Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4187D1965
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjJTW5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjJTW47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:56:59 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE3E10DB;
        Fri, 20 Oct 2023 15:56:52 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KLRJCM022746;
        Fri, 20 Oct 2023 15:56:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=8NdR/tRfockubu2aDa1mpETiKT+lyb/dTaFarl9I/14=;
 b=Z4yPkz3Pzoi3jg6gvN3cCYpArOcdBMPw+yx95qsA2dSl+rQKHZ387rJpMtWhNAre82XJ
 nXeDTE4ditEBSmmt5fnm8wCamyUWrtw+2lxo6dnCBXOxzxtm0JtCUGiuVMR+mLAWGfzU
 xF3/HL6+MVJLgsApHJuV1oit1vXA5OAb/qXhZ6wDeJngpBd01PSNHr+XsqF90j8ruSTl
 YnLIOa6RWFRS0h57RYu5oECfHgvfW4ofM62u2ME0HS1ricPG2POdOxjgjOuxiaCcqvyx
 l+dCX55hhk7FF3PcuRJslUCkQlePNMyZICIsfMDp6BHNtC3/RAuBqVDOsWhJSMgfRuRr JQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3tubw3kvv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 15:56:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1697842601; bh=8NdR/tRfockubu2aDa1mpETiKT+lyb/dTaFarl9I/14=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Dk0Ep/4zzzqOldVEUEi2iy2G4cM8/ZfUNLl/lq13aoG1WG6/9mxzW/kxMzxGIIf8Q
         zasGvE9U9HzE0SUswayyeKIN//ssOAqU1Po/o20NNxON0pbWiAjXrUWlaqxiHQLxuz
         +7OCSKze6SiS9jSFsedMy4Ck+jRxijrA/rSRIvtcgAW7TCH3hhIc1JVY7RuK/Xp6f1
         UeCCctSgFc5OKFvwAPXV1N7IzQKMWVC0SfZKgAhF4HvhqwRAqmxeAsL6Ct7tE/4MLD
         5CO1PZgq/Q7VVCySQdLMhHi4cMfmT5g4qUTNr4IM0UJcppvUDrFp1F0KIpgESuJPUc
         ThGh16yzOj7ug==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9C88D4011F;
        Fri, 20 Oct 2023 22:56:41 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8700CA006D;
        Fri, 20 Oct 2023 22:56:41 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=bpvFMbt1;
        dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 38DED4013A;
        Fri, 20 Oct 2023 22:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gohy93whWD9Sc96aHTQaZfdb/qsJ+0IxpWxW9vYzKIL+nWOGli/3Fa3mqNqJYyTSFGa6wiyFure+UVdIXPnhIE7pW/lKPwRPQdlVGXSnJZJK0PZ9dmV5p1YWKJTRqeu8Kkx6tYvRgLQ1PpRcA8AfiqFjLIx5kUbFW8LQIVTwQWoSP2kDPM11FgVJasrC54ZLcIdjOvtC/jzC3XaMuNntN342zwyqSRQG8iOJJ6BnAmsdpfJ9IvnzlrdUTWEq5/EVnxSMVGM/3n4N6IwhQNRdGvSlkClpX6JqF7uRhbO9z9urPbHz41rJBpuHKaXScWJDjet04vOzI03ha7dNkJE5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NdR/tRfockubu2aDa1mpETiKT+lyb/dTaFarl9I/14=;
 b=X1WEPjPsvOBSVUuV8nma3CFTzIiKppebTv8xLDukNGOiTpe4v1u7MqPMMWTWxuVGvl/EEh22q94PHpqAUqfGy5p9oGN0YqMZUB0jb2IMkoe9WAkcb8UQzGg/Z8BjI0PLsjQjAlR3TkBc4HlzFz1LQMul1sU5jP47VtMv7C0b8WMNrA2HRZFm2zNVz3VvKEZbLGJyJfFdSnly2HuSxjZtUJzNBf6u/1cmR7zNIKtomGQ8POR6c3UN5KeBgvhW2LtUCzmtMmrWNiw93QhetO+VOHaSUMEtlN910qghFg8+mH5310syR8HTG3KjZqcNiCne4IVvsaeawMB1kJ6bh+3Zyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NdR/tRfockubu2aDa1mpETiKT+lyb/dTaFarl9I/14=;
 b=bpvFMbt1uW3UtdReH2bZRYkF0G+2twVfMkvAro3TonnHU51ZZEUfHb12q/HWJ0PUz3UDztKq5EYY7mWN0CDyIzlqkIEQixDSFVNBUoo1ffSFpaZ9K2Xta+cAWiax+9tc2S4OmQ1owVXxcxFWgD1npvWhfwchbGxmD3cyMzCDzF4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY8PR12MB7338.namprd12.prod.outlook.com (2603:10b6:930:52::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 22:56:36 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b63e:67e6:b5fe:a8cb]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b63e:67e6:b5fe:a8cb%3]) with mapi id 15.20.6907.021; Fri, 20 Oct 2023
 22:56:36 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Piyush Mehta <piyush.mehta@amd.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git@amd.com" <git@amd.com>
Subject: Re: [PATCH V2] usb: dwc3: xilinx: add reset-controller support
Thread-Topic: [PATCH V2] usb: dwc3: xilinx: add reset-controller support
Thread-Index: AQHZ/dUS1Q9eNx0OQkeEsSD+6zzyKLBTVaqA
Date:   Fri, 20 Oct 2023 22:56:36 +0000
Message-ID: <20231020225631.4locwbzhvz6rs4uh@synopsys.com>
References: <20231013125847.20334-1-piyush.mehta@amd.com>
In-Reply-To: <20231013125847.20334-1-piyush.mehta@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY8PR12MB7338:EE_
x-ms-office365-filtering-correlation-id: edeef1de-a373-45fa-c2bf-08dbd1bfd04f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uintTznwM3fYUwPrAyrEUYh5UXzsLsiS7Lvr7sUC7JJqI9Bd9bHnKH8fXni7i3GB/n3bZz3RDgiXrr5iT23npFjyD5hFxc8I6s8Z2anLuOAksm8S+RfJMDCp94depgkbqHUhw2XW8rYi4KZi9DAOfMd+P1NzIZax82Yik52TqLI6qDCqQeu851DpW4p3FMuq9ZrNebRfJcyUq03VYkNhGKC9HV5hzqsMkpbm5h4M4adlPzP/+2YBFElk9n6EmZac0G7aOI2Lv1Z1qH8/0FZmzVwrnD+U7BctI4rlv6Zjj4JVKNb/vsJiDpH2kWWswTagxuj9ka/OxiluzaTD9HZ0GaoqZejKfACCij6YNfPOXoVoZkNoIf2fnBlBJnAwXSgGG758t90y7tx3kGKj0lusdr+qekjaT3Y/2PkN+9k1bIbrxAtBkJrol4mOhV1Wr3je20eIKD0Y+HLpOal1QERcDQlNT3L5RELWJyo+Ls1yIRLk9znwOyJK8tVZYH0nGM7VOseY7qW+rSN5nFLo4eehMnxCDMLES0cnGHgTGS3ed5xb/jP2o0375/r0D55tct/yyuTJ4iabcDNQ6NQmhEBklL1tGaeG4mmYP4Tge0xXMmQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(64756008)(66556008)(66446008)(54906003)(66946007)(478600001)(66476007)(76116006)(6512007)(6506007)(86362001)(6486002)(966005)(6916009)(38100700002)(316002)(71200400001)(5660300002)(8676002)(26005)(1076003)(2616005)(4326008)(8936002)(38070700009)(41300700001)(2906002)(83380400001)(36756003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SE9ESmcxbmgxdUl3ZkVGMUhMdG9JVmdPdFNaa25QbGJ1d0xwQVY1ayt3Lzgy?=
 =?utf-8?B?ckg0WVpieFFwczdsbWtyV2dqQThuU2V5NnVKWElLYTFTTktMOFkxdmREN0I3?=
 =?utf-8?B?M3YweHk4UlUxaE1TM0Z6L2dScGJ1MEZ5TFYzSVJPd0ZXaTcxME5LMHhhdWdS?=
 =?utf-8?B?dWw0cGVTY3RFTVIrS2hBWlNkVlZmRVZ4TWdYaTIrcTU0amZzbWhEWDFOQVhJ?=
 =?utf-8?B?VnprSGxjVWVHaGhnNHYzTmJHWm9GV1JPcEFXd1BHV2ZsUXdMcGliMno1QkpJ?=
 =?utf-8?B?YTJBWlo4SFRQWmRNV2ZYdm9lOTNLV1BLa0ZDaXZsTDZyNzVRWkxiMnBkeW95?=
 =?utf-8?B?NnJTVUN6UXVmVkFMWTI0YzhGdGorUENWdE41enpxWTZFdjlZNzNIR3JWTlFT?=
 =?utf-8?B?elpuQ2RLL3NYQ3J1VGdCWEVRemwybkI2MmVoUFQwdE5RZWNubitrM0dmaXpB?=
 =?utf-8?B?RVMyWHZuNHpWT0tIdzdjVmViYXhodHdod0tXSVhxVlQvWGkvQ1diNC9Qci9y?=
 =?utf-8?B?TjRnWjhKZCtVNUV3Q3loWFhlTHdKb1hQMXNTWk51SjdDRmhQNnQxSWtXNHNz?=
 =?utf-8?B?WWtKQUg4eWdkeVdieUw1bFd3ZkFmQVVML3JYcVV3a2Q0dHpEMEFtUmdPUi9U?=
 =?utf-8?B?SjZWUURWU09jdGpCVmRrNzVOaVhXVnJMaC8rYnpHb0ppdmZwVW1rOVYwYlBK?=
 =?utf-8?B?T3FuTTBZVE0xd1JIVXIrZk8zdVNnMlZ3d2tOOHBwUkpISzBPUERkM0lVOEVB?=
 =?utf-8?B?Vy9ldnpRL0JuZVhkR09QRUY4VUFCV1d6K291RzNXbEo2bGMrYUxMZmpvOFEr?=
 =?utf-8?B?UTRVYnZRNy92TEpaajRhL1BYTEx6YjhTTHVPR0tWckdHdHVQN0VCNjdkNjVm?=
 =?utf-8?B?MFBTMVZxTjZhd2JCbXQ5QVFSakxjRVJHMWREZGxmS01iRHRyS2xvemRmRncv?=
 =?utf-8?B?RlpjeWNkZ3IxdS9PZXZCa3QzN1dJblJ3YjN6MjBDL2hJaE5qUkFoZHhPK0Fz?=
 =?utf-8?B?MFp5Rk1QRC9reWZYYnRZS0VwM0xmUHgzQTlvaHVhQXBYajlQT1B5cGQrWUVP?=
 =?utf-8?B?MHQ2eXpIZUw0WnkwTkI2VWZxOFdDejJjL0RWMDlDSzBCQmcxUm9VemZZc3Q4?=
 =?utf-8?B?ZklaMWZrY0t1MGFOZWJZdkYrbzhSMHhFdEIxbjN3Q3p4OFdRUzYwU0x3SzF4?=
 =?utf-8?B?Y3VldjVuWW5yQ0ZncEplenlYK0tXRHB1QUtFdXQ5bHZxajd5a1dxV2doN3l1?=
 =?utf-8?B?eEpvdnEweS9YWlE1dUNSblhWUk5tbmJyQzMrNGdkdkNibnBMeHVoNUpkUXpn?=
 =?utf-8?B?ZGFpMFRPMGlHdTNnc0h2N0NuZUUzeWpaQmhENzY0bjFUTXRjOCt4WGNRNmZD?=
 =?utf-8?B?emtoL09pcHF5TWRIN245cE5HRkJsNFpMdUtEN3FOTEtyZWNob0dwVDJRTmJ5?=
 =?utf-8?B?SitxM3I2OU9mNUhvS283SFRWcFk2N1Q3RnRyZFVMclQ0a0NyWWUvZlpnU3U5?=
 =?utf-8?B?aHRySmNMdlRhNVhidnNtc0J6UW0rN1VLTnJEaUdLZ3VrNkdRWWtvTUIxcjZs?=
 =?utf-8?B?aWVuSWV3M0VrNkIyQ0RseWwvRzhqbllXZUl3eHB5L21ZdVVrUFh4UXQySFRM?=
 =?utf-8?B?QnE5NWNKbVJuNUliSDFYUnF4QzhzaTkvamRqNGdkcjdCeTE5WHVEcHBaaUgy?=
 =?utf-8?B?aVE0eFJPbi91dHA1VFltbU9NcXVLTzRXQjNXNm1Ta0NRdm1HUlZCRlZtUW9V?=
 =?utf-8?B?cEpWTUI2aVhpTklPdWYwVWorQjBCWkZ3OWQvRk1BY29NMWZvbEx4WmMxeW1w?=
 =?utf-8?B?RjB4OWVOK2RwNHRjMHNlRC9FamxmdGxRSzlpQzdHNHc3YkUwaE13bWVCR2t5?=
 =?utf-8?B?azNFWVdmckJyUW03NXBuUXJVTFcyNzRqcEJyL3FuMzJEV2k5SWdINytGMmpu?=
 =?utf-8?B?eTk1YUxkb2hKRElDdGZzOXZnVUNTVzRueUFaN0Q1aWluZmZtNkhZUytjQ0ZV?=
 =?utf-8?B?U0R5MnA5YldBdEtSbHFOcWtYL3Vmdk1PbGlPTkNWRmRMZ0lJZjNQT21Fekt6?=
 =?utf-8?B?SVFsSDhLYUFjQW93NzNwZThqbUduVzZCajkvcEpGZzEyU0h0bXZqY3VHU2gv?=
 =?utf-8?B?Y1JDczVXd2tHSGRVdHd3cmNmU3dDcVlaV3hFRWlMYVdrcjdtamRuSjM3UzE5?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9E4F1BA2812354B92D52B8CFD877C40@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ru56ukwHkMtUebDRB0kel3z2eF2oVOMnUaZDXX4LEZn1xdWccH4WIlP1+ebwVrbJtqrJ5KtIMwAGUxzDVvATxEkdgPpxo+eFKwW1UgWP4ffWQqRijbsqZZSrVRw1mGA3JEGRr/k2isJrPzwD6TkFUuquGcML/A9lcNWPASlR/mLotvjlPp35dzrvg490qGMlG34kPO/IXQRh+ovFLe8eM/cmXF57sPHApE3avh22XFMDm97b4M0wsRpyh01qTt599sv5XWGgcc8gi7VKMrG/nsEMJDioS1bQV2p3MyXKG7YgZ9NtD6WbNQmEvbpo42nOus8kyDl4KnhuRsrTp5pPB+MZD3yS7SpopRIeQBq5xJmEu7QBqfs1yBpZmn9AvwJBmGz3jDd+QWRQmsF9/Jy9S8w//Btzovm18fCbskhMBmEh1Ip5+WNPLdY5P1tgYKpQDS7YqVQXLMaCmWx51mM0oQn/T1aSTBdtpm6WiW4c/Q91+OrV0jZQ3r2VQ/o3iBITsp4WNAxVRwnFEGdD0zgziPW1FQs44qbaL/HgeWTzYhvaxGdMUjkN9wo6Uq29OGuOXenvfjC4ie6sQ+0Dpx0KUHh2hOtM/QHD8cT9JqjkDWWrsIAD4CE42dtxLPljtb65SdMFmsmMR1XoMWSZTVF9itbQLEjSM8+6pMw14KNA0PnSrn1zTZh+zU/8rOGmr6VxSg2XIupw9HntdBVMYN3FbMTSt4uOEdOU86R+fniquIIkyUimXMg8silGUVzLoFF2ZlPQ9hjpPbE7K+YjlLyPLIDVFtehu1RVNguq3sWta3FRuxYip6N5gLsKt7cMli4J16UQ1rbqxgeh2KW8Fl8RKt8mNsu2PhUbw8DNwwRSK+2DkB9wFbYnY8sXJx0mK8LfJGiFZ3Qw+oRv8VJnTgHLoGlkuvwy8vyB8OLzdTTPkY0=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edeef1de-a373-45fa-c2bf-08dbd1bfd04f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 22:56:36.6693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GeMWN2uV/GNEACKfMs6ibwaE51mBMipamdOrV2qz9u1TWB3u6LldjlEFMqdoapsSsMhqgFvftOyi4ypRafQ7zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7338
X-Proofpoint-GUID: zHr9kDC1yd4PKlCkvfy0Av1x8ZTAUrd7
X-Proofpoint-ORIG-GUID: zHr9kDC1yd4PKlCkvfy0Av1x8ZTAUrd7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310200195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBPY3QgMTMsIDIwMjMsIFBpeXVzaCBNZWh0YSB3cm90ZToNCj4gQWRkIGEgcmVzZXQt
Y29udHJvbGxlciBmb3Igc3VwcG9ydGluZyBYaWxpbnggdmVyc2FsIHBsYXRmb3Jtcy4gVG8gcmVz
ZXQNCj4gdGhlIFVTQiBjb250cm9sbGVyLCBnZXQgdGhlIHJlc2V0IElEIGZyb20gZGV2aWNlLXRy
ZWUgYW5kIHVzaW5nIElEIHRyaWdnZXINCj4gdGhlIHJlc2V0LCB3aXRoIHRoZSBhc3NlcnQgYW5k
IGRlYXNzZXJ0IHJlc2V0IGNvbnRyb2xsZXIgQVBJcyBmb3IgVVNCDQo+IGNvbnRyb2xsZXIgaW5p
dGlhbGl6YXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaXl1c2ggTWVodGEgPHBpeXVzaC5t
ZWh0YUBhbWQuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiBWMjoNCj4gLSBSZW1vdmVkIHVubmVj
ZXNzYXJ5IGRlbGF5IGJldHdlZW4gYXNzZXJ0IGFuZCBkZWFzc2VydC4NCj4gLSBVcGRhdGVkIGNv
bW1pdCBtZXNzYWdlLg0KPiANCj4gTGluazogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMTAwNTE0MjIxNS4xNTMwLTEtcGl5dXNoLm1l
aHRhQGFtZC5jb20vX187ISFBNEYyUjlHX3BnIWJmYi1ScURoakEwcUlRTkpBZ3pOOWdFSndScmVR
dHJTeXl0ZEN0LXlzbGp1eXl2b01uTEIzb25yN2gycUxpM1IwR1FmbjBTdUFvV19JMTVpUVNzUmp2
alYkIA0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYyB8IDE0ICsrKysr
KystLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYyBi
L2RyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYw0KPiBpbmRleCAxOTMwN2QyNGYzYTAuLjVi
N2U5MmY0NzZkZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLXhpbGlueC5j
DQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYw0KPiBAQCAtMzIsOSArMzIs
NiBAQA0KPiAgI2RlZmluZSBYTE5YX1VTQl9UUkFGRklDX1JPVVRFX0NPTkZJRwkJMHgwMDVDDQo+
ICAjZGVmaW5lIFhMTlhfVVNCX1RSQUZGSUNfUk9VVEVfRlBECQkweDENCj4gIA0KPiAtLyogVmVy
c2FsIFVTQiBSZXNldCBJRCAqLw0KPiAtI2RlZmluZSBWRVJTQUxfVVNCX1JFU0VUX0lECQkJMHhD
MTA0MDM2DQo+IC0NCj4gICNkZWZpbmUgWExOWF9VU0JfRlBEX1BJUEVfQ0xLCQkJMHg3Yw0KPiAg
I2RlZmluZSBQSVBFX0NMS19ERVNFTEVDVAkJCTENCj4gICNkZWZpbmUgUElQRV9DTEtfU0VMRUNU
CQkJCTANCj4gQEAgLTcyLDIwICs2OSwyMyBAQCBzdGF0aWMgdm9pZCBkd2MzX3hsbnhfbWFza19w
aHlfcnN0KHN0cnVjdCBkd2MzX3hsbnggKnByaXZfZGF0YSwgYm9vbCBtYXNrKQ0KPiAgc3RhdGlj
IGludCBkd2MzX3hsbnhfaW5pdF92ZXJzYWwoc3RydWN0IGR3YzNfeGxueCAqcHJpdl9kYXRhKQ0K
PiAgew0KPiAgCXN0cnVjdCBkZXZpY2UJCSpkZXYgPSBwcml2X2RhdGEtPmRldjsNCj4gKwlzdHJ1
Y3QgcmVzZXRfY29udHJvbAkqY3JzdDsNCj4gIAlpbnQJCQlyZXQ7DQo+ICANCj4gKwljcnN0ID0g
ZGV2bV9yZXNldF9jb250cm9sX2dldF9leGNsdXNpdmUoZGV2LCBOVUxMKTsNCj4gKwlpZiAoSVNf
RVJSKGNyc3QpKQ0KPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIoY3JzdCks
ICJmYWlsZWQgdG8gZ2V0IHJlc2V0IHNpZ25hbFxuIik7DQo+ICsNCj4gIAlkd2MzX3hsbnhfbWFz
a19waHlfcnN0KHByaXZfZGF0YSwgZmFsc2UpOw0KPiAgDQo+ICAJLyogQXNzZXJ0IGFuZCBEZS1h
c3NlcnQgcmVzZXQgKi8NCj4gLQlyZXQgPSB6eW5xbXBfcG1fcmVzZXRfYXNzZXJ0KFZFUlNBTF9V
U0JfUkVTRVRfSUQsDQo+IC0JCQkJICAgICBQTV9SRVNFVF9BQ1RJT05fQVNTRVJUKTsNCj4gKwly
ZXQgPSByZXNldF9jb250cm9sX2Fzc2VydChjcnN0KTsNCj4gIAlpZiAocmV0IDwgMCkgew0KPiAg
CQlkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVkIHRvIGFzc2VydCBSZXNldFxuIik7DQo+
ICAJCXJldHVybiByZXQ7DQo+ICAJfQ0KPiAgDQo+IC0JcmV0ID0genlucW1wX3BtX3Jlc2V0X2Fz
c2VydChWRVJTQUxfVVNCX1JFU0VUX0lELA0KPiAtCQkJCSAgICAgUE1fUkVTRVRfQUNUSU9OX1JF
TEVBU0UpOw0KPiArCXJldCA9IHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoY3JzdCk7DQo+ICAJaWYg
KHJldCA8IDApIHsNCj4gIAkJZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgImZhaWxlZCB0byBEZS1h
c3NlcnQgUmVzZXRcbiIpOw0KPiAgCQlyZXR1cm4gcmV0Ow0KPiAtLSANCj4gMi4xNy4xDQo+IA0K
DQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpU
aGFua3MsDQpUaGluaA==
