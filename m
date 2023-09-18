Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533717A5197
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjIRSGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjIRSGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:06:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D52119
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:06:41 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IA4Lx3025456;
        Mon, 18 Sep 2023 18:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=ldJYYtYGYdYSqcNyqDiPeInY+/3Ph9iEHKL+OuXr+Xw=;
 b=eMcqyOgJZpxdANByiYEfcjR4m9IBGZD4w5L2u4vP58isYdxKwjkxtw3w7RSggl+bc9Y8
 O5IwQMyEHtrBLW75p4uCUlNLo1URAhuAR0vzBQfljo1Joj2/ElCHctpWJ+4L8Fe+4vXL
 pBteZU8gnuT+pP+E0ffvDQuTBhvlpfjYuKdEXTwlvJRtHZgPmIEHMcV+aW4wMPCaUmYr
 tYC7fwjmcimSf19+W1l99bEDvEybqMmxIrohCnDeq8NumVS3xPUT7VNtxkIZ13Cde4IN
 ZRuOPPYWpmFtlkNlSiiF14NYIAywhQ3/oPSjt/USnICyasiLUXGKqiaaCF0e/qkZ3pz/ gQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t53yu35fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 18:06:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38IHcvnL027067;
        Mon, 18 Sep 2023 18:06:16 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t4vswg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 18:06:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0JNndMQirI46RvXJcCotMEydBGisS8W3WvVhaEblUmkus97mBw260Nykt+LJAFFynOJFYNSRpq/ghmzyBqS0ri9h/QjfWARAxYdllGfo4PonAHvCVnjwD7bvuilqSl9a+3iF9uImN1MhJJ3RGNiiwPj0arl/t6YOl5Twej1JKggUfoIkhWiRD78lllq6SbHJfusceKiCYn13PD2mFS39FmbDPAG4NQnRamQHyKvN6WHPvN48tJ1N6+20wUunZqFHgslOaEw/xvBLvlCJTB0cr+a5wwXGZa41wYTr/+htfyKrzJr8sLXLvSPR+cMErNpg7LdRxoBPruiHHhUTvIMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldJYYtYGYdYSqcNyqDiPeInY+/3Ph9iEHKL+OuXr+Xw=;
 b=JpkU0QJ6Kz0OdZqgA4A6uD6GJSrn/9nQzqQvjaKC0CUGpyycQF5+ydrOeMjCPh+dz78Jj7/lWJfJVX+60omRdWaWCIq51YMLyMwbfDqtTpZ7GdTRS2YGD5ypENhnV8ZsC+BiTpRn2FVoaBx/E69l0PmfD9pDkO76i3gKFK/txViQaJmrmOhGVJ7hzWgxfi8/ZhStEzDUTZV32+mddX4Bo20qvP0dKskR/FaiszuZJHYKgkAlcVGu+DM8iZU0icgbAU8s/OrDRmDt803Z8aTCD4I5kyThoSqFSefgbt4ukl+INfcO5HCOz+5gn9a37WQAcP0BjwIeXJDVVlg2gjyuyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldJYYtYGYdYSqcNyqDiPeInY+/3Ph9iEHKL+OuXr+Xw=;
 b=I6SwxTevdix8m78FkqSB7UICct1eMUr0T7T3hNKqkNzpe9z3ryq+gbSMvUWwNAXHhy5pCq9X9mtNa2KrVG2vqdTzVnXqVRV5G7TUgN1JURgC4IPMIIBETah2pvJZpwpcbMh0H6SIbLSRi9VToPD7JDqIYqWXna8Egp8NunjfoXo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB7331.namprd10.prod.outlook.com (2603:10b6:610:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 18:06:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6792.024; Mon, 18 Sep 2023
 18:06:13 +0000
Date:   Mon, 18 Sep 2023 14:06:10 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Jaeseon Sim <jason.sim@samsung.com>
Cc:     "willy@infradead.org" <willy@infradead.org>,
        "zhangpeng.00@bytedance.com" <zhangpeng.00@bytedance.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: Re: [PATCH v2] maple_tree: use mas_node_count_gfp on
 mas_expected_entries
Message-ID: <20230918180610.s74wyr5gvxpq5jiu@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Jaeseon Sim <jason.sim@samsung.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "zhangpeng.00@bytedance.com" <zhangpeng.00@bytedance.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>
References: <CGME20230915093243epcms1p46fa00bbac1ab7b7dca94acb66c44c456@epcms1p4>
 <20230915093243epcms1p46fa00bbac1ab7b7dca94acb66c44c456@epcms1p4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915093243epcms1p46fa00bbac1ab7b7dca94acb66c44c456@epcms1p4>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1P288CA0031.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::44)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH3PR10MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 42abfc0e-e1ef-46d9-2081-08dbb871f206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WxZIRW4PymgZZADVUxXNU/YpgllVIGRKefF4iqG0Im+iWFBbsZaWTfdLgrVusRVub2KW03HD6XX5zF6AVBNdGF5QKvWd416u8eecBRrDcFeSb/gmO2ZLGr9oMdrfY6kgyWARvxzPaC1dzhkA30KoB8HS9g/4U6dWDZsWPgp22crZVIghPsAgEjyX/HcssbWngBgGjWgnSHC+n4z+41L4JdEbHUTiDT+B4A/Ba1oOmTtyBRI+SArWUZlUmDHHiUg+SNm0M8b19WKbBd0PA+BtTQeE0WKG9Xsmk/tPZLPi+rK07IZvBBnWjE6MJnn/C4iPvIPPKz3+i1HJFn7d9lgZwJTdq0OcVUtr8JOdjlFDjx+IX7FASRP/hJad/j0DRZsiZu8mfb9gK+NEH86um+0p0aBIyJvMhgxW5gl2FnGz2Kf20ijWc0d4i0NHxIXv4Ie1bqxWFs2EnZKEPJJVhNspULnI1LIo4agbtsG3WucSQ6shbQN7RlnQJAasOP6cjldd647QX+p9QeiyGwA61IjSOvbtnjMU9H6KyA25eqr02DzQm3/rZVrvJakI50wJi4xG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(396003)(376002)(136003)(39860400002)(1800799009)(186009)(451199024)(26005)(8936002)(8676002)(1076003)(4326008)(83380400001)(33716001)(2906002)(5660300002)(86362001)(6506007)(6486002)(478600001)(6916009)(316002)(54906003)(9686003)(6512007)(66946007)(66476007)(66556008)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dzWzxv0bt0o10D/K6EXwqYvcsvQ7c52IuiMBAuucd0dpYqr0Afb7J6mrU+Au?=
 =?us-ascii?Q?WQh95eiBlgPfUOru/rdxGq2tRAzklOHb7iOdSSBwS9MK1Tp/gKJu3V9KC96X?=
 =?us-ascii?Q?vzQnciAjgBv6+qIQMCBuGQXxWAcOhAlJrA1yrjl1kbAvF2pa7GUVvrz2lALG?=
 =?us-ascii?Q?JylO/PxSH77UCnWUMH1RsAWzDslQ4kXEEdoHO9Tytcdsfr6EsA/MXNdZ895R?=
 =?us-ascii?Q?MjEm+CzG9jY3jvhzdO034XFQETsa+G0PlrZiCVd62O8rzMkeXwRjHFddCCo+?=
 =?us-ascii?Q?MuUyPRmMmvA1HYlCaNu/RNlFutlMMJi7U242/aAs3AJNOOPRxgyhO/ZMnBvu?=
 =?us-ascii?Q?86ipLdF4rZP1JQGB1S1SHMSSECmFkH9mGyfbOXPmr4SrCHHLpOEfKlk7zUSc?=
 =?us-ascii?Q?jmHBdUS6Fmxcwc7Kossdv1u5yfiRCe3nIGQd5TsqsmZXI7GZowRewuMQLga1?=
 =?us-ascii?Q?I5Uh2fZhzCfzjoAJhIdds8QfTAlYVvgV20GHzVVAZiS7HzhbCSVFt7+lngSk?=
 =?us-ascii?Q?T2A8ECrC/WdsuIPkLrWmdAwcDn1K3nwbXwhqoGQ0Yqmh8suA7vogcO4c3G9K?=
 =?us-ascii?Q?fy9OEQKJ3JtJBE3qIJ96wFmXtz8PSY8tHKmiC8HMTE+LlxIKvwb5frc4lGoV?=
 =?us-ascii?Q?2wTeDMmPF87ZgOueJBykchLcq1AOGMzV9tHYNXYUIIsro1bi+UCM3LAf8mWw?=
 =?us-ascii?Q?f7LsoX4uIPabD9yOpQtsrYr3Xw+p/6QWd/aMl4vHEz0Q9SPPuKXNF422JR2v?=
 =?us-ascii?Q?usVNmH+t6Q+SYApx77SEF+nMzeyhRQsx0L/KshDcGVQV59z/vivcT8tOcM6a?=
 =?us-ascii?Q?01kLPcuKRCk/9Z3gm+P5XgBlJ6zPzBrH9+HakI+TzRe2s28CHvLfIL7qz09+?=
 =?us-ascii?Q?B7pKjDWRi7udDY7Rpm7Si/mxWFuLZGUdMp65wc7+yNhq3qkJIAWfJDUyOcbE?=
 =?us-ascii?Q?EWF40lmmua0O+5bRLHYhi8F5uaiJVDpe6676LQtbeR5MvDgJjz1jjzfWvSYZ?=
 =?us-ascii?Q?PiprCBgNQEfkumfiJE6i7qelI3n3uQcWoU54v7P7Qfml1tn1w7G367NA7w2z?=
 =?us-ascii?Q?/2txHpWg+h4NVjPcaW6OGlQGSUXoPiIIDGC1BGRMiohU4W9t4A9hkzMGifZ6?=
 =?us-ascii?Q?TupXQuDLEQtpTqBQgz8wE1Zmba0FjA1a2Hc8rrGY841h3oEcfQQkpAjZo7xT?=
 =?us-ascii?Q?8Hr/Y3vYUfLZIJmeMrUNT6ZQdzXdnwjSbz93XJZrMl0B5RpyrWREBCwxXe4Z?=
 =?us-ascii?Q?R5HB3w161WEjnomU50D0Kld6wT8RIGhK4EtpSKNWuDicZoHkDe2LHjH6UTnT?=
 =?us-ascii?Q?YQxssC5T39T3VgfXaiMtjz/aC/V2f6+bNVxbeigrVjFjdTw9ny4rBSWq1fDw?=
 =?us-ascii?Q?/IBt50Ymo1ZnEUyaNdhA5sQLG3PNtL8VRCicSNJ95fXSs2s3R3lU0zKHCQfN?=
 =?us-ascii?Q?2WwLS0zgv4XVJzjQdT2jvj69OXzlghOtJnga+YcXQtVZEAFlShErqI6TuqiA?=
 =?us-ascii?Q?uhLtdS2OPZt28VOEBFF3Rt3sfSiYHLweUww93ppnBsGGfhzXspp3IgqjeLxx?=
 =?us-ascii?Q?iVx0/aqAiJAaKLKcSP8XAnhvW9SDWkwaDBgFIL19?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?UzDOrRKe2eBFQ344D86iTAUS1LrbSSMaLFvvLh/g67MGIX1zsu1iCFAcCso2?=
 =?us-ascii?Q?/6WaZ+gZz5lsTsaN8556U2SOyqoETCUPCF4mJfgilBhjUo/ZH4298N4xzlkf?=
 =?us-ascii?Q?Sg24QpaXMj6QgqI3CnyfKaeuMAkJ3TEF12HnuGl++woRu/+x9yESE6Th623D?=
 =?us-ascii?Q?aQwbz+HosrB9FmYtdU53Zoq+AOAit/x+F7WKjAPhu7ilgI16z1QVa7AbGQEM?=
 =?us-ascii?Q?7PfDyGYc/8GZ9KHwwCzCni+fNc8+IC2F776R4zwOgFJ317qzFfBtU7uTO9St?=
 =?us-ascii?Q?acWScpbd0s6SgCMOp5buzljlX29MVO3XDAUcsnv0ZK159GDD1LQwo8Vs9F0V?=
 =?us-ascii?Q?OGSS9jE+Zn845sNdrVf3MNHa3AsB72dmKrgt2JcqizY31UeEx4cBkIdp2yAf?=
 =?us-ascii?Q?NiaAA2aTfdwZuZmCOSyS7XXyWv+fb4av4ThRf+HqiQirbKqPS3iwtH4rfejz?=
 =?us-ascii?Q?oQZZh4lnF0CpgDvnjvZKAWRHfTKgOc0kFnLyz3fyCtxj1Iuzhg1eEkv+pXFr?=
 =?us-ascii?Q?5pOzqZoQ6/lfncrcLGJ6vru7nBokXGeq+w14p+IoJ2eDL07pZoylaWeImCQO?=
 =?us-ascii?Q?hE8swMjZItDKMGV+U+6VMrcJ0abMQban2rPZ80qaDp6b3cii5t52BF9ci81H?=
 =?us-ascii?Q?cANxIYOomaYSxGF49X1lrbDJFSZETvukp1mBxFSHyEuC7+Y7l/TjyPAHlvkr?=
 =?us-ascii?Q?KofldER/FsA/YjMInhQFHTb/YpTOxRbmJk+L8aQA25ulrq73kIItFlqzgpwr?=
 =?us-ascii?Q?VE8ziSllBKXbU4vt+YkahHd4EBy/w8dV26tG/cqSdL/Y3io19VWTyPPSittT?=
 =?us-ascii?Q?ueqf9sJn84iTQ/UA0KUVO//FGfb4Wp/lEK2gSNPKcxjqtuFpqHvl4q0fx9wX?=
 =?us-ascii?Q?Xj17EKDLsLgGDBEU45oxjxlNfSflKF86ewOfxPkTqO73DmXVuL8v7SH9Fqi7?=
 =?us-ascii?Q?oM95sFU78s7GlIoRhWEDMT9A+FCjOYeCAIOdrmmQPKZ5cdHzA2h6qKvw3YDJ?=
 =?us-ascii?Q?F7BO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42abfc0e-e1ef-46d9-2081-08dbb871f206
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 18:06:13.5394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7TNMvmSsmju1ZLSA+K76ZCVJljEG2olOjlwUITnXpDpN/hFQjl+H3nzHZpZbqXHE61SkJ2y83bIUwNiIuE4UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_08,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180160
X-Proofpoint-GUID: 6eyAlI6vcAZYsL5dX2_jnc43TTSbhXxy
X-Proofpoint-ORIG-GUID: 6eyAlI6vcAZYsL5dX2_jnc43TTSbhXxy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply.

* Jaeseon Sim <jason.sim@samsung.com> [230915 05:32]:
> Use mas_node_count_gfp with GFP_KERNEL instead of 
> GFP_NOWAIT | __GFP_NOWARN on mas_expected_entries 
> in order to allow memory reclaim.
> 
> Currently, fork errors occur on low free memory as follows:
> 
>  Zygote  : Failed to fork child process: Out of memory (12)
> 
> -ENOMEM was returned as following path:
> 
>  mas_node_count
>  mas_expected_entries
>  dup_mmap
>  dup_mm
>  copy_mm
>  copy_process
> 
> Signed-off-by: Jaeseon Sim <jason.sim@samsung.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index ee1ff0c59fd7..b0229271c24e 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5574,7 +5574,7 @@ int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries)
>  	/* Internal nodes */
>  	nr_nodes += DIV_ROUND_UP(nr_nodes, nonleaf_cap);
>  	/* Add working room for split (2 nodes) + new parents */
> -	mas_node_count(mas, nr_nodes + 3);
> +	mas_node_count_gfp(mas, nr_nodes + 3, GFP_KERNEL);
>  
>  	/* Detect if allocations run out */
>  	mas->mas_flags |= MA_STATE_PREALLOC;
> -- 
> 2.17.1
