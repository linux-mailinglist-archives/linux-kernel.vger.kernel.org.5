Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35A778D1C1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 03:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241568AbjH3BdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 21:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241548AbjH3BdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 21:33:00 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AD8CC2;
        Tue, 29 Aug 2023 18:32:58 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U0IPiG026817;
        Tue, 29 Aug 2023 18:32:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Bidj/rN0nR9Rxb8enGxyoWwYgRNIfPKJS1oLF2OFNtI=;
 b=gvpsCp8Fe7kcVoFPuVK6T5eL472ZjbzsyvcliN5ACSiD0UyyPl1PspbZ9CLczfaeICH4
 eo1Nz9y4o80gOBUGHlb/FlyUBjSO6/p6y+NyjFnOqGBFJRV/kVp9LXr9hHsuSpYTStw1
 yfsUmhTWpwg8My2NK5fqEy9Haz7ULmwbQ0uXRsXazWi+YagO4GZVXF7LNWz4SS2Xlae3
 KEAsGAKAIoBeLq1RhNNz5znI+4Y29e3D3dqrG4CPMsWqDJ1i0LSvVj1GjMfWUSYYqsvO
 s9pBm7+eWb6CgmjYCCtUyumCapxaOL9sKo+StLd8KmDf8c1ycDfml7MwxFyKmDqs8dEc 1g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3sqgn562pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 18:32:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1693359155; bh=Bidj/rN0nR9Rxb8enGxyoWwYgRNIfPKJS1oLF2OFNtI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=DwNsX/vyT1OCdHfZzAA9ccQOYMTGHHv6oBe6YzFZK0jfMF1mISgTI/P2bC30ERs2h
         9e5Qgym/ZHwZzH2nBLJv+AaDuBRNQSNLVivEnvYFfum4yJvsfQNbKUXwqrmJRmj5kG
         JzALNYLQGBGukFQMf+6Y4lCFhyZPR2aF6lUHY2Tvlss2qCIszr4GISgQZXdhWPBULI
         uttph4tnhmQzjz0yKSYgxtHT06Shf/jcWmuxSUD4leizU98fwDgf4RtJj5Tw4NwKJv
         zv7ntWRUDTb+N7fqGq5gPF2OMwHqPZRClXJYdcyKo/ugWPZSMzOiw1I8eLsg3IkIGl
         zgF+mj/ZY8HQg==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C76DE40130;
        Wed, 30 Aug 2023 01:32:34 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 34CF6A0096;
        Wed, 30 Aug 2023 01:32:34 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=FuWruepV;
        dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 598A6404AC;
        Wed, 30 Aug 2023 01:32:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EINeTYtV81wRrXHkxHR5QDYtIPELEjgvy2TXW+RHQsmRzstb+TITBGhDJctUUNHYPvuKJkRa7gMp7x+/6DxwTdcAi/7pAJNZBsc6L2PCv1vbe59i5cLCQZtWWiAezN02gU1g/1cNgPKmeFKDaapH4wo07ZQ1iv835k6lV0vKZdxy53aoTvOs3N1IEpfKJFxCsegM/tgpPE23aCGibhrSCk1xhy9HgaS8CcAcd3SmkpieW9kx/9CSM9MwzFKOiv7aRoat/gp94yiJe891VE9MnewWiFxA3GoT206zF/iSj1XTmlkm4lUIVBZ4Q+dW4PylcDwp9tQ1WWun6wSINZ1ndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bidj/rN0nR9Rxb8enGxyoWwYgRNIfPKJS1oLF2OFNtI=;
 b=N2cXwWh/O89wDuD6/wH7FxYu5cALyK++q7Iks3vfZoa9VASd95bNjNgo0ayk2CPlhjKkMWV+Nz0QpztMUkoQRCesix6d1vCDxhyYu0tgsq0Aw69pecABeXqhKtmNFXO5kfdALrobM/wEITg1Tqyv14CovhNEUXOpXXrHkWMzppSBr1v9SegYyImYBa/EQ8F+HW+BlnvdyZo4Vdv+tnLkBIg2nZvHCzxTUOM1ONsWJiulqyAirMjJmDCjpeyZeL3jWcpWVOqAp4WX2Ya0lV+171vRZno/7J8P1GNpWv8/eZPFhIJXgnSVb67kzghY4KSg9fE6IDRElNjbvEg0fvNCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bidj/rN0nR9Rxb8enGxyoWwYgRNIfPKJS1oLF2OFNtI=;
 b=FuWruepVeq9olSZaFCxq9GvMh4He9KceIS4pv1P6170VevX98ok1vedH2oWrgIuqDyqdgpKICrDQztneVbgH/MgT2duIgCztERcVdvdvJ4sryyBn/qeRFlhLYhsXMudGE8OETNxHmjnsaCy0UuLBomAnkQ8zc5TCne6l36Ee8N8=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 01:32:28 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 01:32:28 +0000
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
Thread-Index: AQHZ0WkxsEX2ZGMtZEmcF1gvP2WuTK/vPhuAgAAY0oCAAAlogIAACMGAgAEOQgCAADc1AIAAELKAgAKA6gCAA+wcgIAA2rMAgAAtNoCAABaOgIAAMuwAgABCyQCAAxO2AIAAHuQAgAYtxwA=
Date:   Wed, 30 Aug 2023 01:32:28 +0000
Message-ID: <20230830013222.ukw5dtburjnrrjko@synopsys.com>
References: <20230819000643.7mddkitzr4aqjsms@synopsys.com>
 <e63ba783-f5a4-4442-8736-987a3b134e7f@rowland.harvard.edu>
 <20230823021429.rlgixqehry4rsqmm@synopsys.com>
 <5d5973b9-d590-4567-b1d6-4b5f8aeca68b@rowland.harvard.edu>
 <20230823175903.bpumanwv5fkpwc44@synopsys.com>
 <08a3759d-4c6b-4034-8516-685e4d96a41e@rowland.harvard.edu>
 <20230823222202.k7y7hxndsbi7h4x7@synopsys.com>
 <9b175f9e-ab70-47a3-a943-bfd05601aa23@rowland.harvard.edu>
 <20230826012024.mboftu3wk7fsrslp@synopsys.com>
 <ba06679f-93d2-4cb4-9218-9e288065bdfb@rowland.harvard.edu>
In-Reply-To: <ba06679f-93d2-4cb4-9218-9e288065bdfb@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SN7PR12MB8004:EE_
x-ms-office365-filtering-correlation-id: bd5b5ba2-b89a-46bb-ee62-08dba8f8f908
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XkE75+IeqgJaJ3kjTdnBpRzCWnPl+lH+vy6ftZJl4D64zzuET5SB3JLDzZNMVQUu9ATz7rEJ5GbJi2BSqfBUFGBP8IqWToRqBePEYi7gACV0LXD2crnWaBlKAmkPgi+8yt3iCy/tFyvqU8pS2NyQZCjWjyiUfeMX+Of/oy3Jy1vDDuoehbL1dIfla/AA4crGhoTvF+Di65BMgREPID7hbXFodqt9XasEnaj41F+kM7hDndocZptdTpex4TSj/8viGdqZw1vAMhsX+JxyNA8cCuvLVkRXtSAsUNEtCBlgOF1HkVg9fqtRAJJm2+ucn2Z4qxJtlxmV+mjNytBCR7/6dTa5I/SIwWNEw9iVMiqBh2yDubZ3xhi6e/wiJZOIZzsF6/PkjhLrLN24nfljGY1HBE2PDD1XCbaA+yUWXSyt2nxtzpkRVfLovQt0CGcCHMKbSGRqo1qTWRkEoXbEdk7LBWX2gzkqDHTdQtBQG8DX+JtyZk7l85qQMI1P+VbEMWiqJzeYMq4OX9p5mHh+sylhhq3y/EyXMABi/6S+WcBpFrkEa9oIhT99DI3CcuCB2GsBM8+kTtkOrCG4T/gR+I4pTJVLAMCF+kMoVl/9hjEBGUXP8xEJfbA4zPCfUtll3fuA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199024)(1800799009)(186009)(6512007)(38100700002)(38070700005)(316002)(41300700001)(6916009)(4326008)(2906002)(83380400001)(86362001)(2616005)(26005)(1076003)(8676002)(5660300002)(36756003)(8936002)(71200400001)(66946007)(6506007)(66556008)(6486002)(66446008)(64756008)(66476007)(54906003)(91956017)(76116006)(478600001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?em42eDVqTmN4UTBvaXNWSUFJRkNrdDNEeDRsakRIckZkVjN5alRmc1lSK1k4?=
 =?utf-8?B?QkpaUVROTmllb09rMkFnczI0OHRCVmVicVRrYzNzSE5senpFZ1lJU1F4MHFQ?=
 =?utf-8?B?dlBPSXpCb0hIZmczcVZ0a2pocTNZNWczcWRoaHFMcEVRaGJTVE9ZODRsNFdY?=
 =?utf-8?B?RlZHSFk2c0tXTnZUUmN2MHI0bDdUNy9UV2NyNmQxK3c4a0pER01UR3Bsd2hP?=
 =?utf-8?B?bTRRdVdYR1ZLNXl2bEY4dkMrV0ZrT3hUNXNHRU1aYXVHU3B0VzVta2Vobk9h?=
 =?utf-8?B?VVdUSHBDdC8weWYzVVVRQjdIblZ3S2g5RGx2RGRucXpwWjQ4dmgvSnUvNXh0?=
 =?utf-8?B?dFEyYkZJVHVobVBvaTBLeFZPWUFCMTVNOXAzRnZXcGUrZzlEbkpBM2dPR3Fp?=
 =?utf-8?B?YnR2WkQ0UElCUmZ0NnlGalU2aDNBbnBkamdRM09Pb1pRL0lKeXFoS2JCWGdR?=
 =?utf-8?B?ZFhMK3I5UGdRUnFsU1hlQXhTM2xSbFhHdjJvRGZDWUs0a2hDL3l3b0I5anVv?=
 =?utf-8?B?TStxWjZjVThNZjlybDFSbzYwNmYydjVicXNGMDRLRzl3Y2lUVzFjRndwY1B1?=
 =?utf-8?B?WTQrZDYvVWUzc0lwREJXR3pJVC9YYllPckVyYjd2WTVmb3lJNHptY3VhOXRa?=
 =?utf-8?B?QXNOK25Lc0R0UDRXbTlXRVBzRGU2eVZuczdKL2FjNm1JZ3I2dmNOUEFITlFM?=
 =?utf-8?B?b1JQYWdNeSs0WHN4TStzNnU5U21WVGh5MEhlU0F4L3J2b3FlWU1pLzJqY2RS?=
 =?utf-8?B?NkpxazMxVzVaTENoN0I5NkR3bEJBd3ZvVE9ycnFuaG5yOW9lU3pVcjd4NDEy?=
 =?utf-8?B?N0ZjZVJIUGhwUjZYb0l5amdwZTFocFMzVGxvMzZiNG80RjZKQ1A4S2xUai9u?=
 =?utf-8?B?Vktic21QdkMvSkVTelRkblVnTUQ0Q05id1BSdHhKWG02QVo4SnJBd1kzYk1l?=
 =?utf-8?B?M2JaM2lScE4yT0YwVm42YStSVjllWXEzUXhrb1dSaE5WR3lxenQ4eklpZXd0?=
 =?utf-8?B?anBYUEhjR0ZhVlBhWTNnTnBQbVd3RFltWFlqT2J6c0pmMTQvSTlGMlY1ZXhj?=
 =?utf-8?B?MFFhaVg5TDA3R1NvQW44K1NTeGsxaDI1S3FDaDdlaFpLMkhOb1NWZnR4ZEc0?=
 =?utf-8?B?ZTdXSDBJNTdKTG9QY1BEQkRxRXM1SlN6dHVXWGxLT1Y5WUZXRStRWjIrK3hq?=
 =?utf-8?B?UGRmQS8yUTVUem5RSVNNUVlYZFFMQk1tNTdHRTZWQno1UWkwUU1NSGxjSGM5?=
 =?utf-8?B?cVNtbHZTTzB1aGlVVkQ2WkJhMThzUDVIb001MGg1anFrV0VOTG4xdkhwQjdt?=
 =?utf-8?B?NnF0SkxtdkgzbkJLMjljV3cweDNtQ0F1cXNkcEJacVpaNEF5V1l1ZmZqTzRt?=
 =?utf-8?B?T2xoelJJZGw5SnRyQ0NQRCtrajdIbktOZWlOSXdnZ0dpcDdxK0YxU0pPbEtM?=
 =?utf-8?B?eDlRUG5PN0srbXhxZEx5eExUZ0hJU0puSUw0M3lCcEVHeGdaejhQMll5YzFO?=
 =?utf-8?B?VlFmdk9vQWo1MTlYYWd1QVJZUkRMQnFYaHZldy9HRGtlbHExTW1Bc2xDaXBQ?=
 =?utf-8?B?QitjcDZMa1FhNWR3TEovL3BRNWp3TGZOTnJOS2oyUVZWQ0pzR1ltYjdCUVVw?=
 =?utf-8?B?L0dEd3ZjUjBwd3BoaVhENUk5RWJCQ0ptRkxMczNKU2FGekl1bUU0QzZvYWRk?=
 =?utf-8?B?bGVaanJSQUUwN0VjQnJjbnQ1SnNsQjIzeXhUWk5IQ0taVzFCYWIyK1FGekhN?=
 =?utf-8?B?RkZEL2JzTEF0QWUxY0QwbUNXR2JqRFU2ZmgzT3czUU1SUDR6Z2tlUVRlcnFR?=
 =?utf-8?B?T29Hcm8zNk82cTl6aVh3blVOZHI5YnV6V29tTElZYkMybGpJLzJJZFg1Z0hP?=
 =?utf-8?B?U283bzNYQW00aWxlTWRGVk1zRzhNWno3NGpKc3IwblpiaHI5Ri84TVBGTEg3?=
 =?utf-8?B?cTFvVXh2WmZBV0NKQzJQNEJaZGpHVDVrM1Y0M0l4ZENqR0F4b0Y2MFZGSzFx?=
 =?utf-8?B?dVliaTk1Y3NiNDB4bTNqOUEyb3MrbE1TL2tQWVFYWE9QcVFoV3p3RXpHSlQr?=
 =?utf-8?B?UWw4Vng5alJUc2NmdExIYzE4OEVFQXhpN29wOU1GcGlFNkpoakdKVE9ta2J0?=
 =?utf-8?Q?Gc/BxGrCZbGtCI5LPeQSYgl3x?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <432755E6E10FF94DB75E762E7B6A92A6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SjhsNFNDRGF1cDN4dTFFdG1aMjRXaFBxRUxUb1RsL0Q4NFZwUW9kTjBINjJB?=
 =?utf-8?B?UGYxNFhYa0Z2L1l5TjloMVZqZWFMdjE0QW40WXpKckpqeTdpaDk5eVovNDFr?=
 =?utf-8?B?aE10dWMrTTFUSWZTNVdGdHNxV09JTXRUb05UaTIyRUJmeXdrTXZHa1hKTndN?=
 =?utf-8?B?S0hNL1RvMlFDZWFaczA4Y1dCM3VRaFVudTI4OUlDYzFhOVQxcmZ2dFZrbFYx?=
 =?utf-8?B?ZjFYOW04bDhBOGw1cW5HWEdNQzlSN2Q3Yks0L1FpeENjZWVkbGN1Zmd0c0xE?=
 =?utf-8?B?Yi9pN05xdTNncGFGVXN2WGJhbDNZbFBUVnFSTlFIeDdXelBTb3RKS3NCTThN?=
 =?utf-8?B?eDBnZk42RzZzYWhENk9iR0ppb0k4ZUVIVjJEenJHN084WXFCc0xtLzFnTU1t?=
 =?utf-8?B?OVc2SmswWngwQXYwRnRueExLajFuUjVuTXlEK1F5QWhwQTR3amJ0TFJGckls?=
 =?utf-8?B?bGt3WXRLSWw3OWNkZ2lnUk9WMVJMc3lITkdKS2xEN3Iyd0Q0MDJ4empGWk9i?=
 =?utf-8?B?QWZ4elkwd01LbGdvNTNkYlE2NFc1M3lQVG9Hc1B3dkhSOVB2d2J1UEtFUlBa?=
 =?utf-8?B?SUlRSWFjT3lkcURINUg2bGNXM2dFelVTdzAwMGd0bndMZXZkazgzenZUZVBo?=
 =?utf-8?B?WWtqWVp6V2QzKytHbVdRNFlLMTgza1JqZjhrcVROZ2xCTm13WWdSdmlnMG9L?=
 =?utf-8?B?b04zdUVILzNvMkZxQ2R2VmFZbXkzQVV0cnFKWFlBR0h1R2dnUjZ4MDE4S3Fw?=
 =?utf-8?B?Tjc1L0lvL29SV0ZiSjc2OFR0aFprdXlYcVo3SjVscXM3bks0QWtjV2JuL3Rt?=
 =?utf-8?B?NElWQ25WdGVrcS9jMC8xc3ZFZ3Q2VnRWWm5Sd0RUN2VISTVvZXh0LytDczAw?=
 =?utf-8?B?WGVrQVVRZE9ac2U3SkQ3ZWZ6Q2Z3UTBnRjZpZVMrWGpuYVVnZDB2UnFJcDZ5?=
 =?utf-8?B?OXkvTDRpYUR1WjZ1aDNmVGsvZHZ0RVdSclpTZEpEekZrYXg5elhnSVBSSk5B?=
 =?utf-8?B?emxURWtiYW4rUVlMRzNxd3hnLzloYkE4MGFidk5QWDREd3BrVzFuWVMxbXcr?=
 =?utf-8?B?QmVFYzV1ZUVTRWJvR0dTTHBxQVFmT0RqaHQwWUpvR3QrWElhV05DWHF3S0JL?=
 =?utf-8?B?aS9zdnRVK1J3L2VYV2M2MlRqTkt3SkpuWjZla3REV0x3WlN4anVxRjlkamFv?=
 =?utf-8?B?alZoTTNKai9Gc3NvSUFSMGJxT1Y5Tk0rR1VkSzFJeXhKZEk1YUVVSEprWmhj?=
 =?utf-8?B?VVovLzJQMHJQYytZTmdrTEllNzJlWTVwYVF5cStBU3I5TXhqZz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5b5ba2-b89a-46bb-ee62-08dba8f8f908
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 01:32:28.6123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3tLUM4OtBp7ByNrJiYUihggasQiF3NEKLMpORwJNgM4ZWuGUuFrJ4Shg/MIaKH2/6LFtLzTphWWzJVrX5tmpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004
X-Proofpoint-GUID: HoJVRerjFwTp44nq1OFOOuDdQwTNBm0w
X-Proofpoint-ORIG-GUID: HoJVRerjFwTp44nq1OFOOuDdQwTNBm0w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300012
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBdWcgMjUsIDIwMjMsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IE9uIFNhdCwgQXVnIDI2
LCAyMDIzIGF0IDAxOjIwOjM0QU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBTb3Jy
eSBmb3IgdGhlIGRlbGF5IHJlc3BvbnNlLg0KPiA+IA0KPiA+IE9uIFdlZCwgQXVnIDIzLCAyMDIz
LCBBbGFuIFN0ZXJuIHdyb3RlOg0KPiA+ID4gSW4gdWFzLCBhIC1FUFJPVE8gZXJyb3Igd2lsbCBj
YXVzZSBhbiBlcnJvciBzdGF0dXMgdG8gYmUgcmV0dXJuZWQgdG8gdGhlIA0KPiA+ID4gU0NTSSBs
YXllciwgd2hpY2ggd2lsbCBpbnZva2UgdGhlIFNDU0kgZXJyb3IgaGFuZGxlci4gIEFmdGVyIGVu
b3VnaCANCj4gPiA+IGZhaWx1cmVzIGl0IHdpbGwgY2FsbCB0aGUgdWFzIGRldmljZS1yZXNldCBo
YW5kbGVyLCBhbmQgDQo+ID4gPiB1YXNfZWhfZGV2aWNlX3Jlc2V0X2hhbmRsZXIoKSBjYWxscyB1
c2JfcmVzZXRfZGV2aWNlKCkuDQo+ID4gDQo+ID4gRnJvbSBteSB0ZXN0aW5nIHdpdGggVUFTUCwg
aWYgSSByZWNhbGwgY29ycmVjdGx5LCB0aGVyZSdzIGEgMzAgc2Vjb25kDQo+ID4gdGltZW91dCBi
ZWZvcmUgdGhlIHJlc2V0IGhhbmRsZXIga2lja3MgaW4uDQo+IA0KPiBUaGF0IHRpbWVvdXQgbGVu
Z3RoIGNvbWVzIGZyb20gdGhlIFNDU0kgZXJyb3IgaGFuZGxlci4gIEkgYmVsaWV2ZSB0aGUNCj4g
dXNlciBjYW4gY29udHJvbCB0aGUgbGVuZ3RoIGJ5IHNldHRpbmcgYSBzeXNmcyBhdHRyaWJ1dGUu
ICBBbHNvLCBpdA0KPiBzaG91bGQgYmUgcG9zc2libGUgdG8gY2hhbmdlIHRoZSB1YXMgZHJpdmVy
IHRvIG1ha2UgaXQgcGVyZm9ybSBhIHJlc2V0DQo+IG9uIGl0cyBvd24gcmlnaHQgYXdheSwgdGhl
IHdheSB1c2Itc3RvcmFnZSBkb2VzLCB3aXRob3V0IHdhaXRpbmcgZm9yDQo+IHRoZSBTQ1NJIGVy
cm9yIGhhbmRsZXIgLS0gaWYgdGhpcyBtYXR0ZXJzLg0KDQpTdXJlLCBidXQgbXkgcG9pbnQgaXMg
dGhhdCB0aGUgcmVjb3ZlcnkgZm9yIHRoaXMgaXMgaGFuZGxlZCBkaWZmZXJlbnRseQ0KY29tcGFy
ZWQgV2luZG93cy4gV2luZG93cyB0cmllcyB0byByZWNvdmVyIHdpdGggQ0xFQVJfRkVBVFVSRSho
YWx0X2VwKQ0KYmVmb3JlIGl0IGdldHMgdG8gdXNiIHJlc2V0Lg0KDQo+IA0KPiANCj4gPiBGcm9t
IHRoZSB4SENJIHNwZWMsIGl0IHN1Z2dlc3RzIHRvIGlzc3VlIGEgQ0xFQVJfRkVBVFVSRShoYWx0
X2VwKSBhZnRlcg0KPiA+IHRoZSBlbmRwb2ludCByZXNldCAoZS5nLiBmcm9tIHRyYW5zYWN0aW9u
IGVycm9yKS4gV2hldGhlciB0aGlzIGFjdGlvbg0KPiA+IHNob3VsZCBiZSB0YWtlbiBmcm9tIHRo
ZSBjbGFzcyBkcml2ZXIgb3IgZnJvbSB0aGUgeEhDSSBkcml2ZXIsIGl0J3Mgbm90DQo+ID4gY2xl
YXIuIEhvd2V2ZXIsIGFzIHlvdSBzYWlkLCB3aXRob3V0IEJ1bGstT25seSBNYXNzIFN0b3JhZ2Ug
UmVzZXQNCj4gPiByZXF1ZXN0LCB0aGUgaG9zdCBhbmQgZGV2aWNlIHdpbGwgYmUgb3V0IG9mIHN5
bmMuIFRoZSByZXNwb25zZSBhY3Rpb24NCj4gPiB0YWtlbiBmcm9tIHhIQ0kgaXMgaW5kZXBlbmRl
bnQgZnJvbSBNU0MgcHJvdG9jb2wuIFNvIGl0IHdvdWxkIG1ha2Ugc2Vuc2UNCj4gPiBmb3IgdGhl
IFVEQyBkcml2ZXIgdG8gdHJlYXQgQ0xFQVJfRkVBVFVSRShoYWx0X2VwKSBhcyBzdWNoIGFuZCBu
b3QNCj4gPiBleHBlY3QgYSBCdWxrLU9ubHkgTWFzcyBTdG9yYWdlIFJlc2V0IG9yIHRoZSBlcXVp
dmFsZW50Lg0KPiANCj4gSW4gVVNCLTIsIHBlcmZvcm1pbmcgYW4gZW5kcG9pbnQgcmVzZXQgaW4g
dGhlIGhvc3QgY29udHJvbGxlciB0b2dldGhlcg0KPiB3aXRoIHNlbmRpbmcgYSBDbGVhci1IYWx0
IGlzIGRhbmdlcm91cy4gIEl0IGNhbiBsZWFkIHRvIGRhdGENCj4gZHVwbGljYXRpb24uDQo+IA0K
PiBIZXJlJ3MgaG93IHRoYXQgY2FuIGhhcHBlbi4gIFN1cHBvc2UgdGhlIGRhdGEgdG9nZ2xlcyBv
biBib3RoIHRoZSBob3N0DQo+IGFuZCBnYWRnZXQgc2lkZSBhcmUgaW5pdGlhbGx5IGVxdWFsIHRv
IDAgd2hlbiBhIGJ1bGstT1VUIHRyYW5zYWN0aW9uDQo+IG9jY3VyLiAgVGhlIGhvc3Qgc2VuZHMg
YSBEQVRBMCBwYWNrZXQgd2hpY2ggdGhlIGdhZGdldCByZWNlaXZlcywNCj4gY2F1c2luZyB0aGUg
Z2FkZ2V0J3MgZGF0YSB0b2dnbGUgdG8gY2hhbmdlIHRvIDEuICBCdXQgbGV0J3Mgc2F5IHRoZQ0K
PiBnYWRnZXQncyBBQ0sgaGFuZHNoYWtlIGdldHMgY29ycnVwdGVkLCBjYXVzaW5nIGEgcHJvdG9j
b2wgZXJyb3Igb24gdGhlDQo+IGhvc3QuICBTbyB0aGUgaG9zdCBkb2VzIGFuIGludGVybmFsIGVu
ZHBvaW50IHJlc2V0IGFuZCBzZW5kcyBhDQo+IENsZWFyLUhhbHQgdG8gdGhlIGdhZGdldC4gIFdo
ZW4gdGhlIGdhZGdldCBwcm9jZXNzZXMgdGhpcyBjb21tYW5kLCBpdA0KPiByZXNldHMgaXRzIGRh
dGEgdG9nZ2xlIGJhY2sgdG8gMC4gIE5vdyB0aGUgaG9zdCByZXNlbmRzIHRoZSBzYW1lIERBVEEw
DQo+IHBhY2tldCBhcyBiZWZvcmUgLS0gYW5kIHRoZSBnYWRnZXQgYWNjZXB0cyBpdCB0aGUgc2Vj
b25kIHRpbWUgYmVjYXVzZQ0KPiBpdHMgZGF0YSB0b2dnbGUgaXMgc2V0IHRvIDAhICBUaGUgZHVw
bGljYXRlZCBkYXRhIGxlYWRzIHRvDQo+IGNvcnJ1cHRpb24uICBJZiB0aGUgZ2FkZ2V0J3MgZGF0
YSB0b2dnbGUgaGFkIHJlbWFpbmVkIDEgdGhlbiBpdCB3b3VsZA0KPiBoYXZlIGFja25vd2xlZGdl
ZCB0aGUgZHVwbGljYXRlIERBVEEwIHBhY2tldCBidXQgb3RoZXJ3aXNlIGlnbm9yZWQgaXQsDQo+
IGF2b2lkaW5nIHRoZSBjb3JydXB0aW9uLg0KPiANCj4gSSBhZG1pdCB0aGUgcHJvYmFiaWxpdHkg
b2YgdGhpcyBoYXBwZW5pbmcgaXMgdmVyeSBsb3csIGJ1dCBhIG1vcmUNCj4gcm9idXN0IGVycm9y
IHJlY292ZXJ5IHByb2NlZHVyZSBhdCB0aGUgY2xhc3MgbGV2ZWwgd291bGQgcHJldmVudCB0aGlz
DQo+IHNjZW5hcmlvLg0KPiANCg0KVGhpcyBhY3R1YWxseSBhbGwgdGhlIG1vcmUgdGhhdCB3ZSBz
aG91bGQgbm90IHNpbGVudGx5IGlnbm9yZQ0KQ0xFQVJfRkVBVFVSRShoYWx0X2VwKSBhbmQgZGVw
ZW5kIG9uIHRyYW5zZmVyIHRpbWVvdXQgYW5kIHVzYiByZXNldC4NCg0KVGhhdCByZW1pbmRzIG1l
IGFub3RoZXIgdGhpbmcsIGlmIHRoZSBob3N0ICh4aGNpIGluIHRoaXMgY2FzZSkgZG9lcyBhDQpo
YXJkIHJlc2V0IHRvIHRoZSBlbmRwb2ludCwgaXQgYWxzbyByZXNldHMgdGhlIFRSQiBwb2ludGVy
IHdpdGggZGVxdWV1ZQ0KZXAgY29tbWFuZC4gU28sIHRoZSB0cmFuc2ZlciBzaG91bGQgbm90IHJl
c3VtZS4gSXQgbmVlZHMgdG8gYmUNCmNhbmNlbGxlZC4gVGhpcyB4SENJIGJlaGF2aW9yIGlzIHRo
ZSBzYW1lIGZvciBXaW5kb3dzIGFuZCBMaW51eC4NCg0KPiANCj4gPiA+ID4gVGhlIFVEQyBkcml2
ZXIgbmVlZHMgdG8gbm90aWZ5IHRoZSBnYWRnZXQgZHJpdmVyIHNvbWVob3csIGNhbmNlbGxpbmcg
dGhlDQo+ID4gPiA+IHJlcXVlc3QgYW5kIGdpdmUgaXQgYmFjayBpcyBjdXJyZW50bHkgdGhlIHdh
eSBkd2MzIGhhbmRsaW5nIGl0Lg0KPiA+ID4gDQo+ID4gPiBBbmQgSSdtIHNheWluZyB0aGF0IHRo
ZSBVREMgZHJpdmVyIGRvZXMgX25vdF8gbmVlZCB0byBub3RpZnkgdGhlIGdhZGdldCANCj4gPiA+
IGRyaXZlci4NCj4gPiA+IA0KPiA+ID4gVGhlIE1TQyBnYWRnZXQgZHJpdmVyIHdvcmtzIGp1c3Qg
ZmluZSB3aXRob3V0IGFueSBzdWNoIG5vdGlmaWNhdGlvbi4gIA0KPiA+ID4gQ2FuIHlvdSBuYW1l
IGFueSBnYWRnZXQgZHJpdmVyIHRoYXQgX2RvZXNfIG5lZWQgYSBub3RpZmljYXRpb24/DQo+ID4g
PiANCj4gPiANCj4gPiBXZSB3ZXJlIHRlc3RpbmcgYWdhaW5zdCBVQVNQLiBUaGUgcmVhc29uIEkg
YWRkZWQgdGhpcyB3YXMgdG8gbWltaWMgdGhlDQo+ID4gYmVoYXZpb3Igb2YgY29tbW9uIHZlbmRv
ciBVQVNQIGRldmljZXMgd2hlbiBpdCByZWNvdmVycyBmcm9tIHRyYW5zYWN0aW9uDQo+ID4gZXJy
b3JzIGluIFdpbmRvd3MuDQo+ID4gDQo+ID4gV2hlbiB0aGUgZGF0YSBzZXF1ZW5jZSBvZiBhIHRy
YW5zZmVyIGlzIHJlc2V0LCB0aGUgaG9zdCBuZWVkcyB0byBzZW5kDQo+ID4gQ0xFQVJfRkVBVFVS
RShoYWx0X2VwKS4gSXQgc2hvdWxkIGJlIGEgY29tbW9uIGJlaGF2aW9yLiBTaW5jZSBpdCBpcw0K
PiA+IGNvbW1vbiBhbmQgcGFydCBvZiB0aGUgeEhDSSBzcGVjLCBkbyB3ZSBleHBlY3QgdGhlIHhI
Q0kgdG8gc2VuZCB0aGlzIG9yDQo+ID4gZG8gd2UgZXhwZWN0IHRoZSBjbGFzcyBwcm90b2NvbCB0
byBkb2N1bWVudCBhbmQgaGFuZGxlIHRoaXM/IEF0IHRoZQ0KPiA+IG1vbWVudCwgSSBleHBlY3Qg
aXQgdG8gYmUgdGhlIGZvcm1lciBhbmQgZXhwZWN0IHRoZSBVREMgZHJpdmVyIHRvIHRyZWF0DQo+
ID4gaXQgYXMgYSBjb21tb24gc3luY2hyb25pemF0aW9uIHRoYXQgcGVyaGFwcyB0aGUgb25seSBz
eW5jaHJvbml6YXRpb24NCj4gPiBtZWNoYW5pc20gdGhlIHVwcGVyIHByb3RvY29sIGRlcGVuZHMg
b24uDQo+IA0KPiBJIHRoaW5rIGl0IHNob3VsZCBiZSB0aGUgb3Bwb3NpdGU7IHRoZSBjbGFzcyBw
cm90b2NvbCBzaG91bGQgc3BlY2lmeQ0KPiBob3cgdG8gcmVjb3ZlciBmcm9tIGVycm9ycy4gIElm
IGZvciBubyBvdGhlciByZWFzb24gdGhlbiB0byBhdm9pZCB0aGUNCj4gZGF0YSBkdXBsaWNhdGlv
biBwcm9ibGVtIGZvciBVU0ItMi4gIEhvd2V2ZXIsIGlmIGl0IGRvZXNuJ3Qgc3BlY2lmeSBhDQo+
IHJlY292ZXJ5IHByb2NlZHVyZSB0aGVuIHRoZXJlJ3Mgbm90IG11Y2ggZWxzZSB5b3UgY2FuIGRv
Lg0KDQpSaWdodCwgdW5mb3J0dW5hdGVseSB0aGF0J3Mgbm90IGFsd2F5cyB0aGUgY2FzZSB0aGF0
IGNsYXNzIHByb3RvY29sDQpzcGVsbCBvdXQgaG93IHRvIGhhbmRsZSB0cmFuc2FjdGlvbiBlcnJv
ci4NCg0KPiANCj4gQnV0IHJlZ2FyZGxlc3MsIGhvdyBjYW4gdGhlIGdhZGdldCBkcml2ZXIgbWFr
ZSBhbnkgdXNlIG9mIHRoZQ0KPiBrbm93bGVkZ2UgdGhhdCB0aGUgVURDIHJlY2VpdmVkIGEgQ2xl
YXItSGFsdD8gIFdoYXQgd291bGQgaXQgZG8NCj4gZGlmZmVyZW50bHk/ICBJZiB0aGUgaW50ZW50
IGlzIHNpbXBseSB0byBjbGVhciBhbiBlcnJvciBjb25kaXRpb24gYW5kDQo+IGNvbnRpbnVlIHdp
dGggdGhlIGV4aXN0aW5nIHRyYW5zZmVyLCB0aGUgZ2FkZ2V0IGRyaXZlciBkb2Vzbid0IG5lZWQg
dG8NCj4gZG8gYW55dGhpbmcuDQoNCkl0J3Mgbm90IHNpbXBsZSB0byBjbGVhciBhbiBlcnJvci4g
SXQgaXMgdG8gbm90aWZ5IHRoZSBnYWRnZXQgZHJpdmVyIHRvDQpjYW5jZWwgdGhlIGFjdGl2ZSB0
cmFuc2ZlciBhbmQgcmVzeW5jIHdpdGggdGhlIGhvc3QuIFRoaXMgaXMgb2JzZXJ2ZWQgaW4NClVB
U1AgZHJpdmVyIGluIFdpbmRvd3MgYW5kIGhvdyB2YXJpb3VzIGNvbnN1bWVyIFVBU1AgZGV2aWNl
cyBoYW5kbGUgaXQuDQpUaGVyZSBubyBlcWl2YWxlbnQgb2YgQnVsay1Pbmx5IE1hc3MgU3RvcmFn
ZSBSZXNldCByZXF1ZXN0IGZyb20gdGhlDQpjbGFzcyBwcm90b2NvbC4gV2Ugc3RpbGwgaGF2ZSB0
aGUgVVNCIGFuYWx5emVyIHRyYWNlcyBmb3IgdGhpcy4NCg0KPiANCj4gQWx0ZXJuYXRpdmVseSwg
aWYgdGhlIHByb2NlZHVyZSBmb3IgY2xlYXJpbmcgYW4gZXJyb3IgY29uZGl0aW9uIGlzDQo+IGdp
dmVuIGJ5IHRoZSBjbGFzcyBwcm90b2NvbCB0aGVuIHRoZSBwcm90b2NvbCBzaG91bGQgc3BlbGwg
b3V0IGENCj4gbWV0aG9kIGZvciB0aGUgaG9zdCB0byBpbmZvcm0gdGhlIGdhZGdldCBhYm91dCB3
aGF0IGl0IGlzIGRvaW5nIC0tDQo+IHNvbWV0aGluZyBtb3JlIHRoYW4ganVzdCBzZW5kaW5nIGEg
Q2xlYXItSGFsdC4NCj4gDQoNClJlZ2FyZGxlc3Mgd2hldGhlciB0aGUgY2xhc3MgcHJvdG9jb2wg
c3BlbGxzIG91dCBob3cgdG8gaGFuZGxlIHRoZQ0KdHJhbnNhY3Rpb24gZXJyb3IsIGlmIHRoZXJl
J3MgdHJhbnNhY3Rpb24gZXJyb3IsIHRoZSBob3N0IG1heSBzZW5kDQpDTEVBUl9GRUFUVVJFKGhh
bHRfZXApIGFzIG9ic2VydmVkIGluIFdpbmRvd3MuIFRoZSBnYWRnZXQgZHJpdmVyIG5lZWRzDQp0
byBrbm93IGFib3V0IGl0IHRvIGNhbmNlbCB0aGUgYWN0aXZlIHRyYW5zZmVyIGFuZCByZXN5bmMg
d2l0aCB0aGUgaG9zdC4NCg0KT2YgY291cnNlIHdlIGNhbiBqdXN0IHdhaXQgZm9yIHRoZSBob3N0
IHRvIHRpbWVvdXQgdGhlIHRyYW5zZmVyIGFuZA0KaXNzdWUgYSB1c2IgcmVzZXQuIFdoaWxlIEkg
YWdyZWUgdGhhdCB0aGUgY2xhc3MgcHJvdG9jb2wgc2hvdWxkDQpzcGVsbCBvdXQgZXZlcnl0aGlu
ZywgaXQgbWF5IG5vdCBhbHdheXMgYmUgdGhlIGNhc2UuIEFuZCBJIHRoaW5rIFVEQw0KZHJpdmVy
IHNob3VsZCBiZSBoYW5kbGVkIHRoaXMgd2F5IHRvIGludGVyLW9wIHdpdGggd2luZG93cy4NCg0K
QlIsDQpUaGluaA==
