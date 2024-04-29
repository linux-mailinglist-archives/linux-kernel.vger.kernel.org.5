Return-Path: <linux-kernel+bounces-161834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC058B51F4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7911F21542
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3D612E74;
	Mon, 29 Apr 2024 07:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBXO7841"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EB46FCB;
	Mon, 29 Apr 2024 07:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714374338; cv=none; b=EgYQMRqAsb+OsAe4CQlweVi8tMRoI2WcVOwsph8cwJzSEiutUgqfa5qbGAprPnYazz2lpZz/oFuGMmPdzX1v5uy8DAdRSRurmASBwDDKpbCTbqc2IANLXMeUG9kVW4KY5ZlqoHCTDI2LmxDXsUUNjClhI/mLbF0MujYsGPFXz9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714374338; c=relaxed/simple;
	bh=A92NApa3ooDk01UhoJeZtWditAENVRvKRE9OTUjWJrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o7fLpgdMp6sScetIRDYr8zHFzNdG00izPVsXWIpSwi/3OG8Q0xpLjN/+vkOweBZQct9P1GtoJcAkOag47thHk7Z8L83LsVdIyxQmxci1B9ttgblkIsdpddOZT6RUawMbx7wvpbyZSWDFAyfYHJZG0KiRTwhfZUfecBK4SJOKvQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBXO7841; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ab1ddfded1so3661331a91.1;
        Mon, 29 Apr 2024 00:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714374336; x=1714979136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vEglK9K8c5i8QBLiYdAQTdb0ab9SQtK5PmVbKoN4XV8=;
        b=OBXO78410p6hWkVoxBvJYtnL/xjyIfWIPnyk3rJGv4A+lSZjPfUkGpe29ZBe0c4+vW
         ha4p7YAANIjlZKpV07/W1xpRk3tSL9xw8xhOe9qMXis6reSCvpjWwKB9fL3PMQ4KVsxA
         6aEEE3Qb/0ZOPnlv/3317Na9CkAv+p2TUrt6q4GoxTMuPQAUGcrtT4EOgFN3BPHm5Kp5
         +u3OTFg2Pkuwv9jeefooTnoMEOnZxxwXc3d/pDIUZonMPb1TqNUxpeRILm/9RdsZIRFC
         FG4JTAF8fCmwETFf1SfBh9AYf+eRQoE7erJAiL0X17qS/kwUgwHNX5wKzJU+2JmpCDbK
         sepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714374336; x=1714979136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEglK9K8c5i8QBLiYdAQTdb0ab9SQtK5PmVbKoN4XV8=;
        b=JejPvIHARBrQBS4Z/7YmsCdKJChmDOelTXITrrDaUEEu51/pzePdk79k81n/EV8xsJ
         fgFY1ThhYV8ooTd7Rf/ABCDpkPH0AfpQZoo+jcs1o5/Ly39ySVb2c7fQqYOefmhWYbIv
         OMswRr7ueTRE3p1G2a4BNlS8YxU1rvd1YeTqavOjQ/rYibmVXkkuWqQ0KqL5mGERAvVw
         YQJRfRcPLJPjfQjJ3y64C9iXFlsO/QPSbJTelJMZ0zmY4L3IvSCdBug1kFVp7I1zsY9J
         xUrvyc62hoVeEZPFjlLv1XxBjqADUAdDvjxKtdd7/N3++vJDbShi/8QsFHmi7XZlgix0
         zhuw==
X-Forwarded-Encrypted: i=1; AJvYcCUxpz5d9WNY8EwIvX7bNfFHm1Ftdbj8Kkl+EPEI+/xSZFARzzRhsPTM7Y1p5F1yIcLhjpvY3nHsDxvQdJX7+yU+lOHaUyHFNrRaFkLX
X-Gm-Message-State: AOJu0YzRx+NF4jUtHWE0ayrT4wgxaMUxGXEdULE8n157yN1twJy1/f1W
	HL5c3YPwHQmVDl6DOsyyGlIH9cAoX+B9TluONgqSA9+L+J0+LFAX65r4Qw==
X-Google-Smtp-Source: AGHT+IGMAMI8jVYAcx5uDRIfdvsKW0eMKlGR3gETBwuInjA3i51gQQBZTkLDilCVqH0FdDm+X1BZAQ==
X-Received: by 2002:a17:90b:1d01:b0:2a2:bd4b:764f with SMTP id on1-20020a17090b1d0100b002a2bd4b764fmr8222549pjb.3.1714374336553;
        Mon, 29 Apr 2024 00:05:36 -0700 (PDT)
Received: from localhost.localdomain ([1.200.153.166])
        by smtp.gmail.com with ESMTPSA id gt5-20020a17090af2c500b002b16f39c917sm1947355pjb.50.2024.04.29.00.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 00:05:36 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	KWLIU@nuvoton.com,
	jim.t90615@gmail.com,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	dan.carpenter@linaro.org
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: [PATCH v3] gpio: nuvoton: Fix sgpio irq handle error
Date: Mon, 29 Apr 2024 15:05:23 +0800
Message-Id: <20240429070523.3160248-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic_handle_domain_irq() function calls irq_resolve_mapping()
so calling irq_find_mapping() is duplicative and will lead to a stack
trace and an RCU stall.


Fixes: c4f8457d17ce ("gpio: nuvoton: Add Nuvoton NPCM sgpio driver")
Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
Changes for v3:
   - remove unused variable
Changes for v2:
   - add more description
---
 drivers/gpio/gpio-npcm-sgpio.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-npcm-sgpio.c b/drivers/gpio/gpio-npcm-sgpio.c
index d31788b43abc..260570614543 100644
--- a/drivers/gpio/gpio-npcm-sgpio.c
+++ b/drivers/gpio/gpio-npcm-sgpio.c
@@ -434,7 +434,7 @@ static void npcm_sgpio_irq_handler(struct irq_desc *desc)
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
 	struct irq_chip *ic = irq_desc_get_chip(desc);
 	struct npcm_sgpio *gpio = gpiochip_get_data(gc);
-	unsigned int i, j, girq;
+	unsigned int i, j;
 	unsigned long reg;
 
 	chained_irq_enter(ic, desc);
@@ -443,11 +443,9 @@ static void npcm_sgpio_irq_handler(struct irq_desc *desc)
 		const struct npcm_sgpio_bank *bank = &npcm_sgpio_banks[i];
 
 		reg = ioread8(bank_reg(gpio, bank, EVENT_STS));
-		for_each_set_bit(j, &reg, 8) {
-			girq = irq_find_mapping(gc->irq.domain,
-						i * 8 + gpio->nout_sgpio + j);
-			generic_handle_domain_irq(gc->irq.domain, girq);
-		}
+		for_each_set_bit(j, &reg, 8)
+			generic_handle_domain_irq(gc->irq.domain,
+						  i * 8 + gpio->nout_sgpio + j);
 	}
 
 	chained_irq_exit(ic, desc);
-- 
2.34.1


