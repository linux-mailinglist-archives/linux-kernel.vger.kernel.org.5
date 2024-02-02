Return-Path: <linux-kernel+bounces-49343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 911748468F7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2A4C1C255EE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0E418049;
	Fri,  2 Feb 2024 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b="e27k0HW2"
Received: from KOR01-PS2-obe.outbound.protection.outlook.com (mail-ps2kor01on2109.outbound.protection.outlook.com [40.107.128.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8D01799B;
	Fri,  2 Feb 2024 07:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.128.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706857465; cv=fail; b=rkjfK985zMTGngBnYHYQFQ6wMKlUANTC9rN0E1af/MqJm3F5kSgx1JzJaCNNkRJ6csOhU6Bk1OqUjLObo3kLSL2TXohYQWQohVL06tmG4VOPnSQQS+nRmkcU2m4vrJVeiXg4V/Ou13iK69kwGVzuR6iN0lrTXFrbKHh3l2tSid8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706857465; c=relaxed/simple;
	bh=uXCX7Zb1YFiWugkY/J2GQqpDoWQa9jzsN0oPdthfgdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kvsNHo7JNO/DM7rTovSTNqobyVyIetMSJUeWYrITTgTREA2bAjWsnfrNIYfjN3hOnbZDUEWS98nvJN89bDmECUnu/2wFwLrvwQrEyHtpSHUlQ/E3t1RNt/yRfAkso5mwCgcm5eoUzrtkByvTzelHpvN94lnSl4SjZH8Ji0WKRFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b=e27k0HW2; arc=fail smtp.client-ip=40.107.128.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoG6eZyolOFZYkjlpmJzdIEkUqFld28NZt2/z6wv3Gdas79OkezAvhgnyBcXAIQMdrun1VI2LDSzgZEhHLIH0wqZVeSF2Zunk6tnmDb2/i8nRZdSgyu77HbExM6o/0acDjX4w35pivaPGwa+6HbEAtdWaE/rRoURELKJt6SwwqKBmL4F2TVrBSjd3erNZNe3xdgT6E5GfO51dD1zzIUpwONrw587r75sCzRm1F2A/xwvdp5z6fWiUTWLZxZihJanD9pa2GlcWJb3/SR74fsb9j12ZZr+Sw5N8FysLP93wsQGLQbn5KxspwFdEOG8efyWIiQQJE3YXDQCNtuoI36qow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWhRJLfD0YtdtMQPxy8kjWI35mM/okkIxLGCZP7Tzo8=;
 b=PBHsSd6XbQTuEXDozhPwDCbB6RWb2UduCpAtqVwAPw10OjqBDx6MtS1IqUOk7mdoiY5zxjSEE9ocviFGSmCrBx10POEw7BszURKN62bcRboG6ieiZf4tp6mGUewFTI7evSLfF6JOaOygUmAKG+enqYKhlGHQmTZ/Dk9QYoj8+qgeI4tfgwwqraAN0mTmsXHmUGoNQVjMDNuRbA98njw3LVGN2RIvwQ5HzjyWPu+HIR76D9JlG+ygOuYczc/8HYRszKn/UUtGHwJu8VRUFqtYac7yRSjNTl7tcEq80GcnbMxAkMlrVuUimFbnh0YN8Bp/ikTzuN6lfd3hL5N/5h5g8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chipsnmedia.onmicrosoft.com; s=selector2-chipsnmedia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWhRJLfD0YtdtMQPxy8kjWI35mM/okkIxLGCZP7Tzo8=;
 b=e27k0HW2/EwIrn3uzSG/GYKEVxm2UMJ7+C8J8pFsebk06hsiDwnIjHTcfm25GnGl4X/kCh1pmNgJQMwFwlQOgUlxdWf1ljGyrMlrwIv1j/AccClwuKbQQ8pgwdi9KgE1vdsbf4J+tNaZQnI5C+xutoCqmMgP6vNzRZDjAHw3Guk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 SE2P216MB1425.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.26; Fri, 2 Feb 2024 07:04:15 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c%4]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 07:04:15 +0000
From: "jackson.lee" <jackson.lee@chipsnmedia.com>
To: mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jackson.lee@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	b-brnich@ti.com,
	hverkuil@xs4all.nl,
	nas.chung@chipsnmedia.com
Subject: [PATCH v1 4/5] wave5: Use the bitstream buffer size from host.
Date: Fri,  2 Feb 2024 16:03:51 +0900
Message-Id: <20240202070352.14307-5-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240202070352.14307-1-jackson.lee@chipsnmedia.com>
References: <20240202070352.14307-1-jackson.lee@chipsnmedia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 69cce1b1-7650-4fcf-d9f3-08dc23bd2add
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N+IwAhbEdBEOS4TH4Zld6eGCtyhvWerHwsU1VOIeuR6GswjzPGJ266pAGRw7qUFLbc97kCQueyMrM+nH7LYrP/6bzmSY667ryBEIq6Q4miCJNm2llE9pBk/lFn5HazfGUP+MzwXQrTxKlkIzW87AMj5HDvjjgw0qzAj6kHFi67x54g9rlG9UAgMGBokZBCVnHq0mBi+H1PAihZqM2TsSIZlIKXD9MzPqk5+A4IAtLY98Dhm0rIRTUuv8ouggAImHpGpqeMT5eBs6/YfEqI9Eq9quCbLMXsGy9nmKYl3vWKfSWRTJ3p+qPvXbMuXjxR+09REZ6UN1UQWfThgF6vGMAR+Kbml/x5+B07LoV0OpV7H4GuMT05sCt9x43z03vj2jznBx7wuUu2Tv4KcV8s0j6ndcl0MAjdVPo4HyDw0rUK5EKhnJYtFmSbtrSTjgtZXoCgz8ocd0EEWiLazN6DMptXv0JN5dSN5nuZVzFRmZBDWnx4zTCb1De9G+9kpUvgGat4Bxm10KPPH/csnamcq2WjNsQhOjjDYE4gTfcTMd0RFEgojBrlA5fWrY0Z5/3Gh/3goPtZGsiQYRb9m8rn58LsC46llSmvE9/NKJKWDU4d/4knx3/TE+DKMMr0sCm+ea
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39850400004)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66476007)(41300700001)(66946007)(8936002)(8676002)(4326008)(5660300002)(2906002)(86362001)(6916009)(478600001)(38350700005)(36756003)(316002)(66556008)(6512007)(6506007)(52116002)(38100700002)(83380400001)(6486002)(6666004)(2616005)(107886003)(26005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M9V9wXi6l9kzUboFkHaQ3st6/1AB+Sq65BmWVjorguH4KmiJ1WgSkj6s/r1x?=
 =?us-ascii?Q?escAoocgQ76v//4S/aWBVkGlv75LQkx5OhaujHAvRnVVyNuvzorV4J2hUwFg?=
 =?us-ascii?Q?bWfEONbiA0euXfQYFuKBPXJqeCROovvnXjygZJJmiJDhMIjdSn/yF5S2/xV3?=
 =?us-ascii?Q?nv3CXnaOE4p/3x7ggQaz3GP9YIIWyxeWqK5lfJe5oi/qcWXKMeLZeH3WLHbq?=
 =?us-ascii?Q?S9+VYBot424rIqmQRzwCh7GVJey+c9RFvbExn5WubOERQ+y1xaEnemRbTzeo?=
 =?us-ascii?Q?+owt3ozIJ9c9Pnxrrykb44A1PtzJVtEEfNTBesP7mXhswufX8++I2kUly9CF?=
 =?us-ascii?Q?dqxLOGGn+yD3RzD4GCvuqJu7VCeHdcqr2jmVPY6d1yGysAG7jNnRHdtiWxwF?=
 =?us-ascii?Q?OedKPHslqWGx2ChF3GWgD7cfXr6VDHsssgQafgp7xF+wQQIVDD2OyuemsMZX?=
 =?us-ascii?Q?wYvWXIqCucEszZTWdH4eoX/UwkX80W8BIPfm1vHFRF7pz0M/peObA002s1vK?=
 =?us-ascii?Q?tH8Xkc/a/DE78mGpyHcEOktq8UcvOjfkqAEjeFnbfYS60RROmSdeO+t6m9vb?=
 =?us-ascii?Q?5sC0EFRYushVj2pJewp8nljRKgNmfSVcTRoFswqUoTTPd+62TuRjsFlNnUId?=
 =?us-ascii?Q?G68ln4k5zhPTJ0vMgYsN+bFXUo2ZFXbtORg46xYCNXwMcLYuEZ+BYtJb3Pfd?=
 =?us-ascii?Q?Plx+NDa3cAjHdOdd70DTUH2mrcCdeGKy3QBHxThAWsquTqVPPxtBZwdRK5fz?=
 =?us-ascii?Q?7LcZBb5JL00TW4RPBYAwbSI3fp8ZXOU5rBlXK/KoJoHmaJBiv78ubQD/6cBJ?=
 =?us-ascii?Q?/LMp2hEDe8wIYQcluwJnPQu1coSLd7zVSfXfZ4SRmwF6lAx8eOqIHXiE0hTc?=
 =?us-ascii?Q?mmfBnNId8LiXbaAk17Co23hgcDmmkbwm+YraVpvF62kjpOqNoXHVwJgIw+IF?=
 =?us-ascii?Q?Q0R8hRNmxNE/uczioXrIe3ptfKeI4JC3gOl+1EA+V6YzDbjPcuKnrgCgtLLe?=
 =?us-ascii?Q?ctJeAdB3nwREjmvvf/o5DffQsDZEDn7rG3BeW7+OVSym8v1dTY58tS15YilF?=
 =?us-ascii?Q?RmaNlrDV3b8OQKwIOz5Dc36Rn6nCV8uTr74GmwN3wU9WiDB5ziNwF3SAxOdt?=
 =?us-ascii?Q?YLEMcZQUNza9bn+BvRDzY+tVApyDvrO7/MTjRtx8ChecaM8p/kc0HkPJL5qa?=
 =?us-ascii?Q?4TDovOMPf0QejSzipAJ+ndJLeAoD0pEirSDvYmCw6s1CEZhOZ8Zzl1R2j5Bd?=
 =?us-ascii?Q?zPXm8kF56BXfpZLwegzvlMR5y/VQr2c6BzdSbK+zf5gQmSCI5pbMevoO3uuJ?=
 =?us-ascii?Q?W1GhW145ZMuDA5K/ZfpCGpbafesHqpcgRB1KN2yL4jTK/5rgc1XzHJAp9V4o?=
 =?us-ascii?Q?ONQRzGndFw4Ha1vWxFdhIGxU5XNKrgCjvYa2fahHgjl/l55cxa0bsqQpxtZM?=
 =?us-ascii?Q?luok2Aamxm6wlcijiqSH5ph5w1sb7WbPYbITovpj2yK0byZB9FBoQDWafvhn?=
 =?us-ascii?Q?idQTkSTUrTNbSiHEdOOsndAFUaTbhT6Ew21ov7/SDzJWBgYolf2AfO6FIP2q?=
 =?us-ascii?Q?o8c6ioLeDkB5qV/dq5psHF3LHfEpcAGFcua0O9u4/koSdvE8bmFhJenQCub+?=
 =?us-ascii?Q?5hRAPOneygW1nc512ajk/GQ=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cce1b1-7650-4fcf-d9f3-08dc23bd2add
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 07:04:15.6222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3WU75Akh4BfpV2iM8MhqJil/O46lYyacE9uZPFu0ZF6lPmAM3nwzdNSMRMLTBYyG4VPxs7dvJoC6xPMg+/zCNNHl32P92Rad7sv4oekt0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB1425

In V4L2 spec, Host can set the bitstream buffer size.
Allow the larger size between default size and input size.

Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index ff73d69de41c..62be7cdfccd8 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -11,6 +11,8 @@
 #define VPU_ENC_DEV_NAME "C&M Wave5 VPU encoder"
 #define VPU_ENC_DRV_NAME "wave5-enc"
 
+#define DEFAULT_SRC_SIZE(width, height) ((width) * (height) / 8 * 3)
+
 static const struct vpu_format enc_fmt_list[FMT_TYPES][MAX_FMTS] = {
 	[VPU_FMT_TYPE_CODEC] = {
 		{
@@ -193,7 +195,8 @@ static void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp, unsigned
 		pix_mp->width = width;
 		pix_mp->height = height;
 		pix_mp->plane_fmt[0].bytesperline = 0;
-		pix_mp->plane_fmt[0].sizeimage = width * height / 8 * 3;
+		pix_mp->plane_fmt[0].sizeimage = max(DEFAULT_SRC_SIZE(width, height),
+						     pix_mp->plane_fmt[0].sizeimage);
 		break;
 	}
 }
-- 
2.43.0


