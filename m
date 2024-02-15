Return-Path: <linux-kernel+bounces-67715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFD4856F99
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E22F1C21BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36E1141995;
	Thu, 15 Feb 2024 21:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVcwh3MF"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D536A349;
	Thu, 15 Feb 2024 21:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708033912; cv=none; b=Yke2Qh8RpuI7zuUQrJPPv1b8CUJM5yApVLjfbvSuSxWhNWdGL0Que7e0wokDsu137IDn+jsAjhywOx/uHDhbSEo1mS5UzT3yHRkR5UdoxEwatm1uzIPVy19g39VWJuqAZnV1Ke7Jd7DrQShglY7b8vlglOkz6taYkrKc9Piqf/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708033912; c=relaxed/simple;
	bh=O42nuhICBihJWnszpZZ0NOG3Cl71f3VoQR7IUUPNH9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bjl2X0dYF2a6VrnigOWMhTDRtT3HVjmH1LMyxvMtWXYiiC1EoARKwAR4OE+KrbP05Gery+qN7anxmpVDtjutghMz9Luz0HbugfTBAafdhomDYPHclcPnBnrELVYfpGuUR+RUEN+aUGy2NBSGc/PVhhdcIjv455HHefmGLKng8IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVcwh3MF; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36426ae1c5eso4365335ab.3;
        Thu, 15 Feb 2024 13:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708033908; x=1708638708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IPmAvIsDewbgoAF8s7naRSTRLzReKRtE3k+XB4aF880=;
        b=bVcwh3MFe8+fviF2XNZIbtKbNA2tT1mhU+S2LSr4AYoqFj2n2/WTtdqpcFzxm8Jlbb
         Il0rtgpVFC/+FlNpZYxMOXZMXRiEhBLN5VaxUNzcFU+PpuD1RwyNnWlPXtuF2jHzujxM
         ULyV57OCsO83ras1/R8P621TXuoaCetwoKIsvTDkky8HP0aTlRLWY30MytPOyuQufIOW
         362AQYIXNBa4gDOkTvE3Qc0KMe+aMKt+QGocBRqjXWWQO3RYKhBTdnERB8tBdJxWQQI8
         gOIzYGx8SR+J9abJez4xm4LhiRy2ZaC8Kp8fSXwB/tcHKcsVj8f2SA3BaItpPidoaabe
         xmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708033908; x=1708638708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPmAvIsDewbgoAF8s7naRSTRLzReKRtE3k+XB4aF880=;
        b=XmTwXYneooL5MOwAWL51zbTgDOV7PHSU+ECQOw+s0xEZ8QdsGktWoKqVkvqph3CzeM
         vHT4GEvgG2RU7TRUrGdPC5yOwrwid6TNhR+py/3nXIX3OddWX0Nr54PliZ59KNfdM3s7
         3pEygfiSnzTT5CuRAdG6NtOsF3JKCeQl5qZ3ZvCwS6bieJHHfOS8dIV13RhVUmR7ZxqD
         AqNxqc1il54EtFaxZAZj0QGzrVctsJzpEnbYq2nvLaZ3Y0Yf83rU4kPciH9u+lKxtqb9
         dMc4CStkpJbS7WNGALHgO3s0z/FSW518qdrZLsWuOClciPVXd5/pltUiGE9esilTYfXB
         KbTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWafvSQ5HQi3ui13epYxZhfGq/aXbCof+ohCpHysPRUx9bLltgZGBanqTRPgcXOjzKfT9DvqV/ZVA+vuvvKThHLCXsCoFaI4zS8r08Ea4xFLt8o8TloPEWdpWb6q+3ugodPRAsHqhToMcj
X-Gm-Message-State: AOJu0Yx9BHo2yHmFtiCPNX7NZ4wFuN9gsoMjIbYjhM5eHhQsKvMDhnas
	enphrN7P1Xsxy7JOsi+6ZgXKRBJDkiBpiJJRtusgyb+u1xBwdGRqx48A7qFW
X-Google-Smtp-Source: AGHT+IEX1+8EidKV0XMDVUGs/HwRHakCT7CjDaHuFK48a3BEAjjXcnYdXVrIefUBlEWoXEedo4TzQA==
X-Received: by 2002:a92:c6c7:0:b0:363:be58:cdb0 with SMTP id v7-20020a92c6c7000000b00363be58cdb0mr3227415ilm.6.1708033907744;
        Thu, 15 Feb 2024 13:51:47 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h63-20020a638342000000b005d8b2f04eb7sm1843319pge.62.2024.02.15.13.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 13:51:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Helge Deller <deller@gmx.de>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Sven Schnelle <svens@stackframe.org>,
	John David Anglin <dave.anglin@bell.net>,
	Charlie Jenkins <charlie@rivosinc.com>,
	David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH] parisc: Fix unwinder
Date: Thu, 15 Feb 2024 13:51:45 -0800
Message-Id: <20240215215145.2103639-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Debugging shows a large number of unaligned access traps in the unwinder
code. Code analysis reveals a number of issues with this code:

- handle_interruption is passed twice through
  dereference_kernel_function_descriptor()
- ret_from_kernel_thread, syscall_exit, intr_return,
  _switch_to_ret, and _call_on_stack are passed through
  dereference_kernel_function_descriptor() even though they are
  not declared as function pointers.

To fix the problems, drop one of the calls to
dereference_kernel_function_descriptor() for handle_interruption,
and compare the other pointers directly.

Fixes: 6414b30b39f9 ("parisc: unwind: Avoid missing prototype warning for handle_interruption()")
Fixes: 8e0ba125c2bf ("parisc/unwind: fix unwinder when CONFIG_64BIT is enabled")
Cc: Helge Deller <deller@gmx.de>
Cc: Sven Schnelle <svens@stackframe.org>
Cc: John David Anglin <dave.anglin@bell.net>
Cc: Charlie Jenkins <charlie@rivosinc.com>
Cc: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Tested using qemu with B160L (32 bit) and C3700 (64 bit) machines.

 arch/parisc/kernel/unwind.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/parisc/kernel/unwind.c b/arch/parisc/kernel/unwind.c
index 27ae40a443b8..f7e0fee5ee55 100644
--- a/arch/parisc/kernel/unwind.c
+++ b/arch/parisc/kernel/unwind.c
@@ -228,10 +228,8 @@ static int unwind_special(struct unwind_frame_info *info, unsigned long pc, int
 #ifdef CONFIG_IRQSTACKS
 	extern void * const _call_on_stack;
 #endif /* CONFIG_IRQSTACKS */
-	void *ptr;
 
-	ptr = dereference_kernel_function_descriptor(&handle_interruption);
-	if (pc_is_kernel_fn(pc, ptr)) {
+	if (pc_is_kernel_fn(pc, handle_interruption)) {
 		struct pt_regs *regs = (struct pt_regs *)(info->sp - frame_size - PT_SZ_ALGN);
 		dbg("Unwinding through handle_interruption()\n");
 		info->prev_sp = regs->gr[30];
@@ -239,13 +237,13 @@ static int unwind_special(struct unwind_frame_info *info, unsigned long pc, int
 		return 1;
 	}
 
-	if (pc_is_kernel_fn(pc, ret_from_kernel_thread) ||
-	    pc_is_kernel_fn(pc, syscall_exit)) {
+	if (pc == (unsigned long)&ret_from_kernel_thread ||
+	    pc == (unsigned long)&syscall_exit) {
 		info->prev_sp = info->prev_ip = 0;
 		return 1;
 	}
 
-	if (pc_is_kernel_fn(pc, intr_return)) {
+	if (pc == (unsigned long)&intr_return) {
 		struct pt_regs *regs;
 
 		dbg("Found intr_return()\n");
@@ -257,14 +255,14 @@ static int unwind_special(struct unwind_frame_info *info, unsigned long pc, int
 	}
 
 	if (pc_is_kernel_fn(pc, _switch_to) ||
-	    pc_is_kernel_fn(pc, _switch_to_ret)) {
+	    pc == (unsigned long)&_switch_to_ret) {
 		info->prev_sp = info->sp - CALLEE_SAVE_FRAME_SIZE;
 		info->prev_ip = *(unsigned long *)(info->prev_sp - RP_OFFSET);
 		return 1;
 	}
 
 #ifdef CONFIG_IRQSTACKS
-	if (pc_is_kernel_fn(pc, _call_on_stack)) {
+	if (pc == (unsigned long)&_call_on_stack) {
 		info->prev_sp = *(unsigned long *)(info->sp - FRAME_SIZE - REG_SZ);
 		info->prev_ip = *(unsigned long *)(info->sp - FRAME_SIZE - RP_OFFSET);
 		return 1;
-- 
2.39.2


