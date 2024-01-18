Return-Path: <linux-kernel+bounces-30217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EBE831BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293251C209EC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF4EA53;
	Thu, 18 Jan 2024 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8Z/+56M"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893F1646
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588974; cv=none; b=FuG3NvNmWFDxuMSnAA3Af+eCgrwC8zn++Qhq38HI8820YHBdFk2BYnaIbvpi6zeeN1wR1LvgTdW0UapxNuWeHJci7XPlq0hyscuFvc+3cfdU/CaHuhzL2TVQhXtcYN17c+CmwF+9Q2SB1gZKkwn1KFJ5AwJ2ABEjGVdocerULO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588974; c=relaxed/simple;
	bh=uxGgJcXm3aAJDaHF15vKNxr/n7qIlwyktZ3CCGHOF3U=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Content-Language:To:Cc:
	 From:Subject:Content-Type:Content-Transfer-Encoding; b=UbcMMEiVXae2In7otOajd8grG1btxt3mPq32sl9BqMqQeCv+z95tWoRSZDL+AKQoLPHJeYVoZw0cwqY9IbrdX5HcoUsUyCw6QbUiZ6PcGHbFdbj5Z3NpOglVSPRLe9T9baTK63xFoYJP6xoqE3C3F9B29FAQHUTXNpja7pUfM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8Z/+56M; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bd5ed7d760so453323b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 06:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705588972; x=1706193772; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOqtTg4UhK2C7KvLSKvadXo0TFb7Q9SqKiW1/C+ZT5k=;
        b=e8Z/+56M2dmaBAOhwnNFnuCjrzB/fDQAzD2oG6J7439VY0F5Xhd4y9gmwZAkgzKJCs
         aKlc89u0uyPCpKyn0Ry+48t/GlM7Uq3pDP4zFvgqesWHzQAhEmb2C9Ze54P6xZIaNnjv
         U/xFkMzLUTwWFUJWIVyKBi7B+D7DuycKbNs/PVt0n2ITExLmE5+snhHQWTuey2gPZADF
         QZ8DRhx7PStWLH6Oa8bDVhILa97as8mrPatFjTs2tuD1u1FlkX9HzewHD0ir/jHRntKF
         4LjZ2Rs2J3lJ6v00gSzV8ozVUFxPVh/wEjiT6A06DAC20q7gQDwYVU3nv7m7AOVJz69v
         Ih7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705588972; x=1706193772;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mOqtTg4UhK2C7KvLSKvadXo0TFb7Q9SqKiW1/C+ZT5k=;
        b=l8OxVB6wyWVQkig0Od1xo/akqs9sH5voSIPNz3se0m9HRA6okAW2pGeJGttS4/Tr3S
         Bd3py8rn7LB1xKhLIoNq9iMYEqypYKmwAsg08+RasWadCreaM2W4eUeNmIoQPC8wOR1x
         TUqjDqlzx5eunbqmv/DjvdF2AfiTXup5lbjWGw2xliaYJVDix8pJ2h7ApWUwL18/MZjv
         fcat4mhfwz37YjEx6pJGRAb3cyLsH2JunWUJGelZ3xFGohVVmokGrZDwmZbWAEYd/6ji
         5B86IaLPDS3/c8Y+wtquakOJYlzzoBHvu56pTOYsT9Q/xeQsW7YKPvuuRFvJJzVkQ/KW
         FXGQ==
X-Gm-Message-State: AOJu0YzrsCqzbajhMPwddSlEU9dBrsUgZO/Qlg1wa012l50xC8dHK2YR
	wEO50UPvThN2JrSM7K+QBEAWLyC5wUpbJ0LiqTWTpE7F16mGC1Gu
X-Google-Smtp-Source: AGHT+IHwO/PRr4anWSEpoynGuxV16/UCi+N+rYypmX49+oaDj5sBVZrSE7+8oKlL6PS5YMbX7NpSRQ==
X-Received: by 2002:a05:6358:8a9:b0:175:d0a3:7432 with SMTP id m41-20020a05635808a900b00175d0a37432mr1914208rwj.1.1705588972436;
        Thu, 18 Jan 2024 06:42:52 -0800 (PST)
Received: from [192.168.1.157] (pool-74-98-201-227.pitbpa.fios.verizon.net. [74.98.201.227])
        by smtp.gmail.com with ESMTPSA id nh17-20020a056214391100b00681929ad11fsm455813qvb.76.2024.01.18.06.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 06:42:52 -0800 (PST)
Message-ID: <03b524b7-8e66-4180-b22a-aa641acbaac3@gmail.com>
Date: Thu, 18 Jan 2024 09:42:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn,
 micky_ching@realsil.com.cn
Cc: jklott.git@gmail.com
From: Jacob Lott <jklott.git@gmail.com>
Subject: [PATCH] staging: rts5208: Fix coding style issues
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Help text in a module should describe the module and give
some guidance on whether or not to enable it.

The BIT macro should be used instead of 1UL << n. This
makes the code more readable and easier to maintain.

Signed-off-by: Jacob Lott <jklott.git@gmail.com>
---
  drivers/staging/rts5208/Kconfig     | 10 +++++++---
  drivers/staging/rts5208/rtsx_card.h |  4 ++--
  2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rts5208/Kconfig 
b/drivers/staging/rts5208/Kconfig
index b864023d3ccb..bb293cbf6230 100644
--- a/drivers/staging/rts5208/Kconfig
+++ b/drivers/staging/rts5208/Kconfig
@@ -3,7 +3,11 @@ config RTS5208
         tristate "Realtek PCI-E Card Reader RTS5208/5288 support"
         depends on PCI && SCSI
         help
-         Say Y here to include driver code to support the Realtek
-         PCI-E card reader rts5208/rts5288.
+      Choose Y here to enable support for the Realtek PCI-E card reader 
RTS5208/5288.
+         This driver facilitates communication between the Linux kernel 
and the Realtek
+         PCI-E card reader.

-         If this driver is compiled as a module, it will be named rts5208.
+         If you opt to compile this driver as a module, it will be 
named rts5208. Selecting
+         N will exclude this driver from the kernel build. Choose 
option Y if your system includes
+         the Realtek PCI-E card reader rts5208/rts5288. When in doubt, 
it is generally safe
+         to select N.
diff --git a/drivers/staging/rts5208/rtsx_card.h 
b/drivers/staging/rts5208/rtsx_card.h
index 39727371cd7a..9d2504fddb13 100644
--- a/drivers/staging/rts5208/rtsx_card.h
+++ b/drivers/staging/rts5208/rtsx_card.h
@@ -338,7 +338,7 @@
  #define DMA_DIR_FROM_CARD              0x02
  #define DMA_EN                         0x01
  #define DMA_128                                (0 << 4)
-#define DMA_256                                (1 << 4)
+#define DMA_256                                BIT(4)
  #define DMA_512                                (2 << 4)
  #define DMA_1024                       (3 << 4)
  #define DMA_PACK_SIZE_MASK             0x30
@@ -542,7 +542,7 @@

  #define BLINK_EN                       0x08
  #define LED_GPIO0                      (0 << 4)
-#define LED_GPIO1                      (1 << 4)
+#define LED_GPIO1                      BIT(4)
  #define LED_GPIO2                      (2 << 4)

  #define SDIO_BUS_CTRL          0x01
-- 
2.34.1


