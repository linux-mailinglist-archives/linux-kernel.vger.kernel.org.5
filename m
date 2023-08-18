Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA2A7813E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 21:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379842AbjHRTvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 15:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379892AbjHRTuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:50:52 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49F5469B;
        Fri, 18 Aug 2023 12:50:27 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IIEbfA007917;
        Fri, 18 Aug 2023 12:49:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=hee7xtq0fdcvpplS5B8965YR+6/eYaBnMaK5RqoEHL8=;
 b=nJ39BtSy7ITVlE6DslmAL+NRtHuWyZLhHaIjeQT4qmPOs0SgcUlhoVaugNs0RLT5PBSK
 f4AtjNMcQ2HKli+HYmMLhPGJWu1c2Xw3dcG0WcWTQo5J+SpxyQgEWf+91U8rE3oUHeIK
 WQqlgz36QZIUkTbfBqL4RyAkHK21J6VhePepcDfdMJECdsgNa/pym9VvVme8uyE8/kEX
 D3AGdKPumgToiV7oXK2TEvY6j09fR+u4Kse1oxPy6IPPv6uZd4H9wZgj+2xanJHWZILl
 hD8fePX3FAcAGTF7HLFyUd64AOax9bFWKKQV8Zc4/ZryZQk4yqeTRp5SoqrS3/mXGouT aw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3se8qdujjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 12:49:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1692388179; bh=hee7xtq0fdcvpplS5B8965YR+6/eYaBnMaK5RqoEHL8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=IcGtyvrCqR68GCYwU+ad7Tek8pkyivQ+9wIXoO0uG/afLX830KedLtOANkxR8RJlY
         MzwH3zXLu7s3ZHTRmXIFC77COk7scuzuqikHkScM/cd3euQ8iTsOkiJidHgL7Ur1uC
         WkylNMWdE43Mlu/pOXVdg2CCuGKZ4CYRMYXga6mmlwXEip/RwU3NJIXUruu6XEQQ6o
         nz0MuS0DZLmWXfArAPgWwUI948uYnM2DGQ7TPq/jGLVQbNKH5jsbKfXkj3nITsEzPE
         J3RVbT7iGEz3QnLupjVk/fGR98GY5jsyzOpQ5kMpjJbKPP+TLPDTsiWFpFa1XISFSL
         gRwqsI+8aqLpw==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 36C7940130;
        Fri, 18 Aug 2023 19:49:39 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3D1BDA008A;
        Fri, 18 Aug 2023 19:49:32 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=M5QHbEXf;
        dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8018E40354;
        Fri, 18 Aug 2023 19:49:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJkXw4gnr0/wPr98gkjSkRzXBNN65nbpQoNI/TmHhmjlT13A1JV2MP/YhQy0nf805jXwnCjJLjsaK4TvDd+tSeA0wvT48IfsPu9OgRQnYvFkrbHx2/P/iZN/GXJtx2W2kVmW40y+iVTwij7gHoBSzTPwAnHetvxMOVAW0qdVUGFmrJNDCE+Q+5kTOSqUYNOYqK2YSwkIBUZbQLhizgXHTHs4rP3Ee9vqLAofa91PBYzYy8TVoVUCoi+7GafUIftHQNiTluiIEZYICxjnNWAxh8xhocNb4vW0mOjJGhipmFpw4g8F/Q/xdXAiljifMDHWOdeijNl4veTSKjf1OmuUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hee7xtq0fdcvpplS5B8965YR+6/eYaBnMaK5RqoEHL8=;
 b=fmsxrrpY45C+Dt/HhFONUgj4HLgzM5c9Ay4qFLeniHQLzZQ3HYXslKXseTMDjJJjxy/KU/Aaq5AAttzUOKd/nRnk92c8IKa5a0LZPQYiOqmYIfeCj7EKZEKG3Ay6fzIPd2DR/yyCHl3XxtCoskLZ8dIKZN6SnFeKwjzMrVfHkv1410X6gF/bPKcq6qPvepDDUc6eWZx7G+7ZYQZ63AI0QjOiIJhoiFbi/cA5Auf1MTPi4f2fFN5ZcHP3Mc/4RZmjkFLG2XUZD8TZddnJRvJ0a8PYPn5VEkZb9yLrpMSZ1CRoZKy6I0a4nJiu8pXf0GVDMvbVDcq7xYquXnOZd16wLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hee7xtq0fdcvpplS5B8965YR+6/eYaBnMaK5RqoEHL8=;
 b=M5QHbEXfAmYJEOKlHMFsJ8eowdWE/qp2NIkIVQXU43bdx3ui+rW95NC6h5LnU3AU0eU4HUglzQPB39HhdmfGxk6avRdvwln1Pu6PPVONyCynwjB7ymWa9ygsSri2+nA7DNQCsmGBQOmQ9gU8S8LoiOJuQqKwS5PsJschEPJV6cY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 19:49:27 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b18d:912e:908a:5952]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b18d:912e:908a:5952%4]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 19:49:27 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Thread-Topic: dwc3: unusual handling of setup requests with wLength == 0
Thread-Index: AQHZ0WkxsEX2ZGMtZEmcF1gvP2WuTK/vPhuAgAAY0oCAAAlogIAACMGAgAEOQgA=
Date:   Fri, 18 Aug 2023 19:49:27 +0000
Message-ID: <20230818194922.ys26zrqc4pocqq7q@synopsys.com>
References: <CA+fCnZcQSYy63ichdivAH5-fYvN2UMzTtZ--h=F6nK0jfVou3Q@mail.gmail.com>
 <20230818010815.4kcue67idma5yguf@synopsys.com>
 <bb470c47-c9dc-4dae-ae3f-c7d4736ee7e9@rowland.harvard.edu>
 <20230818031045.wovf5tj2un7nwf72@synopsys.com>
 <cfc7ae18-140b-4223-9cc2-7ee4b9ddea28@rowland.harvard.edu>
In-Reply-To: <cfc7ae18-140b-4223-9cc2-7ee4b9ddea28@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CH0PR12MB8578:EE_
x-ms-office365-filtering-correlation-id: 9331399c-33a0-42c3-8933-08dba0243af1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lw4RnFsvkzsVC1Bl9tXgZVNV1FXiAJqhCzJIB4OQRL2dGuu/i62Gk/j6sWMQVgEwpq0oY3zlRa0VgEMBHGIJHlbaWkaS3J/WMhU6EVJH6QuHmTvRe08nbRhC39JGDfjzdIXiyx/OG1PDjyPlh8gwpE5AFHDxS1Ee8TsvNGIqHGb9T+EX+ecoeOU7sq80Lc1zH1lQgeQXDfZNZsJokoNwvBKGGJKZBK698bLzOxWJn0ljjsa0eDi7h8nljbZnuC6y227/0hoAMM3qP3NiLUyB3wXloiIGdZ+Zwz20MR2GhRja+mgkuDQI3aAMurFBUgJJJ1OqvCEJaumCWAQfllSemy/ZTtSg+g323a4+3/CRHQQXiKleQaYevdfFExtrE8BAgUZVJ8FvJeFyXdluDGSGckFmuT5P2qy+7dNW8nxPaPm+3gyAnGdfHpO49dSmMkxzpxyuLO44lDcC6dPk7UQReri4IWNK3xk/fEB5MEav/CKVL5nATyTK/w3urjtb4F7yfoTyKsmQuAyZtk0YFgohT/ed6lQXY8bwnPQBxuIrbF3rdWc3f+47ENyJNkWc/0brMLWzOYkQZ36WCYxFFznsZIXB1vbxC0mNKaHRfS6p0rSViZ2G4HPkxFU5vtW08Z9Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199024)(1800799009)(186009)(86362001)(36756003)(38070700005)(38100700002)(122000001)(66446008)(76116006)(2616005)(5660300002)(66476007)(316002)(6486002)(71200400001)(66556008)(6916009)(6506007)(66946007)(54906003)(26005)(6512007)(41300700001)(1076003)(8936002)(4326008)(8676002)(64756008)(478600001)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3lNUVFDdU9SbmlZWUhwMFEwZm9rWUJ3YzQyM0dmTEJ4NEFvdkpqd2NUazVD?=
 =?utf-8?B?am5jSWFnOVU5a1ZYTzRxRldVV0MvSnJmd0lXWmUrSWZNQXlrMFhTVlNxVHdo?=
 =?utf-8?B?cWs1Q3BOUGJqYXV3SVdmRVJPRDVyeEN0UFNoakhzdm52eTZRcmwxdzZTVVRD?=
 =?utf-8?B?VEgyM1lsZDU3c2VaY3BCOHMwTGh5NVZRS29ka0VFSiswQWw4V3ppaFNIWUdY?=
 =?utf-8?B?bEJtQzhHWTg3UjdqUXd0eGJuYkh3bSs2QUNUcmp4Z3UyRnJYVVhDbTJJTmw0?=
 =?utf-8?B?NzFvcFhFQnBudzFCbXVuM1hsSmp5TDMwdE5CTlFwQm51VGMxSWFkVm5HRGhl?=
 =?utf-8?B?WnZBbHNmc29FMGpXZ1hKUXo1VnBFazMzUThMZjhPMGxjS2wveVI1M2hFVGVi?=
 =?utf-8?B?bmlRd1FadUtxQi9XMnhtM0p6RzlscDJPcnI2WDJzY3JzcXFrSC9iZENacXZo?=
 =?utf-8?B?WmtkMno5L085MnBrRVA2RmIwdVR4RG4vV04reTZQY2pjbjJEOE9ZQmZHU1Q5?=
 =?utf-8?B?WnNKRnZqdTNKWVlVRm41Rm01L2IreWNDSGJHWmtLam4vZk5QQnlRQTVFbVRP?=
 =?utf-8?B?dXhKRCtGYkErSUxjUVhnQk9LUUpaZExvTDNuNCsvNGlxSXQ4Vk5mc0dOY0sx?=
 =?utf-8?B?WG5EVW5vZ1RiUXpmMW1EYTA2Y0ZXdXBZUWhlTjhFQUkzcW5uU0J3ZHdIWXVU?=
 =?utf-8?B?ZGZ5WjlOaTVpWVVlVW5tQzBPU3FhaER1Z3ZZTTkvUG1TVllCYXovYXRRSFBa?=
 =?utf-8?B?d3VkMWxzU2hGN0FRSHI1Ny9hd1lxcVh5dmRMNmttWlBHS1BUMEpzckxJcjZj?=
 =?utf-8?B?WWN1RnVUcnJxQU9RRHpBK3phY3RqbU9qUE5PcE11S2JGNEZLazJtZENPV0p4?=
 =?utf-8?B?SkowWEI5MzhMODlLMDdpUU9uZ1RLK3FsQnFvQVQ1UWZxNkFBOVBsdVJDVndm?=
 =?utf-8?B?b2d3YUE3YW1RelQ5djVyc2Y3ZkdjSlJ6Q1drbG1KQXFFVkpYNlFFdEk3eXJ2?=
 =?utf-8?B?SGpEdzRQR2todnJpeS9SOGozQ2lFUEdNb2NJVEgrZ3JndFV1cUdLZEhrOUJa?=
 =?utf-8?B?VnV5Z3haQkxuakt6UVkrWW5PT0lVS0kyWnoybnBwMGdRYW9vSjNtYVFNcUVI?=
 =?utf-8?B?OXJqcUZBeHkyUXNuYW5FOVJrMGpPaDdzQjlvTmJBZEp3Qkx6MHlGMTZGOG9Y?=
 =?utf-8?B?N0M4MXNhV1BzRWFTZ0t3NnBPMzhhTWJ6VUxmTUpXUDFPMG9VdzlJMzZ4cGJ3?=
 =?utf-8?B?Q2daYzdtU2ZJWjc5UUtDSXRvVkVUK2xaczlWNjc4SUN4SHR3VEZVaFFyVnJW?=
 =?utf-8?B?L1VPSGMxRUpOaDJwVG8zMkhYMWk5VTJGSHUxWkovcVVzVk9leHJzdzIwdWVJ?=
 =?utf-8?B?U01FbjFtakorellPR0xCUCtnV0tWOGhDYi9Od0Fpc2QrYXI5ejd5VHp4aHJU?=
 =?utf-8?B?RStSSDV5aS9OQUF0bWU5b2JGbDFqc2xoYzNBZEU1dzdRSWlvRzBUaVZia3N4?=
 =?utf-8?B?Mlpoc3lLZTZNbSszSSsrUFdvQVhwWEViSUdSVDJtOUQ4VElRQU1kNmN1RFRH?=
 =?utf-8?B?OXNWcGJlK2cxaE93Z0NSS1Z2NGRzNG51YUJiaGxkNC9ZMFZkaFgxdm4yMDR1?=
 =?utf-8?B?K01OOXlmK3B2SU93S3lCSWVhcThDL2p4N04yVDYzVWgxektmRE92ZXM1R2c3?=
 =?utf-8?B?UURSblpQZ0puU3NxWlZsRG1TRUhZT1d5ODlRSDM3VVYxY1h1TzcyR0hsaHZN?=
 =?utf-8?B?aWxtWnFkeGNSczlOMUNtUzB1UmJ6bk1yN0FwQTZUaG94b01IcHVheklqQTl4?=
 =?utf-8?B?Y3lOMFZYZWFkU3cva3pzNERXdzY0U0hHZXliWnVIKy9pKyt1SHA1YmQwWUpR?=
 =?utf-8?B?ZURybnYzbGlzemxPN20zdUEwT0xkdEc5TEdyMWROM3BCZTBEa05oaUp2b3lP?=
 =?utf-8?B?cHZONVVqZ3VSWmZQMVJ3RERWTitOVXpPU2JiSHhieUxHdWtRVGk5aGJxN0sx?=
 =?utf-8?B?WFhaTmJjZ2x6YVh2Qm9ocjlmK1ZUajd4SUI4MXIyREphY2dpVWVzT1lVVlRm?=
 =?utf-8?B?RUR5bHBKQXVKVlhiMmFDdjA3b1NabVRlQSsvV1Q3VEJWRDRxd2xZdk5QbFAy?=
 =?utf-8?B?NXM1dWQ3dTlwSzBaZzN5Q3ZMRUhESXU2ZXJ1aTJ6eThtbWVMRkd3QlFnQWhm?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <655EFE4437500F49AF5EBD20F08FB23C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Qm5HREU2cENwZmYwVWhpejlqYit1d3lpQWNYTDFBSytBeGhnajBkYkhtMGFU?=
 =?utf-8?B?NTdQdUZQY3phRDRVa2Z3aytnL01JRXltbFJrL01raEliL1lNdW0yU3RPT2dn?=
 =?utf-8?B?WHlYcWtMZmx3cVdieVIzazBMQUhadXJKOXF1SzhqenlaZkpYSmZMTnJZbDcr?=
 =?utf-8?B?TWFyWDNzSnJkT21FNXdDeHgrZk83eWtCdXowOVlsZFVydGZQd25xRjR3UTcr?=
 =?utf-8?B?dFRSbms4TEwwUlA0cjR2UENDeUpGeTFqczEwTkdCV2IrdlpPSVRMSnFwS1Vw?=
 =?utf-8?B?VmRBZHJDc0Fua0o3c2FoMExKcm1PWVBvcEI5eXIyaWJTd2JHVFRFMGhRNWNu?=
 =?utf-8?B?QjhHRGdnaExwRHlRRzljVU14RmRPS3ZmbExaMGxadjZabmZoRWxBZnV1RDBG?=
 =?utf-8?B?cEsvZkZrWVJsSWJGVFkySzVXUFRuTjhPVjhjRnNqNGlqREYrdDRGQi96MG14?=
 =?utf-8?B?RC9HVnBsZ3Y2eE9zTHAvQkpyckUzZ0ZGOEg4R1VLUXpHZUhCU0toYUZJUVR2?=
 =?utf-8?B?KzQ3TTNFODFoNmN3WUNsQXd6OGw3VndJd1gveHp1YlZQM2lVQ1RJdW02aXVZ?=
 =?utf-8?B?QWRVV1pWSG02a1BONjl5Q1IweXFYcmJ3SFAvclUyUWQrRHhpMDI5cDhRN21k?=
 =?utf-8?B?cjAwSEJvbHFyeG9udlc2MVhYUlhvYmE2TzhsVXVpQ3N4THZFTFBlRTZxbnFN?=
 =?utf-8?B?OTYvZTdTZkVwU3Vsbk5KUUUySFdURFJWRmpUMWdjSWJDOStTRGlDblBQSCtP?=
 =?utf-8?B?MVgzZ0ZFMEFQaWVKcmx6MzZlYWdrSEQwZElJbnBLMXRZWW1UOTBkcHM1bmhZ?=
 =?utf-8?B?V3c0NksxSmU4ZjEyZW5BWkZlYUFkWnphdjJuRklFS1Jwc1RyNnhva1RKemJR?=
 =?utf-8?B?QnF4RW9EVVBpTzNYQUVsNWtjckkwZGp1OUNOcUgyRmZSekhYOElhc2JLSDFs?=
 =?utf-8?B?OUxBYXFzSDVVcFNKTXBtZkVPUW1vazVNd09CeEtVZ2JnRmIvYU8zcnp3ZS9p?=
 =?utf-8?B?UUtDUHNxUDNhUC9nVU1ieWpKRm9yUkEzNWVlNElzd0FrdWxsN2x3TmhBdzcv?=
 =?utf-8?B?QWdUTnN0OEE3bWVOODZRRFB3RzhnWTNrL085ZjBLYk55aWV6bVZOOWluZy94?=
 =?utf-8?B?UkgwRVZDcGNOZ0xrUEYreDE2bC84aTRqVnRiQ0lJbTRGSjVWUmhzVzlPVW9W?=
 =?utf-8?B?UXhmc3FTT1dONm1Qdk93UCtGN0RCQlV4K1E2ZHFKMUttQXp1MDFBMG56NXFU?=
 =?utf-8?B?QWpWcGZvTFRDMjJxWWFhNkFHeEluRUdXYXF4cTdFbWRLRkZBZz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9331399c-33a0-42c3-8933-08dba0243af1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 19:49:27.1049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iFw52x/HkzWh5oDlT0if9ny4rvyUO0w+czyxDV+i1VjqqgGXw8glCreiGaMRoS66S97wPdv02kqDQKqfkWhP9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578
X-Proofpoint-ORIG-GUID: XcVB6-VwTwVSKhxR6MtDxzMR2-ps1rwL
X-Proofpoint-GUID: XcVB6-VwTwVSKhxR6MtDxzMR2-ps1rwL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_25,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308180179
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBdWcgMTcsIDIwMjMsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IE9uIEZyaSwgQXVnIDE4
LCAyMDIzIGF0IDAzOjEwOjQ4QU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBU
aHUsIEF1ZyAxNywgMjAyMywgQWxhbiBTdGVybiB3cm90ZToNCj4gPiA+IE9uIEZyaSwgQXVnIDE4
LCAyMDIzIGF0IDAxOjA4OjE5QU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+ID4g
SGksDQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBGcmksIEF1ZyAxOCwgMjAyMywgQW5kcmV5IEtvbm92
YWxvdiB3cm90ZToNCj4gPiA+ID4gPiBIaSBBbGFuIGFuZCBUaGluaCwNCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBJIGhhdmUgYmVlbiB0ZXN0aW5nIFJhdyBHYWRnZXQgd2l0aCB0aGUgZHdjMyBVREMg
ZHJpdmVyIGFuZCBzdHVtYmxlZA0KPiA+ID4gPiA+IHVwb24gYW4gaXNzdWUgcmVsYXRlZCB0byBo
b3cgZHdjMyBoYW5kbGVzIHNldHVwIHJlcXVlc3RzIHdpdGggd0xlbmd0aA0KPiA+ID4gPiA+ID09
IDAuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gV2hlbiBydW5uaW5nIGEgc2ltcGxlIFJhdyBHYWRn
ZXQtYmFzZWQga2V5Ym9hcmQgZW11bGF0b3IgWzFdLA0KPiA+ID4gPiA+IGV2ZXJ5dGhpbmcgd29y
a3MgYXMgZXhwZWN0ZWQgdW50aWwgdGhlIHBvaW50IHdoZW4gdGhlIGhvc3Qgc2VuZHMgYQ0KPiA+
ID4gPiA+IFNFVF9DT05GSUdVUkFUSU9OIHJlcXVlc3QsIHdoaWNoIGhhcyB3TGVuZ3RoID09IDAu
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gRm9yIHNldHVwIHJlcXVlc3RzIHdpdGggd0xlbmd0aCAh
PSAwLCBqdXN0IGxpa2UgdGhlIG90aGVyIFVEQyBkcml2ZXJzDQo+ID4gPiA+ID4gSSB0ZXN0ZWQs
IGR3YzMgY2FsbHMgdGhlIGdhZGdldCBkcml2ZXIncyAtPnNldHVwKCkgY2FsbGJhY2sgYW5kIHRo
ZW4NCj4gPiA+ID4gPiB3YWl0cyB1bnRpbCB0aGUgZ2FkZ2V0IGRyaXZlciBxdWV1ZXMgYW4gVVJC
IHRvIEVQMCBhcyBhIHJlc3BvbnNlLg0KPiA+ID4gPiANCj4gPiA+ID4gRm9yIHRoZSBsYWNrIG9m
IGJldHRlciB0ZXJtLCBjYW4gd2UgdXNlICJyZXF1ZXN0IiBvciAidXNiX3JlcXVlc3QiDQo+ID4g
PiA+IGluc3RlYWQgb2YgVVJCIGZvciBnYWRnZXQgc2lkZSwgSSBnZXQgY29uZnVzZWQgd2l0aCB0
aGUgaG9zdCBzaWRlDQo+ID4gPiA+IHdoZW5ldmVyIHdlIG1lbnRpb24gVVJCLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBIb3dldmVyLCBmb3IgYSBzZXR1cCByZXF1ZXN0IHdpdGgg
d0xlbmd0aCA9PSAwLCBkd2MzIGRvZXMgbm90IHdhaXQNCj4gPiA+ID4gPiB1bnRpbCB0aGUgZ2Fk
Z2V0IGRyaXZlciBxdWV1ZXMgYW4gVVJCIHRvIGFjayB0aGUgdHJhbnNmZXIuIEl0IGFwcGVhcnMN
Cj4gPiA+ID4gPiB0aGF0IGR3YzMganVzdCBhY2tzIHRoZSByZXF1ZXN0IGludGVybmFsbHkgYW5k
IHRoZW4gcHJvY2VlZHMgd2l0aA0KPiA+ID4gPiA+IGNhbGxpbmcgdGhlIC0+c2V0dXAoKSBjYWxs
YmFjayBmb3IgdGhlIG5leHQgcmVxdWVzdCByZWNlaXZlZCBmcm9tIHRoZQ0KPiA+ID4gPiANCj4g
PiA+ID4gSXQgZGVwZW5kcyBvbiB0aGUgYlJlcXVlc3QuIEl0IHNob3VsZCBub3QgcHJvY2VlZCB0
byAtPnNldHVwKCkgdW5sZXNzDQo+ID4gPiA+IHRoZSBnYWRnZXQgZHJpdmVyIGFscmVhZHkgc2V0
dXBzIHRoZSByZXF1ZXN0IGZvciBpdC4NCj4gPiA+IA0KPiA+ID4gTGV0J3Mgc2VlIGlmIEkgdW5k
ZXJzdGFuZCB3aGF0IHlvdSdyZSBzYXlpbmcuICBTb21lIGNvbnRyb2wgdHJhbnNmZXJzIA0KPiA+
ID4gYXJlIGhhbmRsZWQgZGlyZWN0bHkgYnkgdGhlIFVEQyBkcml2ZXIgKHRoaW5ncyBsaWtlIFNF
VF9BRERSRVNTIG9yIA0KPiA+ID4gQ0xFQVJfSEFMVCkuICBGb3IgdGhlc2UgdHJhbnNmZXJzLCB0
aGUgLT5zZXR1cCgpIGNhbGxiYWNrIGlzIG5vdCBpbnZva2VkIA0KPiA+ID4gYW5kIHRoZSBnYWRn
ZXQgZHJpdmVyIGlzIGNvbXBsZXRlbHkgdW5hd2FyZSBvZiB0aGVtLiAgQnV0IGZvciBhbGwgb3Ro
ZXIgDQo+ID4gPiBjb250cm9sIHRyYW5zZmVycywgdGhlIC0+c2V0dXAoKSBjYWxsYmFjayBfaXNf
IGludm9rZWQuDQo+ID4gPiANCj4gPiA+IElzIHRoYXQgd2hhdCB5b3UgbWVhbnQ/DQo+ID4gDQo+
ID4gVGhhdCdzIG5vdCB3aGF0IEkgbWVhbnQuDQo+ID4gDQo+ID4gSSB3YXMgcmVmZXJyaW5nIHRv
IHRoZSBuZXh0IHJlcXVlc3QuIEl0IHNob3VsZCBub3QgYmUgcHJvY2Vzc2VkIHVudGlsDQo+ID4g
dGhlIGZpcnN0IHJlcXVlc3QgaXMgY29tcGxldGVkLiBEZXBlbmRpbmcgb24gdGhlIHR5cGUgb2Yg
cmVxdWVzdCwgaWYNCj4gPiB0aGVyZSdzIGEgZGVsYXllZF9zdGF0dXMsIHRoZSBkd2MzIGRyaXZl
ciB3aWxsIG5vdCBwcmVwYXJlIGZvciB0aGUNCj4gPiBTdGF0dXMgc3RhZ2UgYW5kIFNldHVwIHN0
YWdlIChhZnRlciBzdGF0dXMgY29tcGxldGlvbikgdG8gcHJvY2VlZCB0byB0aGUNCj4gPiBfbmV4
dF8gLT5zZXR1cCBjYWxsYmFjay4NCj4gPiANCj4gPiBNeSB1bmRlcnN0YW5kaW5nIGZyb20gdGhl
IGRlc2NyaWJlZCBwcm9ibGVtIGlzIHRoYXQgc29tZWhvdyBkd2MzDQo+ID4gcHJvY2Vzc2VzIHRo
ZSBuZXh0IHJlcXVlc3QgaW1tZWRpYXRlbHkgd2l0aG91dCB3YWl0aW5nIGZvciB0aGUgcmF3DQo+
ID4gZ2FkZ2V0IHByZXBhcmluZyB0aGUgZGF0YSBzdGFnZS4NCj4gDQo+IFVtLiAgVGhpcyBpcyBv
bmUgb2YgdGhlIGRlc2lnbiBmbGF3cyBJIG1lbnRpb25lZDogYSBuZXcgU0VUVVAgcGFja2V0IA0K
PiBhcnJpdmluZyBiZWZvcmUgdGhlIG9sZCBjb250cm9sIHRyYW5zZmVyIGlzIGZpbmlzaGVkLiAg
VGhlIFVTQiBzcGVjIA0KPiByZXF1aXJlcyBkZXZpY2VzIHRvIGFjY2VwdCB0aGUgbmV3IFNFVFVQ
IHBhY2tldCBhbmQgYWJvcnQgdGhlIG9sZCANCj4gdHJhbnNmZXIuICBTbyBpbiB0aGlzIGNhc2Us
IHByb2Nlc3NpbmcgdGhlIG5leHQgcmVxdWVzdCBpbW1lZGlhdGVseSBpcyANCj4gdGhlIHJpZ2h0
IHRoaW5nIHRvIGRvLg0KDQpObywgYXMgSSd2ZSBtZW50aW9uZWQsIGZyb20gdGhlIGdhZGdldCBk
cml2ZXIsIGl0IHNob3VsZCBub3Qgc2VlIHRoZQ0KbmV4dCAtPnNldHVwIHVudGlsIHRoZSBmaXJz
dCBjb250cm9sIHRyYW5zZmVyIGNvbXBsZXRpb24sIHJlZ2FyZGxlc3MNCndoZXRoZXIgdGhlIHRy
YW5zZmVyIGNvbXBsZXRlZCB3aXRoIGVycm9yIGNvZGUgZHVlIHRvIGFib3J0IG9yIG5vdC4NCkV2
ZXJ5dGhpbmcgc2hvdWxkIGhhcHBlbiBzZXF1ZW50aWFsbHkgZnJvbSB0aGUgZ2FkZ2V0IGRyaXZl
ci4gVGhpcw0Kc2hvdWxkIGJlIGhhbmRsZWQgaW4gdGhlIGR3YzMgZHJpdmVyICh0aG91Z2ggd2Ug
bWlzc2VkIGEgc2V0dXBfcGVuZGluZw0Kc3RhdHVzIGNoZWNrIGluIHRoZSBkYXRhIHBoYXNlIHRo
YXQgbmVlZHMgdG8gYmUgZml4ZWQgbm93IHRoYXQgSSBsb29rIGF0DQppdCBhZ2FpbikuDQoNClBl
cmhhcHMgdGhlIGNvcmUgZGVzaWduIHNob3VsZCBiZSBzbyB0aGF0IHRoaXMgc3luY2hyb25pemF0
aW9uIGRvZXMgbm90DQpkZXBlbmQgb24gdGhlIHVkYyBkcml2ZXIgaW1wbGVtZW50YXRpb24uDQoN
Cj4gDQo+IE9uZSBxdWVzdGlvbiBpcyB3aHkgQW5kcmV5IGlzIG9ic2VydmluZyBhIG5ldyAtPnNl
dHVwKCkgY2FsbGJhY2sgDQo+IGhhcHBlbmluZyBzbyBzb29uPyAgVGhlIGhvc3QgaXMgc3VwcG9z
ZWQgdG8gYWxsb3cgYSBmYWlybHkgbG9uZyB0aW1lIGZvciANCj4gc3RhbmRhcmQgY29udHJvbCBy
ZXF1ZXN0cyB0byBjb21wbGV0ZS4gIElmIHRoZSB1c2Vyc3BhY2UgY29tcG9uZW50IG9mIA0KPiB0
aGUgUmF3IEdhZGdldCB0YWtlcyB0b28gbG9uZyB0byBhY3QsIHRoZSB0cmFuc2ZlciBjb3VsZCB0
aW1lIG91dCBhbmQgYmUgDQo+IGNhbmNlbGxlZCBvbiB0aGUgaG9zdC4gIEJ1dCAidG9vIGxvbmci
IG1lYW5zIHNldmVyYWwgc2Vjb25kcyAtLSBpcyB0aGF0IA0KPiByZWFsbHkgd2hhdCdzIGdvaW5n
IG9uIGhlcmU/DQoNCkFzIEkgbm90ZWQgaW5pdGlhbGx5LCBpdCBzaG91bGQgbm90IGhhcHBlbiBz
byBJJ20gbm90IHN1cmUgd2hhdCdzIHJlYWxseQ0KdGhlIHByb2JsZW0gaGVyZS4gR3JhbnRlZCB0
aGF0IHRoZSBzZXR1cF9wZW5kaW5nIGNoZWNrIGZvciBkYXRhIHBoYXNlIGlzDQptaXNzaW5nIGlu
IGR3YzMgZHJpdmVyLCB0aGVyZSBzaG91bGQgbm90IGJlIGEgcHJvYmxlbSB1bmxlc3MgdGhlIGhv
c3QNCmFjdHVhbGx5IGFib3J0ZWQgYSBjb250cm9sIHRyYW5zZmVyLiBBbHNvLCB0aGVyZSBzaG91
bGQgYmUgbm8gZGF0YSBwaGFzZQ0KZm9yIHdsZW5ndGg9MCBldmVuIGZvciBJTiBkaXJlY3Rpb24g
aWYgd2UgZ28gdGhyb3VnaCB0aGUgY29tcG9zaXRlDQpsYXllci4gU28sIEkgZG91YnQgdGhhdCdz
IHdoYXQgaGFwcGVuaW5nIGhlcmUuDQoNClBlcmhhcHMgQW5kcmV5IGNhbiBjbGFyaWZ5Lg0KDQo+
IA0KPiA+IEkgd2FzIHRhbGtpbmcgaW4gY29udGV4dCBvZiAwLWxlbmd0aCB0cmFuc2ZlciAoYWxi
ZWl0IEkgZm9yZ290IGFib3V0IHRoZQ0KPiA+IHNwZWNpYWwgY2FzZSBvZiBjb250cm9sIE9VVCBk
b2Vzbid0IGhhdmUgMy1zdGFnZSkuDQo+ID4gDQo+ID4gSWYgaXQncyBhIHZlbmRvciByZXF1ZXN0
IDAtbGVuZ3RoIHRyYW5zZmVyLCB3aXRob3V0IHJlc3BvbmRpbmcgd2l0aA0KPiA+IFVTQl9HQURH
RVRfREVMQVlFRF9TVEFUVVMsIHRoZSBkd2MzIHdpbGwgcHJvY2VlZCB3aXRoIHByZXBhcmluZyB0
aGUNCj4gPiBzdGF0dXMgc3RhZ2UuDQo+IA0KPiBUaGlzIG1heSBiZSBhIGhvbGRvdmVyIGZyb20g
dGhlIGVhcmx5IGRheXMgb2YgdGhlIEdhZGdldCBzdWJzeXN0ZW0uICBNeSANCj4gbWVtb3J5IGZy
b20gYmFjayB0aGVuIGlzbid0IHZlcnkgZ29vZDsgSSB2YWd1ZWx5IHJlY2FsbCB0aGF0IHRoZSBm
aXJzdCANCj4gVURDIGRyaXZlcnMgd291bGQgcXVldWUgdGhlaXIgYXV0b21hdGljIFN0YXR1cy1z
dGFnZSByZXF1ZXN0cyBpZiB3TGVuZ3RoIA0KPiB3YXMgMCBhbmQgLT5zZXR1cCgpIHJldHVybmVk
IDAgKHdoaWNoIHdvdWxkIGV4cGxhaW4gd2h5IA0KPiBVU0JfR0FER0VUX0RFTEFZRURfU1RBVFVT
IGhhZCB0byBiZSBpbnZlbnRlZCkuICBVbmxlc3MgSSdtIGNvbXBsZXRlbHkgDQo+IGNvbmZ1c2Vk
LCB0aGF0J3Mgbm90IGhvdyBVREMgZHJpdmVycyBhcmUgc3VwcG9zZWQgdG8gYWN0IG5vdy4NCg0K
Rm9yIGR3YzMsIGl0J3MgYmVlbiBsaWtlIHRoaXMgc2luY2UgdGhlIGJlZ2lubmluZyB0aGF0IGl0
IGF1dG9tYXRpY2FsbHkNCnF1ZXVlcyB0aGUgc3RhdHVzIHVwb24gaG9zdCByZXF1ZXN0LiBVU0Jf
R0FER0VUX0RFTEFZRURfU1RBVFVTIHdhcw0KaW50cm9kdWNlZCB0byBzdXBwb3J0IHNjZW5hcmlv
cyB3aGVyZSB0aGUgZGV2aWNlIG1heSBuZWVkIGEgbG9uZ2VyIHRpbWUNCnRvIHByb2Nlc3MgdGhl
IHNwZWNpZmljIHJlcXVlc3QgKHN1Y2ggYXMgU0VUX0NPTkZJR1VSQVRJT04pLg0KDQo+IA0KPiA+
ID4gKElNTyB0aGF0IGF1dG9tYXRpYyBhY3Rpb24gaXMgYSBkZXNpZ24gZmxhdzsgdGhlIFVEQyBk
cml2ZXIgc2hvdWxkIHdhaXQgDQo+ID4gPiBmb3IgdGhlIGdhZGdldCBkcml2ZXIgdG8gZXhwbGlj
dGx5IHF1ZXVlIGEgMC1sZW5ndGggcmVxdWVzdCBvciBhIFNUQUxMIA0KPiA+ID4gaW5zdGVhZCBv
ZiBkb2luZyBpdCBhdXRvbWF0aWNhbGx5LikNCj4gPiANCj4gPiBXb3VsZCBldmVyeSBVREMgaGFz
IHRoaXMgY2FwYWJpbGl0eT8gSSByZWNhbGxlZCBzb21lIGFyZW4ndCBjYXBhYmxlIG9mDQo+ID4g
ZGVsYXllZF9zdGF0dXMuDQo+IA0KPiBJbiB0aG9zZSBjYXNlcyB0aGUgVURDIGRyaXZlciB3b3Vs
ZCBqdXN0IGhhdmUgdG8gZG8gdGhlIGJlc3QgaXQgY2FuLiAgDQo+IFZlcnkgZmV3IG1vZGVybiBV
U0IgZGV2aWNlIGNvbnRyb2xsZXJzIHNob3VsZCBoYXZlIHRoaXMgbGltaXRhdGlvbi4NCj4gDQo+
ID4gPiAoQW5vdGhlciBkZXNpZ24gZmxhdyBpcyB0aGF0IHRoaXMgZGVzaWduIGRvZXNuJ3Qgc3Bl
Y2lmeSB3aGF0IHNob3VsZCANCj4gPiA+IGhhcHBlbiBpZiB0aGUgVURDIHJlY2VpdmVzIGFub3Ro
ZXIgU0VUVVAgcGFja2V0IGZyb20gdGhlIGhvc3QgYmVmb3JlIHRoZSANCj4gPiA+IFN0YXR1cyBz
dGFnZSBjb21wbGV0ZXMuICBCeSBzZW5kaW5nIGFub3RoZXIgU0VUVVAgcGFja2V0LCB0aGUgaG9z
dCBpcyANCj4gPiA+IGluZGljYXRpbmcgdGhhdCB0aGUgZWFybGllciBjb250cm9sIHRyYW5zZmVy
IGhhcyBiZWVuIGFib3J0ZWQuICANCj4gPiA+IFByZXN1bWFibHkgdGhlIFVEQyBkcml2ZXIgd2ls
bCBjb21wbGV0ZSBhbGwgdGhlIG91dHN0YW5kaW5nIHJlcXVlc3RzIA0KPiA+ID4gd2l0aCBhbiBl
cnJvciBzdGF0dXMsIGJ1dCB0aGVyZSdzIGEgcG90ZW50aWFsIHJhY2UgaW4gdGhlIGdhZGdldCBk
cml2ZXIgDQo+ID4gPiBiZXR3ZWVuIHF1ZXVpbmcgYSByZXF1ZXN0IGZvciB0aGUgZmlyc3QgdHJh
bnNmZXIgYW5kIGV4ZWN1dGluZyB0aGUgDQo+ID4gPiAtPnNldHVwKCkgY2FsbGJhY2sgZm9yIHRo
ZSBzZWNvbmQgdHJhbnNmZXIuKQ0KPiA+IA0KPiA+IElmIHRoZXJlJ3MgYW5vdGhlciBTRVRVUCBw
YWNrZXQgY29taW5nIHdoaWxlIHRoZXJlJ3MgYSBwZW5kaW5nIGNvbnRyb2wNCj4gPiB0cmFuc2Zl
ciwgZm9yIGR3YzMgVURDLCB0aGUgcGVuZGluZyBjb250cm9sIFRSQiBzaG91bGQgYmUgY29tcGxl
dGVkIHdpdGgNCj4gPiBhIFNldHVwX3BlbmRpbmcgc3RhdHVzIGluZGljYXRpbmcgYWJvcnRlZCBj
b250cm9sIHRyYW5zZmVyIGZvciBkd2MzDQo+ID4gZHJpdmVyIHRvIGhhbmRsZSB0aGF0Lg0KPiAN
Cj4gUmlnaHQuICBUaGUgZGlmZmljdWx0eSBkb2Vzbid0IGludm9sdmUgdGhlIGNvbW11bmljYXRp
b24gYmV0d2VlbiB0aGUgSENEIA0KPiBhbmQgdGhlIFVEQyBoYXJkd2FyZTsgaXQgaW52b2x2ZXMg
dGhlIGNvbW11bmljYXRpb24gYmV0d2VlbiB0aGUgVURDIA0KPiBkcml2ZXIgYW5kIHRoZSBnYWRn
ZXQgZHJpdmVyLiAgU29tZWhvdyB0aGV5IG5lZWQgdG8gc3luY2hyb25pemUgc28gdGhhdCANCj4g
d2hlbiB0aGUgZ2FkZ2V0IGRyaXZlciBxdWV1ZXMgYSB1c2JfcmVxdWVzdCwgdGhlIFVEQyBkcml2
ZXIgY2FuIHRlbGwgDQo+IHdoZXRoZXIgdGhlIHJlcXVlc3Qgd2FzIG1lYW50IGZvciB0aGUgZWFy
bGllciBhYm9ydGVkIGNvbnRyb2wgdHJhbnNmZXIgDQo+IG9yIHRoZSBuZXcgYWN0aXZlIG9uZS4g
IFRoaXMgY2FuIG1hdHRlciBpZiB0aGUgZ2FkZ2V0IGRyaXZlciBoYXMgYSANCj4gc2VwYXJhdGUg
Y29udHJvbCB0aHJlYWQgKGEgd29yayByb3V0aW5lIG9yIGEga3RocmVhZCwgZm9yIGV4YW1wbGUp
IHRoYXQgDQo+IGNvdWxkIGJlIHF1ZXVpbmcgcmVxdWVzdHMgd2hpbGUgdGhlIC0+c2V0dXAoKSBj
YWxsYmFjayBpcyBydW5uaW5nLg0KPiANCg0KUGVyaGFwcyB0aGlzIGNhbiBiZSBpbXByb3ZlZCBh
bmQgZW5mb3JjZWQgZnJvbSB0aGUgY29yZS4gQXQgdGhlIG1vbWVudCwNCml0IHNob3VsZCBub3Qg
YmUgYSBwcm9ibGVtIGZvciBnYWRnZXQgZHJpdmVyIHdpdGggZHdjMyBkcml2ZXIgKHdpdGggYQ0K
bWlub3IgZml4IGR1ZSB0byBtaXNzaW5nIGNoZWNrKS4NCg0KQlIsDQpUaGluaA==
