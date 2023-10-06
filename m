Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2877BBE32
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjJFR6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjJFR6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:58:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60591F2;
        Fri,  6 Oct 2023 10:58:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396Cc7lq028597;
        Fri, 6 Oct 2023 17:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=aGfMkQuWdv/Ir7KQs7cMvk6lOthfDCX1iwTXvQERxKc=;
 b=NJlu9cgu1Snxb8DvvPwKsE8f1rs/tiu6YEz0o/ng/lFacU6qc4MidWk892D8RIacLL0n
 ltJyyQiUctfFxwR6Cb62a74RFZ+keQKYKDSAlz1UE84EHxB4nSa+OrgNW2x/J6uttex8
 eMwb8RU+88fGzDfodmwp2+0z+nfsME75qTFwG1HB6bROwqFDVIjsHg8NY/AZHFDMSR8S
 Ry0QyYncH8qSEgAVsMAjTdG5yt/NTkjYx4T02plCLgDQeHvXsOfNYazZyO5f4uoVN0DK
 ga9k/iUmZT0F8Qk29dxEW6c7jVRUiIDLUWrVcgp66XbGjpnGQYlcVBUYZHI4EBENIaY/ lg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3emeaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 17:57:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 396HUNHo033707;
        Fri, 6 Oct 2023 17:57:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4b848m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 17:57:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPXzKDvrXmw+S7EsgA/VOgg3dohkDk1CaL6BOBSMuwiWDqNV/VkROdnGRie5W6T1NTar1tRk37sywWoOguM/+bfJxVPLfVFsIvqljtmn8DcC5EPmhmhtKPfA127aHSnzt+yDlpPaiSm+weBHI/+3j/8Z7NIMiarEZARLpNtrQbXQ+8nIh97Q+X/D04iygmxSk2Xb3BMT8sc4N720/wl+74JiUh7W6B4UwDp6RzAmgcdXSQTFXKToU2JNCcTnlbEfO1A02ZWMaQA3Pzte1tNG10w8+eAcRlWZo3wD4coEip+vU+heYFWDzHrLqsiITYMqiANJ6Is557lE3b036QjPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGfMkQuWdv/Ir7KQs7cMvk6lOthfDCX1iwTXvQERxKc=;
 b=gNui3xiEEKsaVoc4uZbryiuMjKB5qrR99ULj3WrEG/m2XufLWVa7j9GrSIgUI+mlbx470OdHCuzVRT3dlhdlXmvzo/vvdgha/HQUMdDvK1ReXM+NJBrBvkF433R2ZK3Qbzj2IRgHnMD4uvffGV7v38MiK4BsXH63EAXJi3tUNhQlG+SDatuAvRYEpyYsEM5XrlD0WoRGnXrHRlliIUjiHzN9gl5HZK6rerX1Oev+T/AR3+fB5ZHd+61SK3VhZ1J1h9h5/TfKFkjmx2H1Izr7eeN40NNjBIQqigvzJhQCE5gC0vOGVvWG5NSPQwMrybeQYQeIWxmhTQOMKnT/sn86LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGfMkQuWdv/Ir7KQs7cMvk6lOthfDCX1iwTXvQERxKc=;
 b=abMgBxHs2Z1eI0+P9WDcPKUPctINahR9YULGC4/MvD2j68fEW3d6CDRRQ0gDwfCn2DXfGQ8FHcK+fC5ak4eBeLZ4LMLeKI/l793uLfosgAjcEM/DQYLxu/2VC6rakBo3YEk3BKM5HSA/ijHyH7QquHtY2jun8/MIP2l0ladXV+M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB5078.namprd10.prod.outlook.com (2603:10b6:408:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.36; Fri, 6 Oct
 2023 17:57:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 17:57:18 +0000
Date:   Fri, 6 Oct 2023 13:57:14 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ovidiu Panait <ovidiu.panait@windriver.com>,
        Ingo Molnar <mingo@kernel.org>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 5.15 000/183] 5.15.134-rc1 review
Message-ID: <20231006175714.begtgj6wrs46ukmo@revolver>
References: <20231004175203.943277832@linuxfoundation.org>
 <CA+G9fYunnEUT2evdabX1KOTiryP1heNHWDH4LWZCt2SVRmnKOA@mail.gmail.com>
 <20231006162038.d3q7sl34b4ouvjxf@revolver>
 <57c1ff4d-f138-4f89-8add-c96fb3ba6701@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <57c1ff4d-f138-4f89-8add-c96fb3ba6701@paulmck-laptop>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0048.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BN0PR10MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: ea00f79e-0ee8-49c4-14ea-08dbc695ae66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PwN/R+8iV+OjxCiMNHfjvx5X6U1l2RAi6T6ca1pRf5EMRS7Q9dao7qTG3RQDLDc8fWlC3tsPwUtJvv9m8NQPwivKZGtoEoXZuDqj2J2uoXNiX13q7kXSVvrEIj7jZKwjtBCprhMuU2f7z6jjpnz3lH7dI98/uikQPTTjcVxkSzX+i/lNxwsCWqzLOi+CM8yYeG5wXM8JvIF2f2yl7CxZn6MKoLHa247JWWVRIGLiiZM6ERbPIxkyK8i+hEGCiGUbjF2jG4+k21L/oUiNJqi3CZIqQxx5e5pOkBwr7wUBrFmKGMkJLBGes3EO5Hd15VYWmr5euD5bHLY/qVWPS/08bWBMdicSXrhAkTsWaqdNhRwsV+6YtQr6iigmPvyPWAjptTFRv09S7c0WCleu+jMAmzD4YobHC6AQpX9A6xihifXcaROCXSjAZRS+NEDInpQMCQHUs5HWhd5DyFmLb8s48r9xCbZj5cfncjsqD1kOY9w7aAwmq36LhqkQltuazO+wrYojh2+1IjkU9P8gmNiYXfrfKtcD/odtgW/Ue1VdNq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(7416002)(5660300002)(8936002)(8676002)(2906002)(4326008)(41300700001)(316002)(66946007)(6916009)(66556008)(66476007)(54906003)(33716001)(6666004)(1076003)(26005)(6506007)(38100700002)(6512007)(9686003)(83380400001)(6486002)(966005)(86362001)(45080400002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHpGa2ZFckE3SGtySDRWdWJJMDNQYnFxNE1hNnBlTi9ESTN6T2lVNi8xalhm?=
 =?utf-8?B?VUFUNnV3UE51Q3FLZnpqTnJVK2xMc2VCUXE5K1RKRjB4L3lBWldBNHpVNU00?=
 =?utf-8?B?MEhVaEZaMS8xWjJjWWswZEhvcEcyTXUvMWFZTTcvOXh5WWRrZUtFMmF1TlQv?=
 =?utf-8?B?MDRlZ3dPZjZRcGY3Qk84T0ZlcnpzL3hFdWE0eTFxKzVRMk5PREk4dy8xblNx?=
 =?utf-8?B?dHFvTFNuVnNBTG9idWR0S2h3NWh1WTQ0ZFRvMHFwUi9ZTDJEcDhwMnd4M0VB?=
 =?utf-8?B?RVhSb1pkWXkzZ2JlZkkrRlROeHZBUCs0TWRoYUlYRVNUbWVVMW5yV1pzTkVq?=
 =?utf-8?B?N0NUUlJsNGlxTjFnRTYzR28yOHJkaStzd1BTK3FLdFM2V1A2OG5FYUpxLysr?=
 =?utf-8?B?ZUJlbEp2SkhQZ2c4M0Q1ajdGYXlCNm9SWXJQZWk0aVBleWN2NzFFaHB4MjM3?=
 =?utf-8?B?NHJkRHlsU3JKUGZIZGZGWGFudFB3TDcvYU1ycytmaHdnTVBtZzdnUlJBaDhu?=
 =?utf-8?B?WFpqeVVjT2JqOTFaOHF4UlFpcnUycXhmYlNwWDFvVUpyVHd0Tzh6aGVtNi9W?=
 =?utf-8?B?eVBzVkV3L05UdDVValI4UHZuSmFkRUtLak0yUkNGYm9pbjFVRVN3QlBKZWJp?=
 =?utf-8?B?RnhEZURXQTluMGd3Rjk5U3RUL3NJQWdyZDg1ZTNBK2ZrL1VwTUJSck5iRG9X?=
 =?utf-8?B?YUw5bXMxSW5PUjZHNG9tTjFlNVp0NVA3VHY2VnIzYnFWTzFSNGs5cit0QjY4?=
 =?utf-8?B?L0w4U1VmTVdtbDZjblFnSjEwaUhtYXducWZFQWhiS2cvRFhYNlBwNFp6YURZ?=
 =?utf-8?B?cWVvTStCZlkwVzVPeU4rMndERE9KaDhNMHhHSURFZTFLUW9rdmV5K016dWhk?=
 =?utf-8?B?Q1dQUnBnbmdIL2RhKzc0TmxuOW9ZanR2ajVFWkJUSWI1eklEMDh2MEtQRzlk?=
 =?utf-8?B?YTFCZ2JxWVU5cnVFUlN3YmFnZFRPSlV5UHk4MzFGU3pTS1lqSEtmdWdJckRl?=
 =?utf-8?B?Qm8rOXYwajQ5bUlubDRNbXhyZ0pTNmRzSlNaaXc0MnFoZlBhRmZOWmRjTHFU?=
 =?utf-8?B?U2plcGR1L2t4b1lJb0lKQjRBczlRc1hGSGVGTC85ZXJCbkJhakJZM1NQTmJ3?=
 =?utf-8?B?bi9HRmI1U2JGaXkrWEJWRjV4TDBvWElMd0dRSDgvSnMydnJwRWkzanFqQ1VY?=
 =?utf-8?B?Y1FaWUZvN3VHcWJZQko2UUxBQjFJZHdyQXZKVms2OVVmRUVSUHRTSE5VUWsw?=
 =?utf-8?B?TWRjYUJBaHAvWHRWalNiTG8wcGhlV3VUN0N1REovMVdmVzFVSEJrMjJmdGxx?=
 =?utf-8?B?b3hmcElCSXJDaVdpUHZ3NE43SWRFb2ltZG0zRkN6WXlsMFRXRWNUMkpjRWZh?=
 =?utf-8?B?MXdwWndsdmF0Y3BzYzJTSU9tZGFTTFZaUGxyODFTNDZHbjJ4ZWxkdXhZSU5U?=
 =?utf-8?B?a2oyQU01RnJFczZ4dDN4K3V6RFRJM3VVVHVQaGVkUTQzdnMydm9XclZ4dG1W?=
 =?utf-8?B?VXZBNExWYmNyL2VNU3ZGdkZIWUN4dzEwemcxYVJzTURTWGwvOFIybXQwRVQr?=
 =?utf-8?B?MjZZeEl3V1ZEdnlFSHVWOGQvSW5BUm5SWnBDSmV6WVAwdjhKSXR1OFVqMi9v?=
 =?utf-8?B?Y2lHd0pVYmpwVzRveFVFOE5ISDYyWHkxY3lRMjQ5T3NTSkhKL1Y0N3ZvMUNm?=
 =?utf-8?B?WElyZHErelUwRytZNktHRXdwL0FDalRpMndmQzFwWDArclp1bk84VFMzODJp?=
 =?utf-8?B?TXZmdUFlRlYvOGF2NTdaZ2F2OWtLc2kxejFYMGU3dUZvZklyNWVEZk05ZFQ2?=
 =?utf-8?B?WnNIUFVQc1p5YnJjYnpsaGVGQlczTFpUNXljQyt4Slo3enJwbVFobHdwTWVH?=
 =?utf-8?B?TWUzQWJLWDBKZHNCbjJLd1VYa1dpbFp5TUJTQjVpRWlSK0gwdnhubXNhbHN6?=
 =?utf-8?B?bys4UXlTQk04R0FJTFVmaUtFRFA0eG03U2N0bWVlWi9kU3d2cHlNcGhRaGxk?=
 =?utf-8?B?b0wxcXJjNkZqc3dYWmJ0cTZaaitKMC9ibnhzZElVQ1FRUFdRc3Nob0hOdWpy?=
 =?utf-8?B?bFpYVmNYZDVRMjRzK1hYN1llVkQrZE9qZ0lEOTY5Q1B1NG9ZQ0dUbk9PcTVQ?=
 =?utf-8?Q?biif3Y6rxWgMhMOgkpg0/Z/dp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cG1ZbzgwR0xpbjF3Nm1yVlVEL1MyY0dUWFlyS3JLNmx2R0pYNVFadldUdFdi?=
 =?utf-8?B?dnVrQStia2VyN3Q1VnVJV1VaWE1hUkRPS29QMExwaVBuek51UlZBNS9rV0ZP?=
 =?utf-8?B?T0hKY01Vbk1DTU5KTkJObWdodGdpZWtKUkNCbmZHYmdPb2l6dlhjVUoxQzUw?=
 =?utf-8?B?ZzVoQ29oOFUrckFhcU5SeHdxV0VhZUxodFB6V2F0M0x6bVVXR3Mrb20xa3lZ?=
 =?utf-8?B?eEFtT1BlZTJwK05ZdnRBYVJsRkpzaThhMlpUQlRLam85eWFpQWJIa0Z0ZWk2?=
 =?utf-8?B?SUNkNXJNbGw3WWE3akVXOGlaazYrTXRBbTA2UncydWFaeFlFeTZkZmR5eTZk?=
 =?utf-8?B?Q1FJMjEwTnJxZ0ZvTllpck5Gdlg3WWIwMEpTc2IyNmd4aTBNTWJYRGRaQm1Z?=
 =?utf-8?B?Nlk1YllSL2phVUFBYmlWdGFVbHpLQ2FZR3JCdWExSnNDd0kxMFhnTkw0Nmxr?=
 =?utf-8?B?a2xIRjNIcXJZckVpYlpXcFl5SFNzN0VNRDQ0YmtwSzhUdCt6eVF6QjVSU0dB?=
 =?utf-8?B?UjdoUXM4YUdlT3lWaS9XRGdoT05MZzZKSG9wUUIrOG91ci9BUXo4V3grMXR2?=
 =?utf-8?B?ZUN4SUw3OXNPdXRFcVhEY2dqQUdKTEthUURISXMyYmdVdURRZnB2UGRjSUQr?=
 =?utf-8?B?bldsUHo2U3JBS29sUHlVTkYrcTdob0FGR0x6eGR2OHZjdEUxY3VGL0NNdkla?=
 =?utf-8?B?YXQ5RFpMTktQc3BQcUZ4SmRKbW9MWk1XbklWQ2hIUEwra0NtNzFJcTZ3Sll5?=
 =?utf-8?B?OVVnSm9NKzYzdzBoSnF1MDVlK1FTNnF3aHh3VWtSRk1XczhSVkQxN1llZ0ls?=
 =?utf-8?B?dXUxajBzTHVxSEFOVmhScCt5RnRWWVV6aXpEU1JUdk1YTmk4amI4NVBsNDZN?=
 =?utf-8?B?Y3p4K1d6SGd3VWZ5dmk4MEFTK21VbHA0UThPeEpFT21PQ1p4bU5LQ2NWc1Fz?=
 =?utf-8?B?dXhkTk9RWDB1Mm9TMnkxSFhlOXhWRW0vNmxUaFVBQXozbU0vUzlpaW9EZWh2?=
 =?utf-8?B?a1lrQytZVys2TjFyM083UFd3S1YwU2N0MHUwZnJRRXZmRWdkWFpJdEIvYUJT?=
 =?utf-8?B?Ym1hbkpZL3RPK2JBMlZ6MWZLeC80YitjaHhwTFVxalRpWjhob285VDZaYzVj?=
 =?utf-8?B?b0IxbVNuYy9MWjZKNE1GMWdKMWdqY0pMK0IrV21rcmNtMyt2RXEzODhKWTIr?=
 =?utf-8?B?dzhxZlU1ZkdUSE1UVThoVWh5OTAxZHA0VzBmcHEzdS9HTWxoZzJUZTczbG1a?=
 =?utf-8?B?WmVkY2pVRlZWb2hEOEtibEQyTk9BK0trYjhHSWU0K2Z1Nnd0U2tUbmR5bmZI?=
 =?utf-8?B?N1BjNUpWY1RRYVI5bVBIaitPSlI2bHVTVDlHMGRHVDNRbTdkOUVHeE1jQ1JY?=
 =?utf-8?B?RHJ4bWRqZ2dKb2N5Zml5ZitKNWRsaHl5TG1teEJaa1J4a25LcUpVYTB3WVVs?=
 =?utf-8?B?dlBHNC9qbDFYUjlQZzl4NUxzYmcxU292b3lLeUhqMlVlaGJDcGYwSlZ5QzFZ?=
 =?utf-8?B?MDVFQXZERERwK0tlVEZLUDhyZmRmRlRBUWV4aVlHUW9yNnVGVjJ1VS9ZYXlJ?=
 =?utf-8?B?Z1RWTkFKVGZGS2F6cjdtRzhybjd2N3FuR2pqd0RlcSt6ZXdOa0N2RUEzRVFN?=
 =?utf-8?B?ZVFlYlJVNmpKY3Zxdm8vbmhZWlVMSWRuWWdORmxVbW1oclBjSElhQU9KaWRX?=
 =?utf-8?B?bUR0MFNmVlpLMlVxVS9aZDE3aUZwUDV0N25wWDVsWElIdTVoNzAxOEMvenZw?=
 =?utf-8?B?Y25uM1BSd3l6eVlrV1ZWdkUxOGhGbmltQmczWVg2OFp2MW1oSmpFVm1zdlIv?=
 =?utf-8?B?enJ0RkJzL0JRMmxUbllnVHU1L2NhbkdtdXpRcThadCt5K2NibDFnbERxOUpQ?=
 =?utf-8?Q?ZJOj8O97UYl5D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea00f79e-0ee8-49c4-14ea-08dbc695ae66
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 17:57:18.5466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vhVDnxol5dwNZVaIVjfaXJJzAV/yvbCFvgxvLT61QBWke6DFuKWusLNIFG2BJTKt4NnAnmbPanfI5Cn2oNnDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_14,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060134
X-Proofpoint-ORIG-GUID: KkEkEWlFZd_wuTlDf5u0Dx9N0hUtU5fG
X-Proofpoint-GUID: KkEkEWlFZd_wuTlDf5u0Dx9N0hUtU5fG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul E. McKenney <paulmck@kernel.org> [231006 12:47]:
> On Fri, Oct 06, 2023 at 12:20:38PM -0400, Liam R. Howlett wrote:
> > * Naresh Kamboju <naresh.kamboju@linaro.org> [231005 13:49]:
> > > On Wed, 4 Oct 2023 at 23:33, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > This is the start of the stable review cycle for the 5.15.134 relea=
se.
> > > > There are 183 patches in this series, all will be posted as a respo=
nse
> > > > to this one.  If anyone has any issues with these being applied, pl=
ease
> > > > let me know.
> > > >
> > > > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/=
patch-5.15.134-rc1.gz
> > > > or in the git tree and branch at:
> > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable-rc.git linux-5.15.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >=20
> > > Results from Linaro=E2=80=99s test farm.
> > > Regressions on x86.
> > >=20
> > > Following kernel warning noticed on x86 while booting stable-rc 5.15.=
134-rc1
> > > with selftest merge config built kernel.
> > >=20
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >=20
> > > Anyone noticed this kernel warning ?
> > >=20
> > > This is always reproducible while booting x86 with a given config.
> >=20
> > >From that config:
> > #
> > # RCU Subsystem
> > #
> > CONFIG_TREE_RCU=3Dy
> > # CONFIG_RCU_EXPERT is not set
> > CONFIG_SRCU=3Dy
> > CONFIG_TREE_SRCU=3Dy
> > CONFIG_TASKS_RCU_GENERIC=3Dy
> > CONFIG_TASKS_RUDE_RCU=3Dy
> > CONFIG_TASKS_TRACE_RCU=3Dy
> > CONFIG_RCU_STALL_COMMON=3Dy
> > CONFIG_RCU_NEED_SEGCBLIST=3Dy
> > # end of RCU Subsystem   =20
> >=20
> > #
> > # RCU Debugging
> > #
> > CONFIG_PROVE_RCU=3Dy
> > # CONFIG_RCU_SCALE_TEST is not set
> > # CONFIG_RCU_TORTURE_TEST is not set
> > # CONFIG_RCU_REF_SCALE_TEST is not set
> > CONFIG_RCU_CPU_STALL_TIMEOUT=3D21
> > CONFIG_RCU_TRACE=3Dy
> > # CONFIG_RCU_EQS_DEBUG is not set
> > # end of RCU Debugging
> >=20
> >=20
> > >=20
> > > x86 boot log:
> > > -----
> > > [    0.000000] Linux version 5.15.134-rc1 (tuxmake@tuxmake)
> > > (x86_64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
> > > for Debian) 2.40) #1 SMP @1696443178
> > > ...
> > > [    1.480701] ------------[ cut here ]------------
> > > [    1.481296] WARNING: CPU: 0 PID: 13 at kernel/rcu/tasks.h:958
> > > trc_inspect_reader+0x80/0xb0
> > > [    1.481296] Modules linked in:
> > > [    1.481296] CPU: 0 PID: 13 Comm: rcu_tasks_trace Not tainted 5.15.=
134-rc1 #1
> > > [    1.481296] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> > > 2.5 11/26/2020
> > > [    1.481296] RIP: 0010:trc_inspect_reader+0x80/0xb0
> >=20
> > This function has changed a lot, including the dropping of this
> > WARN_ON_ONCE().  The warning was replaced in 897ba84dc5aa ("rcu-tasks:
> > Handle idle tasks for recently offlined CPUs") with something that look=
s
> > equivalent so I'm not sure why it would not trigger in newer revisions.
> >=20
> > Obviously the behaviour I changed was the test for the task being idle.
> > I am not sure how best to short-circuit that test from happening during
> > boot as I am not familiar with the RCU code.
>=20
> The usual test for RCU's notion of early boot being completed is
> (rcu_scheduler_active !=3D RCU_SCHEDULER_INIT).
>=20
> Except that "ofl" should always be false that early in boot, at least
> in mainline.

Is this still true in the final version of the patch where we set the
boot task as !idle until just before the early boot is finished?  I
wouldn't think of this as 'early in boot' anymore as much as the entire
kernel setup.  Maybe we need to shorten the time we stay in !idle mode
for earlier kernels?

How frequent is this function called?  We could check something for
early boot... or track down where the cpu is put online and restore idle
before that happens?

>=20
> > It's also worth noting that the bug this fixes wasn't exposed until the
> > maple tree (added in v6.1) was used for the IRQ descriptors (added in
> > v6.5).
>=20
> Lots of latent bugs, to be sure, even with rcutorture.  :-/

The Right Thing is to fix the bug all the way back to the introduction,
but what fallout makes the backport less desirable than living with the
unexposed bug?


Thanks,
Liam

