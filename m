Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80067F401F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343498AbjKVIbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbjKVIbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:31:02 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AFF93;
        Wed, 22 Nov 2023 00:30:59 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5484ef5e3d2so7052078a12.3;
        Wed, 22 Nov 2023 00:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700641858; x=1701246658; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9Cxvv/xNdpglan51CFkm8Zx1o0cnxsHHNPItVu8HE8=;
        b=lW99JIXNNxmQKukkeLMX27uWojIlPBvXFrLN00e9jybu0reXN6diw36EZaPcEv+y9J
         tTGBXoWuveCHKQMNWU5HJk5ohEr0cykX2jIX5sFeM3DwKHJoBcCOrDPemdlJkOnrlfxC
         ORDDpGIWP/uIldNgmqyjRdN9ZM17NuKnqSrbIYf8JBQrK87RqZQgwTmuAKDlbECGz9D7
         m8GALo9JiwxwakwdqAfSMwqOlLjWthNsqGCaXKRiLS2tu8oZzuvOCI3LZKmvIfep5XAj
         zG/FXtLmwbKur/l3FaukLXBQRsmESHBFNJBUkdgM57DLU/797j1lzTjZkKNA1Yd/7Xqx
         eYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700641858; x=1701246658;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9Cxvv/xNdpglan51CFkm8Zx1o0cnxsHHNPItVu8HE8=;
        b=AwsG8ilBK22bLFikwvf1ajPbUCpSPoHnAyiQOWrYtVYeOXRKOBQbNycfstRRodzupo
         x0RPgHzXBAmphGqsWrCu9sYk8FJPPGN3S/9hs6Al567+bnPt9lTa+Ckg39pbeG83bXSL
         oGIsAYnPaUgI0Z/X3GcRDe2Z6ewYmlD1eUQjjCLPblt77MlbRrc2xrnKQ9WFjwEKRk9l
         FXxSFX5sES8hhCVe6OSqwpwcAXTgKBNlWRh/5GTHirMybKsikTM3KR7gO4kMIu2iUsLZ
         FNHUJldpDWxvE9/CfCogNxNJdZi1rrSMV8kYkHQnOyCfuyT0LHcZwlK3ioWR/gBcqubG
         oQAw==
X-Gm-Message-State: AOJu0Yxw+92AmDOxiAYgp3iUeC88p4Rq9wiYuaKbeTxf68X3NUNeigV9
        e7t1eW0dQeuYhEoercCQDII=
X-Google-Smtp-Source: AGHT+IFWoRYWE5A4j9ODEYXpZWSAF31+BLlh3D5L+QwX+ENESzyPy4VwZ7njPHBaL0AOnHziTVsatw==
X-Received: by 2002:aa7:d603:0:b0:548:636f:398 with SMTP id c3-20020aa7d603000000b00548636f0398mr1206085edr.27.1700641857596;
        Wed, 22 Nov 2023 00:30:57 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:14bb:d13c:65e3:46bf])
        by smtp.gmail.com with ESMTPSA id a12-20020aa7d74c000000b0054918d34fb0sm1008148eds.95.2023.11.22.00.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 00:30:57 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] wifi: libertas: fix config name in dependency for SDIO support
Date:   Wed, 22 Nov 2023 09:30:47 +0100
Message-Id: <20231122083047.12774-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4b478bf6bdd8 ("wifi: libertas: drop 16-bit PCMCIA support") reworks
the dependencies for config LIBERTAS, and adds alternative dependencies for
USB, SDIO and SPI.

The config option SDIO however does not exist in the kernel tree. It was
probably intended to refer to the config option MMC, which represents
"MMC/SD/SDIO card support" and is used as dependency by various other
drivers that use SDIO.

Fix the dependency to the config option MMC for declaring the requirement
on provision of SDIO support.

Fixes: 4b478bf6bdd8 ("wifi: libertas: drop 16-bit PCMCIA support")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/net/wireless/marvell/libertas/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/libertas/Kconfig b/drivers/net/wireless/marvell/libertas/Kconfig
index 56156a021be3..36b234bc5be8 100644
--- a/drivers/net/wireless/marvell/libertas/Kconfig
+++ b/drivers/net/wireless/marvell/libertas/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config LIBERTAS
 	tristate "Marvell 8xxx Libertas WLAN driver support"
-	depends on USB || SDIO || SPI
+	depends on USB || MMC || SPI
 	depends on CFG80211
 	select LIB80211
 	select FW_LOADER
-- 
2.17.1

