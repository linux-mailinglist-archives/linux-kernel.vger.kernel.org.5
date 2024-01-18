Return-Path: <linux-kernel+bounces-29779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB34B83134E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9AD282EFF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C91DC127;
	Thu, 18 Jan 2024 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ReNQAq5U"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2082.outbound.protection.outlook.com [40.92.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F53125A4;
	Thu, 18 Jan 2024 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563854; cv=fail; b=J6GsmXbq/04EwlyAFJOOmspkGjgVWMRiecMj8aHeD5Z8ccWiC4HhIoTX1u5PQnc8MYgh70i3qpcG8oCIGpn/+0qlvVW0oDE97cBa08WMoGD2IzxyXOMQ+csXmMKV4SjaiIi8ZpfHzYimxS0YVYjqWq0IHop8izGstSIXm1Qin6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563854; c=relaxed/simple;
	bh=yHFjywHy/un70BFVFuB8javPxWwMIjrK4GEoByvZn3U=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 Content-Transfer-Encoding:Content-Type:X-TMN:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=gzC0UbKeXrp+YIeNpZw6Wb351P0xGGHKg+SSm/4dxqBPYP1eSqDWPK4UboH4Y72u765N5A0WHvi7b2+LW3omxfUOKth21bEztaVAJefOYtMBQY+3tXCQfuGPonhidV8jP/h9xCQTzDP1IzJGuVFbp1mY6cc81BhS9awwzOyq9L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ReNQAq5U; arc=fail smtp.client-ip=40.92.21.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lv2Zf2wc2fqBKUfov0pl2wsYhCbXNhery2PTyiVUPATKyLoTadZd5fD4At/JOPbWgZb4PdlJxOBOzohY3HwTp32Icw48yp+y1034RZ6CDoO+GYGehv1Y7j/00tXvtAKaRJWuioT8OP0S7ZixZhhd4djDxsVa5T/C/w1yvLFOwMg47qYmpDtZkfAcl3pJBHC/qWiN95ilM/QKgIplbdC5l8bIs3rOIw/P9mOUkWIgfJQ6n0NoG5RWsCwfFbIe0IzkwShHUW3p8cocinH18yYTw6pX+pPcbxcKl2nngSrbrGVepE7f8FsBBQoCkgNX30TaRzmlR+OUYXW+GD8J5AWUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjUhQuYRUnao2JX1I8SmUUOOA8OuPk1ZzIJUCIoqRYQ=;
 b=CIs/6cdExkZ/7GSIjdGldsjozNRE3013/Zl7Z0a01vuXgbFNLOUx8kgDAiH5F/SuqZZpm91MSE7ns9yOXXpB/IZbGOx+2wo4nXZQo4fhl1YeePKUjiRNzXsa085+CWpvaLkeTQvTVEZRGm7t/Al/L8/pCIRFgf058YFYLQpr1UbJT1BLbQxRigZzyNgmseHTKLmjEhL54lfOq3nTEh2OXE9V6yb3TK6i1THP2Zs1krAHwxItpTt5kwJOltsKdVyf3UxGazZk6c5lZcDhXbWH1BxM87w/yjELpLcXUWAiG+pph3SMH3ptQg5NsHdyqt5e+m+jgk7vbmsjRa6f6+Ml6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjUhQuYRUnao2JX1I8SmUUOOA8OuPk1ZzIJUCIoqRYQ=;
 b=ReNQAq5U6ZzDhaxNl9rgHxVKo3znPp4Q/fEsElIn+3pCBjoXTwtQGzluu157QVuRpWtamOW5F1y/mxA6lmTZa3ra7ledO138Vd+5lTEdBWonOyH7yprrmzJfbDmKp4g5FfHZP1z0w2GmA3OHma+VsZ342WboXg+QcAlQN7WCVV6QusUlHYR+TRCJyhbawFSabldw5HVMkBPAqUHZrd1he8oianrAZPXusJI9Nwei68kAqznF8V4aVs7Molq+3oV1HpI1PZJRfGCYBXHI//qbiFtqlOMtgcv6ljyc7fKb1nbPBsXpmOCECDKSA5tBuaIIiZMmbB4k6gASdWDfPhLAFA==
Received: from PH7PR20MB5925.namprd20.prod.outlook.com (2603:10b6:510:27f::21)
 by DS7PR20MB4144.namprd20.prod.outlook.com (2603:10b6:5:3b0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 07:44:10 +0000
Received: from PH7PR20MB5925.namprd20.prod.outlook.com
 ([fe80::e1de:29a8:e090:5b7b]) by PH7PR20MB5925.namprd20.prod.outlook.com
 ([fe80::e1de:29a8:e090:5b7b%4]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 07:44:10 +0000
From: Fullway Wang <fullwaywang@outlook.com>
To: sfrench@samba.org,
	pc@manguebit.com,
	lsahlber@redhat.com,
	sprasad@microsoft.com
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fullwaywang@tencent.com,
	Fullway Wang <fullwaywang@outlook.com>
Subject: [PATCH] fs: smb: client: Reset password pointer to NULL
Date: Thu, 18 Jan 2024 15:43:57 +0800
Message-ID:
 <PH7PR20MB592590F74C734584DCF88D6CBF712@PH7PR20MB5925.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [gGgyD2zOo3hECuXWJgiyvzctplrwnpgSTrbB9o2Ez0o=]
X-ClientProxiedBy: SG2PR04CA0181.apcprd04.prod.outlook.com
 (2603:1096:4:14::19) To PH7PR20MB5925.namprd20.prod.outlook.com
 (2603:10b6:510:27f::21)
X-Microsoft-Original-Message-ID:
 <20240118074357.42205-1-fullwaywang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB5925:EE_|DS7PR20MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: adc9c6e9-24f3-452e-92aa-08dc17f94202
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XO7YmQd76vzosO47gHBRFgorWEnyO3Md+ZyaOakCCAOmT0Hk+KsC6IIMmOgzVzjmvIprRcumqvld/i6msD8tvn4p30R7a/I3lshllvAwgOG/2R65HjRyk/jhnjZ17uqTmkLsMvjg5RHTyZmkL/USirlnJHSiY5KJhR8z4sVGGOlqQBcHt0owMn7jltdODi5X5THffGOzprQQAOHAJIfwhEuEWcaI3jyyXF9xdhQ4x+/rkz7PmKKmh89v0PRpmIJTNoTqdoJjSa1uX7v0DAxv737ujPqgeCfjJ52bPf5QQrQnGfNCzWvvMNF1C+HjRYXMHg1s0sY94FbfeRXQZO65rR7v6qUuoJDl1QNazE0UixzBaOZaW7UJ/eMHYakSbwzQWQv9jhWz51OSwaUhrglvhdzyitm9+wyjhtRcfXmN+2LaPbilSdA8Mf59kkC6+LnIVdA9rJLv2Sf72oanN80c2MMSFKoCgs/E4xGW/MKICrDUC3JrKxU7vEUGHz1xNQG8A6xkEX5rFH9QOzSMq0IO3YCwAUhjRmjFJPcaUGX4FCBXZcaKl5IdjLfC2K2YCXc5Fz2KD/56UMBGPSoBDQzmh2S7fxRNgGPDVL255uXj123JFZxm+OFg+F3ov0unEKnj
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+0D2HDsgPtDFOUESmylZwgEjxuLwQkTu5uF0G84fh4BUj3WNNbR7neixu9Rj?=
 =?us-ascii?Q?yh/dyrhGgLRkikprcx+08UEVg5klnG9nUNA4v3CaUBrYObeEzsebu/pYl2L6?=
 =?us-ascii?Q?pnqo0KwiMG4oIThSKAgwO6EOlUHuLt1DTAoL9Q5WnmoE8X5fH7cwWvJCF+6+?=
 =?us-ascii?Q?AC8IUGFOspGJIPux3ar+Je3tPngTKpO3tF0zGXkwGg7qZhsxnFVFI63Cw33+?=
 =?us-ascii?Q?P+YkqRfuyN91Vezr3IMcAcTWFbbI3EIMHK9ZIX1E9bsoSseqPT7SqBFDWbzO?=
 =?us-ascii?Q?Fp6vl2t0QoXwsTiQ3XQUJzDlHT5GV3StybvGI2c3JqcZ/uVLKfHL2l+pC6mo?=
 =?us-ascii?Q?CnWYPWqTqwD+Oh+dQiPABIna/nO6OlgE9+BWagoiBR740aoXeXYB62I/0dcF?=
 =?us-ascii?Q?pkA99mLMEu2Ym+/3DEXDEP/qKtPc8t+oZEKLw+nTMb6pEo5TXmDTNpSJSc76?=
 =?us-ascii?Q?NEuIwVRNFfXKM3bkoycion+JmugrXzF/9Y7FWncIgeEHzXAc/03Tx1KH0NmT?=
 =?us-ascii?Q?e+nsG1uppzNT7pINrwfFSOwxsxfKCYPm/foPXOtPcdDMDCT2BqcgcIJDnxYw?=
 =?us-ascii?Q?ai1n3awdmmxhf40SmmhIyx1gX1aV5ES+z6EBRnQhjw9AmWseSUfXpxGQgFCe?=
 =?us-ascii?Q?ytwEeEftfQGpvto2rc5hb4vjKWyRe3ytfjYydTm1OQ7QoSDsZLHEFNrPIfvL?=
 =?us-ascii?Q?litLDONwMHh/ZdK3jTRZvQHTFsSj8VHZcXpR5qt0b9QbxLx/nIqyCxjcYIsy?=
 =?us-ascii?Q?mbZ4hJ3NzKGJzZeOJTrfBNepfLKYRhkCzQWEN1thYHe/qasR8kEIFzhR5QSQ?=
 =?us-ascii?Q?Z/EEZRTI4a2/1tn8OvGRLVHcrRtUvQimRXKz5NGeKN3CqMCKrWmiAt6HIdzH?=
 =?us-ascii?Q?HLQCa79V7mrBb6goh4+suvuclQhTuJ4FV9c6L/QRCtHbJK0yBo+YIvpOlxAr?=
 =?us-ascii?Q?7Jk6hLxDtIMbosFMJhM7qw0wakGLnpI2rwclhOsiyMpaYeV7fls0vt+H3O2Z?=
 =?us-ascii?Q?LN53/a07tvb1z9ryJSkflMu/0L01e2GiARBV5/FCsi5mVbxf3OECGlfoQqUH?=
 =?us-ascii?Q?NbNSRC5s79Na1oGbXrYQXp9PRM5noYi6eGANocXhTV/b1JeMdqDrle7VSGrr?=
 =?us-ascii?Q?Yi02TFooi/TGNAOpn4ZCjLNRyerWuGCbQ2K62po25rn0aRJhiKkR2HC4Ke1H?=
 =?us-ascii?Q?yVW8oKy9zQwKpAIzkocs5buUZW+WDO5R2193lCuX0PJYvHEv0Y2NZhlP5G8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc9c6e9-24f3-452e-92aa-08dc17f94202
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB5925.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:44:10.5428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4144

ctx->password was freed but not reset to NULL, which may lead to double
free and secrets leak issues.

This is similar to CVE-2023-5345, which was fixed in commit e6e43b8.

Signed-off-by: Fullway Wang <fullwaywang@outlook.com>
---
 fs/smb/client/connect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 3052a208c6ca..fb96a234b9b1 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -4028,6 +4028,7 @@ cifs_construct_tcon(struct cifs_sb_info *cifs_sb, kuid_t fsuid)
 out:
 	kfree(ctx->username);
 	kfree_sensitive(ctx->password);
+	ctx->password = NULL;
 	kfree(ctx);
 
 	return tcon;
-- 
2.39.3 (Apple Git-145)


