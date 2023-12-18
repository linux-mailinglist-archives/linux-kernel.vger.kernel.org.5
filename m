Return-Path: <linux-kernel+bounces-3517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D76816D43
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC7128466B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166AE1BDED;
	Mon, 18 Dec 2023 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yfh2CUtg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670F81BDE4;
	Mon, 18 Dec 2023 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-552d39ac3ccso4834863a12.0;
        Mon, 18 Dec 2023 03:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702900684; x=1703505484; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9cob2BTKtRUG3gan91jHtrmfGZP6/xwNRARtcmcWME=;
        b=Yfh2CUtggt53AO4jx+oQWqHokv0ExZBW3extD4S5rdT0EYSsylvjlAGTrDC63SPS9B
         N+G47MjQTpnl7Y6rAyhzvajRxmjraZi8CEpTmFYGLym6bioEx0hfZA7LpSmMIyVSdXhE
         OOBX5jzgFlFAR9Nlx9b4/sJOOwckkCeQNUZTE3xOTASCtJzH5Ae9R5EaBR7e6EpH3MeG
         ZMCd4eBf/nASoIMK4dWFB7FmNP9jgUmRFME8R7Hz2RfrujvULM9Ojr7ZPw/AlPLI3qn5
         DEAPkvB9nId5+7KpNpquiGGdLKBKxjQSBb4m1DKtoSmyMcixfZV/njc971K3l1yGIMqg
         a5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702900684; x=1703505484;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9cob2BTKtRUG3gan91jHtrmfGZP6/xwNRARtcmcWME=;
        b=FpQHhr0Tu9+hQ0qslAcwc5nh5VTq6+6lYmgjyXBHH0qIsoIToxYS65h1OEo4GcLO/x
         gRMGqKTkVEID+dETO8bBc3XVesGsCvxTGhuiGxdsQC6OSaoSOUCUqnt3+x0jlY63YJBy
         3HH771t5iuoj4fMbcZGruUl5bOOnMjWhoJss/flvSi9t07nl4Sz8PvuW5jAkzfo2upct
         /I5uKnxJkJl9YI0oPJF+ZKmT2nJ52T3KQNv2HmKlQX4gT0Zf2UGQr2gywkNkx8jiM+iT
         SyBzN1XXyY4vYZVlQBqr58MyPD15fT+gJC0Vz61lcEpoI4JhCP/BRmW1sCY4CZGUQehm
         IPwQ==
X-Gm-Message-State: AOJu0Yx5BunFS8aA7wxkkwYwlYX+S6qpWgbKfpQXvVz+ERvatuLy6XVT
	M+c84iYlWrhHxTXTJEg28BM=
X-Google-Smtp-Source: AGHT+IE6G8N4QKH7XH8gb0knGfKzrKAZaAHW13YKA7QagA+WTN/R4TzQjfpWe8aJNqAEjUB2zmGK5A==
X-Received: by 2002:a17:906:fa87:b0:a23:3753:4d3 with SMTP id lt7-20020a170906fa8700b00a23375304d3mr2442355ejb.14.1702900684349;
        Mon, 18 Dec 2023 03:58:04 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:801c:2315:7dea:474f])
        by smtp.gmail.com with ESMTPSA id i14-20020a170906a28e00b00a2332116b3esm2406175ejz.152.2023.12.18.03.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 03:58:04 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kalle Valo <kvalo@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Arend van Spriel <aspriel@gmail.com>,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Michael Buesch <m@bues.ch>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	b43-dev@lists.infradead.org,
	brcm80211-dev-list.pdl@broadcom.com,
	SHA-cyfmac-dev-list@infineon.com
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] bcma,ssb: simplify dependency handling for bcma and ssb drivers
Date: Mon, 18 Dec 2023 12:58:02 +0100
Message-Id: <20231218115802.15859-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The files, drivers/bcma/Kconfig and drivers/ssb/Kconfig, define two helper
config options BCMA_POSSIBLE and SSB_POSSIBLE. Both options are defined
identical:

config {BCMA_POSSIBLE,SSB_POSSIBLE}
	bool
	depends on HAS_IOMEM && HAS_DMA
	default y

While this kind of duplication might still be acceptable in order to have
both sections work independently of each other, it really gets strange when
looking how they are then used in expression where both of those configs
appear. E.g., config B43's dependency is:

  (BCMA_POSSIBLE || SSB_POSSIBLE) && MAC80211 && HAS_DMA

Note that BCMA_POSSIBLE and SSB_POSSIBLE identical and already have HAS_DMA
as condition, so that is then also another duplication.

Another example is the choice Supported bus types in B43, which already
depends on B43 and hence, we know that HAS_IOMEM && HAS_DMA holds, so all
stated dependencies in the choice are true in all cases.

Given this whole confusion around the use of these two symbols, just remove
them and replace them with the expression they intend to abbreviate.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/bcma/Kconfig                            | 7 +------
 drivers/net/ethernet/broadcom/Kconfig           | 4 ++--
 drivers/net/wireless/broadcom/b43/Kconfig       | 5 +----
 drivers/net/wireless/broadcom/b43legacy/Kconfig | 2 +-
 drivers/net/wireless/broadcom/brcm80211/Kconfig | 3 +--
 drivers/ssb/Kconfig                             | 7 +------
 6 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/bcma/Kconfig b/drivers/bcma/Kconfig
index b9558ff20830..26bb2a28c7db 100644
--- a/drivers/bcma/Kconfig
+++ b/drivers/bcma/Kconfig
@@ -1,12 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
-config BCMA_POSSIBLE
-	bool
-	depends on HAS_IOMEM && HAS_DMA
-	default y
-
 menuconfig BCMA
 	tristate "Broadcom specific AMBA"
-	depends on BCMA_POSSIBLE
+	depends on HAS_IOMEM && HAS_DMA
 	help
 	  Bus driver for Broadcom specific Advanced Microcontroller Bus
 	  Architecture.
diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index 75ca3ddda1f5..8abbdb88459c 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -6,7 +6,7 @@
 config NET_VENDOR_BROADCOM
 	bool "Broadcom devices"
 	default y
-	depends on (SSB_POSSIBLE && HAS_DMA) || PCI || BCM63XX || \
+	depends on (HAS_IOMEM && HAS_DMA) || PCI || BCM63XX || \
 		   SIBYTE_SB1xxx_SOC
 	help
 	  If you have a network (Ethernet) chipset belonging to this class,
@@ -21,7 +21,7 @@ if NET_VENDOR_BROADCOM
 
 config B44
 	tristate "Broadcom 440x/47xx ethernet support"
-	depends on SSB_POSSIBLE && HAS_DMA
+	depends on HAS_IOMEM && HAS_DMA
 	select SSB
 	select MII
 	select PHYLIB
diff --git a/drivers/net/wireless/broadcom/b43/Kconfig b/drivers/net/wireless/broadcom/b43/Kconfig
index 4559549b80fe..f53eaa8b11cd 100644
--- a/drivers/net/wireless/broadcom/b43/Kconfig
+++ b/drivers/net/wireless/broadcom/b43/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config B43
 	tristate "Broadcom 43xx wireless support (mac80211 stack)"
-	depends on (BCMA_POSSIBLE || SSB_POSSIBLE) && MAC80211 && HAS_DMA
+	depends on HAS_IOMEM && HAS_DMA && MAC80211
 	select BCMA if B43_BCMA
 	select SSB if B43_SSB
 	select FW_LOADER
@@ -42,18 +42,15 @@ choice
 
 config B43_BUSES_BCMA_AND_SSB
 	bool "BCMA and SSB"
-	depends on BCMA_POSSIBLE && SSB_POSSIBLE
 	select B43_BCMA
 	select B43_SSB
 
 config B43_BUSES_BCMA
 	bool "BCMA only"
-	depends on BCMA_POSSIBLE
 	select B43_BCMA
 
 config B43_BUSES_SSB
 	bool "SSB only"
-	depends on SSB_POSSIBLE
 	select B43_SSB
 
 endchoice
diff --git a/drivers/net/wireless/broadcom/b43legacy/Kconfig b/drivers/net/wireless/broadcom/b43legacy/Kconfig
index e4da34ec4f5b..ff11c63b5248 100644
--- a/drivers/net/wireless/broadcom/b43legacy/Kconfig
+++ b/drivers/net/wireless/broadcom/b43legacy/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config B43LEGACY
 	tristate "Broadcom 43xx-legacy wireless support (mac80211 stack)"
-	depends on SSB_POSSIBLE && MAC80211 && HAS_DMA
+	depends on HAS_IOMEM && HAS_DMA && MAC80211
 	select SSB
 	select FW_LOADER
 	help
diff --git a/drivers/net/wireless/broadcom/brcm80211/Kconfig b/drivers/net/wireless/broadcom/brcm80211/Kconfig
index 3a1a35b5672f..2e1db48201ff 100644
--- a/drivers/net/wireless/broadcom/brcm80211/Kconfig
+++ b/drivers/net/wireless/broadcom/brcm80211/Kconfig
@@ -4,8 +4,7 @@ config BRCMUTIL
 
 config BRCMSMAC
 	tristate "Broadcom IEEE802.11n PCIe SoftMAC WLAN driver"
-	depends on MAC80211
-	depends on BCMA_POSSIBLE
+	depends on HAS_IOMEM && HAS_DMA && MAC80211
 	select BCMA
 	select BRCMUTIL
 	select FW_LOADER
diff --git a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
index 1cf1a98952fa..0a6d5a60b5a8 100644
--- a/drivers/ssb/Kconfig
+++ b/drivers/ssb/Kconfig
@@ -1,12 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config SSB_POSSIBLE
-	bool
-	depends on HAS_IOMEM && HAS_DMA
-	default y
-
 menuconfig SSB
 	tristate "Sonics Silicon Backplane support"
-	depends on SSB_POSSIBLE
+	depends on HAS_IOMEM && HAS_DMA
 	help
 	  Support for the Sonics Silicon Backplane bus.
 	  You only need to enable this option, if you are
-- 
2.17.1


