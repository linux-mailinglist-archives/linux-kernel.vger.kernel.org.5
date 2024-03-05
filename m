Return-Path: <linux-kernel+bounces-92599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E928722B1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE3F1F22F9F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1385F1272DD;
	Tue,  5 Mar 2024 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1mEPeM0j"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5B58613F;
	Tue,  5 Mar 2024 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652401; cv=none; b=WW/tT2qhc6auay14oXjTjfioQJqAUMCSZLhYJtz8UX1oCBrSCkjXuAEfk/n/HGOZZjCF1RZvG1/GRT4N6vqNyX8RkGjn8DiVNXsYz/TdA8hLwnmD32nYceLTRUbKIquokPuiXCrV6rw4XQBrfzbfvbcgJiJtFJ2/JUklbxR8YsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652401; c=relaxed/simple;
	bh=J3X4W67bjQqo8Ju8tC3mm7aj1JiGvRSEd9lenlnWcWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TBL8q/JkHIWXbKF5rS3FWPeBC1CKzOskZOtOWRlPRQiFo+iDHT8rPg/JeUg8/XqqrZ1Yop9RBtj04cblumrd/dKNlenuNaPgzjZ1E3RtvR8S609DqA+j9JzNT76bnWP7KkOInbdix/YirMsSd8XYsKVb9fef/LGCaOu7EN4FCFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1mEPeM0j; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709652397;
	bh=J3X4W67bjQqo8Ju8tC3mm7aj1JiGvRSEd9lenlnWcWw=;
	h=From:To:Cc:Subject:Date:From;
	b=1mEPeM0j/k+DUPc+G1g7xMVe/arF5XJLdRg/xGeXDZvpbllXB3tEOmdZBvfHnzSjU
	 7SyevBzvMD9tpppjTzIOY4iyCfGVvKN6QD/C7oFbzxqgrEHOzcq5paFhwIXTJ/rDZW
	 vMQloVHnQsF8+kGjdzXC+gxRQYMnxyB4dRzwA3YeHoEfNlhvW6ZsNH5k4TH2+llDCo
	 bUk2nv0AZkRJ5cnmONgUR2Dhyik64R1GwfT94qNcmpHukwSJU2RGV/GKeCMCcQsZpS
	 0Icc4GjNb7YSNPjeMOCvKtFWaGDXMR+sQ1VUxm4KLPr4y/sn+weckUZL1QMu/3M1Qt
	 UrxWbAUhh05Jw==
Received: from stla-brain-8255-1.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1AF7537813B5;
	Tue,  5 Mar 2024 15:26:37 +0000 (UTC)
From: Julien Massot <julien.massot@collabora.com>
To: linux-media@vger.kernel.org
Cc: kernel@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	sakari.ailus@iki.fi,
	Julien Massot <julien.massot@collabora.com>
Subject: [PATCH v4 0/4]  Add support for MAX96714F and MAX96717F GMSL2 ser/des
Date: Tue,  5 Mar 2024 16:26:04 +0100
Message-ID: <20240305152608.287527-1-julien.massot@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change since v3:
- bindings
  - Renamed bindings to drop the 'f' suffix
  - Add bus type to MAX96717 and remove from MAX9674
  - Add lane-polarities to both bindings

- drivers
  - Address changes requested by Sakari in v3
  - use v4l2_subdev_s_stream_helper for MAX96714
  - do not init regmap twice in the MAX96714 driver
  - Fix compilations on 32 bits platforms

Each patch contains an exhaustive changelog compared to v3.

Krzysztof, I dropped your 'Reviewed-by' since there are some changes
in the binding patches.

Change since v2:
- Convert drivers to use CCI helpers
- Use generic node name
- Use 'powerdown' as gpio name instead of 'enable'
- Add pattern generator support for MAX96714

These patches add support for Maxim MAX96714F deserializer and
MAX96717F serializer.

MAX96714F has one GMSL2 input port and one CSI2 4 lanes output port,
MAX96717F has one CSI2 input port and one GMSL2 output port.

The drivers support the tunnel mode where all the
CSI2 traffic coming from an imager is replicated through the deserializer
output port.

Both MAX96714F and MAX96717F are limited to a 3Gbps forward link rate
leaving a maximum of 2.6Gbps for the video payload.


Julien Massot (4):
  dt-bindings: media: add Maxim MAX96717 GMSL2 Serializer
  dt-bindings: media: add Maxim MAX96714 GMSL2 Deserializer
  media: i2c: add MAX96717 driver
  media: i2c: add MAX96714 driver

 .../bindings/media/i2c/maxim,max96714.yaml    |  169 +++
 .../bindings/media/i2c/maxim,max96717.yaml    |  158 +++
 MAINTAINERS                                   |   14 +
 drivers/media/i2c/Kconfig                     |   28 +
 drivers/media/i2c/Makefile                    |    2 +
 drivers/media/i2c/max96714.c                  | 1028 +++++++++++++++++
 drivers/media/i2c/max96717.c                  |  947 +++++++++++++++
 7 files changed, 2346 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml
 create mode 100644 drivers/media/i2c/max96714.c
 create mode 100644 drivers/media/i2c/max96717.c

-- 
2.44.0


