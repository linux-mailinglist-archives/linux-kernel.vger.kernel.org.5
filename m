Return-Path: <linux-kernel+bounces-1902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A999815585
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49091F25A5B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F23B749B;
	Sat, 16 Dec 2023 00:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dor0919s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366815675;
	Sat, 16 Dec 2023 00:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40c2718a768so11796825e9.0;
        Fri, 15 Dec 2023 16:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702686186; x=1703290986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=I2cQQHTukUtPE/uR7ah1Fmgn0krkwrRifPUQAFLRAB0=;
        b=Dor0919sjHLJZ4NqGrIyvh5qAm604y+rPPova9ukVvqF8ot6P3u4/aSWfdxNt6MMrW
         Qk3hO0Xzzezv/lVwrW7wCVZb7/4SGQ67Yaq9SjpvoQKNmtMKmTbmttSStdxC1ximohl3
         S5B3hX+K5ghei03lPaS3V4D6xKxrF87pZqa3j2MmP96pWRENWoZKdL4r4cn+w2Bdqz4t
         g6c8+Yu0jL2UFCqQ9p4yw57kR8RzSEyVkVFtbfrIEFQNv0ZccibiSYugkD7c0/LOh+R2
         Gk9OU8mNsB5vr4x+V4YC7Qb68h+8C5hP3dHbePY4WQljEdbwNu6z3/u5MO31sU1rjqeE
         IBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702686186; x=1703290986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I2cQQHTukUtPE/uR7ah1Fmgn0krkwrRifPUQAFLRAB0=;
        b=u0+7sde2nXevrTax6Y2YiDca6Vz8UZVb8DKEVN3+4gERtLMm8SFyo2ZpYiKk+lUNCu
         EL+mA0kDaMSoYtQz2JtQ8bHcWnMmr2ImywXDFuTgJy3p6L3Oz+FtNISusdCBAJw2W/bM
         XDbdvK0pzBQ4qwtBLFWrqIC7qw6e51bJ0D/GGTc3OI5w0DTEV8BpKrNnfTWcFpu+9uYX
         E0ikI0j0GKCYC8lBFXAUh/2nWWR9JpMpSdV9CAcUK053bE8iCl6z2Xu+FsOcTIa/YexB
         4cOSyZOA543X5cVTgxfDxU2BNaoT0TNSvXIjcjxtL21Q93X7JC8GPCjlUEBMQcFvXwC7
         jCpA==
X-Gm-Message-State: AOJu0YwY1UCs1ipdTjMuk3yyK63AVggP72/61NLE/p7U8x5hMC8aZJsg
	Q3QN5jE/zwso21Gx4UB99qc=
X-Google-Smtp-Source: AGHT+IF+9FqV+Lr9UMveMWtugElQgByzvoxFfDjtG/GBrvhJpi0XjLDpI57BBQHWqDolF7Z7Gqy9NA==
X-Received: by 2002:a7b:c7ca:0:b0:40b:5e1b:54ac with SMTP id z10-20020a7bc7ca000000b0040b5e1b54acmr7682448wmk.56.1702686186209;
        Fri, 15 Dec 2023 16:23:06 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id a15-20020a5d508f000000b0033330846e76sm1496191wrt.86.2023.12.15.16.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 16:23:05 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tobias Waldekranz <tobias@waldekranz.com>
Subject: [net-next PATCH v4 0/4] net: phy: generic polarity + LED support for qca808x
Date: Fri, 15 Dec 2023 22:22:40 +0100
Message-Id: <20231215212244.1658-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series add LEDs support for qca808x.

Qca808x apply on PHY reset a strange polarity settings and require
some tweak to apply a more common configuration found on devices.
On adding support for it, it was pointed out that a similar
feature is also being implemented for a marvell PHY where
LED polarity is set per LED (and not global) and also have
a special mode where the LED is tristated.

The first 2 patch are to generalize this as we expect more PHY
in the future to have a similar configuration.

The implementation is extensible to support additional special
mode in the future with minimal changes and don't create regression
on already implemented PHY drivers.

(changelog present in single patch)

Christian Marangi (4):
  dt-bindings: net: phy: Document new LEDs polarity property
  net: phy: add support for PHY LEDs polarity modes
  dt-bindings: net: Document QCA808x PHYs
  net: phy: at803x: add LED support for qca808x

 .../devicetree/bindings/net/ethernet-phy.yaml |  11 +
 .../devicetree/bindings/net/qca,qca808x.yaml  |  54 +++
 drivers/net/phy/at803x.c                      | 308 ++++++++++++++++++
 drivers/net/phy/phy_device.c                  |  45 +++
 include/linux/phy.h                           |  25 ++
 5 files changed, 443 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qca,qca808x.yaml

-- 
2.40.1


