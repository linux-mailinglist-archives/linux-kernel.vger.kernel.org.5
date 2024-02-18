Return-Path: <linux-kernel+bounces-70521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2EC8598D1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3041C2106E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49226F52E;
	Sun, 18 Feb 2024 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J01y7xoj"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9726F064;
	Sun, 18 Feb 2024 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282847; cv=none; b=a0nWKNtNjONpj16/eMkk7WShfrMe/vPU7MMmMALLAvhU9CQBt3UpgnUZHWH3/6uzzhzN4bmQLeFs9a7/t5hPXjfWaDJEtqZgAp9Xw7DNzUNshDd/I2y9pBCl1Q9WBClyT22AYOSYuRsS4xCZzRkfu2DZXX34hySNjsPLifrS2RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282847; c=relaxed/simple;
	bh=+fN+q98VpY8IjI1MBMjHL55COKOUOcO50sgpN3QZVSs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jYr0jOZTzQx43qBj8wDwrNvVbH5gI2O0YqmybFkalrS5HPXn8tDVG/sQpGLy0zkH4uLZL/HDa2XCF3D0/b12Z9q7PUgicit33wrG1KiOeXPmuZCMBP8RoC3Z4W8Z1oW/aAs+7IPcUUZK2FG25Kfm5cI9eWcJ4bp1XAOPTJOQZ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J01y7xoj; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d23473a563so7926581fa.3;
        Sun, 18 Feb 2024 11:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708282843; x=1708887643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ugw282irBh1ZorGeTnwJP2X/5ka0Fa/kP4DGUbl7TpM=;
        b=J01y7xojVtxrP/5K0KvdLRUKoyBhtGhbGuLb7bppXBla9Y9a5FZ6zgdnHumzHUKO1A
         kqCw8zz6OSQTVFT2d59Ix6/b2xwu9wGG0CBp5fgHJ/FoH+QkuinSNzTpKa9lphIDioxi
         5YwPhaVhgLFDk1vgqQ0OEx1KH2trfvqpBoeYGQmiSaHKOROGE3vhIyQrugbjPwZwdOgO
         prvEOMXv2AeothD6BeKxiON0Ix/CDr6kl6E7n4XUr02tDdNZKScrlP5K8W7WvjoiXlra
         YT+6V8p+QbNtNAhzWeyjdxnJORsOaBmhefNJGyZvJntPPMwtuA6UFtYRoH3tO3h89Wsi
         jHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708282843; x=1708887643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ugw282irBh1ZorGeTnwJP2X/5ka0Fa/kP4DGUbl7TpM=;
        b=jvN3P1gf8lQItyJ0nI3vWrXH6LHBkAezr4oJiyPduuRdgpd9fSX8fXhnBZoAf+whNU
         0Uos0NZzseDy0A5G5+7laMsxIn72izYwuoI9VQLJwtrC96MK6JhFR1AlOR3QAIjolZxi
         eX6ZyZL45c4PFZE+6gS30RA4UDSH4g0GtNd7Y+NcMfVTsnYoQFFyWTY+D55jP+brfns3
         sWWMJLEpVUV2AbGPU7LhJENWsbhY4kJsbbeDxJxactGqLAzAwIJbYKMxEJyfXSQPWYOX
         C0enlMERjEE13njH6IaNFKW2H3fw83tJpkmghvKQK9SnK5BkmV62lsr6EFtO1frVN0pt
         NTpw==
X-Forwarded-Encrypted: i=1; AJvYcCWIHI9fYgKI+VA/DZSsvZSE0vexqyAto+D4n5yXyY06XG3GBYGOu/piXReTUBYvtC4DJED4OPYpy+NeBbuMgIL/J530Nepkm5gwXKVx5zOswRrwFJ1BaVL3jc3PsthK/6AHU/Bw
X-Gm-Message-State: AOJu0YywhNpAtsMKEjlG31zu2HNoBpHtPu1pO3kAar0PjdBONKpQWH8Q
	7Dg2bjfTdgtz7aui1bWKrLW+OxUiSI8snGufiFbvxBlxyn+l0/HI
X-Google-Smtp-Source: AGHT+IEXLBde9dQZbYJSTmWJ04vcELWmg0GSmWGAhRIDsRgIh0UcSCIsPKOdVOiJlU1cmc68gYElZQ==
X-Received: by 2002:a2e:9956:0:b0:2d2:3018:6eda with SMTP id r22-20020a2e9956000000b002d230186edamr2274750ljj.39.1708282842871;
        Sun, 18 Feb 2024 11:00:42 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id m15-20020a056000008f00b0033b728190c1sm8115762wrx.79.2024.02.18.11.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:00:42 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Puneet Gupta <puneet.gupta@amd.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH 0/6] net: phy: support multi PHY in phy_driver Was: net: phy: detach PHY driver OPs from phy_driver struct
Date: Sun, 18 Feb 2024 20:00:26 +0100
Message-ID: <20240218190034.15447-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an alternative implementation of "net: phy: detach PHY driver OPs
from phy_driver struct" with the same object in mind.

As was pointed out in the previous series, deatching OPs is a way too big
change (although IMHO needed, but I understand the problem with downstream
and ugly code). As suggested and was already an idea discussed privately,
a more easier approach is introduce an alternative way in phy_driver
struct to declare PHY with the use of an array of IDs.

Some small changes were needed to mod_devicetable to make mdio_device_id
more suitable for the task.

This implementation keep the single way to declare PHY ID in phy_driver
but also indotruce .ids where a table of mdio_device_id can be defined.
Each entry can optionally have a .name variable to define a more specific
PHY name (for phydev_info/err.. usage) that if detected will overwrite
the dev name.

An example of this name is a phy_driver with a .name "Aquantia 107/102"
and .ids with single mdio_device_id with "Aquantia 107" and "Aquantia 102"

"Aquantia 107/102" will be used for early PHY driver probe and the more
specific name will be used as soon as the phydev dev_id is populated.

Aquantia driver is reworked to this implementation and BCM7xxx driver
table is rewritten to greatly benefits from this implementation.

While at it I also notice a strange problem with detected PHY ID and
C45 PHYs. Probably i will have to drop it, but including in this series
just to make someone aware and maybe discuss about it too?

Christian Marangi (6):
  net: phy: add support for defining multiple PHY IDs in PHY driver
  net: phy: fill phy_id with C45 PHY
  mod_devicetable: permit to define a name for an mdio_device_id
  net: phy: support named mdio_device_id PHY IDs
  net: phy: aquantia: group common OPs for PHYs where possible
  net: phy: bcm7xxx: rework phy_driver table to new multiple PHY ID
    format

 drivers/net/phy/aquantia/aquantia_main.c | 170 +++++++++--------------
 drivers/net/phy/bcm7xxx.c                | 140 +++++++++++--------
 drivers/net/phy/phy_device.c             | 104 +++++++++++---
 include/linux/mod_devicetable.h          |   2 +
 include/linux/phy.h                      |   8 +-
 5 files changed, 243 insertions(+), 181 deletions(-)

-- 
2.43.0


