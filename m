Return-Path: <linux-kernel+bounces-60930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B6F850B3E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842991C222F5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37015DF17;
	Sun, 11 Feb 2024 19:35:28 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CD95C90A;
	Sun, 11 Feb 2024 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707680128; cv=none; b=Rv/odlujjTsADlrWkwfCukF30cAbxKG8UIfigwHmOAOWvJjeHoT0qbLTNdgSDOZBqGk2zHqK2W610L2PJO7BAkeynzpZ2P0WEg3jnpAPQ43EUoOvCTFwNv0KvCbdlTHxowei8CdyYDl5FBoVhlOKVf+Q6Sx7BD2mseXjPjcN/Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707680128; c=relaxed/simple;
	bh=4p+eEId/ef6hmdn2ZUdbEMzoLKAUOWJOO2z7RNaWg/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XLK8IXGDDAWN5+pIPwpQ8msIDxWjlJraM2p/XCOfLCSvPUyKCbCb6EXJJUWA4WYqJEL80C1ovkrd5AgfZrzkgdM8oRrwCm5fPsat3ExyX7QqCqWLtqkqm9hIELUKQ2ei9CFQA0CHayvA0qbY7n7dgav2cuFCMGaNkLt/XgUTtYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id C609EFF804;
	Sun, 11 Feb 2024 19:35:15 +0000 (UTC)
From: Artur Rojek <contact@artur-rojek.eu>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH] sh: hd64461: Make setup_hd64461 static
Date: Sun, 11 Feb 2024 20:34:51 +0100
Message-ID: <20240211193451.106795-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: contact@artur-rojek.eu

Enforce internal linkage for setup_hd64461.

This fixes the following error:
arch/sh/cchips/hd6446x/hd64461.c:75:12: error: no previous prototype for 'setup_hd64461' [-Werror=missing-prototypes]

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 arch/sh/cchips/hd6446x/hd64461.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/cchips/hd6446x/hd64461.c b/arch/sh/cchips/hd6446x/hd64461.c
index f3fba967445a..81764882d87d 100644
--- a/arch/sh/cchips/hd6446x/hd64461.c
+++ b/arch/sh/cchips/hd6446x/hd64461.c
@@ -72,7 +72,7 @@ static void hd64461_irq_demux(struct irq_desc *desc)
 	}
 }
 
-int __init setup_hd64461(void)
+static int __init setup_hd64461(void)
 {
 	int irq_base, i;
 
-- 
2.43.0


