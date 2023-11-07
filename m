Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16BE7E4B92
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjKGWPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbjKGWD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:03:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C294A1709
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:00:38 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJVW3014845;
        Tue, 7 Nov 2023 21:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=8Zn30y72lLc/EfFZQRlza458xX3iWLHFkzwKXZIi/gI=;
 b=MtbVLRudKHuWr35XfgCc6qTHSetu9NqDyZBWsrJvSRIbR77wCk6iWS3Ab2UrhTS4V+lr
 wc+3zNEPasGhXARaZgNXuV2uf4L0ZQOVhVxEnJnO4TvZvYcoD80B9WOWSJHJQFnhKkP3
 W/B+XHq+bk5OjqiSyJKeRWt/NVuoOocxOgXK3lJeNYBgvFJT+DuYhSFm6yUUSKulEN6l
 geBej/Xx77LPTgxbnA+WKi1FRQL4LWMfgUO5syJFZX0QMIZoqqLT+1GRQ4vkmNXDaeZx
 +OAe2sEEkOjFueim4lFjxQfYg+4rbrzBz7kU0hGH00MUb8ytauUdXrvcKrososhhsxbP 1A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w26r2e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIt9S003973;
        Tue, 7 Nov 2023 21:59:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vsjqx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oi5CAHOJBMM5Q1Tlesie3zvIjLtXge0WXNttlJIDgiw2SMiVF7bpWOVUdBVm6d2xIWvFXs4smg4pRqLYJrukQ66gCMqLGvMZpeJmLLuyQ3Lq1Fimeg/YWTYGkChaTzutOx8ED+0T6WMujzEbsqPU8XPdJM7YmGJr34OA20mBbdfgYPoSueIqHB59XVIhcFVN5DOfRPJHPO6GIg9q2eba18wGJcBHupP3FlqXPh589uFGi5BKcfqeL6T0RkuNJ0I0JiXiRzwPbKjKcoEaChA1FrF70Q6DhnmWQsECdb/LTNYjwAejI7vulttWjWq1+G7ZohP9sXyAM3snO2blw6eNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Zn30y72lLc/EfFZQRlza458xX3iWLHFkzwKXZIi/gI=;
 b=HqZUXEdAeQWWJckTHOuSzclRYTwH/esIYnSBpnqh0QPoUZXQM1vdnTyZ7Btsl9bqGDjYg+UzaqYav3ncmmncMApB1/wSz/wErMZHdEuqXsX2mEh17oey10aWjsjVQqFbG6GkjT2WX3bxEuCoX8rxJP7QjSJMGxBnroMGqeNenGNBOxvd27cltjsHxcJ4h9mcfa0K2tZUfFvjRAFUqva0pPyt/ExUWYDF96JfCLg5T4cE82SNUgWhKJWxNbCiXMGo7m6FE+obPXlkn12qr5SNeKwSMR6TIpKx6A0DPwUIKC2YpmNll9b8ehV3v5adtLWFviuzrXy41GG0xU5sBEvn1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Zn30y72lLc/EfFZQRlza458xX3iWLHFkzwKXZIi/gI=;
 b=YFb73KrDXFjLEINqfFTNenQW2ifu2BMfno8pfi0pTvbtdH81G5TKrekxVVr3mb1Sv11FbEajZDektqNQloX5vmQHoEPGstFTl61hT9E7W9Igc+5z7UfBRpuUTeAVubdeBRocnmqRc/e3ArcexGZPMEFGsUoms/+Dq2WDk4KLhjA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6141.namprd10.prod.outlook.com (2603:10b6:930:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 21:59:27 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:59:27 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 34/86] thread_info: accessors for TIF_NEED_RESCHED*
Date:   Tue,  7 Nov 2023 13:57:20 -0800
Message-Id: <20231107215742.363031-35-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR2101CA0008.namprd21.prod.outlook.com
 (2603:10b6:302:1::21) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab5b2dc-a7ff-48fe-6a55-08dbdfdccfcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0jVa7YKklfqdp3OyyUPhQCflpZQMBL2PihSeKOMHn8l5BwKtjhmbcyiKRaZz05cBpGhRFCIEAM3kPS910VgV2Q/93ItwIExhq/sEXEeLImVLxts3DrlQ0nudk75WrNASextXNIcZ0PkteNUHRKXcNMTdtDDxgSz/64mFg2hICm1QFu/ZPdRLroabbhCiKNZ4HLVefzum/0rt20MYHsPUDHZgLt/SiIV979Ps4KlxE1qFSAkmkQehadaOzSrzlFqzTZ2XfBH5M7KVq9XCEFTX+yWQWBacrAUtQVdHGDxvDoBWuGcdv/NhTQLJskIA32OYmtLmW+Y3B+bAeQL+kNkWAwK76dBhllLFMBfNPkecQVBBDmMvtgLz4aD/zzovpI20+HHPSBiGe+wg7SkfkEL+LNQbeD+s1dzCk2IHlIcQP6DSTN5nvB66wAjGhwNRa8rFjvEq0BY8FhSNVW+8uqksi9Iy89uJcTycfTA5hTlquYns8HvgvIZo/ZOYBWv7QMI26UMgH8qumGlAaJYNFLrOWsfdHWuDwJ/TEh7lx+pyhCc2/yh6vy6ZsgCQ6Ih62MTK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(86362001)(103116003)(8676002)(478600001)(8936002)(6486002)(4326008)(6666004)(38100700002)(1076003)(5660300002)(36756003)(6512007)(66476007)(6916009)(66946007)(66556008)(316002)(2616005)(7416002)(107886003)(7406005)(2906002)(26005)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?02re2A9YazPiYO4EKrfFTLDRL9hYozbzfMhVNT2dAyjliHmgDvZSiNWOj/8B?=
 =?us-ascii?Q?7TEE9L7zytlV0aaZmwpTrmCXbu0C3Zdl63SKA17ST9Rjt4yd1gbgzgqADR2o?=
 =?us-ascii?Q?nLC5LrpmjCOZ9H4u3FJxLhtlPkVj7TrDn9Sjpd0MjKPbYLPoyI0FmY8JSlSt?=
 =?us-ascii?Q?SjXDQVr61MCKvu3G+P3cxIzyeDLBY7m/JqcEOXl7mhEvrL7wH3r0r3Uky3b+?=
 =?us-ascii?Q?eODfMAH96xCVrkeF1Edh7e8in0nO4NYrYzoxtRcQl2Sbi1FlbWYwfTjaE5mw?=
 =?us-ascii?Q?Vck1zeGRx4ZfsP0dMRZWb/2LGz5Dh8eH8B0rjgwgkLu4T50Ufciunhcooc4N?=
 =?us-ascii?Q?+8nmkYyPZHq9ziOUD4V7wwAIqfEcptoYgdpuYASDNriXkrawhsDaDpmGsT94?=
 =?us-ascii?Q?0v821R3xmPwr2A6WBcQLf6OjKKbzS+ZJemWb8tMf/yn837cRmdVMtFze73H3?=
 =?us-ascii?Q?rYBVKZOQYhX8O2eAXTRiG9R429EpKHFPhcW9L2tjnrysW6mRCgTJ/G1QjTDK?=
 =?us-ascii?Q?4CIEh+NkLZUEx8GCc74M70idbXaQvb4Ld9Z5EH5AeeY/yx0gesx+Y7IXgMwB?=
 =?us-ascii?Q?nbMHwXSJ4U5TKZ4cvo3JXhHQbqf22rOvsnupC/xlgO5EknLCUN3CXtdJ9/Gc?=
 =?us-ascii?Q?IdrbjtHUyOBp0WqK/P3wjORhO0O4/jYEaDPOIdsR9/mh3xoeeKG8QQRfKyZ5?=
 =?us-ascii?Q?U1S+hkSP22ASFT5PXf3V3MPYZbsxoRuROs7JO9XxiupksAztGZ9xzHPCf8V7?=
 =?us-ascii?Q?r/T100P3LCzJijQIPahlL29Z4kbrcLWM8uPzd99HkASYaZuPqPphalgWUaZk?=
 =?us-ascii?Q?vBwrfVNzN9t8zxPh4nOivLP3V0P7lGmK8konCzWw7c5cc57utmeRdhmIiYLw?=
 =?us-ascii?Q?iE02/c4Qd6nxuE+riuZhlr2vkclIUWS0O+806Sk7PWySQCiSGEDIytuBDeAy?=
 =?us-ascii?Q?BgGR1tqFCHmxKWI9AGArnLW8+i7bYztV1lDN9M7gBbnvvd3BoT+p0b/BU9Dz?=
 =?us-ascii?Q?E8PZOVaKMyeaxd88BKpmB986JdQ63suv3ObAsr09E9CIVVyRZpL0FpAkD6LN?=
 =?us-ascii?Q?DHbJ5/487SEyk3rQqcsTP/Y66/5/ZU/DYkgggxWmj/ufXND8mCwf8vXVJ1Ax?=
 =?us-ascii?Q?OF09hqS2Q0IrjQr3HU1kZLoLsKD+2JVkElbwuyU1ARixiix7TdxMaNYdbQEB?=
 =?us-ascii?Q?HUSjnEWXYQCyRraAUzs2SGCApUCCVwpdeC7TtcTkjk4vxH//mQdkC7sr4yKe?=
 =?us-ascii?Q?IoAJxylAm5ttVJesDmNx36hecYEdJDKQ9xOSfcikExVGIvqhVP+sAumt7g7M?=
 =?us-ascii?Q?kOlbbzK7TmVkRZ9mpOm6+COG75qLVVP3oTZ1ibYGzw82BujtEk3mlL3sWy1o?=
 =?us-ascii?Q?2MWKnJPPN5+vnX9hMMCBAudTBBOwfa+GcEIayvHCSYhMymWR1gufWk+/vw2h?=
 =?us-ascii?Q?rgfIoHEC4YC0G+WWgcgKutivAj6Yj/h1X6yGdV6WS7JPN02GF92pXobCYNtF?=
 =?us-ascii?Q?MX9uPIFRUOQLhA5ytoPUOzkn+kush0vMQvhwKoCqfv7+2RSKsCgUFilsr3fo?=
 =?us-ascii?Q?W4M742L3YGapMWGWati9yuGop24bTRIpQBvBQiQ4vnlPiGiVHqup7WG9Y3CE?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CQWu3xTjlPGPXqnjf3j+jFI7wRU/XaL2hHR5SaJi26q8y+2vOa+X6oQ3dL2B?=
 =?us-ascii?Q?6qxLt/xftR7Ex0LporGHmgGHivV75msculsfJ8HmLrRNTIFSa7MMykLR9yrh?=
 =?us-ascii?Q?7ev0h7bNZ3yV0r0XoqMn3eCV2oUPgHeEAzyuV3LyALUfMzzBGvCLbZACG0xZ?=
 =?us-ascii?Q?/HXTYAhlnhGTUFpApYEFELIVkQ5De6y0FakEzgohLfTq7jIjjdq+7TuI3Rr9?=
 =?us-ascii?Q?+NlxYBdAgEyjXOO+pNWZgmBTm7GjzFqSqEN5QEqZCwm5QTuEdDw/xH/Wcmp3?=
 =?us-ascii?Q?j17BP3WrON1xw64b1KKkdE+8SUm13gmPzrcPyyBibIBI5abXqbF71hQ56ESz?=
 =?us-ascii?Q?RcLIpF0mHWI9gKQ2Wq19IUTk5lK7iBhFDiHRJ+G6i+eQ4CSov46yOat/wELU?=
 =?us-ascii?Q?uZLvz4rOF/KvTbxydfki3TA+w2h5evYwiCpyiK3dA8/O8KC6NGuzRb8XdWIQ?=
 =?us-ascii?Q?0wfe8pgNiF7S+xCku9Wt+2zodqykZye6XhtTEnqTkxN/0VfZIEfw3PuDF9aR?=
 =?us-ascii?Q?lqu3wAlgMLA6RY8CvwcgKeVgVqyfyFDb4GvM53NJkaNlsZ8cOh8/EmclTT7h?=
 =?us-ascii?Q?Qr3cjcR3wOs3wzsGBVCqglKg/7YUgLnjdO0jtWcWJXxJk5Ul+ZoyFgR0Ux66?=
 =?us-ascii?Q?jOw7VG7AIddtjA1JBCy3yos/v6vFHPomwhxJ8KNTA7sPa3eZKBC2rokQsdc4?=
 =?us-ascii?Q?QFOJNKaQukCGVBzrWLzQ0BuKDf1OUDSO2SI6Ktz6KZuviM4l9g05NCNybN0A?=
 =?us-ascii?Q?4jeyFyaZ3UIQRzVf8ZYJlYERofCIOj6eiaKY9Wuj/cNAQpCF9IZ8/3PCurGt?=
 =?us-ascii?Q?W5MsZf2JAm4kovHOQ8cWGQkrW43RjFOhSStA9aIw6DUm/QsSXnEwdE4KUYbe?=
 =?us-ascii?Q?e6wk1UGx5fyoMCx0LQbO24xzxq+oMguSqBdHaiB0N5+awYxBRyNDLGd06iTi?=
 =?us-ascii?Q?8XF85W9IjG8Yvzn1YCI+UwC5LAivh5jk2K/v2ilUq2yjzsLEeHScKWNMoN+F?=
 =?us-ascii?Q?hgt0J6iYfqc4KXeJQkeDQEXkUK05W+q9t0bEHb9wJprUcdsOB7G+Ww6nq6Xc?=
 =?us-ascii?Q?CLdvy42dvZ4bo1fI1jHwc91VIyKNvewde+GILkkT5UNbFcE7v1lP59Ugx56l?=
 =?us-ascii?Q?JmmXhkdIBg2VqgT8pjWlxRXxpgeg+zMYpcWV1x5lUQQOyQxX0ju7iBezlVIF?=
 =?us-ascii?Q?9/ULmzZFI9iI5Df6WcW+65N5WnGq/AuGNhP1j5Wbll25hXI7uqUw1ei7+SQh?=
 =?us-ascii?Q?43V/hAAoAyYGyJL0ciKgvxBniwItGQG6OTQyNBc047itApnKPoQzBWC8pTTc?=
 =?us-ascii?Q?jH+5NC9Ia8fRTZoogsHThsQco1uTvZYBTx235/cofAIK0s+TkCu0RAKzX2an?=
 =?us-ascii?Q?gdN2gIwaqS9ibuTSwjdT5UFEodzKlV2mozSV9nGiP8TyR3aOhgY2UrLbg3XG?=
 =?us-ascii?Q?kUPxVyy/dpTUZvdq1Fy7VhF6U9LZerZ6PYY6xirT/368/CFxp/dTfAcHH2W2?=
 =?us-ascii?Q?OT2y7stCWk14po4NZVbsZcJofhFvQiK/QhCZ8lFVG5I9eyLo5XZSXql+/A?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab5b2dc-a7ff-48fe-6a55-08dbdfdccfcf
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:59:27.6962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: suxE9FBtFaOYvoAxUhkDI2rE/0G3PYLFSIvt4u2kXfx8qgiaZQhjp3vyKyIPHiYbNbsWL9aXAMtDDyi5VDAtEldOKEfppDxGYgpC/a4Evtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=776 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: sUL1PvCwwW5IRd2Oi-CFXP19dC_Q8FHs
X-Proofpoint-ORIG-GUID: sUL1PvCwwW5IRd2Oi-CFXP19dC_Q8FHs
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tif_resched() which will be used as an accessor for TIF_NEED_RESCHED
and TIF_NEED_RESCHED_LAZY. The intent is to force the caller to make an
explicit choice of how eagerly they want a reschedule.

This interface will be used almost entirely from core kernel code, so
forcing a choice shouldn't be too onerous.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

---

1) Adding an enum for an interface that doesn't do all that much, seems
   to be overkill. This could have been an int/bool etc, but that seemed
   much less clear and thus more error prone.

2) Also there's no fallback path for architectures that don't define
   define TIF_NEED_RESCHD_LAZY. That's because arch support is easy
   to add (modulo ARCH_NO_PREEMPT, discussed in a different patch)
   so it will be simple to do that instead of thinking through what
   seemed like a slightly convoluted alternative model.

---
 include/linux/thread_info.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 9ea0b28068f4..4eb22b13bf64 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -59,6 +59,27 @@ enum syscall_work_bit {
 
 #include <asm/thread_info.h>
 
+#ifndef TIF_NEED_RESCHED_LAZY
+#error "Arch needs to define TIF_NEED_RESCHED_LAZY"
+#endif
+
+#define TIF_NEED_RESCHED_LAZY_OFFSET	(TIF_NEED_RESCHED_LAZY - TIF_NEED_RESCHED)
+
+typedef enum {
+	RESCHED_eager = 0,
+	RESCHED_lazy = TIF_NEED_RESCHED_LAZY_OFFSET,
+} resched_t;
+
+static inline int tif_resched(resched_t r)
+{
+	return TIF_NEED_RESCHED + r;
+}
+
+static inline int _tif_resched(resched_t r)
+{
+	return 1 << tif_resched(r);
+}
+
 #ifdef __KERNEL__
 
 #ifndef arch_set_restart_data
-- 
2.31.1

