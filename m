Return-Path: <linux-kernel+bounces-12845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878A381FB1D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A2B4B23B57
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDA711194;
	Thu, 28 Dec 2023 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtW7GVeC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728B410A0F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 20:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5e7bb1e0db8so51508057b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703794184; x=1704398984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8PF5TYSB+fNMcICiC7EawuixTtkSNVX+hQlbjAGH9E=;
        b=DtW7GVeCm2M3ou5Sx6eirGs1wkcWtbvocVgfrZNscqn969DS7ANqIp3JHFTtbHgmQ5
         NvNuAh+EAu8q4+oKtHYId/0i+IBKjC94Wdkk0fzmll3w4p/O62xAhlUgL7n2e2NhjGAA
         T73oFX9ei/ApmeQEfPlYC7jQOhVD3i/cUcC9aC+tKOWT05tnQW8q2KaXcZOd88hBJ8QW
         3Do1knKCaVp087AGrqVsRzLPV56Q2NBUv+SCy21atoJdotGfjAxksdd5q5TqMpr7hjgF
         9amJq4uEue+8XfAbcZ9q6rQWcvO+1RDXWKHnF6j7BwyaX3YgxKOxVznlMRdrXGDEChG5
         TLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703794184; x=1704398984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8PF5TYSB+fNMcICiC7EawuixTtkSNVX+hQlbjAGH9E=;
        b=iEsjZoQgoa8sou4LYm8XzFq+sHO5UP8jTUtjKN6xxbe6cM9no5TgxiXn62HUO1D6G2
         vtjNaZaVF5XlTWJ2HEuO+IJZzo+yY30AXtnpcUDDAFbCj/KLcM3KtpjXD4OwHd2jcqC3
         z/9zYO47t/6vx5MZ4JeFMsVM9EhrczF3DuY1b/Kpqq8sz8hQ36Ck2OoEc/bbJIHufC/g
         iITczADKUhI62bw2pEfkPnO4HeJcJ85DV1xedDWyAM5HzSruBcfcGobSvVV4EZKKwHtc
         Tpc/WYCI89EHxrMSaLnGBXuOygqekZpH3Pgl4ovvlNDBCM2H0ZWxbvdkRztKpDnc4X3R
         rEOA==
X-Gm-Message-State: AOJu0YwKTKARa9FU+Fx0r3CDb1eeK8CWcbHhltWSKVAc8AdZvboyO2hR
	Z2e3fCVQTNjndrDacG82TM2/Di4d0d4=
X-Google-Smtp-Source: AGHT+IE//TotKL+aI3R/b6hMZ911AUJ74tGL0ZeBQAPRf1IhjLzEzGgTwGUL3iZVBR/XruZIPAKSOA==
X-Received: by 2002:a05:690c:2e92:b0:5eb:eb51:aa5d with SMTP id eu18-20020a05690c2e9200b005ebeb51aa5dmr3908051ywb.28.1703794184189;
        Thu, 28 Dec 2023 12:09:44 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:967c:a333:ae09:3f60])
        by smtp.gmail.com with ESMTPSA id d3-20020a0df403000000b0059f766f9750sm7825729ywf.124.2023.12.28.12.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 12:09:43 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 4/9] lib/group_cpus: optimize outer loop in grp_spread_init_one()
Date: Thu, 28 Dec 2023 12:09:31 -0800
Message-Id: <20231228200936.2475595-5-yury.norov@gmail.com>
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

Similarly to the inner loop, in the outer loop we can use for_each_cpu()
macro, and skip CPUs that have been copied.

With this patch, the function becomes O(1), despite that it's a
double-loop.

While here, add a comment why we can't merge the inner and outer logic.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/group_cpus.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 0a8ac7cb1a5d..952aac9eaa81 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -17,16 +17,17 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 	const struct cpumask *siblmsk;
 	int cpu, sibl;
 
-	for ( ; cpus_per_grp > 0; ) {
-		cpu = cpumask_first(nmsk);
-
-		/* Should not happen, but I'm too lazy to think about it */
-		if (cpu >= nr_cpu_ids)
+	for_each_cpu(cpu, nmsk) {
+		if (cpus_per_grp-- == 0)
 			return;
 
+		/*
+		 * If a caller wants to spread IRQa on offline CPUs, we need to
+		 * take care of it explicitly because those offline CPUS are not
+		 * included in siblings cpumask.
+		 */
 		__cpumask_clear_cpu(cpu, nmsk);
 		__cpumask_set_cpu(cpu, irqmsk);
-		cpus_per_grp--;
 
 		/* If the cpu has siblings, use them first */
 		siblmsk = topology_sibling_cpumask(cpu);
@@ -38,6 +39,7 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 
 			__cpumask_clear_cpu(sibl, nmsk);
 			__cpumask_set_cpu(sibl, irqmsk);
+			cpu = sibl + 1;
 		}
 	}
 }
-- 
2.40.1


