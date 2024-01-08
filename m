Return-Path: <linux-kernel+bounces-19283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BB0826AD9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2AD1C21E9D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977FB11C89;
	Mon,  8 Jan 2024 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nol5DFi3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7590A11C80;
	Mon,  8 Jan 2024 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a1915034144so154313166b.0;
        Mon, 08 Jan 2024 01:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704706721; x=1705311521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8kouE5CSPn3gRjysvgQti+N33ar0nrWwuJLOe8A2Fqk=;
        b=Nol5DFi3RFfih72psui7aa7Okoq/bL8u8BkunJ4rAyI1VwJ9t92/fQC6bGCu8/tpZQ
         6raE5Qx4bSj355HIkDJR8hIwS5LTeGq+YW24dHYPW+OxcuruEbaB1CJHiGJo09HAZvaM
         1NX2f2d9h71S/thWUs+SvpyFSbgRD/aCotz1ZlW7v3bYbVUasG6SnU0sXFKLXEjgxdQL
         /2F2FH+ECV3kA0fmoomoDZnfiPBwDKH3f6EniG29ycIDDDMQsr0OSLmkvZ+HgJWYrUeN
         0EKoU681ODho9KIcobdhj58RViFA3dvtyQxGnQroPGAz6qbzuXELKw9k7r9ywcOdEwNf
         uVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704706721; x=1705311521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kouE5CSPn3gRjysvgQti+N33ar0nrWwuJLOe8A2Fqk=;
        b=lmBB/GrUj3fSJkVBXnYEb7HfU+i7zcQ2xY6xTzWTKfVG7Y9xnG+ZhnZ1t0jyOxVYey
         c8pd9ZCG1XA+TXrOCTwO6+ggCSzh2Swmw7Pqx4vrS6XzGd63x3g8mgl0aSwr7Po70CTc
         XLdo9xEfPhI6Gaj5t/vWLDrj1ZsSWm8KYmhn0sHKKhXejkRf8el8oQkhKmCFNKInDIN2
         VwNZXaDWzyJiuoZK+6BFvad1ZCedaPORy0drpdHB6o/Sdz9oE7/GdveqmyfgvbrA2HcO
         PqFacZKZs+48w17Fw1BnEwO1r+s/Tnz0rJQOeU0v9ToilNeovLaMud4Zoyhm+6EAluOL
         fdzA==
X-Gm-Message-State: AOJu0YwnQgxxBmA6z4kAvyU6zKy7jPOqKJ/x6CkdIeKkQVOrYQX87oQ+
	7AZPISIKSPpv4mfFnA1FD9bBXLsgUdpZ6Q==
X-Google-Smtp-Source: AGHT+IG1Gj3k1fwYTeUo3sjPYA3x1PvEPwE3MXpj2xrTPSUpmRZTIGdK+M2DrVeo014egn2MePsMkQ==
X-Received: by 2002:a17:907:9909:b0:a28:e67e:9b36 with SMTP id ka9-20020a170907990900b00a28e67e9b36mr1335114ejc.102.1704706720565;
        Mon, 08 Jan 2024 01:38:40 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906338c00b00a2ae71cee2asm326851eja.177.2024.01.08.01.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:38:40 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 net-next 0/5] net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2220 PHY
Date: Mon,  8 Jan 2024 10:36:55 +0100
Message-Id: <20240108093702.13476-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
	- used defines MDIO_CTRL1_LPOWER and MDIO_PMA_CTRL1_SPEED1000
	  in mv88q222x_config_aneg_preinit
	- use genphy_c45_loopback
	- mv88q2xxx_read_status reads speed, master or slave state when
	  autonegotiation is enabled
	- added defines for magic values in mv88q222x_get_sqi

Changes in v3:
	- mv88q2xxx_read_status includes autonegotiation case
	- add support for 100BT1 and 1000BT1 linkmode advertisement
	- use mv88q2xxx_get_sqi and mv88q2xxx_get_sqi_max, remove
	  mv88q222x_get_sqi and mv88q222x_get_sqi_max
	- fix typo: rename mv88q2xxxx_get_sqi and mv88q2xxxx_get_sqi_max to
	  mv88q2xxx_get_sqi and mv88q2xxx_get_sqi
	- add define MDIO_MMD_PCS_MV_RX_STAT for magic value 0x8230, documented
	  in latest datasheets for both PHYs

Changes in V4:
	- clean up init sequence
	- separate patch for fixing typos in upstreamed code

Dimitri Fedrau (5):
  net: phy: Add BaseT1 auto-negotiation constants
  net: phy: Support 100/1000BT1 linkmode advertisements
  net: phy: c45: detect 100/1000BASE-T1 linkmode advertisements
  net: phy: marvell-88q2xxx: fix typos
  net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2220 PHY

 drivers/net/phy/marvell-88q2xxx.c | 234 +++++++++++++++++++++++++++---
 drivers/net/phy/phy-c45.c         |   3 +-
 include/linux/marvell_phy.h       |   1 +
 include/linux/mdio.h              |   8 +
 include/uapi/linux/mdio.h         |   2 +
 5 files changed, 230 insertions(+), 18 deletions(-)

-- 
2.39.2


