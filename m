Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A6A7E5A16
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjKHPeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjKHPeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:34:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E68F1FDB;
        Wed,  8 Nov 2023 07:34:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D24C433C7;
        Wed,  8 Nov 2023 15:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699457654;
        bh=IQuIhzAP2oCEkm8RxRpRLdGUd2nvXPFXpheFn9oGLgY=;
        h=From:To:Cc:Subject:Date:From;
        b=UaZObc8mXWne8kEwdn8YJEBxVKqi6dG5H1QQQEOxvRugvMqSsjzk/K7FfY+G+UCgQ
         tiRIpFS2MbQRsQCbxRhAh9lTA5cFXNwi85GusgYp65NdjCizM4+qHr4+6rUPYWgAjJ
         eoUqZSz5nJx3tIKCdnQAC3W4YtnMscI51dp7aIAkTj8fwTIHLyC7JUw6Vx4laTdUTp
         AGw1ggrnlD8dxwfKmpU8wBTqz2VACaByKbmoYLcsInr5i98BmnDtSteiW+gGaL5NKc
         lzv2hgh9O6JZ2OJ9+JpioTvvfuFyaT7zRm/ZfrClJBKrM6vGNlsMgJXAGyyRH5pmjy
         JY4U2PC0iW1jQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Kiran Divekar <dkiran@marvell.com>,
        "John W. Linville" <linville@tuxdriver.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, libertas-dev@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: Libertas: stop selecting wext
Date:   Wed,  8 Nov 2023 16:34:03 +0100
Message-Id: <20231108153409.1065286-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Libertas no longer references the iw_handler infrastructure or wext_spy,
so neither of the 'select' statements are used any more.

Fixes: e86dc1ca4676 ("Libertas: cfg80211 support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/marvell/libertas/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/Kconfig b/drivers/net/wireless/marvell/libertas/Kconfig
index e937e1bf70c1..da07ee826100 100644
--- a/drivers/net/wireless/marvell/libertas/Kconfig
+++ b/drivers/net/wireless/marvell/libertas/Kconfig
@@ -3,8 +3,6 @@ config LIBERTAS
 	tristate "Marvell 8xxx Libertas WLAN driver support"
 	depends on USB || SDIO || SPI
 	depends on CFG80211
-	select WIRELESS_EXT
-	select WEXT_SPY
 	select LIB80211
 	select FW_LOADER
 	help
-- 
2.39.2

