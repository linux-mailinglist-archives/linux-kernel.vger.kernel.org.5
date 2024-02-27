Return-Path: <linux-kernel+bounces-83141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11762868F65
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9247A2824FA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E998013A248;
	Tue, 27 Feb 2024 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="whKgNXxD"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FFC133285
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709034484; cv=none; b=M2REI26+OCXdtePlq9JfdaSrU8IcrQnadfbII8mUy4rgrI8eRYMBmb1VxzHudeFC1quJBP1zSGJhi0Vei3nk890klsWfiWugLBKXCUM2BDUQIOa41QC37B1HA1eLpu2n+MbgqkK12/hPQzHjPAyKe7UshrD/wy9tuvXouIkYc60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709034484; c=relaxed/simple;
	bh=rqOKTEfdfcG4Ij6AAPk3XWIkqLCxrGvU0rlH+6YVYio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hVDp+b9Bwn5GagAEYzxeKWJQ7Ke4+CrJ7yTmdqW7FSwrssgDyZ8X4bCfasfZ2LEA0Cc4ttsGhk8u2NkMkdbVn/bQPkLh54D4mc25fP9uTf9RVaYwp/+/Bowdc9pCfqbcWjWYGtr4VmTrtmPKenc5HZMM+5A/efzqYal4wyDcsvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=whKgNXxD; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512f6f263a6so2181589e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 03:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1709034480; x=1709639280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YDEwCDwla+ATU4OUPMAD+dyVfDQxnOaxyBUEQhnu7Tw=;
        b=whKgNXxDwtVqLoUaepDmdueatkXQhC951QmQqYlSFAQsycDdl8mXO/4h9KXBqfg2M9
         Zr03p+iyS+F2Fa4BapKXLrB+L2qi9XLB88ygacm0HX/WcvdiB9M4FUh9GiAeNTxwFCO/
         gzDMRuGpDhyWyE7HyIAKx/DXY/QeiLyLVPQWrLNFO1ugE+CssmTm/tN3FwWlS/M4UNsY
         3uEv21AjhlRSvV4ZG3EgqHvz1pYOmPL4NuAFFitC7U8y3Yubxc/VJeI/vuXKoT4D30GD
         PYVCxFcPnYIw9TZTHSI+cVSvXzv781rNBD9oYS8TeZVWF+m+Cl6nkH+F7cqsmUJG4Hy9
         so7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709034480; x=1709639280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDEwCDwla+ATU4OUPMAD+dyVfDQxnOaxyBUEQhnu7Tw=;
        b=Fq7i7uZHI5GMHVrROfd+eCwngK3Mzq5EatHSq8VaxqUK4AzE+CAQMLUp6hOGx86iN6
         CE5WOLDEqiG+VodpLDQoxJCjS4DnQjIFyPk5wpza6oRUzGcvee4QadYUDpCL9M0KzoTq
         EWAdl8fkRAmlRD3Q9k2Y+AeQtSTEIU1Cogv86ffNN5gq9OxU9qf0G2cCJvheDwwhYlXa
         TINzc0BjPeVIrE7ekJSuGgx+gXepN5H66lqYQBuewZetpdkZ93ncm8PM6vLWmDbJZV45
         wsoWCcDWHFfxTXJEIqttUq6+zm+oZwk6xmUYAsDKkk9k0TXIMHYnF6Fxx/Wz/dcvELO2
         7YDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTaTRzBnSUZ+IVUAyLdyJj9qdQMntM1+ZyZwsGpfFqyqcIAf7zvD2/X/pHgg1hvTsHEv1sy4yMqzq+mGlDGlYBPm++FjtB33fRuYyt
X-Gm-Message-State: AOJu0YwZk2T3KafhVXOGt5fi4pwCdzXCss1qJM5tNu92XFJlY1Jb5+l8
	be/J44S6OFJJ8jKMsysC7fbblehLvH9pYoxJmm/nSMQ+Z+IOx6BTAzul4nUB/RM=
X-Google-Smtp-Source: AGHT+IHXhvqLUhpZRvjTuEkke1Jw390Omi57V0IsWTpVChaZWkMYbHmweV6UQW9CZ7fl8axkMAKT2A==
X-Received: by 2002:a05:6512:3e0d:b0:512:f53b:893c with SMTP id i13-20020a0565123e0d00b00512f53b893cmr6423497lfv.64.1709034480402;
        Tue, 27 Feb 2024 03:48:00 -0800 (PST)
Received: from fedora.fritz.box (aftr-82-135-80-35.dynamic.mnet-online.de. [82.135.80.35])
        by smtp.gmail.com with ESMTPSA id r29-20020adfa15d000000b0033de7a30b4fsm2519818wrr.26.2024.02.27.03.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 03:47:59 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Wei Liu <wei.liu@kernel.org>,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] x86/apic: Use div64_ul() instead of do_div()
Date: Tue, 27 Feb 2024 12:43:34 +0100
Message-ID: <20240227114333.1718-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes Coccinelle/coccicheck warnings reported by do_div.cocci.

Change deltapm to unsigned long and replace do_div() with div64_ul()
which doesn't implicitly cast the divisor and doesn't unnecessarily
calculate the remainder.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/x86/kernel/apic/apic.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 4667bc4b00ab..facfb03ef5c8 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -699,7 +699,7 @@ static void __init lapic_cal_handler(struct clock_event_device *dev)
 }
 
 static int __init
-calibrate_by_pmtimer(long deltapm, long *delta, long *deltatsc)
+calibrate_by_pmtimer(unsigned long deltapm, long *delta, long *deltatsc)
 {
 	const long pm_100ms = PMTMR_TICKS_PER_SEC / 10;
 	const long pm_thresh = pm_100ms / 100;
@@ -710,7 +710,7 @@ calibrate_by_pmtimer(long deltapm, long *delta, long *deltatsc)
 	return -1;
 #endif
 
-	apic_printk(APIC_VERBOSE, "... PM-Timer delta = %ld\n", deltapm);
+	apic_printk(APIC_VERBOSE, "... PM-Timer delta = %lu\n", deltapm);
 
 	/* Check, if the PM timer is available */
 	if (!deltapm)
@@ -724,14 +724,14 @@ calibrate_by_pmtimer(long deltapm, long *delta, long *deltatsc)
 		return 0;
 	}
 
-	res = (((u64)deltapm) *  mult) >> 22;
+	res = (((u64)deltapm) * mult) >> 22;
 	do_div(res, 1000000);
 	pr_warn("APIC calibration not consistent "
 		"with PM-Timer: %ldms instead of 100ms\n", (long)res);
 
 	/* Correct the lapic counter value */
 	res = (((u64)(*delta)) * pm_100ms);
-	do_div(res, deltapm);
+	res = div64_ul(res, deltapm);
 	pr_info("APIC delta adjusted to PM-Timer: "
 		"%lu (%ld)\n", (unsigned long)res, *delta);
 	*delta = (long)res;
@@ -739,7 +739,7 @@ calibrate_by_pmtimer(long deltapm, long *delta, long *deltatsc)
 	/* Correct the tsc counter value */
 	if (boot_cpu_has(X86_FEATURE_TSC)) {
 		res = (((u64)(*deltatsc)) * pm_100ms);
-		do_div(res, deltapm);
+		res = div64_ul(res, deltapm);
 		apic_printk(APIC_VERBOSE, "TSC delta adjusted to "
 					  "PM-Timer: %lu (%ld)\n",
 					(unsigned long)res, *deltatsc);
-- 
2.43.2


