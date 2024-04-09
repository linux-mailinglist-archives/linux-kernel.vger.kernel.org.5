Return-Path: <linux-kernel+bounces-136687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B8B89D720
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E931B283CEA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB548288C;
	Tue,  9 Apr 2024 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R6FaY/31";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rx9WtC/z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7EA80629;
	Tue,  9 Apr 2024 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712659164; cv=none; b=uXmaa7MGSJePYD654mdkR08yi6mHarzb4Y0xo06K3GRPNbhM2JYhHZ70rOZfQQbTQ6jZkZlSZkmYWVlcDiTPIWzF1cR3bgfwc7iXofw9XmGBzsydlO2Pk5rnwhsqcYWt2D+dQvzJ0rVywAbztAqvPLoqDDLxdpIxU6zCO4+vRGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712659164; c=relaxed/simple;
	bh=vBNAaRtilA1/KMENPluIi7E66a5NrejGivslYU/h5Sg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sAIPXrY2oykFRgGfaAXU/f9m3tTaMbHrGi4j98TzRST7S5vLAzb3JsrSFcemw9YeMnGuzop3tWllETLrej7UCcNDtA/FW0RMxBBmZtVczAReBLL4cfw8MNFVOyapiofRiONvlGNj+QiPQjL8gR2i8c3L5iDqT685jo5T2xqLZxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R6FaY/31; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rx9WtC/z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 10:39:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712659161;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gttQIJNL59zhUjHn8cD/dhDt+wymKBNBfaeDovjPI0I=;
	b=R6FaY/31obJLMPAoML9JCPWm1pyUzdsfM5eIJIVSi6ZOuKLW3L9wd8RI0q6uy2GXbPhoiZ
	lkt8fVeAiZ985sSk6BXzE5r/uOyg82ELcalnYAeldqrS8g0UyEqamE3jMJEOXBkiWQW7Cd
	B/fUboeY78ks39p5zfZGs/bf0IVpkk6D4/8w2E404loN7zz2E8/iJoPmkcofHTo2A1bPTQ
	8HCZyMqmxIxDf2vBmSQFN4UPpXEDgzRQcIGyc98GyIaFwZmO+ipvzaLFuMuh3qQqQCLY3/
	8pu2jjPd+/gaa2UblesTk8mgH2lKoWCWB90FxJ/+22q65lFu7yiZjxNTJrsfHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712659161;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gttQIJNL59zhUjHn8cD/dhDt+wymKBNBfaeDovjPI0I=;
	b=Rx9WtC/zamSx7UwVghWU9xlB2QQyIrXbaF/QRA5HMi/eJcHXyXX0SiQCt8M6dkBJpZb0cq
	JF9czO9Vc+r2QDBw==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] vdso: Fix powerpc build U64_MAX undeclared error
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240409062639.3393-1-adrian.hunter@intel.com>
References: <20240409062639.3393-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171265916054.10875.8484801130571607744.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8ff1e6c5aca5fd908e81c33c460c45f9555e1c22
Gitweb:        https://git.kernel.org/tip/8ff1e6c5aca5fd908e81c33c460c45f9555e1c22
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Tue, 09 Apr 2024 09:26:39 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Apr 2024 12:35:19 +02:00

vdso: Fix powerpc build U64_MAX undeclared error

U64_MAX is not in include/vdso/limits.h, although that isn't noticed on x86
because x86 includes include/linux/limits.h indirectly. However powerpc is
more selective, resulting in the following build error:

  In file included from <command-line>:
  lib/vdso/gettimeofday.c: In function 'vdso_calc_ns':
  lib/vdso/gettimeofday.c:11:33: error: 'U64_MAX' undeclared
     11 | # define VDSO_DELTA_MASK(vd)    U64_MAX
        |                                 ^~~~~~~

Use ULLONG_MAX instead which will work just as well and is in
include/vdso/limits.h.

Fixes: c8e3a8b6f2e6 ("vdso: Consolidate vdso_calc_delta()")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240409062639.3393-1-adrian.hunter@intel.com
Closes: https://lore.kernel.org/all/20240409124905.6816db37@canb.auug.org.au/
---
 lib/vdso/gettimeofday.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 9c3a8d2..899850b 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -8,7 +8,7 @@
 #ifndef vdso_calc_ns
 
 #ifdef VDSO_DELTA_NOMASK
-# define VDSO_DELTA_MASK(vd)	U64_MAX
+# define VDSO_DELTA_MASK(vd)	ULLONG_MAX
 #else
 # define VDSO_DELTA_MASK(vd)	(vd->mask)
 #endif

