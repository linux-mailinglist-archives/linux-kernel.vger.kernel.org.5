Return-Path: <linux-kernel+bounces-4743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C0B818174
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3461F22504
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7BD79C6;
	Tue, 19 Dec 2023 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FwTF/2ZQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vjHnBPdZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEACC12F;
	Tue, 19 Dec 2023 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ0J6ri024712;
	Tue, 19 Dec 2023 06:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mRLdUGvWRzdgNryt9Pc3ZJ+rnhzMlw/NYjOhyJviVq0=;
 b=FwTF/2ZQ59psSLyLKPbsiANFoEUmvE0kpwl3oLzVVf70x6/o3t7wFwstG3FeFypgDVPi
 tBw1kbT+CJHjP91HCJk+ULjc4vrINIyBCkmh4JK1WuqHkXQ1nnQCE+nXNI4cym2pRnuV
 ycxjrG/gT10fjwfq7r2uUM/Wq1JDfZdAoplJ5fk2Wj44o1MzyKzIPIul7yNT++mUdboK
 9BfJAgbWdFAHafhmhObhXkA1851xXyQOYtzgqF+X/bhWiCo7ucc4gqgsWduc/kJACXXW
 aqQXfbPSMEqNUrjwpNgygOCA+0Q9W39CrsxDffjtJ52BOpL51IH7jA/i9l/d3PkdG7UU jw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13xdd4wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 06:20:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ6A7A5021006;
	Tue, 19 Dec 2023 06:20:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b6gkdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 06:20:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogiAZCtzajzOQCkoz8d21figJMUIyO8ZerlvAVEYsTV3RFpfvlABoj1jqCWvclA6iW7FRVoLpRJMx82HVuJ2Y68NFrGVrEKEjRHn6s04BGnkEETUtQ54WU7D+vBUL4tia3r142AWxzwk+N25hf2UBp0J1dh6Q0mjzgL0id96syPj1Uja9Mx7AKB32F2rkaDMgnAJnk/xFo8uZu1l2aUUw2HZ8Hl7R46iONAlNpDUY10vIJriuwWVtzRhr448hXMxowUBdyTaSoVCG2WhuOt1ptBXH1GfOOCu6f+tpier5GVOFldZhqGRPNL0oOyx5cKhAdcU/dhvmE4NEhmuvEJHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRLdUGvWRzdgNryt9Pc3ZJ+rnhzMlw/NYjOhyJviVq0=;
 b=N0iEhk+lfTAVKbKYWPE+lqzo/4DK4GcemwByW1oIzfeOQILeJ8jqlrfQKJ0636utD46lE6CANEgMQ6Df4KLUIbs2sntMSUKhxF00eaAh75bMOlih8i4beAauFuf5Gm2wfOGqNFiAB8Obx2Auj9WoUUsUfRlqJtBe5B2GQGIiqpLRa7igK130WG/rfaMnYeYKFZ/hfPHHgoqqa3IDVgs+VDeOJWi8qrWECLKgCcTEOy+/hzTqZyIduc2rb+yCR3x+dZaQiSDsIQ8VqaHupdI+Y4yq6MWj3ywn5Bop4wwMQtcvqhtg5/wMeISNunwxeDzSsQJkMmOMnG3942N9zXMg9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRLdUGvWRzdgNryt9Pc3ZJ+rnhzMlw/NYjOhyJviVq0=;
 b=vjHnBPdZNVMqN/7sJfw9iKxbiVPoIQW20bW8jVsYg1TxuCl3HrzjQ7RSkes4/kcpwoRHhAeoFEuRMeezMoZUGbaOXGpXOkJiK+isKpfZh7lCdhtGwuYmoTlwU15zvjPvclvtNhaOutrn62aBXWzQidFipj+rUG10JEEa9IB+t9M=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA2PR10MB4633.namprd10.prod.outlook.com (2603:10b6:806:11a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 06:20:12 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::b7a9:b552:a623:84a4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::b7a9:b552:a623:84a4%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 06:20:12 +0000
Message-ID: <c555d601-2421-486f-a6dd-fd64e3708525@oracle.com>
Date: Tue, 19 Dec 2023 11:50:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.14 00/26] 4.14.334-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231218135040.665690087@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231218135040.665690087@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA2PR10MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: 4885f8d6-f04e-459e-ff2d-08dc005a8ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AuP5c0mzxeaCeQIRm4HcFy465O7vf/Cu5Xgfz2i5j9Fuq/k9q9257xy9AMznmFOaG6XJWEwhN2Dvx6DNxg0CEMjtit8UgNGlcblPy5fYC0dGeGmkgFdLI9wDUXroQq0RjyCpa2srvdGBdxZqEM1pmBUdBFpmDlLwNFjs+A7JSYqKNH2qx9GO4cLrQUOakHwwnTPOBHCYZvtFvz40Tw+EPkL4nHBQTy4uUEWP4f8KCNHO5oudUPtRZ4EBgnsnVrHBHlPu9qKWcgJGqR+ecxxPyJvT8asRAacbaS/+6+Umy4tzXHdwTOnarLseu+lUXSbZRa/Xq5Osl9QQAv8CKnKB9Ie6atQljLpeyv6gJhyOBWBQuIK+utUjxJrH/SzRSY/bSfPkuQXUQ9CTNC8G9A+EWDH6caH00One48sBTDRC0lBL7ZLC85d8tNiiaYlw4ZuljaKuMN+MHkH12JetG+gbgnLmWLR3XEBLTNCb6gPqcUL03PaRjYBzrNfBIZj2vTBo8lNJLxXKbhpduxbbvmYNx6u9+5bEO1XGRQxypAYDFwxWwn1mSxVSrm+W+Ig9qbhFu7SGmJnkgrOeSXjGj72YofSekmnwjUdQuyc4Zl9ACmVplgfD9nNqJDBO48VrvTgV6DjTbFxEiJP163XpEXQ45g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2616005)(107886003)(53546011)(478600001)(26005)(38100700002)(8676002)(8936002)(4326008)(7416002)(41300700001)(4744005)(316002)(66946007)(966005)(6486002)(66556008)(6512007)(5660300002)(54906003)(66476007)(6506007)(6666004)(2906002)(86362001)(36756003)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RVU4NmhtekU4bEx2WTNZZUVCM2pQbVY5bDBHcjVSa3I1NFIxUzlyVW5FRldp?=
 =?utf-8?B?NXMyMnl2TFpUdkJzdGh1ZTdQWHRiWituZ2U4SGovcUdZamdpeWZCVitZZ2xj?=
 =?utf-8?B?Z1FwRjMvamtTY3Z2OXQ0d1B0NytHOUNJSkUzb3hFWUtIM21mVVJKdXZndmxj?=
 =?utf-8?B?MWc1QkdEMFl6d3hrS3hPL0dhWXZFeWNXTVJyOTVkNERPZjJ5WW9KL0kxaStO?=
 =?utf-8?B?ZzA0YXRKZC9tR3Bad29KZmd4YVd0a2luVDFYNWhUR2p2MTdZWGlxYjlYOFRS?=
 =?utf-8?B?VXB3ZUhhNUs1VVU2aHRpbHBrb3lnS1djcGhDQ2toaFJMcVk4L0lTNlpMOTBj?=
 =?utf-8?B?V21kZmlMQVJTVndLVFgwYVB3TVpzSUZyMHM2RG9wa2NvL280cUgrQTRwSnZp?=
 =?utf-8?B?dzd0M082UnpYR282blB5K2V4S29hM0VLb014Vk9LWHlLWUxIZW5ydERzR0pE?=
 =?utf-8?B?U0wybW9MWlRSeUpjVmZZNWZzZmFkdXNqenBLNGR2bEhiY0IwQWowV0c4WjNE?=
 =?utf-8?B?ZHJKWXExWHNTeTVUNWcxQTFFM1dhU0NRTEovRnRGeXZ3VGMxY2dUTHVHd1dD?=
 =?utf-8?B?SmdVbE5ldnUrWEd3am9pV0ExQnAyUDVnWnN6V2tVSjdTWXd6VUtjNHJvSnli?=
 =?utf-8?B?bFV0eUYrT3c1dnptKzZlOFZyOEVpclZNSnN6dXV5M0U4bGlmZkNOcnRmYmpO?=
 =?utf-8?B?MGFXN2FWaWJXak12bk9sL21xSUwvQml1V3k0Qy9ES0k3UFlDWkJ4eFROam93?=
 =?utf-8?B?TUU1bW9kVUlSYSt3dHJsQmhES1UwejQ1UElEdnh3TmtiNjI2QWc1Tld4eTF5?=
 =?utf-8?B?Y0s2eUwySXJXZ2Q0bW1ldGo0M2ZzSHhtd09mRFVKdXh1RnNrVm1EOUFOeHJV?=
 =?utf-8?B?TmNaS3EvQzU5dG1SeS85a21SMklNMFNVUzd1VlBYSkluQnZtMHVlM2xNS0Rj?=
 =?utf-8?B?QzJCRjFtanlJakpEeFk3Y1RrcDFWV21vVFhGYUIvQ0JvR0RUN2NOOTBZbjhR?=
 =?utf-8?B?SFJOcFhBVjR1L2VISmJXU0cwMHdFdEUrcWd0NnNLdUs0c1FVdlVLYXpCSDNB?=
 =?utf-8?B?SmFwc3N2UGxibnNMRVV3SUkxVTNIc1phTTBuaGJKQkQ4azliMlhnc0h0Q1lJ?=
 =?utf-8?B?M2hMd1Y5cElYQzE5UVl2NEVPS0hkVUUyT2tUc3JjUk1lUWkzM2ZRcytVeVFp?=
 =?utf-8?B?eGwvMHJVVlZiaHAxOHhSQ0FwUFpOaGMzeUFFMEhUbmxEaWtmM3lqMjVkcUFC?=
 =?utf-8?B?UlJhMG5jTFZTQ2swMHVIRUIxNjRCc3BmTE80NHBTS1RFVE9lNk1wOGc0VGQ4?=
 =?utf-8?B?emhtZmRMUzJKYktndjNFYVVJeURJM0liQU55NFRXakJXUDhjdlBmOFp1QlNa?=
 =?utf-8?B?Wmx2RDBoZEtock8raENqQkVQKzZKYzIvTFlBZFZVK1VWbUpzeGwwL1hMT3po?=
 =?utf-8?B?amZOREtYTnA3cHJCUDdzdzhOUEswY0d3Ky9VL2Y0alkxYjZQVjVydmFLYWJL?=
 =?utf-8?B?eDFFcHRyL1BlbDdhQm1vSUJVM0xSclg0TWJ4SHdSVVpSWHIzdHR4N0JmZWVS?=
 =?utf-8?B?clhrdXAxanpsZnFSMGE0c3lRUWhqNUpmclNSWXpOYjNRS2ZGUUNnVkMrckdH?=
 =?utf-8?B?M0kwbi80WGFXNnI3bysxS1NicFo4VldlRWdmRXdjTWNyREx2QmdnS2VlcFkz?=
 =?utf-8?B?azRUYmNUN1JVRkszQkRwaWlxUlBWakNJYjdxWU9rQnhIWExlK1lLeU4rN3lo?=
 =?utf-8?B?dVRXU0drNElRVzVLNzJDYVVudWlqNkJOcXR0SXhNcWJsa0lvLzVzRnFaV1Ir?=
 =?utf-8?B?U1hCcmxzSk5Lck5KWFJGU05hTkRPZlBJbGx6bUQ1QU1QMFpubWFndWloUkRi?=
 =?utf-8?B?OWNITCthVUo4SG5ndEoyNkRBemhreTMwQUpLcmFpTEpuVE5Jam1EQlZBbDA1?=
 =?utf-8?B?dGExMzZHdFFmU0RvbnlURmRnY0pFN1crdSs0TjUvVHJUMmlINXdCZEdlZkRZ?=
 =?utf-8?B?ZUtXNml4OU82ZnhqS3R1Ryt0UnNMOUN4bTdqWUtodEtnMEVIVnNESVB6Z3VR?=
 =?utf-8?B?Ykk1MDNYZnBUVTVCSGVkZDM5TENHVmNYQ3NjelVNbGlyeVBkQnA5TlJ2L2w5?=
 =?utf-8?B?ck1VOWZjdFpna3d4N21VeVFSMVZOWkJmbXRrMDQrZDAwa0MraEFqR1ZTVUln?=
 =?utf-8?Q?nB3KxEwiBR/DCNPQn137udA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pQRBqCxP8oxRHn9FExv9/JQ6ScgXwyjoA6q4OhSwu9pVVoxkLfzo9AMaerNURciR2gfu9AH3p/w3FHTtE3bBp0doKVOKA5yRAkVVqUBnVvszQYsW2k4ZydJpU1mB3Uy2uaBIe0NBSJnBZirh5IgmJZZ9JlNtd1M8VSUYSUKktoQO8ZS8u9h0dYgN79J+ckK3Hx2sGUWGLgMyZ3AoiAVICgm8E3zUKXTBMx/I3BGX1HQiEdRpZsE5osPdNE7WD01iLcpvPV1lOGVs1B2MicpZ3DTCplTXrgSqH2sV2dSphsBqRpQuxuRWmn68Hh9EACGGvQBKJbaZfZV7snS5ROX/6+D6R+i1WajR3QoS0DpYBr8E7NnMQF4tCMxt+7MqFwSn4RDXI40gX0HuhlrSMd94YaE7dpC8d8F3U+OdW64w3yB5WzoOmHHILfn09vQBiI2MyRJWlVCOrLpNkON9YTW6Nzg657VNmlkKVisR41NLQukkeOVgmfXkV9YpXfTsukJ0ReSPD3XfsVq6H1munxWv370I+6tPkySqYVRpDIgVqhyqGcapfdBQJNrXLy4YoYu6UNJZDBEbz/D0yh209Vlp+/CGugw7i/0Wisx62txkFuU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4885f8d6-f04e-459e-ff2d-08dc005a8ede
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 06:20:12.6562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkdR+hOK8IFlDzTI7ymKuoqSzA82GKBlr6w6GvhesCKXXBgcviberc40oYVb0QvrBWF8r2hE+Gzv6ZIxmZmWUGd9VuYbjkczudGApMM0kQZ/aH32mQhji8PPxyZ+Is6L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4633
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_02,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190045
X-Proofpoint-GUID: rJYy4noLWxvgJFYJ8VRdhkc-MlF_gEWF
X-Proofpoint-ORIG-GUID: rJYy4noLWxvgJFYJ8VRdhkc-MlF_gEWF

Hi Greg,

On 18/12/23 7:21 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.334 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit


> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.334-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

