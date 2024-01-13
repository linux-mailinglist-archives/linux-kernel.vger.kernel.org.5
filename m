Return-Path: <linux-kernel+bounces-25204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0524482CA42
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 07:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD081F239BE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 06:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF4A14262;
	Sat, 13 Jan 2024 06:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYyTdyjz"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED3E12E4B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 06:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dde528dbe8so2655596a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 22:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705127687; x=1705732487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VObFOuD2bDjgl/7PoJxrcUgi9Of18dEO3PoUlswc0kk=;
        b=NYyTdyjzPwhjj2ND4eZVW3Y2mjd4aHszTPqEEz1lyglyqyoiM2NT7G+pd2zMMA0+SF
         SHWIn4qAH8JmVBECe9Vwr4smVe5CZGf2dQIY6aGhJ08oIEsJ7qAtFjxhg5Gcx0RJc/O4
         /5YeNAPR1J4bQKpDOoYbB3sDv8tOOKzA8wEj30CzGTRK1OCCqt2qOXANukD1TpkpHTNN
         Ldr+ZZ7QhJxm+jzGNlpCohqz9PO6yYJQhFtYcbuHDvv3eZFvuyBgaN+NaOn3wBLmN5JJ
         w76E80LJ5TAEZdxYttwiJAsWvCxJwHGtTmwI+RHa20hxDrCSzGUSGTosGCFLa6Srxtrp
         MWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705127687; x=1705732487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VObFOuD2bDjgl/7PoJxrcUgi9Of18dEO3PoUlswc0kk=;
        b=Qd1X02jRoGYxI+nm1SE+h5o6yvDe+2IIGF7NV3nqIk2nAbLr0v24Cz5VIXA2VhA1tr
         CGecrvsUmaPn/UPIJ94GQpY0SJMOxdnZlY3XQmhITWc9cpO9h1S3QLsJ7jgJvoOO2bfW
         wCpK3OYvcZdhuIJiIEDJyvCIFw+L1/NCgY8P6tBP2rj5pLO9pi5FTdz5lP5JsfK6Zx4W
         KL9MfHcPZ2Zqn8WD/8MwLzy+LRu1tdy4QlMDU5J07cVARkXp68Aaij7Km2jgUP8rsqaP
         j+Q7xAPTP1YIebfuVgQNTX3p6fulIvqHXVR3RvpkV4JS1piopa8d/TZx8Ms30uljBeNQ
         lHDA==
X-Gm-Message-State: AOJu0YwtNocNnDsrg/05j05dQR1Oup2Y5QuR3RxtvyxMwbPq0dAHkPVJ
	GOKZdnTAx9KWs5NdC8QbA9edJYewQ6Y=
X-Google-Smtp-Source: AGHT+IFiMxQPfP/EA5piVoLhzra8xgkk8GN8WxunRykNLH0S+4MUDz0mVFCoGtV3OReE18i/ISDeIA==
X-Received: by 2002:a05:6808:3a0f:b0:3bd:463f:fb11 with SMTP id gr15-20020a0568083a0f00b003bd463ffb11mr3213128oib.63.1705127687651;
        Fri, 12 Jan 2024 22:34:47 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net (c-73-63-239-93.hsd1.ca.comcast.net. [73.63.239.93])
        by smtp.gmail.com with ESMTPSA id y126-20020a62ce84000000b006d9b5b3ea1fsm4264043pfg.22.2024.01.12.22.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 22:34:47 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: don't produce FDPIC output with fdpic toolchain
Date: Fri, 12 Jan 2024 22:34:44 -0800
Message-Id: <20240113063444.4189388-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel doesn't use features of the FDPIC toolchain, disable FDPIC
code generation when using such toolchain and select ordinary ELF linker
emulation.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
index bfd8e433ed62..4c14a02179eb 100644
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -35,15 +35,19 @@ KBUILD_CFLAGS += -ffreestanding -D__linux__
 KBUILD_CFLAGS += -pipe -mlongcalls -mtext-section-literals
 KBUILD_CFLAGS += $(call cc-option,-mforce-no-pic,)
 KBUILD_CFLAGS += $(call cc-option,-mno-serialize-volatile,)
+KBUILD_CFLAGS += $(call cc-option,-mno-fdpic,)
 ifneq ($(CONFIG_KERNEL_ABI_CALL0),)
 KBUILD_CFLAGS += -mabi=call0
 KBUILD_AFLAGS += -mabi=call0
 endif
 
 KBUILD_AFLAGS += -mlongcalls -mtext-section-literals
+KBUILD_AFLAGS += $(call cc-option,-mno-fdpic,)
+
+KBUILD_LDFLAGS += -m elf32xtensa
 
 ifneq ($(CONFIG_LD_NO_RELAX),)
-KBUILD_LDFLAGS := --no-relax
+KBUILD_LDFLAGS += --no-relax
 endif
 
 CHECKFLAGS += -D$(if $(CONFIG_CPU_BIG_ENDIAN),__XTENSA_EB__,__XTENSA_EL__)
-- 
2.39.2


