Return-Path: <linux-kernel+bounces-20950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AEA8287B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BB7287D10
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8458439AC2;
	Tue,  9 Jan 2024 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yTXHxlcb"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E7D3A1AA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-336dcebcdb9so3118012f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 06:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704809085; x=1705413885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4eDBGUcsDSDL8WR80JtlsXII8Q6J7ftU5c15K+YQyE=;
        b=yTXHxlcbWCtFzbMEoK7veXkcj5whfB078tGeImE4BKpwXfTnlcqiFHfqCT6twGSO6x
         ITHUznrxhaWGRCePCuXUxGDN3A/7ymllQ55X7iQFMvPDcg9uMHjkhZA7IL6GV9Aue0Fo
         3Qm1aXA6PmG/SKQ94GfZ5tICgYfKYx8fkxHPkickj7jPbNbMtwwLsUq4h//eLJ2V9GjC
         E/MZI/uh0zOb0ljUSTRud5S+OmZP5n3xBzD89ICUxLXTHJ1mcsL14KHgzlEg62U72YCa
         9IqITrsCzZ1Stwg0dy7ZRR5LCN2LUf/LTQZN6OjMvCsdjAE8Rtb6DJfWO64qNCDM+AKk
         PvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704809085; x=1705413885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4eDBGUcsDSDL8WR80JtlsXII8Q6J7ftU5c15K+YQyE=;
        b=XjIBAZDIsHLkMuxRtYSf6ccR+f75jfXMJwfdFL1xFSmY7qZToTs5tVZVdIl2gMjUHX
         MI74WiwEkVAiffZrB02KYvvZeNpzfRRnKjh+FVHTaW+58hXHLuuCDnJAWO/GsbRsQ/+W
         ZWh2da1EUz1Ez0zGG8psD0HCI9ihxQ4lrOGtlOkX4FwNFZbEnYVWMVnDLcfnSdMiOuVx
         XaJQ3sS+qQwaPDDSWBkFO/hpUxuiiB9f5sTyuoNVoSHFj/fpRqO+hIFqE+Dy3uM0VJS0
         kMcmIl1JriTPnzID8M6wY0r4v/TUai8V/xARL8KdRp1SctPVGp5ZOx5ov4MX0tKzKLL1
         eSGg==
X-Gm-Message-State: AOJu0YxQwwNqNeHY2oZ7kpgl/g+JTpwkiudLrws+N21I7TYUCYjziiR8
	a+5ESAufzNXvRkPT1tFsM74kYPyL+pn7AQ==
X-Google-Smtp-Source: AGHT+IFMqVBgwU7mE18AKDtOKcW01AIFweyT2he9q5FcoMTAeHwxeFs+tozpNfDbYbb3bPuXZQCNng==
X-Received: by 2002:adf:fdcc:0:b0:337:5568:363 with SMTP id i12-20020adffdcc000000b0033755680363mr260609wrs.201.1704809085292;
        Tue, 09 Jan 2024 06:04:45 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d4c91000000b0033342338a24sm2521337wrs.6.2024.01.09.06.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:04:44 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: sumit.garg@linaro.org,
	dianders@chromium.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	andre.draszik@linaro.org,
	willmcvicker@google.com,
	peter.griffin@linaro.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] arm64: irq: include <linux/cpumask.h>
Date: Tue,  9 Jan 2024 14:04:37 +0000
Message-ID: <20240109140437.3703330-1-tudor.ambarus@linaro.org>
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

Include cpumask.h to avod unknown type errors for parents of irq.h that
don't include cpumask.h.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/include/asm/irq.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index 50ce8b697ff3..d5612bc770da 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -5,6 +5,7 @@
 #ifndef __ASSEMBLER__
 
 #include <asm-generic/irq.h>
+#include <linux/cpumask.h>
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
-- 
2.43.0.472.g3155946c3a-goog


