Return-Path: <linux-kernel+bounces-21797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8258982946F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82A528744E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA7E3A1D3;
	Wed, 10 Jan 2024 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRMK08S2"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D22B3A1B5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3376555b756so2126767f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 23:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704872410; x=1705477210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NLPe7rN96jPmcBQ+yEx7r8GzqAJEfJNRmgl3HhO41JE=;
        b=NRMK08S2mCTi6UNBwrhBRDxsxThiYHvB3GHnuM7LVmCQboaDHD8uoZD8JCbb3Tb6wZ
         7dbcn1dqiqytm/5vpvhYkDmcBzIHJkB6iDb8HtIaSNI1eBLkAnCt+Gz8tNw2ouWmcGyd
         IK7Jeubr4dTFoccpXm50C2XtasOKLiqYS7Uxl47Gqo6VmttqVI7ws81Cp+XuTXg9+WR1
         K6fVtt7RxfbwsUKw3Lr7+z/mDp4N5V1ECQAM3mdSaPhkeBGqed2IzzkfgE/HU1f6bAwm
         MgiIaJhWgjrYuJPPuzW/4zGa0Io8jQAeqx+J2yYdA31b++dQXCxsKDrdGIoO5VjEL72B
         Z0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704872410; x=1705477210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLPe7rN96jPmcBQ+yEx7r8GzqAJEfJNRmgl3HhO41JE=;
        b=tiyYzG0GS9nE+kzYCCu/Xyl/DL5tbpI3q3QtQJ7u9qvPGWVG8yVE84RnOLjQDGZdQB
         ypvZ50zL2UcYC+6nwGe9McJ3d2aBWrv5lUXzJShYv+BJ4uCidXNJ65+2zCKVx24Y8hdd
         rh6UWpXXtvHXkIY03PM7QH+qFgs3cO3jNhOzpO2P8Qk7lYZCVgsvn3Qv/C2iTsijuSL+
         6+5EXojAaFpMWChatPF0EBdbH3j3GtVyyAJGaPn8rdPkOnkY/bVm+pBBqR2Ex5lTH7QV
         V3T78o/kgza5NuNxZiGDOuw2+GHH08XbzSGfIwNzkTcgvvXYzjM3Kb3qvM2r7ppM5Epo
         2ZNQ==
X-Gm-Message-State: AOJu0YzVOlaXyexx78zMFiA7haO1NG/RXVHgrSxDJ6N/Dc4wE09z5NLI
	ShxYeutfIqxm65D0AVGX/PIZFydpJxaIVA==
X-Google-Smtp-Source: AGHT+IEWGg/TtsHpb+8OZcJ3s5rg1vjUJ0YbvyUGPN2Et40F9kQT6rgF5c9MQnw9Vlk0josWMt/8Vw==
X-Received: by 2002:adf:fec1:0:b0:337:64eb:1c4 with SMTP id q1-20020adffec1000000b0033764eb01c4mr1098496wrs.7.1704872409835;
        Tue, 09 Jan 2024 23:40:09 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d420a000000b0033719111458sm4148928wrq.36.2024.01.09.23.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 23:40:09 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com
Cc: swboyd@chromium.org,
	dianders@chromium.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2] arm64: irq: include <linux/cpumask.h>
Date: Wed, 10 Jan 2024 07:40:07 +0000
Message-ID: <20240110074007.4020016-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sorting include files in alphabetic order in
drivers/tty/serial/samsung.c revealed the following error:

In file included from drivers/tty/serial/samsung_tty.c:24:
/arch/arm64/include/asm/irq.h:9:43: error: unknown type name ‘cpumask_t’
    9 | void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu);
      |                                           ^~~~~~~~~

Include cpumask.h to avoid unknown type errors for parents of irq.h that
don't include cpumask.h.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
v2:
- fix typo, s/avod/avoid
- include the linux header first and then add a new line to differentiate
  from the asm header
- collect Mark's Acked-by tag

 arch/arm64/include/asm/irq.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index 50ce8b697ff3..e93548914c36 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -4,6 +4,8 @@
 
 #ifndef __ASSEMBLER__
 
+#include <linux/cpumask.h>
+
 #include <asm-generic/irq.h>
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu);
-- 
2.43.0.472.g3155946c3a-goog


