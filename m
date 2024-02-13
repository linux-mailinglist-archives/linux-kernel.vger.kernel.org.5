Return-Path: <linux-kernel+bounces-62970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A1E852873
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395401F24B81
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBC0241F9;
	Tue, 13 Feb 2024 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n7jkOAOS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QN4+elrC"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15EF225AF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803831; cv=fail; b=HhcDQd2dwpUddTy83NxaNNyeFA7sm1qaVwfhnLQBMKcbZfsTqFYVvUH0R2hQB03GF4zsdDbjOLgVsra6vx9KiazwFnSabLkADpBooZBUJM1QQi+8WQL5b6OG5g6Vf41kBEBPqBUTGvXbLmCOr64Yv7a8128aKBs9FeAUNcNzvTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803831; c=relaxed/simple;
	bh=ptzY8xYhgaz8pOJ1Q9OkCaHt6nskL8/KOpzXWY9aYm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J4iUjjC2pQfM1juuCfDdGICc8ftOaU0UF5tGMi9Y2pxnxpiSyRj5pYoZg3zkzT+l12OOOVH+5wVygI80A84fOzHiIdMGgWUGk0eYxcxhbUoy3nZ1o1UQU5m5Ogikwf484SmSudusQ/dt0KmeBi9Pv2zOWCJSh3UsSoroDkHFw+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n7jkOAOS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QN4+elrC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5UC7m005104;
	Tue, 13 Feb 2024 05:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=R+WAiT+QYHc5DleZN6Kcu5t68C7UX9ZuJGb5W6WXKpo=;
 b=n7jkOAOSGPrz0xOT1ygWIpy+pLV5AxAn3lG6PMeyPUz/WZ5fxPTNig+90pGs+nyHj9/w
 CDZOrWT0gTlwjzoRX/PqlUI/WRMsaEQ2PoXs2HYpUJUT3bz5ZzfhbZX4VouBcB+gvaB+
 SSVywMXTOiobmXEANm+7mZui7wLz9tO0W4tid67jzlDBJxkzUBPw4/rmcDPDGoYOEIUw
 nG9REbNgp/te0c9bng7pBQVrZiP+nJdgS6BL0OHbzq1rnAO359pCXn9oXoKv0gSp0qAm
 hV/GZkrEUGRzfF5lz7TjvRIlmLU0SZFjkNt5Pn8RwVoPH+rF0htnrY3J0UKl8Dv4uF3I Iw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w82atr1rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D3xouA024776;
	Tue, 13 Feb 2024 05:56:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykd3t4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/kv2IrIUvtDW5ojLg5dusdL9b6Gp9f8hnijBOsIG724+iItKRjI5sXFknRoj0JIcbJjx7LLZLiM8+BBXe8ygbc9Rn1kWmG/KRyEDrjV4Zomw6W2HwFqca3qotsmgxG5aB7u2TisisdEQSbpPXNt40OnQmbv01SjmlzkDK3qvrWklkEwPcbLW1CEmBsG6h9HZA2K5lHRgNr+21or6m1qtwApZ8kUCsnix2T00a/YIJkwneXimG02o4aqLU5sgydTPOIVwBfyK+KdkX9MINXdNr8lRSdJZ3bs4VPG9/lOz+BtJduVipYiRjsPMXRUJL6M5PEpee2vZTYOaK9Nxftxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+WAiT+QYHc5DleZN6Kcu5t68C7UX9ZuJGb5W6WXKpo=;
 b=IOY9FhR2HafvR6ttJvzSBiXpkOVScWbmQrq+qcJ3IHrzJnoHDM86p+cnxDtW8zIwH+HWagTd7ZdSFsMuYOnB1VfpKXPHtJNWTXeT14t9r443iQrfbdS+/iIl/0pL+AFArSWCV3W1vLTYk7Aua6goLqqxaq2yvhAIaBpa4oh6ItopCe2K74vrQu9y6+TOwlWBDbFXZY8fk7ApEgTjBXdrsrP5NgmJi44omoNUVlyQXTPN13AJHrsVZjfXZtMm9+TaYmWYPeulj/2suvyTbF+H/jHKDTZEelyJuD9XvhMRMr1pBpDefvGkF7jGSg6f5fGXOCi9Szg9s6WvNls+HORBOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+WAiT+QYHc5DleZN6Kcu5t68C7UX9ZuJGb5W6WXKpo=;
 b=QN4+elrCL01cFwWVmOrmsqg0vS+t/cWAcr+grF9SUA/1Qyz2+ZAOrV8xdvjPMkdquFAGbXSpXTcTjf0IQyDvQ9hd7QRVlAv9u99Un9FWGI5n1AXZe9y4+8AzauzY02tlgb/kB+hxXbEOoFH+jqUDCo5Z/ZcrTuh2k687NRrG6Ak=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6906.namprd10.prod.outlook.com (2603:10b6:930:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:56:12 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:56:12 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
        mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH 13/30] rcu: fix header guard for rcu_all_qs()
Date: Mon, 12 Feb 2024 21:55:37 -0800
Message-Id: <20240213055554.1802415-14-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:303:6a::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ebc9aeb-94df-43fa-e3de-08dc2c587bce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cm7Ob36Ume456s8OVBxqMxQAhzlfAYE6A7nJMgKIiUf9/8P5hgavI0vw3mUvzvmjerjLPB7tFTr4x101b0YhI00ary1tPLbCUsYktbI02vKxg1wyXohbGEZYLnHzGQgdgsBfH85LwH7YkExr8tnfA3aq7xmhOs5jyT9PB6OULfc6PyoYPv63s/mhU4eR391aSRnBRpCwf2EQBt+p59BjZRHWZYLgtEWGYMgke1ARhLGRGQyiWBfVgqd2VoycXSTnmlzJu8zxnC0n9uzOhA3mxCl2scKFjlQJ4odpWgYtI8MQ1kmi7WF9uVi+29azoso5yOOkIGHthNS/e1aUj9JkQKeo9D+rNIz0QEYclMMJxhQl9eFh4hA6ZbDOf7n5ps1Ns/VFP7re9Q6YBA1J26jfDHVzLeOLcr8DhcHAGyXhWu3xLpV1zvxqFmm1a+ezgOFw9PsRopx0I6ZBkKC1NQ0mdzPAGbTtR4UyswN0957zWn73KjoVztiGZ7mAy8MHugIkt9khVxngZ73/8RiGmpEQ5pGcdvEqwjl4TS37+xAMVt1amyJB4ueJ+3+UHqqPd4AU
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(5660300002)(4744005)(66476007)(66556008)(66946007)(8936002)(8676002)(7416002)(7406005)(6916009)(4326008)(86362001)(41300700001)(1076003)(26005)(107886003)(2616005)(36756003)(83380400001)(6666004)(316002)(6506007)(6486002)(6512007)(103116003)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UuQm/tVZCPCqWJy3I5mnxdzne6BEEM3GdH6UTHjiihUamFesCHP5SqqHSW6i?=
 =?us-ascii?Q?HNIc88nM9UOCwweCwHBYHI06Cy1+Bow05fnmwi+/Rpz2j3w7Tt6UEvlO4G8P?=
 =?us-ascii?Q?FHU39cIYZsAOBJgr9XPseH+C8lXDWb7bRslLVtXLUNWxVLZnQcgS8p8RaPqT?=
 =?us-ascii?Q?N3m2LErTixMwMAzLDg5xZ6TjzLfQLP0piJ372XyUkOs8WJHmFFK8xU14jhkk?=
 =?us-ascii?Q?NY9pP+YQzzVIGW8s3iuBP1PtBrXzitc5+LEdo+FK46iuwZMVji6nWd13uHYv?=
 =?us-ascii?Q?SPgP4GVt/jzTqg2Oi0sxE6Lx7L+1LcK0UIhj2ZXFDAmWyuGSvCYoQ7tygas5?=
 =?us-ascii?Q?6XHNIYywxXt1akoB81DOuIIMz3OTMS24NfmbM7Mq2whPuetmlyX60aEjtyCa?=
 =?us-ascii?Q?FSV+oyCKcmKObVvDVP5YbZ0lOpS4t96LEEn+VGjQ708eO/5xgut9oD/INBE3?=
 =?us-ascii?Q?yJ3Tj36Lx6rfO92hkmchrokpbDOb3I2vGD61H7nQUuUhvHxVtM7NEaCYjE63?=
 =?us-ascii?Q?25z9R3RTlr0LTatxZwxkYnomMTxyMSgVAZ7JEvbJCNLLOKD6Dir1f87qFnhc?=
 =?us-ascii?Q?s3irZAf1mxHb6Dkl0eazQZ66rho184v9PBX3AIgGgARR3gpbHZ8NBsHYFP5u?=
 =?us-ascii?Q?mPNbIAbO/YADwSyZyiEqMkHjwcabN66zAitvQbeyLslLRoRKey3m1r9ov28W?=
 =?us-ascii?Q?eWUxiNhL25TEmcc77MRHQNsW4IZuBChQ9xy+OyNJ8hiDpoeIA6FgiGX0+O7S?=
 =?us-ascii?Q?JT+jToUAT4oVUUZVxKlov2GBIalP4I0/icl5ZXSIYBzDwr88XXzTIPBPBGg+?=
 =?us-ascii?Q?G/+76Ft/+gRK5o/a7+k+xMNDFaWmfmlNsOrRzJdkrnGA0+dxzKpri8w+/rXH?=
 =?us-ascii?Q?p4KB1Nr02yDqwHsCf8ieHVZlSY/Ytjj2WNkmFaFCJvKLmaBgtIXGVFysTfLf?=
 =?us-ascii?Q?+8p33oibCPNh5psAjLQ+Up12OTaHY0s+nXyH+GzZwoDkQL9TAaneAhw+srKF?=
 =?us-ascii?Q?b0Edc8x481/q2mRuosbUODF9+BueTbBefgqMg07xjvgmpYUUGg6d7IC6Rt9g?=
 =?us-ascii?Q?W44RVaR5ygL+sPCsWB55oPyI7jYmYfi2ar7GJ0I6pAJO6khw8DikIoyL0enk?=
 =?us-ascii?Q?ZPqyrwvvdAb8978+o2917epZdui+PI9Vh9hBMUi/Pb+vvwJWgfoA3niet0Ej?=
 =?us-ascii?Q?V6ill32kLaO7DVMsSMNEL0ETKmBZwPNVVDK0Ah+rvnTR7r7Vih8rftQuxcaE?=
 =?us-ascii?Q?rHczJ9+nSAXXqKXhebbZKadC9G7LXLAhqTr76Z1o4d5PI6mZWj55jrG44JCS?=
 =?us-ascii?Q?UyUj81lVduKZrssfU9vwMfyhRhyuycyt4cPeZ0bdPJ5LxiSYd9y6tDyYczE9?=
 =?us-ascii?Q?jz/XFrQwhwbUA39LChSiD2Pa5BDjroyN4/6nMW5FKDhpguKO4kod0kvSXyCl?=
 =?us-ascii?Q?cXebkQufUjD0vj3tlMDVOiGlr4w+GsAyoHuZFRDslU91nFuUb2uo+BZzj5D9?=
 =?us-ascii?Q?U0CvD4BCZp/+c6c43GFVVZmhpJEbsUZidWbnM+HGLdGkH0g/R+1w+cP+JoOw?=
 =?us-ascii?Q?V3R6m9O+dzHp68JModizthla9tkITCYpgFl2kJTNN6ZCZzwZZuqbrX2x8Ymv?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VNXR8A/83GXNONEHjN62F7ZB2LNXJPcWcPIkbTbm9G42Kir68BoeuqL1RI8ERGGjMlgWMWWTdhr/1VD7TGpc7p446Pn5dPRlehlO9ZWnNsro3Y61tkhD5tZzVSI0S61Cr2iDB1BsJEUUbC3z8sjupd/PFEvmSRzClowHs8YciraQ9iHnfSOmYzCekrHb5Myv7WyWAJfijPGONxuGFerf3Y8P+Dbj+35//IRGWXhE0sa7jh6btgtKab3izDo+x3U1zf9PXE83Ey4vqBDGcU/kM/t46WBuS2deLJjaS8qXqH7TeK/+vlxoUJ/HodYTwFYRX/tDJQtAFM1ivf3JXmHmPSuExMvlzvOdX9IZDeliuSJQgT8K55fdte1N+PqOT/Pq2aahY7TjV3g69asop11dy6tucP3yrPBX80NWRT28lScjxcqgLnRlx6r2Hnsp56Pngmy/T6WclivTlFXJXMS9Zpltuw5KG4zVLnzPwKQJkEwUzjnH1r6JWNHXxLWCyd9eArJLxeRT7rc2YMsGAgObeprRb1zf3ImCGyZcruR+luQGPFBPb2LhMSX/cnCchfy4Up8Gks5E0bqPLxzB6werGDKtAVBBga1DxY04Yuv6f/s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebc9aeb-94df-43fa-e3de-08dc2c587bce
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:56:12.7414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPiyZD87XgGxyro5HWGY+PCCc7oPXhBN80o7ODrqjdrmMmdZMACQQw2ZH3xZEsTHn3G2U9eWIMoozXjXSOSmf61GzNSf8bqXJMdcbh//TmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-GUID: eMTZOi3O761qKBSqv-ELMEMHYC5OtEne
X-Proofpoint-ORIG-GUID: eMTZOi3O761qKBSqv-ELMEMHYC5OtEne

rcu_all_qs() is defined for !CONFIG_PREEMPT_RCU but the declaration
is conditioned on CONFIG_PREEMPTION.

With CONFIG_PREEMPT_AUTO, you can have configurations where
CONFIG_PREEMPTION is enabled without also enabling CONFIG_PREEMPT_RCU.

So, decouple the two.

Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/rcutree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 254244202ea9..be2b77c81a6d 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -103,7 +103,7 @@ extern int rcu_scheduler_active;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-#ifndef CONFIG_PREEMPTION
+#ifndef CONFIG_PREEMPT_RCU
 void rcu_all_qs(void);
 #endif
 
-- 
2.31.1


