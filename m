Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B37680F9BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377542AbjLLVtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbjLLVtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:49:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1806AB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:49:29 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCJaZeg008514;
        Tue, 12 Dec 2023 21:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=qb/RLEN3VVZgvrlGkqDrV9xjI1Mx9XyDyoA7hu725+I=;
 b=laAxD1o+iRVlM2x/z90ykEwA0oLMk/9bR9DUhnH+q8Mii1MnZojUWWnG29syZ/+FsJiw
 TXLK3pPpVE7inIZC0PkVdYGYX7cHxEgKRrDFbtunpzJUsx6FpVyK5OP21lBOQQNoAokt
 xNBJiQ39WeL0BUx799Ntpr40y+zswwVK6l8UZxHOYHXY8F+fhBWrLDpsb1qCtHH1d8y7
 mzN+HQSF3CtbE2ALCiXpa18VhP/al14Bv82kXZfK9b1Jg8vqbxCsdeaG9LHNZ/MJOYmO
 Q7dYDtoZKLDR3a0LFEqGFWn9EH5lEDP6exkytUUQ0HR5p8Ek4xQZDLzd9RVCdDGYcMLj Eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ux5df3ghr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 21:49:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCLZuH4009877;
        Tue, 12 Dec 2023 21:49:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep78hsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 21:49:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEqgP8GxiJsbcbS09d0bz/c85gXIO0ZfbOmosXWLW4IIA//BMIVka2ofFBw9wwDmxTaPzH0Tz/Xbu0eHvGjg9rJlb4SB6ouLoU6ymfgJLlGLD0tWN1UiIQhu4njlRrc/K1lXQP+66dTdSf3dd8MlbLqKkMj5ibs2gmYZti2PM03Q7VsXqB4lkX2bMbVg1Q9NrFO2Cd+U4uelN9/sDT8KIptX9mlai2DgzdHvdu90lVf/Jut2QGQBEW71XgqSyjHgFtHXgg60TkOYF5pMxtrpqPMrbhSOxzNg0X1Xoudufi9GY5WoDWS27373oznXGvBqNFHbeRbHaR6DvLHHayyixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qb/RLEN3VVZgvrlGkqDrV9xjI1Mx9XyDyoA7hu725+I=;
 b=mG2dsnpEFD0xMnR3Vq2w+w3+Hw/setiDXx2bm+htecjhs8VNbbdPel+JusKcmaTic+q3RJXokrflY6d+D8tN1zs5VJkGA4irG07qEPsl9LnycaQVjrSLDYTHT5P+pniySfe1ZGVgrSV1Wm0uIhjAvnceOc851pXSm9W/KvzZaRvkWcbycHCV2HkAdAF/TG29CZzMJzjvVV5d6b5Tcl9yW+5n6vWIwFKGuqvxgXX6ROVPKcSHowebTNk2wBoF4+2rCcsoMtYNkpqJATMVlVG2+C3kZGSvUpctaO9x9M+b+hKPVdGXrxzUh1CXULiQI71rP/I0AV26UQ2PiLlEpihjMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb/RLEN3VVZgvrlGkqDrV9xjI1Mx9XyDyoA7hu725+I=;
 b=e1Zzih+ip/SdMrztjfyKrNqHg82mPNHFoohjMwfFuRY2R9ff3AM2x0GcGSjb2CcdeZIO9gxYvDHtww84819PHEWMw6oi2OpI9MzJXADEOmH69tJukYvlgkX7Jk77LMadkUERFveSrO4dHkmzZsvt6DhapgqfSbao8GNsDmT0PsA=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BN0PR10MB5175.namprd10.prod.outlook.com (2603:10b6:408:115::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 21:48:59 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7361:23aa:7669:bcce]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7361:23aa:7669:bcce%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 21:48:59 +0000
Message-ID: <2593de09-22fb-5579-2022-c0fccff7f6b3@oracle.com>
Date:   Tue, 12 Dec 2023 13:48:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] maple_tree: do not preallocate nodes for slot stores
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org, akpm@linux-foundation.org,
        liam.howlett@oracle.com, zhangpeng.00@bytedance.com
References: <20231212194640.217966-1-sidhartha.kumar@oracle.com>
 <ZXjJTM0pDksnslgo@casper.infradead.org>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <ZXjJTM0pDksnslgo@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:a03:331::35) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|BN0PR10MB5175:EE_
X-MS-Office365-Filtering-Correlation-Id: f399d7d4-dece-460b-f288-08dbfb5c25cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/HlxSPq0wgV3Xqv1YEOLtYuLT3+OzPmiEpSkJhtrvY/yfPMLrAnwp3y71BynJUC9xqr3HjEbMkhF4fpjTXaaRedDXBN+A6nmZVTSR0MG8my6so4+6hPQlPAIwiOAf7gaWO5nmPFvPeg8h3Z+wiXmfLiqzZBpV2c5PKRidBo2OzPhejRVvNcy6bIdISkzjgnAXignc1tv9YtpNru+0vgZafTKOmQsCL58XcD3i+Fyo6tJJpQFY5onrmX6JSI/5YZ77qrVGgDGK+yh1niJ1vJdw+y1gboARH5VSe8+pEIBLyCeeZn5xobIVMweY4EGH7AVkY3UtLEtLrxaCGnmv46RsDliTvk1hSrkJ4ruSLo2U8U+Bv+UPZPNG3H1AQN752zmsPGx+SKHoqYGDiRDOB3P/jSGAy4RLNbO+YW1ttSQCooBC4p4jIiW8n1gRZvwTTkwIRQlEMlQm7gNWNeSPju5XuBMVjVB9yrbO7R+3iL4naAhKqwo+SPVuVdNY8C/tKEJzHIPhw3zZgou0xAeEEWoTQlvjWNvcO9Ql8RYgCkRCRQTsuC3byeM4VFgnlivRrbGOT91x6O2bCDgziD0hbFQhEGJSmdAXsq7f/e2yzAn3rna0UDXPsDNzeKPOqlrVXDbNk+vpyszlCMmc4776tB5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(41300700001)(2906002)(8676002)(8936002)(316002)(5660300002)(44832011)(4326008)(53546011)(6512007)(6486002)(6666004)(6506007)(2616005)(478600001)(36756003)(86362001)(31696002)(66946007)(66556008)(66476007)(6916009)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEE1R1g2RnFyY1A0NXYxVnJoZXgrZGdrckVCaFk3M3BDMlFOWEt5T2pLb1RF?=
 =?utf-8?B?VHJTN0QxL2FrMVp5V29EdGZxR2NzQjNUMTlWNCtCYVI5WW5TR3NvVGFSRWgw?=
 =?utf-8?B?ckZWcXVvekYyUTJCeFB0d20rbEYzWEJIZ2NkVWlhZkVVV3hCMFFmM0Z5b3ln?=
 =?utf-8?B?TVZ2eFRJeWNWbnJSTzZtc1NsR0MyQ0YvZUNNSjdKV0FVTmU3bGpWc1JDck5S?=
 =?utf-8?B?K3FDQ00wdytsamxkNHVDY2xuN0VVMlJYUG1zYjcrL0VSV3BETVNMQ3k5am92?=
 =?utf-8?B?UHFTTUh5SVR0VjlVeHo4RHlVUEVRV2FLbk9MVnZTdEVoMW10U1pWWSt0NmF3?=
 =?utf-8?B?ZnB4ZEVpWnN2SmplZlN0aUhLMnVpOUgwSno0ZnVWMDcvR3kwVy8yazZNa2pk?=
 =?utf-8?B?TE5heUhXcTFZMlVTOVlEOHZaUW1hYzIrQmt6cVQ4QW9QUUxpclVTb0pIaDBD?=
 =?utf-8?B?RDQzazRicjFWMlJ4TmRjOWNLdUJuL1FXUGFyU1RYaVc0WEhzNzNkK2ZqQldo?=
 =?utf-8?B?MS94WDh6c2ZHWUJxWWFjTS9XOW95clJBSlAxNzllSksxSHdVd3AyWlBrYUV1?=
 =?utf-8?B?bDB3WENvQ2ZjN2p3VG1NQ0xLbzJWSit4Qm5JUWU1c0t0VTB2c1hGUWM1OGRC?=
 =?utf-8?B?QmdnZ24vbXhOWVJ2am5ELy9IeHNFalBtZ1M5dVYyM3J5UlBqM0lqdjAzdTBh?=
 =?utf-8?B?NGROVHl0NVEvN1FLMFYyaDNvd2hWSGt0QmplbER2bjVaYjNjN0ZwN1R4dVF1?=
 =?utf-8?B?a1FtRDVHUTh5Y0VFM0VuOEVKSmxHdTFVR0VNTmhUYUdpY2pld0dwSXZoTGdG?=
 =?utf-8?B?YlE4djlCUlc0c2o3aHJUUlZTUFNnazU5RnhiNHlOQlJpSnByQXRSQVZOT3ZE?=
 =?utf-8?B?eTBpMUVhNUwwbkwxRUlFNXJRTmN2T2NvZzdVQ05rT0F3VS90aWl3eVRxLzg2?=
 =?utf-8?B?N1BVYnVma3pBc0M1cXZBYnJ1YWppRjJXNVFSTFdLeTI0ZEZ3dzNPUmJLc0Nn?=
 =?utf-8?B?YitibG5UcTZwWGFxcVBSZHFPQ3N3Z0VnVllTU1lkMzNtNytjWmZnSEc0NTh4?=
 =?utf-8?B?MkdvNVlTL2xQM1FPVVlNQjIxU0pqOHhUWGFRR0VQdkNVbG42cmVOdHg2amdr?=
 =?utf-8?B?Y1Y5UlUwazN0VHErU0NmRlBmM0NsSXRwKzQxZ3ZXelVjYWw5blNBMGdyMGpx?=
 =?utf-8?B?OEdKMnl2MlIvZGt2SEltUHg0eEc3WVlsSGhJTzRsVVVxaVpvUWUxaHNZdlZr?=
 =?utf-8?B?cXZFSTNWbnhwS2c0Sk1FYUtkbUxaOE5EYnI0MVVmeEo1VGdDL2dMaFVIT3dU?=
 =?utf-8?B?a2xXYm15WDJ0Y1BGSXV3VlZvakhSc1pwRTA1QmRwUG53QjZPbG5sQXIzWUkv?=
 =?utf-8?B?eU5HSHI0S1k0SXo1SzAwK3d2Y2t2dGR6cnd2TmxRZDRKRmU4REt5MUhFREZP?=
 =?utf-8?B?dFhzWGYzalNWc3VVU0cxbmcvVmFUQ3hFb1RjaXFGbE13WUsyQUlJbWdZYnMr?=
 =?utf-8?B?enZyOU03TnNDNnhET0RJQzRZNFlHSlNwWUMwSVZuNWw2MmZBVHRYbHNHaFBn?=
 =?utf-8?B?RmZtR2NadUVYYlNLaTFLYW5lVlB5ZmFPRUhqSnFyb2xVUnpsck13YXB4djIw?=
 =?utf-8?B?Q2dYaFg3bmp6ZFZqZEp5cjYrYkVVZjFQckoyYU4xV2lMdWR5YzdUWVVBRXdZ?=
 =?utf-8?B?WHJrdGJFVlh3ZjZzNjR2Yjg4ZGpMUmlycExKQjF4OW44dC9OeG0zS2R2NnhT?=
 =?utf-8?B?b0FuNGJxTVI4ZndsdXBmMHNFTUZWUmhBMHIwZTk1NmZpRXRkc0hGY1NhWldq?=
 =?utf-8?B?bFMvN3pZdUMvcDVvN2J4d0Q0c3RqdmZjZUpnR3dBU0ZmTU1SYnJ4MjJWYXFj?=
 =?utf-8?B?RGI1RWtuOXdqRTFxY1hQZSsrWkk1bkR1bFBHeGZ4ek42Qmt2WlpEUit5Mnky?=
 =?utf-8?B?dUdKMG9WeURWQm1IU2JwSWxselFGMFlKWFhuNTZqa1Z2djcrZXZWYUk1VkUx?=
 =?utf-8?B?dkdVRytLRmNJS1RwdllyMDNRU1NxL1F2cTFLUW0rYVFiSWtRSGh2MXRJRjFu?=
 =?utf-8?B?RU02aThURXV2YUtIbHRrTWljMWdKcnJ0dVl1UHVmZVRIYUFnYi8xZTJUcFQr?=
 =?utf-8?B?TG9rbEI2NUlxVytRbXJJMldqOE1laWc3WCtFTXZrRVllR0NIY0NxKzJ0eVlT?=
 =?utf-8?Q?MkeYMF0LgJ5A2lvFHR5dM+U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Z+A8Brkgty62gIoU/c76EnoGLNEmqSolO3SfNgwbuI5WxehI/r3qu4bWYKNIEoUOfGQ8fmxo8+lsotRR4bVbs9PFZZbJ1+K/Ejb1AsGwdloF2MZ5HrnQcInDYqWoyGmlXHPvbhbu3525GFfAZkjWx6qrrXlVHlJ/JuQZwCnpZJpHRFnwVtLIPTwj2pro3aHRQYN0vkyTDul7WqfukJVZOBzMUSKXolVwdR36dc/RXeSS12v/oD2in+5beSJ2Kb1pP0gsiL+BFumcNOWRVYQEeNt+3tvw6Yu+DmMd2XBdZQePOi3XOkLtRRGEJJfFVH+XnZpqCWIvfNxqeSIIuREJz1GqdVI2YyICKuV1G3y8ssyjrRZQg9H9DEA1IA/Iyu30oQH3tRjOF6z63A3QMZp6YHYv60ub7NjBE4s/fNCnew3nITKi1sFLkQzxXE2EAIf2d0Ne3tocHqqC8aAC9e/IfJpQB3DYDxdhYzNljwFwkAQuAArQN1mBv4qQKsr96khdoWcVSXteDLNJEOH36iU66fLdXNgbsM30Q2L5beaD1LsYKsttLfbOBHtrDWZOP7QyV6GazA10V0m3FkdkhXEEiZgDsIly6t6VsFk/GhOHTEc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f399d7d4-dece-460b-f288-08dbfb5c25cf
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 21:48:59.5009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +h/krIeT2Kthy1k5m874IeD8Ay/k/78O53VUur+elnvfn/z3IUOFKMF+i4VXGDuWP5iMXk408BNpCf6GIkZvuq7Z6GiFJLDTcsuSs3mIDl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120169
X-Proofpoint-GUID: L1per04m4pjgDUTHGOqHEokoCtoSprTn
X-Proofpoint-ORIG-GUID: L1per04m4pjgDUTHGOqHEokoCtoSprTn
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 12:57 PM, Matthew Wilcox wrote:
> On Tue, Dec 12, 2023 at 11:46:40AM -0800, Sidhartha Kumar wrote:
>> +	/* Slot store, does not require additional nodes */
>> +	if ((node_size == mas->end) && ((!mt_in_rcu(mas->tree))
>> +		|| (wr_mas.offset_end - mas->offset == 1)))
>> +		return 0;
> 
> Should we refactor this into a mas_is_slot_store() predicate?
  yes, I think we should add helper functions to identify the different type of 
stores. Thanks for the pointers to code style this is what I think the slot 
store identifying helper function would look like:

static inline bool mas_wr_is_slot_store(struct ma_wr_state *wr_mas)
{
	struct ma_state *mas = wr_mas->mas;
	unsigned char node_size = mas_wr_new_end(wr_mas);

	if ((node_size == mas->end) &&
	    (!mt_in_rcu(mas->tree) || (wr_mas->offset_end - mas->offset == 1)))
		return true;

	return false;
}

thanks,
Sid
> A few coding-style problems with it as it's currently written:
> 
> 1. The indentation on the second line is wrong.  It makes the
> continuation of the condition look like part of the statement.  Use
> extra whitespace to indent.  eg:
> 
> 	if ((node_size == mas->end) && ((!mt_in_rcu(mas->tree))
> 			|| (wr_mas.offset_end - mas->offset == 1)))
> 		return 0;
> 
> 2. The operator goes last on the line, not at the beginning of the
> continuation line.  ie:
> 
> 	if ((node_size == mas->end) && ((!mt_in_rcu(mas->tree)) ||
> 			(wr_mas.offset_end - mas->offset == 1)))
> 		return 0;
> 
> 3. You don't need parens around the !mt_in_rcu(mas->tree).  There's
> no ambiguity to solve here:
> 
> 	if ((node_size == mas->end) && (!mt_in_rcu(mas->tree) ||
> 			(wr_mas.offset_end - mas->offset == 1)))
> 		return 0;
> 
> But I'd write it as:
> 
> 	if ((node_size == mas->end) &&
> 	    (!mt_in_rcu(mas->tree) || (wr_mas.offset_end - mas->offset == 1)))
> 		return 0;
> 
> because then the whitespace matches how you're supposed to parse the
> condition, and so the next person to read this code will have an easier
> time of it.
> 

