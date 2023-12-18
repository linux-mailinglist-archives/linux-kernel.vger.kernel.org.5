Return-Path: <linux-kernel+bounces-3582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CD5816E12
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62C7E1C2395A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785227D61F;
	Mon, 18 Dec 2023 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lxJ+dgTS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532457EFD5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-55336b3d3c0so626597a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 04:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702903246; x=1703508046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs+j5zfhwbmFpwYioV+9DGlHFgYonyMMkWfDj06Vx9Q=;
        b=lxJ+dgTSRFj/xSbJScprKbh1a2XlGc83TFqd/5Hs/Q8UsEJ3YrXXguhHGzh8xSCM0H
         ypOBIXjnE8jQfJQRKP/4TqZxhAC/9lkvwjHN0U4HN3z3jpVKm2C2fPhBUlhq8P1A5M5V
         e4ATLEt8P0xfHPODKuKLc78ffWMR/NsSIg24iJKbQjVtm1ei4zsRBym2/dV9gVzDqIHN
         qTLvaHJkNATLi5YHHHubfYAEYK2KHBE1pEP0Z8ObJ6xLJAnQMBiV5439Wi+xlm1vtbf9
         kUbWjzEIlqnV2kYDZ44okCIAJH9cZefPJw/nVIHIwlRCfPTWrqqEXkanj9oQpEBkFAX0
         5ABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702903246; x=1703508046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs+j5zfhwbmFpwYioV+9DGlHFgYonyMMkWfDj06Vx9Q=;
        b=fdZwMmG+9OETF/uefS6+6/boiDD4/niHOmYb9ilakad/YMluFhA94ANww0Hs+WcgLt
         ylppPJn5G+Vdyo0zyJRYT3bcTgrs5hYHN4OxkJTpYFaez+hFwDLALGFVXVj6Cw88NCxH
         /J8bau8dAdHyH/KT5ga9romnELr2e9TDlwbg+ICMa6rNbz/lBD974ZSVLjFnsdeYexEZ
         RyOkYcZhU8cLOcXmqs82NT7VF+sHzXWMttM+0rgIJKQiYuDUVy0kaIzYGl0dDBajpghE
         gwkehp4iSxMLLHlkzK3GgB5IzareGgWGS3Nc86/nqd1rIGzEGZCs24FTepUVuJOkB5jr
         EwUA==
X-Gm-Message-State: AOJu0YwKYeqdfNHUBochCKDW7DQhC5Wn15sh9N36qpR3oSD1HGI7Y/ZV
	SjdbuFyu0620Bn0uyZw5qh16tTGFyU0=
X-Google-Smtp-Source: AGHT+IFQVHgRH93m/ueB3XJGh9TO8YJYZZ4U7vSweIWkP1eoMbz/HsT3jdJ+e4LMpQ/IE0AeW1HhdHhT8gY=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:9a3f:c8e7:1395:806e])
 (user=glider job=sendgmr) by 2002:a05:6402:3083:b0:552:fdb5:6de0 with SMTP id
 de3-20020a056402308300b00552fdb56de0mr30708edb.3.1702903246393; Mon, 18 Dec
 2023 04:40:46 -0800 (PST)
Date: Mon, 18 Dec 2023 13:40:29 +0100
In-Reply-To: <20231218124033.551770-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231218124033.551770-1-glider@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218124033.551770-4-glider@google.com>
Subject: [PATCH v11-mte 3/7] lib/test_bitmap: use pr_info() for non-error messages
From: Alexander Potapenko <glider@google.com>
To: glider@google.com, catalin.marinas@arm.com, will@kernel.org, 
	pcc@google.com, andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com, 
	aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk, yury.norov@gmail.com, 
	alexandru.elisei@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"

pr_err() messages may be treated as errors by some log readers, so let
us only use them for test failures. For non-error messages, replace them
with pr_info().

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Acked-by: Yury Norov <yury.norov@gmail.com>

---
v11-mte:
 - add Yury's Acked-by:

v10-mte:
 - send this patch together with the "Implement MTE tag compression for
   swapped pages"
---
 lib/test_bitmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 46c0154680772..a6e92cf5266af 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -507,7 +507,7 @@ static void __init test_bitmap_parselist(void)
 		}
 
 		if (ptest.flags & PARSE_TIME)
-			pr_err("parselist: %d: input is '%s' OK, Time: %llu\n",
+			pr_info("parselist: %d: input is '%s' OK, Time: %llu\n",
 					i, ptest.in, time);
 
 #undef ptest
@@ -546,7 +546,7 @@ static void __init test_bitmap_printlist(void)
 		goto out;
 	}
 
-	pr_err("bitmap_print_to_pagebuf: input is '%s', Time: %llu\n", buf, time);
+	pr_info("bitmap_print_to_pagebuf: input is '%s', Time: %llu\n", buf, time);
 out:
 	kfree(buf);
 	kfree(bmap);
@@ -624,7 +624,7 @@ static void __init test_bitmap_parse(void)
 		}
 
 		if (test.flags & PARSE_TIME)
-			pr_err("parse: %d: input is '%s' OK, Time: %llu\n",
+			pr_info("parse: %d: input is '%s' OK, Time: %llu\n",
 					i, test.in, time);
 	}
 }
@@ -1380,7 +1380,7 @@ static void __init test_bitmap_read_perf(void)
 		}
 	}
 	time = ktime_get() - time;
-	pr_err("Time spent in %s:\t%llu\n", __func__, time);
+	pr_info("Time spent in %s:\t%llu\n", __func__, time);
 }
 
 static void __init test_bitmap_write_perf(void)
@@ -1402,7 +1402,7 @@ static void __init test_bitmap_write_perf(void)
 		}
 	}
 	time = ktime_get() - time;
-	pr_err("Time spent in %s:\t%llu\n", __func__, time);
+	pr_info("Time spent in %s:\t%llu\n", __func__, time);
 }
 
 #undef TEST_BIT_LEN
-- 
2.43.0.472.g3155946c3a-goog


