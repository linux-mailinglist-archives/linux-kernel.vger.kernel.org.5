Return-Path: <linux-kernel+bounces-7162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F8281A27B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A82ACB21213
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC53F4652C;
	Wed, 20 Dec 2023 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="h9KTP9l8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885E03E46E;
	Wed, 20 Dec 2023 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BKAmY9i020525;
	Wed, 20 Dec 2023 16:27:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=tEuXmaN
	aHen/qbXE+5QeVHvI7f5gS6OM2PXMf9c90iY=; b=h9KTP9l85hp14tkMNtiJs6M
	KSL37hMKUUp9sg1JGR6OiGPHF0OCLnR31DocKfOKk453z7U8kncgOrb4EaS4m5jy
	M6i6ref4wh/SU4UqR9slsStIASRy99AGL8EMiMttJHazYvmbUj4FN0yK7sVw+9hR
	k5OSJUmHeoVxpKemWu78g3AIZxHAl/0EevAD7ZZyEGLoxpWekjD7mYh731/P/Fyb
	6YnXxPXi5OAciYeHa42HQ3ZwZbSfEGLT0LcNiTVDiAmke2Wcm7CstKdE8+iPHexR
	c6Z2Jkwa5GzEvcS3JYWDNO54gUpuCeQVF72ZBHyHSmpDxvjqpYvoRgKWrGIDqDw=
	=
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v14422ac4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 16:27:35 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 67E32100057;
	Wed, 20 Dec 2023 16:27:34 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 577A721ED29;
	Wed, 20 Dec 2023 16:27:34 +0100 (CET)
Received: from localhost (10.201.20.120) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Dec
 2023 16:27:34 +0100
From: Hugues Fruchet <hugues.fruchet@foss.st.com>
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Sakari Ailus
	<sakari.ailus@linux.intel.com>,
        Benjamin Gaignard
	<benjamin.gaignard@collabora.com>,
        Laurent Pinchart
	<laurent.pinchart+renesas@ideasonboard.com>,
        Daniel Almeida
	<daniel.almeida@collabora.com>,
        Benjamin Mugnier
	<benjamin.mugnier@foss.st.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mauro
 Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, <linux-media@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>
CC: Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Marco Felsch
	<m.felsch@pengutronix.de>,
        Adam Ford <aford173@gmail.com>
Subject: [PATCH v4 0/5] Add support for video hardware codec of STMicroelectronics STM32 SoC series
Date: Wed, 20 Dec 2023 16:27:27 +0100
Message-ID: <20231220152732.2138260-1-hugues.fruchet@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_09,2023-12-20_01,2023-05-22_02

This patchset introduces support for VDEC video hardware decoder
and VENC video hardware encoder of STMicroelectronics STM32MP25
SoC series.

This initial support implements H264 decoding, VP8 decoding and
JPEG encoding.

This has been tested on STM32MP257F-EV1 evaluation board.

===========
= history =
===========
version 4:
   - Fix comments from Nicolas about dropping encoder raw steps

version 3:
   - Fix remarks from Krzysztof Kozlowski:
    - drop "items", we keep simple enum in such case
    - drop second example - it is the same as the first
   - Drop unused node labels as suggested by Conor Dooley
   - Revisit min/max resolutions as suggested by Nicolas Dufresne

version 2:
   - Fix remarks from Krzysztof Kozlowski on v1:
    - single video-codec binding for both VDEC/VENC
    - get rid of "-names"
    - use of generic node name "video-codec"

version 1:
  - Initial submission

Hugues Fruchet (5):
  dt-bindings: media: Document STM32MP25 VDEC & VENC video codecs
  media: hantro: add support for STM32MP25 VDEC
  media: hantro: add support for STM32MP25 VENC
  arm64: dts: st: add video decoder support to stm32mp255
  arm64: dts: st: add video encoder support to stm32mp255

 .../media/st,stm32mp25-video-codec.yaml       |  50 ++++++++
 arch/arm64/boot/dts/st/stm32mp251.dtsi        |  12 ++
 arch/arm64/boot/dts/st/stm32mp255.dtsi        |  17 +++
 drivers/media/platform/verisilicon/Kconfig    |  14 ++-
 drivers/media/platform/verisilicon/Makefile   |   4 +
 .../media/platform/verisilicon/hantro_drv.c   |   4 +
 .../media/platform/verisilicon/hantro_hw.h    |   2 +
 .../platform/verisilicon/stm32mp25_vdec_hw.c  |  92 ++++++++++++++
 .../platform/verisilicon/stm32mp25_venc_hw.c  | 115 ++++++++++++++++++
 9 files changed, 307 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml
 create mode 100644 drivers/media/platform/verisilicon/stm32mp25_vdec_hw.c
 create mode 100644 drivers/media/platform/verisilicon/stm32mp25_venc_hw.c

-- 
2.25.1


