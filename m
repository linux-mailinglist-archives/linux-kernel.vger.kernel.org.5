Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B2878E0EB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbjH3Urr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239981AbjH3Urn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:47:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3E2E57
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 11:52:40 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UInrRw018041;
        Wed, 30 Aug 2023 18:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=nJloHB0zDu8LwgV39mz1tQFxCkCRoHiIuVP6I6CUHrM=;
 b=utW3nYS2w74/gf46FinDK3cutipHI2RgnpVqYOY+yr9oyWS5FMr4lLHsqCmAc/+jz2Pi
 4Lk7psHGTVwrbJgKre76kWpUybe30K4hCZAxjMDp9lwozd9OOdpSYc/FhSLD5sIDqx0V
 2Xebu6m255owgerAEkspCV2NO+V/r8Zoyb9YMqtbwYkZNZK1D4CDtru3+gi6yynVOC4F
 AGH742rkLmiSABi1k7fS2geLM3ThcxjvBj0ERZb5myB8NU900CtULRnJsJb3mmQCntAK
 xxTIzxSx56NB458CEqQDt2c3eVRqxSpaG0r79SOqlZG5+PRYLmeSRHPRUq+EZBnqoACX ew== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9j4g75r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 18:50:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UI0boG000447;
        Wed, 30 Aug 2023 18:50:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6gcyw3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 18:50:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhFpn+d6a/o/HZX341TRrp8HGqXTvGbnMX7Tix2aLT49CleuzbDxvyptntIJo9bZJ/2lVAthMG0VZ30XWAeukOC2UeC6HzL5KmGjDlmPqhphuSgL/S+n3Y9BI/pfffrsaee8XN7f9gc6mo2hTLTIxDXreuFPm3pYNsCh5b/U4Z/4/3rJUS34CaFk+wc4f34etrPHQpLNNK+/gCa14aQ4lhp+aIO8+2F3yFIoGjDwz33FgcnMNgcpepJ5bUrGiyRUfYF9Of95rbujode8admDR3l4i2Blk1dVzuHVdq7V8stIN/FBY3mCfObWjgK8PdT96ucQyNeY2aGbRjlEjbxwWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJloHB0zDu8LwgV39mz1tQFxCkCRoHiIuVP6I6CUHrM=;
 b=dvL1cBjpMoD/WdCK20r/ZBrBQXj200DfwuxgYXMBttrNeWbOLQ3liFDlsxTWe1Qv9DjLYytcC94WP7BiTtLVZOd6RZsdjC0OGeWw9YFbDU+KXZ0SP1f+givpeUFmLN0/o5MlLG6gZoAX/ntXyrqi5SccPe/LCKm0wwOScQ/kkF5nR0USnO4IKvHlUQ0+Xmy/adW3fHESlEmpUGNjgl2aQmJFBQcOqw+0gS+r9CMAUwWyG8XXitZi9e3RPyJ8KscTItQ+2+Yh0AOqGfe1gXC1NZM6UkitJDQE0IG0N2Dl1AH65dsqucGygPTVA4sNvP/me/JRekT3IwEHDb+N7QoTrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJloHB0zDu8LwgV39mz1tQFxCkCRoHiIuVP6I6CUHrM=;
 b=szWPjUYGjkD7KLZalDmBB/CiCIeU6aR5dw+f3SGPm4c0CWssdaDcM9h7Gwy44jrDbr5qgt9+7LmqOMH+KXplbguy+AKta2bEM7VzEvyREHYTAXp78qrm1XmehHSOJ9lQE5BfKkYsNQSUZA/EkSuGJhgp8WuiTmSOoFbIdThInjo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYXPR10MB7897.namprd10.prod.outlook.com (2603:10b6:930:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 18:50:13 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::238e:5e86:cbd0:7415]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::238e:5e86:cbd0:7415%4]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 18:50:13 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v2 4/9] x86/clear_page: extend clear_page*() for multi-page clearing
Date:   Wed, 30 Aug 2023 11:49:53 -0700
Message-Id: <20230830184958.2333078-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:303:8f::30) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYXPR10MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d48c7a-c6ca-4080-3991-08dba989f190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tWHw1Bzleq3VLt57kDBz6HOlx1Yj+hbmhix/327oZvg6ojP4A1BjeS90W+0IU+SmBdf4fRl29Who9GnxkL0oQDPEDSbAaOtvrjO6eY3195797WawwAk35zbAPVGCGtRJIZmbcqyPYtI0xpJwgVfISDF3oefcOE+MmgJmxJH9y7o2lGKfvI9i9oOCCBz83Gr/AgWftGolZQDv7ls9FhWmX74FFRiOnQ7f3cZhY5GR9q0+kjgkQ9xrmE90oCcSwAd+XjmJIe4ZRlaXHTBtbIbT8zriqgCKGkCDL4R+KxKThSXrxT7Q+qQrP2I8fEl/dt7kcvufTPIOPse+tpztACqvlvjJIcetj7T3xTwNMfnjbDLH2pyn3tbOZ1EAJByRlMClDFHSGNmdO+zpK/xXRmoBAAAjcRjI/kxKrUgxLhJ6YxWKo5iZCch/abKPm7YxQ1wew9uEmYyAmKB7bpErdTu19+jgppPXlFTHTiyf/BfvTdxNHjLLG0yq239CLfq6QtjTlT91hIbjZYQq8CKmOd3TGYhg7YocNbzNN2mvdmuQ/Lu6trhxWjlx8+cxQOh+FRM6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199024)(186009)(1800799009)(478600001)(38100700002)(26005)(1076003)(36756003)(66946007)(41300700001)(6512007)(83380400001)(2616005)(107886003)(66476007)(66556008)(6486002)(6506007)(316002)(6666004)(7416002)(5660300002)(4326008)(8676002)(103116003)(8936002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MNGn0hz5IREwEpfgI5QtLSKwZJgZ7WZbc6CtXAeKh9zn7jqpoLbCzXvxJIQu?=
 =?us-ascii?Q?hEIGnSgKGNuK+fzoSUWVSipnV2OTX6GDVSdYbPjKmpJp/E0g+KJAgb/8rOxh?=
 =?us-ascii?Q?Nq5uxQehaGqDkmzPFy8y7/louzlS0NUFensDAE86xU1bmnhn1Qq7C4SxBfZO?=
 =?us-ascii?Q?CuuofGmYzz35GQlYTrV101KvR/DN19o/CbHLroAeu5TDh2z+XmtbQNxbPpxL?=
 =?us-ascii?Q?5o4cAPqZz15BRxEK7dnkbfk2UgrIJ3HxzkvbuGWPOOwbeydJtqXNBxFQ+orN?=
 =?us-ascii?Q?OMISW9fv5X81lFsGX5BObpmjbHU3BNtAL8VFTCCXuMGwVbzQFH7rKroKSPtg?=
 =?us-ascii?Q?MICJgI+2i3hnRPK+1ide2ChCorb5eY/+W/HaoOV6Q3jeflmtw++W9CBKyEKm?=
 =?us-ascii?Q?NY4FXLwCeKSvHmi9VQ+/32eofGYGeZtjYMgKkIug0kADbYpEPQUUutKwZ2zG?=
 =?us-ascii?Q?LkUvWL7AThKxV8vtTfhIr6GEXI1oztUkQBoGJCKmP1FFmtOwkx5AGLukbS1J?=
 =?us-ascii?Q?M5bCe4Z62qcAhyfwAyWo76abt1zqp7fL0L2eCVvZj0LUBX6sajKL+XFEHt/B?=
 =?us-ascii?Q?7zkOxzTA9MP6tN4/ycumffGpTsr1jg/GrZUARtLCMDOImqBuLVYOUIm2Rnsg?=
 =?us-ascii?Q?HnN76OmcYasda8XICYbiXdj/n0oNbIJwTxps2wmMRWbc/8WFBwgcc5DzwTGP?=
 =?us-ascii?Q?NUygLYfi8ssSWp6canJgNGMK35Tkclf2NMevWgPnBW9cuXCqOjNpjF9/7/I+?=
 =?us-ascii?Q?WmtaQLhkrMF5bQTC2XMJtxZHH23eW2cdsgUkwuB6RGunWg0v5sryb1rIabgQ?=
 =?us-ascii?Q?A1ggI19bBPYqbFQ8GXMg9WD4T+PzQ6renq5NtXDgr6xvdrt3/xZ5x1Ag3wsL?=
 =?us-ascii?Q?UA/R4ddId+4FK0+MmGBxkVKGVV95ElJJwr+ThUB7wic7Axw/icMyYo5sCgG3?=
 =?us-ascii?Q?5MdDV4BO86FLeuHnyBPhuYh9QME7xcheUsRw4gIl4Q1X1JtA+Po3Ywk78Y6J?=
 =?us-ascii?Q?3oFAcb1p+/oSJuM0wNZy9yERsqLtz0gXiLYlEwXEe5cc2dk4HzS/2TmIlgUl?=
 =?us-ascii?Q?i90tVMeixCWIJiLL6qUaSstekMJi2k9/D0SNbLdFySYjH0zTmi/4gO0czfh1?=
 =?us-ascii?Q?VDD7Mrr6vfj+LFqckm9SFngqvpaIjRr5DzL5XTxfkud2yHPb6DjKp5sXoCqk?=
 =?us-ascii?Q?uZHTxzS7PXZv+ala57oxc4Xnel9LL6Im5joH9xwqpQHkI+wvdPWXcwGIcQyM?=
 =?us-ascii?Q?tgEbVX1ylqlpBvEHUHI+YTzV6fuQMWsLPVKyFdp8ZT7aTsMgj+gwr7KU8QpH?=
 =?us-ascii?Q?/pYxXd/4r65/ZPZXiVTFy1V8NdFOC3gsnzHz8UQIug3hAosYaUludZyxr4aQ?=
 =?us-ascii?Q?Ks2gkbFWYkeJvVvj6FC3ZcT5UkaZ7GfGqGLLWis7UqGbMEgHur44EGs1CydK?=
 =?us-ascii?Q?vlpT7oKyzaXiRK85ZueNCgj/ys5t8OOmDplsUEbFQiq7fCd9IQBxvn788ebC?=
 =?us-ascii?Q?qUzONoY3inONMJ/bV5sv+o3hrlsHK1xNhw0Tykmuat9VF5XyCNXX5iiGYUqo?=
 =?us-ascii?Q?uCqMPvDjOcXlXIwpe1GuNaxWJ9wmtUJIxEhIykWj/Dm3HzRpZl6d6d/Ft8qG?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lb1Lk5rZslOEUWrpZyof+mbkzXtSnlzf0/D4MozEDrvZSUKwg6xOPeT+XRfn?=
 =?us-ascii?Q?kdDidQ4rd2JmGlCoiniopkywOuVowUjIUkVb6BsMxxKgDvHS4iqj3wjT2SLU?=
 =?us-ascii?Q?bH5m5JHGJMVc2RkLYjw/VmlOJcGi95UOHDPFPlZJGtCYwb5I8DOw+OzDzOIz?=
 =?us-ascii?Q?ldapmiPIlo42zME6tbLwen9P5Q7EH6ycJ7FQ2zMnL2MpB8Z5+bamXTG0c0ML?=
 =?us-ascii?Q?sh1S8T9Y4XOi/sezU/loHkEWNfthcd2zao4SLcekzXxJqlmVuRBVQVBoNgMG?=
 =?us-ascii?Q?Fa2FsDI725WrNUE40C21uc4AAlUzzkEFReQE8rTvl6DjgHm7rYxZ3AdLfVQx?=
 =?us-ascii?Q?P5iZGMhdoN+fVJMmHglXmSokOJyEFGgcwyaFh1tyfEZ6CezIXSk+8qdDrEtH?=
 =?us-ascii?Q?aDIKnDWW67TO/feAbbuJdconfA86Hrklzc5t9vhenox+zDhUzdo0qLlF7AW6?=
 =?us-ascii?Q?JIUwrGAetxhuxVFn5BmYsGJpXrzhb1QVQ/n+DxepRgB5jWZwuvbnQ7SDSulv?=
 =?us-ascii?Q?fBNcfLkjr9rHmh6SxojM4oTpql6bQ/VmFO2Q63ezG3GfQx3pIUQviZ9x1UNI?=
 =?us-ascii?Q?rGOYz9Yh9vQTr5FCcEQEpcIudTJdsQWyDyW7r8cTAhjVsd0X72nAgsJUlLlY?=
 =?us-ascii?Q?y6/sxUNQktNuNJbXwqtWJ/sbWLqL0Q/+zv1ve7R7P3QZ46vAgTRccZ75CjzM?=
 =?us-ascii?Q?d6OXrxayp8PD455xWcvN3kGIqTsKidlz2MA85I5yAEY/eslCFA3Mi8BYfif3?=
 =?us-ascii?Q?IaI61Yp0zyuwR+NbfhG7dI96X5iTRRsdt9Az/MAdp7HfwzMU/PdgpR8WeLKe?=
 =?us-ascii?Q?JK9k2uA1WZoKsTO5TtprYgcD9mOX9rIjz93t+5LhuPRXcxze8UhyC5fA9FGk?=
 =?us-ascii?Q?2WxfAaAYaLiEKLXX6xkXrQJUzNheXA6dqwb00PZtQrM/x7ojhVoDb5DtNWJ0?=
 =?us-ascii?Q?T2QscCncXELyhhdw1vJnPGR+x69Gzg8oljzp0TUml2axrtZqyc1SXwC3GJ4C?=
 =?us-ascii?Q?GtdGRx7tT8XoxCAk7V8uB8L8/VZHt7Ynocji4X0dkyRTqLv7hR/8SZSrDqNK?=
 =?us-ascii?Q?4ir7PhquK9KneVSLyBHSz1th5tpQaFhFKF60PHpqo7QrsKc5z/mFOA9KagO5?=
 =?us-ascii?Q?0rV1EScxcWLCKtVEM0b7UKqg1r1jGREf2mo7BitqXzRqt0tYhkhLbkQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d48c7a-c6ca-4080-3991-08dba989f190
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 18:50:13.4385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCjLtkeS/3muNw6Sgm8Uy4PcauxCtioNilkUhMP9Ko0i24T1BXzGpDp5nxREY8oamPHbjZ5QZBLuvuMBZYAJNjJSirzMupFXjhcaC4YrHMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_15,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300170
X-Proofpoint-GUID: CPje_lIh5Rw1YeWA3jtGvcbAznD8HBQm
X-Proofpoint-ORIG-GUID: CPje_lIh5Rw1YeWA3jtGvcbAznD8HBQm
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear_page*() variants now take a page-aligned length parameter and
clear the whole region.

Rename to clear_pages*().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/page_64.h | 20 +++++++------
 arch/x86/lib/clear_page_64.S   | 52 +++++++++++++++++++++++++---------
 2 files changed, 49 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index cc6b8e087192..56f9adf0e892 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -39,22 +39,24 @@ extern unsigned long __phys_addr_symbol(unsigned long);
 
 #define __phys_reloc_hide(x)	(x)
 
-void clear_page_orig(void *page);
-void clear_page_rep(void *page);
-void clear_page_erms(void *page);
+void clear_pages_orig(void *page, unsigned int length);
+void clear_pages_rep(void *page, unsigned int length);
+void clear_pages_erms(void *page, unsigned int length);
 
 static inline void clear_page(void *page)
 {
+	unsigned int length = PAGE_SIZE;
 	/*
-	 * Clean up KMSAN metadata for the page being cleared. The assembly call
+	 * Clean up KMSAN metadata for the pages being cleared. The assembly call
 	 * below clobbers @page, so we perform unpoisoning before it.
 	 */
-	kmsan_unpoison_memory(page, PAGE_SIZE);
-	alternative_call_2(clear_page_orig,
-			   clear_page_rep, X86_FEATURE_REP_GOOD,
-			   clear_page_erms, X86_FEATURE_ERMS,
+	kmsan_unpoison_memory(page, length);
+
+	alternative_call_2(clear_pages_orig,
+			   clear_pages_rep, X86_FEATURE_REP_GOOD,
+			   clear_pages_erms, X86_FEATURE_ERMS,
 			   "=D" (page),
-			   "0" (page)
+			   "0" (page), "S" (length)
 			   : "cc", "memory", "rax", "rcx");
 }
 
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index f74a3e704a1c..58cb1d6355a7 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -11,20 +11,35 @@
  */
 
 /*
- * Zero a page.
- * %rdi	- page
+ * Zero kernel page aligned region.
+ *
+ * Input:
+ * %rdi	- destination
+ * %esi	- length
+ *
+ * Clobbers: %rax, %rcx
  */
-SYM_FUNC_START(clear_page_rep)
-	movl $4096/8,%ecx
+SYM_FUNC_START(clear_pages_rep)
+	movl %esi, %ecx
 	xorl %eax,%eax
+	shrl $3,%ecx
 	rep stosq
 	RET
-SYM_FUNC_END(clear_page_rep)
-EXPORT_SYMBOL_GPL(clear_page_rep)
+SYM_FUNC_END(clear_pages_rep)
+EXPORT_SYMBOL_GPL(clear_pages_rep)
 
-SYM_FUNC_START(clear_page_orig)
+/*
+ * Original page zeroing loop.
+ * Input:
+ * %rdi	- destination
+ * %esi	- length
+ *
+ * Clobbers: %rax, %rcx, %rflags
+ */
+SYM_FUNC_START(clear_pages_orig)
+	movl   %esi, %ecx
 	xorl   %eax,%eax
-	movl   $4096/64,%ecx
+	shrl   $6,%ecx
 	.p2align 4
 .Lloop:
 	decl	%ecx
@@ -41,16 +56,25 @@ SYM_FUNC_START(clear_page_orig)
 	jnz	.Lloop
 	nop
 	RET
-SYM_FUNC_END(clear_page_orig)
-EXPORT_SYMBOL_GPL(clear_page_orig)
+SYM_FUNC_END(clear_pages_orig)
+EXPORT_SYMBOL_GPL(clear_pages_orig)
 
-SYM_FUNC_START(clear_page_erms)
-	movl $4096,%ecx
+/*
+ * Zero kernel page aligned region.
+ *
+ * Input:
+ * %rdi	- destination
+ * %esi	- length
+ *
+ * Clobbers: %rax, %rcx
+ */
+SYM_FUNC_START(clear_pages_erms)
+	movl %esi, %ecx
 	xorl %eax,%eax
 	rep stosb
 	RET
-SYM_FUNC_END(clear_page_erms)
-EXPORT_SYMBOL_GPL(clear_page_erms)
+SYM_FUNC_END(clear_pages_erms)
+EXPORT_SYMBOL_GPL(clear_pages_erms)
 
 /*
  * Default clear user-space.
-- 
2.31.1

