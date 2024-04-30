Return-Path: <linux-kernel+bounces-163987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E57D8B76D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDBFA2839E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2452171E7D;
	Tue, 30 Apr 2024 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2FRRSI97"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59732171E49;
	Tue, 30 Apr 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483234; cv=none; b=RZcxYVIgB9LBNVVp/pklICeYTUob943GBaq5marRora/JscYkteSZ5YANRxX8AgUKYllDf1VsveXUuBi8zw0SXyou+w1feTlwoh+CNHQQTi5FTvP1CNym99PhM9oHUExGuH2C9HlsfVAivBhHXCSkO9SU3q8rijNSw18IBKGUEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483234; c=relaxed/simple;
	bh=F7Xc0i5LqTLUVcR9pEW59UMkv6QivjdXaw/5qjYRNRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQ4s3el1nCDVj91LxWmmD9F0SjpiJcnCm/Ih0RrGL9nngXHnAFFkDBoJsATH071e/fKdln6Vo1aZUkIvDcL1F/NerVNd+vT/JWB29I2k5psbxWht51dzRLjITwAn2M1R5wGD0Xy1qNTCho7xFySm6S9AoJPsrFQtO2AqEc4bUQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2FRRSI97; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714483231;
	bh=F7Xc0i5LqTLUVcR9pEW59UMkv6QivjdXaw/5qjYRNRc=;
	h=From:To:Cc:Subject:Date:From;
	b=2FRRSI97EyrjLf6V/HzElSGlP6DxmuRR3fimjBPDltPbzbX8opYM9qzG1IvHSf97I
	 6e1CkM3HS06J4ApHqhNLWBvmFVr8CIHGrYGKNnvR9WwmC48FzmrTGtYrMX/Xw6CEtX
	 RrFi5ZB2+5LBLljd+KWX71ciC4LYHFm+eRFp8KJveHQ8pISGOjMDTWODCUXnPE0LwP
	 8Oj5NVFj1KKDOUeRIM5dn6LBLNNaUtRZl5JxfS3AhR4AxpnYoxkj0YqwhYrhWnsDSv
	 JQ8Bgh+E/d6ArxPuVi20LO3H0cV4t0Z1nB3+ULeZlAi+g4UpWP6l6/pphVffx7B8RE
	 UEpn2JcpmFQqA==
Received: from apertis.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BC2F137813E3;
	Tue, 30 Apr 2024 13:20:30 +0000 (UTC)
From: Julien Massot <julien.massot@collabora.com>
To: linux-media@vger.kernel.org,
	sakari.ailus@iki.fi
Cc: devicetree@vger.kernel.org,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Julien Massot <julien.massot@collabora.com>
Subject: [PATCH v7 0/5] Add support for MAX96714/F and MAX96717/F GMSL2 ser/des
Date: Tue, 30 Apr 2024 15:19:26 +0200
Message-ID: <20240430131931.166012-1-julien.massot@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change since v6:
  - Remove mention of C-PHY for MAX96717, this serializer is D-PHY only
  - Remove bus-type requirement for MAX96717
  - Minor changes requested by Sakari
  - Workaround a MAX96717 issue, which occurs when stopping
    the CSI source before stopping the MAX96717 CSI receiver.

Power management is not included in this patchset. The GMSL link is
not always resuming when the deserializer is suspended without
suspending the serializer.

Change since v5:
 - Reverse fallback logic: max9671{4,7} can fallback to max9671{4,7}F
 - use const instead of enum for max9671{4,7}f compatible as suggested

Change since v4:
 - Add support for MAX96717 and MAX96714 and use them as a fallback for
   MAX96717F and MAX96714F respectively
 - The drivers are now compatible with MAX96717 and MAX96714 since no change in
   the logic is needed
 - Reference 'i2c-gate' instead of 'i2c-controller' in the bindings

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

Julien Massot (9):
  dt-bindings: media: add Maxim MAX96717 GMSL2 Serializer
  dt-bindings: media: add Maxim MAX96714 GMSL2 Deserializer
  media: i2c: add MAX96717 driver
  media: i2c: add MAX96714 driver
  drivers: media: max96717: stop the csi receiver before the source

 .../bindings/media/i2c/maxim,max96714.yaml    |  174 +++
 .../bindings/media/i2c/maxim,max96717.yaml    |  157 +++
 MAINTAINERS                                   |   14 +
 drivers/media/i2c/Kconfig                     |   34 +
 drivers/media/i2c/Makefile                    |    2 +
 drivers/media/i2c/max96714.c                  | 1024 +++++++++++++++++
 drivers/media/i2c/max96717.c                  |  927 +++++++++++++++
 7 files changed, 2332 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml
 create mode 100644 drivers/media/i2c/max96714.c
 create mode 100644 drivers/media/i2c/max96717.c

-- 
2.44.0


