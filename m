Return-Path: <linux-kernel+bounces-22145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F15268299F4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDEE21C215DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120C9482C3;
	Wed, 10 Jan 2024 11:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHDqerK7"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D275A47F7A;
	Wed, 10 Jan 2024 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e5508ecb9so11459775e9.3;
        Wed, 10 Jan 2024 03:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704887873; x=1705492673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VmiLt44BBIGX7+/Kr067RQ8AjOyThzAc6HnwtGL3adk=;
        b=QHDqerK7grmlo2hxhiGv7yljPa6Wg3MaRd8r/nPswBy+kuU9Pw31FSgY+p7QwHF1Jg
         j1pB0e5m1CCeooo4KcEb1g71QOVYY8qft3QXB4cdSDNkYbhxaqF3M9JlDdVdYWsFyYmm
         2J9G8o+qc7as6XhA6RfW3KIAACx8ok+1PhxgKNX/xYzn4FOvTQipsdeDnrgbL+Vt1Sv0
         KWzTUCuDW7xrWzp2D3b/i/3yDtqKD0N/OLDame2NnYtplCR3ZQ2H6JDlk59uQ5HPlc69
         r0wtvPC8R8cPUl4vvqalBKHSHG0LCz4UDAJ+e4l3nXtuW3U5uSTDDRiS+vFgbnp2blPS
         PytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704887873; x=1705492673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmiLt44BBIGX7+/Kr067RQ8AjOyThzAc6HnwtGL3adk=;
        b=juoZUnOa2+b3pDF/w5SpNgZHGBmXQM203trF5HyIBAQtdUcGgsD/ueXXa5dLIzuug3
         Wh5XWFJbLZPN9Q/kNl1wMQKATNYGLMvhKWf3a0Ny9YtL0xdthWhzkhyhXNLjSaUmKiel
         fLyolTWYPiLbnzoWdnsvIzAnLzy75qlF2Ba2SdYdJMUbGT0Hfxms4oRuvBTAwoGlPGbj
         bJt0mBZIIC5CyS0njQqfUHe7qkO/OLqrHhOz8gajb/Ac5zB/fbb551wAvEnioDkAFiuU
         lv2Jn16zt+gWVKzNCQ68Ah5Z3GG6X+0mldT6iORRR8Htk35yvHdK4ehGFjOrJDi+upBM
         dVpw==
X-Gm-Message-State: AOJu0Yy1oVIhcFwQqULRPMxbAi9ZOO3+6JBVVO3Yy4kehpDe1K34FZb8
	MfWBVq0YdHo9RFJv1cw6lQY=
X-Google-Smtp-Source: AGHT+IGuzbNI2Scm2re8bIAeZQDghXQWwwz53yu7mEA1YkjKYKgqc5t0SIG5uI0slY60bOsnh1LYCg==
X-Received: by 2002:a05:600c:3acd:b0:40d:7259:4730 with SMTP id d13-20020a05600c3acd00b0040d72594730mr567427wms.58.1704887872772;
        Wed, 10 Jan 2024 03:57:52 -0800 (PST)
Received: from localhost.localdomain ([78.209.40.150])
        by smtp.googlemail.com with ESMTPSA id f17-20020a05600c155100b0040d62f89381sm1962136wmg.35.2024.01.10.03.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 03:57:52 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next RFC PATCH 0/5] net: phy: split at803x
Date: Wed, 10 Jan 2024 12:57:30 +0100
Message-ID: <20240110115741.17300-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(This depends on [1] that has been fully reviwed but still
has to be merged in net-next)

This is the last patchset of a long series of cleanup and
preparation to make at803x better maintainable and permit
the addition of other QCOM PHY Families.

A shared library modules is created since many QCOM PHY share
similar/exact implementation and are reused.

After this patch, qca808x will be further generalized as LED
and cable test function are also used by the QCA807x PHYs.
This is just for reference and the additional function move will
be done on the relates specific series.

[1] https://lore.kernel.org/lkml/16cf006b-e9fe-4e09-b58d-49ce19c09879@lunn.ch/T/

Christian Marangi (5):
  net: phy: move at803x PHY driver to dedicated directory
  net: phy: qcom: create and move functions to shared library
  net: phy: qcom: deatch qca83xx PHY driver from at803x
  net: phy: qcom: move additional functions to shared library
  net: phy: qcom: detach qca808x PHY driver from at803x

 drivers/net/phy/Kconfig             |    7 +-
 drivers/net/phy/Makefile            |    2 +-
 drivers/net/phy/at803x.c            | 2757 ---------------------------
 drivers/net/phy/qcom/Kconfig        |   22 +
 drivers/net/phy/qcom/Makefile       |    5 +
 drivers/net/phy/qcom/at803x.c       | 1142 +++++++++++
 drivers/net/phy/qcom/qca808x.c      |  934 +++++++++
 drivers/net/phy/qcom/qca83xx.c      |  275 +++
 drivers/net/phy/qcom/qcom-phy-lib.c |  429 +++++
 drivers/net/phy/qcom/qcom.h         |  118 ++
 10 files changed, 2927 insertions(+), 2764 deletions(-)
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


