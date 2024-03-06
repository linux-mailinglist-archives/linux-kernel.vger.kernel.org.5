Return-Path: <linux-kernel+bounces-93636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D22A28732A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDEC81C22607
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1915F466;
	Wed,  6 Mar 2024 09:35:09 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2096.outbound.protection.partner.outlook.cn [139.219.17.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298125DF28;
	Wed,  6 Mar 2024 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717708; cv=fail; b=KBsuuIgJ1cXAZSp6JiK5548yUt0/Wobl1yuIz4ZNpvguWxLEpbnY8iaTvmkzcsRSr0E3i4lZW+1R3H5t+R5NPatbU4i+W6am3jeD6kbLJ1/XEn+WG7Y866QaX3GQ/6BiBpu+P2GXZwo+SeXXFjQhm9NqbqT1UAaVOS3l9PpB1+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717708; c=relaxed/simple;
	bh=SlH/hVyLYNqyxN5DLVfot9JVRxYvrwxxdrBWpqDZjsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gQhyQ5/eWT85TVdIp6uo3NvHD2dp32LK7KMQfeUne55FDfvqoTgOIqzTZIxTrDAb48Wd83uLTnKJTF+kHL+cY2ch3Ydx8U/AyI55ypFmm5XwZNFwuAoPKC77F0wZpOiZzewg4iyPeVvd/EL16uUNNxAiD9Ry0DjALwpsO1U2XEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7716cbqVYAOtHkQc5InHtn8McmRzJpOm5U27MM75kDmt+lhOT960qvQ7rbZ1g0nHsiGh2wPRsYi+fZlV7EbbHyjT6W4sOjucUe/HDSweFpAiXPXGhzyaW9zO1Rkl/HsOb4PFWRHG/98CviCdFzJI+l6rBehUhMweKjd/QdSPwPxdzI5bgiXz+CBO4gYMRXkdwawUeSDaAk55pk8R5E1+cwJ6AU6tgNFxc0y6HoPChj9vD4tTNRtOR6gUa16l53P1lQCPag8U8xXqVLZ65/fRS0kEioRhivM7dm51ididZYcx7hhWoEPGSQtFAhyPSrUp1Ak6cvDsZUn41YRNs6BwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiM4HQjaSjnjqEr0hjGgbLSiOZY/NOEIpFCa5O+6cLo=;
 b=m26MfFC1jNHhZpHVK7/N5SG4FHFMRCr+TcsZk2srfog6YgBqMm3FTfQ/2UqM+x+ERHOBHx4HFk8eVrnucw/ZikUY0l8Z0YOaXUeflflTEYEVhr4idUQDgTRhkycX6/74ngP6mv2F/gWOEgGmusRUV9SJ02TxGu0G20BZU7+YQjtjSRW2qc0yKwT0CbjPJf0McN8nH9i5WDXxXcTFiD+ew5KF4paibyEvIwsCFyIBrvWwjdW5WlGkDj9izAr4t2+7hAm07d6eaORCqcsavuabMnS8A37WjpbBZkziQ3L5SMQ1ZlPPI6bCH4QeGnLBf6UB1Ck8PJ4eSVfA6RfGxe1/jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.51; Wed, 6 Mar
 2024 09:33:48 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Wed, 6 Mar 2024 09:33:48 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v1 5/7] staging: media: starfive: Add ISP raw video device
Date: Wed,  6 Mar 2024 01:33:32 -0800
Message-Id: <20240306093334.9321-6-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240306093334.9321-1-changhuang.liang@starfivetech.com>
References: <20240306093334.9321-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::17) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0765:EE_
X-MS-Office365-Filtering-Correlation-Id: ba3e8ecd-8ca7-4707-0ca1-08dc3dc08673
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7Yu9jl6T0gSz5HuMHMpQR+bRjMg46e08Z2YjGPSk2MIHHjQLgNrdOVWQ7+X20CdXcXZv9eIwBpjzkgalNAUeKq9MgdWWx8Z8CkuWalEAdcqlUch7+Q2sn86PlywCGlG5AgycuMsV17DmkFm1lehNG2tpz5rbe0dCQijpZgHplJnrHOjKrPUvsTygs7+F+ltNzjOuPq5aVPmFIIMpdHYI9IKl44j08tICEBtBpLOpCz15Wc2GfS7Wse82GtM1RTHqtmVHTf35c/J/WMNF253YWB/UbaU+Hxo7X4Jbla6CRMbVTMm8Yhla4FrXIRe7Qsl6oZbc083CKETh2tWvZ29cCe0jJVSoHlNgBd9W3qlCcFp4UTCc14QXHwMmRkpwfaKoA4dYIjo1SA1EHl6byGAwfMWLQHr/yLItzIDhriL4sT3z+TVg3zGhLDay7STvGF9R4983hc8p9dQtuyCF8HHLD+Ls5AJfaxt+7iMvtWUK1UPWvHwf8qT1SqDaCCAbb5qToDaK+UdiTOqO4EVT0rTgtMTpqAeb9vuKow4/KxA50GlAVDxJAtpJ+piFHo7Nvys9CwAz7xTpaZ95hEyHTEndgJQG+KvBW88RHA5XdjuT69KxwVA2Qz8u7yEFwHGL2/lB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0k0h6FiBAA/zD9sERNFwpyDCfabZrBgLCNmUgNNaoCI3DscWAJ7qeINCrF8E?=
 =?us-ascii?Q?9gwfmfYZjj8V+gxAu/GeFnoKQzKPKG6iqSwT330Xic1PuWEZIn9KfYVqVOQt?=
 =?us-ascii?Q?hvMlNVDr5Fu4qDFAezL6BB5+hzqTOkIX77QRzMJIbDlFm5SBfYbYv3Y8fN+X?=
 =?us-ascii?Q?WbUBppcmoJCp8hu7haSGphyxQs+tQFmzyjGkmaG4k8UEY4geIvRHjzx2Tqii?=
 =?us-ascii?Q?aFWInisiWZfUUpq1ZhqUoOEQ74P6VSfPt4ffPZDrnoYZvlmtoX1ZpCwJkE80?=
 =?us-ascii?Q?vRR21Urfe96UwcCvHTXVnNkWSmSZKSIhb6uskcc20soECAK9RUhfdfbHzJMj?=
 =?us-ascii?Q?XwLHVegZqUUlPwd56MH5zaOg+T8VZYgTEcIMsMG3GVUxfFZFCEcNUXO5UGgK?=
 =?us-ascii?Q?WNMgPV85pXqkMJ8l8btxn65SZPM157IEj50VHocnOVFhOSfugbAkoFXsRTw4?=
 =?us-ascii?Q?4SQA2/gj0ToPETYY6Re/gfBpdc64RxPvXezyrSPKs0QYuRTq82F/MxhKV79D?=
 =?us-ascii?Q?zb8DKFhcBwtOsHdXY/4Bx9fCGwR+pA5tgm/pbIxUocKy+ifKU0GuLZPeP3bp?=
 =?us-ascii?Q?rqSoW3b/Fk9MmS0K04DHFRyhRL+tTJeRh9/QpDY0YIix/TyFBf60TW1aaMWT?=
 =?us-ascii?Q?Ho0ukjcuxwy4zYyWjvjEgKFOXkY4AuzaQNANLrnrBrVNlR5i+1Qs9wgNzWAh?=
 =?us-ascii?Q?bdw0Te2MwGQDFNNEX3SIOQ8Ag/cwinyd+RBxbFmlW5wkNbKANuUcnM5wlx8g?=
 =?us-ascii?Q?ohx/V8D1lV+JK0/LjrlRrP2IgVTgiXiUFzggfRWlspftE3u3NoY95yMRTnIs?=
 =?us-ascii?Q?Hpg4BbR86vdXbnsatQ/oK3uPwWILE1DfF2vAy9v7CBgrKgNH0hYvLOoi5clx?=
 =?us-ascii?Q?9Tlre2MNZfEVKW5xMPfrG84wpdomUxEVza5npV/Mz1Sm1dCl/NfcSC5ypqNg?=
 =?us-ascii?Q?c/OSG4AHPRO9MdzLnR51CSn6nHnSIH/Kpw+qf78Z1sx4IfgURrTb6esaCV54?=
 =?us-ascii?Q?uEDR+GNzVHdyVAxcqpTkM9rTYkNVNB8mHow+O7xP7O8FdzzGgc7SSF2rT17l?=
 =?us-ascii?Q?yqUaOpz4PIysSfQY4EgYC1Ylpg6BnzZzSLv2/xtYYk5FbncznvRh7OfDSRb5?=
 =?us-ascii?Q?fYcGpvEABFjI7joTpyOtpC3fTk/adSUfjBoeTz0wbvy3mpFRHnk0f/5kQSzv?=
 =?us-ascii?Q?+ebfGh8UZJrNDU1JTy/yRplIXhFmUfuBd7RTFBzma7vMMTMuqKdHYzxdyDp1?=
 =?us-ascii?Q?3jJWxQ5uxKTW+sxWCWmN0UlkcCA3LfQOu9bju6lgFhSU3SF/mnBLeeVSDoLj?=
 =?us-ascii?Q?FRQRHELR5Xd6qFAVJNSPnfz+vbdBsG01bFEtfDuRh7Xr0Ajykc4Nrg1ceApf?=
 =?us-ascii?Q?E9wVC8U6RrHCxzs74bj6F0RzLHTBPhfU1Iq39aatbFlzbNgBJXWzNSMgzXRV?=
 =?us-ascii?Q?T4SDJRf9H6RBGL/b4G6HBWqp1Rl6xwDEtbtKeTVIn/fHK8kA7mobbQdfj2Ky?=
 =?us-ascii?Q?2LHYlAxKb8gzG+jgeWHr6y5IOBxefYCGHlxxUHwEKvwkuV6m0nsCWrWA3aai?=
 =?us-ascii?Q?kfjLg+zDnT5RzJYJ5BOL9ZYbcTAY28eTum+tYaLZdc6vZJqh9cOERwM+J2Er?=
 =?us-ascii?Q?/1ndwvk7LUEKCc8yT99+1vs=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3e8ecd-8ca7-4707-0ca1-08dc3dc08673
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 09:33:47.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goto9k9MgOqyBxWa9udoasRLqIrlQ44L3UJ4wWxsN/krflAQp3hTbpNeehTZ5zk4orjRFwr4xi18xdCAy65cGI7gYMvNWPBc9TBwUh9pMsxlRuMwTc1MWkmguV075RiP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

Add raw video device to capture raw data from ISP.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../staging/media/starfive/camss/stf-camss.c  | 19 ++++++
 .../media/starfive/camss/stf-capture.c        | 58 ++++++++++++++++++-
 .../staging/media/starfive/camss/stf-video.h  |  1 +
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/starfive/camss/stf-camss.c b/drivers/staging/media/starfive/camss/stf-camss.c
index 81fc39f20615..90ac8b67c76e 100644
--- a/drivers/staging/media/starfive/camss/stf-camss.c
+++ b/drivers/staging/media/starfive/camss/stf-camss.c
@@ -126,6 +126,7 @@ static int stfcamss_of_parse_ports(struct stfcamss *stfcamss)
 static int stfcamss_register_devs(struct stfcamss *stfcamss)
 {
 	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stf_capture *cap_raw = &stfcamss->captures[STF_CAPTURE_RAW];
 	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
 	int ret;
 
@@ -150,8 +151,18 @@ static int stfcamss_register_devs(struct stfcamss *stfcamss)
 
 	cap_yuv->video.source_subdev = &isp_dev->subdev;
 
+	ret = media_create_pad_link(&isp_dev->subdev.entity, STF_ISP_PAD_SRC_RAW,
+				    &cap_raw->video.vdev.entity, 0, 0);
+	if (ret)
+		goto err_rm_links0;
+
+	cap_raw->video.source_subdev = &isp_dev->subdev;
+
 	return ret;
 
+err_rm_links0:
+	media_entity_remove_links(&isp_dev->subdev.entity);
+	media_entity_remove_links(&cap_yuv->video.vdev.entity);
 err_cap_unregister:
 	stf_capture_unregister(stfcamss);
 err_isp_unregister:
@@ -162,6 +173,14 @@ static int stfcamss_register_devs(struct stfcamss *stfcamss)
 
 static void stfcamss_unregister_devs(struct stfcamss *stfcamss)
 {
+	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stf_capture *cap_raw = &stfcamss->captures[STF_CAPTURE_RAW];
+	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
+
+	media_entity_remove_links(&isp_dev->subdev.entity);
+	media_entity_remove_links(&cap_raw->video.vdev.entity);
+	media_entity_remove_links(&cap_yuv->video.vdev.entity);
+
 	stf_isp_unregister(&stfcamss->isp_dev);
 	stf_capture_unregister(stfcamss);
 }
diff --git a/drivers/staging/media/starfive/camss/stf-capture.c b/drivers/staging/media/starfive/camss/stf-capture.c
index 5c91126d5132..a5f10ec57782 100644
--- a/drivers/staging/media/starfive/camss/stf-capture.c
+++ b/drivers/staging/media/starfive/camss/stf-capture.c
@@ -12,6 +12,7 @@
 static const char * const stf_cap_names[] = {
 	"capture_dump",
 	"capture_yuv",
+	"capture_raw",
 };
 
 static const struct stfcamss_format_info stf_wr_fmts[] = {
@@ -55,6 +56,37 @@ static const struct stfcamss_format_info stf_isp_fmts[] = {
 	},
 };
 
+static const struct stfcamss_format_info stf_isp_raw_fmts[] = {
+	{
+		.code = MEDIA_BUS_FMT_SRGGB12_1X12,
+		.pixelformat = V4L2_PIX_FMT_SRGGB12,
+		.planes = 1,
+		.vsub = { 1 },
+		.bpp = 12,
+	},
+	{
+		.code = MEDIA_BUS_FMT_SGRBG12_1X12,
+		.pixelformat = V4L2_PIX_FMT_SGRBG12,
+		.planes = 1,
+		.vsub = { 1 },
+		.bpp = 12,
+	},
+	{
+		.code = MEDIA_BUS_FMT_SGBRG12_1X12,
+		.pixelformat = V4L2_PIX_FMT_SGBRG12,
+		.planes = 1,
+		.vsub = { 1 },
+		.bpp = 12,
+	},
+	{
+		.code = MEDIA_BUS_FMT_SBGGR12_1X12,
+		.pixelformat = V4L2_PIX_FMT_SBGGR12,
+		.planes = 1,
+		.vsub = { 1 },
+		.bpp = 12,
+	},
+};
+
 static inline struct stf_capture *to_stf_capture(struct stfcamss_video *video)
 {
 	return container_of(video, struct stf_capture, video);
@@ -73,6 +105,11 @@ static void stf_set_yuv_addr(struct stfcamss *stfcamss,
 	stf_isp_reg_write(stfcamss, ISP_REG_UV_PLANE_START_ADDR, uv_addr);
 }
 
+static void stf_set_raw_addr(struct stfcamss *stfcamss, dma_addr_t raw_addr)
+{
+	stf_isp_reg_write(stfcamss, ISP_REG_DUMP_CFG_0, raw_addr);
+}
+
 static void stf_init_addrs(struct stfcamss_video *video)
 {
 	struct stf_capture *cap = to_stf_capture(video);
@@ -91,6 +128,8 @@ static void stf_init_addrs(struct stfcamss_video *video)
 		stf_set_dump_addr(video->stfcamss, addr0);
 	else if (cap->type == STF_CAPTURE_YUV)
 		stf_set_yuv_addr(video->stfcamss, addr0, addr1);
+	else
+		stf_set_raw_addr(video->stfcamss, addr0);
 }
 
 static struct stfcamss_buffer *stf_buf_get_pending(struct stf_v_buf *output)
@@ -250,7 +289,6 @@ static void stf_capture_init(struct stfcamss *stfcamss, struct stf_capture *cap)
 
 	cap->video.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	cap->video.stfcamss = stfcamss;
-	cap->video.bpl_alignment = 16 * 8;
 
 	if (cap->type == STF_CAPTURE_DUMP) {
 		cap->video.formats = stf_wr_fmts;
@@ -260,6 +298,10 @@ static void stf_capture_init(struct stfcamss *stfcamss, struct stf_capture *cap)
 		cap->video.formats = stf_isp_fmts;
 		cap->video.nformats = ARRAY_SIZE(stf_isp_fmts);
 		cap->video.bpl_alignment = 1;
+	} else {
+		cap->video.formats = stf_isp_raw_fmts;
+		cap->video.nformats = ARRAY_SIZE(stf_isp_raw_fmts);
+		cap->video.bpl_alignment = STFCAMSS_FRAME_WIDTH_ALIGN_128;
 	}
 }
 
@@ -441,6 +483,8 @@ static void stf_change_buffer(struct stf_v_buf *output)
 			stf_set_dump_addr(stfcamss, new_addr[0]);
 		else if (cap->type == STF_CAPTURE_YUV)
 			stf_set_yuv_addr(stfcamss, new_addr[0], new_addr[1]);
+		else
+			stf_set_raw_addr(stfcamss, new_addr[0]);
 
 		stf_buf_add_ready(output, ready_buf);
 	}
@@ -468,6 +512,7 @@ irqreturn_t stf_wr_irq_handler(int irq, void *priv)
 irqreturn_t stf_isp_irq_handler(int irq, void *priv)
 {
 	struct stfcamss *stfcamss = priv;
+	struct stf_capture *cap_raw = &stfcamss->captures[STF_CAPTURE_RAW];
 	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_YUV];
 	u32 status;
 
@@ -476,6 +521,9 @@ irqreturn_t stf_isp_irq_handler(int irq, void *priv)
 		if (status & ISPC_ENUO)
 			stf_buf_done(&cap->buffers);
 
+		if (status & ISPC_CSI)
+			stf_buf_done(&cap_raw->buffers);
+
 		stf_isp_reg_write(stfcamss, ISP_REG_ISP_CTRL_0,
 				  (status & ~ISPC_INT_ALL_MASK) |
 				  ISPC_ISP | ISPC_CSI | ISPC_SC);
@@ -487,14 +535,20 @@ irqreturn_t stf_isp_irq_handler(int irq, void *priv)
 irqreturn_t stf_line_irq_handler(int irq, void *priv)
 {
 	struct stfcamss *stfcamss = priv;
+	struct stf_capture *cap_raw = &stfcamss->captures[STF_CAPTURE_RAW];
 	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_YUV];
 	u32 status;
+	u32 value;
 
 	status = stf_isp_reg_read(stfcamss, ISP_REG_ISP_CTRL_0);
 	if (status & ISPC_LINE) {
 		if (atomic_dec_if_positive(&cap->buffers.frame_skip) < 0) {
 			if ((status & ISPC_ENUO))
 				stf_change_buffer(&cap->buffers);
+
+			value = stf_isp_reg_read(stfcamss, ISP_REG_CSI_MODULE_CFG);
+			if (value & CSI_DUMP_EN)
+				stf_change_buffer(&cap_raw->buffers);
 		}
 
 		stf_isp_reg_set_bit(stfcamss, ISP_REG_CSIINTS,
@@ -571,9 +625,11 @@ void stf_capture_unregister(struct stfcamss *stfcamss)
 {
 	struct stf_capture *cap_dump = &stfcamss->captures[STF_CAPTURE_DUMP];
 	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stf_capture *cap_raw = &stfcamss->captures[STF_CAPTURE_RAW];
 
 	stf_capture_unregister_one(cap_dump);
 	stf_capture_unregister_one(cap_yuv);
+	stf_capture_unregister_one(cap_raw);
 }
 
 int stf_capture_register(struct stfcamss *stfcamss,
diff --git a/drivers/staging/media/starfive/camss/stf-video.h b/drivers/staging/media/starfive/camss/stf-video.h
index 90c73c0dee89..cad861aae31c 100644
--- a/drivers/staging/media/starfive/camss/stf-video.h
+++ b/drivers/staging/media/starfive/camss/stf-video.h
@@ -37,6 +37,7 @@ enum stf_v_line_id {
 enum stf_capture_type {
 	STF_CAPTURE_DUMP = 0,
 	STF_CAPTURE_YUV,
+	STF_CAPTURE_RAW,
 	STF_CAPTURE_NUM,
 };
 
-- 
2.25.1


