Return-Path: <linux-kernel+bounces-51745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9893848ED1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47438B215FF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22162225CB;
	Sun,  4 Feb 2024 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="hoJc365J"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F207F22339;
	Sun,  4 Feb 2024 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707059682; cv=none; b=LrmVsM9O1EtNTuW4oRduGiJr9MW5RZVpmPbf6PxkWPiT7XAIuJ0sGH8xwoLxIQ0Yq64XKp8uS9B9xlrCt0C2bt8+Y+0dAfTBvldIUC4tTbf8s8LI7zuUcfK+F3ttev5zcd0UixPhVbUnPgu8VLAVYumyzt4pgJaL8bXw8f6WwnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707059682; c=relaxed/simple;
	bh=unFrVMxFKdtlqsueW7SbasHzGEZbQ6TZB8LIc+Kh/8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R/0MqcGOnOBDif3bhe2tXXbkknTgEky9Sj4Gwrz2fWw2+rkBtDPqyD3NYit4cZuWoFOAsC/iUvGBxc1MDI4sauiuXdAql8gbvFAzRCbB7aOqTnKT3Q4Bm1o4JsBtxORQ9/DMmTZ/u4Q/rIcRHohiW9ZLbh4jAmF4ZOyDP9CFW0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=hoJc365J reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d7881b1843so31613965ad.3;
        Sun, 04 Feb 2024 07:14:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707059680; x=1707664480;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVaWgQ1LmZY0En2Gv1UD7y3r8EXSlwnu8I23/WONgF4=;
        b=h9IyzhDSDsQQMOCVxt2fS5mTXqSINSleYtZrqQHQrOzLAbCO/tRjKn+qQm1ud3Xo2N
         j4gK5jsqvUu62lSlQU7hDKArM3S0gGo+oZi5sT/VkL93sxz3JHiKsCLvxLV2gI5Ef4w2
         pUampbDCtEH6CqEMVC4oTi8LRxdqL1fwHy68R3Takum7souMCnzBjKcJw17/12rpK3Tz
         fixOE/CdfbukEytPgNj5Uz0hQK+2yksZDiUQCwPqfvX1YJXA9X5bEnCH0vcKNyfJSH6G
         8MBtLMtqMJ5PqNpQ0n8y7bzBfDqqKxQhxf2RNEKGM3qw5fBhHfP40HdGenxJ5sIRS7Rx
         ndtw==
X-Gm-Message-State: AOJu0YxY2juFe2OwX/HUrloIPpSGVJrpYFx9C+kX6uqWIyd3spd5c+bB
	kq2HIJyfjWQSnkh3tTGt1fQYk40hdVtFTnW4GBuntkHO79+6OfhX3TKKiSkZ5iZYKQ==
X-Google-Smtp-Source: AGHT+IGDzq37VVdp17hoYkuKaFrCKYQpGo+DEPCydb82x+tNqHr6PhSxcFI+1ZycGEhxE+/NgMLn2A==
X-Received: by 2002:a05:6a21:3a47:b0:19e:2a1e:9650 with SMTP id zu7-20020a056a213a4700b0019e2a1e9650mr8502299pzb.38.1707059680256;
        Sun, 04 Feb 2024 07:14:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWIYkZHoemoqL767NAqkaGmbRzZCLG0NEQRhqW9NTjXZQ6RzQHf1i7zNPf3DWvGQmF0XxBr4rXPU9SAfEQaspXjAjslEKd73LydnsV33pcNJK21rSs+YQ1Z1JewIhNptsH8t7GNRyi0B/kvjhi7Aeqp4c69ubhU+KphirzU9GTnxVDOqCsr6kee5IN8I94XjVTx1nKWi1Je
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id g9-20020aa78189000000b006da96503d9fsm4913302pfi.109.2024.02.04.07.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 07:14:39 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707059678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xVaWgQ1LmZY0En2Gv1UD7y3r8EXSlwnu8I23/WONgF4=;
	b=hoJc365JYKgNUQj3hn22YIOD8f0t7HndiNGa+bD/gkkHXV14IzEYyMpG9/y6Gd70aFYcr5
	kWoBvHJAzMFqYFN7HcuKpdN85moNHcAg11sDZkpeBXyDmjb1fUZZ40P8oq+/X5sUuWwBIp
	t7hSOpHuxTHxOuzUNMFL6qaYYUzf0fsI9k9ZEKG5g8tM3sgwTKHWuwY3h6/gwIyATF0Vs9
	uX6UqZZ7WAcWalCughPwentMfqrXkjWxArJmKhHiOGtnJjyL0bKmsr1lgHULkXVxYwYHHR
	mlzbvlyDbmyDea1unm7/mgp9jxhgn2PCxuFchG1rHytL1THgFyYF+ZgmS4FKsA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 12:15:09 -0300
Subject: [PATCH] dma: dma-sysfs: make dma_subsys const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-sh-v1-1-44ced951bb16@marliere.net>
X-B4-Tracking: v=1; b=H4sIAPypv2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwMT3aTS4vjknNTEvNIC3eIMXbMU42RDY7OURLOkJCWgpoKi1LTMCrC
 B0bG1tQD0gQiSYAAAAA==
To: Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=unFrVMxFKdtlqsueW7SbasHzGEZbQ6TZB8LIc+Kh/8g=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv6n9FGNJyod4DtP0WFNNlPJ/fSSPQH8L0WfqL
 wkAkwvOqSKJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+p/QAKCRDJC4p8Y4ZY
 phNhEACW1zdIRC1W3ggdTI9lW8Xlbv7ns5oeBSNfr0yiKF7lDbcy6aCRQP/IXJgajOZz7xJIbfI
 Lzpu1IgUAGRoz4VE5sXuZkicDgMQX84SLLQ1up5XTNfeV+I7IH6wifAz/f48WcWlyj6pTDXC8nQ
 5ko62B8nwrd5L0z3jTebDZKhFjY4fMTchGa3mwPZdzMpesZ2Af17l86VLxosgvMYVWOyq0UE7Br
 Rh7Fl9DFPmzJ8392xoxXsghD6ylRiu0w5/bMt1KDCQ21MR9krQmzyPldmxtpwqAlfqqFXn7cQlk
 Ph/T6zM5Ry3viUp8/ftEMW/xUMSVAe/43yaA+xkb2aYmWlXkyl7Iin+tP3UPRe31JkihAk6XuHk
 F+l+CGwZFp5XN1o+S1CndSG+AMIApTXhOi5yToaOpzPpb+wDS3zi1UbrdChwtxpE38TpOp0A16n
 z9uJKv3gOPadodMGE6XHr3TItTqpqCRc/9+tGDbho7pTUoD9/F2GtNVdwALOptwZMZgPFxz45bL
 724uuVsDtRNG3JCDXbne/cA+S1axsI+ZXALwmRjOsKvFVnzSlVkcOD2o6pX+Sl/QWS1XqJaenv/
 dtf1AjcX/UCwaR75GRsLJeE3nS2M5mZEHZPHcaxMHWoRjd8Eibl9O4W7ivjV0gdWhmF3edayi2N
 kwKfr824GMROhyg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the dma_subsys variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/sh/drivers/dma/dma-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/drivers/dma/dma-sysfs.c b/arch/sh/drivers/dma/dma-sysfs.c
index 431bc18f0a41..9f666280d80c 100644
--- a/arch/sh/drivers/dma/dma-sysfs.c
+++ b/arch/sh/drivers/dma/dma-sysfs.c
@@ -15,7 +15,7 @@
 #include <linux/string.h>
 #include <asm/dma.h>
 
-static struct bus_type dma_subsys = {
+static const struct bus_type dma_subsys = {
 	.name = "dma",
 	.dev_name = "dma",
 };

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240204-bus_cleanup-sh-6d3c136da6bb

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


