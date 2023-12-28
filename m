Return-Path: <linux-kernel+bounces-12848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C24C81FB20
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6704A1C2360F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FBE11C9D;
	Thu, 28 Dec 2023 20:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzeQM+vF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7DC11705
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7b7d55d7717so293128539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703794188; x=1704398988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfZWh6S86hfLbf3ALuySh4PKa92mkoOaYgRP6tzCQaQ=;
        b=UzeQM+vFVJ1Z33zQAvAHTAHjxGTHwLNIeQX066HcWxc6uwdbYCagg+E8AEPY1hGbpJ
         /kBzDFdin6YQbFBPIU6J7Zi8XwzZJkYaZK2IBG48MKqhJOC6FVwuJwMoJpkTfPhRzmCu
         dsUh80Fg0dhuYsSZGOjlRBbUqkhgm4GQg2hzPHBVW79L+xXq2N6srNINPwgr2DyHcyrD
         tBteBTkeQuvMdrWiZPiNIm/k3WHOEzCz3LuXz0bPj+89T/TpuJQOW69IGtemCht+KNxD
         va/rA+EQtXBE3dq/GVxsCBsAsSflH4jYmZJH94jo4dUFco1WyLgg5Zwze2LYmcxTfpb2
         j12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703794188; x=1704398988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfZWh6S86hfLbf3ALuySh4PKa92mkoOaYgRP6tzCQaQ=;
        b=ZRYcMNfht/Nbvno9lIxDTh/rWIeZNR929kuUvgJf/OrDJARxoMr4bwViRVe57Io2QN
         Ctv89QW79lp1e/8thfAWO+xmzNm1AjugBXj2IrbMxMd6Wi832Nn4i9qy4fz96F1Ju0qs
         nap2M5cK65zy2Qn56tUhGHr/bsluXmbNkhfGkWExJTQy4fxhQ2643qO+gZy0/ZCASUEK
         co55vlYxyFERy/Bj/nHXvdNASv4d1CKwYm0vRN7dZJbW/7td3DMbGPPdWdCMeVj1Qi+Y
         rl+2O0rgh/KkVbdojGrGiLtl3Hwv1P9SDDYK+DA7s1hVyfRdbbvodI2rS28b3gWm3s5b
         lVWg==
X-Gm-Message-State: AOJu0YwKJLyjW3Uzevt2O+ywB5300brwQqyYGm4pKvVNW6tjbtnm8VdF
	ZMvqmgkVtv/N8JTXKnIbtr0=
X-Google-Smtp-Source: AGHT+IG9Lqqh2T5AlaAupitak9SDKW67lW/8ZquP3N4mohdxhGbx0NttQfb1TF3K5GkIEQUNGQzi2w==
X-Received: by 2002:a05:6e02:1785:b0:35f:e9a7:372a with SMTP id y5-20020a056e02178500b0035fe9a7372amr11090768ilu.47.1703794188311;
        Thu, 28 Dec 2023 12:09:48 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:967c:a333:ae09:3f60])
        by smtp.gmail.com with ESMTPSA id gz17-20020a05690c471100b005e93604a567sm7604354ywb.52.2023.12.28.12.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 12:09:47 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 7/9] cpumask: define cleanup function for cpumasks
Date: Thu, 28 Dec 2023 12:09:34 -0800
Message-Id: <20231228200936.2475595-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228200936.2475595-1-yury.norov@gmail.com>
References: <20231228200936.2475595-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now we can simplify a code that allocates cpumasks for local needs.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 73ff2e0ef090..f85515ebcf42 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -7,6 +7,7 @@
  * set of CPUs in a system, one bit position per CPU number.  In general,
  * only nr_cpu_ids (<= NR_CPUS) bits are valid.
  */
+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/threads.h>
 #include <linux/bitmap.h>
@@ -988,6 +989,8 @@ static inline bool cpumask_available(cpumask_var_t mask)
 }
 #endif /* CONFIG_CPUMASK_OFFSTACK */
 
+DEFINE_FREE(free_cpumask_var, struct cpumask *, if (_T) free_cpumask_var(_T));
+
 /* It's common to want to use cpu_all_mask in struct member initializers,
  * so it has to refer to an address rather than a pointer. */
 extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
-- 
2.40.1


