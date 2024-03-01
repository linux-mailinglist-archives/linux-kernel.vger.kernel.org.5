Return-Path: <linux-kernel+bounces-87983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDEE86DBC6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7721C222FF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F1969949;
	Fri,  1 Mar 2024 07:00:43 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2106.outbound.protection.partner.outlook.cn [139.219.17.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F9869943;
	Fri,  1 Mar 2024 07:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709276442; cv=fail; b=aykgY1I+P2AOg1igIfDxk9S+/Gvtl/VmS1tRxqS9HW9+gT8YMJpFPKoqB+T7QbKSfdHIuQdsDFQzM2/O2MTOrX4RL+GkFzJMiecCn/zt49Ql8M+qCOyRVZOaMBPPirUgELLi9s1c9OddXYiXXu524b+0vf/eZPCQVSXv031PwJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709276442; c=relaxed/simple;
	bh=rEND3FQb5tDK/MVihV89d1ezaLDOKFEaDw7q0GKiOeM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LHp9iwRnMRz0qDmtA/+yXSY4GGEbssvzkuBORp9DoKccCle3D8/AQOoBk3hG2nO9snsbhvx7GecsMPiVjb82Ki0aVbGPLGxjQv4/5OI1rVTSjyllLV1YGgV3xQZZfs0Et6mJK3dzeh2A6V9wFOeqfW4T0j+UrnvtpZTlAExVwrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClhYqa5ZeVkSsRGiE3eZ+JijJnAZA3nlcPooLTXrGsebYxmQhKqEV6PXJW0AZuM/5Mcb94PbB7iF77bjvVwPj0UITHEkdjmBlUkG52/UTEW6mQiG9qMiJ4isQY7QF053sqV2druPoDmUFggHLBU7JWW/UzdZq3xz5B9vbquWmi+8D2OiZS9SZZqQe143434cMHt+2c2zmfZZA3al52X6CzPfR6C5GuZWcgBHxetb+MBYQhnhbjsSyf3mXVJBpXn3qHA5Kez5mh8B8+F600SuVDXXJnfnvUlqTlk0BJ3M237JwN2BE8TOH8dj3WiZNUOBYHfwr3QkRRhLbLzcabho8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CurFyMpT09PhFVXrzFUVLY2Eln2WXY3rjQUa+Ax+HHU=;
 b=Ik3XqER+3fiizHhPCPj0kfy0C+jBzmuPStI2kBGjTJd4xMi4wFqwtwIUDTWVWJleiLR/eJNQkrL+dAJLjUh8BIarwC4uKDM0ifSMoP41gnMvm5JCELHMKafZn2UMVFe8NMeNx9jkUNrVKRan0TLCugNUb2Ubg4Ua88tbrarDhVwVkFI/GMroextYTLvAaWWpW99vwLh7HeA/rbW4WDdV9MwAwAmRwMQR8hAWbKSDzjNjgqn4X7/WlzQTeAXcQvkkgNT/FiixtEakJrXYAP4YAfix4BNdTEQXL20GX2pcX/wiiggMWL06nDTMEdcePRCzYNjrlCs4vQO0zQ29mcae0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0864.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:24::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 07:00:34 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Fri, 1 Mar 2024 07:00:33 +0000
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
Subject: [v1] staging: media: starfive: Renamed capture_raw to capture_dump
Date: Thu, 29 Feb 2024 23:00:25 -0800
Message-Id: <20240301070025.11144-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0030.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::15) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0864:EE_
X-MS-Office365-Filtering-Correlation-Id: f8aedcb5-6888-4e80-1c08-08dc39bd4a30
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5NduyWObZchoDR3s/D++Vj0ZZdY6IpgM1M4Te07T1My3I4ImJXXEROlz085ZDY629K40CiMCCw2t/3dqy0MDpkiEQ09lp9XEp8pfPHS8il3N/v+pOUTYB5WHZg43bKe9ke3DazwO5z0r2J+jyJ5nq0+zZ5PmAiTBvQ3UobN8chmNH90vdfQjE5OnzUn9Y8AYeue64lrqA8ay1N2pIZYN5tyMv9U7qO++4+NatHTnbBLK2wXiqzZlK6CRZv1gVn3UYpFxokKfvsrbmnBQjo9CsH6ZJwFol2xwmw+LsI88sSiMt1ZsRHMAqMwtOPWarJOYyZUN3crStx2t3for8aImIaCn++gl4php+Un9LR0p9REz/ctvDFTzXErsfeu/NjCiOuBC/lDrmCSAYm6xMk5kFP+O6/j7u9fmU34BzW5VwE86UdyP2I2Z/uIiQxxzKiTpm6AfFxWXaMrudcjjYvuzskNeBH+PUCKzgNDA3IqLRvOePi2ewS50rX2953JD072WAsPuLFAxBmstt12HhS4HDiuLk7p8VAC/Z3naZDL8lZECL4yGD9nwfZJBdkCNAWu4cZIKSfrQFT2x3iSb/RKm4G2lAimkfeE0XNw4P+WiM287YiGOhbNK/l4podcm4DHK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mKas+UklEVOhUzusbhbS1hRslzQAQE4NF9mTA3YVOp8tkHzGWhDuCnXAiRVP?=
 =?us-ascii?Q?iHcoNEAvHdzQR0HhwnF9ekZ/vWBg5bpgIL9zgJUeVmU6tWpa68CUusQ+bpCD?=
 =?us-ascii?Q?M1bn+xM4Kbl/sdFiB4C44Sm1PP8BkBvmuFXolH6KQRbYeCpkn/qQ3FU1ZEZh?=
 =?us-ascii?Q?ilXsMQjDxIC6ZUE6+12/6Qu9t9ZtxIfpBecJOXHcgMliobySfmtqbHmZY2M3?=
 =?us-ascii?Q?Qn9EjfUdVLVs1+ZWyILKvgXi9bzU2fOjd5KymvAoThP765kbBRWXv05FvRNQ?=
 =?us-ascii?Q?KK3sC8SMhOZfmo7Mfwxv1b4kM5+LErtoUX8FouwQxkW+LoRHYEV8lJXf3x7M?=
 =?us-ascii?Q?mnYghPsUSiHOs//5FB4/ksLKZNF0XDSb551NAKxbUCQzYJ/ulvbl+whK58DX?=
 =?us-ascii?Q?aYvpgvXimhcpDq98qulqTI1ul3TPJ32E/nKvQbVRGMni3dqj3obkggooXevm?=
 =?us-ascii?Q?h8LwzN3ixGRLXd1ICrCKzzaYDjkmuexgckzsIBoiB7Hagdw5GRUxsEHm//a1?=
 =?us-ascii?Q?W+0arunqcplY0bP+PhP97ZVkA1OrqQRWL/sV/fgf74H4p6hB33PZyWAQnLQv?=
 =?us-ascii?Q?xC/dmadmLrwaT+h4AVUHx+z6YR1j67TyyPPZ/I9e6EX4ZVOayLz/8irtaGTO?=
 =?us-ascii?Q?DQQc4fYwfIWgdqSS422P7NL/Jqz6ZPgSeJHtfN1ocqfnDGSPsBcKQyQYCj5t?=
 =?us-ascii?Q?IeyUEuusW/URfzC3NW7ny6ZJsQIg6LUb5+7wGpVz1CtMZHZCX4eciCWWD2Fc?=
 =?us-ascii?Q?c/BZ4TRiUM4AZjqN5Vu/hBfSo0R4GeyFV9EqaUMwXBD365FVR6Z1GKs0MP6r?=
 =?us-ascii?Q?2clVXIJnm3Jtb6zioBB18BGeK27rpq5diXC/oyX0/B7bldjn8iiS12uAnbnn?=
 =?us-ascii?Q?JduqeU0shnLrblJv737e7ly6BuBbb3AqBLJh2A4xMVxmYr5RG413VyeBKw1L?=
 =?us-ascii?Q?JOC9zRgQx6J/So0/SNoXyqCDjAdoQhM12L94WD6pLcMfsBgtxkM+abG9TfFt?=
 =?us-ascii?Q?53TRvKvLc1eCIVuhpjTL8q9fXbPA1PmyCppSM9DD4d+kwzq5igafk8JxxDEm?=
 =?us-ascii?Q?bGdP1NTd93GyGLkz1FQMMItFmenaUpbdmh+/7b6pqkhbrSRNFPcOqCfuCiq8?=
 =?us-ascii?Q?+Am2fg54+g65db7jBI8sF931oJCp2VtjfX2MTnK+NNPRjvLo9duhCRsFiB+g?=
 =?us-ascii?Q?6rju8gAaXClUnF3xyBybHoBTRoCJZr9TfleQ52PlbdVfjgEZH001L3nDxI4U?=
 =?us-ascii?Q?YWxds+WnfoKYvzyNhCLUz+Mp/R9Gu+RisnTOtXAUCRJFr0w2HA0kw+fORjhD?=
 =?us-ascii?Q?c046IdYkJZFgwVDPgaIUj3Jr7aT2wpFS1dlMXpao/kbzjslcH+CCn1SvkbQc?=
 =?us-ascii?Q?ei5VFc0QtQ2i2WpXCDKbziYZh4zOYs7VMusMCtANY9+MHH1ZSdqv3/AS/DLk?=
 =?us-ascii?Q?9GcPGtNWpr2hwV2W/+ZJOi9QNRdK+dCEgmlPy6ij4RkoGPI7LUuJsrVgWvpI?=
 =?us-ascii?Q?TkdFkqX4BHmrSLXu/qtSem806UBuVVZHlWOP/Sg3RVMeMAkxP9w2Xn9B0DDc?=
 =?us-ascii?Q?WQvonil6/ASgdeIa6dfbDZNRBSDael6yaNXmsh4LQHzJX+XpRHIKcZy+myBb?=
 =?us-ascii?Q?KwvbVtQ2p2Wk8swLMV4BOSI=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8aedcb5-6888-4e80-1c08-08dc39bd4a30
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 07:00:33.8159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDxMoHgkm7ns+qKLYaBO41fIIh5elaY2fxC3VEpDl0ZK4zSxnXXqnGlw7DQZbrYw/hyWgrFYmafXfa8LQDlb6G2FjqdAtQAgfoOgWBgpTjwKxEXn6cklWyEg+4CzFP/T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0864

The pixel formats captured by the capture_raw video device depends on
what pixel formats come from the source device. It is actually dump
the source device data. So renamed it to capture_dump.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../admin-guide/media/starfive_camss.rst      |  2 +-
 .../media/starfive_camss_graph.dot            |  2 +-
 .../staging/media/starfive/camss/stf-camss.c  |  6 ++---
 .../media/starfive/camss/stf-capture.c        | 26 +++++++++----------
 .../staging/media/starfive/camss/stf-video.h  |  2 +-
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/media/starfive_camss.rst b/Documentation/admin-guide/media/starfive_camss.rst
index ca42e9447c47..c224e6123042 100644
--- a/Documentation/admin-guide/media/starfive_camss.rst
+++ b/Documentation/admin-guide/media/starfive_camss.rst
@@ -60,7 +60,7 @@ The media controller pipeline graph is as follows:

 The driver has 2 video devices:

-- capture_raw: The capture device, capturing image data directly from a sensor.
+- capture_dump: The capture device, capturing image data directly from a sensor.
 - capture_yuv: The capture device, capturing YUV frame data processed by the
   ISP module

diff --git a/Documentation/admin-guide/media/starfive_camss_graph.dot b/Documentation/admin-guide/media/starfive_camss_graph.dot
index 8eff1f161ac7..5e8731e27701 100644
--- a/Documentation/admin-guide/media/starfive_camss_graph.dot
+++ b/Documentation/admin-guide/media/starfive_camss_graph.dot
@@ -2,7 +2,7 @@ digraph board {
 	rankdir=TB
 	n00000001 [label="{{<port0> 0} | stf_isp\n/dev/v4l-subdev0 | {<port1> 1}}", shape=Mrecord, style=filled, fillcolor=green]
 	n00000001:port1 -> n00000008 [style=dashed]
-	n00000004 [label="capture_raw\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
+	n00000004 [label="capture_dump\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
 	n00000008 [label="capture_yuv\n/dev/video1", shape=box, style=filled, fillcolor=yellow]
 	n0000000e [label="{{<port0> 0} | cdns_csi2rx.19800000.csi-bridge\n | {<port1> 1 | <port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
 	n0000000e:port1 -> n00000001:port0 [style=dashed]
diff --git a/drivers/staging/media/starfive/camss/stf-camss.c b/drivers/staging/media/starfive/camss/stf-camss.c
index a587f860101a..81fc39f20615 100644
--- a/drivers/staging/media/starfive/camss/stf-camss.c
+++ b/drivers/staging/media/starfive/camss/stf-camss.c
@@ -176,7 +176,7 @@ static int stfcamss_subdev_notifier_bound(struct v4l2_async_notifier *async,
 		container_of(asc, struct stfcamss_async_subdev, asd);
 	enum stf_port_num port = csd->port;
 	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
-	struct stf_capture *cap_raw = &stfcamss->captures[STF_CAPTURE_RAW];
+	struct stf_capture *cap_dump = &stfcamss->captures[STF_CAPTURE_DUMP];
 	struct media_pad *pad;
 	int ret;

@@ -192,12 +192,12 @@ static int stfcamss_subdev_notifier_bound(struct v4l2_async_notifier *async,
 		return ret;

 	ret = media_create_pad_link(&subdev->entity, 1,
-				    &cap_raw->video.vdev.entity, 0, 0);
+				    &cap_dump->video.vdev.entity, 0, 0);
 	if (ret)
 		return ret;

 	isp_dev->source_subdev = subdev;
-	cap_raw->video.source_subdev = subdev;
+	cap_dump->video.source_subdev = subdev;

 	return 0;
 }
diff --git a/drivers/staging/media/starfive/camss/stf-capture.c b/drivers/staging/media/starfive/camss/stf-capture.c
index ec5169e7b391..5c91126d5132 100644
--- a/drivers/staging/media/starfive/camss/stf-capture.c
+++ b/drivers/staging/media/starfive/camss/stf-capture.c
@@ -10,7 +10,7 @@
 #include "stf-camss.h"

 static const char * const stf_cap_names[] = {
-	"capture_raw",
+	"capture_dump",
 	"capture_yuv",
 };

@@ -60,7 +60,7 @@ static inline struct stf_capture *to_stf_capture(struct stfcamss_video *video)
 	return container_of(video, struct stf_capture, video);
 }

-static void stf_set_raw_addr(struct stfcamss *stfcamss, dma_addr_t addr)
+static void stf_set_dump_addr(struct stfcamss *stfcamss, dma_addr_t addr)
 {
 	stf_syscon_reg_write(stfcamss, VIN_START_ADDR_O, (long)addr);
 	stf_syscon_reg_write(stfcamss, VIN_START_ADDR_N, (long)addr);
@@ -87,8 +87,8 @@ static void stf_init_addrs(struct stfcamss_video *video)
 	addr0 = output->buf[0]->addr[0];
 	addr1 = output->buf[0]->addr[1];

-	if (cap->type == STF_CAPTURE_RAW)
-		stf_set_raw_addr(video->stfcamss, addr0);
+	if (cap->type == STF_CAPTURE_DUMP)
+		stf_set_dump_addr(video->stfcamss, addr0);
 	else if (cap->type == STF_CAPTURE_YUV)
 		stf_set_yuv_addr(video->stfcamss, addr0, addr1);
 }
@@ -179,7 +179,7 @@ static void stf_channel_set(struct stfcamss_video *video)
 	struct stfcamss *stfcamss = cap->video.stfcamss;
 	u32 val;

-	if (cap->type == STF_CAPTURE_RAW) {
+	if (cap->type == STF_CAPTURE_DUMP) {
 		val = stf_syscon_reg_read(stfcamss, VIN_CHANNEL_SEL_EN);
 		val &= ~U0_VIN_CHANNEL_SEL_MASK;
 		val |= CHANNEL(0);
@@ -219,7 +219,7 @@ static void stf_capture_start(struct stfcamss_video *video)
 	struct stf_capture *cap = to_stf_capture(video);

 	stf_channel_set(video);
-	if (cap->type == STF_CAPTURE_RAW) {
+	if (cap->type == STF_CAPTURE_DUMP) {
 		stf_wr_irq_enable(video);
 		stf_wr_data_en(video);
 	}
@@ -231,7 +231,7 @@ static void stf_capture_stop(struct stfcamss_video *video)
 {
 	struct stf_capture *cap = to_stf_capture(video);

-	if (cap->type == STF_CAPTURE_RAW)
+	if (cap->type == STF_CAPTURE_DUMP)
 		stf_wr_irq_disable(video);

 	stf_cap_s_cleanup(video);
@@ -252,7 +252,7 @@ static void stf_capture_init(struct stfcamss *stfcamss, struct stf_capture *cap)
 	cap->video.stfcamss = stfcamss;
 	cap->video.bpl_alignment = 16 * 8;

-	if (cap->type == STF_CAPTURE_RAW) {
+	if (cap->type == STF_CAPTURE_DUMP) {
 		cap->video.formats = stf_wr_fmts;
 		cap->video.nformats = ARRAY_SIZE(stf_wr_fmts);
 		cap->video.bpl_alignment = 8;
@@ -437,8 +437,8 @@ static void stf_change_buffer(struct stf_v_buf *output)
 	if (output->state == STF_OUTPUT_STOPPING) {
 		output->last_buffer = ready_buf;
 	} else {
-		if (cap->type == STF_CAPTURE_RAW)
-			stf_set_raw_addr(stfcamss, new_addr[0]);
+		if (cap->type == STF_CAPTURE_DUMP)
+			stf_set_dump_addr(stfcamss, new_addr[0]);
 		else if (cap->type == STF_CAPTURE_YUV)
 			stf_set_yuv_addr(stfcamss, new_addr[0], new_addr[1]);

@@ -452,7 +452,7 @@ static void stf_change_buffer(struct stf_v_buf *output)
 irqreturn_t stf_wr_irq_handler(int irq, void *priv)
 {
 	struct stfcamss *stfcamss = priv;
-	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_RAW];
+	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_DUMP];

 	if (atomic_dec_if_positive(&cap->buffers.frame_skip) < 0) {
 		stf_change_buffer(&cap->buffers);
@@ -569,10 +569,10 @@ static void stf_capture_unregister_one(struct stf_capture *cap)

 void stf_capture_unregister(struct stfcamss *stfcamss)
 {
-	struct stf_capture *cap_raw = &stfcamss->captures[STF_CAPTURE_RAW];
+	struct stf_capture *cap_dump = &stfcamss->captures[STF_CAPTURE_DUMP];
 	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];

-	stf_capture_unregister_one(cap_raw);
+	stf_capture_unregister_one(cap_dump);
 	stf_capture_unregister_one(cap_yuv);
 }

diff --git a/drivers/staging/media/starfive/camss/stf-video.h b/drivers/staging/media/starfive/camss/stf-video.h
index 8052b77e3ad8..90c73c0dee89 100644
--- a/drivers/staging/media/starfive/camss/stf-video.h
+++ b/drivers/staging/media/starfive/camss/stf-video.h
@@ -35,7 +35,7 @@ enum stf_v_line_id {
 };

 enum stf_capture_type {
-	STF_CAPTURE_RAW = 0,
+	STF_CAPTURE_DUMP = 0,
 	STF_CAPTURE_YUV,
 	STF_CAPTURE_NUM,
 };
--
2.25.1

