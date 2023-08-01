Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BB076A65C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjHABbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHABbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:31:31 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771441725;
        Mon, 31 Jul 2023 18:31:28 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VJpnFG028448;
        Mon, 31 Jul 2023 18:30:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=uCIQGCEXbnsZSy2/1MK/4NF7l4ha4cjfcVMSK7XYR/Y=;
 b=pAHCWKCplyh/ZICk/fBIeRAiRakbJquqcLma7uyD5Ajr1M6FTi1ttVn1CON/aDZ8zxDI
 TXzoeZra0CDv6XbU3P/AMEWYhHvvhJe9qM8fY7Cd6inMNMPAGGeN27LFVtMMXPlqkLbX
 6tL01friirVoV03FopRgERR79kFLJrboXUSlNpnp7AEPIzfu++J+aNnMPba3eIeIjavK
 9l7cuMFq0g35Yt7oNax1ER7Z2uhHA/k7PNJeng4zUYcw38XkgWft9vsTgkUcC2uvCJI2
 /nxhsGgq+DBkoulnKpQUvL8+nKcYW6an1I0FXrrEfcJQc38iJ+LgvgCjXfOVGQxhAMHt ww== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3s51dct3yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 18:30:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1690853444; bh=uCIQGCEXbnsZSy2/1MK/4NF7l4ha4cjfcVMSK7XYR/Y=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=MCHSeAxX6B5Or6lHEc3YL3eVwmO9fU1F0+pUYw3hF2iJXv52SZbrCfTB7/9aENlEO
         +Fnwm/Io+Olq2FYy91gVEKgw+o7WgK6+9oz5lxOweKT2WmDhGFW/bv9zymUPcwx6pg
         MGennmjcx+F8GHaYMJRPv4V0TyUfZ0yvzBGFFH2032z5uZJcfYWv/p88EtjdayzmYM
         YCWY05pZuFaM+g0aAVQ9qY8LBhujMmRoOa1rV3cfQkQYl9DjtdgyxLt30NARZv8PRd
         tlBMylOmvkGZ+8SifCozgAQ0ssH+iG8T5w+PFdSx0EP2bfdDR4uIP+FI/yEzBN0nbp
         3vXfv9E6nr1/g==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B9AB540145;
        Tue,  1 Aug 2023 01:30:43 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 47AFEA009B;
        Tue,  1 Aug 2023 01:30:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=pf2lxSpb;
        dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 97D9D40596;
        Tue,  1 Aug 2023 01:30:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILOP4T1nc5CZjjR48PvlqVj4MWpOPVKyK2Z04jZF6YNNEHNGU6UQQEK/qW4HfIGYfICDxNcwKMOuuN51faiKPqiNpCmqTXq+DDVFlKB19BIRFK6+7J0Go7/9n4XGMf36OrkpgdOOtT9lhhTa+gp4QZFbRy0KEusSbCEbHh2Gh4r5WPRwSRPQDM6A21WNnqIklOqgivFPjnZHJywtRe0GeLjSdV66CHB32/Fq0b5o6aKJ5fvDPRcCo0G42fUwG4Fkb8AA/hOMbjd7wnD543jWihXW7bszCbeTOx7vhEtgBPstJ0J56Utz6InRiY+Cw6wCmC2JmiOwjb4Wxi5AYyS5iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCIQGCEXbnsZSy2/1MK/4NF7l4ha4cjfcVMSK7XYR/Y=;
 b=mmCIfeI4MZ1jGJlPqQUxgYhbb0msF9XE3upR8Xu9KIcjeB18yLUrBIvLmZJnHHxWN9V/M5NXBNpAvgN3fqvEssUm6WLBTLiodH6GOgwvbY9QmUihUhoPX6Zdwg6qEmm9TAf2/MhdtgxGxkMLAICUm0CQgBeB61qZBAa4MCOlaM4vKxxvvnAX6nnBtYh2GHk25aWI6N7Pg+ag4qb2jeUp7HSBSajkvdwQzJjJNyJDIoVrnc98bfuOcqMmx5ha3pJpoH8WXOyhcCe0QSTv3h+PCyofvWfpZv/baE+wvpYgaYubCBfawPi3CzpVYvI64utt3M1lqxxlkHTFOQyBt/9pSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCIQGCEXbnsZSy2/1MK/4NF7l4ha4cjfcVMSK7XYR/Y=;
 b=pf2lxSpbVSx5T92EMcgd4aLu10Srv4sM55eV0RJpdcQxOkRwp9K1K719DEZXAFtwaLnQcNrsgbvjJleWJ3U4XEIubh+JNKVTSLWETFod97B/yJN29NZF2RifkEDsOhZFlj6GwSfurSrEBEkXG8rTKqD5qgbXk/3vHAFIp6F9GqI=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH7PR12MB7939.namprd12.prod.outlook.com (2603:10b6:510:278::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 01:30:37 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::138d:ed63:a424:1f33]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::138d:ed63:a424:1f33%5]) with mapi id 15.20.6631.042; Tue, 1 Aug 2023
 01:30:36 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v9 05/10] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Topic: [PATCH v9 05/10] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Index: AQHZo/oZ8maca+f9u0KOSdCs01wKEa+emICAgAhNWQCAHSPwgIAQ3ceA
Date:   Tue, 1 Aug 2023 01:30:36 +0000
Message-ID: <20230801013031.ft3zpoatiyfegmh6@synopsys.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-6-quic_kriskura@quicinc.com>
 <ZJrRe7HtMs0KbsCy@hovoldconsulting.com>
 <e3e0c4c8-1e91-caf1-c1c4-86203a7ecba0@quicinc.com>
 <ZLo6MwbuKNL5xtPE@hovoldconsulting.com>
In-Reply-To: <ZLo6MwbuKNL5xtPE@hovoldconsulting.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH7PR12MB7939:EE_
x-ms-office365-filtering-correlation-id: 88421cf8-2758-43c0-bc02-08db922ee863
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0+rouLnaX/QE+IuX1ix1Jq+j1KDLrQ1ueRG0AeX81XaXan0uKvM8gx5tI4p48vwsCb0qCvUqGMv6m0uWItyc4SYyYZ0MhrhXTYiE1ys+t0ViNRSbkwDGJWLu8uEEEuUr7Ni6c0lyj9y2f67/0ZSmIbzBp0OEoFnXxCytgQ4laZFOUZg1DKEp0/WWM9Jog0/4eGTSd4gfXY+UV+2pW0kBeykQrWJl6haFKNHm2FUJEd8ByBp/7TefB2raCmEZdzcUP4mySHJqXCYMRIsu7S591tULNcw5Uk7u8CyPGo11R54Jf+jYnY53G3pEiLVHcwvIGk91Ua8cxKl80rBT4xKB6BgIwCsD/+w/hC4zxnTvSMKHTvdayaFQ0QEzbIK7WJB5ZnXZTwLJU+kD4McJ5AG73tBVatQaYrS/+y1wV+oZYblKwJ/R5bu1LZTW9UUBWVqXHRPuf0WBZJ/H1ZpVCv1YENkgCkL+/GRnBRMXfaeNTBQjVSIxQCiogkV1aytgMYc6zpBBEtodSNa4zAZerHqLmiZiWgxQ8DnA9A4IMfI7BPTulN9O2S9lEMr4Srn01JCEIK0zzXYrJj5LNJ4allfPriegeDaVERI4LkEPvOd7IWZgW7c8SKn2PAgdF78aCrFF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(38100700002)(122000001)(86362001)(38070700005)(36756003)(6512007)(478600001)(71200400001)(6486002)(2616005)(186003)(53546011)(26005)(1076003)(8676002)(8936002)(6506007)(7416002)(5660300002)(66556008)(66946007)(76116006)(66476007)(6916009)(64756008)(66446008)(54906003)(4326008)(41300700001)(316002)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXZtQnVyQWJLRDVaWURrNzBhUWM0aEZqcG1lSmMzTGx6elFNQUVKRFZoY2ha?=
 =?utf-8?B?TDNJdHFOTXc0YzFOM3NoamMwL3lBL0lUallXdUlVRGtxOVRXa0F6Y0VZcVIx?=
 =?utf-8?B?ekpCU1RZbmZMY0JudVM0bWkxNUd3NlhreFc5NHpyZGNHamtnTXNTSFZaUi83?=
 =?utf-8?B?Zkoza2JMKys4QzFDd25HYXdMcXZobjVHQS9aL0NKRFRUZklRbzcxcXNYSU51?=
 =?utf-8?B?TG5vQ1pJckVRbWJpamZYOVRoN25KMFJTb0sxbDA1cWFpejNxSkF2aVpTRFc1?=
 =?utf-8?B?KzUrK05LM2Rya25uczFoUmMranNnU3JSZGVIak9FcFJYYXBWcXpxTU41SkdS?=
 =?utf-8?B?cFkwUzIzbXhacUpuZ0RvM1p2aCtRNisvOUJaMzFlSEJ2ZlVXQ0s2aTQ2ZnVZ?=
 =?utf-8?B?ZWt6UEhnZVJvVGYyK3JKamdrWEFJRmtMSmEza05GTjArNHdtc00zRWNwUTUr?=
 =?utf-8?B?ZXN3MVRNT2Y1SGdtNFMvMDE4ZUIzQjJ2NlJHOFl3TTlRSm9zczQ4RXBtZlBw?=
 =?utf-8?B?ajRFZVNLZllXYkdYUHBnMzIyVjdDZk8rMFZTU1VMdE41SjVaSW9XWkY2WFVH?=
 =?utf-8?B?dzZDaEFrWkNOZUJGUFBZTk1MSkxlK2x6NWErZ1puYVE0czIzUmppR1RsMTFJ?=
 =?utf-8?B?RnF0OUpUWCtJc1lTdnAvZ0FaR01JZzFsQ1o3VXg1aXBIS24xMkMzMGNYd09Z?=
 =?utf-8?B?MVAremNVUDFmT3A0Z1BIUy8wY2YzY3pxdjlVYXhaa3hYcVN0SDZOUWQ4UnNo?=
 =?utf-8?B?d2NDVVVvYXZLNnpuMmFlMm5DenBKK01GTm5GcmcvQTlXbmYzNEorTGl0cXFQ?=
 =?utf-8?B?Q3RWbkE3ZzlxQ2FETFNtR2diWUxRUzRBZllKcDRMcXJwdHhXZGdPcFlnN2Z3?=
 =?utf-8?B?VEdXakxwUkQwbmtzbVBTQ1VDWjcxdDRCVWVFa2tRUDlFOXR1dmFEMmhPVE8w?=
 =?utf-8?B?OEhUQUNTYzluOHBJZUo4RGlUQ0RkTDZ4eVRVdUFabGFwM1ZTRkhySFNtQzI0?=
 =?utf-8?B?TlNwbE14eGdMS2lzaFc4aHB1cDNMYzREaDBJTnVQM3JXTkZPN3F5TnRrNVJz?=
 =?utf-8?B?WmZ3K0tOTHM0MFk1RUtZYXpVMXVFSmdUZkdNb1NwTkhPZ25hOTVjeFIrM05O?=
 =?utf-8?B?bll5OUVvd2lIUW1IazI4YnV5RXMxWm1idWpmMzZ4U2VxSUxiZGN0SytXeTZv?=
 =?utf-8?B?cWtyZStBN0RIUC9FUXo2ZzlaLzkzT0RsbFZWTlpHMlE3c2JXbUQ5WW93YStE?=
 =?utf-8?B?QjZBZkxHRnR4dE1LbFA1OHcrTEoxWG9xTlpwVjRXOXhyM2RnUWxmMkxWOGoy?=
 =?utf-8?B?QzgvQnBPUEUwRXFwdjkxZGR1QlhzZlIxQXhwWWNVVGpNdVdXMmh1Y0ZwNVJP?=
 =?utf-8?B?VmZRSjhINFJvajVCblV5eW9BSmdMeitVblAyQVBoYWxTSy9yMDZUYmppcUEv?=
 =?utf-8?B?WXdqa1NqQmNVSEhNelNHUTUvVEcxSHJRMkVuSEFtV0ExaFRFZUJhYy9wdjgw?=
 =?utf-8?B?TXRvRS9CMUpWQmdqK3krQ0luUVpWK1MxMysvKzNLY2owK2V6VW1kbUpTTHV5?=
 =?utf-8?B?L05oL0IvbVg3elo0YU02UzFLaWRUVGU5ME1MVEt4STczUTlWWXJOc0hIUEVk?=
 =?utf-8?B?Y04xR1pRY3VZUXhlU05ZSHJqUTY4bENrQXpGUUorYUJUdFVON2c5ODBsTVZa?=
 =?utf-8?B?K1VTbEs2K0NUQnhBa080NnZSQWJudThHUXQ3clNhVDZsK2x5elI1aXlnRHFs?=
 =?utf-8?B?ckppa1BPOVE2WmRUcUJWbmdtTzFkcDEyYnE4WVhJSzVmeGlTVlJlWFhQUmNY?=
 =?utf-8?B?NmprNWsxMjZWTC9SSHBTR05KKy9BOVg3RDc2a2IzUFE5QWtFZDhJR1lSUVpa?=
 =?utf-8?B?WEZyNWVMc21nblNJZEw4TkNXdXMzRnZIKzN2eEZVaktPeWw5andLejBFd24r?=
 =?utf-8?B?eUl3TzBGOVYzeThtejdxRDhSZko4QWVwZHYwemVOWFBHSXFBS0Q3enZMaUdC?=
 =?utf-8?B?V3c4ZnQxSno2S2hRR25SS25jTXpHN0czbEgyUzAzQ3FNM0xwVUJtRk9mRDNh?=
 =?utf-8?B?bmZMK3BGVUVlb3FGVmE5WmZ2R00rdkdkVzNYK0U0dDdXVUV4akh0VVplVXRZ?=
 =?utf-8?B?UGd6MEJvRXBkU0hzMHFjd29mM0lDemtlMnArTkRrQVY5ck5WeVNuNHZVb0pO?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8752D2CAF6019D4AAED41F0857844320@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MWlKKzFzbFRhRm5yUkdxRVAvSXh4QUFsN3Vhbi9SYUpTUmlEaVlBUDZSOURn?=
 =?utf-8?B?WitwWFU3MlZhbXFSTWsycHJQNU0yQ3RWdDduazF0UVU5M2tiL3l6ZG5YRXRl?=
 =?utf-8?B?MjF3bUZkcWQ3UDJtU3JoaUp4bDUzTkkyeXZuT3RUVytHRmhydWxrbDAxTHZF?=
 =?utf-8?B?YW1LVEVCV1hSTjlWMEJjUklvS1ZEYTBTQUFlWGU4RjY5SGpnblJVSnpyRlIr?=
 =?utf-8?B?UUJuNnJVYWY5dkJqUnV5SHhPTXJoaEF1aHl4aXZ5aThFejBRY1ZwaENZbGxx?=
 =?utf-8?B?YXFsbkk5YnF4UHBoUjloNkJ4VXJaSHQxZ0RKVEJvQXVFYkFpdUtaUTFkZ3lQ?=
 =?utf-8?B?UzUyRkRiSHMyUkcxU1dkMTBmVVF4WjRvdm9rQ2F1a2g0V1RjVEg3UWJWN0dz?=
 =?utf-8?B?NzJFZXZaeExpdjJtYmU5WENwcThlTDJHdzE5bDQxcjBjTU9iRTM2RlJnczMr?=
 =?utf-8?B?VHluYW1kOHNtdU9oR05ubWE3NytCQ2xMdG9iT0g2bWRQdGl1K2Q5WUpBZzhK?=
 =?utf-8?B?WXBVK09ZbGg3TUFJcXc4RTdsUEVKQlIyZ1JVRHR0T1pCM0IrUENKRVlxTE5Q?=
 =?utf-8?B?S05idjc5YXRWNEp6SitONE4vd0tXcGo0ckk1N1pnTXRRUFBIS2llZjNoY1hC?=
 =?utf-8?B?cVBlTWNnS3J5eW5EVllnem5JVnM2OGtzbVpyVFp5Uk11R1diS05hLzl3a2py?=
 =?utf-8?B?eEFBK3FwK2w2K0N4OVhUTTFSTXFQY3A3QlR1UWM1VkUrdm9qd1RpTThFTkVx?=
 =?utf-8?B?VmZzdzZXZWNydTdxYjN4S3JKYkZSLzFzYys5MjRLWFhycEEvM0x0QmJjcU4x?=
 =?utf-8?B?Yjg0d1FxaHRxSXJSdkRScjBLa2krSmYrblAwdkwyMFhZRDlrSXNpMkVSdVhk?=
 =?utf-8?B?bldSbXVuSTJkaFFra0RsR1lqM2Jsd3RqZnlyRWk5U25IUnNiK3BZcXRLY1oz?=
 =?utf-8?B?dERzaGlZY0ZKOEVnWmFkc1FXbmdtbkFWeUc0NC9IcVpORnJJMWdRd3FJVHJZ?=
 =?utf-8?B?SC8rbW9sVlhzUlNjNm8xQnVnSUUzWXlGSnVzVlQrTlorcTI0Q0R4Lzd6d21Z?=
 =?utf-8?B?VEZ0Si9BT2JWYnVPQjVqakJ2ZDRWVDVvZ0x2d0xYVG9UM2dncGZHS0dZUXRz?=
 =?utf-8?B?a1NkdGIxeG5IYnhtVEhRR0VnUXpydGhiVlI1NllHcGlJb3dpazVzTmdNOHVt?=
 =?utf-8?B?UjNLUkx2WVlGbkRmdE9JM2plNmRxZUgvYlVSb1llRjVDTy9LT0lXeVpOdU1B?=
 =?utf-8?B?bVduUE15SlkwTzZpb2VGZGpHcHRmbkV6SDA5UWd3di9pSkVFUzdvK2tCaFgz?=
 =?utf-8?B?TWorTXFEZU1kZkgyckZ2T083OE5CMFpoN3c3UXN0S0g1WnhPWjFzSWN0NDRx?=
 =?utf-8?B?NW1JRUxJQnU5SkE9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88421cf8-2758-43c0-bc02-08db922ee863
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 01:30:36.7535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6AENbaPuDMFtNEkArn0uPzQ+FZ/gZMfE4YMvPg2gFyAzAeZJC2vWn1EiRnQg9M5coipCTl7Cg4FSIocSYpWCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7939
X-Proofpoint-GUID: urIMiChXmIuKE45CYnDojJfA7rGVuepC
X-Proofpoint-ORIG-GUID: urIMiChXmIuKE45CYnDojJfA7rGVuepC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_18,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308010012
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKdWwgMjEsIDIwMjMsIEpvaGFuIEhvdm9sZCB3cm90ZToNCj4gT24gTW9uLCBKdWwg
MDMsIDIwMjMgYXQgMTI6MjY6MjZBTSArMDUzMCwgS3Jpc2huYSBLdXJhcGF0aSBQU1NOViB3cm90
ZToNCj4gPiBPbiA2LzI3LzIwMjMgNTozOSBQTSwgSm9oYW4gSG92b2xkIHdyb3RlOg0KPiA+ID4g
T24gV2VkLCBKdW4gMjEsIDIwMjMgYXQgMTA6MDY6MjNBTSArMDUzMCwgS3Jpc2huYSBLdXJhcGF0
aSB3cm90ZToNCj4gPiA+PiBDdXJyZW50bHkgdGhlIERXQzMgZHJpdmVyIHN1cHBvcnRzIG9ubHkg
c2luZ2xlIHBvcnQgY29udHJvbGxlcg0KPiA+ID4+IHdoaWNoIHJlcXVpcmVzIGF0IG1vc3Qgb25l
IEhTIGFuZCBvbmUgU1MgUEhZLg0KPiA+ID4+DQo+ID4gPj4gQnV0IHRoZSBEV0MzIFVTQiBjb250
cm9sbGVyIGNhbiBiZSBjb25uZWN0ZWQgdG8gbXVsdGlwbGUgcG9ydHMgYW5kDQo+ID4gPj4gZWFj
aCBwb3J0IGNhbiBoYXZlIHRoZWlyIG93biBQSFlzLiBFYWNoIHBvcnQgb2YgdGhlIG11bHRpcG9y
dA0KPiA+ID4+IGNvbnRyb2xsZXIgY2FuIGVpdGhlciBiZSBIUytTUyBjYXBhYmxlIG9yIEhTIG9u
bHkgY2FwYWJsZQ0KPiA+ID4+IFByb3BlciBxdWFudGlmaWNhdGlvbiBvZiB0aGVtIGlzIHJlcXVp
cmVkIHRvIG1vZGlmeSBHVVNCMlBIWUNGRw0KPiA+ID4+IGFuZCBHVVNCM1BJUEVDVEwgcmVnaXN0
ZXJzIGFwcHJvcHJpYXRlbHkuDQo+ID4gPj4NCj4gPiA+PiBBZGQgc3VwcG9ydCBmb3IgZGV0ZWN0
aW5nLCBvYnRhaW5pbmcgYW5kIGNvbmZpZ3VyaW5nIHBoeSdzIHN1cHBvcnRlZA0KPiA+ID4+IGJ5
IGEgbXVsdGlwb3J0IGNvbnRyb2xsZXIgYW5kIGxpbWl0IHRoZSBtYXggbnVtYmVyIG9mIHBvcnRz
DQo+ID4gPj4gc3VwcG9ydGVkIHRvIDQuDQo+ID4gPj4NCj4gPiA+PiBTaWduZWQtb2ZmLWJ5OiBI
YXJzaCBBZ2Fyd2FsIDxxdWljX2hhcnNocUBxdWljaW5jLmNvbT4NCj4gPiA+PiBbS3Jpc2huYTog
TW9kaWZlZCBsb2dpYyBmb3IgZ2VuZXJpYyBwaHkgYW5kIHJlYmFzZWQgdGhlIHBhdGNoXQ0KPiA+
ID4+IFNpZ25lZC1vZmYtYnk6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVpY2lu
Yy5jb20+DQo+ID4gPiANCj4gPiA+IEFzIEkgYWxyZWFkeSBzYWlkOg0KPiA+ID4gDQo+ID4gPiAJ
SWYgSGFyc2ggaXMgdGhlIHByaW1hcnkgYXV0aG9yIHlvdSBuZWVkIHRvIGFkZCBhIEZyb206IGxp
bmUgYXQNCj4gPiA+IAl0aGUgYmVnaW5uaW5nIG9mIHRoZSBwYXRjaC4NCj4gPiA+IA0KPiA+ID4g
CUVpdGhlciB3YXksIHlvdSBuZWVkIGhpcyBTb0IgYXMgd2VsbCBhcyB5b3VyIENvLWRldmVsb3Bl
ZC1ieSB0YWcuDQo+ID4gPiANCj4gPiA+IAlBbGwgdGhpcyBpcyBkb2N1bWVudGVkIHVuZGVyIERv
Y3VtZW50YXRpb24vcHJvY2Vzcy8gc29tZXdoZXJlLg0KPiA+ID4gDQo+ID4gPiBUaGUgYWJvdmUg
aXMgbWlzc2luZyBhIEZyb20gbGluZSBhbmQgdHdvIENvLWRldmVsb3BlZC1ieSB0YWdzIGF0IGxl
YXN0Lg0KPiANCj4gPiAgIEkgdHJpZWQgdG8gZm9sbG93IHRoZSBmb2xsb3dpbmcgY29tbWl0Og0K
PiA+IA0KPiA+IDgwMzBjYjlhNTU2OCAoInNvYzogcWNvbTogYW9zczogcmVtb3ZlIHNwdXJpb3Vz
IElSUUZfT05FU0hPVCBmbGFncyIpDQo+ID4gDQo+ID4gTGV0IG1lIGtub3cgaWYgdGhhdCBpcyBu
b3QgYWNjZXB0YWJsZS4NCj4gDQo+IEkgZG9uJ3Qgc2VlIGhvdyB0aGF0IGNvbW1pdCByZWxldmFu
dCB0byB0aGUgZGlzY3Vzc2lvbiBhdCBoYW5kLg0KPiANCj4gUGxlYXNlIGp1c3QgZml4IHlvdXIg
dXNlIG9mIFNpZ25lZC1vZmYtYnkgYW5kIENvLWRldmVsb3BlZC1ieSB0YWdzIHRoYXQNCj4gSSd2
ZSBub3cgcG9pbnRlZCBvdXQgcmVwZWF0ZWRseS4NCj4gDQo+IElmIHlvdSBjYW4ndCBmaWd1cmUg
aXQgb3V0IGJ5IHlvdXJzZWxmIGFmdGVyIHRoZSBmZWVkYmFjayBJJ3ZlIGFscmVhZHkNCj4gZ2l2
ZW4geW91IG5lZWQgdG8gYXNrIHNvbWVvbmUgaW5zaWRlIFF1YWxjb21tLiBZb3Ugd29yayBmb3Ig
YSBodWdlDQo+IGNvbXBhbnkgdGhhdCBzaG91bGQgcHJvdmlkZSByZXNvdXJjZXMgZm9yIHRyYWlu
aW5nIGl0J3MgZGV2ZWxvcGVycyBpbg0KPiBiYXNpYyBwcm9jZXNzIGlzc3VlcyBsaWtlIHRoaXMu
DQo+IA0KPiA+ID4+IEBAIC0xMjAsMTAgKzEyMCwxMSBAQCB2b2lkIGR3YzNfc2V0X3BydGNhcChz
dHJ1Y3QgZHdjMyAqZHdjLCB1MzIgbW9kZSkNCj4gPiA+PiAgIHN0YXRpYyB2b2lkIF9fZHdjM19z
ZXRfbW9kZShzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+ID4gPj4gICB7DQo+ID4gPj4gICAJ
c3RydWN0IGR3YzMgKmR3YyA9IHdvcmtfdG9fZHdjKHdvcmspOw0KPiA+ID4+ICsJdTMyIGRlc2ly
ZWRfZHJfcm9sZTsNCj4gPiA+PiAgIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+ID4+ICAgCWlu
dCByZXQ7DQo+ID4gPj4gICAJdTMyIHJlZzsNCj4gPiA+PiAtCXUzMiBkZXNpcmVkX2RyX3JvbGU7
DQo+ID4gPiANCj4gPiA+IFRoaXMgaXMgYW4gdW5yZWxhdGVkIGNoYW5nZS4gSnVzdCBhZGQgaW50
IGkgYXQgdGhlIGVuZC4NCj4gPiA+IA0KPiA+IEkgd2FzIHRyeWluZyB0byBrZWVwIHRoZSByZXZl
cnNlIHhtYXMgb3JkZXIgb2YgdmFyaWFibGVzLg0KPiANCj4gVGhhdCdzIGdlbmVyYWxseSBnb29k
LCBidXQgeW91IHNob3VsZCBub3QgY2hhbmdlIHVucmVsYXRlZCBjb2RlIGFzIHBhcnQNCj4gb2Yg
dGhpcyBwYXRjaC4gSXQncyBmaW5lIHRvIGxlYXZlIHRoaXMgYXMgaXMgZm9yIG5vdy4NCj4gDQo+
ID4gPj4gKwlpbnQgaTsNCj4gPiA+PiAgIA0KPiA+ID4+ICAgCW11dGV4X2xvY2soJmR3Yy0+bXV0
ZXgpOw0KPiA+ID4+ICAgCXNwaW5fbG9ja19pcnFzYXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4g
PiA+IA0KPiA+ID4+IEBAIC03NDYsMjMgKzc3OSwzNCBAQCBzdGF0aWMgaW50IGR3YzNfcGh5X3Nl
dHVwKHN0cnVjdCBkd2MzICpkd2MpDQo+ID4gPj4gICBzdGF0aWMgaW50IGR3YzNfcGh5X2luaXQo
c3RydWN0IGR3YzMgKmR3YykNCj4gPiA+PiAgIHsNCj4gPiA+PiAgIAlpbnQgcmV0Ow0KPiA+ID4+
ICsJaW50IGk7DQo+ID4gPj4gKwlpbnQgajsNCj4gPiA+PiAgIA0KPiA+ID4+ICAgCXVzYl9waHlf
aW5pdChkd2MtPnVzYjJfcGh5KTsNCj4gPiA+PiAgIAl1c2JfcGh5X2luaXQoZHdjLT51c2IzX3Bo
eSk7DQo+ID4gPj4gICANCj4gPiA+PiAtCXJldCA9IHBoeV9pbml0KGR3Yy0+dXNiMl9nZW5lcmlj
X3BoeSk7DQo+ID4gPj4gLQlpZiAocmV0IDwgMCkNCj4gPiA+PiAtCQlnb3RvIGVycl9zaHV0ZG93
bl91c2IzX3BoeTsNCj4gPiA+PiArCWZvciAoaSA9IDA7IGkgPCBkd2MtPm51bV91c2IyX3BvcnRz
OyBpKyspIHsNCj4gPiA+PiArCQlyZXQgPSBwaHlfaW5pdChkd2MtPnVzYjJfZ2VuZXJpY19waHlb
aV0pOw0KPiA+ID4+ICsJCWlmIChyZXQgPCAwKQ0KPiA+ID4+ICsJCQlnb3RvIGVycl9leGl0X3Vz
YjJfcGh5Ow0KPiA+ID4+ICsJfQ0KPiA+ID4+ICAgDQo+ID4gPj4gLQlyZXQgPSBwaHlfaW5pdChk
d2MtPnVzYjNfZ2VuZXJpY19waHkpOw0KPiA+ID4+IC0JaWYgKHJldCA8IDApDQo+ID4gPj4gLQkJ
Z290byBlcnJfZXhpdF91c2IyX3BoeTsNCj4gPiA+PiArCWZvciAoaSA9IDA7IGkgPCBkd2MtPm51
bV91c2IyX3BvcnRzOyBpKyspIHsNCj4gPiA+PiArCQlyZXQgPSBwaHlfaW5pdChkd2MtPnVzYjNf
Z2VuZXJpY19waHlbaV0pOw0KPiA+ID4+ICsJCWlmIChyZXQgPCAwKQ0KPiA+ID4+ICsJCQlnb3Rv
IGVycl9leGl0X3VzYjNfcGh5Ow0KPiA+ID4+ICsJfQ0KPiA+ID4+ICAgDQo+ID4gPj4gICAJcmV0
dXJuIDA7DQo+ID4gPj4gICANCj4gPiA+PiArZXJyX2V4aXRfdXNiM19waHk6DQo+ID4gPj4gKwlm
b3IgKGogPSBpLTE7IGogPj0gMDsgai0tKQ0KPiA+ID4gDQo+ID4gPiBNaXNzaW5nIHNwYWNlcyBh
cm91bmQgLSBoZXJlIGFuZCBiZWxvdy4NCj4gPiA+IA0KPiA+ID4+ICsJCXBoeV9leGl0KGR3Yy0+
dXNiM19nZW5lcmljX3BoeVtqXSk7DQo+ID4gPj4gKwlpID0gZHdjLT5udW1fdXNiMl9wb3J0czsN
Cj4gPiA+PiAgIGVycl9leGl0X3VzYjJfcGh5Og0KPiA+ID4+IC0JcGh5X2V4aXQoZHdjLT51c2Iy
X2dlbmVyaWNfcGh5KTsNCj4gPiA+PiAtZXJyX3NodXRkb3duX3VzYjNfcGh5Og0KPiA+ID4+ICsJ
Zm9yIChqID0gaS0xOyBqID49IDA7IGotLSkNCj4gPiA+PiArCQlwaHlfZXhpdChkd2MtPnVzYjJf
Z2VuZXJpY19waHlbal0pOw0KPiA+ID4+ICsNCj4gPiA+IA0KPiA+ID4gQWdhaW46DQo+ID4gPiAN
Cj4gPiA+IAlUaGUgYWJvdmUgaXMgcHJvYmFibHkgYmV0dGVyIGltcGxlbWVudGVkIGFzIGEgKnNp
bmdsZSogbG9vcCBvdmVyDQo+ID4gPiAJbnVtX3VzYjJfcG9ydHMgd2hlcmUgeW91IGVuYWJsZSBl
YWNoIFVTQjIgYW5kIFVTQjMgUEhZLiBPbg0KPiA+ID4gCWVycm9ycyB5b3UgdXNlIHRoZSBsb29w
IGluZGV4IHRvIGRpc2FibGUgdGhlIGFscmVhZHkgZW5hYmxlZA0KPiA+ID4gCVBIWXMgaW4gcmV2
ZXJzZSBvcmRlciBiZWxvdyAoYWZ0ZXIgZGlzYWJsaW5nIHRoZSBVU0IyIFBIWSBpZg0KPiA+ID4g
CVVTQjMgcGh5IGluaXQgZmFpbHMpLg0KPiA+ID4gDQo+ID4gPiB3aXRoIGVtcGhhc2lzIG9uICJz
aW5nbGUiIGFkZGVkLg0KPiA+ID4gDQo+ID4gT2gsIHlvdSBtZWFuIHNvbWV0aGluZyBsaWtlIHRo
aXMgPw0KPiA+IA0KPiA+IGZvciAobG9vcCBvdmVyIG51bV9wb3J0cykgew0KPiA+IAlyZXQgPSBw
aHlfaW5pdChkd2MtPnVzYjNfZ2VuZXJpY19waHlbaV0pOw0KPiA+IAlpZiAocmV0ICE9IDApDQo+
ID4gCQlnb3RvIGVycl9leGl0X3BoeTsNCj4gPiANCj4gPiAJcmV0ID0gcGh5X2luaXQoZHdjLT51
c2IyX2dlbmVyaWNfcGh5W2ldKTsNCj4gPiAJaWYgKHJldCAhPSAwKQ0KPiA+IAkJZ290byBlcnJf
ZXhpdF9waHk7DQo+ID4gfQ0KPiA+IA0KPiA+IGVycl9leGl0X3BoeToNCj4gPiAJZm9yIChqID0g
aS0xOyBqID49IDA7IGotLSkgew0KPiA+IAkJcGh5X2V4aXQoZHdjLT51c2IzX2dlbmVyaWNfcGh5
W2pdKTsNCj4gPiAJCXBoeV9leGl0KGR3Yy0+dXNiMl9nZW5lcmljX3BoeVtqXSk7DQo+ID4gCX0N
Cj4gDQo+IFllYWgsIHNvbWV0aGluZyBsaWtlIHRoYXQsIGJ1dCB5b3UgbmVlZCB0byBkaXNhYmxl
IHRoZSB1c2IzW2ldIHBoeSB3aGVuDQo+IHVzYjJbMl0gaW5pdCBmYWlsIGFib3ZlIChhbmQgSSdk
IGFsc28ga2VlcCB0aGUgb3JkZXIgb2YgaW5pdGlhbGlzaW5nDQo+IHVzYjIgYmVmb3JlIHVzYjMp
Lg0KPiANCj4gPiA+PiAgIAl1c2JfcGh5X3NodXRkb3duKGR3Yy0+dXNiM19waHkpOw0KPiA+ID4+
ICAgCXVzYl9waHlfc2h1dGRvd24oZHdjLT51c2IyX3BoeSk7DQo+IA0KPiA+ID4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+
ID4gPj4gaW5kZXggNDJmYjE3YWE2NmZhLi5iMmJhYjIzY2EyMmIgMTAwNjQ0DQo+ID4gPj4gLS0t
IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gPiA+PiArKysgYi9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuaA0KPiA+ID4+IEBAIC0zNyw2ICszNyw5IEBADQo+ID4gPj4gICAjZGVmaW5lIFhIQ0lf
RVhUX1BPUlRfTUlOT1IoeCkJKCgoeCkgPj4gMTYpICYgMHhmZikNCj4gPiA+PiAgICNkZWZpbmUg
WEhDSV9FWFRfUE9SVF9DT1VOVCh4KQkoKCh4KSA+PiA4KSAmIDB4ZmYpDQo+ID4gPj4gICANCj4g
PiA+PiArLyogTnVtYmVyIG9mIHBvcnRzIHN1cHBvcnRlZCBieSBhIG11bHRpcG9ydCBjb250cm9s
bGVyICovDQo+ID4gPj4gKyNkZWZpbmUgRFdDM19NQVhfUE9SVFMgNA0KPiA+ID4gDQo+ID4gPiBZ
b3UgZGlkIG5vdCBhbnN3ZXIgbXkgcXVlc3Rpb24gYWJvdXQgd2hldGhlciB0aGlzIHdhcyBhbiBh
cmJpdHJhcnkNCj4gPiA+IGltcGxlbWVudGF0aW9uIGxpbWl0IChpLmUuIGp1c3QgcmVmbGVjdGlu
ZyB0aGUgb25seSBjdXJyZW50bHkgc3VwcG9ydGVkDQo+ID4gPiBtdWx0aXBvcnQgY29udHJvbGxl
cik/DQo+ID4gPiANCj4gPiBJIG1lbnRpb25lZCBpbiBjb21taXQgdGV4dCB0aGF0IGl0IGlzIGxp
bWl0ZWQgdG8gNC4gQXJlIHlvdSByZWZlcnJpbmcgdG8gDQo+ID4gc3RhdGUgdGhlIHJlYXNvbiB3
aHkgSSBjaG9zZSB0aGUgdmFsdWUgNCA/DQo+IA0KPiBZZXMsIGFuZCB0byBjbGFyaWZ5IHdoZXRo
ZXIgdGhpcyB3YXMgYW4gYXJiaXRyYXJ5IGxpbWl0IHlvdSBjaG9zZQ0KPiBiZWNhdXNlIGl0IHdh
cyBhbGwgdGhhdCB3YXMgbmVlZGVkIGZvciB0aGUgaHcgeW91IGNhcmUgYWJvdXQsIG9yIGlmIGl0
J3MNCj4gYSBtb3JlIGdlbmVyYWwgbGltaXRhdGlvbi4NCj4gDQoNCk5vdGU6IFdlIGNhbiBzdXBw
b3J0IG1hbnksIGJ1dCB3ZSBzZXQgdGhlIGN1cnJlbnQgbGltaXQgdG8gNCB1c2IzIHBvcnRzDQph
bmQgdXAgdG8gMTUgdXNiMiBwb3J0cy4NCg0KQlIsDQpUaGluaA==
