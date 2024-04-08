Return-Path: <linux-kernel+bounces-135125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5167D89BB68
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2F62816AD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F59148CFC;
	Mon,  8 Apr 2024 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JF2J+7vK"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2BD481B1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567754; cv=none; b=dP0UETwfHHTSObtmVVCcg1FgvF1htq683vWeA4g82S4E87jW1df7HioiHx/GD51X0dUWgKZTfK0pcOnLtFPq/vfqf7l9xMyhiTKN0gJp/7ccp+bWVSpBHPxmQBzckhOKquA4rSlsb5DQSEaXkXoNvN2V4TWs+kE1XvLQiSv4MEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567754; c=relaxed/simple;
	bh=5fuNG4JtxWpa1aHjVE/qQXcnWqkbcXD6PJKqbjZrods=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdscIsXASf80U9udsbTBGA+EIBC8zJoz6QSPjGOdruNiIx84OcOKWRU+c2xvaC1HJwvSwHrfmf5etdmdG/f4JitgfLCpqJcCspxpuKyr5AI8iSSkuHadOAq+kJZcTYmcvGBvZcm9X1FHUx6+C1/7WoDIpAHS41+BgFFYdJdDF4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JF2J+7vK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a465ddc2c09so305029666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712567751; x=1713172551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPyFfFBQRvUn/lSLv41dUDu83F3iOzpaGu3TPie4BR0=;
        b=JF2J+7vKaLEdQCI6Cj0inP7Oh+JKB5vHikt44vGRYbCCSmyAPfws9VI/qTPO9q+7Zy
         T4oGGPwmpWEU3hIynvsJV1GCoLedIRWWj4lORdsmbRCFA6MjBPyQeViTcrKhjrF2VGBp
         mqZCa/5GtRkpy4fESynNjQX0ED4dOLaYDfrcI0ZhYyvwzwt++AmtcTWqKFCidVu3oavr
         CwVv5SMOn3+SUPbXxBmH8xNCMvls1875inNvEtx3M3h4gOHv4ZwLura+y8j2H2xFMo0A
         ugQj5y5fKP55LZuSXeks+b3NTb3Ht/d+FD5KwQlpxzIqwYzhc6yQhUhLWC70o/CEuQIn
         D8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712567751; x=1713172551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPyFfFBQRvUn/lSLv41dUDu83F3iOzpaGu3TPie4BR0=;
        b=VlPYYvDEwX1TzDp3qc0nYhJ9+cjISbtaoocG0lN9PDpbiUOCWi+Yqdgt1D9TKukJas
         hfATBdKxGkPrgVRPR4f3aygv/nyAjhZdpL+qIK1oT9NEsJVoKaNLeeKiV0G+/xDSqWvY
         zkbGNYsrYUdEAd0Yvf1v1l8H8iNXfOMqWLZXuMS8zfHtJ/4txkJc4LFtCkdR+vQMMweM
         E6aSLqkvyrTr9WAznp/nr/t9BVNHXH7Jl1Lc7uhtRRkX71gqz9Wyqe6f6IwXAdh03fm6
         fRwpQLn15GnwkrBjLbhxfizJKUj0SxkMVA/4NqnRFAV9yM1SEVumQBBjvOTH1AR8PM9C
         ibJA==
X-Forwarded-Encrypted: i=1; AJvYcCWIqIBe6HAkx73aa8NTpabqnMGRAwLmR7X8FpkNAs+0GL4g02vp6Bbc3wPadmAQYjAYZHjZPKJmv2fgoBDVjgkhi0eHslI9nlvFyk7+
X-Gm-Message-State: AOJu0YzFeuODarm84qKItU8ZKWF7LOFqirZpS+jsSKH5wHF7+rC5Ty60
	+Eu4jMzSEJjJAqEP7ig9kTThVCNFQ4h1oHx8/jde9VuTj5Mr0YnP
X-Google-Smtp-Source: AGHT+IHcSnn3gVhUuyN6DZXB7/cKEMvpnVjo7Nw8a3pi3ZHMf1OiSgW7NVTMWJPQ/sSDsV1KnDq08g==
X-Received: by 2002:a50:8d5d:0:b0:56e:3f0:a163 with SMTP id t29-20020a508d5d000000b0056e03f0a163mr8217250edt.14.1712567751480;
        Mon, 08 Apr 2024 02:15:51 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id n2-20020a056402434200b0056de7bee45bsm3854201edc.18.2024.04.08.02.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 02:15:51 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/3] locking/atomic/x86: Correct the definition of __arch_try_cmpxchg128()
Date: Mon,  8 Apr 2024 11:13:56 +0200
Message-ID: <20240408091547.90111-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408091547.90111-1-ubizjak@gmail.com>
References: <20240408091547.90111-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the definition of __arch_try_cmpxchg128(), introduced by:

  b23e139d0b66 ("arch: Introduce arch_{,try_}_cmpxchg128{,_local}()")

Fixes: b23e139d0b66 ("arch: Introduce arch_{,try_}_cmpxchg128{,_local}()")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/cmpxchg_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cmpxchg_64.h b/arch/x86/include/asm/cmpxchg_64.h
index 44b08b53ab32..c1d6cd58f809 100644
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -62,7 +62,7 @@ static __always_inline u128 arch_cmpxchg128_local(volatile u128 *ptr, u128 old,
 	asm volatile(_lock "cmpxchg16b %[ptr]"				\
 		     CC_SET(e)						\
 		     : CC_OUT(e) (ret),					\
-		       [ptr] "+m" (*ptr),				\
+		       [ptr] "+m" (*(_ptr)),				\
 		       "+a" (o.low), "+d" (o.high)			\
 		     : "b" (n.low), "c" (n.high)			\
 		     : "memory");					\
-- 
2.44.0


