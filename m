Return-Path: <linux-kernel+bounces-7415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F8681A7A8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BFE2846B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFA21DFE2;
	Wed, 20 Dec 2023 20:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xny6pLVy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027DB41A85;
	Wed, 20 Dec 2023 20:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d12b56a38so1024085e9.2;
        Wed, 20 Dec 2023 12:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703104570; x=1703709370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gab6lAEWInYI2on8pVOUw7Ug3N1N4atZPO1lxaglfow=;
        b=Xny6pLVyT/POOku9vpBsQnnMlPvsIvDNEXfrg+VkCIwcz/MeP8u3laZhnQQYF3PhcJ
         cdHdJEbtA0fzgxW4viy9MQVzZ7rjxicTSD9g11laUkWS4lfN1oRLaO0Ing0HIxC2Ccf8
         /Aso2spqRaOLtquyKSu1scY3xMHvKB4h99tfC+XKL3/sBeEX4K29qpRQ5XOEf+0hwFG/
         sh1tZlsPn9ycOaYhhUAAm413ZMt82o/epLMz2pm0n+3xblXyoF33JUkomWHzEZY0Wpl1
         UvKko7o6ynTWWPx6FgNNruqLM5UcicNy3rk//HyZH+T3u0dK1kkr0sUcHJ1Q9M1PMiN8
         utLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703104570; x=1703709370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gab6lAEWInYI2on8pVOUw7Ug3N1N4atZPO1lxaglfow=;
        b=VNU65rOgZIAebutIHTO5dtar9XypnDNpUxv0bLp6x5+hAeacNw7esbDrhRasfg7+mu
         6cA1s0cj5inbt+2VfOCb4bOH9ijjjHo8z+pMKuisUmqb2fNqU60YKnO8FGW2rW8fIMR6
         j++SgxyfhEn+GyHsn/AoPIe0tfn9r+4KjiBEJFRLHGBC4/aO6AE/7Pd/eAuugfo2uYiG
         NVDxiDmTr7e9eg+loyi5VFodl82tqYZwMUP7lCBFMPBSto08n1XzcOT/5iampIsjn6Nk
         NWaiSwPwsogE8RUX43u7BIndzUIXdSNRAQcMabLo7vtLtzOUH5A1T6CW7/baWHpCzElb
         2oxA==
X-Gm-Message-State: AOJu0Ywd/1wrBzUoMdvNAS6lMp2kfBDYisC5MEnKlDgN1vqLeV9zobx/
	m89wCs3dwi4EA8QEBDyTjog=
X-Google-Smtp-Source: AGHT+IG7/pATF5SbDyVvRmck3xB4G+FEKhoLKpI3NCY4qj24Tl8dGaUxllvbsMityLj5lXSpUtPePA==
X-Received: by 2002:a05:600c:1387:b0:40d:1a5f:8abd with SMTP id u7-20020a05600c138700b0040d1a5f8abdmr64059wmf.291.1703104569941;
        Wed, 20 Dec 2023 12:36:09 -0800 (PST)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id v14-20020a05600c444e00b0040c58e410a3sm8703224wmn.14.2023.12.20.12.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 12:36:09 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	wens@csie.org,
	samuel@sholland.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v5 0/3] arm64: add ethernet to orange pi 3 & one plus
Date: Wed, 20 Dec 2023 21:35:34 +0100
Message-ID: <20231220203537.83479-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is continuation of the work done by Corentin:
https://lore.kernel.org/linux-sunxi/20221115073603.3425396-1-clabbe@baylibre.com/

In short, Orange Pi 3 and Orange Pi One Plus boards have ethernet PHYs
which are powered by two voltage regulators. They have to be powered on in
correct order or otherwise they are not functional. Please see link above
for previous discussion on how to achieve that.

Best regards,
Jernej

changes since v1:
- Add regulator_bulk_get_all for ease handling of PHY regulators
- Removed all conversion patches to keep DT compatibility.

Changes since v2:
- removed use of regulator-names and regulators list.

Changes since v3:
- fixes kbuild robot report

Changes since v4:
- dropped merged patches
- reworked PHY powering on/off patch
- added Orange Pi One Plus patch, since it has same issue

Corentin Labbe (1):
  phy: handle optional regulator for PHY

Jernej Skrabec (1):
  arm64: dts: allwinner: orange-pi-one-plus: Fix ethernet

Ondrej Jirman (1):
  arm64: dts: allwinner: orange-pi-3: Enable ethernet

 .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 40 ++++++++++++++
 .../allwinner/sun50i-h6-orangepi-one-plus.dts | 29 +++++++---
 drivers/net/mdio/fwnode_mdio.c                | 53 ++++++++++++++++++-
 drivers/net/phy/phy_device.c                  |  6 +++
 include/linux/phy.h                           |  3 ++
 5 files changed, 122 insertions(+), 9 deletions(-)

-- 
2.43.0


