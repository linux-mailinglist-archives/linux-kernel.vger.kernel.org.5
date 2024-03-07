Return-Path: <linux-kernel+bounces-95360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3DF874CB5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9165C1F23C17
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF63126F05;
	Thu,  7 Mar 2024 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw4K5vLn"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9906383CB9;
	Thu,  7 Mar 2024 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808700; cv=none; b=LKas4FOh7ylqgrUZs08kVj/4mo4o9z+xDinO45iNmjO3IZCEXFv2xuvnpETBAQkNBFkJipCoxH2rf1HQ2CIoj9CLyy07iiudoUAd8lvNEGQRnhp+6h+kpfRngt45980QF3kfrXWN89gsubF/ruXO4EtOFGFd5Jj36JlYNqSH8Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808700; c=relaxed/simple;
	bh=LFi8S+OWOa1EYqqXXM+L4rFj+uOGc2AEYkl18pL38+0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ECr3HlnhImdONHA0JfAC97CqcTD09/R9v3pnCJBlN5H3M5U4eHwJqNiMhImFsawI/MbJteccxMOsueeOwNU6UpnOtt9Xr6hvlbc1Oy1tn6Hopz4dNElTztQXMKyFGBiY1UM5BATSVAZhWbp6rpT8WkS7J8igIrtSuyoqicPDtKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bw4K5vLn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4130e293686so5240945e9.3;
        Thu, 07 Mar 2024 02:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709808697; x=1710413497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOL8jp68frDmdFmotjs/CjSEGrRrsCfDr/cS6FaUvfQ=;
        b=Bw4K5vLn1BbT5HKrWqMEiNe4yyYkqN6ok3MFtRFgjqu5Bc9fkXMmMVlhMIT/Jafexa
         SsbIeU0zvSammARhKpPaz1PNva67iJyMIjo/BrGytZCC1aCzOrwW4WJkNHQn+l6iW8M/
         Zg3s1WL+C6m0iT8egEhoKjb1UlubR/IEZd6IBUHlyZt3t5ADkUyUa2XMGMzcEN5dkInU
         beDc4lHAHde7cdVBr3HaNq2pc6VWgHM3kvHOJxDsO09UU2FXntWjOb7z3mGno90RQQxH
         TluxCQ1v/6NMJLsy4GyUaotSwP3NRi82TQrzPESMdrj3PW+EXGb6RjHEEAHtFhAoT+pO
         QWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709808697; x=1710413497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOL8jp68frDmdFmotjs/CjSEGrRrsCfDr/cS6FaUvfQ=;
        b=Am0G5Y8qe4oThMDJEYc9vMIvrFu60R3oUt7gfcUaUcNjTMGLwv7guUC2VMB2pxdIbk
         vMoBsNw7M/e6clWePczaqK/fzNuFRxPmzZ5Uem4JUTbS/Gm37tYrfT8s0PHhjQNH93Rd
         Ql8hyG4iEIU4rdvwqS8rw7Ibp9Hqs9MrsZFxe/3NGlhUtZ07j5C87S2OG1xM/MiPOUgJ
         kautF65FMy8iM6zwGILQMm+eLHSo2Gtav8Q4nUGvlerRDOFYTXAorjhXwi+/mUv4iIk6
         xHOd8orv6n7ZLUm9lVuX2xLf4FkiqSkzEmmiW+5YKLICHml11ZPLEVQsbwsK99Fo9XlA
         zjIA==
X-Forwarded-Encrypted: i=1; AJvYcCXFxzOFnUf1iIjvK1XiIeFKNYfvVfp0wM3gGjlYq99Ezn5+8WABcV+hrK688dAZDrkQgZMDPx0YdpQYIyS3NiNtQB6DrShDXr1BsGJm9PmGMOrXeROONI5kYhYPycIe8B3z2F61bpEl
X-Gm-Message-State: AOJu0YxmRn3H/qUeegtIYR8D8NjaI74ro/KvDSH+/gMrGO+Y/fA98KRf
	aawvZFPwQVzg+9OgGTH2VAtXj2WzVPDzZyQGoKH3gjApKj3OMp2cBaOngbTDcUU=
X-Google-Smtp-Source: AGHT+IGeEgkRgsaiFwIjcNuzK8ZuJjK2X784yUxLBu2x7jaeWNAD/A3sG6sJX9D0PSNNKgNvB3Mxaw==
X-Received: by 2002:adf:f249:0:b0:33b:87fb:7106 with SMTP id b9-20020adff249000000b0033b87fb7106mr12194062wrp.55.1709808696943;
        Thu, 07 Mar 2024 02:51:36 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bk23-20020a0560001d9700b0033d282c7537sm20282575wrb.23.2024.03.07.02.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 02:51:36 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	u.kleine-koenig@pengutronix.de,
	linux-usb@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: gadget: net2272: remove redundant variable irqflags
Date: Thu,  7 Mar 2024 10:51:35 +0000
Message-Id: <20240307105135.1981060-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable irqflags is being initialized and being bit-or'd with
values but it is never read afterwards. The variable is redundant
and can be removed.

Cleans up clang scan build warning:
drivers/usb/gadget/udc/net2272.c:2610:15: warning: variable 'irqflags'
set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/gadget/udc/net2272.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index 12e76bb62c20..afd2a836be6d 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -2607,7 +2607,6 @@ net2272_plat_probe(struct platform_device *pdev)
 {
 	struct net2272 *dev;
 	int ret;
-	unsigned int irqflags;
 	resource_size_t base, len;
 	struct resource *iomem, *iomem_bus, *irq_res;
 
@@ -2623,16 +2622,6 @@ net2272_plat_probe(struct platform_device *pdev)
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
-	irqflags = 0;
-	if (irq_res->flags & IORESOURCE_IRQ_HIGHEDGE)
-		irqflags |= IRQF_TRIGGER_RISING;
-	if (irq_res->flags & IORESOURCE_IRQ_LOWEDGE)
-		irqflags |= IRQF_TRIGGER_FALLING;
-	if (irq_res->flags & IORESOURCE_IRQ_HIGHLEVEL)
-		irqflags |= IRQF_TRIGGER_HIGH;
-	if (irq_res->flags & IORESOURCE_IRQ_LOWLEVEL)
-		irqflags |= IRQF_TRIGGER_LOW;
-
 	base = iomem->start;
 	len = resource_size(iomem);
 	if (iomem_bus)
-- 
2.39.2


