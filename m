Return-Path: <linux-kernel+bounces-141861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCC88A2459
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E22281EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E2D175B7;
	Fri, 12 Apr 2024 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HapOIJzq"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDF11B963;
	Fri, 12 Apr 2024 03:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712892248; cv=none; b=VwqoleC8XWr6QsN+4wC1reh1BP72oQZ27NzUMZW6+zm5tl049fyynZx0i3q/ssc07UtJIee524msODLScq3EOpvGO56poXzlQAJ0tW4vI8dFiK7jnwtFQFexU35598RxYuTa/mstU/pOYM35jqfaVVcJTqA/lkmvPrGGSUpsDY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712892248; c=relaxed/simple;
	bh=B3BEeQqzlf4FZKveKyo0QpREp7f6dmwUHp30YnzGYyQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=RsqD9qi9kQJQ0QzA92Z9/gMMmvY/uSZeTDxe0S3c0JtSj6RS2xQ6VcK9iSCNBbCpeey/MZqMdmPPucV9uyLKNXbXyFtloyIAFpK6VzS9cmy/JCT8coTmZfo9VytaKA3mAFGUWXplYUp3BeqnwV90ykVQLk1p7UvSv2bccctgcA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HapOIJzq; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c3aeef1385so291458b6e.3;
        Thu, 11 Apr 2024 20:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712892246; x=1713497046; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkzqh0jNf3IiQKrXTxkpy8kUD3tILL0aPn6146+WbnA=;
        b=HapOIJzqRvWrXQ5oOLK3my6StSXNEgriezbHrcjaiNovH+NOZDI7ri5NiuttUD5ktX
         iMPil3/0ZZaEK1DuSGgzukWZx5pi3Ng3Z9s4jKQX9DJ6kg3D4WhbeM4S6w4OF1H5+DcM
         pMh4EFwhrghMAA5tdDiKlCKrfSp5EyQw9qpoa8WK9kO3sahGbsqsCBTVxCmZ6eV9+gy4
         iZPV0JMcJBnAl8EWuD4aNWwCPTyX0mZ1AbCdcdNSR7yFZu3bC3JY5poG/MEY1Ze5LVD+
         RmJFRTR63LRslRw7hWdWIVvNz9D2qol/GQj6V+HxON3FuwBsDylB3TqgVsulkJeefj/X
         jvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712892246; x=1713497046;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkzqh0jNf3IiQKrXTxkpy8kUD3tILL0aPn6146+WbnA=;
        b=HjU0wBO2McQZFoCR5UpwPnNEuIiUR3aUFTd+EN3rNHHd5CKTETfVfMR/PyZPqKFYzi
         93FphmqsGAgW0k58vA7IQHirAUP/hXT9sjflsB3C4MmZG5GjmpvFL4ckqx2zlbr1JLGL
         oNbP9UoiZI3wTCBzQa26NlAnnXPnYXKwUgAWGL6UO3IJJpEzPvnIEdg/PM8a+yC7BN0y
         j49wFn8LFqlKujyyZ5kdSXQ6V7yXmSPk5dF+OmFtuQwAtYHAR0GkIiYOkYJDGyhOX+vA
         sbJZfhCAFAtMEB60+ScTWo9D0ZddYUu4B+10GL6i99MFWjz3tDdz53BOp1K6VGbIxiFQ
         s3lw==
X-Forwarded-Encrypted: i=1; AJvYcCVc4ZC+GuaNc9bNCSUY7ARbOX4NddSFy0E82BAVOFHyt74ULQ9Ut3Q5zEtkMf2X33IQZve8Fa23i7T7TNmVAlzOBH8oJZVfss5Z/XjxzZmNzwny8L/4rQk+hoWJd+Q11IwTwDZXrkS9GYfL
X-Gm-Message-State: AOJu0YzVuKM/1LRGuWqNozOUU/tMwlz+ZhbUhVgNidSQXGlvptw1/vzD
	pyaLO4lkdDIuPLzvAwdKkRRQ9xS0ntRQSZ0I27nDQmyMMfuINWVWk3SaBA==
X-Google-Smtp-Source: AGHT+IE8rx5EJBd6/CsrwNSxVWEB1fMfJLITA0J9C4XwGkskILp8B9Sr6+lun+dgeht8FJwG50ezjw==
X-Received: by 2002:a05:6808:1a16:b0:3c6:a77:651c with SMTP id bk22-20020a0568081a1600b003c60a77651cmr1912133oib.29.1712892245959;
        Thu, 11 Apr 2024 20:24:05 -0700 (PDT)
Received: from localhost.localdomain ([43.159.199.34])
        by smtp.gmail.com with ESMTPSA id l16-20020a63da50000000b005d5445349edsm1561074pgj.19.2024.04.11.20.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 20:24:05 -0700 (PDT)
From: Guanbing Huang <albanhuang0@gmail.com>
To: gregkh@linuxfoundation.org,
	andriy.shevchenko@intel.com,
	rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org,
	tony@atomide.com,
	john.ogness@linutronix.de,
	yangyicong@hisilicon.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lvjianmin@loongson.cn,
	albanhuang@tencent.com,
	tombinfan@tencent.com
Subject: [PATCH v7 0/3] serial: 8250_pnp: Support configurable reg shift property
Date: Fri, 12 Apr 2024 11:23:51 +0800
Message-Id: <cover.1712890897.git.albanhuang@tencent.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Guanbing Huang <albanhuang@tencent.com>

The 16550a serial port based on the ACPI table requires obtaining the
reg-shift attribute. In the ACPI scenario, If the reg-shift property
is not configured like in DTS, the 16550a serial driver cannot read or
write controller registers properly during initialization.

To address the issue of configuring the reg-shift property, the 
__uart_read_properties() universal interface is called to implement it.
Adaptation of PNP devices is done in the __uart_read_properties() function.

Guanbing Huang (3):
  PNP: Add dev_is_pnp() macro
  serial: port: Add support of PNP IRQ to __uart_read_properties()
  serial: 8250_pnp: Support configurable reg shift property

 drivers/tty/serial/8250/8250_pnp.c | 40 +++++++++++++++++++-----------
 drivers/tty/serial/serial_port.c   |  7 +++++-
 include/linux/pnp.h                |  4 +++
 3 files changed, 35 insertions(+), 16 deletions(-)

-- 
2.17.1


