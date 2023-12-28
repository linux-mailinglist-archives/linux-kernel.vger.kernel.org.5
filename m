Return-Path: <linux-kernel+bounces-12843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5936681FB1B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFAF1C2373C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ED01096C;
	Thu, 28 Dec 2023 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTS/Is/R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DCF107A4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5e54d40cca2so40808897b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703794181; x=1704398981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTJvjOs9CDMbScRZQ2ed7lVLiXIATMKcHXT0ZLGRjno=;
        b=mTS/Is/R17lJ6dI4n66t1gdgquPt5KIYB4dkAHxanoYbD1qTSQ/hIUha+3mjJyJ+Kd
         ZLVfHQ5eZ3j2CkXDYze10iDiyEldjuT9VSX6c+9199g3krpYMb+XBYOGxh9n8DuruI33
         Kx6O5rjEeZPrw5arNdat0t8H60zgEtnlSQ1GOgekDG/BH3LsqgL9cq0VBtXt+GDPTRtc
         KijHiufAbd5EmRqUCjZOtI1j/572cFNi+b6xRemGoiVzBYO81feOPVjY9twmhFdWQQG1
         x+CSEcAtcaEuq7EilWZ4kDAenLTKzf0RYDjKS8GH4EUPBf9ZLbz9eVIWMdNoTNe//br/
         ++kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703794181; x=1704398981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTJvjOs9CDMbScRZQ2ed7lVLiXIATMKcHXT0ZLGRjno=;
        b=uh2LXB1SYqvbjpTloV9gFXYXSmid9AvmkJop8pNes9iPAQWV6GD3hbgk+GN1Mc2mdX
         kMt/LjhZlK62tuhJrR7zC7j35m+F6Pl78KZTQTnWG0X+VGcVJXAe4bqLK3IcA4eB5m7L
         14JV1EnnL18cKY0prV59YBbxnOhvjZETL6f0WwLWiHL6HBia//ZOrO9SXd4oLZXKDjpP
         D+L37gd+omMsIDMp7hiVFrTZE1JZX/zyUarqxxyFL5wAzPDpil4QgYPcobphNj0Ioo4S
         q74mxDT1fS7YWddxBWi81icWFim2dxxlFffVtbQAarkmiBIdbjaRLTBKLQhEU6fURouV
         gPIg==
X-Gm-Message-State: AOJu0YzEI+WPtaJKQZrC4DnT29GZKsGok+D0pG/GzSOikpEggFD+JknN
	dQrZz9OBw/jRD//gVAgw71E=
X-Google-Smtp-Source: AGHT+IGGhx2yGE46hMQp8zWymRb4aaEZ/el9a7/MCTXYKakHGTFSkhELP8lH16OaCVxTEwpniW74vg==
X-Received: by 2002:a81:5483:0:b0:5e5:39aa:2b4e with SMTP id i125-20020a815483000000b005e539aa2b4emr4631014ywb.26.1703794181469;
        Thu, 28 Dec 2023 12:09:41 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:967c:a333:ae09:3f60])
        by smtp.gmail.com with ESMTPSA id c67-20020a814e46000000b005e4d89b4520sm7743452ywb.47.2023.12.28.12.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 12:09:40 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 2/9] lib/group_cpus: optimize inner loop in grp_spread_init_one()
Date: Thu, 28 Dec 2023 12:09:29 -0800
Message-Id: <20231228200936.2475595-3-yury.norov@gmail.com>
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

The loop starts from the beginning every time we switch to the next
sibling mask. This is the Schlemiel the Painter's style of coding
because we know for sure that nmsk is clear up to the current CPU,
and we can just continue from the next CPU.

Also, we can do it nicer if leverage the dedicated for_each() iterator,
and simplify the logic of clearing a bit in nmsk.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/group_cpus.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index ee272c4cefcc..063ed9ae1b8d 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -30,14 +30,14 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 
 		/* If the cpu has siblings, use them first */
 		siblmsk = topology_sibling_cpumask(cpu);
-		for (sibl = -1; cpus_per_grp > 0; ) {
-			sibl = cpumask_next(sibl, siblmsk);
-			if (sibl >= nr_cpu_ids)
-				break;
-			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
-				continue;
+		sibl = cpu + 1;
+
+		for_each_cpu_and_from(sibl, siblmsk, nmsk) {
+			if (cpus_per_grp-- == 0)
+				return;
+
+			cpumask_clear_cpu(sibl, nmsk);
 			cpumask_set_cpu(sibl, irqmsk);
-			cpus_per_grp--;
 		}
 	}
 }
-- 
2.40.1


