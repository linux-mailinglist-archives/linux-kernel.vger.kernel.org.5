Return-Path: <linux-kernel+bounces-78610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C488615DA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D70287492
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD7581AC6;
	Fri, 23 Feb 2024 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JPcMnRrJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I9Ls/RjH"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AFC823C1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702302; cv=fail; b=TrJieVyA3uzG3fSkr3u8X82ivmKN1mtz9MdiKQobDZLZ1m7UaQuyk5k+ex/UknIqSvfonaj4tdTnYnMLf987eEkk62dA03CWu+gsEN4Hidkx9wEgJeH9YIdDLixYUsFkFheMzOXh/jNrV6DJtfJdIQt1TGrSB6qtZwjRfnANUJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702302; c=relaxed/simple;
	bh=NBhNyfIj01ZsGJmBQt2U1djDrPNPgqd9WcI3KsTkn8A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rM3XNmeEc8ADjYVj1W956k0WFUDLQQ9zAi0fagpl8DqgaRJhiIqc7R5nUOwy3FpuYObw3Y9/3Rig2Me4P9jiXgt9MzTchK4Q8/MQbxrzgDjYlQr59j6uonuzIkYxvOYHj1xHNLVbxncqp3DOhpUt018ODW/MerC2MA6JLw5UqVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JPcMnRrJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I9Ls/RjH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NEKFJT006784;
	Fri, 23 Feb 2024 15:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=xqmOAsAvA6izP7lCDRb6GEPoc+D/4g3iBS1lZrCbI/0=;
 b=JPcMnRrJMPiwcXmO4+RLran0jGbeMPuD0nTtoCYlfiXUT9F+kthVeNGS3KsP4ByotClz
 ldJqvR5Dr9TPuFxNHLKOoRlhcAz0u1hxUFkCBz/syeSfj38LKV7B6WhVi8zbSluFhL1a
 O1LRTMsiAbN0Gj9iSCcCkxwrRtBgjgGSqVbcHm8fQw+GlPC+6+rJq/sH7q/KwTTU8tYT
 Lz2qEodrnc1oxbNSO4JltWnIN+ACf2WUXeuGg2gNel2wF9tmRTKxgaG98pz5R3pSKoCV
 2STSCvTQB2qCW6kR68nkCxSbpLY1ZL2O5/E07woJIaf/zWEBerV2Mtq0lgW53vFNuujl Ww== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd4knykmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 15:31:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41NEBIbO020280;
	Fri, 23 Feb 2024 15:31:33 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8cfmb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 15:31:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXp66v1HORqpjegFT6qABYgZhQyFICVQSG/6pOu85DHcoLk38C+N6O0AAMRNpb5t8g01hzj9xeeA/ntpCcz66JsmWOnxnep/DNNqFKwX+/BiaOpQjkRXBq6XuPJSjLX/QcYuhdSwncpK8OVoJZEIDOzfza8nYswe3YjwUEq1oIx/n4dC0kxb0IA7ilT34cNr1DsnsW1BFQiYnxzoxM9jTepcWFvS5NKQf/LiKLH8wPXrHwwXefxN3+5VjiBHBL73LuB2/hP1kR7KERQGCz77tQG7ZLySX4ChMzu7a8H1XV4SvroXUp3s6Ps6kVfceVPywe74wL939d2ykqt3X4KUGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqmOAsAvA6izP7lCDRb6GEPoc+D/4g3iBS1lZrCbI/0=;
 b=UFEg8lEpOZRHS5UIlOgXK3kCGZ+S6HXLfxh/TxQt32zx5NmkwRJHE7Tr/0Iefdr9jdBaWKOiwMdUH35i5gFVAgmYPKUrSnkYpX1xlNnO3Xzh3WB8JGPjCL/p1CL/moRBTtN31L/ZCOViG+2K0G5/fLA/TchEm63nj8RJbm9JQmIhr5bKW67ruEujBoJv7VRt+R5rhNGcKtzx8bTHY52wIyeUqVgSPd83GExxHGcJCKRpptCDMgy33G1ZvHRiDqprK77UokvDswJaH+bRoVjcvzt8xkcaqXN41oNC6q8MbvSDFkyZW9ii1IUkLooKlwP4ihKZPMzMUKLtXHP0lRemvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqmOAsAvA6izP7lCDRb6GEPoc+D/4g3iBS1lZrCbI/0=;
 b=I9Ls/RjHIaL/sAG8V8122K6mkOL4i1M+xPcqxQniSC94haUr0VKm8SXRACWU/7/6yDsud0+dMQAXZWn8QzgfU7b/6JVodcmhFyVJ6g3EHLj6KV799ZNLFn+XRGjIA8vMD37JMwlbi9yoQAwH7zUxvlZcLKEKQT6iobfgjokz4+M=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by BLAPR10MB4962.namprd10.prod.outlook.com (2603:10b6:208:327::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Fri, 23 Feb
 2024 15:31:31 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::3dc4:7751:97e:42a1]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::3dc4:7751:97e:42a1%5]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 15:31:31 +0000
From: John Garry <john.g.garry@oracle.com>
To: mcgrof@kernel.org, russ.weight@linux.dev, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc: linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2] firmware_loader: Use init_utsname()->release
Date: Fri, 23 Feb 2024 15:31:21 +0000
Message-Id: <20240223153121.440763-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:208:329::11) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|BLAPR10MB4962:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f063cf3-7dc9-4164-148c-08dc34848298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PgAylBs4z+H1mYULQ5glwTuFLUbd1/F15xZQy0kEZPaD1YKIFJVmnbfY0XKQB8ZBKtLwoAdQVw4fgK29y8hrkfdP6BpMw9Rfz38pkwzgUqE7YF9AZ+6klS58ZXrNxSSEhkfnIb1Y30XaiAcNGg43YhxetUUykklInLYcznktleveHKdNWVBNX+FiNk836mS6jC1HG7RvDN4BOja3lQBut+epHBb6gItH9B9y7k9l/CUnnbfvX7bj+n9rpGVcAYAP/jcHDisEDbxZ578nu/X6DiIgKSu2OB02fYPukaPXnGwJcqg1D9iBRMccHt1svuf2pZbUUsYwkKtcpoC1FI/DlIkUgnYT8GmKkI8F8xyBcw2hUzrZlSA/Kp35O8ppx3fSVZt7L3xYJ8WSb9gS/mPTBj2JfahfxL8FevMN576f3Ob9hvlfeWJsRXpPivvvtBUNQ+AzXqB2jCf9Z3gTlB+oCXt8zVTIQGdKI4+f4TupE58t3t0l9MrF7FP82Wy+VtdRTFf+X29cjxrpQ2e5yWyD2zSa5UqQ2NNqX3e7vSU9QOI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5oJWkp8sNleebBTEJ76yZfO1ecPb4FAB6LKRCfFQMkeabdJlA6zjnfX3llrv?=
 =?us-ascii?Q?/ixb+EtsFKFD6N3ktmuavdWB1UjskTmVG9VqctQzHCRpBahY2Lu5ihdbJXeh?=
 =?us-ascii?Q?oQfXnbAynZZTL8WDDgKZBCXoXEY/GqfGu+DGtxX6MmINnRXpfKIham9gNNAL?=
 =?us-ascii?Q?m0iqrzso9Jksm7aQCFWYNA/vg7EXaTkQQosBA8AeW0gv9QPjQGlZlsmOh+QI?=
 =?us-ascii?Q?e6DEV3l/8uveh2Ja15xcgrbHyhOb0xLSLIbm6bnNlAKDXxXGrFvCkKu/zBXc?=
 =?us-ascii?Q?1f7YCPQGILIm0rXSi4NX8Jundku0HH8OKfu8kKmtBLOAZ1wLz9wK/5+AFlTG?=
 =?us-ascii?Q?Q7J+DQOJlxa6TYwEKYJIpKlRKMljQXZwKGERp38vOC3ee+c9umudJLCdgtgX?=
 =?us-ascii?Q?SfM4qSM0JQkFH/tMj+57XeNAUfkW/ogv3klLYrmtIzK5+Es9UsHSouO3AyCW?=
 =?us-ascii?Q?luYp78okqpQhL1bwmNhYL9p4VfRCB306o1Z2sLoYArIUl9WI95P0YJobrcYM?=
 =?us-ascii?Q?+xD1Ic63fUyPpWBuPh4T9euLk+FAY/aNypxOsAcHY5F5klyxVtZonhmkfyxu?=
 =?us-ascii?Q?T4hT/LVbv4+Hot/pS5DGbjtYNby3/zuLQIC+H6DYhY4ALEScgNyQLLf3HyZB?=
 =?us-ascii?Q?4cxFt4zQpiCw2ZhNZejt1aHpfE/jedVLU2cQWur43tzVHAywdS4FjRp6qY7L?=
 =?us-ascii?Q?ykbuzMklX7THi2xD6goxNEG2g4QVBj7cMuPsYrH0oad2vzZzlKwi3paeJ3jP?=
 =?us-ascii?Q?z2mCDwnSYXK8vGfXUYI3mSR3i4hZCT2WoYYjI8aViK1qTAPFR0BLd07K48mI?=
 =?us-ascii?Q?HwK9Uw5QqsNrv4/C6l8LQFB2GakFN0eeVljsQEZp85bKmB/ggEu1+TG6MfLx?=
 =?us-ascii?Q?QrF0VOfrfgGQ2HJ22fwsLHw+P8KhTZdLaKrzEVlHWjiz2FDKTWTe2WOL0gjT?=
 =?us-ascii?Q?tbgdSlseCBSSBpJS8tNnvx+kDVyc66vz9dPQ4XlzGKoloBRNxqq22fyMAPkr?=
 =?us-ascii?Q?LQfIzJ3hEx6CphaHV7PiPvWCYGEnANEU1YyPM+E5NQg2xGKBod8Qsovgos9M?=
 =?us-ascii?Q?KVCoycJDGPP2KBfQ6HOl+5gAbNgjSog2j0G4dDbgb1+uKn3n9Ai/RdjrYu0a?=
 =?us-ascii?Q?Za2Q06ScY6Ft/pGj7VZqGYBlUpgivfwH+4L0ARk7w6bhBWoAxK9YEm+ZxW5L?=
 =?us-ascii?Q?OQMVni4kQk02nTOep+eNK39FeVivKTmI+hFIgees5N7GYhXdYikruqOGyz/2?=
 =?us-ascii?Q?dXa9W4MYQchdRBhdUzM9DCGHFwDNpusLE3Cfaz/YrM+L4grcibF0ppsflhq/?=
 =?us-ascii?Q?lT7mlcKBL+1lE4uUcEBF2gvOgv94xwDKqlO3sRURzxf7/y5OLQ5KZroXvXZA?=
 =?us-ascii?Q?6UgmfASKej5azo6JGDJCZlTqmvqt4QX2U1qkQntQKyKsWkl4gq6aszZ/CHmI?=
 =?us-ascii?Q?QY9uCdRfbesvI5J29JOicuYKCQ2ubllBBGBTwiVN2spFd87aoVD9kg9y+QGI?=
 =?us-ascii?Q?WgiZwXSgXmQjTeFq5xel1W//DgdXhnTv1die+iC4Vy52wiD8Oj/lfB5pD7b0?=
 =?us-ascii?Q?5yOcDyIsJ+NswK8lxRfdb4nphnOlYVFF0mZ99v7Q?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VLUElvD+jFYrQVjPZh6sDat3hGtwyT/FTRc+BUZ/0+bnN1PNox/jend/B2IgYn7rzsKP0d+88QOsaJx+LPE7SFyZ8a9tOvigXilrxNZs3/NIKRFdouck9+o0RpAwb2ozAy+wawkMBeFOt9sknI7vvHAkRxjChszzaZmDcbv8NmuV/h4c9SlI/NVGTjQ5NSc9JR3g4f4DVT9p2IKXvSghdsDu1Grw107Tada0SV9GLUY7HeTZMN+5Zu7oaJopqc15NZ3MjauIMYt9AP0tloalbDDnDBvS7V0+mwYmL78/V486hGHiY7zAg2b9RqWYflD4IisW1ThQzrH3YI9bXJ0sY8LEhuUO3HwbOl0k+R8BnPjaLfjBdS7mfie7tDSMlOeYXj7RGSd06mGo/zdS1xx4BqmoUmdwklSxOGwbp0n9A/I4LYX1pV4jw5wHE0IycN0Xrlf192OF0AXk6/hp+vB7DQ951qLRNKxMB94xqIIvJI2yWu6CcFUAY74iWQgPEKjtIZgsxIYSmLWUsek23M0K7wQnXWTemcXBby14f1191LBKq2osLFA9ZJW+9zcp5UFDswRKkwJbuiPEJWXEGWvQHa0YPVTgx0xPugq2pFz7voo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f063cf3-7dc9-4164-148c-08dc34848298
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 15:31:31.2147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: il6q+8jb6s+2JMUEAjGpxGwsLJhSv2ZIAV9y+seabbWz2SrvPH1FpEVsJolDxBXvnxaFlx6EBC17oGkrHOn1bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_01,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230112
X-Proofpoint-ORIG-GUID: L4i77lE8ZashF5FKxS5O8c7_CYtITCgT
X-Proofpoint-GUID: L4i77lE8ZashF5FKxS5O8c7_CYtITCgT

Instead of using UTS_RELEASE, use init_utsname()->release, which means
that we don't need to rebuild the code just for the git head commit
changing.

Since UTS_RELEASE is used for fw_path[] and this points to const data,
append init_utsname()->release dynamically to an intermediate string.

The check for appending uts release is if the string in fw_path[] ends
in '/'. Since fw_path[] may include a path from the kernel command line
in fw_path_para, and it would be valid for this string to end in '/',
check for fw_path_para when appending uts release. 

Note: As mentioned by Masahiro in [0], when CONFIG_MODVERSIONS=y it
could be possible for a driver to be built as a module with a different
kernel baseline and so use a different UTS_RELEASE from that baseline. So
now using init_utsname()->release could lead to a change in behaviour
in this driver. However, considering the nature of this driver and how it
would not make sense to build it as an external module against a different
tree, this change should not have any effect on users.

[0] https://lore.kernel.org/lkml/CAK7LNAQ_r5yUjNpOppLkDBQ12sDxBYQTvRZGn1ng8D1POfZr_A@mail.gmail.com/

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
Changes in v2:
- moved note into commit log and tweaked slightly
- add Luis' RB tags, thanks

Also verified against fw loader selftest - it seems to show no regression
from baseline, however the baeline sometimes hangs (and also does with
this patch).

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 3c67f24785fc..9a3671659134 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -38,7 +38,7 @@
 #include <linux/zstd.h>
 #include <linux/xz.h>
 
-#include <generated/utsrelease.h>
+#include <linux/utsname.h>
 
 #include "../base.h"
 #include "firmware.h"
@@ -471,9 +471,9 @@ static int fw_decompress_xz(struct device *dev, struct fw_priv *fw_priv,
 static char fw_path_para[256];
 static const char * const fw_path[] = {
 	fw_path_para,
-	"/lib/firmware/updates/" UTS_RELEASE,
+	"/lib/firmware/updates/", /* UTS_RELEASE is appended later */
 	"/lib/firmware/updates",
-	"/lib/firmware/" UTS_RELEASE,
+	"/lib/firmware/", /* UTS_RELEASE is appended later */
 	"/lib/firmware"
 };
 
@@ -496,7 +496,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 	size_t size;
 	int i, len, maxlen = 0;
 	int rc = -ENOENT;
-	char *path, *nt = NULL;
+	char *path, *fw_path_string, *nt = NULL;
 	size_t msize = INT_MAX;
 	void *buffer = NULL;
 	dev_err(device, "%s suffix=%s\n", __func__, suffix);
@@ -511,6 +511,12 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 	if (!path)
 		return -ENOMEM;
 
+	fw_path_string = __getname();
+	if (!fw_path_string) {
+		__putname(path);
+		return -ENOMEM;
+	}
+
 	wait_for_initramfs();
 	for (i = 0; i < ARRAY_SIZE(fw_path); i++) {
 		size_t file_size = 0;
@@ -521,16 +527,32 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 		if (!fw_path[i][0])
 			continue;
 
+		len = snprintf(fw_path_string, PATH_MAX, "%s", fw_path[i]);
+		if (len >= PATH_MAX) {
+			rc = -ENAMETOOLONG;
+			break;
+		}
+
+		/* Special handling to append UTS_RELEASE */
+		if ((fw_path[i] != fw_path_para) && (fw_path[i][len - 1] == '/')) {
+			len = snprintf(fw_path_string, PATH_MAX, "%s%s",
+					fw_path[i], init_utsname()->release);
+			if (len >= PATH_MAX) {
+				rc = -ENAMETOOLONG;
+				break;
+			}
+		}
+
 		/* strip off \n from customized path */
-		maxlen = strlen(fw_path[i]);
+		maxlen = strlen(fw_path_string);
 		if (i == 0) {
-			nt = strchr(fw_path[i], '\n');
+			nt = strchr(fw_path_string, '\n');
 			if (nt)
-				maxlen = nt - fw_path[i];
+				maxlen = nt - fw_path_string;
 		}
 
 		len = snprintf(path, PATH_MAX, "%.*s/%s%s",
-			       maxlen, fw_path[i],
+			       maxlen, fw_path_string,
 			       fw_priv->fw_name, suffix);
 		if (len >= PATH_MAX) {
 			rc = -ENAMETOOLONG;
@@ -588,6 +610,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 		break;
 	}
 	__putname(path);
+	__putname(fw_path_string);
 
 	return rc;
 }
-- 
2.31.1


