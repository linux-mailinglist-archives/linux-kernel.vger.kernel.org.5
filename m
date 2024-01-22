Return-Path: <linux-kernel+bounces-34180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37E2837548
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59F381F280F3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B734C481A3;
	Mon, 22 Jan 2024 21:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VI5dgmGJ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DD847F6B;
	Mon, 22 Jan 2024 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705958973; cv=none; b=n3tjCk+vuN/6ojgtWog0NaOE2RQvYIVPLdevWLDzByxDO2q4xfnBGyFaLFqUT1c5E3/ISN611iDqoGp2Hclty7Oq7FTTjKyOlrivZZtrzJx1bGWUY6AohR48gvuqhOXj0ZT9JTeuydLPmeC4Mg5W1Ww58LmsTbwo5B3pfY2lqLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705958973; c=relaxed/simple;
	bh=8coC5yzndgmW8NHa94Ly/wQqor0u5naA8znjh3t16Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R7BhQwph9Q92J4LiNQ+6x4D3zzv6uuYP2BP+cMOKH45+0uWYs9BhUDkbq7PafuNssqdTf8pzUbb9HVBBlYlOi5bblPM5TaX7vwwVQKyYfB6EnnGQ0SE9RLtExB41l7vHPw8pXQh9gVLcFBuL/Upi9eH3xmFJDEgqHwsGZCjReaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VI5dgmGJ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so344039866b.1;
        Mon, 22 Jan 2024 13:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705958969; x=1706563769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Kvowyg4BDpjEfa2PvZ2l1xtf8WF0GFMnDWIWKtXeCc=;
        b=VI5dgmGJb+mssdogLdX+/eGkdtuNv2VTAqKlinJHBWmiX1DW/JyZhm0+lYNMFOADPy
         p+N9AmrUvzrQCkAMnpD6O05ArbeLvlvJqzlnB2MUiFyyo97muhfUYx7Xcznk35ooWuRb
         YzkNlW/0xtH9y3+ZVqrLNeL5AJpQpC68hML0Qsu7Uw3ZO2YC5IKb13VgfoYKva5WmUVo
         Gw1mHFtyzDFtIA43fN1Ci5Fc/UscAWXGnwlfJ598NAWVK/OUoX6Nw+t5M3s1dwbVMP5L
         VoZEpztLLvqDdy8sDBW3DRYAeXZxC5fyv+XnqVjDj7BcL7QKAXJSdn/Nqd4o2mNDwnCp
         DPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705958969; x=1706563769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Kvowyg4BDpjEfa2PvZ2l1xtf8WF0GFMnDWIWKtXeCc=;
        b=CbC/0CZvyZOA1n8lAhfPm5cvkUvybWhTcypqgQnxGtI/PukO7Z17IAiDO4ZkUeENv4
         +W3DkMtrv+1IWt2Ru1TYsKj2fiFaD2R4N3oeYQL0o0pjl3gVWRvYybxcBFrX3yK+8GxR
         whCH7Gt8d7LknoxezuSQOFvWSgt5rZMaky9lGq66aeDU4Xw3tVaPH/AUrPVJZYTWlU6H
         UgS1mK6jVpnfdRVwbYyOMDg0aFwuqpE0fnNsErVbq2KISJxaed50h6bURhdqlTpSmsmx
         eVe+rwnuxrO5piOxwnCXD3EYhUnoYz1/ZBcolkCCgrNyjpcRFJJ+9bhyqCoP44jrIJT5
         CwXw==
X-Gm-Message-State: AOJu0Yzsn7x9HIQ7+Qx1gISrs7vhWiyj4fAfdgk2gKVORG4z1XzNqvf+
	HIxVmmxe8p4K/ZfmJC9XjJmTj7HB/AWAxsmwRH+M8Sjj3UOzJ0P+
X-Google-Smtp-Source: AGHT+IHBMSq5x5P3AlAOWFFkV2o4LwiGphMkUJnjq28gYkopimtyx8ZGY6X0xQO22ZpqxQOxfxCebA==
X-Received: by 2002:a17:906:3189:b0:a2e:8379:48cc with SMTP id 9-20020a170906318900b00a2e837948ccmr2292288ejy.105.1705958969270;
        Mon, 22 Jan 2024 13:29:29 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a26af4d96c6sm13823336ejt.4.2024.01.22.13.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:29:28 -0800 (PST)
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
Subject: [PATCH v5 net-next 00/13] net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2220 PHY
Date: Mon, 22 Jan 2024 22:28:33 +0100
Message-Id: <20240122212848.3645785-1-dima.fedrau@gmail.com>
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

Changes in V5:
	- add missing statics for mv88q222x_revb0_init_seq0 and
	  mv88q222x_revb0_init_seq1
	- fix typo in commit message: autonegotiation
	- fix ordering of Signed-off-by and Reviewed-by in commit messages
	- add interrupt support for link detection
	- add suspend / resume ops
	- add support for internal temperature sensor
	- add cable test support
	- call .soft_reset in mv88q2xxx_config_aneg, this makes
	  mv88q2xxx_config_aneg compatible for Marvell88Q222x devices and
	  remove mv88q222x_config_aneg which is then just duplicated code
	- cleanup mv88q2xxx_config_init and make it compatible with
	  Marvell88Q222x devices
	- move parts from mv88q222x_config_init to mv88q2xxx_config_init
	  that are applicable for all Marvell88Q2xxx devices.

Dimitri Fedrau (13):
  net: phy: Add BaseT1 auto-negotiation constants
  net: phy: Support 100/1000BT1 linkmode advertisements
  net: phy: c45: detect 100/1000BASE-T1 linkmode advertisements
  net: phy: marvell-88q2xxx: fix typos
  net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2220 PHY
  net: phy: marvell-88q2xxx: add interrupt support for link detection
  net: phy: marvell-88q2xxx: add suspend / resume ops
  net: phy: marvell-88q2xxx: add support for temperature sensor
  net: phy: marvell-88q2xxx: add cable test support
  net: phy: marvell-88q2xxx: make mv88q2xxx_config_aneg generic
  net: phy: marvell-88q2xxx: switch to mv88q2xxx_config_aneg
  net: phy: marvell-88q2xxx: cleanup mv88q2xxx_config_init
  net: phy: marvell-88q2xxx: remove redundant code

 drivers/net/phy/marvell-88q2xxx.c | 634 ++++++++++++++++++++++++++++--
 drivers/net/phy/phy-c45.c         |   3 +-
 include/linux/marvell_phy.h       |   1 +
 include/linux/mdio.h              |   8 +
 include/uapi/linux/mdio.h         |   2 +
 5 files changed, 618 insertions(+), 30 deletions(-)

-- 
2.39.2


