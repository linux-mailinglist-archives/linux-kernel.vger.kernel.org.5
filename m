Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2765B75AB45
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjGTJrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjGTJrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:47:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD6310A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:43:57 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K95uIO025162;
        Thu, 20 Jul 2023 09:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : references : subject : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Yvq5mOBR20yIEGlV3G94RKDuDXYbygkAmVJ9TqHpnxU=;
 b=rZKEJRpy40xV6qFpn7+89RZjh5X4xKEPR9FmoJMftXIk+aWt7TRZSFpxmZAi91pQJp6G
 VPxH03eeAQMnRqodzGhA33k2mVR3gneB0UM5tYotAg14cfMiCzIBPYw6nTZuGIsLJH6G
 sNQDPv9mMaq3cEpQ+4hATmddXbfXJEPezpZhDIofOWkmVjauYT2NamzE/zoX+orLQR9u
 Qp3KmC1hNUw1ub8R3wngNe8upqG7LL+G4Q1A+o0d1iIss8aTtjqACPz13sU2ZPOpFIoU
 lqCLwo4Nf8cBe4MU0OwIdigpr87kTSK0B8N1Kdu93ugQPG37Hful2YCc8YNqNS09lWp+ AA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run7898sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 09:43:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36K8tkkI017369;
        Thu, 20 Jul 2023 09:43:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw8bs8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 09:43:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fr75f4HzD5IwzBVa6M7CKnAz2AjIW1647XGnp10EbwHBxaSso/Wn0ktMi83sSW5L6aqKN1lPQQ9tl1CI5zBxZTT5Za3AriIPWJoWUJY8J8rSkm6NqsZQ/5KLjvs8s0sDOesfW+SAwPA3ZmDc7xnmN/pBDV+qcsvQhBmwUGIdp9iYK92AYqFw29lCwzs4k5F56ZhFWVy/AUNIHf1bxpiHnNQC/DWQ4yv+IKoFOsRFNfAJYbzVx7q0M0uxdNvmNtXTqw70gMTvSM7dXZFN7NTF1kwuFPwrxA1Vz0n2KnNbP7tDuxNB2xu5GQ9u+MGxHKAlH/AhjwBMhcn3cRxWntq/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yvq5mOBR20yIEGlV3G94RKDuDXYbygkAmVJ9TqHpnxU=;
 b=VKjnk6yON1k6LfJ9DNXAsHYLt8q0d9pi64EnVElgHz3UslMgTfZzHHPPqv46wnreVuiciRnt/nbhB3p5Y6Urttt36iMD6SHFdWjOWwUzR1OTmR22Ym1VIVStURHV01MJxV2smTJqPXcnm2IhnZYKO0L32WOKSHIHKJLVSZ6RmoJkm2Yqk9lGrGOxeeKO/du68Q9r+cFVE+M++4hEVKcBT62HfBLrWKsHHn32AmcJgV56gjMUApX9sATTCnRupA+SInooILotlWDVc86IcstBDQJs48P5RRkZly7TcWkJYGoCRz8Fg5t/Jle9MqWFUKwth4OF31n+5lDTRljP80+vfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yvq5mOBR20yIEGlV3G94RKDuDXYbygkAmVJ9TqHpnxU=;
 b=Zg3w0foDT4IxULxKf6NAjttp2WWFoxsyDZYbh55eOmdkyzpiSfi2T6kwItIWWv3WM+YTj2EB0MW5/XkI33nqXQUyxpUEYLQK7q0sqxzP72vwnSnfTOq3t68tz1dpFnVUynjodDrBYORyslRNRWzxn8PddaNZ5D4kjTI78mdswDk=
Received: from PH0PR10MB5894.namprd10.prod.outlook.com (2603:10b6:510:14b::22)
 by CYXPR10MB7975.namprd10.prod.outlook.com (2603:10b6:930:d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Thu, 20 Jul
 2023 09:43:40 +0000
Received: from PH0PR10MB5894.namprd10.prod.outlook.com
 ([fe80::dcac:281d:3279:713d]) by PH0PR10MB5894.namprd10.prod.outlook.com
 ([fe80::dcac:281d:3279:713d%5]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 09:43:40 +0000
Message-ID: <9830b94a-da88-48f2-6fcd-da46b2e2ed0a@oracle.com>
Date:   Thu, 20 Jul 2023 12:43:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     scott@os.amperecomputing.com
Cc:     catalin.marinas@arm.com, darren@os.amperecomputing.com,
        james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org
References: <20230627002939.2758-1-scott@os.amperecomputing.com>
Subject: Re: [PATCH v6] arm64: sdei: abort running SDEI handlers during crash
Content-Language: ro
From:   Mihai Carabas <mihai.carabas@oracle.com>
In-Reply-To: <20230627002939.2758-1-scott@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0191.namprd04.prod.outlook.com
 (2603:10b6:806:126::16) To PH0PR10MB5894.namprd10.prod.outlook.com
 (2603:10b6:510:14b::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5894:EE_|CYXPR10MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 80986982-0baa-4f50-81dc-08db8905cc9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oc5XNWY3g8vvVBIqHycgOBBTdExuAnQm7tsv59TW3eRU6Hf/Ao8Gckzz+D87bTnEDBDuSnAQxhH0oGS8MdNoOPfS8UfAu8PRiegFNEOLYlKnB4DCXRHoY8zPAIHBwxbbDax2gLOWMedWUdOWDPm+3uNf205dj3Ul/MIW9SOk4tFC0ArUVA52DdOs5yUxdFv64CYm547Whdsa+4GV6RvBvzCrc9fDV+N3u/LfvPqfe/Y+ahf0ITnQ+yOIxp1+kkS/Q0k6G3gRRz7cNZikIVek//yh5U2cMfRhQ4UwYLUQ/78OEzNC+txx4Khavat6HmiH4TbfjwHoWzXPlOSeIahTmU9QgidJZyC6WD8Umi4mbxV++ZT7BbY71WLbEkhX3SW4RswWOsuP/VPywSqHVwE+MW8XVu3nFAZMkQ75MAnuo7sFAqZZeFhLjUB36tAXzGapTZouwst1woD30Jbp9DfqMuihLAUrY/E5qssVWhxCD/1ZYKThFuCsPLYn57qmRlr5eQYqLKB87c3T0aqtQifQTea26+LGwK+5YkDtaRtYjRLCrArnUHGUlMLQ01n4ICVrLSTbUD8LR2OthvWWK1OBINn7l/C1w5UtXHY0o2QcuISNQTLcmnNCFwSUN01BeL02TBYyHVp/fPKEcq2VhPvrgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5894.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(31696002)(86362001)(2906002)(36756003)(4744005)(44832011)(31686004)(186003)(83380400001)(38100700002)(6506007)(26005)(6486002)(66946007)(4326008)(66556008)(66476007)(2616005)(6916009)(316002)(6512007)(41300700001)(478600001)(6666004)(8676002)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blZWSmhPNzEzdjk4cER1VkNaVTFjSkFpNGxSZVRTdlgyU2ExeXpITGFBelAw?=
 =?utf-8?B?TUlIbFYzYmdYVENSZXJPcmltK1FrU0RtSHIzQXhLQ3BkaVQwck1OU05hWkNL?=
 =?utf-8?B?OVpKYTFqeEltenBtNnpNajA0OEJCRlZjWmFrRmc5QWd4L0ZYdFUvdHNka2gx?=
 =?utf-8?B?anVNTlFtRWN2N0lQcGQxQkxUa2pZQTdxblNjNFhGZStiMkIwV2svaUlHYWtY?=
 =?utf-8?B?dWJ4ZGVEeDlHVnhXMmx2SmpaY3hOanRrRHNVckhyQTB1UVhjaVpLRVJiWkVO?=
 =?utf-8?B?SHFQQzZmQ28wWHNNWjdJcEJIbHpkd2l2RWVld1hlRHp6Q1haOEh1NmpQUmFk?=
 =?utf-8?B?Qk91TUVzUXdaNVl2aGdhVEcwS3hBU3lTOUxSUEtUL3hpS0hTdTFyb2thaDNh?=
 =?utf-8?B?WHRjTUthRGtEbVd3L3RUN0VGVFB1OXl6ZE80MjBlQkZNNDRJbkFINEJPWjNM?=
 =?utf-8?B?MkZIRTBDa0VlcS82NWNsSUczSWVGMVFmSEgrZzVTSnpRNDlrTHNQaG9keHE3?=
 =?utf-8?B?SEpjL3BHc3FvbUR1Ylo1ZVNQcWRocCs4RG12N0E5S1VCLytINzRhbnZxZ2lP?=
 =?utf-8?B?N0VJSWtCWHBxc3hIV0RVUWVaSEFSSU9yUmJFWDFSeDNnMERDd003SFlLMzdM?=
 =?utf-8?B?amZWb01mTnplbnZiTGpDQVRhUkhrQ0YrUXJKdWl2ZmlpZ25vVjRFZWliQ3Rp?=
 =?utf-8?B?MG1QVVZlczVkN3I4c1UvM1U4a08zYi81MEpUcUV3UXE1L3ZNS3dGRkdXUEtr?=
 =?utf-8?B?YmpQYWxNUjM3K1kxemYyekVOVjlzNVpCWFYxcElNc09pRlhxY25wV0FiRGhW?=
 =?utf-8?B?Y0oyK2hmMlRBUXk3dk1lVzZnaTk4ZXdBbjBJN2NCbDJCVUFCZ0VJZWNtVTJj?=
 =?utf-8?B?UGRSbWxXZjQwMGFST1lWSi9tUEtrekZQVG5ITU1VeTZDRHFycEhKWldreWRK?=
 =?utf-8?B?N05sQzhQQ1ROeEsySHJlaVJ0Mi9SQS8yNkVjamhDeUNFUVZUcGRmY29BdUg2?=
 =?utf-8?B?eHBEL3JwUm9hZ29vSXM5dHdyYVJFUHZ0d2RpUmhyRmtxaWgvUGo1L0FEMWVo?=
 =?utf-8?B?MDN5MEFlbk9hWktxNHlHWW5YbFd1MHozNURTU0VncmN2R3lXNkI2N0dsWDlj?=
 =?utf-8?B?eTNvaFhhZndRTERQU3FpOFdtdjRXcFYwVFMzdVpBUkwwOTliSW9SWDhHdGxM?=
 =?utf-8?B?d3BCd3dHb2RtSWR2SWZFRHdQVnJBdzVZL2xCMmdVVzlCcU1mMkZuU1NPeGhM?=
 =?utf-8?B?YVJ3UzN6R1JKQnpQbzhIT0d1bHk3UmsyaHdORFc1cVZKNGRVVHBxS2VtaE0v?=
 =?utf-8?B?eVdwVHpoWk5qNVlYQ282ZGwrNHRsSk1oNkFKY0dHOWZkL3Fjc1pQazNTcmls?=
 =?utf-8?B?Zyt4aXRmT2ZCVkNkMlQ1Z3JFKzYrSGNQZTJ0b2NIazF3U1Bpc1VtR0EzMVlQ?=
 =?utf-8?B?UEFjNUNRSldHaHMvcFBydTJ2dEFCNEV6ZTZpNVVDQmtKOUo2ODN0M05VTjlN?=
 =?utf-8?B?dmlpUEVWL3RkL3cvTSt2NnU2OXBiaCtldkhYeWpWMjh5TnVVSlJEQUpBZkZ0?=
 =?utf-8?B?dCs5aTdUOVZUaDFVWW93ZUxPTU1kUHZGRUpGVVdpVGRTeFdqRDltdlpqRnYz?=
 =?utf-8?B?UnAvTUtoOThsMjRvMzZCdDI4RlpnSXY5RWtVYW1UeTZzQmRJV294dEJjemQ2?=
 =?utf-8?B?TVlUT3k1Nk1NQXVmTUoxeWlTN2RITFMrZnJxOHZWVUZMazZLU3J0S1pBQXh3?=
 =?utf-8?B?WEZNemxJeVg1bnVZZ3YxUUhiNmM3S3pBeVZ0SDJiOGNSSWxGTnZ6OFA5bktx?=
 =?utf-8?B?Tjd6QVVzZ2pVUWQ0cjhHS3lTbmJ5eHRRNmh5Q3FIb3VGN0JuaU1TR3U2TTBO?=
 =?utf-8?B?WDlSWkZaRmRBVnJXNWxPNFBHZDNjTWZKTHordUt2MGJ2M2hXR3JTeVRjSk9F?=
 =?utf-8?B?Ly9PWDAveVBDbm9UZWF1RmpXVjQ5YXlxRkpUT2phRmxieWI4N3AzUEFWbWkr?=
 =?utf-8?B?RVRjY0FybllRWm5GK1JYRi9BQ0I1a2V2YXlEWEhkbDhRczREK3VPdnVBK0JG?=
 =?utf-8?B?WU9YMXdyaDFtQ1BLVkNvMmhyUE1PZFhHSmhQc2V4THVuQzF0VG0xVEpVK213?=
 =?utf-8?B?Q1hUbjVCclRCNEZTYlhZVHlScktYc09tS3pWQ3p4UDBDQjVOcG11Z0xwbXBu?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Mnuipe8OJ/nAzVagqbSRn0+o2B6GRBYX75+3iShMiY26YJvzYj2bL2XuQqGri4JbIqgCAHYYHbNj3cxx4Q0T9YWz8pSUHSBOKzPgjLPPWzdM0NsIVSIBjmR2IZZkj9W3emJLW2mhiEJKdaJYuu3tF/JKQ8Q28YcDXmbjWfztVVkhNBzdPG18tlTf1NpRH8esh9n4Qi5Ex02HPcMhn/GbDq/XzwAOOAhRyHYrBLaDzQbOgNQmrWqorLm0ylHNN89aVFcO3Q56VlkBLe0RjShm06lk9qHcFqBFVaqM434rFG64bMEzCkcPfGFtKZDvx5+UJGeZ6agtUPVR0CK4DprmU08qyVNu7XGjKAqDWi8pss7hTyCKJ95pMdbeCtNnbhxrctfLhpoBog/27Zp50oaIqy8eA9AKAVGEV9Zg3q38kMG06GfV4HmuOhQaysz6uXquA6IXDzpHrUepb7HZvsqSvjX/GV0DYNjOcF/cpuBaJoclz4GoMJkgwmKiBpvMxZOz99SVp67OSc+dRYUA94D5EMYrS2WlZPnyfP2pU8NmPwzRA5wdO6Lcnbpxxq9c447gSaZFozBZCUTrQmvFGqJ47PQPySU8HEavXeoErdd1Q0U4ILaciiERKOj5y7ufT8dyzUvREQPi9JiavXDC/HQWmjRJcfMHpBexLze8PzNoJRU8JXGIeWFvuxjCQOcjaQreZH8S+bhGCTpkMM0ZV1b+/thiVYsXRiredHnohGSt8QG4JPyGXW4je6dbfxjZMq40yLHghqn+uGHhv9eQk+2RIN6Kk03EQ1QJd8n3gmA9QI3LNfOijTkZfs9u2wDAHoNGBLUdsgqSI4A+2CFxPuJs9cSnWuPydRKQHzpeP1V874Qw6xMV1XmsTIuHdgkjk4G+EMV3Mddj+6OLssCnwdSLnEdf5fdUqeKvoAhzwVfnp20=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80986982-0baa-4f50-81dc-08db8905cc9c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5894.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:43:40.5242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xSxQ6ZPaTmlRHSyQL1fXOyTSLYhyy6KA700zRnwo3KptsYfGfSJD49p5k73qg3Qc1zikPMze9TTq8BfUC+kekSGjHcmNrATtL+xe/GUo5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_03,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=831
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200081
X-Proofpoint-ORIG-GUID: 5K6j6z5qTUjnfxIJd6qqdp4qMy6o6COw
X-Proofpoint-GUID: 5K6j6z5qTUjnfxIJd6qqdp4qMy6o6COw
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > Interrupts are blocked in SDEI context, per the SDEI spec: "The client
 > interrupts cannot preempt the event handler." If we crashed in the SDEI
 > handler-running context (as with ACPI's AGDI) then we need to clean 
up the
 > SDEI state before proceeding to the crash kernel so that the crash kernel
 > can have working interrupts.
 >
 > Track the active SDEI handler per-cpu so that we can COMPLETE_AND_RESUME
 > the handler, discarding the interrupted context.

 > Fixes: f5df26961853 ("arm64: kernel: Add arch-specific SDEI entry 
code and CPU masking")
 > Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>

We have tested successfully this patch on Altra and AmpereOne.

Tested-by: Mihai Carabas <mihai.carabas@oracle.com>
