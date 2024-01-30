Return-Path: <linux-kernel+bounces-44408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 555388421BD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 834B9B2AFED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4141066B22;
	Tue, 30 Jan 2024 10:43:33 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C7E664AD;
	Tue, 30 Jan 2024 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611412; cv=none; b=aHOkpVPuWAfUUOB4ra0Qb+SIxvdbeDEaSx6uX0lJAp51PfU3qW/vT+ymiCLdMBGP4UlwGXYMS8grjuJMZb/FLFVWKvOGlrZDpotH9Ua9cqrqQhzgdHNhkSXGnxhdu9E7hDjOC4t6cDMz9/wd+MkUgVJcl+QBX6lrsN+M+gHzuBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611412; c=relaxed/simple;
	bh=8oiNUKVEEhh5oIYwZyQpxbFSOFjFdsD2ZWymU4+yk5w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S4ruf7GnRlWxiPPzRl7z7R8tqfclUlZ92NojVHld7N2LjZiLF3cFZiYkdPQYc02u6QW6PgOg7pgHowYTQohpBI+70JUDxJC5MBo+Gm/hQbmdDOWBmG/c2i1mXs6ErVIjxF9XA2IS1f5ltDiS1HBE3g6H/2VoON14cRTmTHKh7Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3122b70439so507558866b.3;
        Tue, 30 Jan 2024 02:43:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706611409; x=1707216209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ql0oyYDm/ONLDgpSOg+sQ97/Ipoz0ZGMbVNoqcIynPY=;
        b=Ihm7AmyLuTPSL+KCJTfQUeBFGgsNI3y9DbP4CtqPWeW8STQhnv/thckUQwBpaXoFln
         tjLt6P11ukumiJ5SIKXoTH88TdmZYQ6bue8Fs4F5GqlHf7oVnrQIFdPRMfnbaoAC+l07
         6KFjjft5OG9DBFB/tshXukcx5wU/t9jyE7YsnuPFb4ATIIRWNJZvEB/6Q8t4chzSPzwh
         5QZR41rTR8SKsSMD9LzNtHEIcuaCF+G3BkIeLyT5+RkDcm3LIgpex5t9mWTSfmXHKXER
         GZE8e7G7aWRpG4A0api6dTIXZyQ1jrl+8LZGlz9G3Rqw0Ta871NiDZwFwedZqj0aJcTK
         o2fw==
X-Gm-Message-State: AOJu0Yx087QMjY8um8fCSBc1KEKZwqyCMew5jQXYOZW7ud3aQg+aKUb6
	RbxowY6hB6h3vVJY/nrPZ07Sx0wlvGSNlyQlNsu5QAGZ3EgAKL9r
X-Google-Smtp-Source: AGHT+IEtxpY+u54zGhcCVwYX9YjdB+nRP8nrec/HVsZO+vZBGj/3TYmuPEqUfjAxkz+cHNpgDKF4+g==
X-Received: by 2002:a17:906:724b:b0:a28:8dc:455a with SMTP id n11-20020a170906724b00b00a2808dc455amr6190722ejk.48.1706611408740;
        Tue, 30 Jan 2024 02:43:28 -0800 (PST)
Received: from localhost (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id gy14-20020a170906f24e00b00a28f51adc39sm4968837ejb.61.2024.01.30.02.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:43:28 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch,
	leit@fb.com,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support:Keyword:mediatek),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support:Keyword:mediatek)
Subject: [PATCH net 0/9] wifi: Fix MODULE_DESCRIPTION() for net (p4)
Date: Tue, 30 Jan 2024 02:42:34 -0800
Message-Id: <20240130104243.3025393-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are hundreds of network modules that misses MODULE_DESCRIPTION(),
causing a warning when compiling with W=1. Example:

        WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/microchip/wilc1000/wilc1000-sdio.o
        WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/microchip/wilc1000/wilc1000-spi.o
        WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/ti/wl18xx/wl18xx.o

This part4 of the patchset focus on the missing wifi drivers, which
is now warning free.

Here are all the MODULE_DESCRIPTION added:

        MODULE_DESCRIPTION("Atheros AR5523 wireless driver");
        MODULE_DESCRIPTION("Atmel WILC1000 core wireless driver");
        MODULE_DESCRIPTION("Atmel WILC1000 SDIO wireless driver");
        MODULE_DESCRIPTION("Atmel WILC1000 SPI wireless driver");
        MODULE_DESCRIPTION("Broadcom FullMAC WLAN driver plugin for Broadcom AP chipsets");
        MODULE_DESCRIPTION("Broadcom FullMAC WLAN driver plugin for Broadcom mobility chipsets");
        MODULE_DESCRIPTION("Broadcom FullMAC WLAN driver plugin for Cypress/Infineon chipsets");
        MODULE_DESCRIPTION("MediaTek MT7603E and MT76x8 wireless driver");
        MODULE_DESCRIPTION("MediaTek MT7615E and MT7663E wireless driver");
        MODULE_DESCRIPTION("MediaTek MT7615E MMIO helpers");
        MODULE_DESCRIPTION("MediaTek MT7663 SDIO/USB helpers");
        MODULE_DESCRIPTION("MediaTek MT7663S (SDIO) wireless driver");
        MODULE_DESCRIPTION("MediaTek MT7663U (USB) wireless driver");
        MODULE_DESCRIPTION("MediaTek MT76x02 helpers");
        MODULE_DESCRIPTION("MediaTek MT76x02 MCU helpers");
        MODULE_DESCRIPTION("MediaTek MT76x0E (PCIe) wireless driver");
        MODULE_DESCRIPTION("MediaTek MT76x0U (USB) wireless driver");
        MODULE_DESCRIPTION("MediaTek MT76x2 EEPROM helpers");
        MODULE_DESCRIPTION("MediaTek MT76x2E (PCIe) wireless driver");
        MODULE_DESCRIPTION("MediaTek MT76x2U (USB) wireless driver");
        MODULE_DESCRIPTION("MediaTek MT76x connac layer helpers");
        MODULE_DESCRIPTION("MediaTek MT76x EEPROM helpers");
        MODULE_DESCRIPTION("MediaTek MT76x helpers");
        MODULE_DESCRIPTION("MediaTek MT76x SDIO helpers");


Breno Leitao (9):
  wifi: fill in MODULE_DESCRIPTION()s for wlcore
  wifi: fill in MODULE_DESCRIPTION()s for wl1251 and wl12xx
  wifi: fill in MODULE_DESCRIPTION()s for Broadcom WLAN
  wifi: fill in MODULE_DESCRIPTION()s for ar5523
  wifi: fill in MODULE_DESCRIPTION()s for wcn36xx
  wifi: fill in MODULE_DESCRIPTION()s for p54spi
  wifi: fill in MODULE_DESCRIPTION()s for wl18xx
  wifi: fill in MODULE_DESCRIPTION()s for wilc1000
  wifi: fill in MODULE_DESCRIPTION()s for mt76 drivers

 drivers/net/wireless/ath/ar5523/ar5523.c                      | 1 +
 drivers/net/wireless/ath/wcn36xx/main.c                       | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c | 1 +
 drivers/net/wireless/intersil/p54/p54spi.c                    | 1 +
 drivers/net/wireless/mediatek/mt76/mt7603/main.c              | 1 +
 drivers/net/wireless/mediatek/mt76/mt7615/main.c              | 1 +
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c              | 1 +
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c              | 1 +
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c               | 1 +
 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c          | 1 +
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c          | 1 +
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c            | 1 +
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c               | 1 +
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c               | 1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c          | 1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c             | 1 +
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c            | 1 +
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c               | 1 +
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c               | 1 +
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c              | 1 +
 drivers/net/wireless/mediatek/mt76/mt7921/main.c              | 1 +
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c               | 1 +
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c              | 1 +
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c               | 1 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c              | 1 +
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c               | 1 +
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c               | 1 +
 drivers/net/wireless/mediatek/mt76/mt792x_core.c              | 1 +
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c               | 1 +
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c              | 1 +
 drivers/net/wireless/mediatek/mt76/sdio.c                     | 1 +
 drivers/net/wireless/mediatek/mt76/usb.c                      | 1 +
 drivers/net/wireless/mediatek/mt76/util.c                     | 1 +
 drivers/net/wireless/microchip/wilc1000/netdev.c              | 1 +
 drivers/net/wireless/microchip/wilc1000/sdio.c                | 1 +
 drivers/net/wireless/microchip/wilc1000/spi.c                 | 1 +
 drivers/net/wireless/ti/wl1251/sdio.c                         | 1 +
 drivers/net/wireless/ti/wl1251/spi.c                          | 1 +
 drivers/net/wireless/ti/wl12xx/main.c                         | 1 +
 drivers/net/wireless/ti/wl18xx/main.c                         | 1 +
 drivers/net/wireless/ti/wlcore/main.c                         | 1 +
 drivers/net/wireless/ti/wlcore/sdio.c                         | 1 +
 drivers/net/wireless/ti/wlcore/spi.c                          | 1 +
 45 files changed, 45 insertions(+)

-- 
2.39.3


