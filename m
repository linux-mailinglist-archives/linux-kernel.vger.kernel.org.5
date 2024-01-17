Return-Path: <linux-kernel+bounces-28982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 395218305F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E104D1C22CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B3F1EA74;
	Wed, 17 Jan 2024 12:49:39 +0000 (UTC)
Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD0B1DFF2;
	Wed, 17 Jan 2024 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495778; cv=none; b=E6TkaBfyOj2OucPdrQMDCgvfRUkoNh0o9H36ArgJT3RYFUvYDSJammDH0OiqoAxZ5XgcWv0PtFWrF9+uDZj8VFcgeULgxdSKi7EpHNCQGTpo/7aVsIjz3fJNhbTpE/RJ34FR41BeYPOjciV0KCXoAjetlJjGEh4e1dCp1koUk1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495778; c=relaxed/simple;
	bh=yAVW7ObbCfhbkCbmZjm1w55Iw1QPKOCJ27ZxRHwf7e4=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding; b=M8uz3yosHpj8StnMgFawHPweZ4bg/Ac33WAbJwGrpDQksey6bpn/yXULcBXT4Nd9qEdQtzMJ4Kljk8DHN85wk8PRx6z3eauzfD/ih6/+7yUhKT5ACzLCjRlSNPYTCCjS6fE+CU4lHe5t7LOVxpanR9eBxze87mPQnY9Q4IhGlqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wifirst.fr; spf=fail smtp.mailfrom=wifirst.fr; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wifirst.fr
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=wifirst.fr
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 9BBFBDF8932;
	Wed, 17 Jan 2024 13:43:16 +0100 (CET)
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:aa1:d2f0:f6b3:db6:44c:eeef])
	(Authenticated sender: isaias57@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id B2AF778034D;
	Wed, 17 Jan 2024 13:42:57 +0100 (CET)
From: Jean Thomas <jean.thomas@wifirst.fr>
To: sean.wang@kernel.org,
	linus.walleij@linaro.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Jean Thomas <jean.thomas@wifirst.fr>
Subject: [PATCH 1/2] pinctrl: mediatek: mt7981: add additional uart group
Date: Wed, 17 Jan 2024 13:42:33 +0100
Message-Id: <20240117124234.3137050-1-jean.thomas@wifirst.fr>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add uart1_3 (pins 26, 27) group to the pinctrl driver for the
MediaTek MT7981 SoC.

Signed-off-by: Jean Thomas <jean.thomas@wifirst.fr>
---
 drivers/pinctrl/mediatek/pinctrl-mt7981.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7981.c b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
index 7e59a4407859..ca667ed25a4d 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7981.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
@@ -737,6 +737,9 @@ static int mt7981_uart1_1_funcs[] = { 2, 2, 2, 2, };
 static int mt7981_uart1_2_pins[] = { 9, 10, };
 static int mt7981_uart1_2_funcs[] = { 2, 2, };
 
+static int mt7981_uart1_3_pins[] = { 26, 27, };
+static int mt7981_uart1_3_funcs[] = { 2, 2, };
+
 /* UART2 */
 static int mt7981_uart2_1_pins[] = { 22, 23, 24, 25, };
 static int mt7981_uart2_1_funcs[] = { 3, 3, 3, 3, };
@@ -871,6 +874,8 @@ static const struct group_desc mt7981_groups[] = {
 	PINCTRL_PIN_GROUP("uart1_1", mt7981_uart1_1),
 	/* @GPIO(9,10): UART1(2) */
 	PINCTRL_PIN_GROUP("uart1_2", mt7981_uart1_2),
+	/* @GPIO(26,27): UART1(2) */
+	PINCTRL_PIN_GROUP("uart1_3", mt7981_uart1_3),
 	/* @GPIO(22,25): UART1(3) */
 	PINCTRL_PIN_GROUP("uart2_1", mt7981_uart2_1),
 	/* @GPIO(22,24) PTA_EXT(4) */
@@ -933,7 +938,7 @@ static const struct group_desc mt7981_groups[] = {
 static const char *mt7981_wa_aice_groups[] = { "wa_aice1", "wa_aice2", "wm_aice1_1",
 	"wa_aice3", "wm_aice1_2", };
 static const char *mt7981_uart_groups[] = { "net_wo0_uart_txd_0", "net_wo0_uart_txd_1",
-	"net_wo0_uart_txd_2", "uart0", "uart1_0", "uart1_1", "uart1_2", "uart2_0",
+	"net_wo0_uart_txd_2", "uart0", "uart1_0", "uart1_1", "uart1_2", "uart1_3", "uart2_0",
 	"uart2_0_tx_rx", "uart2_1", "wm_uart_0", "wm_aurt_1", "wm_aurt_2", };
 static const char *mt7981_dfd_groups[] = { "dfd", "dfd_ntrst", };
 static const char *mt7981_wdt_groups[] = { "watchdog", "watchdog1", };
-- 
2.39.2


