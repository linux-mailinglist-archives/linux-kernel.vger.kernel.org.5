Return-Path: <linux-kernel+bounces-41609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8C483F554
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 13:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694851C20BCB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD2420B10;
	Sun, 28 Jan 2024 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vu0hDtVN"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4498523741;
	Sun, 28 Jan 2024 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706443502; cv=none; b=OtXW+rI8dKfm/AI1YC6gvNIcy56smsZ0UZnlZ7CcZf1RWDdtFg3UCaH7UwRcB75uaZnZwjhz758s7DEkH2A39r5jOE6yTtSLtfC/B4YY315crkCol34/p4lrM6byvw28i3rXVFl3dSqMYx733ux05/+RCeIusHxnpachHuJWUho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706443502; c=relaxed/simple;
	bh=9CbGrdI9JPoS6wbEDQZo48l0teEnfrYuvfBrz6Ww+VI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=poZDxXzzRrl5NFuFWTyV/LqBLDJ1IZF63NwHxKaBjEz2k4/NumVS7JIzWgpKHKfW4/Yqwc+6wQ48iBBR6ebLFEQxisPrhpuPXAqlSqHjalkePRtp1FMmM74fnA4YjgAl9RUm1FiNKyyqk6EBDXrkUDcWsOQ7YtBVd1BE0V1Qbkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vu0hDtVN; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3394bec856fso1654050f8f.0;
        Sun, 28 Jan 2024 04:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706443499; x=1707048299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8526VyeYHi8h135m9aHulwM3wCSi9JY+wy/BfAR44Qc=;
        b=Vu0hDtVNOUs+BR4hR/pSZUvTPT+NuyXjVzHzbHShCM71UwAR4CRiq8+y+KB+xwqEJI
         l8rpqMSO8pcmCYN6Wy9mAqUjtY+9clUha1h1skgkVtZi/w8NA/f6/Spz+EuHuiXZAkuT
         NkuXCvdFAM0B5FNIFqgF9SkkyLYMqBeYWE8yTQXQ22icd/XjwExyLtVF7cG4seMzI8SX
         xIl9NA6Mvr9KA8ltfHsz17evAqp49mxeJSrQ9xV8EVD0pImTEn0Zf63fC3DlcOKZUoNi
         D12I7lspQBx3LDFVW0uZv2aDzRFw25TaGZT+2Yw3uVHPwa/bmvzfmoPNEUUQ9dM+2M02
         QZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706443499; x=1707048299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8526VyeYHi8h135m9aHulwM3wCSi9JY+wy/BfAR44Qc=;
        b=dzjvud7ZWf3jwYLKbFGWhCvVYnG8qvo4Y+KgypRA15xln93CBqwhrx9ek8k3Rnx8tY
         2isMZBPYGANMX/uJ0p2LUOyA/PFP89JA8TD49Tuyn/WPhxMMVHBE7S0ERYPwRadwPGJ0
         knC45TfMYKITtC1JHd4IB5u1BSXW+Hwa0gxofLrbTxyoNB1tdmdrVsha6uxhrb67Iucu
         9VppmrFtU4f7uUqENoSiSxg9R3IOVzaVcIahp5yWTnzt90K0yKDvlvgJxH4T0QUhURIC
         5oY6KdjDcD2uRSyx6VnT7tgaxjjaK58AvHMO2AqkMFVEPQKg/x+Q5PGnS2C3F+oULFTz
         G02Q==
X-Gm-Message-State: AOJu0YzVGvnO5Bl3YNpcrApNijzarpfJLfiLnG5qxY9vA1GVKploKIEt
	HZCdZ+vhjECB6RHsi3FAKs5q2jYytKh3K8x6QWrDPg7pGvq19VHk
X-Google-Smtp-Source: AGHT+IFDQ1PvpJtRQcOjopl54qIzxgACQOr4YwRtcvX9EzsyLdnW3mvaD9HhaBTQ6OeEChLDF3xDhg==
X-Received: by 2002:adf:ec10:0:b0:337:bfca:bd26 with SMTP id x16-20020adfec10000000b00337bfcabd26mr1873676wrn.26.1706443499122;
        Sun, 28 Jan 2024 04:04:59 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id v1-20020a5d59c1000000b0033aeab6f75fsm1110034wry.79.2024.01.28.04.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 04:04:58 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v3 0/5] net: phy: split at803x
Date: Sun, 28 Jan 2024 13:04:21 +0100
Message-ID: <20240128120451.31219-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the last patchset of a long series of cleanup and
preparation to make at803x better maintainable and permit
the addition of other QCOM PHY Families.

A shared library modules is created since many QCOM PHY share
similar/exact implementation and are reused.

This series doesn't introduce any new code but just move the
function around and introduce a new module for all the functions
that are shared between the 3 different PHY family.

Since the drivers are actually detached, new probe function are
introduced that allocate the specific priv struct for the PHYs.

After this patch, qca808x will be further generalized as LED
and cable test function are also used by the QCA807x PHYs.
This is just for reference and the additional function move will
be done on the relates specific series.

This is also needed in preparation for the introduction of
qca807x PHYs family and PHY package concept.

Changes v3:
- Fix compilation error on testing single change till
  patch 4. (improve bisectability of the series)
Changes v2:
- Out of RFC (at808x dependency got merged)

Christian Marangi (5):
  net: phy: move at803x PHY driver to dedicated directory
  net: phy: qcom: create and move functions to shared library
  net: phy: qcom: deatch qca83xx PHY driver from at803x
  net: phy: qcom: move additional functions to shared library
  net: phy: qcom: detach qca808x PHY driver from at803x

 drivers/net/phy/Kconfig             |    7 +-
 drivers/net/phy/Makefile            |    2 +-
 drivers/net/phy/at803x.c            | 2759 ---------------------------
 drivers/net/phy/qcom/Kconfig        |   22 +
 drivers/net/phy/qcom/Makefile       |    5 +
 drivers/net/phy/qcom/at803x.c       | 1140 +++++++++++
 drivers/net/phy/qcom/qca808x.c      |  934 +++++++++
 drivers/net/phy/qcom/qca83xx.c      |  275 +++
 drivers/net/phy/qcom/qcom-phy-lib.c |  429 +++++
 drivers/net/phy/qcom/qcom.h         |  120 ++
 10 files changed, 2927 insertions(+), 2766 deletions(-)
 delete mode 100644 drivers/net/phy/at803x.c
 create mode 100644 drivers/net/phy/qcom/Kconfig
 create mode 100644 drivers/net/phy/qcom/Makefile
 create mode 100644 drivers/net/phy/qcom/at803x.c
 create mode 100644 drivers/net/phy/qcom/qca808x.c
 create mode 100644 drivers/net/phy/qcom/qca83xx.c
 create mode 100644 drivers/net/phy/qcom/qcom-phy-lib.c
 create mode 100644 drivers/net/phy/qcom/qcom.h

-- 
2.43.0


