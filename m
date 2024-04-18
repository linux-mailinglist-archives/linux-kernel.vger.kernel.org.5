Return-Path: <linux-kernel+bounces-150175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D813F8A9B50
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6641F2369E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A8A161311;
	Thu, 18 Apr 2024 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="lytFUuKr"
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7E0EECF;
	Thu, 18 Apr 2024 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447129; cv=none; b=tNZ8sSd/JU/ExNBWxPLmUgbnMelMmgRyZ7Nu23Z5JXhVEgNmFl06hozQP/nnPkwR6w7XzZJ1H1JIU2O3fydJxQieke1GiSz2bmgTkUB3dz/eufpfX5o9yYmg7m0PK6glCh66rbE8ZAO3X5voOZvoMp1dAwcjqQRagPtKvs97R8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447129; c=relaxed/simple;
	bh=VgSvRh4Nkqg+giXaWx1zHyeFWJKVhVCAvHRS1IAmzoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WAfhpNfoHAD2L7IftnnvlLp6NXVFCt4Kni3CYvpg1s8GVaYV1j5+nNPwEmi6NHa5BAtRZXkSponYvK8uziyntHObKLBxSqGKGCaR2qFQWpj5Oab2l1ue/kKpGWTYCsbetGt3RWYb9RO+652VcyqtUfzBmNl483XhfgPTrhBP1wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=lytFUuKr; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net [IPv6:2a02:6b8:c05:84:0:640:40f8:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 24D34614D5;
	Thu, 18 Apr 2024 16:25:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id HPFFWsDX0Cg0-Zzy45R7B;
	Thu, 18 Apr 2024 16:25:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1713446726; bh=shykAdTRV0cwoBwnCaC1Edv+I0dugY6Hlb/B0Lizbw4=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=lytFUuKrncc6LBsWKDtLT8ZdlsxBBpgdFFP1IMhszbuZZC4l7b9400lCTWf2ufcu/
	 vrYlLoPO3uFqq5IuHxWm7I1IokzoZW0fw1j9lotX2CUc3qBT3u1jdyBZSTg5c+4g1k
	 hI7GaurLw9i6zq1dzFrm8iC/K6iGtD5/X9AbaIuU=
Authentication-Results: mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Konstantin <rilian.la.te@ya.ru>
To: 
Cc: Konstantin <ria.freelander@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 1/3] serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
Date: Thu, 18 Apr 2024 16:25:03 +0300
Message-Id: <20240418132508.3447800-2-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418132508.3447800-1-rilian.la.te@ya.ru>
References: <20240418132508.3447800-1-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin <ria.freelander@gmail.com>

Hardware supports both modes, but after
commit 4afeced55baa ("serial: core: fix sanitizing check for RTS settings")
we always end up with SER_RS485_RTS_AFTER_SEND and always write in
register SC16IS7XX_EFCR_RTS_INVERT_BIT,
which breaks some hardware using these chips,

Fixes: 267913ecf737 ("serial: sc16is7xx: Fill in rs485_supported")
Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 929206a9a6e1..a300eebf1401 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1458,7 +1458,7 @@ static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s,
 }
 
 static const struct serial_rs485 sc16is7xx_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND,
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
 	.delay_rts_before_send = 1,
 	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
 };
-- 
2.34.1


