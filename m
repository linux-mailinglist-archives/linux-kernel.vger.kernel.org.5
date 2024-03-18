Return-Path: <linux-kernel+bounces-106019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4766587E7A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2A1EB21D46
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6173B2E83C;
	Mon, 18 Mar 2024 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="KWICTmE6"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD01724B26
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710758969; cv=none; b=FCPgqvF7y2tWPZ8GC+RhDYHaFHZ/I6XzBWHsKeV8ndyQHFLjLNmF1sb8dTMv5X5ZC4OAC6efsUxcpatOx1elP+OwqxQjzH8+5CuiXgR2RlGQxHnCivmi7PyZNfEDKxu8/Tl1zqei/YZYeEuMQeu6FpBZwWuhYdpHU5IIKeq/EMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710758969; c=relaxed/simple;
	bh=w8kGD73Xz/uZpQJ5ZgCw6GsFXXl9zD5Qm0dcGMbIXpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4oh5YfxgaDt8dZDcgh3tO93AXds96Nt/pNxZNYbr+1wLb/KuXaQ8Ew7NURn0Ly/ZYay7xrPCZbNggNMoxYCJhLM9oDik7WRxvlMhfO7cuYdJFfILdB0qvzBbpAEOnqyaa1+czyT23lyceG62z+JF10GHHNzywUtR2tuAvbsvvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=KWICTmE6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41413ad1f73so3480725e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 03:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1710758966; x=1711363766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7t60vDpglsBHCmAmlybKd04G36JOxRBGBizt48yxWg=;
        b=KWICTmE6NJO9weCBlZUnGlGljaSiuk6R39tYYCWdc0DeefF7eyIVvQfuJcmDicCPyl
         jH37jR29E9oaYYkcs5Vrrw+FoS6Cs88tMJdU4oesm8eqQbo2OEFpuI8JF0AgfX5IcD5w
         LmF7SH2lGAfxL0trfwCOq58kgIh1UD9X6QL/rE7Tl2pAjdi9kJJnL6sVE/1KidvuUFMB
         qYKVXjpNNlXbsDQL4tqIdDH69HB5b4iRRU11tTPMmzBl3rC2eKjJuZC8IaB7L0ouVJ2k
         fWqv2j0f9mJaqQVuehLTUkedwSPiAIgbgGjBgrgpwSbDgF2Z7mTEW7p24F0VzabpUp7+
         e1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710758966; x=1711363766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7t60vDpglsBHCmAmlybKd04G36JOxRBGBizt48yxWg=;
        b=M1x3KvnsadPb+a+4ofQdwu2dpvhW4c1PaLl0CTGCxd0pQ12P2LgvdhpLH59cFm6os/
         FvW2Nzba3YAs4oZTyu6gp3e95zfpSVZi2mk9pxmH5iCcm9O279ShfTzhGPlQaypEceGv
         q4W2PSFVln9IIEUDUH97mo5Nk2Bb7Io+pwr0iwTr7l3hmPcsHCvNAgN1rWTjdkuLEPfe
         hqE/7X9BsvSFCnygUd/0CDeaash/us8sbj3qJ7+VW2XQ7rW+RVjfI3ajJK+Pjt8n7XrU
         uj54auZmkKT87OGz2JiPx5Ip4Ts5fQLeH3QZfUuSYIqPQQ6DsvDkX7cy4s1p+mj8Pku4
         3CNA==
X-Forwarded-Encrypted: i=1; AJvYcCXoVOSBo90PllSsQ5I/3runlV2d+Y82O89DDCtPResxNvXPkytT320meBx71RzyJNspV6VOLk6QCO9fMH8fTi4zaqo1Ysrq5zYwnoYe
X-Gm-Message-State: AOJu0YxsbOa7KLnj66estAZ7lqZeHI0dy2LvXa2IJKOdR0Jd7mLDESV1
	79CB5X2MsmPF/PO3JRuFqIObD/FnkGWOZn0IFfcm2Pk/ob684YecUvo8HiAT6oUxSnqM6KROW3p
	KPeQ=
X-Google-Smtp-Source: AGHT+IFRTKwvp4NAQQcRK/V8ww6cX01HYijcJTkmICr2vjDu8vieDPT+5eRXaPiSiQ6RMubCEtHFHA==
X-Received: by 2002:a05:600c:1987:b0:413:ee55:8bba with SMTP id t7-20020a05600c198700b00413ee558bbamr5642354wmq.4.1710758965961;
        Mon, 18 Mar 2024 03:49:25 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b00412cfdc41f7sm4899567wms.0.2024.03.18.03.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 03:49:25 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thorsten.blum@toblux.com
Cc: David.Laight@ACULAB.COM,
	bp@alien8.de,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	x86@kernel.org
Subject: [RESEND PATCH v3] x86/apic: Improve data types to fix Coccinelle warnings
Date: Mon, 18 Mar 2024 11:47:23 +0100
Message-ID: <20240318104721.117741-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308230228.3161-2-thorsten.blum@toblux.com>
References: <20240308230228.3161-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Given that acpi_pm_read_early() returns a u32 (masked to 24 bits), several
variables that store its return value are improved by adjusting their data
types from unsigned long to u32. Specifically, change deltapm's type from
long to u32 because its value fits into 32 bits and it cannot be negative.

These data type improvements resolve the following two Coccinelle/
coccicheck warnings reported by do_div.cocci:

arch/x86/kernel/apic/apic.c:734:1-7: WARNING: do_div() does a 64-by-32
division, please consider using div64_long instead.

arch/x86/kernel/apic/apic.c:742:2-8: WARNING: do_div() does a 64-by-32
division, please consider using div64_long instead.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Revert changing do_div() to div64_ul() after feedback from David Laight
- Use u32 instead of unsigned long to fix Coccinelle warnings
- Update patch title and description

Changes in v3:
- Adjust patch summary and description after feedback from Dave Hansen
---
 arch/x86/kernel/apic/apic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 4667bc4b00ab..184e1843620d 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -664,7 +664,7 @@ void lapic_update_tsc_freq(void)
 static __initdata int lapic_cal_loops = -1;
 static __initdata long lapic_cal_t1, lapic_cal_t2;
 static __initdata unsigned long long lapic_cal_tsc1, lapic_cal_tsc2;
-static __initdata unsigned long lapic_cal_pm1, lapic_cal_pm2;
+static __initdata u32 lapic_cal_pm1, lapic_cal_pm2;
 static __initdata unsigned long lapic_cal_j1, lapic_cal_j2;
 
 /*
@@ -674,7 +674,7 @@ static void __init lapic_cal_handler(struct clock_event_device *dev)
 {
 	unsigned long long tsc = 0;
 	long tapic = apic_read(APIC_TMCCT);
-	unsigned long pm = acpi_pm_read_early();
+	u32 pm = acpi_pm_read_early();
 
 	if (boot_cpu_has(X86_FEATURE_TSC))
 		tsc = rdtsc();
@@ -699,7 +699,7 @@ static void __init lapic_cal_handler(struct clock_event_device *dev)
 }
 
 static int __init
-calibrate_by_pmtimer(long deltapm, long *delta, long *deltatsc)
+calibrate_by_pmtimer(u32 deltapm, long *delta, long *deltatsc)
 {
 	const long pm_100ms = PMTMR_TICKS_PER_SEC / 10;
 	const long pm_thresh = pm_100ms / 100;
@@ -710,7 +710,7 @@ calibrate_by_pmtimer(long deltapm, long *delta, long *deltatsc)
 	return -1;
 #endif
 
-	apic_printk(APIC_VERBOSE, "... PM-Timer delta = %ld\n", deltapm);
+	apic_printk(APIC_VERBOSE, "... PM-Timer delta = %u\n", deltapm);
 
 	/* Check, if the PM timer is available */
 	if (!deltapm)
-- 
2.44.0


