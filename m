Return-Path: <linux-kernel+bounces-67067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B778565AC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483921C213C8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6C5132469;
	Thu, 15 Feb 2024 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cqwUUNub"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FD5131727;
	Thu, 15 Feb 2024 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006466; cv=none; b=CyFwVPfufOSf8jWNc4uUaG/fsNQQZEMUiTTLSaMy4r4yfmZDvLNCOICsJKx6a6fhFDqezT91+JBAli7yyIlZGyYUaZZP6jOZ5WizTcueVVliWjOz5QLiB4XZ++BtJmQEzk98HWrihkqag0IHUxytH/JZV7Q0IHCjzmi3oZQWe00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006466; c=relaxed/simple;
	bh=t3Zyfq1flidLj2HJeYGumwpQFqjehsUbkuEswwX6ibc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aT4g+IILHZAWWq5Z5msF3dQcPEm1juVYzVwNZ9MuDu41nu3nhpcat0Gd6h+MXMMVX5ijw0nnyWd/7bsKtxmWCDa5DXmBYHhffDEwmgSiDjLSMXL2YdFSot9KaH/ikL+JHMRdFZZAaQZ/HFY+e0zXtN3QucQwDT8bBWXUE1OTsZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cqwUUNub; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 321DA60008;
	Thu, 15 Feb 2024 14:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708006462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NRqWFUm6aNd2iZs3bNrOnrrE0X4fa/zKmGGOIOEUt48=;
	b=cqwUUNub4BGRoLFqoqtgc+yWruEgnDpy9FAO7POq7+WalF28f1RZ5um9ioRiKR2EeBmFAY
	4AE2By7uWnsmGNb2n0V6xVVF/VQ648hC4tRjJZqwBuywwu2oMKIQDzM4uNA43zbzXjHZC8
	Dk3gcIW5XsZIB2w89xDBNVayArH6U3lnCw/noJBy43YWlm89Z0vh5Wk3I+qZWPxVvN4Ha2
	fjdsOUlTgb8goH0nlP4PBFzc1fhHxPxaihvQO40Tmv/ug4Xmx1cjP1y60uQI2taRUGlanN
	yPDD0OOtB2Kw+mOyvJE1c5czw7TOBHa/qKYNyrAEOwsDOgAbUIXfyoaAq35FXQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Thu, 15 Feb 2024 15:13:53 +0100
Subject: [PATCH 2/2] wifi: wilc1000: remove AKM suite be32 conversion for
 external auth request
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240215-nl80211_fix_akm_suites_endianness-v1-2-57e902632f9d@bootlin.com>
References: <20240215-nl80211_fix_akm_suites_endianness-v1-0-57e902632f9d@bootlin.com>
In-Reply-To: <20240215-nl80211_fix_akm_suites_endianness-v1-0-57e902632f9d@bootlin.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ajay Singh <ajay.kathat@microchip.com>, Kalle Valo <kvalo@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Igor Mitsyanko <imitsyanko@quantenna.com>, 
 Sergey Matyukevich <geomatsi@gmail.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: alexis.lothore@bootlin.com

The driver currently raises the following sparse warning:
[...] cfg80211.c:360:42: warning: incorrect type in assignment (different
base types)
[...] cfg80211.c:360:42:    expected unsigned int key_mgmt_suite
[...] cfg80211.c:360:42:    got restricted __be32 [usertype]
  CHECK   drivers/net/wireless/microchip/wilc1000/netdev.c

This conversion was needed because historically the external supplicant
(observed with wpa_supplicant) expects AKM suite as big endian in
NL80211_CMD_EXTERNAL_AUTH message when the AKM suite is WLAN_AKM_SUITE_SAE.
This is not needed anymore:
- new (to be released) versions of wpa_supplicant now reads it in host
  endian _while_ keeping compatibility for older drivers
- for new drivers used with current/old wpa_supplicant, this conversion has
  been added to nl80211 to force big endian when the AKM suite is
  WLAN_AKM_SUITE_SAE

Remove this not-needed-anymore conversion to fix the sparse warning.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308290615.lUTIgqUl-lkp@intel.com/
Tested-on: WILC1000 hwB SPI WILC_WIFI_FW_REL_16_1-13452
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index f03fd15c0c97..cb564e2bad29 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -356,7 +356,7 @@ static int connect(struct wiphy *wiphy, struct net_device *dev,
 			memcpy(vif->auth.ssid.ssid, sme->ssid, sme->ssid_len);
 			vif->auth.ssid.ssid_len = sme->ssid_len;
 		}
-		vif->auth.key_mgmt_suite = cpu_to_be32(sme->crypto.akm_suites[0]);
+		vif->auth.key_mgmt_suite = sme->crypto.akm_suites[0];
 		ether_addr_copy(vif->auth.bssid, sme->bssid);
 		break;
 

-- 
2.43.0


