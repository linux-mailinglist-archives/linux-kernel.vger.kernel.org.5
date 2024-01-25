Return-Path: <linux-kernel+bounces-38065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C16983BA8A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D051F236D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E60882D;
	Thu, 25 Jan 2024 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZsSCh1F"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534878493;
	Thu, 25 Jan 2024 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706167279; cv=none; b=bVfyvAMN4DYS3qZoT3KpKS3I9VPO2ly3gtvgqQxEwWU7QbZeNLp2EceAqYa7N5sH1noB/JacmjTFDnsrFViYP/WMdSJtUNIDhmoqrpJTXHqbbkTiaZcC5zERxZW6+OwsUKBXhvtr+yn4bLOr6LBd/HeUxcHbDiRn0VZv4pSC2so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706167279; c=relaxed/simple;
	bh=VPh9d6Pxp5XZeNDZKQSreVmnAMlM8+t2+Jf9vaXc4/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KITNM5VW2bJbcS2F3i0xcf7Y6Dsnv9xmW+NnEW9Xb6ueZFj3sxl0HNfkgozTzvr1wXS9XpPbgHabLI4//mpYK/VaFPHcYpx8vQPXqQRdX6WhoaqX6AJCYUjnU6DH52zlnQVBTfmWp5yvd6FsMwK2QTdhhV4bMkNR5qmj/DFMMb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZsSCh1F; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so7132875e87.3;
        Wed, 24 Jan 2024 23:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706167276; x=1706772076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rfbdi06WEg6XPP7HBGTF5pjBeEWo6KdfcLseKD4sHZk=;
        b=SZsSCh1FzgeEcCr9DC02GRd+EmI3JXzg2QYSvpr+KR2emjFrplToIw5yXVRdEMUeQr
         6ErLP6ZAPmyN49hN4nxJQlC3QPMjw+H64I3pCx7E+fb2cMaZUwT9ikihYAdVYcuc/gao
         9zn5zlffumFN4sYUWyg+jpV3ad9QqHPQsoMHTZDrNM0QNDJt8y4TL9Jx/n+lt/tC9huo
         7gDEnKVShiDJVE6PeDXWaRhR+M+mb86kDmayxjKk+llymZ7pGW8pLvT0kJlNg5IKoLuX
         lzDp60RxWRUkGe/W7nFemu+a4VrYqTrTDK3wbdRguy34bhNcrRyntpftSOlgBQgev7nd
         3W8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706167276; x=1706772076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfbdi06WEg6XPP7HBGTF5pjBeEWo6KdfcLseKD4sHZk=;
        b=u8Noq/EGAOe3LpKLdT8t1PiyMJGA3QHPK/hsG5JJFggPKQfBBx6OUvZVce3JS2AtJc
         GM7dBGT7v+jKHbjO72HUJ/AqdkMnKE7UdyXMaY+hVecjRqnlAZTpUaBIJRuk2ST1ZZT/
         aCRlYi4QWS/rMY+fFs2HXi8bnvDaNoTC2OqsGuggD/3ijrXIpyBNRMNk+mrDp6DuC4Oj
         pIC8IAItFhujoKXVvUDPtsa2SHsf/vPUwdzmGrViGhsqUrpUEIM+HqZDDO1AY9wvaX2/
         IbOcGJLLqhRREmh5Rv9T7YeqDwh1qBehGVKp9B8wETBm29TFYsNMNbP61AkBVo/mY3Mk
         4CsQ==
X-Gm-Message-State: AOJu0YySr0dNrX+HulgPEcBMdbFPFQsSLRzOppC9IUW89f75sOGI9edv
	9J/oK3a4wwOLq2dpOIfwFD0i+PEiHxUztDYZ96z+9sP931YzLUDN6f6E4lWCCZRx7Nw=
X-Google-Smtp-Source: AGHT+IHuzdCwXXJzzYZ0ZphpiXZChO5Xnkj9g1TvGPwPEf24LwgoMu6D+BEIIOzw2PpSJNXyoPZbwA==
X-Received: by 2002:ac2:54a7:0:b0:50e:7c70:f8da with SMTP id w7-20020ac254a7000000b0050e7c70f8damr216409lfk.16.1706167275400;
        Wed, 24 Jan 2024 23:21:15 -0800 (PST)
Received: from localhost.localdomain ([188.162.200.139])
        by smtp.gmail.com with ESMTPSA id x37-20020a056512132500b0050e75f9e8c8sm2780070lfu.98.2024.01.24.23.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 23:21:15 -0800 (PST)
From: Aleksandr Shubin <privatesub2@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Aleksandr Shubin <privatesub2@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andre Przywara <andre.przywara@arm.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	John Watts <contact@jookia.org>,
	Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH v7 0/3] Add support for Allwinner PWM on D1/T113s/R329 SoCs
Date: Thu, 25 Jan 2024 10:19:40 +0300
Message-Id: <20240125072032.1151383-1-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds support for PWM controller on new
Allwinner's SoCs, such as D1, T113s and R329. The implemented driver
provides basic functionality for control PWM channels.

v2:
 - fix dt-bindings
 - fix a remark in the driver

v3:
 - fix dt-bindings
 - fix sunxi-d1s-t113.dtsi

v4:
 - fix a remark in the driver

v5:
 - dropped unused varibale in the driver
 - fix dt-bindings

v6:
 - add apb0 clock

v7:
 - fix a remark in the driver
 - add maintainer

Aleksandr Shubin (3):
  dt-bindings: pwm: Add binding for Allwinner D1/T113-S3/R329 PWM
    controller
  pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
  riscv: dts: allwinner: d1: Add pwm node

 .../bindings/pwm/allwinner,sun20i-pwm.yaml    |  88 ++++
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  12 +
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sun20i.c                      | 380 ++++++++++++++++++
 5 files changed, 491 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
 create mode 100644 drivers/pwm/pwm-sun20i.c

-- 
2.25.1


