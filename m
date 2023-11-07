Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AC07E4B6B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjKGWEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbjKGWD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:03:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAB81723
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:00:48 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LK255022959;
        Tue, 7 Nov 2023 21:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=PzHw82oEkjWSM8GhCZuzoOhLZoIhhNSDnnxsu9vLv6o=;
 b=uBCx9poGHhF6SKD85mK2kEM6et/jSfcOa3dKkyUXNA973zwpyxa2DStX3OsqFOfezFVr
 6GTMZLJiYw32yEfAVMrWIvSPv9lqeYV5uRhCXP8DQ07QkHCTMvvtGG7fzhVgrg7dtVLj
 mEaroCcdMmEb6LofBQpHBn0HVR6UwItRhz4uNNmhOg66+jzKA6g8D6tRtltjBS6r+A9m
 av/itYG8dPz5xTu/hcOtL6tT36Q377ewvWA2XR4StFkGmkaq/aon7WTEydcFzVkEwsr5
 fq2nOZGLMdS2M8ZpDsZUuWroLAg+cLku5MnMzZ/coCx1oGrAQcLqzuHjub5+ieCTY6z5 qA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2002j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIwbU000509;
        Tue, 7 Nov 2023 21:59:50 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wsmf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCpYolXEfBN14K5cCahkwXkpgCCx1cgjaDT82wofFyJx9ueUKemzbapGqPj20AziBzFelfEEdRpPL93vSpsuQ317h93gw60sw1Bqc5L51VcoBvtcmX59WbH1U6ERIeYtKeRddpuPXMPrV3cmiDF5/5SO+JeIx5G6arDjakJSTyqLPr4j+vOferA58cSPWSi2HL+3eChoG/25a1z1vGJRv4oe9n/19bpEuBXQzfee4hbIaw7MvGlouNosh4J5gTfEaCpu641+f9mwdsX9CSEcyE5mCn5AUwKFHpEzK9HDJGMWB89k//WwIYLELhRTQ3dALPQ2TZjaaTgDmNkrpgreaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzHw82oEkjWSM8GhCZuzoOhLZoIhhNSDnnxsu9vLv6o=;
 b=ntFrAitrybSGSqNBUewhVP1XuOn/FOrw8lonGpni6OgSGSx2bbQ9ctrUP4x5AZwlGjwWgxkAfXE6sgvaMBr61nTJ0aznT4a9NKhy2L2r03rF15CRt1OeX8cUQ0r3Qdqfplt+qnnd1Raab1vIJKrSyV2eLB56ltOPej9xaG/lCFOaxHtjOXuTPCVKmHrcqmo18te3vpzCXjv8uX9d5pGJaOhYfyzYAe3E6Zv5HI6L28S3xHZvLLI0Ose75POV0AiL0hHDhgv/gP5W2FkqR4QgkLr6pMn6JUTgpJvsrlAEjZq0aJt1pSugPfrWE7EZdigIP+ttoHxcQuMb53EZKVtkZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzHw82oEkjWSM8GhCZuzoOhLZoIhhNSDnnxsu9vLv6o=;
 b=b4B0rJqdH7d+pBBB2J3g4rH7ux+22YzLFcyzjWhpL8AgjJrVxVrQDmZeQsZ1+0rpTqF19wNTYFPRMWofImzcKpYf4qv0ImZkP5NpSO6/eY2I9Zi4rfa3D/NdtWa01adi+HdfxlyETn5hSJtjeqMo4DqfR1dNvNCTzKsoyzAEJ5g=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6141.namprd10.prod.outlook.com (2603:10b6:930:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 21:59:47 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:59:47 +0000
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
Subject: [RFC PATCH 41/86] sched: handle resched policy in resched_curr()
Date:   Tue,  7 Nov 2023 13:57:27 -0800
Message-Id: <20231107215742.363031-42-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0309.namprd04.prod.outlook.com
 (2603:10b6:303:82::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b602de-ef27-49fa-2b7e-08dbdfdcdb63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alIjP+A/j3H7tkRjSsPJGNRMv35Dais9mxh2/ds8jKdXpZu4z1ZMd8Xftr/zgNcEY+4u5cGOA2nGoRsztzXZAz8z71RT93d5SA6W+t+32IoeK70nTIpLZxW+G3bFRMcJbJXf6wygrxxG45Z0QBDj1nYLhaNtH/dnNVZgaPGXBBwSjNREkpSsynO5u2jRxAU+VwiX++1ztHXBBXS2xGNkaFnBPzv1zEAlrB624YUMqhy8Wj7Gl0U+s6dIVFVCrlN+bH/cFREFdI5hmEin6RPxw3xNLUORhkhwWXJo1S7IXZri1mtAQ/aPmI0Snu9+gGB1n+cOKpGSqXAzV9Jogfq9gnkxnfK2mJvzd/ZIqHaMeKYgiokWlC01JnsEmgN0IB+mkK7XUYYxs2IhUbt6VPHQOzZyyceYVyb9cuJISBltPZB8K6dA5cCtZc3OSibfAPk4boEMsoL+xG7UfpzfTb5pR7xQ+9ERGejW8cDaKTbIg4F7S4u/3aXFtoQpbyTkcXn0GjmggYU03Sak16pHGpssEneJrSOeoEHpUMXtOjFmQIZQKEG1tVkoi1Qh93bPCD5t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(86362001)(103116003)(8676002)(478600001)(8936002)(6486002)(4326008)(6666004)(38100700002)(1076003)(5660300002)(36756003)(6512007)(66476007)(6916009)(66946007)(66556008)(316002)(2616005)(7416002)(107886003)(7406005)(2906002)(26005)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JoCkS36sxHBJKGvP0/REZrZv+iEt7Zhq/XXRQDpM4sxubzqe4PA/624H1lRF?=
 =?us-ascii?Q?hcCuMG4yNrq8VncbHqQzna4PqYzrbwUL4i2jxInUP57H19Z5ccbysDpJzIPo?=
 =?us-ascii?Q?0gDlJ4VDRWtlfnqQVlvIq/FOhSq924KtHiOUNQq+quTT/LMik4B7JE9T45Io?=
 =?us-ascii?Q?DTOU/wdp6VwWLP1ObBw9SK9tM2KRYmHu3ydrelqz5gOxrk2JQ8BxWlYL8hFC?=
 =?us-ascii?Q?9gq50f9/obXLq3NeYZ7AocP0lb35TSm/l1U1jKbmH+Ir0xG/kkGAxwUKQW8X?=
 =?us-ascii?Q?5XjxIhNOBRootjTxOP7sjbsVY+j4Nwf3sQT9XrURyVwBUc8V/YJg4bV4TFOz?=
 =?us-ascii?Q?x0FVrsen1aA3lX9Vy9De0THEBztz8rUxjr7vq9EPwsWMm+Tkm8j8D/3g6/0L?=
 =?us-ascii?Q?7xE+rUGiuoXxv90dVBqpjo0uX274v1z6HjIUsEpF8rkzwEhLVECXnnZDARzP?=
 =?us-ascii?Q?Z2kRrska6Yew7mC22p3O/rvO1EDPFsrXQq37Z0OjPE3PnFbNB75VICn1MukP?=
 =?us-ascii?Q?mw1PcKIzOgDmEw2r+aZhpmEE+pM+OntNcg9RBLejUm1N6wI5r37sEnHmSyrE?=
 =?us-ascii?Q?nOleh1qWH2+k5SNwUpviG5oDHQmWvdBpcSjneHCpxk1+/XAMDAAveVZPu95X?=
 =?us-ascii?Q?ZEE1rQI+RLtqgmuB3ZCv4HA9fEeK5+MERNeRjV51oGPnijtsHsEIKxzxTTlx?=
 =?us-ascii?Q?SGn8WO8PqtJSzKn+K3YpEIZmkzkPv9yukiVwysx2DGFhsYosKZJRUPNNGYPx?=
 =?us-ascii?Q?Szu8vQUOt4XTWZmsZpm/Cih6oVNPgTjBBGv6N/clHWamGICTXPc5jo7okdvb?=
 =?us-ascii?Q?//Y+Jk8Bhj6RYvjW7dseVhSdttGB3ycSTQEo37HPBYafRHp20ZKAeJDcnIei?=
 =?us-ascii?Q?mkVmhzna/EhYihAgFnu6h8OZ1uQQ7CcWWbZM3NWaOlYc87vFpF+ybGSDbWy5?=
 =?us-ascii?Q?Gb1zQtsrPXUW96CYjxWODIIp/uxd18LoYOb7lZpukn2n7uG4CV6gLfpK5IFv?=
 =?us-ascii?Q?kfP9/iUnVvLEsYt+y3n5AROOtsQ3rEt+Iq4RzeR3glrmENvTqMqydNnFCAb3?=
 =?us-ascii?Q?KolP91h2TEtbolFYePr9shyLC311bbX/DDcGixNFOxz6l3ubU7CVIrApNAXE?=
 =?us-ascii?Q?+kx64nAu+sAP34UNDuZ6ymWuLoQMGrnQuyohsih9VLnhqZNN4+vXNOhaiHQk?=
 =?us-ascii?Q?YiALUlIHUHC54EvvfpVLr774r8OTx0KOgfUvfDng93II6GaQYeyVFdF/NmQ9?=
 =?us-ascii?Q?hjn+pmLu3rdEvhfjb2FRRZl1DPNGVSQ3ZHbZizr8Tm/wRwXkV0iSUbXDHah9?=
 =?us-ascii?Q?kXwztxcuZT224TkbBYtzHua8qWheSkQsefhHq6AmP9Qrzh84H5QM2764Pnam?=
 =?us-ascii?Q?1JQKIsmsSd4QNyUPuL142xiokOQVVhJEwsf7iG9DhJf+MS8xJiY3kUH7HJsa?=
 =?us-ascii?Q?DZIcMcJ4yPl6NX7QFEhA/wxaqr69hzfm+67gMhZ3CC8iduggHiCH6ThSZN+u?=
 =?us-ascii?Q?APSoxuCD2g2yLtfrJ1fw3FucygI4tHy5aMrvhbRrTNxx7MLAG2afS/MylT+K?=
 =?us-ascii?Q?rqAvhicbiMCvBJw+TLnyQFHmfbk0kpR4eFtF2yUlYY4Aw+BCKV+SQdtB01Hd?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?clOikU/RxyK2qgsFa4b8hgNtIg2a48cn9dqUAbTgr8tlvEovDYNwGWlyCxNe?=
 =?us-ascii?Q?JclL6B/4LYQ3SjxcSv0ZClcjsQFfYDgeHuKThQywPAUvjQxuPX+PP6OZ/Uof?=
 =?us-ascii?Q?VEKBNBKoth9EGO/GGP8bYjB+jyXCqTj19ifQi08rY/67V/AQvUn8nm4iVpv9?=
 =?us-ascii?Q?pW6+QvRyjZCWYic8yGTpW/VMcPtpHV4m4FPEcaChdEs1JM/AwylJVAsUwxrI?=
 =?us-ascii?Q?fErjGULVzMRSNy9rZlNJwC3S2HUAMcSQnfznsm0QvyvL0xIXyX8u8f2Ayi5c?=
 =?us-ascii?Q?6B70Fi8zXchhJIr6dA4s7yavPZmyR9At/wB6IK92mEqBTPEvLxdWba+e+DB1?=
 =?us-ascii?Q?V2/LZgurU5zRNQNUILnF+kLUw5FwbI85TsIMH8sEiEzk58Kimek/thn6H2Bl?=
 =?us-ascii?Q?ogiyIaFDvN/gatWMLj5iIW5wKoXzYgBfncqL+/9icDjbf7R0ZYpBqEDr+8k/?=
 =?us-ascii?Q?MtBGnmUO09ZQBX/Crzlw4/HwKCEAQAUOGcu/Z/VWV4DMX/vYHliRB3JMzFTf?=
 =?us-ascii?Q?InWEfQMQJti2jdaDvcLc6XZdZMxzADUbBGzKtx+pa+8IELCaLoJUqUsPqxLP?=
 =?us-ascii?Q?H0gJ3+IkAtB2O3V2WHnAytX47ft6+kyX4/q17TRieZN3YLCnxpOD0wy5JmkP?=
 =?us-ascii?Q?iAytz2HavXKueJ6pAtygj7MLxgrI2a4qRPCv55514TZqk0Z5bHeVw0XTy9Q1?=
 =?us-ascii?Q?ieb3KEHE0fIQNWG/qu5dBr2tXS9zTorKv5wbj5Hc7IxgmYjCCmf1fgJIcYlm?=
 =?us-ascii?Q?qGhHItEDcr5/YU+3LLBGVYcUwoWr5QJ2g+eR//kgOUWstSSWVCxuSoVswqAH?=
 =?us-ascii?Q?UQYly92iD6DjVtQ3S6BPwt3iwrwnYm8ooL/XbC9VPTYZGPbZBE638SvL+HxI?=
 =?us-ascii?Q?LerndjVXo28Be99GLFia5DiPcXr2hDvmrzk8FJkGF9cneuivIWztMMTBnZkx?=
 =?us-ascii?Q?qQm1rAAxqEzjxxI/VWaVu3fVL3f2dc1mMqwKy3x5zAkoZPpLWUDTRV07INoQ?=
 =?us-ascii?Q?LpaJGAUNwef+pgIkUYB2yaHeZQ2GC7GeZuTxlGUa1YZp6/7LbCAtZv4CQZE0?=
 =?us-ascii?Q?AISSamG1fdScHeE2L6MU8ez95DkBqjMBGq87FbAyjYIWVNwbJu7mZsT8GJNF?=
 =?us-ascii?Q?TheCpV+rjHdsd5xJUZKWqOALgdo0LpnklKf0QTaQcYwSygB3t6m1t5J7TK3i?=
 =?us-ascii?Q?JmAVnLt9E0jof+r/gn0smsg2DNQ0wVhv8bMT+VVSciOZPa4CRGl6cakbHgJW?=
 =?us-ascii?Q?sEcFM2kmQtcgYXK5tE+6gUWp+xtWS614GAyxKJuvvJbNKahb5th4VsdH7lTk?=
 =?us-ascii?Q?bIkm86bL3F+AnTyqkizk+Dll3x7CTmOW3E0jWe8ZtpU0Xb8QD52TaOKm6zy0?=
 =?us-ascii?Q?De6totr4QVRjEWLCEW282FX3fnQwGlmIn1AXfFBXDJ9k6po+XHLZgSMYjnKS?=
 =?us-ascii?Q?3z3vl6OGKlWXQli9/DEfMkfcRRtZcO15zMHbKJZWUc/TtaEmLv/GfNKWoJRe?=
 =?us-ascii?Q?gs0JUf3WtoExfM6G4amR4EHTfFNh8k1/y4vE40d0U3S8w3FeB5+H1qxjOg?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b602de-ef27-49fa-2b7e-08dbdfdcdb63
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:59:47.0886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDr67krRKVBku9HxJswQeqUG9JcfPw2W41N+nH7XPFECnvEAT7jpv4jOccccYTzYiKfgariUK3j7ONCDXBqu5JahFqKWFz+mcUFzKMIZ7bI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070182
X-Proofpoint-ORIG-GUID: tHGkLVpKjcEGtNJ_4RGk7iDp9yAfm-CU
X-Proofpoint-GUID: tHGkLVpKjcEGtNJ_4RGk7iDp9yAfm-CU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the last ports of call before rescheduling is triggered
is resched_curr().

It's task is to set TIF_NEED_RESCHED and, if running locally,
either fold it in the preempt_count, or send a resched-IPI so
the target CPU folds it in.
To handle TIF_NEED_RESCHED_LAZY -- since the reschedule is not
imminent -- it only needs to set the appropriate bit.

Move all of underlying mechanism in __resched_curr(). And, define
resched_curr() which handles the policy on when we want to set
which need-resched variant.

For now the approach is to run to completion (TIF_NEED_RESCHED_LAZY)
with the following exceptions where we always want to reschedule
at the next preemptible point (TIF_NEED_RESCHED):

 - idle: if we are polling in idle, then set_nr_if_polling() will do
   the right thing. When not polling, we force TIF_NEED_RESCHED
   and send a resched-IPI if needed.

 - the target CPU is in userspace: run to completion semantics are
   only for kernel tasks

 - running under the full preemption model

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 80 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 70 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 01df5ac2982c..f65bf3ce0e9d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1027,13 +1027,13 @@ void wake_up_q(struct wake_q_head *head)
 }
 
 /*
- * resched_curr - mark rq's current task 'to be rescheduled now'.
+ * __resched_curr - mark rq's current task 'to be rescheduled'.
  *
- * On UP this means the setting of the need_resched flag, on SMP it
- * might also involve a cross-CPU call to trigger the scheduler on
- * the target CPU.
+ * On UP this means the setting of the need_resched flag, on SMP, for
+ * eager resched it might also involve a cross-CPU call to trigger
+ * the scheduler on the target CPU.
  */
-void resched_curr(struct rq *rq)
+void __resched_curr(struct rq *rq, resched_t rs)
 {
 	struct task_struct *curr = rq->curr;
 	int cpu;
@@ -1046,17 +1046,77 @@ void resched_curr(struct rq *rq)
 	cpu = cpu_of(rq);
 
 	if (cpu == smp_processor_id()) {
-		set_tsk_need_resched(curr, RESCHED_eager);
-		set_preempt_need_resched();
+		set_tsk_need_resched(curr, rs);
+		if (rs == RESCHED_eager)
+			set_preempt_need_resched();
 		return;
 	}
 
-	if (set_nr_and_not_polling(curr, RESCHED_eager))
-		smp_send_reschedule(cpu);
-	else
+	if (set_nr_and_not_polling(curr, rs)) {
+		if (rs == RESCHED_eager)
+			smp_send_reschedule(cpu);
+	} else if (rs == RESCHED_eager)
 		trace_sched_wake_idle_without_ipi(cpu);
 }
 
+/*
+ * resched_curr - mark rq's current task 'to be rescheduled' eagerly
+ * or lazily according to the current policy.
+ *
+ * Always schedule eagerly, if:
+ *
+ *  - running under full preemption
+ *
+ *  - idle: when not polling (or if we don't have TIF_POLLING_NRFLAG)
+ *    force TIF_NEED_RESCHED to be set and send a resched IPI.
+ *    (the polling case has already set TIF_NEED_RESCHED via
+ *     set_nr_if_polling()).
+ *
+ *  - in userspace: run to completion semantics are only for kernel tasks
+ *
+ * Otherwise (regardless of priority), run to completion.
+ */
+void resched_curr(struct rq *rq)
+{
+	resched_t rs = RESCHED_lazy;
+	int context;
+
+	if (IS_ENABLED(CONFIG_PREEMPT) ||
+	    (rq->curr->sched_class == &idle_sched_class)) {
+		rs = RESCHED_eager;
+		goto resched;
+	}
+
+	/*
+	 * We might race with the target CPU while checking its ct_state:
+	 *
+	 * 1. The task might have just entered the kernel, but has not yet
+	 * called user_exit(). We will see stale state (CONTEXT_USER) and
+	 * send an unnecessary resched-IPI.
+	 *
+	 * 2. The user task is through with exit_to_user_mode_loop() but has
+	 * not yet called user_enter().
+	 *
+	 * We'll see the thread's state as CONTEXT_KERNEL and will try to
+	 * schedule it lazily. There's obviously nothing that will handle
+	 * this need-resched bit until the thread enters the kernel next.
+	 *
+	 * The scheduler will still do tick accounting, but a potentially
+	 * higher priority task waited to be scheduled for a user tick,
+	 * instead of execution time in the kernel.
+	 */
+	context = ct_state_cpu(cpu_of(rq));
+	if ((context == CONTEXT_USER) ||
+	    (context == CONTEXT_GUEST)) {
+
+		rs = RESCHED_eager;
+		goto resched;
+	}
+
+resched:
+	__resched_curr(rq, rs);
+}
+
 void resched_cpu(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-- 
2.31.1

