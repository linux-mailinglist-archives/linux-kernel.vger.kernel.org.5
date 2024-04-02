Return-Path: <linux-kernel+bounces-128724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDCA895EAA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B065B21103
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1E015E5C7;
	Tue,  2 Apr 2024 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPGKER3q"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3D315E215;
	Tue,  2 Apr 2024 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092954; cv=none; b=YjTeSK1pSVXotjOULMAgaUWrysNsg2nWjM6xYRGJMa75i4ZMC2JoHikRdUrnSpjiSBn9TzP0RinJ++1gNkSxubi0d7R4FZ2I/WfvT6P6yy/Wc9+NipDx1FEAjbuVRt8sumwz6LqC5rqXeLCOL6+Ea+iRwapBylAjhchUEUbZj/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092954; c=relaxed/simple;
	bh=68s9jtYdcYGDR0kZCfIkamlbUFgOfRFqc1cC0+Lp03E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OAS8USlW+b6A0S29nEP9/8W62Bay66ChaGrquEFoIc6jfL6eZVDNDzi9bJBJQiJFOtGs8IuFKYn3gqBO5QF8zoXKurOLP6qSTuYG6LtV0RIxP2FAwmzqKgvq+4ATr87Ohgc2VG/nHDuptSqNoXG7Uzy5K1aQcY/rHb1UmFGxC8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPGKER3q; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c3d3710018so3872894b6e.0;
        Tue, 02 Apr 2024 14:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712092951; x=1712697751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6dcAJ3rmAchD5+sDV3IumTxh3WKkWo+qrMSX95SeE3A=;
        b=lPGKER3qLRCN82XW7Ps52n1ZswlZy8CTtoqDnZlJous6JoQrz1sOxfMQ8GjojNeimi
         xU8Oqk1dAjVPmQe13mwpaxOPZgB5a2cs7GQ0LGi87MvSma5fHmTvUIS2yteNjl/rd0UP
         tNDAEBv7O1v5IZlP2gQy9G5lXHDoEPQMNIoRjUeKvklk1ZJ7j3DHtNT94KUCJeyKytxD
         cQ97rMH66GypZZ7/s+Lag4oys/H+3eUUnP2Z5JY+Aa+FBOdTubqvKrHfkQpZuTpPIEEk
         tRt48WmH92C2D3qU54tjtBmD8kTAhK8JzAbjOMBdrazMqF4XV67OE9uP/baXcqeWk3Ik
         GDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712092951; x=1712697751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6dcAJ3rmAchD5+sDV3IumTxh3WKkWo+qrMSX95SeE3A=;
        b=V5RHI01lN1BhfbMHevE8vDaBQ1yI+Xl5GZ0jbiqFaQRNZZiIg65ELIZWc1iQiv50OU
         ZQaVdt8cOxrUdGt+WO4z2Q4eXES0Mq+E92g/lQVs9+b9xg1fd60PivveVmA/cdnE7SDY
         s1SJD5VtLN4KHtEdb43sYkuv+4nrx6Ndip9gkncQO1B80oh7Bn5rrC/85RrDuriphyJv
         TbFNFsYuW58icrCBSoN1ucPlcb40BPdphQyRxf1bgntNKo9GveeGzEvTReblo2NTq1ib
         6mFUyZYUL4hC1S22qgA89TH3I/gnE0jQUWmKfnmVRNOsUu7otu8IE0GcQYXc2LQhEfa8
         qtCg==
X-Forwarded-Encrypted: i=1; AJvYcCWPkHo8voNRzjjOT+2e1C5H3/B0kafT92sg8XmzIjWmM+UCUbk9x740fs1A2dvOjmiO93Rc20LzPZ4DYP45uttze4BQBJ0j6JGsQ7wnB3GqH3EIhAEF0W8s11en6Bm2o1Qp
X-Gm-Message-State: AOJu0YxIWisU1kk2jwCSNVDJvCC11HkGZWFDcVR6J5DfNSJ/P10Sd3m7
	NIARM3CFhC0dOJO6QYYH+BIDoYSU9OwaOjRFiStNRQ0eXpaFymsC
X-Google-Smtp-Source: AGHT+IHYFajXI9esfIMmetv5rHIYA8iHuw/IH4DLh0P6g6/9wXvup+VZEVYuT3KF7gzsSv519sHKSA==
X-Received: by 2002:a05:6808:128c:b0:3c3:520b:d163 with SMTP id a12-20020a056808128c00b003c3520bd163mr814208oiw.49.1712092951353;
        Tue, 02 Apr 2024 14:22:31 -0700 (PDT)
Received: from lima-default.myfiosgateway.com (pool-108-50-252-180.nwrknj.fios.verizon.net. [108.50.252.180])
        by smtp.gmail.com with ESMTPSA id ey25-20020a05622a4c1900b00431612e7111sm5933785qtb.41.2024.04.02.14.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 14:21:46 -0700 (PDT)
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
To: ast@kernel.org
Cc: harishankar.vishwanathan@rutgers.edu,
	paul@isovalent.com,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Matan Shachnai <m.shachnai@rutgers.edu>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Edward Cree <ecree@solarflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 bpf-next] bpf: Fix latent unsoundness in and/or/xor value tracking
Date: Tue,  2 Apr 2024 17:20:38 -0400
Message-Id: <20240402212039.51815-1-harishankar.vishwanathan@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scalar(32)_min_max_and/or/xor functions can exhibit unsound behavior
when setting signed bounds. The following example illustrates the issue for
scalar_min_max_and(), but it applies to the other functions.

In scalar_min_max_and() the following clause is executed when ANDing
positive numbers:

		/* ANDing two positives gives a positive, so safe to
		 * cast result into s64.
		 */
		dst_reg->smin_value = dst_reg->umin_value;
		dst_reg->smax_value = dst_reg->umax_value;

However, if umin_value and umax_value of dst_reg cross the sign boundary
(i.e., if (s64)dst_reg->umin_value > (s64)dst_reg->umax_value), then we
will end up with smin_value > smax_value, which is unsound.

Previous works [1, 2] have discovered and reported this issue. Our tool
Agni [2, 3] consideres it a false positive. This is because, during the
verification of the abstract operator scalar_min_max_and(), Agni restricts
its inputs to those passing through reg_bounds_sync(). This mimics
real-world verifier behavior, as reg_bounds_sync() is invariably executed
at the tail of every abstract operator. Therefore, such behavior is
unlikely in an actual verifier execution.

However, it is still unsound for an abstract operator to set signed bounds
such that smin_value > smax_value. This patch fixes it, making the abstract
operator sound for all (well-formed) inputs.

It is worth noting that we can update the signed bounds using the unsigned
bounds whenever the unsigned bounds do not cross the sign boundary (not
just when the input signed bounds are positive, as was the case
previously). This patch does exactly that.

An alternative approach to fix this latent unsoundness would be to
unconditionally set the signed bounds to unbounded [S64_MIN, S64_MAX], and
let reg_bounds_sync() refine the signed bounds using the unsigned bounds
and the tnum. We found that our approach produces more precise (tighter)
bounds.

For example, consider these inputs to BPF_AND:

/* dst_reg */
var_off.value: 8608032320201083347
var_off.mask: 615339716653692460
smin_value: 8070450532247928832
smax_value: 8070450532247928832
umin_value: 13206380674380886586
umax_value: 13206380674380886586
s32_min_value: -2110561598
s32_max_value: -133438816
u32_min_value: 4135055354
u32_max_value: 4135055354

/* src_reg */
var_off.value: 8584102546103074815
var_off.mask: 9862641527606476800
smin_value: 2920655011908158522
smax_value: 7495731535348625717
umin_value: 7001104867969363969
umax_value: 8584102543730304042
s32_min_value: -2097116671
s32_max_value: 71704632
u32_min_value: 1047457619
u32_max_value: 4268683090

After going through tnum_and() -> scalar32_min_max_and() ->
scalar_min_max_and() -> reg_bounds_sync(), our patch produces the following
bounds for s32:
s32_min_value: -1263875629
s32_max_value: -159911942

Whereas, setting the signed bounds to unbounded in scalar_min_max_and()
produces:
s32_min_value: -1263875629
s32_max_value: -1

As observed, our patch produces a tighter s32 bound. We also confirmed
using Agni and SMT verification that our patch always produces signed
bounds that are equal to or more precise than setting the signed bounds to
unbounded in scalar_min_max_and().

[1] https://sanjit-bhat.github.io/assets/pdf/ebpf-verifier-range-analysis22.pdf
[2] https://link.springer.com/chapter/10.1007/978-3-031-37709-9_12
[3] https://github.com/bpfverif/agni

Fixes: b03c9f9fdc37 ("bpf/verifier: track signed and unsigned min/max values")
Co-developed-by: Matan Shachnai <m.shachnai@rutgers.edu>
Signed-off-by: Matan Shachnai <m.shachnai@rutgers.edu>
Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
---
 kernel/bpf/verifier.c | 94 ++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 51 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fcb62300f407..a7404a7d690f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13326,23 +13326,21 @@ static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
 		return;
 	}
 
-	/* We get our minimum from the var_off, since that's inherently
+	/* We get our minimum from the var32_off, since that's inherently
 	 * bitwise.  Our maximum is the minimum of the operands' maxima.
 	 */
 	dst_reg->u32_min_value = var32_off.value;
 	dst_reg->u32_max_value = min(dst_reg->u32_max_value, umax_val);
-	if (dst_reg->s32_min_value < 0 || smin_val < 0) {
-		/* Lose signed bounds when ANDing negative numbers,
-		 * ain't nobody got time for that.
-		 */
-		dst_reg->s32_min_value = S32_MIN;
-		dst_reg->s32_max_value = S32_MAX;
-	} else {
-		/* ANDing two positives gives a positive, so safe to
-		 * cast result into s64.
-		 */
+
+	/* Safe to set s32 bounds by casting u32 result into s32 when u32
+	 * doesn't cross sign boundary. Otherwise set s32 bounds to unbounded.
+	 */
+	if ((s32)dst_reg->u32_min_value <= (s32)dst_reg->u32_max_value) {
 		dst_reg->s32_min_value = dst_reg->u32_min_value;
 		dst_reg->s32_max_value = dst_reg->u32_max_value;
+	} else {
+		dst_reg->s32_min_value = S32_MIN;
+		dst_reg->s32_max_value = S32_MAX;
 	}
 }
 
@@ -13364,18 +13362,16 @@ static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
 	 */
 	dst_reg->umin_value = dst_reg->var_off.value;
 	dst_reg->umax_value = min(dst_reg->umax_value, umax_val);
-	if (dst_reg->smin_value < 0 || smin_val < 0) {
-		/* Lose signed bounds when ANDing negative numbers,
-		 * ain't nobody got time for that.
-		 */
-		dst_reg->smin_value = S64_MIN;
-		dst_reg->smax_value = S64_MAX;
-	} else {
-		/* ANDing two positives gives a positive, so safe to
-		 * cast result into s64.
-		 */
+
+	/* Safe to set s64 bounds by casting u64 result into s64 when u64
+	 * doesn't cross sign boundary. Otherwise set s64 bounds to unbounded.
+	 */
+	if ((s64)dst_reg->umin_value <= (s64)dst_reg->umax_value) {
 		dst_reg->smin_value = dst_reg->umin_value;
 		dst_reg->smax_value = dst_reg->umax_value;
+	} else {
+		dst_reg->smin_value = S64_MIN;
+		dst_reg->smax_value = S64_MAX;
 	}
 	/* We may learn something more from the var_off */
 	__update_reg_bounds(dst_reg);
@@ -13395,23 +13391,21 @@ static void scalar32_min_max_or(struct bpf_reg_state *dst_reg,
 		return;
 	}
 
-	/* We get our maximum from the var_off, and our minimum is the
-	 * maximum of the operands' minima
+	/* We get our maximum from the var32_off, and our minimum is the
+	 * maximum of the operands' minima.
 	 */
 	dst_reg->u32_min_value = max(dst_reg->u32_min_value, umin_val);
 	dst_reg->u32_max_value = var32_off.value | var32_off.mask;
-	if (dst_reg->s32_min_value < 0 || smin_val < 0) {
-		/* Lose signed bounds when ORing negative numbers,
-		 * ain't nobody got time for that.
-		 */
-		dst_reg->s32_min_value = S32_MIN;
-		dst_reg->s32_max_value = S32_MAX;
-	} else {
-		/* ORing two positives gives a positive, so safe to
-		 * cast result into s64.
-		 */
+
+	/* Safe to set s32 bounds by casting u32 result into s32 when u32
+	 * doesn't cross sign boundary. Otherwise set s32 bounds to unbounded.
+	 */
+	if ((s32)dst_reg->u32_min_value <= (s32)dst_reg->u32_max_value) {
 		dst_reg->s32_min_value = dst_reg->u32_min_value;
 		dst_reg->s32_max_value = dst_reg->u32_max_value;
+	} else {
+		dst_reg->s32_min_value = S32_MIN;
+		dst_reg->s32_max_value = S32_MAX;
 	}
 }
 
@@ -13433,18 +13427,16 @@ static void scalar_min_max_or(struct bpf_reg_state *dst_reg,
 	 */
 	dst_reg->umin_value = max(dst_reg->umin_value, umin_val);
 	dst_reg->umax_value = dst_reg->var_off.value | dst_reg->var_off.mask;
-	if (dst_reg->smin_value < 0 || smin_val < 0) {
-		/* Lose signed bounds when ORing negative numbers,
-		 * ain't nobody got time for that.
-		 */
-		dst_reg->smin_value = S64_MIN;
-		dst_reg->smax_value = S64_MAX;
-	} else {
-		/* ORing two positives gives a positive, so safe to
-		 * cast result into s64.
-		 */
+
+	/* Safe to set s64 bounds by casting u64 result into s64 when u64
+	 * doesn't cross sign boundary. Otherwise set s64 bounds to unbounded.
+	 */
+	if ((s64)dst_reg->umin_value <= (s64)dst_reg->umax_value) {
 		dst_reg->smin_value = dst_reg->umin_value;
 		dst_reg->smax_value = dst_reg->umax_value;
+	} else {
+		dst_reg->smin_value = S64_MIN;
+		dst_reg->smax_value = S64_MAX;
 	}
 	/* We may learn something more from the var_off */
 	__update_reg_bounds(dst_reg);
@@ -13467,10 +13459,10 @@ static void scalar32_min_max_xor(struct bpf_reg_state *dst_reg,
 	dst_reg->u32_min_value = var32_off.value;
 	dst_reg->u32_max_value = var32_off.value | var32_off.mask;
 
-	if (dst_reg->s32_min_value >= 0 && smin_val >= 0) {
-		/* XORing two positive sign numbers gives a positive,
-		 * so safe to cast u32 result into s32.
-		 */
+	/* Safe to set s32 bounds by casting u32 result into s32 when u32
+	 * doesn't cross sign boundary. Otherwise set s32 bounds to unbounded.
+	 */
+	if ((s32)dst_reg->u32_min_value <= (s32)dst_reg->u32_max_value) {
 		dst_reg->s32_min_value = dst_reg->u32_min_value;
 		dst_reg->s32_max_value = dst_reg->u32_max_value;
 	} else {
@@ -13496,10 +13488,10 @@ static void scalar_min_max_xor(struct bpf_reg_state *dst_reg,
 	dst_reg->umin_value = dst_reg->var_off.value;
 	dst_reg->umax_value = dst_reg->var_off.value | dst_reg->var_off.mask;
 
-	if (dst_reg->smin_value >= 0 && smin_val >= 0) {
-		/* XORing two positive sign numbers gives a positive,
-		 * so safe to cast u64 result into s64.
-		 */
+	/* Safe to set s64 bounds by casting u64 result into s64 when u64
+	 * doesn't cross sign boundary. Otherwise set s64 bounds to unbounded.
+	 */
+	if ((s64)dst_reg->umin_value <= (s64)dst_reg->umax_value) {
 		dst_reg->smin_value = dst_reg->umin_value;
 		dst_reg->smax_value = dst_reg->umax_value;
 	} else {
-- 
2.40.1


