Return-Path: <linux-kernel+bounces-1865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AC38154EF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B345A2872D3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E9F6AA9;
	Sat, 16 Dec 2023 00:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a42u2+f3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AQAb3eLz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023C5568E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 00:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFK7tS0020292;
	Sat, 16 Dec 2023 00:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=GBc3Vht6jBeZ8GBCfY8HcSU4XQVPmxjaKev6rJ3FwPE=;
 b=a42u2+f3i5YG6yfAh5STzMmrn1SxXJksCFEgWgmvkNke+94WzNhUg/ffGqa/P4J0Ydt0
 LXUNToFQuOmzmat5XB066tzhWYKzcmbo+mk2jhRzT1QME6mxquPhW4Gz3r53yw+Sv9WW
 +29BGkr6JYjRB0hwAdoXzNb1aFdOWgMMt8OPk5tLcRGCWHss/90QzBgsg8j7S/Nf+tjf
 tLDU4ClWOYsNS1IV1LQ9vg5mPmGVHmmwsGTUbHyh8f2rC+ybFWMEH+zgx2F3G5PxQXxx
 WAi3qUuT+o4qdvZwXlR4CSIl+wZfPJADfcwFeRx09jRhrkBUNUlpyxdc5Z8jFs2gOZn2 Aw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuuejcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 00:18:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFLuKYY021489;
	Sat, 16 Dec 2023 00:18:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepcmaas-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 00:18:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofAInPcX1LaDHHdvQcYKq2CqlMcf0iqfWVXOObNP1EkB8Pxr1kuFVLvel4XoTYRo5Q7URjAsKjzgY+Sv0fzOkUlB9YUVZ+sQ+nVve/vYeSuXvIC5m1S7ew7aDeWv958g7mYNRqI9Gwbv6iciaEIBPvfpKSIAGlExZsWWCt1OGTpcbJ990qbc8DsZGE38vNP0yw8hKCwFSr/V8dRgb0Qvs8Ibxr1OXeMG0pvl3ew9TRDklofd1EH/CXPBuO+vfdq6aGpdso50c3nq2Lss3QEUBsrfezIeDCPC/bqoNHD28doGFlEpxfcJh2DyO6ZsZsFqRpNdKdMRfx3xTKHHVsdWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBc3Vht6jBeZ8GBCfY8HcSU4XQVPmxjaKev6rJ3FwPE=;
 b=FRLbAUeB6dc38L0jv8bTtr9NgOgWcjVNYpO3KmDQIrM51CZViQh5fCqScuhOujgIwEIB/bABHWVW/m4MPBgUfuAS5xj8mYTDuQwaeyiy84sF2grIhovakqCjg61mhWtK6Sg+nXRYp8nacQ0zIG+jxkmNxryrutjw3q9dPzMpiK3wHNE9rihm+Gz1IfqZh+eoegmV5HcXtca7KHNmF+0c6xuKQMInjOT5tN3uiEXQ9PCaUARuAcwxyDRfH7gmf84hNhzbySue1XnWJ+ARfxZekzr3a8+S5ttwDVAy0/J0EvR3hSU8rKDiWtPcdAlfqMvsgY/SsVUxJ+9ACHhtmYI6uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBc3Vht6jBeZ8GBCfY8HcSU4XQVPmxjaKev6rJ3FwPE=;
 b=AQAb3eLzLa5LvgduCmf3kwTe85Wy8iB/Cskvx940E9yFuN7EbPoirq5mALa4JeIXV4k5nhbx9qA60aKkn1KjgJCFx6+vDxCqcNN0ZQzHcZD9amlPtbrBV95Ef+TVY2kCmTK7LmqQY0RpIdK/FfkMRmPA7UhZ+e90q//Prrnq734=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by MN2PR10MB4287.namprd10.prod.outlook.com (2603:10b6:208:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.33; Sat, 16 Dec
 2023 00:18:22 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::67e:d770:a6fd:6d00]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::67e:d770:a6fd:6d00%4]) with mapi id 15.20.7091.030; Sat, 16 Dec 2023
 00:18:22 +0000
From: chris hyser <chris.hyser@oracle.com>
To: "Chris Hyser" <chris.hyser@oracle.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>, linux-kernel@vger.kernel.org
Cc: "Konrad Wilk" <konrad.wilk@oracle.com>
Subject: [RFC/POC 1/2] sched/numa: Adds ability to over-ride a tasks numa_preferred_nid.
Date: Fri, 15 Dec 2023 19:18:00 -0500
Message-Id: <20231216001801.3015832-2-chris.hyser@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231216001801.3015832-1-chris.hyser@oracle.com>
References: <20231216001801.3015832-1-chris.hyser@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::37) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|MN2PR10MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: 7913f3b2-e9ab-4bf0-843c-08dbfdcc8399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	trTUkqhCTTYxKIXzfdrhaly8ZcTZBn5HCTIX38APolnxr1pRCSI8Q3DszWSCqJHLsDFt2rYK3OnyNK2cQvd1yqmDBJ3pdS11SSoiBB9QJU+jc67gJOtMCpfUUVounZpYglzGB27hZvthiSMNRFtIZ23l+kz1h23YJu+By/3tckwJbAbeT5vNuW6xIrmkpiI0lxjaepSO8AGQT/N7lwwXhN9nyx+4UU40E4lRevZWgIM0s0VYRTvxXzawd4ynGgRWa/QrxEHXEXf2VSHRr4dw0uatdo/zbFPHl31vKM2T3ZyACL4CcVCiE76hbT6oIawgaII87xQm/kpZe/pPgvrbiteaqWPuj9HjcittWriqpM7oHQWXNQwS/qJORNLI7k0tTvgKIAYpYjWMhrGhdBPsBYRtA6uCsAXR9Gi4QT4vST3AFXHPxxNtaHYu5gD85NIJ2WyqNRnYyvVuYut/qONr+ZYHjsAKWzXatBaIqmDK4taJiQICJEnoImydswoyzRhd5wpmbbtOF7WUmhgjz7ghWjQnG1ZjW7vEMLLTWg8R+Gp07iuD3SJ1vCTjMz0bnqMd
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(366004)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(316002)(66946007)(66556008)(66476007)(8936002)(8676002)(4326008)(478600001)(6486002)(110136005)(41300700001)(36756003)(2906002)(86362001)(5660300002)(38100700002)(6666004)(6512007)(6506007)(83380400001)(2616005)(1076003)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?L/cujRE7JctinvR7J9UanySFH+cFh3472JiwHh5o02a/bg6pvwAROaz8/XJJ?=
 =?us-ascii?Q?o5YEzar4a5IyFDtBKs7+92rx/QT3opUZNP/zomrtbNv49FtkjeMcvhWmzbgP?=
 =?us-ascii?Q?KAH6Adly2s00qCGkwxN54mOdgY03FAvgq/WaGJt/tOMEMwTU1Xt7lnflI8UA?=
 =?us-ascii?Q?+dfvdfDln/gZaCcO1punjQxpkXkPQckykT3hR+PsemZrUHkSydqJmiYMvuR7?=
 =?us-ascii?Q?8hNmsgU0pk1VptyNkEZT5zoP3AS37QBWDq4u3mw1oCYObrUfrKK0MJJp6yhL?=
 =?us-ascii?Q?3u68KJI+PPbf/Quc2pdzk7pV5oKinjSAmWSBs8Jy/DZCvf2HfDQ3gyTj1NQZ?=
 =?us-ascii?Q?97DQLXau0aFKYu/WdlS4xPL+EiQGW8dLtC8h2e9GPTpXNsoDQs8NvRCrQaFX?=
 =?us-ascii?Q?8+pdH0OABBpbo4IZEXg1Hso+uyuCJJJLBHoXUUNnNmdHQQEG7/smM7rOhcPe?=
 =?us-ascii?Q?90qNhAPk8/XhlwGlk/XjmYnIxDp8ziCT4IvnAQ9lWd0I30ShSAIpEsAuMGPc?=
 =?us-ascii?Q?T1vDDaHvkrKW87ODhkID7jq4NnloBcfa2qxZG6e80bWmQCmqhGUelvgOHFDe?=
 =?us-ascii?Q?cYXMAI26cpACaHUPCW6UYFFINBODaCNeofYn46LvDcW5Kvw7CLq72NW/C4JP?=
 =?us-ascii?Q?/V6NYHZwjYmu7VuGRZPhO/YMcAlvg6OfUBDm45b6GSJUzT8iTMkK0PDpcSOr?=
 =?us-ascii?Q?afgnNYpiXohr+rA3bXl1BvRRseDYNpPuwMIK6XrJnM1Gim208ti98g8krsSY?=
 =?us-ascii?Q?+fTJQFQ+JRGCFWzMaHkV4HvlCVV5cDrM1geRvKxfcETx6U9TNH8Dty+X3Kq1?=
 =?us-ascii?Q?hvmwbevkUuKGUvN6cyeu0Dym+uVpO166wxEpWW+18Rl908CUY5iO7lZFVUaC?=
 =?us-ascii?Q?ENQBoHmmVcTYGQmoxE1dgUilOK0bL64+06u3BoD4h+TN5z29eRBXWX00999P?=
 =?us-ascii?Q?LBHtmLn/PJwaD8pSCSOnQWqrvcTL7rnAnB42WEWf9a446A4yyBBOJZiWjfER?=
 =?us-ascii?Q?ergUj3ES5chkzOpCSPQ+j88opxwXgHvAB0S5MyNj4RqA3spJfOaiOf7uxPyz?=
 =?us-ascii?Q?8gGtLzwqZPKwkOaPGrQoA99iK7PM1bWKQ8Vo1knwYskDZ7wB3my/iKg9wFDZ?=
 =?us-ascii?Q?2YN2tO9RTbE5ADOg2b2tNOmWQcFg6efNiQRN9z2hY3oTFamyZF3FqW4Qb/9X?=
 =?us-ascii?Q?TipofeYimMLEgN8lfhbOF99EF1nr01NDujsKnJquSixqOJdC+B/RDFRZkdIl?=
 =?us-ascii?Q?PNaBj1d7PK5zSguSBRAK/9iBWBfWvoXsBJJlGzFp1poO7sYpw4rvtppgrQ01?=
 =?us-ascii?Q?5qeqwsgfXegls36hgWnofiV873q/SQ9iuAYfTy96kuPAwaJuO6Jqd+nVepLK?=
 =?us-ascii?Q?oFT29DMPHj05pdiBqjE3kYmwjU910Jb8GHOhtubdkaPKukN6g9SP3Zsmk5GB?=
 =?us-ascii?Q?yYOY8JRMnD1z/Z3GYihGokMWuW3SKObaIZH1J9xeUCzGVblNj6HzOpqeaDPQ?=
 =?us-ascii?Q?bQoDWp/lc/ukeOpw09KcPlAJcRFmWAf+u4f+ZMXWMWLia7gT76fAw7CbeH5G?=
 =?us-ascii?Q?S/PtwkR9+viRR55wMRxAJqoFEewXW/30fbtyb5n7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KDX4WopPXHjzwwpqNYRQm0FdHHKaVqT9DWMzP1iN5wBw2KL/2bdbFnIry+HLUuzK53dW4zHEI83z9+MR+RO/i5h8Z7GQr2GvN1yjRn9lnTVMyDGyCHB8b6YcDN72ZY1Jv92AmQh+8VKEIcyA4XmuAK3Rpx8EpvRbjWCA/q3/1Wvy+LVhQtjz7pm2UWDZJ7DJN9JuduHM5JsPKmrpTwJSzn1C7nSrbU3AGbqc0hRlSVy1HAkAB7xChSnRScuM1YldYObKvpGdGk0PBI+/wNle8y3EdegU3PhisOAMIWSPkyI+AQNfRNENVNvNbgPhPzKaRsShKwdYwpcfh1TmCnaEQWIrT0lcjrQc9y/GT9qDIagsTLhShtIdFoPePcAtp4PtDEeqEY2u1V15MJuxuEeJCrIn7O1EbXiughIA63crcKEXZGtoCY6tPKv+Bsdlsg6jKKDX60y9Eu6J7ubsMzrhreawYodT2QI3061MQLcWua2s9uWj43IJrJnkAj1g4nkMZbvsTxtjeOZ7F2FWSCEe6GDSOBTNJqzlUtxJ+xjLFGimdLMh1iRBKtr2Qn9d2sV2VfGOafWx0R4D88ljxO6HfDsmanWflqkfuz6zLzauM0o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7913f3b2-e9ab-4bf0-843c-08dbfdcc8399
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2023 00:18:22.7409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1M3i5DbP/GQLtEJ91P7LU1cBI14nwIc2qc1qD+S9ticBfj+RzEZjPnntSUNxA+sykvRIPIzZ9hW2h1R7+Wa8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_11,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312160001
X-Proofpoint-GUID: RyRIKOhq-371vekGhSInnSXt9DsUwryR
X-Proofpoint-ORIG-GUID: RyRIKOhq-371vekGhSInnSXt9DsUwryR

EXPERIMENTAL - NOT INTENDED FOR SUBMISSION

This "patch" is a proof of concept for over-riding a tasks "Preferred Node
Affinity". It is not intended for submission, but simply to show the code
used in generating the included results.

Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
---
 include/linux/sched.h |  1 +
 init/init_task.c      |  1 +
 kernel/sched/core.c   |  5 ++++-
 kernel/sched/debug.c  |  1 +
 kernel/sched/fair.c   | 17 ++++++++++++++---
 5 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8d258162deb0..6e7290468fa5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1279,6 +1279,7 @@ struct task_struct {
 	short				pref_node_fork;
 #endif
 #ifdef CONFIG_NUMA_BALANCING
+	int				numa_preferred_nid_force;
 	int				numa_scan_seq;
 	unsigned int			numa_scan_period;
 	unsigned int			numa_scan_period_max;
diff --git a/init/init_task.c b/init/init_task.c
index 5727d42149c3..a1797037af7e 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -174,6 +174,7 @@ struct task_struct init_task
 	.vtime.state	= VTIME_SYS,
 #endif
 #ifdef CONFIG_NUMA_BALANCING
+	.numa_preferred_nid_force = NUMA_NO_NODE,
 	.numa_preferred_nid = NUMA_NO_NODE,
 	.numa_group	= NULL,
 	.numa_faults	= NULL,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index db4be4921e7f..1444dd0207aa 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9380,7 +9380,10 @@ void sched_setnuma(struct task_struct *p, int nid)
 	if (running)
 		put_prev_task(rq, p);
 
-	p->numa_preferred_nid = nid;
+        if (p->numa_preferred_nid_force != NUMA_NO_NODE)
+		p->numa_preferred_nid = p->numa_preferred_nid_force;
+	else
+		p->numa_preferred_nid = nid;
 
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 168eecc209b4..fecf529c9dc7 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -978,6 +978,7 @@ static void sched_show_numa(struct task_struct *p, struct seq_file *m)
 		P(mm->numa_scan_seq);
 
 	P(numa_pages_migrated);
+	P(numa_preferred_nid_force);
 	P(numa_preferred_nid);
 	P(total_numa_faults);
 	SEQ_printf(m, "current_node=%d, numa_group_id=%d\n",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bcea3d55d95d..988b3285f40c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2541,9 +2541,14 @@ static void numa_migrate_preferred(struct task_struct *p)
 	unsigned long interval = HZ;
 
 	/* This task has no NUMA fault statistics yet */
-	if (unlikely(p->numa_preferred_nid == NUMA_NO_NODE || !p->numa_faults))
+	if (unlikely(p->numa_preferred_nid == NUMA_NO_NODE))
 		return;
 
+	if (p->numa_preferred_nid_force == NUMA_NO_NODE) {
+		if (unlikely(!p->numa_faults))
+			return;
+	}
+
 	/* Periodically retry migrating the task to the preferred node */
 	interval = min(interval, msecs_to_jiffies(p->numa_scan_period) / 16);
 	p->numa_migrate_retry = jiffies + interval;
@@ -3462,7 +3467,10 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 
 	/* New address space, reset the preferred nid */
 	if (!(clone_flags & CLONE_VM)) {
-		p->numa_preferred_nid = NUMA_NO_NODE;
+		if (p->numa_preferred_nid_force == NUMA_NO_NODE)
+			p->numa_preferred_nid = NUMA_NO_NODE;
+		else
+			p->numa_preferred_nid = p->numa_preferred_nid_force;
 		return;
 	}
 
@@ -8828,7 +8836,10 @@ static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 	if (!static_branch_likely(&sched_numa_balancing))
 		return -1;
 
-	if (!p->numa_faults || !(env->sd->flags & SD_NUMA))
+	if (p->numa_preferred_nid_force == NUMA_NO_NODE && !p->numa_faults)
+		return -1;
+
+	if (!(env->sd->flags & SD_NUMA))
 		return -1;
 
 	src_nid = cpu_to_node(env->src_cpu);
-- 
2.39.3


