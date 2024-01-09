Return-Path: <linux-kernel+bounces-20956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A078287C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A93BDB24594
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FE239875;
	Tue,  9 Jan 2024 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NgXP9tg2"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221DB38FB0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40d604b4b30so23506695e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 06:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704809448; x=1705414248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LiZhV/OIK3NB239S+NY81kazxadQtUrasStVnqbtwp8=;
        b=NgXP9tg2dsmGmmvqiT4MGxMZ2X8Yjn64tdaEGG1t5uTr6hwkLZsfkwc0LPD9Gvndft
         DXO/jtw36u96YKehS0+XVrLWNoQ0M+ZPoagHSHf4LzhfwSK9jNUSYnGTTUR1rfITauVB
         sKd5AAT4Nh0RjoWOsS+K4E79AAWv2byHPE9m2NyA6qijpxTt8ftR4XE8LSOwH1qLGDhm
         AW+WpegrOYYtEGbb4TaRvpqHzE9K83rizRlfeheBSEl9oMyCC1zUecIfQ3F0B0Chm633
         b+ZNeBAsakoxiRxQO9KkKEVQceixjViHqFBd1f5DctwhOwDrQdSNOnD24GQtRqCJ+I15
         vlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704809448; x=1705414248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiZhV/OIK3NB239S+NY81kazxadQtUrasStVnqbtwp8=;
        b=PBynjdzQmPkE8ClH49Orge5flGHnXkMb4z7DFRdJfb2SyZ9XGV/hnyN3gkC7OER/A3
         JYznPA3wc+Q0Kx8THqPzX/wxHUx4gdK9MJ4S6b7SLBMi0VKxRd9m2/VoahxsvkZY+nq/
         XwmGH3osF4entk6uAwKRQUfkRlbVSKuWuvIjhB+WWI50rzzUjiTjotW3PNIeSZMmz3AY
         MbRWedTTUjk1Z7GCf1CdeWoW4EyT/fkzh5dwGrwvd5G+fasiptCJ3XfkeMLkZwnCuPrF
         3JR/HKoRo0UK3bREB3TFsjyzmlKdWv+nqHzom26nVJ34BwQxjvtP6XLG+Famv6NpnQmZ
         dBdQ==
X-Gm-Message-State: AOJu0YzFZRERomLRIOo5OM37tlMGae067DFsZe0VZru4rUrUrsaEKMaB
	bVpdMr/CkmwEYgMKf5wETWpXBsugNZVI0w==
X-Google-Smtp-Source: AGHT+IE21XIcoGPnC8VVtGIgmx+jgFN+/YRyE7EhJGYU7nme3wJt/AuIhwbdQp8KQ78cqVJhbwJ1Iw==
X-Received: by 2002:a7b:cbc8:0:b0:40d:5f8e:21f3 with SMTP id n8-20020a7bcbc8000000b0040d5f8e21f3mr485460wmi.85.1704809448350;
        Tue, 09 Jan 2024 06:10:48 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id az3-20020a05600c600300b0040d5f466deesm3789408wmb.38.2024.01.09.06.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:10:47 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	hpa@zytor.com,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	dianders@chromium.org,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	willmcvicker@google.com,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] x86/irq: fix [-Wvisibility] warnings
Date: Tue,  9 Jan 2024 14:10:45 +0000
Message-ID: <20240109141045.3704627-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorting include entries in alphabetical order for
drivers/tty/serial/samsung_tty.c revealed the following warnings:

   In file included from drivers/tty/serial/samsung_tty.c:24:
>> arch/x86/include/asm/irq.h:39:56: warning: declaration of 'struct pt_regs' will not be visible outside of this function [-Wvisibility]
      39 | extern void __handle_irq(struct irq_desc *desc, struct pt_regs *regs);
         |                                                        ^
>> arch/x86/include/asm/irq.h:44:50: warning: declaration of 'struct cpumask' will not be visible outside of this function [-Wvisibility]
      44 | void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
         |                                                  ^
   2 warnings generated.

Fix them by including <linux/cpumask.h> and by adding a forward
declaration for ``struct pt_regs``.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401090827.6Qt43Hqk-lkp@intel.com/
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/x86/include/asm/irq.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index 836c170d3087..4b689cec473e 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -10,6 +10,7 @@
 
 #include <asm/apicdef.h>
 #include <asm/irq_vectors.h>
+#include <linux/cpumask.h>
 
 /*
  * The irq entry code is in the noinstr section and the start/end of
@@ -36,6 +37,8 @@ extern void kvm_set_posted_intr_wakeup_handler(void (*handler)(void));
 extern void (*x86_platform_ipi_callback)(void);
 extern void native_init_IRQ(void);
 
+struct pt_regs;
+
 extern void __handle_irq(struct irq_desc *desc, struct pt_regs *regs);
 
 extern void init_ISA_irqs(void);
-- 
2.43.0.472.g3155946c3a-goog


