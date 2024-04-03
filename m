Return-Path: <linux-kernel+bounces-130099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FB4897417
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7B828B275
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1529514A0BF;
	Wed,  3 Apr 2024 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pmuFNUgl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xI8e7ZCQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD49114A092;
	Wed,  3 Apr 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158481; cv=none; b=M8ttdSBlmgF+SNdmq/j0wh8QQQJj1+jQpTqcVgx0jgCg2FxCpqm2B3fBsSCgERClEbKgwQmOwx3ki2BKJ2sQ6lep5CEfch0FIsJQ4Il9Vd/sJ6FVXqPvvjYEVcYQ6qqX8MZ1cn14qXDH+1aev+kuweIugfQSP7PgtH3Le8E08iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158481; c=relaxed/simple;
	bh=0yR1YZrFPcWqE35bawXukpzUEZSo68/XTB1pOsvuQlY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m01jYe/4KGjbszdBOL8eIvTdr0ImPL66mY8qZrXDFJrCs4Ap+48fL7D8au8f9df2OSVy81EN2aUP6xnYjpEbz6As0+4dlDlcDr0NIB29VTFefJiXlEDtKObNIX3N7ycaDZ+Oy+JhwZAg649GFmRHD0FFWfQpnqAxJIF8MowgzPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pmuFNUgl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xI8e7ZCQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Apr 2024 15:34:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712158477;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3gA+MH41tDMK85+ffDy9WD+nQ22y2JvuPFWEFURH4JY=;
	b=pmuFNUglj4nQE40bv1s06IxxovYaH8AkAoVu3ZRl7V0vdFRO27yJKTl5XFg0FvEssiEzVp
	h1tQJD45ZSCnnTIsfITPgLeC5Nev8syrd7vZQhnChelCdUzbmVaGQVDiaQ8fnsZepWQ4IT
	U62zLsCgYX95ABXo0attinLKL5ZJKMDqmx3DyG73YX/TTKZz1EWN6aygZ2csyI6+YJR/jm
	Vca6Lxwj0XGIVMXu3UyeXOVTau96TjQ+UWs/SuDUo7+1GUKy63JnzD13Pqq2vOjjdc1HYG
	Emsyv9a4jb9l6VS3ET/6XoiBq7+5lVas3AC4yVD42scbg66n/v6WAjyDknqM/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712158477;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3gA+MH41tDMK85+ffDy9WD+nQ22y2JvuPFWEFURH4JY=;
	b=xI8e7ZCQmuOfZM0KBCSxqz/PAyOaOe2fQgfPn+BUw2iYshg6lQpSCEOzYhN2S0X0hAzBLo
	TNnjJ7xYsrBoP6DA==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/rtc: Remove unused intel-mid.h
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <1460592286-300-5-git-send-email-mcgrof@kernel.org>
References: <1460592286-300-5-git-send-email-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171215847684.10875.11532736795620786435.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     62fbc013c185896080bc5c7f6dfb26f0746eb217
Gitweb:        https://git.kernel.org/tip/62fbc013c185896080bc5c7f6dfb26f0746eb217
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Tue, 05 Mar 2024 18:10:24 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 03 Apr 2024 08:24:48 -07:00

x86/rtc: Remove unused intel-mid.h

The rtc driver used to be disabled with a direct check for Intel MID
platforms.  But that direct check was replaced long ago (see second
link).  Remove the (unused since 2016) include.

[ dhansen: rewrite changelog to include some history ]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240305161024.1364098-1-andriy.shevchenko%40linux.intel.com
Link: https://lore.kernel.org/all/1460592286-300-5-git-send-email-mcgrof@kernel.org
---
 arch/x86/kernel/rtc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 2e70669..51a849a 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -10,7 +10,6 @@
 #include <asm/vsyscall.h>
 #include <asm/x86_init.h>
 #include <asm/time.h>
-#include <asm/intel-mid.h>
 #include <asm/setup.h>
 
 #ifdef CONFIG_X86_32

