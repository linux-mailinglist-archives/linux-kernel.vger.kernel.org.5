Return-Path: <linux-kernel+bounces-54116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD0484AB02
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4AF1C23CDA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0F317C8;
	Tue,  6 Feb 2024 00:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="C9l7b7H5"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22398184E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 00:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707178435; cv=none; b=Uc2EyKbt0lG9fKC6ZM8fTN8dY2z6aPNKodT3Cn5sFaNMW3Go3ab1BGYNyNfnvZTPSPGHnXzsUwN3fNI7MIrS73+BkJMNesnzgRwst1gYnBHsW6gZZSDB+atPmWFGaBOACITYY3evC5Xi6uD1oBRwjCXRLHBjFtHRce1EXHtATds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707178435; c=relaxed/simple;
	bh=qgTGi7JidDwUNcALuXCs/Aobj1U/WF9E3H5PaXfigWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K11OtkabNR14z1k0eEjZHSjm3OlxtRVTpy/oSZrLvjGOB70+Wmi7Hqm23wO7T2W+pYoxAHrkseLLDevBm43bvtpfAjgUDeRnHh3dq2OScJi06QNbop0FiNTHLbEjGEvBRyl/Llk/7UJoOVuBk5tc34WbUR/b3sE0VBBoPP6vtss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=C9l7b7H5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so4000805f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 16:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1707178430; x=1707783230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r3al5hoYNZZk10PcQ0r4e5BeElcwyRKIKSa+2Ek/7S4=;
        b=C9l7b7H53KP2v3EvJyWesaJRo+r7zP9Vb3KnwAWxnLdta9YrUg5xGQ+ve1f8cR2Oby
         wpcRKQdD9Pmgq4CuDpgM6+shndCKj40IU3NldDQfGbjleLsjDqGaeGcliVneVqmtEyuj
         0Mf+n+dyXRhq2FxAhUCxkBVgXnZpMTJq7NOd9ZGBvfwQVgAmLTWe1easadqQCBPzqrNX
         PsXl/dIOm5zIF3Ma0iz9nVrZ+Y2+b3U9Qa1GKTxkb0cVJAx2GbFwh8ZQpUg9OOu/3i9x
         6rbw1rRTjh8P5UlPX9QL4WMgrfhFsmYeyGb6KZn/PGalbB8Td4TFJB533rY8GD6vOcUc
         xBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707178430; x=1707783230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3al5hoYNZZk10PcQ0r4e5BeElcwyRKIKSa+2Ek/7S4=;
        b=pazzqKAZ1QzwIfh0JgNGGFt4m+J6WEI0lzswTLwoBfL+sJIxaxXARrbp5+7ezyE9XI
         uWsAabmhOflAxXBmhOClDsgvxpSQ0nJuJIu1DcDeXFMItqfU+hta5xsw37voMfNNqeH/
         FGbmpo/ey4gmWGm7+NC1nHRPY0A+e732IHpHQqBaBXkl1ZrffArdp0vywQRHP0EmGi36
         O01G9I1Y+LxFhn2PGdUAsaEDsvW1y+PuDBCQJf1NzW3v4sDQYsieC3gs1WxN6qraciLf
         kihi6Bris1V4aVNc7+Fik0f0QBf/+f4AiMRztYCAX51A5DzdGOYIwckZxQ6WQzI+G87G
         DPFQ==
X-Gm-Message-State: AOJu0YyfVyeFOLXEMadh8wt8hZmot9ebxqNsql5A1Yu9mfRSUaQufVp7
	O5ltwsk3l//X8txscxUT8iFzJQVylOdJxOyFH80PUGWjg0oJGc7Myf/xHEJ3+0I=
X-Google-Smtp-Source: AGHT+IFCim5OUOcgfTPcWA7Y6IOO0/nwwMYeV/LjPUpF6aS2P1E1QUN/ct8OXNgDJGo/eorbjUfFDQ==
X-Received: by 2002:adf:e6cb:0:b0:33b:150e:627a with SMTP id y11-20020adfe6cb000000b0033b150e627amr32907wrm.70.1707178430299;
        Mon, 05 Feb 2024 16:13:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWGGbZtGrR24l8gipVeG/n2/q6+R1SUf1M+MXyjypyn/mXeEuLCRm8v6kFtLpF74IY1NWbBNfY1X5T6nuLBRJysUAaAisMwjmSLp4Q5PwOEGmkvlybNBbMv9J3Q8dRxcOXD9sKaM/KK6C+eqomNABkluk6ej4SEGTkgxwfNxfGEb5CDl/oRNsnJJ2ql0767ogdYZRVh6u8gBKBeyehf7TojNfgS7PvqUhReBu/IAc78fD4vJAMAMY6rTYcHtg6Hh1wu3omiZffR+c3FXSQTIaAGS7wvvtKvO2o+Uvg/bWkecdP1AmdouvpaZowkyFYqufk8+G61B3KfaYfSbAylpsdeqiUN9hWQgJ5k+Z2YZkRTHdJrLjlIYPEWw491FYaF3kYgjJa6FSQTPJl0BKLqP3XUD3uZcNlyuyBe4bwyl8gQyh/j73myH9PXLdtox7QsJMNqWczKpXTV2dy1DRoAsCUL86ED+wM2A2t+DfWght/gIDhAoL5PLawCMsyR65D4TGyimPDUyzkW1HgIOZqCo42te6zULDk/ueCWSJGwnWW5cxZac71XlvK2nJEbvFAqTZpgtoDBzOQaH/1X9Pns27uRorZrx4mWcV92/97gRRpDhq4QRuAVzHeRTdnbZagQJa+7w026zTjHt1TPIpvsjSl1l5ElUDBOtkTOB5Uit+HPV+cLo9+I1cNtQi95nAfG4ATctArhvsW1se3lAmojkuuNE/dYjCN4dYdhjfxPMYMtbDTQfuOVaBiRiIfupQXscuRpQC3nlnkEjzqNz4uvYPXzECMIjeo=
Received: from P-ASN-ECS-830T8C3.local ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id b17-20020a5d40d1000000b0033ae7d768b2sm686959wrq.117.2024.02.05.16.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 16:13:50 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	x86@kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Borislav Petkov <bp@alien8.de>,
	Darren Hart <dvhart@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH v4 0/3] printk: CONFIG_BASE_SMALL fix for LOG_CPU_MAX_BUF_SHIFT and removal of CONFIG_BASE_FULL
Date: Tue,  6 Feb 2024 01:13:30 +0100
Message-Id: <20240206001333.1710070-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series focuses on CONFIG_BASE_SMALL.
The first patch fixes LOG_CPU_MAX_BUF_SHIFT when CONFIG_BASE_SMALL is
used.
The second patch globally changes the type of CONFIG_BASE_SMALL and
adapts usages.
The third patch removes the now redundant BASE_FULL and puts BASE_SMALL
in its place in the config menus.

Thanks everyone for your reviews! :)

Patch history:
v3->v4: Applied Petr Mladek's suggestion (Thanks!):
* Keep BASE_SMALL instead of BASE_FULL
* A patch changing the type of BASE_SMALL was added.

v3 series was named "printk: CONFIG_BASE_SMALL fix for
LOG_CPU_MAX_BUF_SHIFT and removal"
https://lore.kernel.org/all/20240204232945.1576403-1-yoann.congal@smile.fr/
* Patch v3 1/2:
  * Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
  * Reviewed-by: John Ogness <john.ogness@linutronix.de>
  * Reviewed-by: Petr Mladek <pmladek@suse.com>
* Patch v3 2/2:
  * Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>

v2 -> v3: Applied Luis Chamberlain's comments (Thanks!):
* Split the single commit in two : one functional fix, one global
  removal.

v2 patch was named "printk: Remove redundant CONFIG_BASE_SMALL"
https://lore.kernel.org/all/20240127220026.1722399-1-yoann.congal@smile.fr/
* Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
* Reviewed-by: John Ogness <john.ogness@linutronix.de>

v1 -> v2: Applied Masahiro Yamada's comments (Thanks!):
* Changed from "Change CONFIG_BASE_SMALL to type bool" to
  "Remove it and switch usage to !CONFIG_BASE_FULL"
* Fixed "Fixes:" tag and reference to the mailing list thread.
* Added a note about CONFIG_LOG_CPU_MAX_BUF_SHIFT changing.

v1 patch was named "treewide: Change CONFIG_BASE_SMALL to bool type"
https://lore.kernel.org/all/20240126163032.1613731-1-yoann.congal@smile.fr/

Yoann Congal (3):
  printk: Fix LOG_CPU_MAX_BUF_SHIFT when BASE_SMALL is enabled
  printk: Change type of CONFIG_BASE_SMALL to bool
  printk: Remove redundant CONFIG_BASE_FULL

 arch/x86/include/asm/mpspec.h |  6 +++---
 drivers/tty/vt/vc_screen.c    |  2 +-
 include/linux/threads.h       |  4 ++--
 include/linux/udp.h           |  2 +-
 include/linux/xarray.h        |  2 +-
 init/Kconfig                  | 15 +++++----------
 kernel/futex/core.c           |  2 +-
 kernel/user.c                 |  2 +-
 8 files changed, 15 insertions(+), 20 deletions(-)

-- 
2.39.2


