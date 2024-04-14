Return-Path: <linux-kernel+bounces-144251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA80E8A4396
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D331F21803
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920701353EF;
	Sun, 14 Apr 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJxUIf6o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49BF1350CC
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713109811; cv=none; b=W3/aNgLdudzY4fJFlWKkTWeU/Wk8fLK6kd1Y+xcQHbLT/1qdifYDMAtKuqtteGbVhB51ngpl4XFQciQVvL7BDVjC4E5EHyArSrh3mkURCm3mehNA57O/QwsfzmUw+LaZ7RJ8NlD0s7nyRnQKoHwADg0arAoBkFeAzkrUeKsp/fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713109811; c=relaxed/simple;
	bh=1siY9G7c32/jXXjmIv0pzxqYCWLt7XapCGkShk13+8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UIWgCLC/xL6OQ3cy62W42r557lm0WjV/0+7c2gyT3FvX13bwYw6rEzAULNiuExnNg1HD4qsYMAVrFHuD0oYumTNVzEhTHKu3/1umzVTQPU6tlz4rwM1dOX/tOD72ik2tITs0obIC3znLfVPhKqQL3ME7861C5F7+Nv/XTBmLzbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJxUIf6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5AEC2BD11;
	Sun, 14 Apr 2024 15:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713109811;
	bh=1siY9G7c32/jXXjmIv0pzxqYCWLt7XapCGkShk13+8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HJxUIf6opbRLmamr7yUQE1j/d4/xq8J4ynotLlQB/lNvpVgNgQMXj/XZ75l2Vsb8f
	 a9zEEOCuQUXVz5uITy8NWUmgshUTipuwuaY+ruJq1egAoPoj4wsmJ8ngBj+2RTr7L1
	 zPKeoLuHzhUghhA2mlVAakHzhCzOYwNZOkNO+y4Kx7mq7aiABzcYPpj/1UliDgog6y
	 XY9DLmpPDbNy1zvANNyxLTdqRTrLXGf6nGDnzq79dBfwXNczneuGW0cXUB8xNEoAaF
	 +aX45htApFHAvRnXBjOzlqeaY/C8GC2scd4aJfm+MgEedJhgv2anuBxVX6Ns2jSXsq
	 l5ZLL8xWleCAQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] eeprom: 93xx46: drop unneeded MODULE_ALIAS
Date: Sun, 14 Apr 2024 17:49:57 +0200
Message-Id: <20240414154957.127113-3-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240414154957.127113-1-krzk@kernel.org>
References: <20240414154957.127113-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ID table already has respective entry and MODULE_DEVICE_TABLE and
creates proper alias for SPI driver.  Having another MODULE_ALIAS causes
the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index e78a76d74ff4..45c8ae0db8f9 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -578,5 +578,3 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Driver for 93xx46 EEPROMs");
 MODULE_AUTHOR("Anatolij Gustschin <agust@denx.de>");
 MODULE_ALIAS("spi:93xx46");
-MODULE_ALIAS("spi:eeprom-93xx46");
-MODULE_ALIAS("spi:93lc46b");
-- 
2.34.1


