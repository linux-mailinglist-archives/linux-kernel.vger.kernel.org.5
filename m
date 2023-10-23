Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA90F7D427A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 00:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjJWWA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 18:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjJWWA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 18:00:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2418F10C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 15:00:25 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NLi5H8020581;
        Mon, 23 Oct 2023 22:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=UVCebi6LtFk4/FFQhC6ESOTBzDn3wdGAb+r05BzMr5E=;
 b=TCv52kwt4zjawX2nBZfsvnuNbUrnzm64kYhRQPWUTrx8uDAxm7vyukRmBKM7Ud27vuPt
 TRTyExywOEuSv/1c8BRObByXn4NiiSP3tbWPlznhrFPXPL28TYH2jaGr2ZgCdeTJqklQ
 nkbUVocHxvkhaERSt+LUxeXREuMeg3cxiFB/2oq0p2jI/3/Duwuo/zJ9GxZ837IVoyML
 p7mH6AtlklbeeveqgcvRtsTHw4oW8miRkI9eXdvIK7WNneHWvcQWeIenEZ3P42pd7FaX
 3JO8us7E2Dy8umy8HbI0FczZ84/b/F4FeXvg7ZZC5k23gVUNYGZO5TW8jBDGl1aP7lEf jg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv52dv645-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 22:00:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39NKx8FQ031095;
        Mon, 23 Oct 2023 22:00:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53b2mr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 22:00:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfWR2G6BkPfV1HuuRB6YoTjqHmspIt7g9KLCUroD6mEKH0BRnDz8JkjsIYCl4kNy9DqMNbNF1KBKgJ7HzThvSFknurHYKh7m1MAgSs7FDCndy6TiWGRju7VlyJzDw7cDUlPDUGx6pOpkANOLTTt3NMvRKgRbp8+W9/SF9xti1PpztB/2AZNEYoBdRQjWzfERVmggrJk9Sv0agJ2Bj2pyEh+CrXSAuZmd4lckTXndonzTQptpsrSH7P1aNWhbiRwnpM2CDoGQxnS5EM6BEkgkXYqGlkNzAlSO7s7/9GhCcwAtr7gQ0bhxPDbk/I7Yr/xuTp1/bUlEE33nc/3TG/ecVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVCebi6LtFk4/FFQhC6ESOTBzDn3wdGAb+r05BzMr5E=;
 b=k6xY5BczTaFMmhWPMpN1575NsBKkeKq21/gCjkilYhZtRdoee1xfjf/W+l8yJ/Max5LbNIjTZQnJr9oRVdHsplkxf7LH9FrJWz1byml/xVnBbu6f3W8MNRso4a2MUTapFCaMKQrHaBGrMSfvt5j7RpuOOQUaDkLlWft3cJYI4dW9ZKnea9XU7ADrJ5NkziYVPUksZXoUQbFN41jJH6lk37cJ2ZBaKPZQRJuOjHHEK+7zwpASaxbaX78XCwlB0+J/SvczR+/kwrkI1ND1VVKzUVVAWL4DULVID6x0wDosKTIARuvyHb+j3Zf3t0jMxS9YJ1TfWZjDI0ZOPjv8SyFB2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVCebi6LtFk4/FFQhC6ESOTBzDn3wdGAb+r05BzMr5E=;
 b=X2D+CTt5W/466YpHa0+rNG5qGLgg1a/a9tf7knMqIgaoAVLZB2JoffaIkr0sbmyROLaBevWQydxOzm7eag3UcSycZB7zZIwHGD2ZT3fAWitZlJdjIqWpMkdsKnuWLoR0hjn/H8R/Vsi1DhN+cwhZSCl//hGOAsrSmORMNddbzD4=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS7PR10MB5376.namprd10.prod.outlook.com (2603:10b6:5:3a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 22:00:04 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930%4]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 22:00:04 +0000
Message-ID: <4d03661b-4289-46e7-8760-32a186783b73@oracle.com>
Date:   Mon, 23 Oct 2023 15:00:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] vdpa: decouple reset of iotlb mapping from device
 reset
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, eperezma@redhat.com, sgarzare@redhat.com,
        dtatulea@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEvkSFcHXC0HFw-NoDtDNnaucJbpfPO0Yho2r1QP8F6zSw@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEvkSFcHXC0HFw-NoDtDNnaucJbpfPO0Yho2r1QP8F6zSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:254::7) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS7PR10MB5376:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c68c0f5-a0e0-4531-480a-08dbd41369af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pdmrj5VVWCIn9CvzayL5b41ZaysMhKRQNs1f+ew9teXAJ7pwMFZdjoi1PhT+2wN/JTfDtM1prTN+meq4o9kOrG3Htu3iLk6evkhOUg4Ybz+2BNmbhrIKnb9o8qwBHlGO+pCYg/AnTD30ZFVc0ECMjYwbOouG7/WOz4GLKvWmm9lOBi4/eMbeMtM2uzs4jgXZLPN2XV0aOVBNtUiY6+UUkNEXeD2D5VH3jkzB2D1AoXvddQEyH/lLX9OS9h4nnhnuhdE1eBStZoXGCRK46rNupscRrFp38Yu4oUwDAF/vnSEHlrj5BkT/H9mw32Luf5J5SyKsWcnoQPCxvuz1xk/529vW9x2AW9R6VuLYDIl6MZ+wG4qLOMOQmh9JfvVgJDdd0K31w8FNTGEvj68EwhhNrgrZT8hl+rmLbWraLFkGVGH2AvhZWdrYBv+4AgdWoWbuehFYxzmyeGJInh2AIV/kdqme3tZFxvaV2+Uu5hfgIMjiZuLVp5OVKHUYVfCGPgjg7hd/neyZ1uKdHUS9R0ym4mQv8B3GOliXFNxySh4O3cVW/WDgWuMNyUPu+XswctEcrgujC5zmWnQXimqFDUCwmJrWgphll3MSi6lmsOHO3cfBN51nhXm/RIyku9Zut1RcQMsBlR416lCFbScOvB0RVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(31686004)(66899024)(6666004)(2906002)(4326008)(41300700001)(8676002)(26005)(6506007)(38100700002)(5660300002)(36916002)(6512007)(53546011)(83380400001)(2616005)(6486002)(8936002)(66556008)(31696002)(36756003)(6916009)(316002)(86362001)(66946007)(966005)(66476007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVczdk5Uazh3ZVZZcE5GcE5jKzFrUG5OYmsycElBaUVSbnBmUFRCMXBLRitS?=
 =?utf-8?B?cmlWTFJIaklIOTBxa2xZNitGOXlNd0xRTWtHM2FnSjYzRzJxZjRPeEhhU0Rn?=
 =?utf-8?B?RW5qZkhCRGhRNi9Ca3RmNXZMM1JjTVRyUFFiMXZrTnM3MU9scFhTSEZ3Sjcz?=
 =?utf-8?B?M2MrSWdJd0owM3ZDeUZidkptMStySjZGM05jd2FrT3lqSWRZcG5ES1hqSEg5?=
 =?utf-8?B?K2dyQXJQVnh3ZW1PcHNsK0RBdThITHRMZ1prcThtbkU0d1VzZndRM011blI4?=
 =?utf-8?B?LzI4MnhUYXpzSXdLcndMM1NoOFNiblI3RkFtRzRkcm0rdjF5aEk2QzAwYnYr?=
 =?utf-8?B?MVFhNTRPSnFQelMvbXNKYVlFL252M0lETGFSQTR6ak9pU0QvTlJ1U3pZYjJs?=
 =?utf-8?B?akVEUlpiT2xwOGRlM0pNMXExVVl6VEhBTWhhL3FoTFRXa24rMlhYZUJocTda?=
 =?utf-8?B?NnNHY0NIMk0vU3ROcFhZTkEwdTBVRTFLNFdGbDJZV3BHSTNnNjdzNGRGaFJ5?=
 =?utf-8?B?Ulh0S2oyU040UklGSjNjbXhJMDhvWHF1Z1c5aWlwbVo0UC9rbW9lSGdqdkpw?=
 =?utf-8?B?NmxGNW8zTG82aW1ZQkgvMDFyMkllalBjWEZ4UG1oeWcwLzhVSGhMY2NKM1pC?=
 =?utf-8?B?SktWcHdsQlBJS1ViWnc2RWcwdTNRdWtieXZlbXBJVmZZa0puVnd2T2RaeXNh?=
 =?utf-8?B?cHlLOWlBdlFMamE3MHlvZEFHbFo2QWxFSW5sQTJmbGlFOGFyc1RTY0V1VFp2?=
 =?utf-8?B?a3czbDlFMnF3QTVLSzJ1QnNkMnBleU5lSUd4SitjWEkrTXNObDRSL1diQUJD?=
 =?utf-8?B?T0F4c0IwR3VMVEozNmZZYU93dyt1RnVtdEYrSmtYMnNnL2NndHRSMklDNk45?=
 =?utf-8?B?bHMxeE1nb216bXhNYkVJNUVra0FOZW1QVE5xTzI3cU5FOEFWR0M1S2R2NWpB?=
 =?utf-8?B?YUpjUDhCNndUelh6QWxrOFA0K3ozZU04enhCMk5nWHRKdXZyVkVURkZhT0pt?=
 =?utf-8?B?akNqKzBkUEZvKzBUMVhTQ1Uwb1QxVFlLRmwvYVFWeXp1RkRLS3JGWnB0WVBw?=
 =?utf-8?B?QTVsTGJwWVVvaDNGZG5CSGNmZmtlYks4QWQ5UmZRR1ppbGNlQTBDT1F3MGdM?=
 =?utf-8?B?SXkzWmJSRjJ0ZlllVGM1TFpLN3R0bnA4MG8rTlQ5aTE0blh1SzZ3dFNsVDk5?=
 =?utf-8?B?RFVrclJNWTk5SG96K284Wm1YZ0o0eWVsS1FTb203K2JHYXVXVUFQcC8zdGxz?=
 =?utf-8?B?QnJ3OUw5eE9qc2p3d0RGbnJMVmlYbjlYeW9UZmJ2R3dXTmI5OGdQeldNVlRN?=
 =?utf-8?B?VmFPbFh6NmxFMkRuQS8rUTZFZ0F4NStIUHlqT01FYTd5clpLVjk3eEJUOWYw?=
 =?utf-8?B?dm9NRmpoTVZOS0ZDUmFRY1pkUURuSTJ2Uys1cmVLclpLTXlKc1d0QkswSmxC?=
 =?utf-8?B?TmYvRFRmckh0OEhnZWI0dXZNYXVTNDRYQVlnaVIzQVZFenZPTHJOaEpwSFht?=
 =?utf-8?B?dS85RnhmeVRIR29YUERWdG5pdFlBQmdKQzJlRGZDWWh1UW9pWUFRYld1bm1a?=
 =?utf-8?B?SWJnS3UrM2pNZFdmOG9IV3BiaUtoODlSMzA4NVhxK1Njdk1nalNJK25MQ1NI?=
 =?utf-8?B?TG5OLzhIeVhBOVgyc0xCMmpBOXBPTHhyZkh3OHl5MERDcklXTHo0VXR3QU5S?=
 =?utf-8?B?WkhjNzdXOWFwQ2MxekNUQlRJellkNDMzWW5DSTUwYjhKVFNQeko2SWhseGI1?=
 =?utf-8?B?ODh6ZU9JcmRuYmw3OVVIK0JIak54Y0l2aE9YMUhDblJBdVVPaUJXbEZ4TWJq?=
 =?utf-8?B?aVdDekRnWnRtaXdwc3FPSkVlTW9JY1dhM25jaEhJZkNlK2pIQVRJT2JuM1ZS?=
 =?utf-8?B?NVQyTkRsT0tJczZIWW1QdnhQVWxNY1h4eldMMDFEUC9lR0d2dzdaQmwvWWFQ?=
 =?utf-8?B?YTdrM0FZanU2NGd2V2J6SmkvZURIRU43SHQwY1NsZUttVnNmZWZqR09zdUhm?=
 =?utf-8?B?dXRoMzhNOG1uQklhdzRBRUNJcmJHMXJ6WnM5YUhTd0huaE5rbHNTL2plbHB6?=
 =?utf-8?B?WEpQLytVbjd6QWx3Ti9ta1pIZG1UOE9nS0RUckdEVEtVOURodGU5V2hpanVL?=
 =?utf-8?Q?Letp942AYmSheWyQzQGDVSIZ1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: As0NQJOBqZCR4dfGzexzEDXI362vxobFpTA6FjO6owDvcwv7lQLcUgK78Zj0zVXz3uKzcOTkwUR5BQDABwdqem6vGduGDUmT9QkAoREHTk48i8lNeS9p6E+QCOI3US+0VVtin6+pwm9KdE03SuK7MydOdj8mdDPmZER7DqjnBTbwxiT0x8rWVz5XhK+/A4BJc+Y4tFuipDv2uVWyWWbzikh4kHF7SiWGjL9gUavaG4KhXnUwjyDFEg3qImqjg2Od3XHtkb+BOfPFTpcHbdBoVkh0yRuQ0Tuod9kw8yIHYQ2iAJ5ViWJbRtQDxkv3oIy1WrB3chtqPp7ubGe8m99UE1aOWLTHTvH2m95j2LkM/ts1BubdGgJDeJ2bSpWfmB3pzFfHi/AMahMVkaNOOi8t9ofs/gpsf4O8ZYs9wtdiNhfIEb1Akfdza2oxgKAPQZT+7x0911AMFDFd844ti0WDUqywNW2oVhodeZoN98i8jDc4HiZsnpd3vfVV+kATfjEuH+DnD62EtjXwBuA2Nm7MJavhlPqG6Wwuu27GcUn4TSoinqZ0R7VTBfvUVVA0LD8ifJBR7eGNakT2V9qfzUK3SvCbJEFV/TEgtpceMmYbmE27HSLzkxsL/4FUW1TSHOXnOvcoGWR3wp1JG1OJx5DkIjOjIrGGMb/QQ3T2eil0OcCfRyJ/bZsASsnJsLtWI0MYqTMxR1Cy6DSq42oM6D69JidjWim2P5Kh/mhKw7H81VrmEqxLHcK9MtBdslSsIvzbe+HDmq6op6BkvdaY2Y1cT8jmGZBR+IeBw/CHuEKJe8QDg/P5CnhNDpw4BkR6wGuhgiQH6iLyDnGRkYcKHGjdAu+W+XIIqe7HhY9LzlCQp84n9Q5UeBU8en9TmmSWkg5TDz1eTbO1Qx2rUwbENZluhA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c68c0f5-a0e0-4531-480a-08dbd41369af
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 22:00:04.7687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pkf4J04d0tNqBbqhr7hWFs3+wQABawEvi0EdNcYyPNBhrBCfnt82rwppWN0ysz/90LbhqC0+3u/D38kQjynw0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5376
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_21,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230193
X-Proofpoint-ORIG-GUID: J7KMr18Ux7JNJBxV8FJhVnmrKtIfTn9_
X-Proofpoint-GUID: J7KMr18Ux7JNJBxV8FJhVnmrKtIfTn9_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/2023 8:51 PM, Jason Wang wrote:
> Hi Si-Wei:
>
> On Sat, Oct 21, 2023 at 5:28 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> In order to reduce needlessly high setup and teardown cost
>> of iotlb mapping during live migration, it's crucial to
>> decouple the vhost-vdpa iotlb abstraction from the virtio
>> device life cycle, i.e. iotlb mappings should be left
>> intact across virtio device reset [1]. For it to work, the
>> on-chip IOMMU parent device could implement a separate
>> .reset_map() operation callback to restore 1:1 DMA mapping
>> without having to resort to the .reset() callback, the
>> latter of which is mainly used to reset virtio device state.
>> This new .reset_map() callback will be invoked only before
>> the vhost-vdpa driver is to be removed and detached from
>> the vdpa bus, such that other vdpa bus drivers, e.g.
>> virtio-vdpa, can start with 1:1 DMA mapping when they
>> are attached. For the context, those on-chip IOMMU parent
>> devices, create the 1:1 DMA mapping at vdpa device creation,
>> and they would implicitly destroy the 1:1 mapping when
>> the first .set_map or .dma_map callback is invoked.
>>
>> This patchset is rebased on top of the latest vhost tree.
>>
>> [1] Reducing vdpa migration downtime because of memory pin / maps
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html
>>
>> ---
>> v4:
>> - Rework compatibility using new .compat_reset driver op
> I still think having a set_backend_feature()
This will overload backend features with the role of carrying over 
compatibility quirks, which I tried to avoid from. While I think the 
.compat_reset from the v4 code just works with the backend features 
acknowledgement (and maybe others as well) to determine, but not 
directly tie it to backend features itself. These two have different 
implications in terms of requirement, scope and maintaining/deprecation, 
better to cope with compat quirks in explicit and driver visible way.

>   or reset_map(clean=true) might be better.
An explicit op might be marginally better in driver writer's point of 
view. Compliant driver doesn't have to bother asserting clean_map never 
be true so their code would never bother dealing with this case, as 
explained in the commit log for patch 5 "vhost-vdpa: clean iotlb map 
during reset for older userspace":

"
     The separation of .compat_reset from the regular .reset allows
     vhost-vdpa able to know which driver had broken behavior before, so it
     can apply the corresponding compatibility quirk to the individual 
driver
     whenever needed.  Compared to overloading the existing .reset with
     flags, .compat_reset won't cause any extra burden to the implementation
     of every compliant driver.
"

>   As it tries hard to not introduce new stuff on the bus.
Honestly I don't see substantial difference between these other than the 
color. There's no single best solution that stands out among the 3. And 
I assume you already noticed it from all the above 3 approaches will 
have to go with backend features negotiation, that the 1st vdpa reset 
before backend feature negotiation will use the compliant version of 
.reset that doesn't clean up the map. While I don't think this nuance 
matters much to existing older userspace apps, as the maps should 
already get cleaned by previous process in vhost_vdpa_cleanup(), but if 
bug-for-bug behavioral compatibility is what you want, module parameter 
will be the single best answer.

Regards,
-Siwei

> But we can listen to others for sure.
>
> Thanks
>

