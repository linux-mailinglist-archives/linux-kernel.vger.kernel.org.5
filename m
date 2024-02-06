Return-Path: <linux-kernel+bounces-54826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A4884B420
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543412880F0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F09133291;
	Tue,  6 Feb 2024 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="6tTCLbnb"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E6130E4A;
	Tue,  6 Feb 2024 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219974; cv=none; b=fFm44euP7ujZFKUKgOqgA3qwCPYx4QqfVCv4G74Im/BzpRpKnrgIVsoPp3uAm70id7O5WszK3O+lXubadkTHtCFEPR6n/02nTYs5B0H7Ryenvod8vsRafqP+BFkistsHp/Cp6Vpa2yHn5O7/qTDXri6uJVcrrwB3AxzRsedBq8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219974; c=relaxed/simple;
	bh=mf4mcWEJHh468k2NfRH0WhQ+lqGq1EkNw05FDn/Kn+w=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=djvYi47LTpv1hz6qjRtt7kxIyF5r85rsduEWwRLqGiLbJ2N/BKYSYxqJ8SgR/H7lL6+0Qc2zO5aPS2pm7gr4TZ2GNKZDvBwWIExKqF8r59L79d7uAq5zV2orFrsiv5Q03kAl8AHsCRkX2oFLwyg5TiesQLfN0MfkOvK6lhWcg+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=6tTCLbnb; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4168nXgM018518;
	Tue, 6 Feb 2024 12:45:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=selector1; bh=KFKGglTUpjYqNq
	WORHTS/MU/U9RXok/ogiI6BUa3hCc=; b=6tTCLbnb0Pka6raI1BUyCTVkaVLDLz
	uAfcOm67cV9GCTJJigLlJW1s48OcjzhaQIGTTKO0I5jRg6VEDRtRfx7WCFeBfyvh
	EY9HagpzoBWXWD0m2+BO6DneEMNEIlfJR1NxqUgfXBHiN3jMMEfWBHcT5bDPUUx5
	XPHR/fy6XawpkrW3S+qlWNypTI4YP2m4B7xkEpefFfvQSKbk/cf4gqU44Vdfh3VP
	Xe9OLxyHWIfxt/0/3nntz2cJV03nm1M9ZdX4hKOCjIR3iHrh+lnmOQZcuwavWc9Y
	NkMWn1RGLwpBGQz/jj+TamnmKV8xnCRIQZ+sGKOuRTaWMuGR0pt6benA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w1yx4110d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 12:45:54 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 64A93100056;
	Tue,  6 Feb 2024 12:45:54 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5B91B23D408;
	Tue,  6 Feb 2024 12:45:54 +0100 (CET)
Received: from localhost (10.129.178.155) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 6 Feb
 2024 12:45:54 +0100
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Subject: [PATCH v5 0/3] Introduce STM32 LVDS driver
Date: Tue, 6 Feb 2024 12:45:33 +0100
Message-ID: <20240206-lvds-v5-0-bd16797b0f09@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN0bwmUC/zXMQQ7CIBCF4as0s5aGICi46j1MFw0MdhIthmmIp
 uHuYo3L/+Xl24AxEzJcug0yFmJKSwtz6MDP03JDQaE1KKm0VNKIewksUFqN3ki0Zwvt+swY6bU
 z17H1TLym/N7Vor/rHzj9gKKFFM4GE90Uj86FISbmntfepweMtdYPeN2XW5oAAAA=
To: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_04,2024-01-31_01,2023-05-22_02

This serie introduces a new DRM bridge driver for STM32MP257 platforms
based on Arm Cortex-35. It also adds an instance in the device-tree and
handle the inclusion of the driver within the DRM framework. First patch
adds a new panel compatible in the panel-lvds driver, which is used by
default on the STM32MP257.

Changes in v5:
	- Fixed path in MAINTAINERS
	- Fixed compatible in driver

Changes in v4:
	- Align dt-bindings filename and compatible
	- Remove redundant word in [1/6] subject
	- Fix example on typo
	- Some minor fixes on YAML syntax
	- Explicitly include linux/platform_device.h
	- Drop device-tree related patch after internal discussions
	- Rebase on latest drm-misc-next

Changes in v3:
	- Changed the compatible to show SoC specificity
	- Fixed includes in dt-binding example
	- Added "#clock-cells" description in dt-binding example
	- Some minor fixes on typo

Changes in v2:
	- Dropped [1/8] because already merged
	- Dropped [4/8] since not mandatory for this serie
	- [1/6]: Switch compatible and clock-cells related areas
	- [1/6]: Remove faulty #include in the example.
	- [1/6]: Add missing entry in MAINTAINERS
	- [2/6]: Removed CamelCase macros
	- [2/6]: Removed hard to read debug log
	- [3/6]: Fixed my address
	- [3/6]: Fixed smatch warning
	- [5/6]: Move changes to stm32mp255.dtsi

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
Raphael Gallais-Pou (3):
      dt-bindings: display: add STM32 LVDS device
      drm/stm: lvds: add new STM32 LVDS Display Interface Transmitter driver
      drm/stm: ltdc: add lvds pixel clock

 .../bindings/display/st,stm32mp25-lvds.yaml        |  119 ++
 MAINTAINERS                                        |    1 +
 drivers/gpu/drm/stm/Kconfig                        |   11 +
 drivers/gpu/drm/stm/Makefile                       |    2 +
 drivers/gpu/drm/stm/ltdc.c                         |   19 +
 drivers/gpu/drm/stm/ltdc.h                         |    1 +
 drivers/gpu/drm/stm/lvds.c                         | 1226 ++++++++++++++++++++
 7 files changed, 1379 insertions(+)
---
base-commit: bb3bc3eac316b7c388733e625cc2343131b69dee
change-id: 20240205-lvds-e084ec50e878

Best regards,
-- 
Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>


