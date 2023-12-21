Return-Path: <linux-kernel+bounces-7933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DFE81AF6A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE50285F12
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A841414262;
	Thu, 21 Dec 2023 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZA9iBKCx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D0213FF4;
	Thu, 21 Dec 2023 07:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e239c49d0so630603e87.2;
        Wed, 20 Dec 2023 23:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703143749; x=1703748549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0No83KHRxx6gjMj4IekluccYziFPxXT8Pkn9VDLDyM=;
        b=ZA9iBKCxOagiEWXueJbHZ0JMx0NxCdF9vBtI3elwlgj/cZaY8351YrEl2k2kUPB4Ya
         AvGtU/x6ZHfqMlExpcL6mTvTYZtBvJowytNLW80HDsmrX6a5kOx9ExT+AWRpg6QeWJ4E
         lVh6+jGR85aM7jAc4mr6pAlkibso1jeo7SIG0ioZq+tIfZkKQ5ht725Z4CV6uHYE1oio
         lmimrA64DZbabYX6cGpoMf6AlUnR1RbJEC1xzJb3kon7nyMH1LoQ8x8W0Fjg0Iueaawv
         85s/y9LQ+BFLBzboNqj7iboFhip661vLuKPj4diZ8iwmCRKh9+eoNOv07n8UJUa3o8EQ
         hP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703143749; x=1703748549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0No83KHRxx6gjMj4IekluccYziFPxXT8Pkn9VDLDyM=;
        b=KYahV+P5Pox9ppPkeq0CwGyB9Un1NTciIE+WuwoN21Y708s1bwewDNvgsOgR5ZXMT/
         qhKe5SUX4SZxsMQJy6i9qKvnFk7URpMFPUeR2E0GpWPStwF0GwZJcRme+YCG+wYnXNMP
         CCDW5XOh+urNZKyvmw/q+waESAWBaCf/KzUlJsYLQNHM8GTK/FTVot/dhUiuwYKtNuEp
         W8IFGWxj4rBHq4xglQIUHaR3c6lwkb7F1zgiQLHpBKFxpF5rFCIvtgxZqnAJ/KWn/HLa
         KYmCJGF5h8A2kdyPqNIdVCc4NqIbWyuguZQWrCzPBoVzzaV9nJQSa/2cMnFJUv9BfILr
         dsgg==
X-Gm-Message-State: AOJu0YwoztGOx90aw9uSqUprnX+ISgplpXBSYVFSYhGwY9BUCNe/XlNU
	Lisw+ZsUHI21PwRTfv09+Us=
X-Google-Smtp-Source: AGHT+IHqgoIDduubkU20lWNfO6nh6Nl0tNfJjOAk9HI11dskd4f4tcFqPxuJYYmCFj10/NAw1Nek2w==
X-Received: by 2002:ac2:46e9:0:b0:50e:3cc7:7ff9 with SMTP id q9-20020ac246e9000000b0050e3cc77ff9mr2879635lfo.135.1703143749497;
        Wed, 20 Dec 2023 23:29:09 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id en22-20020a056402529600b00553830eb2fcsm787819edb.64.2023.12.20.23.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 23:29:09 -0800 (PST)
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
Subject: [PATCH v3 0/4] net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2220 PHY
Date: Thu, 21 Dec 2023 08:28:47 +0100
Message-Id: <20231221072853.107678-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219093554.GA6393@debian>
References: <20231219093554.GA6393@debian>
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

Dimitri Fedrau (4):
  net: phy: Add BaseT1 auto-negotiation constants
  net: phy: Support 100/1000BT1 linkmode advertisements
  net: phy: c45: detect 100/1000BASE-T1 linkmode advertisements
  net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2220 PHY

 drivers/net/phy/marvell-88q2xxx.c | 310 ++++++++++++++++++++++++++++--
 drivers/net/phy/phy-c45.c         |   3 +-
 include/linux/marvell_phy.h       |   1 +
 include/linux/mdio.h              |   8 +
 include/uapi/linux/mdio.h         |   2 +
 5 files changed, 312 insertions(+), 12 deletions(-)

-- 
2.39.2


