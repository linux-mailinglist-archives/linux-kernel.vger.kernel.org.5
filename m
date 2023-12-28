Return-Path: <linux-kernel+bounces-12842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA57E81FB19
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D8C1F238C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B781107BB;
	Thu, 28 Dec 2023 20:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hX87VFm6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D9A101F8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 20:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7b3b819f8a3so338100439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703794180; x=1704398980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+ncE/Ke8W/9eSicUFGfjAMk7XfHt6TzmaC+XB67O8c=;
        b=hX87VFm68TvZCoWI+oNASYDa+8iXTtG2+fel4NQMpBYpefiZvwQ3Kg3aAImVHF+oYU
         vbhMvx76dOKygUsn/UwBWjwIgkUEvm0Z8y3nL+1KZXngwaxYauy0gTEpKbdD9gLr+tiZ
         rBEVQcV/bfbwelTKtpU7X2X1SP85D5t/+UtUEs8ELkvQ6+UBDxEYQX4wI2hm4gGsDEPu
         dVR5VTnAA45WC07+e7fyqD9YaJsTZgrJI5ir6UroQm26ggVD6WcqNIqfEhibqQB9wklw
         g7gZD/j6/uc0SIZsLzQ/LqZuNbY4Bz5V/Dknc5S7P074yKB0Of3MekqFmni4ELdpDz91
         NZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703794180; x=1704398980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+ncE/Ke8W/9eSicUFGfjAMk7XfHt6TzmaC+XB67O8c=;
        b=IPcjWVqVWPJaQmLmrxhfFt97RqfhdO39lwruIpiNOjnp5s1HP2hiduBkzvvWxaqwwC
         KR6bnApTdCnzQhfxtrd1/CZ+RhzklOE0ti/+2THXr8vKgjAEWReSdR1Gaz6otHrBltZZ
         vuVZKY7QEbl7WW6CDNqbvq8KzFVSoN4rSRPNUKAVtEUX8QeiLio0Y4t0DCYZ6iuVwB0v
         ikYJrX0M/HYH74AbDVZVG+v98WDFHPp3uvMyej22Vp2OQMnO/fvo+0908FwkodwAvAv9
         krzHEflaDYTFqLq18ykGa12NAsZ7ZlNConzkvb/CVvVnIij2lV5AJHSIaVeqEc4Igey3
         hh4Q==
X-Gm-Message-State: AOJu0YxjAcL1zFasFNYsU+FTpi1W1TPjZfiiFdZEsM3LXbNisoeLrBBE
	/oUU3jYlbT6/LlEGDWkFr4M=
X-Google-Smtp-Source: AGHT+IEuA7vQwpAxd31H9FBHqzWEuKeId5J+ssN4C4kptziIh6MKYskaoMQzEIuv8u3BjcqQL5u6Fw==
X-Received: by 2002:a05:6e02:1c4e:b0:35f:d727:1dba with SMTP id d14-20020a056e021c4e00b0035fd7271dbamr9385256ilg.63.1703794179967;
        Thu, 28 Dec 2023 12:09:39 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:967c:a333:ae09:3f60])
        by smtp.gmail.com with ESMTPSA id d3-20020a0df403000000b0059f766f9750sm7825671ywf.124.2023.12.28.12.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 12:09:39 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 1/9] cpumask: introduce for_each_cpu_and_from()
Date: Thu, 28 Dec 2023 12:09:28 -0800
Message-Id: <20231228200936.2475595-2-yury.norov@gmail.com>
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

Similarly to for_each_cpu_and(), introduce a for_each_cpu_and_from(),
which is handy when it's needed to traverse 2 cpumasks or bitmaps,
starting from a given position.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 11 +++++++++++
 include/linux/find.h    |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index cfb545841a2c..73ff2e0ef090 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -332,6 +332,17 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
 #define for_each_cpu_and(cpu, mask1, mask2)				\
 	for_each_and_bit(cpu, cpumask_bits(mask1), cpumask_bits(mask2), small_cpumask_bits)
 
+/**
+ * for_each_cpu_and_from - iterate over every cpu in both masks starting from a given cpu
+ * @cpu: the (optionally unsigned) integer iterator
+ * @mask1: the first cpumask pointer
+ * @mask2: the second cpumask pointer
+ *
+ * After the loop, cpu is >= nr_cpu_ids.
+ */
+#define for_each_cpu_and_from(cpu, mask1, mask2)				\
+	for_each_and_bit_from(cpu, cpumask_bits(mask1), cpumask_bits(mask2), small_cpumask_bits)
+
 /**
  * for_each_cpu_andnot - iterate over every cpu present in one mask, excluding
  *			 those present in another.
diff --git a/include/linux/find.h b/include/linux/find.h
index 5e4f39ef2e72..dfd3d51ff590 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -563,6 +563,9 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 	     (bit) = find_next_and_bit((addr1), (addr2), (size), (bit)), (bit) < (size);\
 	     (bit)++)
 
+#define for_each_and_bit_from(bit, addr1, addr2, size) \
+	for (; (bit) = find_next_and_bit((addr1), (addr2), (size), (bit)), (bit) < (size); (bit)++)
+
 #define for_each_andnot_bit(bit, addr1, addr2, size) \
 	for ((bit) = 0;									\
 	     (bit) = find_next_andnot_bit((addr1), (addr2), (size), (bit)), (bit) < (size);\
-- 
2.40.1


