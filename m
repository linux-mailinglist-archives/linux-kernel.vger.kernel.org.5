Return-Path: <linux-kernel+bounces-1866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06108154F0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D283A1C246AA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B404C151;
	Sat, 16 Dec 2023 00:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ee5IoCnQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GrLQ5bnO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CC86FA0
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 00:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFK7oBH017585;
	Sat, 16 Dec 2023 00:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=6LpANcvu2MA8lS0jzGbZW7nNZ+/r33G/+knpdIQVMeY=;
 b=Ee5IoCnQDxIU/2obzrJ/9hmnx3J9UlshcxF0AVTCX6NY5l/FdhUNoq3Dt17OOCraEhNg
 vbZQKJJI+HKJn5qGC3zqSG+lRrgwXdTTzObcXmSRLjmjJw/Q4STS1nxrOYe4kSRSqJgM
 gTmAakWNZO6E3ONK3vfZIOaL7FENjLLBRoPoxkfsPWVUpVo1zkzJMKaJ0kuZM7MG598Q
 bCRyJR81WUS2Y9iSXSCfWFLxhhFHZsqse43d7ZvYNvFDBY/vGgFdIKbkDTDWtK1GmsYg
 onQ43cmS82Ah3Qm1GakYrcePF7ch5e5nHN9oFfN3by4ZWKqiAbwXApqqm8kFY1/2TSMI KA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ux5dfb7hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 00:18:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFLuKYZ021489;
	Sat, 16 Dec 2023 00:18:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepcmaas-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 00:18:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4tqJIdRTzrlcgAvBlj+KNYL/d9TA/tculgyuDpKgH92zvW0LL9qkQABov8aw9M7Oju73dJdiIhF1ZRqwgSajzOJ43yjSmu75e5QzJCU2Xvpqp9kTXrlPKLFc+zsJJDW/7cs1C1W9jyQqsblgNIFK4/NpiXeTt9TmAtdJBGGMEq2SFKwbtIntK8ybOvsKAxd19ppV7qXYcJA6wh1/664lc0lB3lxafa8AfGoB7jWpWgLHHAyCqsk++HclqIuKGntn77cvEAtCo0MTBRRkmzC3wH5a8YXvS4nhHlhWi6fLHxYs9jqaK+F7seyfbLwut6QPseHX5auZGmxviESRXonLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LpANcvu2MA8lS0jzGbZW7nNZ+/r33G/+knpdIQVMeY=;
 b=KxTpRqPl4xFZnwnRF90dyLWFMc9US4tiCxTfcfyM7D0VmFpEFr+nQqwA7g/VXJdFIgQMU2e6NufOQcw0f8JwHDijmEqyTM5GePvJf4SDJCz4ObqNJhOHFvoYnUv8IGvM3QtoWjz6OJyBJfTlS+GxQwKtkec6frVou82oA3CJUToZr132ONi6owpfYK9/HX6Z/2m8Ep4+MMdTwFt+/ge2l5PxcopXEHPSz+tzrwN4eHl1ogPKiehEbQGk/JGkK5XqoHAYooe+yCNimPM1ffkK9s8YYWGffFQxCehR99Vh0ju5Q6kCK9uQthZLrH2Gj6j24zmNLe9pS/JF5cyjKPuNEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LpANcvu2MA8lS0jzGbZW7nNZ+/r33G/+knpdIQVMeY=;
 b=GrLQ5bnOy5WTM/yYG0qXYHUHO6c7nfsQtiuag6AalC56Hkk3b3/6tl7BbW5Dv8O+G6LaLARJu35bw9AZ7NO5Y2JAcxBS8JMUG8urx73+71awEECA1NORuX+LXoFUAxcWbCrmrshiWpY2Hv2zU0d8ZSSRsSMyDWZfIZb1RjNTy/0=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by MN2PR10MB4287.namprd10.prod.outlook.com (2603:10b6:208:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.33; Sat, 16 Dec
 2023 00:18:24 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::67e:d770:a6fd:6d00]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::67e:d770:a6fd:6d00%4]) with mapi id 15.20.7091.030; Sat, 16 Dec 2023
 00:18:24 +0000
From: chris hyser <chris.hyser@oracle.com>
To: "Chris Hyser" <chris.hyser@oracle.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>, linux-kernel@vger.kernel.org
Cc: "Konrad Wilk" <konrad.wilk@oracle.com>
Subject: [RFC/POC 2/2] sched/numa: Adds simple prctl for setting task's preferred node affinity.
Date: Fri, 15 Dec 2023 19:18:01 -0500
Message-Id: <20231216001801.3015832-3-chris.hyser@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231216001801.3015832-1-chris.hyser@oracle.com>
References: <20231216001801.3015832-1-chris.hyser@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:a03:60::30) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|MN2PR10MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: b38cc442-7ce3-4110-0520-08dbfdcc84ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	b7mkBzCGgeZaLeEOJEhQ8zRQjWM3jYGCKHzX74MMvmG8s8yLQ6U0LIPaUAOwiA5LJphlpgjO68b44WFw5Uha1clXYDnXQsjWTV6JNjSDPWlrTBaXpt331ZObKF36FbY/RtEZu5yoWZS39BlUeI3JA/DaiKp+LMmWyfovr4SL5rgZpEjYJg3vF8qylssTUQuG2j1KvKfJK5YAl+9rjhIB6L2Qe1XO2WP3BbLbEg2H36vWXeagf+ecLzeGnhX/Z56MZdiiXQxwENstvETID81qWxGhpJj5DJ31jdZALPelwEEdC7Ut/HEh5VMrgAF85Os7L8wtQmqcvyAlaS0gSEF1iXFAzcWiQ0Jaq1ySOBDzexfqytlWK7/E5Q6U3qWhxr4zN0vTBb2orf1JMBu/gz+l6CY0uJy13npD41rEKcDlmgYJWnjukR+1Ld5vqFS+S3t18khd0cF/Zr9A74wbbXNhDSRPwYnsARSetGMjJZhUI0ulAq2gvBJwLw7djzaCYS+KAmaUGktDXoWja0HerzFqYTwV9KhrrP5GpE3LTzxQ6Tj/1SDNa3ur7onNCzFgZh/V
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(366004)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(316002)(66946007)(66556008)(66476007)(8936002)(8676002)(4326008)(478600001)(6486002)(110136005)(41300700001)(36756003)(2906002)(86362001)(5660300002)(38100700002)(6666004)(6512007)(6506007)(83380400001)(2616005)(1076003)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zdGEaCQg4qVaRnQtoRl30GBU+HzgZbIgn0shbeQFN6prCUip7DaqMQo5wQiH?=
 =?us-ascii?Q?5XLa88zMTruvWHBpjt2cKU/CLkagPd/sxUUnnlSQC9LAzAuhNZhUvD1Dw9Qm?=
 =?us-ascii?Q?sohNju0SvVpoCngqyCYszIpOmjXb1abvhtjb5lNymU4ZHIs2aDz3B261hKP8?=
 =?us-ascii?Q?69W2lmE9TK1AZDmFN0c2GKUJ34Q8ratL+oo6/pVPj59JRL5WUXHzstxTJ7rA?=
 =?us-ascii?Q?GH/19K728t6SiEHVC0MbDjjK0SXKdQx4EAqoniqcITVETWCOzvpIVoNcmRoc?=
 =?us-ascii?Q?lWD9OJWSMlioAxyV9lGORcpkQmfDdn+RbGv/GjFiImOzvrO+0RGvxBXjEm/4?=
 =?us-ascii?Q?wxbY0Y2R0u7oeN8f9eSwxa2FVpjTeu6AoX11cW4YcxsC7E12w8P4Iq5I2Nxp?=
 =?us-ascii?Q?6phVhDTovduVnC+gAauLc+vzYTbcQuxHTR05p5uYo7eyHLRYaIrG2VhlVjPd?=
 =?us-ascii?Q?cK2bgM+QaAf1oEo5yH9/J+jEM9XxKug6/4zTTKaWdHqO+e6wncx9bRvr5Wxj?=
 =?us-ascii?Q?vCg6Z/FqFHy7tyNZyg138Ih4U3/LlGc45SjdWOaRgXZoZbWR3t1aJ2wbutKa?=
 =?us-ascii?Q?iykhAPspwntovtg7st/Borx14czozGqyfJcXJPQuB72D1YEDxoxNdZfFqtRb?=
 =?us-ascii?Q?tL3VHT6K17xsDorsP6XTg+Hy/5NQ7AOUnJSLSDkmkTuGpk9q2EksogZ3R4gI?=
 =?us-ascii?Q?JHgqMFFYo9a9PYkZOis8Y0fVR9h6lxHBZZZhLRYbEOlOyEWxwuY5fxoyd+Sn?=
 =?us-ascii?Q?j8g/dlRPF18V1kagaFgd3A4fx3ADf5OTBb3hgqzpBLNmZppQazCA0xfkoBaY?=
 =?us-ascii?Q?5wCgKvvSH6a6+7FXizasi0BtS9SK5TUzhVvR/jjTpkwU3n7gRNAmLt0UObnq?=
 =?us-ascii?Q?16M8nd6zHbLxg22QRMSd+/gsYt1US2LgUY1c7O99cu35qc64iHU/bv1nZLl/?=
 =?us-ascii?Q?vhBnsWxQlAZtqqJA6fV3n/odoPTLlSwj88RswR7ayKxxJpbs1ScDR4CXvaPq?=
 =?us-ascii?Q?kkMAbzgMFciN8FL5hwgj1n7KW7ZoIb37/dzEebd5fO9Frn7Om3DQ4E4Glf+z?=
 =?us-ascii?Q?9vVC2VJ0JW8ByiQbER5QdaWL+SrmRsXRAfHYiVv4E4NzLZ2PInL5feJ5aIkc?=
 =?us-ascii?Q?9VXCyflR7eblQg69smya4Zk8zQin21GDgtMRs9TzEfI1MTp/vBZmff7lM/ND?=
 =?us-ascii?Q?Gos4Fhgt2D2UPK6m11niU7kw+BjWZYK6KrvYz2cBpNr+b827qHjTpEWaFf+/?=
 =?us-ascii?Q?u00uL6+wCnuQoGju0B8GU2S5841da3Jz7eS/KeCn2nVeuggS7VA0Cypw5jFr?=
 =?us-ascii?Q?LxpVHxmozpmpKgIMiZXNb708erq0pZWiuaFhqIAgtjLVlHwr9jsTLRLWtq+s?=
 =?us-ascii?Q?6uZePT26upX0y5oI1fIFKmmxvMTbrh+2JIxMpHVdQkKMWeFhzBKk8YA1Nqo6?=
 =?us-ascii?Q?6zKGTgtHOLOT6IEC7Oruyc8xsDu9fIHH+fW3ykT7aNRgmJLeWRPGk3zrnxP+?=
 =?us-ascii?Q?l78boZJRZb9o4mWQNJH+REVyPj8SXvGkpjcCdCy9w5fD80WSAbVc1vBKChDD?=
 =?us-ascii?Q?iATbEo7vjqisBlXsgINeK+isYNrBBvv5c3W9ecuJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NtXVBDFLs8jNDmBaMBdeZNPs+f7GwjDGygZ1uHoylVH0xdO061C4vE15oid5W7/NtrB7Ui69WxFQYSgkjnFZZdWvqSeU4HUterDSiq8NR3Gs0aOpfcXKn9b3yn9381sMmVVrthbgYjuZ4eT/fZG/RW1SS8zyvyBQc4SSRLXRBYnH1JMXRK3HBrb9s8owe1TlLhqBQpyUthSQkvfn0zNXHLOAs1i1wsFoX3+IB1XqVRDCqcgMTQVFAgJw1a/DyCNrKQFJiEDLbkRdwnjBKlu9/G2l0i+cM0f69MeDWEABiYVSJU5aWY3oAlnVnlvwE2mmUm/heXxSMi915J84lVQxKuGy5L7ZUdpm7Y8YnwcsNYC86t8CdDFhO07kieeA5lG+aDzvBKngMOXWIQ3G0T0JSlErbt9j8Y9tnsmnYCEGk9S5RVqAVwTX3k6vqoE5bd7tMYIqZd6AXJy3ppspAdMp6HMgcJoYfP6zNH2sQtaXwQj8+B9QLGMd+hZ738oTJUd5xUOxrBTT95PWm8uye1mEEsdHl3tE1PMeIxDd9fXsTfAPLnNsNlTcUgCQFHAfrIQrmLrDvDoGl3OM5FLuVvqSrMw7zqBWWkg1HOnCG7cTAUM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38cc442-7ce3-4110-0520-08dbfdcc84ba
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2023 00:18:24.6045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYGtt67w5qnUuEA5zNiJI8QnGqZOCjgPHgb63YCGfqcjNPeEFmR6mJQxBYFxZ+/fYZC5mBxCVBWyPnZcq78dWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_11,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312160001
X-Proofpoint-GUID: N2Mj9uayuZU7-LjW-iEpx3cA8ZClGN7k
X-Proofpoint-ORIG-GUID: N2Mj9uayuZU7-LjW-iEpx3cA8ZClGN7k

EXPERIMENTAL - NOT INTENDED FOR SUBMISSION

Adds a simple prctl() interface to the preferred node affinity test code.

Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
---
 include/uapi/linux/prctl.h |  9 ++++++
 kernel/sys.c               | 66 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 370ed14b1ae0..6c8f6c0156d8 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -293,6 +293,15 @@ struct prctl_mm_map {
 
 #define PR_GET_AUXV			0x41555856
 
+/*
+ * This is experimental and placed out of order to keep surrounding context
+ * the same in the presence of new prctls. Thus the patch should just apply.
+ */
+#define PR_PREFERRED_NID		101
+# define PR_PREFERRED_NID_GET		0
+# define PR_PREFERRED_NID_SET		1
+# define PR_PREFERRED_NID_CMD_MAX	2
+
 #define PR_SET_MEMORY_MERGE		67
 #define PR_GET_MEMORY_MERGE		68
 
diff --git a/kernel/sys.c b/kernel/sys.c
index 420d9cb9cc8e..6dca12da6ade 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2406,6 +2406,67 @@ static inline int prctl_set_mdwe(unsigned long bits, unsigned long arg3,
 	return 0;
 }
 
+#ifdef CONFIG_NUMA_BALANCING
+
+void sched_setnuma(struct task_struct *p, int node);
+
+static int prctl_chg_pref_nid(unsigned long cmd, int nid, pid_t pid, unsigned long uaddr)
+{
+	struct task_struct *task;
+	int err = 0;
+
+	if (cmd >= PR_PREFERRED_NID_CMD_MAX)
+		return -ERANGE;
+
+	rcu_read_lock();
+	if (pid == 0) {
+		task = current;
+	} else {
+		task = find_task_by_vpid((pid_t)pid);
+		if (!task) {
+			rcu_read_unlock();
+			return -ESRCH;
+		}
+	}
+	get_task_struct(task);
+	rcu_read_unlock();
+
+	/*
+	 * Check if this process has the right to modify the specified
+	 * process. Use the regular "ptrace_may_access()" checks.
+	 */
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
+		err = -EPERM;
+		goto out;
+	}
+
+	switch (cmd) {
+	case PR_PREFERRED_NID_GET:
+		if (uaddr & 0x3) {
+			err = -EINVAL;
+			goto out;
+		}
+		err = put_user(task->numa_preferred_nid_force, (int __user *)uaddr);
+		break;
+
+	case PR_PREFERRED_NID_SET:
+		if (!(-1 <= nid && nid < num_possible_nodes())) {
+			pr_err("prctl_chg_pref_nid: %d error\n", nid);
+			err = -EINVAL;
+			goto out;
+		}
+
+		task->numa_preferred_nid_force = nid;
+		sched_setnuma(task, nid);
+		break;
+	}
+
+out:
+	put_task_struct(task);
+	return err;
+}
+#endif /* CONFIG_NUMA_BALANCING */
+
 static inline int prctl_get_mdwe(unsigned long arg2, unsigned long arg3,
 				 unsigned long arg4, unsigned long arg5)
 {
@@ -2698,6 +2759,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_SCHED_CORE:
 		error = sched_core_share_pid(arg2, arg3, arg4, arg5);
 		break;
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	case PR_PREFERRED_NID:
+		error = prctl_chg_pref_nid(arg2, arg3, arg4, arg5);
+		break;
 #endif
 	case PR_SET_MDWE:
 		error = prctl_set_mdwe(arg2, arg3, arg4, arg5);
-- 
2.39.3


