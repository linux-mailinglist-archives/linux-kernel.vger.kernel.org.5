Return-Path: <linux-kernel+bounces-136530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343F489D535
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92487B21C0F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9027F476;
	Tue,  9 Apr 2024 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIV/mYGv"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85C73BBD8;
	Tue,  9 Apr 2024 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654089; cv=none; b=iKwpXjvKcPDOWhoMNx7u1YjTtAxM+Y6I6xtdMYwbAAJFBGi+62qiR2OCzp/StV8I54H+YZ1w7tzO/S2U42zUL4nBehuGW+v2+BMNLsibrujAEze+mb+iIUJcVWwBAndS7ySoxxuxnvEbV6XW2GAUMuja/kzIa0XjA1fF/hw9HhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654089; c=relaxed/simple;
	bh=rgfzUkeKJOYDFNLwAPFDe2XuMe4uqGK7GAQvrlFcr3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jyTvtodz/z2mJxdLeD6IgPxn6yYY+QXE/LiuMUL/jEeBMPMAx8soh+ALuIG3pfHualynOG5xirGc6VnL+uIPz9Fgp9Aol5g4p4exuo+HnCJltmGQfKTBg/ZxFI4Ex5En+jxrc+XMQfB2+V1fIHrsL2jBW4d+UoSKqVKJ0eq0TWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIV/mYGv; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-229d01e81f1so3065460fac.2;
        Tue, 09 Apr 2024 02:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712654087; x=1713258887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pl7DTbYlcD6/uMqaXD1kQvMMRCQ5Tqm1qNlMm77S728=;
        b=WIV/mYGvVRpnnX1sdFiDDJgzYYNt30OmsW3cw9jrlWzVHjqilGt+VVl1b6P5Gdp1br
         PB3jZbKq7BUMgf6uRYroHSy1+euj4R+7vt6LgMtBBAWiMCu5thojesbjp3ziyykQUHoh
         u5bp/vSzWvT1wBzAT7Jl0Sb+yPBfeohGJ8FtPmcuNUlCelpICKfTUu6LwjpCCGw0yAeq
         KU4io2a/qlURSwBmaJelMl75QPv/9sWutwDPkfAss2QFM/QnXIjkSiIprDpMj69NoZeK
         6+L0qYOU9i3IBTlbe9BJHO+fo5btlaIHuvp8qVVzhTkwjGsuPpOKBCbaoVXOtMuO1KkZ
         My5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712654087; x=1713258887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pl7DTbYlcD6/uMqaXD1kQvMMRCQ5Tqm1qNlMm77S728=;
        b=uzPJlNp5eV39TH02azebe3k7ULIJhjFlBRV5/HwKE+lrMJBme+19fpjivMJ8evgmkr
         ypZl0N0wPlUnU7MKrUZp/DeWqdNkBik4mU+u1dyMzfGsNgpJaBriIUkhR2OwnOFAf7v0
         1s4+LoJK0TdTO77GQ9L+7VSSKM80/COGz9s4IV5APf1XBl+5qlq/Trkr7nVUIkBFP1wd
         XC0/xnEHz1JPK67sQ86ONVNiKa9Px2DU2jCVpnYP6D9Ep2stKRBZLcC6i/MbRnNuLBTJ
         ffXXkEQb3Dnb8OPog5XcEkTkwCqD1Fl6UuDXA+75fFI06CltPoWNbWoTwGWunR9XIW7E
         w5XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIzDUyw9N8lUxPUIZm5QxyYjoGvcMl6sFms6zp6I85mns5dFb5jviDu4J8GZapS8PEz3BhW4qN0DQl+NeugUS9TC2Sn64Wg+ZPOxfD
X-Gm-Message-State: AOJu0YyL3gdE3EvQSaQkzzNTpB+LDPdXl05L6OpfSlLgPsqzRnmuhcH5
	C+32pGBVnR2XDmI/WYZ8qISwzualcxbe+0WpHOloYDGPd6XvljzvCSl0tUfv
X-Google-Smtp-Source: AGHT+IGBkMDq1rmbyxjfwhXgPWfcyyKypUF11tjVYwfZfvE4K9h+fujOJEcIa05fC3DHcinAGRlS3w==
X-Received: by 2002:a05:6870:72c8:b0:22e:af38:47ee with SMTP id o8-20020a05687072c800b0022eaf3847eemr11892364oak.58.1712654086854;
        Tue, 09 Apr 2024 02:14:46 -0700 (PDT)
Received: from localhost.localdomain ([116.89.141.171])
        by smtp.gmail.com with ESMTPSA id o9-20020a056a00214900b006ead1509847sm7802100pfk.216.2024.04.09.02.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 02:14:46 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	KWLIU@nuvoton.com,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	jim.t90615@gmail.com
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: [PATCH v1] gpio: nuvoton: Fix sgpio irq handle error
Date: Tue,  9 Apr 2024 17:14:19 +0800
Message-Id: <20240409091419.1356615-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove irq_find_mapping and use generic_handle_domain_irq

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/gpio/gpio-npcm-sgpio.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-npcm-sgpio.c b/drivers/gpio/gpio-npcm-sgpio.c
index d31788b43abc..136838c25756 100644
--- a/drivers/gpio/gpio-npcm-sgpio.c
+++ b/drivers/gpio/gpio-npcm-sgpio.c
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
2.25.1


