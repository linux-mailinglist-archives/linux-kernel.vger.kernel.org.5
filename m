Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9867BBC97
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjJFQWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjJFQWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:22:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA069A6;
        Fri,  6 Oct 2023 09:22:01 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396Cc3Pg015212;
        Fri, 6 Oct 2023 16:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=Nfp4YBOt9uz99RUA5OuBNdMsWmGgRBy54nRkbQJfsIg=;
 b=QGIn9jYEVmCiS5mRmiuxEI4cux67GibH8+nLXh7/dnVtPdT8aIg8sIF06phDXuRjpnwP
 PZ98gmkDnXbJWfYQE5zNaoewAwTL+JduMOfI8jXXgI7+UCxF9i8aP1ljQZ9/4Srt/JLh
 2prdOYA1TigQNYXhWSE3WbAZr1ObbZGXPoSNLRg6HjMHwaEjD3srzbY359HfHMX2cyT5
 eqA3m04EqNwquddtfu0+yzbqg+/Dldlev4t8rSOgDAbxWZeYeAUh6N3EOzTrNtX0wMV0
 wRwcL2vGLTJag7KC2SWtQUx9Odga6KVmfk9QUZHVCHdyD+p5GdoeKrWmMQgnSUKuSEbe XA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebqe4b5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 16:20:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 396EwcGS010374;
        Fri, 6 Oct 2023 16:20:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3thcx8qe12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 16:20:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJ96+qhKtg2/9+yxSK8/+Mkw5GrscN7HcRjzMH+0vFRbPx/llVUtI022cxrosnYd5ajp3Swxx622pCtPVGRgHMlKrTs9De3z+CGnO+rihusmC6Y6zK2pXWh58EMcswpdv5t/EO/9JNH8rLpB+HALvXTJ1Wlsog+7ctM6Yn5NbgcenTsjoiFJinnUggKfNmQmjSydeArAjlEASLutHWP6mwykurIqrQODHMmrzM8vxSfcCp0BxAg6wK0/Mekvdi2hmJd/h6PyOMWD4VtmKirnzu14pLmuMZ22jwe5XQWZyq2uVvqsVJZI8VJtH8uzJzOSb2WX7a+Goo25n6QZy1NK/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nfp4YBOt9uz99RUA5OuBNdMsWmGgRBy54nRkbQJfsIg=;
 b=TTzl3RhRhyxVVL6VvZAsJ5IDWLJK0OgEffF1wQ3f8alSpMZv2HjJoEQxkhSdZaz6swI+curP5WL/MJtL6Qpo4nzIRrIUZ5RwytZG06zS9xw7YJePRN8zKytGk6kcKbxRpWahaev9sshsztAbTDjCROrlDxLrvOQEOrV/qUOf6486HWevcgOjw9whauHkDvSwvw0JFaXVr3huTMOABg5SftW8Q+cxnPD7Kf5o6/qUpHYsjm2fV0hCukW1zL+PSNF7um6Gnojtzt2iPuMIzfYu+lBbumMJXRY6K+qLUSopguWmZZ25rU+T0+lQO2TPcbL0pIep5SeplJGLgfKqov4IWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nfp4YBOt9uz99RUA5OuBNdMsWmGgRBy54nRkbQJfsIg=;
 b=ifmokuyGgz77PjDdziBnS7ZnfFxhpUR5FF79byksN/Bexr5FSslT49mpBeXT5h/hUN2g2CfZS6xG7xjD4YjH6/FBtK/QI9tetqFu4TLjvT99wwrMR5zIKJUjmx8PtU15k552kjsonCKc4jyrWthoPA4bPsMwU/8CY3EqyVw0vMM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5129.namprd10.prod.outlook.com (2603:10b6:610:d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Fri, 6 Oct
 2023 16:20:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 16:20:42 +0000
Date:   Fri, 6 Oct 2023 12:20:38 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 5.15 000/183] 5.15.134-rc1 review
Message-ID: <20231006162038.d3q7sl34b4ouvjxf@revolver>
References: <20231004175203.943277832@linuxfoundation.org>
 <CA+G9fYunnEUT2evdabX1KOTiryP1heNHWDH4LWZCt2SVRmnKOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+G9fYunnEUT2evdabX1KOTiryP1heNHWDH4LWZCt2SVRmnKOA@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0203.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2b47dc-3ca1-4abb-1b66-08dbc6882fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jYe/+pPnpBD8OPprbobDWlaKaZRE4lIDdmStVTfbiOE3OjlLJMdRlpY2NB3qLHpXZS17115gobjNB+FXiF8UdeeMiS0Wq/Jl6EE2m1DFYy9b1R52y/ze5EslYTieHrs8T/TMd7nD4wFIs8MgL1KR31LfmU1mAAmPQLSYZ2EdWkYfpzZs3+RX5q4yZxJjbvTyQgr8tAqb0K9qbA55c3X7pI+aq09WYKz28421R7gMiHrFd0xR+C4idLI7mEkK5VMB7rm8o3SIW7g7uvHmeMtx5T29sX/JPhI0tYFIJJAd9fqZiLAG3t27wGBN78oWIfaUQNhnI2OfdRT6m3tZG/IIRfjuY9++BWtLb1VPKVS0U7mvwheysCpqL1b5MPc2KnvstT6ZiFEFpoXPl646966yqGNkjflbUTHCxNSsmTm0MI+bXgbLyQU+r2y5/bxI464IMiSshy20qJGPfhNE7ER5p9TgrXLOmebQb0QcU2eVmkFkdZBhnZWeAh7Ax7KmFL64Ck9bHdLJKTRM9E6EuqjGSW2HS1blvLLM/F+ztqAMl7VgynP7GDZWAT0c3pBaYp2WtcecB8+oyU6ZkXCHrt4DBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(396003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(66476007)(66556008)(6916009)(316002)(66946007)(41300700001)(54906003)(45080400002)(9686003)(1076003)(6512007)(26005)(6666004)(6506007)(6486002)(38100700002)(83380400001)(966005)(478600001)(86362001)(33716001)(2906002)(7416002)(4326008)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVhqeEJrTW0xZ3pFZ05lRS9Gc1VTYUQ1SFRqWk5mdm9kcGJVS2EvZWVhMllG?=
 =?utf-8?B?Y0ZuczNVbkM1eHhHaUFCQkZZMlZTcHZTYUR4ZVg1emVqSWZqSi9MZEFVOTdC?=
 =?utf-8?B?bEF3YnRNZ25valJpbFFqQ3oxVFdoQ3NvTkZZQkpoQUdsR3NTY25ZYzJMaG1U?=
 =?utf-8?B?MG9TbCtXb0l3MHJqQ0EySWFZSFlUdDB6R3dkYkt0aE1nc0h2K2t1ZmpIYS9C?=
 =?utf-8?B?OGQ0dmU5YzdjRG43UEFJWDhiT1FzWU1EMVF6NmdYcENnV2tSZTkxWUw0OTAz?=
 =?utf-8?B?dWlPcURSa3MvcU1tbnp5K3RtZmtDSFZiRmwyRE9DNVhIakhCbTcvMThWMzNR?=
 =?utf-8?B?VFBtQmdPTUFjSlpVT1dvTlZNSGhwOUo4VUNOZ0IxNTgzK1FTQ2NSOCswUUFE?=
 =?utf-8?B?N0hWeVQyK0FMSEsvT2xFS2d1aUhBT2NNSlpHcG9RVnhBbzE5YklCQmhobmR0?=
 =?utf-8?B?Nkpody9kQXEzVm94aUxKRmd0TnM3Qm1hSnVEWWF2b2luL1BGajlMckpwZ08y?=
 =?utf-8?B?OEVPZklEYisyTmNtNi9ZYWc3amdIcEQ2ekNtc2t4SG5LZHlLYmpLeFZHSWkw?=
 =?utf-8?B?aVkrZmMxdThHS0dnM2Y0UWNoUEpPY014ZTdxU1V2aUdidzQ2akFyenBVa2U1?=
 =?utf-8?B?RGhrT1pTVDNDTlBGaUZBTUhQYlZlM2s2NU5MTEQwN2VnYjlUTi9vb0JPNXlE?=
 =?utf-8?B?Y0dkWi9hNjVCQzVLZWwxUXJ6U0RvR24zS3pmWFNTL2hydEh5azBYR1U5WEo4?=
 =?utf-8?B?cStTa0ppci9tUGtMVzBQcGUxWEF1cDVBTGZoT29RZGkzSG90RUdsaVFyVFJs?=
 =?utf-8?B?dEFicVAxRkpqZENnNE8zeVpZMWprOGpVU2xZTk5QQ3prWDZjdXFjb0ZrTjR5?=
 =?utf-8?B?ZXIrbVAwZEl0MjZnK1VhOThNL0FubFQ2Tkc1eS82SGlaMXBrOU50UE54UFA0?=
 =?utf-8?B?b0hNeFY0MFk1NS9RREpvRG5qb0owb2hTUVFrL1NKTFpxWTMwanNwekQyTEti?=
 =?utf-8?B?M2NROGdEa211Zlg5SGVJOVJnY3JNR05vMG1CMzVjMm00eTA5V1NQcXAxdVdl?=
 =?utf-8?B?NHRzQng1ZnRwQlNnTjlTMXE2NzFsV0ZtSkQvU0VXQXljNjlsRFJOeDNDSmIz?=
 =?utf-8?B?cnhpaVlDRWMyZitienlNZU1QY0RuUG04V3BnRGZWbDAzVzR4cTB5ZTlLZzRY?=
 =?utf-8?B?OXhCRlFCWlp0d0JUUVI4cStYUWI0YnBQY042TUNWU3FieVQ1U1ExSE0zTFlU?=
 =?utf-8?B?dUI3ZmQ1NEFSbjFPMzdtQVB1aS9aNHFzQUhzYWJhWjdLUk93SEl6WVo0RGN2?=
 =?utf-8?B?aU9OL293TDh5SW85a2wwcWNHSFlhYmlQQjkxTmlGSzQ4cS92MWlPWmR4ZXJw?=
 =?utf-8?B?eFZzVnlpNEZnUFZ3VHVRMmhQZHdETTRIQ3lSTlUwTnhJMXVxMTRyQ1ZNaWFB?=
 =?utf-8?B?QVUvUXJDRE1EN2VaemJoNS9SSmdsRWtURHVoeHFqLzBFTjB3YXhUUWg2QkxE?=
 =?utf-8?B?dENZVytTSERCZ1R1bjh4eEtibE00TGM3NFlLSTVPbW9nQUswcjdTRFFIbmdR?=
 =?utf-8?B?QnlVeVZnMU1wd0lPMEFMRHlNdFJNMElRUFlmeTdlMGF5MXkrNmEvWnhSa0ZS?=
 =?utf-8?B?bEMyK2hKSERnQXVSS1ZQTm15ZzVIVjlKbXBNaUxFOWJkSFU0emo0dHRXYkNs?=
 =?utf-8?B?MWR2UndTRTNjU1BTbHFPVWJCVlp4N29RRWsrSmNPaWNjZjRXUHVmdHFPQzl5?=
 =?utf-8?B?UjA4Y0p1U0V6cEE2bitta3FkRXVKM3pscEJqUWpReGtORkNtU1ppRnp2TndS?=
 =?utf-8?B?UTN2K0V4NmoyUW0xZm1jQ0hOeW1mV01XY3VWYnRxbmFqRk9XSUhuUitERWo1?=
 =?utf-8?B?a1M1UW1ReXIyRTVDLysrTmtvbkZGVGx0UGxGcjZEa1pQNDFsaWw5TENVeEJq?=
 =?utf-8?B?aHl4aVVMRjJkSkpLZ05jbXlZSE41alVWNnBUWjRKMGtYQVlSYkYyNGU4MzQ1?=
 =?utf-8?B?QnQvTTRHaXFmRUxYakFnUFl3SXdVV2pWSXFGVUpJamdYeXVyd1Bob3kwVENV?=
 =?utf-8?B?WEhrSnQweHB2Z3FoZGJLcjFnc3VCTitMYVRlWnlJUjhUVTNITCthZWo1RXBv?=
 =?utf-8?Q?J0GPzXGozLfegi7fd3U9iQv+y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UC84b2tHV1Bac1c5anhUMVdTVExKakMyLzJ0TWdyYS9jM20rYkVtOVFDQjFB?=
 =?utf-8?B?Q0hWUTd6VkdiUi8xQ1VkamJyUGYwQ2I0aEVyR1V5bFgxa2JQRHJzbndjWTZx?=
 =?utf-8?B?RWsrS2dtdHpiL2xuSnBJWmpyWHAwS2tXditJSG5OS2JPWlBhKzZ3cnBmckJz?=
 =?utf-8?B?REptRWtkdWFsVTBtNU9xYUEvKytjNS9GcGhpL0Nhb0laQld0WEVNa2ZZZXJO?=
 =?utf-8?B?Ulg4Y0F4ZGFUYy9Rb2JiMXlqL0VSdkpLTG5YeEZyS3pJa1ZMeGU3akNFUHI1?=
 =?utf-8?B?cHpoeGpGQUNua01HVnl3eUtBR0JWUkVRSHVpYUsweE1ObG1uYm9sa1h5b3BC?=
 =?utf-8?B?RGhzUjFNS2pCVk51aU5hZk5ra1NRQXNKWHVRUlJnWlFsdkc3aHJZdnpzZTFj?=
 =?utf-8?B?MWZWYUV0UXk1KzFVVTZpNUxpWENmTzIzU2RHTk1EUE1YaEtCcVh2dHVMVDBK?=
 =?utf-8?B?Z2gyMzZRM05KTGNnOHU0UTc5L01SOXZCSnNzb1lZWFdSOWlGZzFhYXVvVGpT?=
 =?utf-8?B?UktzUFhZZGc5aFFYbjNOT0J6WTM4dTdmVW9aTTArYTg0QzFkcVgzTXNKemNm?=
 =?utf-8?B?WHNDeE5mYlNqVUdveDBNczZuNzk1dWNTcVJFVEQwK2ZaelV1M3d6WDZDTlgz?=
 =?utf-8?B?M2R0NThpN1ZCWXVqMWNnTDhpMFIyMDA1M1pFamxtU1BGOEZxSjMrZlhEYzJP?=
 =?utf-8?B?TXBEa3Y4a04yR0xrSmoyQnpWbWkyQitwRThBWGh5bVBDTDM2UmNFY0RldWI3?=
 =?utf-8?B?eDVPU3g1Z2VTQ0tDOUV6bWFFYkhUZ3VSWnpxeklMdXZTemlZT0FOOVZtelpQ?=
 =?utf-8?B?NndlMElqdkRuYXFPUitGV0E2b0lXMWxZcktxUGpkSE9rRTR5VlBJbks5RnRt?=
 =?utf-8?B?UmRGdkhkZVlHbVpBdC9LWHJBNERhNWV1bGVEY09yL3NhZjNlZ0NpaHYzVU1a?=
 =?utf-8?B?QkU3cTBib0J0c2JuNDBnSDJHWFdCeEgvK2pJOWxuV0hUQ21rekZNVnZEc01p?=
 =?utf-8?B?WVdLVlc1aDVHY1ZNc0dnZUxZelBDN0xMMWUvQjUxRXVXWFVpN3hoNVFoYTEv?=
 =?utf-8?B?bFdxUEFuODZvUE5NWk1GTEI1YW4rd2l3cVFMUzU1SVhGcEdRc2FOWExDcnNo?=
 =?utf-8?B?M05IaUsvRURWcUhQV1M2Vmh2MXJhMWo1Z1RNR0h0eXdoSjltbHBzQm9OSHgr?=
 =?utf-8?B?bWJUdHlmK3ljbFJHcWZLZ2EwanUzeEsvQkJKa2tzOVV5TzY5WE9wVmpiTy9U?=
 =?utf-8?B?dXF6YmZIWU1jaVd4elRLd2IxRWFZdDRJNkpkajMzWkFwVjhYemhxR2wxT3JT?=
 =?utf-8?B?ei9FQlEvQU9PNFZrK3dTUnhsR2pINWxXYVBiS0dzek5GVGJyQmNyV1kvRHBn?=
 =?utf-8?B?Zm5zVk1QNTkzODRpWVhFQ3NVTVhCdWh5M04yWklNWXFzZXZ5c2RUMUNCdVVN?=
 =?utf-8?B?NC9HS1Y1WDVGZTVKMFROZWlWWDREa2VmUWg0NXVMRmRHYzBsTGtPNGc0bS9j?=
 =?utf-8?B?QVdjY3hVaHJvTWNZei9VL3ZZa3UzMy8xdlZHVlc3bk9mMUFEek01Tm1vdjB3?=
 =?utf-8?B?d3lxNyt1c3FqRUwwVkdLMkRwN3Z2Q1pJeG1Yc0R1SGswSllacmdFRmJNak1Y?=
 =?utf-8?B?ZFZyajBLZm00SmZud3pONnVHMjdwNnlTM2lhRVBjcE9lbzRIK3BzTGRYNldR?=
 =?utf-8?B?Z0V2djVaV3JIWE9yRHpuVlJvQlVtaFVHUDlmblhpUm1LSWRSNWwzWmdCUjRN?=
 =?utf-8?B?bHhJNExMbmVtZ3MralpCQUl3dWxkaGU1bWZjc21yT010VmFmdmdsaVgxNU5O?=
 =?utf-8?B?cHhnVWlrNDJiV3poWHFxYUVocEJHcHFUclpNMUpMTDM0a2JNTnNyZzF2eWtI?=
 =?utf-8?Q?QxN9PWU8qerV7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2b47dc-3ca1-4abb-1b66-08dbc6882fc5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 16:20:42.7204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ArHJDTv1+UGx+X0jWIhgiz/oKLaklWBV0/phaobtSDTI/Ey6U8H8QdBSRJLrU19ebOEELon2u4y2JmGSeIvVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_12,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060122
X-Proofpoint-GUID: 28m7LokAn4AB7uFPKD8hx3vEwfB2BOEO
X-Proofpoint-ORIG-GUID: 28m7LokAn4AB7uFPKD8hx3vEwfB2BOEO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Naresh Kamboju <naresh.kamboju@linaro.org> [231005 13:49]:
> On Wed, 4 Oct 2023 at 23:33, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.15.134 release.
> > There are 183 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patc=
h-5.15.134-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-5.15.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>=20
> Results from Linaro=E2=80=99s test farm.
> Regressions on x86.
>=20
> Following kernel warning noticed on x86 while booting stable-rc 5.15.134-=
rc1
> with selftest merge config built kernel.
>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>=20
> Anyone noticed this kernel warning ?
>=20
> This is always reproducible while booting x86 with a given config.

From that config:
#
# RCU Subsystem                                                            =
                                                                           =
                                                                           =
               =20
#                                                                          =
                                                                           =
                                                                           =
               =20
CONFIG_TREE_RCU=3Dy                                                        =
                                                                           =
                                                                           =
                 =20
# CONFIG_RCU_EXPERT is not set                                             =
                                                                           =
                                                                           =
               =20
CONFIG_SRCU=3Dy
CONFIG_TREE_SRCU=3Dy
CONFIG_TASKS_RCU_GENERIC=3Dy
CONFIG_TASKS_RUDE_RCU=3Dy
CONFIG_TASKS_TRACE_RCU=3Dy
CONFIG_RCU_STALL_COMMON=3Dy                                                =
                                                                           =
                                                                           =
                 =20
CONFIG_RCU_NEED_SEGCBLIST=3Dy
# end of RCU Subsystem   =20

#                                                                          =
                                                                           =
                                                                           =
               =20
# RCU Debugging                                                            =
                                                                           =
                                                                           =
               =20
#                                                                          =
                                                                           =
                                                                           =
               =20
CONFIG_PROVE_RCU=3Dy                                                       =
                                                                           =
                                                                           =
                 =20
# CONFIG_RCU_SCALE_TEST is not set                                         =
                                                                           =
                                                                           =
               =20
# CONFIG_RCU_TORTURE_TEST is not set                                       =
                                                                           =
                                                                           =
               =20
# CONFIG_RCU_REF_SCALE_TEST is not set                                     =
                                                                           =
                                                                           =
               =20
CONFIG_RCU_CPU_STALL_TIMEOUT=3D21                                          =
                                                                           =
                                                                           =
                 =20
CONFIG_RCU_TRACE=3Dy                                                       =
                                                                           =
                                                                           =
                 =20
# CONFIG_RCU_EQS_DEBUG is not set                                          =
                                                                           =
                                                                           =
               =20
# end of RCU Debugging


>=20
> x86 boot log:
> -----
> [    0.000000] Linux version 5.15.134-rc1 (tuxmake@tuxmake)
> (x86_64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
> for Debian) 2.40) #1 SMP @1696443178
> ...
> [    1.480701] ------------[ cut here ]------------
> [    1.481296] WARNING: CPU: 0 PID: 13 at kernel/rcu/tasks.h:958
> trc_inspect_reader+0x80/0xb0
> [    1.481296] Modules linked in:
> [    1.481296] CPU: 0 PID: 13 Comm: rcu_tasks_trace Not tainted 5.15.134-=
rc1 #1
> [    1.481296] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.5 11/26/2020
> [    1.481296] RIP: 0010:trc_inspect_reader+0x80/0xb0

This function has changed a lot, including the dropping of this
WARN_ON_ONCE().  The warning was replaced in 897ba84dc5aa ("rcu-tasks:
Handle idle tasks for recently offlined CPUs") with something that looks
equivalent so I'm not sure why it would not trigger in newer revisions.

Obviously the behaviour I changed was the test for the task being idle.
I am not sure how best to short-circuit that test from happening during
boot as I am not familiar with the RCU code.

It's also worth noting that the bug this fixes wasn't exposed until the
maple tree (added in v6.1) was used for the IRQ descriptors (added in
v6.5).

> [    1.481296] Code: b6 83 45 04 00 00 84 c0 75 48 c6 83 45 04 00 00
> 01 b8 01 00 00 00 5b 41 5c 5d c3 cc cc cc cc 0f 94 c0 eb b4 f6 43 2c
> 02 75 02 <0f> 0b 48 83 05 36 f8 ee 02 01 b8 01 00 00 00 48 83 05 21 f8
> ee 02
> [    1.481296] RSP: 0000:ffffb25e000afd70 EFLAGS: 00010046
> [    1.481296] RAX: 0000000000000000 RBX: ffff9b40c080d040 RCX: 000000000=
0000003
> [    1.481296] RDX: ffff9b4427b80000 RSI: 0000000000000000 RDI: ffff9b40c=
080d040
> [    1.481296] RBP: ffffb25e000afd80 R08: e32db91cdfdc3bef R09: 000000000=
35b89d4
> [    1.481296] R10: 000000006a495065 R11: 0000000000000030 R12: ffffffffa=
e692100
> [    1.481296] R13: 0000000000000000 R14: ffff9b40c080d9a8 R15: 000000000=
0000000
> [    1.481296] FS:  0000000000000000(0000) GS:ffff9b4427a00000(0000)
> knlGS:0000000000000000
> [    1.481296] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.481296] CR2: ffff9b4297201000 CR3: 00000002d5e26001 CR4: 000000000=
03706f0
> [    1.481296] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [    1.481296] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [    1.481296] Call Trace:
> [    1.481296]  <TASK>
> [    1.481296]  ? show_regs.cold+0x1a/0x1f
> [    1.481296]  ? __warn+0x88/0x120
> [    1.481296]  ? trc_inspect_reader+0x80/0xb0
> [    1.481296]  ? report_bug+0xa8/0xd0
> [    1.481296]  ? handle_bug+0x40/0x70
> [    1.481296]  ? exc_invalid_op+0x18/0x70
> [    1.481296]  ? asm_exc_invalid_op+0x1b/0x20
> [    1.481296]  ? rcu_tasks_kthread+0x250/0x250
> [    1.481296]  ? trc_inspect_reader+0x80/0xb0
> [    1.481296]  ? rcu_tasks_kthread+0x250/0x250
> [    1.481296]  try_invoke_on_locked_down_task+0x109/0x120
> [    1.481296]  trc_wait_for_one_reader.part.0+0x48/0x270
> [    1.481296]  rcu_tasks_trace_postscan+0x76/0xb0
> [    1.481296]  rcu_tasks_wait_gp+0x186/0x380
> [    1.481296]  ? _raw_spin_unlock_irqrestore+0x35/0x50
> [    1.481296]  rcu_tasks_kthread+0x145/0x250
> [    1.481296]  ? do_wait_intr_irq+0xc0/0xc0
> [    1.481296]  ? synchronize_rcu_tasks_rude+0x20/0x20
> [    1.481296]  kthread+0x146/0x170
> [    1.481296]  ? set_kthread_struct+0x50/0x50
> [    1.481296]  ret_from_fork+0x1f/0x30
> [    1.481296]  </TASK>
> [    1.481296] irq event stamp: 132
> [    1.481296] hardirqs last  enabled at (131): [<ffffffffaf7936a5>]
> _raw_spin_unlock_irqrestore+0x35/0x50
> [    1.481296] hardirqs last disabled at (132): [<ffffffffaf79345b>]
> _raw_spin_lock_irqsave+0x5b/0x60
> [    1.481296] softirqs last  enabled at (54): [<ffffffffae69201c>]
> rcu_tasks_kthread+0x16c/0x250
> [    1.481296] softirqs last disabled at (50): [<ffffffffae69201c>]
> rcu_tasks_kthread+0x16c/0x250
> [    1.481296] ---[ end trace 5a00c61d8412a9ac ]---
>=20
>=20
> Links:
> ----
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/=
v5.15.133-184-g6f28ecf24aef/testrun/20260259/suite/log-parser-boot/test/che=
ck-kernel-exception/log
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/=
v5.15.133-184-g6f28ecf24aef/testrun/20260259/suite/log-parser-boot/tests/
>  Build: https://storage.tuxsuite.com/public/linaro/lkft/builds/2WJFhcfqqG=
69pqj6LWuI14kVoP5/
>=20
> steps to reproduce:
> --------
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2WJFhcfqqG69pqj=
6LWuI14kVoP5/tuxmake_reproducer.sh
>=20
> ## Build
> * kernel: 5.15.134-rc1
> * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> * git branch: linux-5.15.y
> * git commit: 6f28ecf24aef2896f4071dc6268d3fb5f8259c77
> * git describe: v5.15.133-184-g6f28ecf24aef
> * test details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.=
15.133-184-g6f28ecf24aef
>=20
> ## Test Regressions (compared to v5.15.133)
> * x86, log-parser-boot
>   - check-kernel-exception
>   - check-kernel-warning
>=20
> * x86, log-parser-test
>   - check-kernel-exception
>   - check-kernel-warning
>=20
>=20
> ## Metric Regressions (compared to v5.15.133)
>=20
> ## Test Fixes (compared to v5.15.133)
>=20
> ## Metric Fixes (compared to v5.15.133)
>=20
> ## Test result summary
> total: 90392, pass: 71514, fail: 2557, skip: 16224, xfail: 97
>=20
> ## Build Summary
> * arc: 4 total, 4 passed, 0 failed
> * arm: 114 total, 114 passed, 0 failed
> * arm64: 42 total, 42 passed, 0 failed
> * i386: 32 total, 31 passed, 1 failed
> * mips: 27 total, 26 passed, 1 failed
> * parisc: 4 total, 4 passed, 0 failed
> * powerpc: 26 total, 25 passed, 1 failed
> * riscv: 11 total, 11 passed, 0 failed
> * s390: 12 total, 11 passed, 1 failed
> * sh: 13 total, 11 passed, 2 failed
> * sparc: 8 total, 8 passed, 0 failed
> * x86_64: 38 total, 38 passed, 0 failed
>=20
> ## Test suites summary
> * boot
> * kselftest-android
> * kselftest-arm64
> * kselftest-breakpoints
> * kselftest-capabilities
> * kselftest-cgroup
> * kselftest-clone3
> * kselftest-core
> * kselftest-cpu-hotplug
> * kselftest-cpufreq
> * kselftest-drivers-dma-buf
> * kselftest-efivarfs
> * kselftest-exec
> * kselftest-filesystems
> * kselftest-filesystems-binderfs
> * kselftest-filesystems-epoll
> * kselftest-firmware
> * kselftest-fpu
> * kselftest-ftrace
> * kselftest-futex
> * kselftest-gpio
> * kselftest-intel_pstate
> * kselftest-ipc
> * kselftest-ir
> * kselftest-kcmp
> * kselftest-kexec
> * kselftest-kvm
> * kselftest-lib
> * kselftest-membarrier
> * kselftest-memfd
> * kselftest-memory-hotplug
> * kselftest-mincore
> * kselftest-mount
> * kselftest-mqueue
> * kselftest-net
> * kselftest-net-forwarding
> * kselftest-net-mptcp
> * kselftest-netfilter
> * kselftest-nsfs
> * kselftest-openat2
> * kselftest-pid_namespace
> * kselftest-pidfd
> * kselftest-proc
> * kselftest-pstore
> * kselftest-ptrace
> * kselftest-rseq
> * kselftest-rtc
> * kselftest-seccomp
> * kselftest-sigaltstack
> * kselftest-size
> * kselftest-splice
> * kselftest-static_keys
> * kselftest-sync
> * kselftest-sysctl
> * kselftest-tc-testing
> * kselftest-timens
> * kselftest-tmpfs
> * kselftest-tpm2
> * kselftest-user
> * kselftest-user_events
> * kselftest-vDSO
> * kselftest-vm
> * kselftest-watchdog
> * kselftest-x86
> * kselftest-zram
> * kunit
> * kvm-unit-tests
> * libgpiod
> * log-parser-boot
> * log-parser-test
> * ltp-cap_bounds
> * ltp-commands
> * ltp-containers
> * ltp-controllers
> * ltp-cpuhotplug
> * ltp-crypto
> * ltp-cve
> * ltp-dio
> * ltp-fcntl-locktests
> * ltp-filecaps
> * ltp-fs
> * ltp-fs_bind
> * ltp-fs_perms_simple
> * ltp-fsx
> * ltp-hugetlb
> * ltp-io
> * ltp-ipc
> * ltp-math
> * ltp-mm
> * ltp-nptl
> * ltp-pty
> * ltp-sched
> * ltp-securebits
> * ltp-smoke
> * ltp-syscalls
> * ltp-tracing
> * network-basic-tests
> * perf
> * rcutorture
> * v4l2-compliance
>=20
> --
> Linaro LKFT
> https://lkft.linaro.org
