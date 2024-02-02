Return-Path: <linux-kernel+bounces-49340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B61CC8468EF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE3E293BE5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07811775F;
	Fri,  2 Feb 2024 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b="VMQPV4f8"
Received: from KOR01-PS2-obe.outbound.protection.outlook.com (mail-ps2kor01on2095.outbound.protection.outlook.com [40.107.128.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2015117550;
	Fri,  2 Feb 2024 07:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.128.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706857460; cv=fail; b=bbWm15gAkLiJWLSARVxdx+USh9q5PYmRinf89WkXP5ajJSCsp1PULzHG3fpAqYVLh1ZkBWuvGD/1a/BOPVt6RI11r/FZpKNVcZDpZC8izdztK2ggNMJ2cQH/ikmUieNQrUQniEcJ3FvfzRgqE9NPHBFxtYPY51GkxWT2I4ZUpv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706857460; c=relaxed/simple;
	bh=b57h3tGk9hIPgwIAyTqLOW+rCi68LfLjmxPNneA7jG8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LgCvmUOpbb7HI4A6GNckdqsvaN6lhxAjmUqy4ei4Sj2dnWgnoekeRMbbv7VBN3/07KvlmilzL1sIi5pqXQCq6KdI8J/gwwZ0y3Yit8ttQCahXXuvvFqcIf0kXd7MhDwHS2Lp64IpKWV9RIzUcELFCD14X1T6LqpJUtZfSzzGSC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b=VMQPV4f8; arc=fail smtp.client-ip=40.107.128.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/+ozpxEDEP0/mUMxeiQ0gZSqt72eDKoY6F3xxJIkWDwsi+bH99N01VR64FtSmYU4d9XlXU/kHc37j/+xsIxEhE9uvEftfra6ujE1UksGpIhVJa8z75hhTgOwVZ3epq/giRoCPwf2fEDkPyUvuHjogg6le5thzyWG8VEjWHKORABSoTJtEkypHeRSmNmYIq/vA3RVvXzbqNnWubSp9ahv2unqceNoqYVbst+/zW7NH4SgqW15mOhlsIRhnuiLZpuyYClyS5rct1NSW8H4rHP/Y8OpaUWUgH20HyX4TLYAn4ICmRTEaee4TPRH+MUvJCAGEvUonkaMZmr0xkHzeFg7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNijhv4y/sjOI3f6hpay/eAY5waZ+2HBDFT1rM4OJxc=;
 b=LC4sNHpiwYsgNLp1zoChb5I9HL2G4TEe9zN4Nmki2glLV8RzPSFuKsq3+7KvwE0wLa8NWx2Pan5AX0q/Taxsn6P+ds++PRbFLQcChBNi1+BKTYNKjgyuwcGczUTgZozeNLQlAof9/4usFRo7rRP986r7Z8562Ad6xF32UVr8u6nkpG2fPJWbn875+ZG/Z26uHeak4EkLSezezfAIpXStOwb1FcnycG1oyUeJ31XAMXOoeT/DmfAD/dFftegdhyqZilnjA/wMek5fVZbbyvtXPzuwok1ieF2fSuZeavoAfUZVBwpNkxlSNePZW0YVlyjYUjTxQ3di1UThQjwZ22vqUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chipsnmedia.onmicrosoft.com; s=selector2-chipsnmedia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNijhv4y/sjOI3f6hpay/eAY5waZ+2HBDFT1rM4OJxc=;
 b=VMQPV4f8eruQqSNLfk7Z8N8A0crWFDhxsSR4mpyv+MayTA8BSTv82bzGUYSoIg82ucVerM85btSCFpXF53fKiCmoOmrjKm0WdVGFkIHP2YC96lI2uobJRVv/WfksmFpQE5X/P6FqVL4yYY5cXlvhnCaE0hRXKdlbqrwaQAyotN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 SE2P216MB1425.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.26; Fri, 2 Feb 2024 07:04:14 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c%4]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 07:04:14 +0000
From: "jackson.lee" <jackson.lee@chipsnmedia.com>
To: mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jackson.lee@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	b-brnich@ti.com,
	hverkuil@xs4all.nl,
	nas.chung@chipsnmedia.com
Subject: [PATCH v1 0/5] wave5 codec driver
Date: Fri,  2 Feb 2024 16:03:47 +0900
Message-Id: <20240202070352.14307-1-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0112.KORP216.PROD.OUTLOOK.COM (2603:1096:101::9)
 To SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE1P216MB1303:EE_|SE2P216MB1425:EE_
X-MS-Office365-Filtering-Correlation-Id: fee07b38-78f7-4911-78a2-08dc23bd2a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uTQWUYEL9KjPximwCwohYanpT5TLqf+9y+Ahz5F6oQySW0AWmn6/4mvZyOqlD6VaEm9nsNk2V3ASnOh11TyNe/EAbs5JAk98ivpNlP9tLpMjlNZBNIyUJXW0OaOKKahhvrS/Tvt96HeMkydeU4bSxJN1x6LMX51RLpuRWJdJAEQToA1qXIN8SlHb8Vm84/nY4krhP2V2tMPlepa0zNmH6dKEFgRfePu7Bf2ow8Pnm8O7reTnTTI0aJvBbuQITTBkgEvZR+DCoUR3FDeaVDLj7KKuFwOYAgWsVkhZm45oH2l9l0wlLKFAmvGR1WFlCWHYCWt3CsYaOfdHateXngDHJyGv4JOQG50M22ZnMr0UJM4uXzhfD0ipKxwKfvZPQ/r74wKRUuUqcv/TwYK2WfH1SAEtVGXxKnwGfUgHg4ENteB6MpVqoX/2FpqmGWqnbX1UGZ2i46ufu0q9xgNlzOdnxzOlilPT49mvHu68SM+T1+qTxbfg5XV83XgKkyYRd7eoiMw6vgQ+yRVAHwtWhfFIZY/fTvPqOUWp83J7Lrx/qSZ64shlg+mf0U0GJnQHIkjJ5kbnbiEK94W9tPxYgVa6OGU0oZtG8whViXeDOvO2Ge7NfGignXGCF2IV7vfhhQf+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39850400004)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66476007)(41300700001)(66946007)(8936002)(8676002)(4326008)(5660300002)(2906002)(86362001)(6916009)(478600001)(38350700005)(36756003)(316002)(66556008)(6512007)(6506007)(52116002)(38100700002)(83380400001)(6486002)(6666004)(2616005)(107886003)(26005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YtubGOXvQ/PvyKfH7YTbJKdQx45NK2vuGgKMaIxiOdj83ozUTIxzvxKHIfIZ?=
 =?us-ascii?Q?QB2W1snBWTpLeCY/uByMUQiGbipk/1gPXqzv24UA7G4/w21L1+jnxNMJf+ah?=
 =?us-ascii?Q?/bqfghdN7yU9LqPEM5qkVCzwz+RIuWkD4+b+C9DfsS8M/C4tlh8hblaDwwjX?=
 =?us-ascii?Q?gsFmtTIxlJ3f9PE1D5XJzaQWpqB3RkAN6BQeBWHZ84Rw/sV+Am7N//uG+NCa?=
 =?us-ascii?Q?wz4a1mlfihA60sWhHdQdTxi7KtzH60xHJDqsO/y0D9vuXrRtTZzlAnnQGMKs?=
 =?us-ascii?Q?zOnA/WTAkIIveopDAFy440zm4wTVeBJ5mz6+F4CSfgn/Wgwzw9ZZ1854CWls?=
 =?us-ascii?Q?6nm/9Bm4n7vUgWRJO2RtMZTOrWcrpnrpG2ge7DXELbhDi8WHJmi+Hswx9THv?=
 =?us-ascii?Q?Q54hqP46XvHOfBR4R9v61cZ+O2rmCWsNDxP5O3vSnnAMvK7OCbobhjGPLyLi?=
 =?us-ascii?Q?I5BLzh08OpGML3RxmYHqe4UTNqzomh1juXiEtPIadhMA+4GFoB8cHXk9NOed?=
 =?us-ascii?Q?z3pg6JJ2Tnw08MHjkK5h37wKPnibK/i1rB7TJsJalayrzrDJD95RHygeIabY?=
 =?us-ascii?Q?1zlV+0q/XoqLMiQ6C1e7Pr7vySCODAm+/QO7b49o20MuU8KzX3ftzkiM0800?=
 =?us-ascii?Q?uTgs+YRjRp+TOm/AKL1KxydUaAgE76/oyronJHnZN60ykE6ZV0KoYxS+iqSs?=
 =?us-ascii?Q?3womEPP0CEKhUuBpymrzTEoLP7Uvpt4zDzE9jewYY9AUHALV9ovk/f+JvBbE?=
 =?us-ascii?Q?Z9CVIOKEx4GUK75fC/8iPpHAJJmmGdz/trp5YLL7zhunVUDeF9b7AviHl5ye?=
 =?us-ascii?Q?JrU7F0vfUHV/jVJ9D/3c6wgDyUwnJcXuAlIZXglbGIxSkigwUNbt7TuPGOZ5?=
 =?us-ascii?Q?Y8AfoGnrpMLT4BKPdY3fwgBo0vvKyjrUTjuMRXrA9iuruozjApMJJ2sdTA7g?=
 =?us-ascii?Q?9rvPxmrA9XDeGsFK3Y5cQ+UMntOjFGUWIbh3+qiqko/oDbt7M8A3ww5qDaCh?=
 =?us-ascii?Q?tkZAMNSHSpsy0fma2IlTQTj9d/sNbGSuMrRaCFuYNJ1kh0/lwQhoRRjC60qk?=
 =?us-ascii?Q?3g3be+Me9KUev3ZVpWEb3VmX6k6QZztKWA8aHPxPsf+FUNpRpBD+2TDq/0ym?=
 =?us-ascii?Q?jAgf3hMOB3lOThrOZVLor/98YiR94rqss/FTeLythFbyRUaP1gf6ZjtkSGmr?=
 =?us-ascii?Q?BKvYbQyCkSwnQRs7J06gR0ELzlgMcsycoAyfrgVM8Lm0CSoiI8Urc1F8m5ia?=
 =?us-ascii?Q?/tw7Uq4pnRTj4spPv7x8m1xsYDoyJ7xNM8jsVqZViVY0zf0uxxC82CZbaM3a?=
 =?us-ascii?Q?4mW22mZ3DXk0P2GYln7kjmima2v7alzoUluMtndOTqKzqhXh22CirKldPa6h?=
 =?us-ascii?Q?XQxOMjgyLeQNdy1uBJSe/RbVzT9p69ihGgJzI6B00q03sQNGhZSCcwOmPomg?=
 =?us-ascii?Q?xWnogmGsFQUyp4uRac0ekbc43RaCtP1kQwDVjhGms4dM0kUtrR3VD2Rz7fJW?=
 =?us-ascii?Q?WpuhMakp5DOJ0vZ41SHSy/Wq+J2EeH0yIaCl7KHn8G8d2Su29gFvlay3kpk+?=
 =?us-ascii?Q?UUWFBX0V56A7CuLcj+wVInMVpuTs07H/9n0f+8R5ftVOh/S9YxcUSL8Z7Mfl?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee07b38-78f7-4911-78a2-08dc23bd2a3c
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 07:04:14.5722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bc2qKH4QcYbciWiPFR4d0Sv+Xw1H78Zl1g+OmMp7GmxvHQmc3gzWfyRdsqxLB46ZAL696Z4SwiAV6+iGOKH75AWyMc+QAiHfzpGrgDuE570=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB1425

The wave5 codec driver is a stateful encoder/decoder.
The following patches is for supporting yuv422 inpuy format, supporting
runtime suspend/resume feature and extra things.

Change since v0:
=================
The DEFAULT_SRC_SIZE macro was defined using multiple lines,
To make a simple define, tab and multiple lines has been removed,
The macro is defined using one line.


jackson.lee (5):
  wave5 : Support yuv422 input format for encoder.
  wave5: Support to prepend sps/pps to IDR frame.
  wave5 : Support runtime suspend/resume.
  wave5: Use the bitstream buffer size from host.
  wave5 : Fixed the wrong buffer size formula.

 .../platform/chips-media/wave5/wave5-hw.c     |  11 +-
 .../chips-media/wave5/wave5-vpu-dec.c         |  86 +++++-----
 .../chips-media/wave5/wave5-vpu-enc.c         | 157 +++++++++++++++---
 .../platform/chips-media/wave5/wave5-vpu.c    |  68 ++++++++
 .../platform/chips-media/wave5/wave5-vpuapi.c |   7 +
 .../platform/chips-media/wave5/wave5-vpuapi.h |   1 +
 .../media/platform/chips-media/wave5/wave5.h  |   3 +
 7 files changed, 253 insertions(+), 80 deletions(-)

-- 
2.43.0


