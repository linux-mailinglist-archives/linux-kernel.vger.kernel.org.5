Return-Path: <linux-kernel+bounces-135406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7AA89C0E7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0DC8B24A75
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D170083A0E;
	Mon,  8 Apr 2024 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NGLRCYw1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZXalsxFj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB4980638;
	Mon,  8 Apr 2024 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581848; cv=none; b=SJc9IRktJwmi/VBu8WvSSp20kgLK+6u8qtwnCmBiWoz0rNTQbFiZtoPBr2LNW6b5G4dYGogskFMx/TLNY8nY0vtPt2GFAVPXG5uzXX1kQQX9gkzW4kdhNcVlX9EvZFL+amvqBkKWelv0LW4D2K71MGhZKdgKlVjfIQMyrx8Bqo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581848; c=relaxed/simple;
	bh=FPf+2P8KFihieaj2JoLCYxeyIhusEiFj7vKfxc8+TLs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QrkMPYJW8ajwnxmtUTQOh11GEEcqK9Si9uzX55oie1OI8t25oBjqk6IAN+2avgkrQHrztuiOfig1+O5R2JxATNE927eWFUeDHrLPU769hf5bo3bGZbApnZyXRgDkN8v380JjQQj6Sa+nPvOL4Pahwf+Y0B9oYokqQcqXUBiVRAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NGLRCYw1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZXalsxFj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 13:10:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712581845;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6SdYy8Rxqm8/RGnP2xgqbjtm7whOGr2UBHpH7c3/PA=;
	b=NGLRCYw1t9IEif6NEL3z1V3PD8z7VSIlKeQ8zcuLi9vop3TO4AA92Mz5emShXhdv4/jZ20
	sxnjD9vPxCLd00uZ6j+etr6NuAjw7qlwj1i+HKp3HyRUAD5ejEMdGpwI2mNR2V2Ms3+sWS
	6YJz6P4e9bv3e7XJtW0LrkvQVqqy56U6mCY6F++MyPiKPnGd3qtdwUMfzDW8fsde9gGta5
	zFb5QUw93gOhvBwj9z6j4tseQmYilJHFoU0pZa2YvPU5978C6/egk8h2vviRecOLaHffym
	6EUU2o1sPF49YS4rA8cId2rEIMXzEctr5V5zVPnQLXm0P5V2tr+PUiedKTDruQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712581845;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6SdYy8Rxqm8/RGnP2xgqbjtm7whOGr2UBHpH7c3/PA=;
	b=ZXalsxFj+7ofBKE4wR5DAanMPI1F207Wt6x+dWckrqv5QNIryk+SbJy71aDFdpTjvGleD3
	CN20VlrpcGQknKAQ==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] vdso: Consolidate nanoseconds calculation
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325064023.2997-3-adrian.hunter@intel.com>
References: <20240325064023.2997-3-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258184409.10875.16644898278425182282.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5b26ef660a690e424d9548fdf0565d4172d5d88f
Gitweb:        https://git.kernel.org/tip/5b26ef660a690e424d9548fdf0565d4172d5d88f
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 25 Mar 2024 08:40:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 15:03:06 +02:00

vdso: Consolidate nanoseconds calculation

Consolidate nanoseconds calculation to simplify and reduce code
duplication.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240325064023.2997-3-adrian.hunter@intel.com

---
 arch/x86/include/asm/vdso/gettimeofday.h | 17 ++++-----
 lib/vdso/gettimeofday.c                  | 43 ++++++++++-------------
 2 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index 8e048ca..5727ded 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -300,7 +300,7 @@ static inline bool arch_vdso_cycles_ok(u64 cycles)
 #define vdso_cycles_ok arch_vdso_cycles_ok
 
 /*
- * x86 specific delta calculation.
+ * x86 specific calculation of nanoseconds for the current cycle count
  *
  * The regular implementation assumes that clocksource reads are globally
  * monotonic. The TSC can be slightly off across sockets which can cause
@@ -308,8 +308,8 @@ static inline bool arch_vdso_cycles_ok(u64 cycles)
  * jump.
  *
  * Therefore it needs to be verified that @cycles are greater than
- * @last. If not then use @last, which is the base time of the current
- * conversion period.
+ * @vd->cycles_last. If not then use @vd->cycles_last, which is the base
+ * time of the current conversion period.
  *
  * This variant also uses a custom mask because while the clocksource mask of
  * all the VDSO capable clocksources on x86 is U64_MAX, the above code uses
@@ -317,25 +317,24 @@ static inline bool arch_vdso_cycles_ok(u64 cycles)
  * declares everything with the MSB/Sign-bit set as invalid. Therefore the
  * effective mask is S64_MAX.
  */
-static __always_inline
-u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
+static __always_inline u64 vdso_calc_ns(const struct vdso_data *vd, u64 cycles, u64 base)
 {
 	/*
 	 * Due to the MSB/Sign-bit being used as invalid marker (see
 	 * arch_vdso_cycles_valid() above), the effective mask is S64_MAX.
 	 */
-	u64 delta = (cycles - last) & S64_MAX;
+	u64 delta = (cycles - vd->cycle_last) & S64_MAX;
 
 	/*
 	 * Due to the above mentioned TSC wobbles, filter out negative motion.
 	 * Per the above masking, the effective sign bit is now bit 62.
 	 */
 	if (unlikely(delta & (1ULL << 62)))
-		return 0;
+		return base >> vd->shift;
 
-	return delta * mult;
+	return ((delta * vd->mult) + base) >> vd->shift;
 }
-#define vdso_calc_delta vdso_calc_delta
+#define vdso_calc_ns vdso_calc_ns
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index faccf12..9fa90e0 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -5,31 +5,32 @@
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
 
-#ifndef vdso_calc_delta
+#ifndef vdso_calc_ns
 
 #ifdef VDSO_DELTA_NOMASK
-# define VDSO_DELTA_MASK(mask)	U64_MAX
+# define VDSO_DELTA_MASK(vd)	U64_MAX
 #else
-# define VDSO_DELTA_MASK(mask)	(mask)
+# define VDSO_DELTA_MASK(vd)	(vd->mask)
+#endif
+
+#ifndef vdso_shift_ns
+static __always_inline u64 vdso_shift_ns(u64 ns, u32 shift)
+{
+	return ns >> shift;
+}
 #endif
 
 /*
  * Default implementation which works for all sane clocksources. That
  * obviously excludes x86/TSC.
  */
-static __always_inline
-u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
+static __always_inline u64 vdso_calc_ns(const struct vdso_data *vd, u64 cycles, u64 base)
 {
-	return ((cycles - last) & VDSO_DELTA_MASK(mask)) * mult;
-}
-#endif
+	u64 delta = (cycles - vd->cycle_last) & VDSO_DELTA_MASK(vd);
 
-#ifndef vdso_shift_ns
-static __always_inline u64 vdso_shift_ns(u64 ns, u32 shift)
-{
-	return ns >> shift;
+	return vdso_shift_ns((delta * vd->mult) + base, vd->shift);
 }
-#endif
+#endif /* vdso_calc_ns */
 
 #ifndef __arch_vdso_hres_capable
 static inline bool __arch_vdso_hres_capable(void)
@@ -56,10 +57,10 @@ static inline bool vdso_cycles_ok(u64 cycles)
 static __always_inline int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
 					  struct __kernel_timespec *ts)
 {
-	const struct vdso_data *vd;
 	const struct timens_offset *offs = &vdns->offset[clk];
 	const struct vdso_timestamp *vdso_ts;
-	u64 cycles, last, ns;
+	const struct vdso_data *vd;
+	u64 cycles, ns;
 	u32 seq;
 	s64 sec;
 
@@ -80,10 +81,7 @@ static __always_inline int do_hres_timens(const struct vdso_data *vdns, clockid_
 		cycles = __arch_get_hw_counter(vd->clock_mode, vd);
 		if (unlikely(!vdso_cycles_ok(cycles)))
 			return -1;
-		ns = vdso_ts->nsec;
-		last = vd->cycle_last;
-		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
-		ns = vdso_shift_ns(ns, vd->shift);
+		ns = vdso_calc_ns(vd, cycles, vdso_ts->nsec);
 		sec = vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vd, seq)));
 
@@ -118,7 +116,7 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 				   struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
-	u64 cycles, last, sec, ns;
+	u64 cycles, sec, ns;
 	u32 seq;
 
 	/* Allows to compile the high resolution parts out */
@@ -151,10 +149,7 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 		cycles = __arch_get_hw_counter(vd->clock_mode, vd);
 		if (unlikely(!vdso_cycles_ok(cycles)))
 			return -1;
-		ns = vdso_ts->nsec;
-		last = vd->cycle_last;
-		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
-		ns = vdso_shift_ns(ns, vd->shift);
+		ns = vdso_calc_ns(vd, cycles, vdso_ts->nsec);
 		sec = vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vd, seq)));
 

