Return-Path: <linux-kernel+bounces-6596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861A3819ACB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428BF287F98
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975861D6BE;
	Wed, 20 Dec 2023 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RV9+YWPZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519BA1CAA7;
	Wed, 20 Dec 2023 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BK6A9w9026700;
	Wed, 20 Dec 2023 09:46:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=cyfd0rf
	aAV6O1iXqR5snIedqjSoG4Q/E7ZuiVTF+bro=; b=RV9+YWPZNrjlUyUfwrjs6dp
	tC9o55EJlpBvVDrJ2j5X4D5E6W04WKwX4S9ArqGU3Yb5Vk+ecXG+X3M7OyB3CGCL
	0G1pH4I40LTQMyn++6U4xWoomvJZe54POIw+id0elZ4w/79ucC4DO5bg2ZEX9H1Y
	jEkD/T92ZAW+8606u+2YonNrnQ5aSIf+Ib1Fz9UBqz4QFSTvZxv3Tffc7xvqkebr
	CiLKUVMj/6XXMlJlQTFJkrh2OMvzoCn1BivqcYFhn+2DeR+TZqmmAaIlT0S9BLLl
	LUv7rm8XTTTnhzgJGlSgXQtyxZG5zP0ygAbsO9eSGhFxdoZ5lt/QngxMDd20xyA=
	=
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v11w901xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 09:46:46 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2C7BE100057;
	Wed, 20 Dec 2023 09:46:45 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0BF3E20A75C;
	Wed, 20 Dec 2023 09:46:45 +0100 (CET)
Received: from localhost (10.201.20.120) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Dec
 2023 09:46:44 +0100
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
Subject: [PATCH v3 0/4] Add support for video hardware codec of STMicroelectronics STM32 SoC series
Date: Wed, 20 Dec 2023 09:46:36 +0100
Message-ID: <20231220084641.2076428-1-hugues.fruchet@foss.st.com>
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
 definitions=2023-12-20_02,2023-12-14_01,2023-05-22_02

This patchset introduces support for VDEC video hardware decoder
and VENC video hardware encoder of STMicroelectronics STM32MP25
SoC series.

This initial support implements H264 decoding, VP8 decoding and
JPEG encoding.

This has been tested on STM32MP257F-EV1 evaluation board.

===========
= history =
===========
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

 arch/arm64/boot/dts/st/stm32mp251.dtsi        |  12 ++
 arch/arm64/boot/dts/st/stm32mp255.dtsi        |  17 ++
 drivers/media/platform/verisilicon/Kconfig    |  14 +-
 drivers/media/platform/verisilicon/Makefile   |   4 +
 .../media/platform/verisilicon/hantro_drv.c   |   4 +
 .../media/platform/verisilicon/hantro_hw.h    |   2 +
 .../platform/verisilicon/stm32mp25_vdec_hw.c  |  92 +++++++++++
 .../platform/verisilicon/stm32mp25_venc_hw.c  | 147 ++++++++++++++++++
 8 files changed, 289 insertions(+), 3 deletions(-)
 create mode 100644 drivers/media/platform/verisilicon/stm32mp25_vdec_hw.c
 create mode 100644 drivers/media/platform/verisilicon/stm32mp25_venc_hw.c

-- 
2.25.1


