Return-Path: <linux-kernel+bounces-138219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BABB89EE3B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387D31C21F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB31F15820B;
	Wed, 10 Apr 2024 09:10:52 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2130.outbound.protection.partner.outlook.cn [139.219.146.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE541553B3;
	Wed, 10 Apr 2024 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740251; cv=fail; b=GV+dWfPA/xIf+IVtd68/eKQTWzLaxV41GzEbRYkb79W/shOy2EinELUo3k+mWHeVNNCjsEvD6SE+ED8f1rSgYP/I+xO9TbS46b5wK37C+YfSdmEkuoGH2v5RIvgnpxyWnEg7f7emiwHaBQCpw71QExBIanrthaZHaK62/BXqrC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740251; c=relaxed/simple;
	bh=NqBbGW/gLbS9tCvNDnh1AswU17r18PeEK95VIz4eROk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fEEAGZnJPT7Bet4VftTXpT9uoL6pRLyE6LXG/p6NJk7J6d4jrDgFEJHoFaozL8yeVpbs2y4Pha6zGkbQ0op0byRUHicP48uL3SDlDTrHtCpnjZmaUknrWFd/b30/sjXk76RKBox33y2ZLStEYbfEn71OVhJJT3IMLFAlpX43QNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knOPsDsZ2JkWBB9LZhHua721a8sjjFcwKk/FEJWx+BJUyAxuIvcz206wvo+nIzkPkwxwaSuRWAAVGJlrrxBRGjhjw8nFyzH5OVuIGkWEiqpng22YYMmKIp6kU2lY9fihfCk1SzHNSieVdbIZQBx2pda5+Gte0T4FZnw/BCYTehbqxVXqrv13i6rVfIDW9Z3SAOKklcQKgVkVjP3IjoBXUFytiUIYRNejirT06z2S4KIfF/KfgGYi/ijUpOaubS5TBAw+lZOsafvNPytTE/frAfa1ffUSWy8yauuABcVLHR9Zmy0NmAVp+WbWeeYVRS3zWwE1DC95LFyr2aiq1bMZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0K3zM2ziE/HCUh0ogvNJJSvABDIyw/DTL7ZtmMK5kUc=;
 b=I7kNDX1pTGvCWJImcOqZFnDBVP2vwiAWw3vn4G3xb/35s2yVtyu8rRqHrf5X4IlrniS71jTxH2LlgbwB/kzTEzrQIx61HaeRJxY+Ttae3auTx2ml5V215ByNpL/adKci65XXAcgThFEM0vjOMPJb2YO4T+65c2UEwGkh5qjHPh2D+vTSndlSbzDpo67EV3fbvGUri0fQao85GOFdtTEXlgqd13Fg3c5pPInj70V/KaZ81efS0lSSpxTduqlQOL4K+Ah6a90jGkcVpgHWZym7/aSO4YBBGUEDLYe3VoaajtC43YGgcKI/D16SenJWIe16i6M/8hGHv8WiENUHzSpcLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0461.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 09:10:39 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.053; Wed, 10 Apr 2024 09:10:39 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v2 5/8] staging: media: starfive: Add ISP bayer video device
Date: Wed, 10 Apr 2024 02:10:23 -0700
Message-Id: <20240410091026.50272-6-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410091026.50272-1-changhuang.liang@starfivetech.com>
References: <20240410091026.50272-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0005.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::17) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0461:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2ce7d4-3e89-4ad4-9e0e-08dc593e1771
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l2JRw7pyguxtKqTiYc/yIFl6IWy1owA3OvdsFiIGA2XVqlq6LnQobttRk1rXCoVerV+oGJi1ymSruws/ga/Rcv6I1tvMSEEL1vgxD4EeDVvNJBkwIiJ9enhSv5HGt6XswBtUZfBCYhYrzqDOBFz/MnRW/oY33FaUIqtgDec1h8ro+N8GJZikyi9rUPOD8M9VNq8lFV7FqcEb3Ln6iI0o3ioTPc4AH3uxBNUuhCY0fSbbN7NoIScsIo+EPxiBQUdKgOQaLKXo7G3PkmIPwkbb9gUgcAwfBy9fcqoHrq8/WLUugs1ot3iseOVjJ4Z8j/TIwMDlM+2EsN8ufDVvurY8dTlwOzBemxAC8Ng7I7XwC+s1+YuZnRe9hc6DHKzvrAH+rh3pT4GgPQRONYUCppXTlRU9VBNgIQXGpmplWvxg5eK91SroIJbZztdaq1VQYqegV5Sm9yF6V5Otvwg2zGKnPltDB3clkQrc5QE5N0qId4JL/9tsaFTtsusCzCn2pv8IhrW/ADZXKPU9iZ7+l3UPuKEiD/WlX0It2SGBhuPKqhEn0wh28U81qP1gOPzx33bCm8GXuEmSQ3i30w6I+4p1j2M61ETdSh6htgk+gOLSf8Nrwq6sBK8wbnJp5/C32jlu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZSPF2mIDhJGVgzKfZ87rzWFgMMjEMrGYVC7FLxAXw6d5VZdXLI8emtstxR3h?=
 =?us-ascii?Q?EikVzIsr6xDyEcZN9NdvyIJQPrMFsDEgSds349SLthpyOwwHVV+2fI0SiGRp?=
 =?us-ascii?Q?F0QRZ7TsA1ClHJKCRjKl+dZgz8B3lLZvbIlnc1ntMoD4imuUh9Bg1nFHqhbk?=
 =?us-ascii?Q?Ovr9zLGKVu3sCDk7C4mUQuGUNl+mJNL+WD+qjEK8gaCsbyI5bfaKQIcfFHcX?=
 =?us-ascii?Q?AD62XDS/CYD2we3P2NQXHC6K1WoRuHmMerlBfXG7DMNA3fmCTCRbpY98aUD5?=
 =?us-ascii?Q?uR1WtFVgP3Ki2V/K0jzj/gBWeqMwKoNM9h9FvwYAAecajwr8Xagr2ErtJpUd?=
 =?us-ascii?Q?IvtxWc6g9jSUugx8t0JLfupfYJxH7QZDip60utkar33JgcnKCaeG86vn0S0G?=
 =?us-ascii?Q?5wgOfiuSGkT9Y3+LKkmL0qx/iEU45ykVqKbEK7KsmQ9er7/bDP8Hd2YqFVjs?=
 =?us-ascii?Q?d7pGI/GMJhpQDXhy+yaNOg6lr1P/kZi1p66vRsxprNujl2gU9JgBZVYjWPfN?=
 =?us-ascii?Q?3COgw40qSLtvjmknKG4rUoCJoUTYHsveVB6ZMQ8+M86MIYZkZog2NxY8ALUN?=
 =?us-ascii?Q?kUdMHumoQSnqS1PMxEviq5jpMXkSJONGXx3VMifTJPlnyeLtSj95TnpPS1IX?=
 =?us-ascii?Q?yi/MXvbZ4m+d9H3ropqXlA+Ljp5qah0o3juHO6q1BhvlwvuBCMrNMUMViMDv?=
 =?us-ascii?Q?6TCkhnVo/RMv4g/HGLaCWttTWM6MVd08C9vtWLvmx0BFINhQ+4MKb9ORXmHy?=
 =?us-ascii?Q?tPTXxEqtnzlUsxWOfaAx/2Op/SZum8RhO0SEEV3Sl+ZoayTS+1OX3BW9fngt?=
 =?us-ascii?Q?w8J9publQ1DR2xKGz9fOe/ME7KPQOqMyBLkj4zzZlZK95oVKNi8q83/vQHrf?=
 =?us-ascii?Q?RmivwhhhXCaivsuzBw+DYoejNdsiaNIAlxcFucQ08dqddn1ciuDDAQcvmDKl?=
 =?us-ascii?Q?ji7VDUGM89qMI5kVeTS7frBRBgZvj/HfopywSBR+kZrEias/Gsx3ksUSzE5X?=
 =?us-ascii?Q?JUzxWs+pY9d0pM4hJ3pp3//OBk4hFaBOZDblD1fkhcwauCZPVBZ8Qlbt0due?=
 =?us-ascii?Q?C1p7s7ze4kZk72M8d8+juM30RHG5QVIx6G7CwFWkHKUVIfCOjusDCfxnkWSK?=
 =?us-ascii?Q?PcGmPpZtPi8AT3icQVTlja609fS5OzSLFkl94rBQpKu2Vlmjek2OzBvYliyU?=
 =?us-ascii?Q?OBjVS79yKFplMXsziMH+2feBEI+ZTrIXdVNfNeayz2d8H65tGt2fb/r8a8WR?=
 =?us-ascii?Q?hzcw7sCchhE55VF2Rdmxf+FJ63OBopRXoe9E37iGABuLoD/OqAP3zWzMZLUT?=
 =?us-ascii?Q?3VNweYpY15Yr7LGNxLqRr8cMwmdocwkUI/enrkLWHUag9hkeBDCHYJU3ih6p?=
 =?us-ascii?Q?RZB4gU0ui5D09JHDFJjFnFJ8Xf7L1c0BFFjetDf4yPZ5mEVsFsUD6oxsmbOH?=
 =?us-ascii?Q?9xVJxHoSaCpLQl4fAxReyr1H6EYEaODSYTZV8TllZtYzy/g3AIrckuMyOjxz?=
 =?us-ascii?Q?5HuNBCyrFA4W4L/+TpxWDtrW7RW5H3ownSEJ1ltFIUARcT8Fyr5rSyiNuMv5?=
 =?us-ascii?Q?mnuzcKhJkH2/kCWRQUzyW5TLccBXlPHfUGFl+saKHDCOBycbnWLzKRaMNBwt?=
 =?us-ascii?Q?xtlMWb4tjxhMhvM/adsVkhM=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2ce7d4-3e89-4ad4-9e0e-08dc593e1771
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 09:10:39.6868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: El9BSJDqTeP6+kzgO0wIQp1wZWjxe3D2P73ihtoET0E5mYA3RvYr8ZF6/+olMcg++tLXAE0nAnHwBrRnK6eotciW61GgOCbiliGEXqC/erJYWYH7yMBePkK2stbJsEii
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0461

Add bayer video device to capture bayer format data from ISP.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../staging/media/starfive/camss/stf-camss.c  | 12 ++++++
 .../media/starfive/camss/stf-capture.c        | 41 +++++++++++++++++++
 .../media/starfive/camss/stf-isp-hw-ops.c     | 19 +++++++++
 .../staging/media/starfive/camss/stf-isp.h    |  1 +
 .../staging/media/starfive/camss/stf-video.h  |  1 +
 5 files changed, 74 insertions(+)

diff --git a/drivers/staging/media/starfive/camss/stf-camss.c b/drivers/staging/media/starfive/camss/stf-camss.c
index 62bf46a69a3e..b2f9892b7663 100644
--- a/drivers/staging/media/starfive/camss/stf-camss.c
+++ b/drivers/staging/media/starfive/camss/stf-camss.c
@@ -125,6 +125,7 @@ static int stfcamss_of_parse_ports(struct stfcamss *stfcamss)
 
 static int stfcamss_register_devs(struct stfcamss *stfcamss)
 {
+	struct stf_capture *cap_bayer = &stfcamss->captures[STF_CAPTURE_BAYER];
 	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
 	struct stf_capture *cap_scd = &stfcamss->captures[STF_CAPTURE_SCD];
 	struct stf_output *output = &stfcamss->output;
@@ -172,8 +173,17 @@ static int stfcamss_register_devs(struct stfcamss *stfcamss)
 	if (ret)
 		goto err_rm_links1;
 
+	ret = media_create_pad_link(&isp_dev->subdev.entity, STF_ISP_PAD_SRC_BAYER,
+				    &cap_bayer->video.vdev.entity, 0, 0);
+	if (ret)
+		goto err_rm_links2;
+
+	cap_bayer->video.source_subdev = &isp_dev->subdev;
+
 	return ret;
 
+err_rm_links2:
+	media_entity_remove_links(&output->video.vdev.entity);
 err_rm_links1:
 	media_entity_remove_links(&cap_scd->video.vdev.entity);
 err_rm_links0:
@@ -191,6 +201,7 @@ static int stfcamss_register_devs(struct stfcamss *stfcamss)
 
 static void stfcamss_unregister_devs(struct stfcamss *stfcamss)
 {
+	struct stf_capture *cap_bayer = &stfcamss->captures[STF_CAPTURE_BAYER];
 	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
 	struct stf_capture *cap_scd = &stfcamss->captures[STF_CAPTURE_SCD];
 	struct stf_output *output = &stfcamss->output;
@@ -200,6 +211,7 @@ static void stfcamss_unregister_devs(struct stfcamss *stfcamss)
 	media_entity_remove_links(&isp_dev->subdev.entity);
 	media_entity_remove_links(&cap_yuv->video.vdev.entity);
 	media_entity_remove_links(&cap_scd->video.vdev.entity);
+	media_entity_remove_links(&cap_bayer->video.vdev.entity);
 
 	stf_isp_unregister(&stfcamss->isp_dev);
 	stf_capture_unregister(stfcamss);
diff --git a/drivers/staging/media/starfive/camss/stf-capture.c b/drivers/staging/media/starfive/camss/stf-capture.c
index 328b8c6e351d..21a59259d7a0 100644
--- a/drivers/staging/media/starfive/camss/stf-capture.c
+++ b/drivers/staging/media/starfive/camss/stf-capture.c
@@ -12,6 +12,7 @@
 static const char * const stf_cap_names[] = {
 	"capture_raw",
 	"capture_yuv",
+	"capture_bayer",
 	"capture_scd",
 };
 
@@ -56,6 +57,37 @@ static const struct stfcamss_format_info stf_isp_fmts[] = {
 	},
 };
 
+static const struct stfcamss_format_info stf_isp_bayer_fmts[] = {
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
 /* 3A Statistics Collection Data */
 static const struct stfcamss_format_info stf_isp_scd_fmts[] = {
 	{
@@ -93,6 +125,8 @@ static void stf_init_addrs(struct stfcamss_video *video)
 		stf_set_raw_addr(video->stfcamss, addr0);
 	else if (cap->type == STF_CAPTURE_YUV)
 		stf_set_yuv_addr(video->stfcamss, addr0, addr1);
+	else if (cap->type == STF_CAPTURE_BAYER)
+		stf_set_bayer_addr(video->stfcamss, addr0);
 	else
 		stf_set_scd_addr(video->stfcamss, addr0, addr1, TYPE_AWB);
 }
@@ -251,6 +285,11 @@ static void stf_capture_init(struct stfcamss *stfcamss, struct stf_capture *cap)
 		cap->video.formats = stf_isp_fmts;
 		cap->video.nformats = ARRAY_SIZE(stf_isp_fmts);
 		cap->video.bpl_alignment = 1;
+	} else if (cap->type == STF_CAPTURE_BAYER) {
+		cap->video.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+		cap->video.formats = stf_isp_bayer_fmts;
+		cap->video.nformats = ARRAY_SIZE(stf_isp_bayer_fmts);
+		cap->video.bpl_alignment = 16 * 8;
 	} else {
 		cap->video.type = V4L2_BUF_TYPE_META_CAPTURE;
 		cap->video.formats = stf_isp_scd_fmts;
@@ -377,6 +416,7 @@ static void stf_capture_unregister_one(struct stf_capture *cap)
 
 void stf_capture_unregister(struct stfcamss *stfcamss)
 {
+	struct stf_capture *cap_bayer = &stfcamss->captures[STF_CAPTURE_BAYER];
 	struct stf_capture *cap_raw = &stfcamss->captures[STF_CAPTURE_RAW];
 	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
 	struct stf_capture *cap_scd = &stfcamss->captures[STF_CAPTURE_SCD];
@@ -384,6 +424,7 @@ void stf_capture_unregister(struct stfcamss *stfcamss)
 	stf_capture_unregister_one(cap_raw);
 	stf_capture_unregister_one(cap_yuv);
 	stf_capture_unregister_one(cap_scd);
+	stf_capture_unregister_one(cap_bayer);
 }
 
 int stf_capture_register(struct stfcamss *stfcamss,
diff --git a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
index 44ac472d9dc3..f170fab2bfb4 100644
--- a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
+++ b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
@@ -515,6 +515,11 @@ void stf_set_scd_addr(struct stfcamss *stfcamss,
 	stf_isp_reg_write(stfcamss, ISP_REG_YHIST_CFG_4, yhist_addr);
 }
 
+void stf_set_bayer_addr(struct stfcamss *stfcamss, dma_addr_t bayer_addr)
+{
+	stf_isp_reg_write(stfcamss, ISP_REG_DUMP_CFG_0, bayer_addr);
+}
+
 static void stf_isp_fill_yhist(struct stfcamss *stfcamss, void *vaddr)
 {
 	struct jh7110_isp_sc_buffer *sc = (struct jh7110_isp_sc_buffer *)vaddr;
@@ -596,6 +601,7 @@ static void stf_isp_set_params(struct stfcamss *stfcamss, void *vaddr)
 irqreturn_t stf_line_irq_handler(int irq, void *priv)
 {
 	struct stfcamss *stfcamss = priv;
+	struct stf_capture *cap_bayer = &stfcamss->captures[STF_CAPTURE_BAYER];
 	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_YUV];
 	struct stf_capture *cap_scd = &stfcamss->captures[STF_CAPTURE_SCD];
 	struct stfcamss_buffer *change_buf;
@@ -623,6 +629,12 @@ irqreturn_t stf_line_irq_handler(int irq, void *priv)
 							 change_buf->addr[1], type_scd);
 				}
 			}
+
+			if (value & CSI_DUMP_EN) {
+				change_buf = stf_change_buffer(&cap_bayer->buffers);
+				if (change_buf)
+					stf_set_bayer_addr(stfcamss, change_buf->addr[0]);
+			}
 		}
 
 		stf_isp_reg_set_bit(stfcamss, ISP_REG_CSIINTS,
@@ -640,6 +652,7 @@ irqreturn_t stf_line_irq_handler(int irq, void *priv)
 irqreturn_t stf_isp_irq_handler(int irq, void *priv)
 {
 	struct stfcamss *stfcamss = priv;
+	struct stf_capture *cap_bayer = &stfcamss->captures[STF_CAPTURE_BAYER];
 	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_YUV];
 	struct stf_capture *cap_scd = &stfcamss->captures[STF_CAPTURE_SCD];
 	struct stf_output *output = &stfcamss->output;
@@ -668,6 +681,12 @@ irqreturn_t stf_isp_irq_handler(int irq, void *priv)
 			}
 		}
 
+		if (status & ISPC_CSI) {
+			ready_buf = stf_buf_done(&cap_bayer->buffers);
+			if (ready_buf)
+				vb2_buffer_done(&ready_buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
+		}
+
 		stf_isp_reg_write(stfcamss, ISP_REG_ISP_CTRL_0,
 				  (status & ~ISPC_INT_ALL_MASK) |
 				  ISPC_ISP | ISPC_CSI | ISPC_SC);
diff --git a/drivers/staging/media/starfive/camss/stf-isp.h b/drivers/staging/media/starfive/camss/stf-isp.h
index f63817b7a235..8505603bdbc5 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.h
+++ b/drivers/staging/media/starfive/camss/stf-isp.h
@@ -592,6 +592,7 @@ int stf_isp_unregister(struct stf_isp_dev *isp_dev);
 
 void stf_set_yuv_addr(struct stfcamss *stfcamss,
 		      dma_addr_t y_addr, dma_addr_t uv_addr);
+void stf_set_bayer_addr(struct stfcamss *stfcamss, dma_addr_t bayer_addr);
 void stf_set_scd_addr(struct stfcamss *stfcamss,
 		      dma_addr_t yhist_addr, dma_addr_t scd_addr,
 		      enum stf_isp_type_scd type_scd);
diff --git a/drivers/staging/media/starfive/camss/stf-video.h b/drivers/staging/media/starfive/camss/stf-video.h
index 53a1cf4e59b7..ea7ec92c3ff5 100644
--- a/drivers/staging/media/starfive/camss/stf-video.h
+++ b/drivers/staging/media/starfive/camss/stf-video.h
@@ -37,6 +37,7 @@ enum stf_v_line_id {
 enum stf_capture_type {
 	STF_CAPTURE_RAW = 0,
 	STF_CAPTURE_YUV,
+	STF_CAPTURE_BAYER,
 	STF_CAPTURE_SCD,
 	STF_CAPTURE_NUM,
 };
-- 
2.25.1


