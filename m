Return-Path: <linux-kernel+bounces-168238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0AC8BB588
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9B2281B18
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB0458AA5;
	Fri,  3 May 2024 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knQcG2tJ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565446441;
	Fri,  3 May 2024 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771369; cv=none; b=PB/i0PwCgIAFsMIBTBWMTTVOXg8RVloMG9sq6n4cp0VrTgf0gVWc/dLZq8AKBPRfZgiGAEAqXxE6foSLM7NzctqkKyZFeG/xTczKmCDTa+393I8Q+EMnS+c+WFdjV/GmIPUM2EWTX1ZPDXhdC+bkuo6tdqaW3GRcpFmD29x/nDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771369; c=relaxed/simple;
	bh=X5QO4KOGbGZJaTwHuLYxcPBvxqlKNKY3v1yg8Ls0+go=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYE1mt/urOqp3UbhvBWsYUSBkkiRJ4ghrkxqWELTmLmIXR5pxhb9tOPzqT0uxfqRNxsoFfYpeAgb6fIlhwkMVxjU7KIrXuqc+TP48IVI/1Kh688g5HgzQ6k/Gum/h1RE0e5HfamN298Wv5E0Qg1gYsYJXsil+N5qt1c34h6p+MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knQcG2tJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41c7ac73fddso1640715e9.3;
        Fri, 03 May 2024 14:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714771366; x=1715376166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L64tyzVkGm6ZnLwG0YS7ddVliyJ40mixqMJfBnGOk24=;
        b=knQcG2tJlX/GzQe9/6Tx3wwnL4tqyegMWWF1sRWw0fLkFYBHZh/NLEAuja641nGpB7
         fry9MvfeAfnEmzNLnWdNlLyGIFgmJKsWov8W+UqHHAI0wHqjtYqA1fg+9+iEN0asp+bN
         vNfhsbt2+2xQHLEZKVYgD51lI9FDcvTg8n/yr9bAI7OUHy7xLq3SshAbmpEzdqcW9cvc
         O0dtKrJaPlZY/xmXDAYAuLfwMKH2QGDv1+ItLJl4uMHSzyR+jNGm8D/KkuwlWaJS5lfj
         9ooyKKmhQFiTs3ZKaoQeqepYXa9iY2oPyVVModi19+u+ZS6bSrSHN9PGb33S54iP+V6M
         t5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714771366; x=1715376166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L64tyzVkGm6ZnLwG0YS7ddVliyJ40mixqMJfBnGOk24=;
        b=ZcMgQ61Dh6UC+Emh/9u4SaZr35KBP3inS73sXXeQaiYMFcTACcnyoUkdtkfuQSusfP
         Tal7l70CQoF3x13rWBfsiKIWVTCTOMU7phFgR2YjrNvGy3gdyesYhtu1fbdx3E3fQrdg
         aKIhD/zuV18bN7jkkB+l/UIUaE4pSYTXHootye9WdRpZs1WWsmycYac3/P7RWPC7w6VM
         CT/e6A0LQVC/EUaX5xKV746Tc7QKgJlgZByLgV+xd4Fip33xYHBbBhKIz5yori/f9Fat
         xk7eCBq5Uo5uXEEdfAFw7Di71texPfc57IJQojLV2At/3mAyIFljJo5wE+/ostb/dxgm
         PjIw==
X-Forwarded-Encrypted: i=1; AJvYcCUm8uK+nsKJsrcv8jwjrq1VH5TgvTtCU2n39jHIgomefW6+uMMT66dc8yAq0spQdmhxONKX0oIgW2uCDLw+VKtdP1es7j84izpdSH6BiJzu5Vi4+SRFLKR6psAQM+aFE+67thSBdSoZZJv8KwfUShrtkVha9Kxk55XmqK7Gxjr6BBQdn0I=
X-Gm-Message-State: AOJu0YzhNBi1Ge/nJs0zuWW42NWA4UHaUentxkdrjnka1x42gPjUA3fC
	6bRrXw3YZev+MElmpaoUyFx2zvoUqrk807mzu02igsgjaaHgoTI2
X-Google-Smtp-Source: AGHT+IF/nCgDRi+5NwRqCziiD6l3p4JJYHDinwP3vOPMd0kinXs0NsTbGxsXvvFTQaYgY6TadncSkg==
X-Received: by 2002:a05:600c:3ba4:b0:41b:bb90:4af with SMTP id n36-20020a05600c3ba400b0041bbb9004afmr3641323wms.20.1714771366384;
        Fri, 03 May 2024 14:22:46 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id g7-20020a05600c4ec700b0041902ebc87esm6918729wmq.35.2024.05.03.14.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:22:46 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	linux-mips@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Gonz=C3=A1lez=20Cabanelas?= <dgcbueu@gmail.com>
Subject: [PATCH v2 1/5] mips: bmips: BCM6358: make sure CBR is correctly set
Date: Fri,  3 May 2024 23:20:57 +0200
Message-ID: <20240503212139.5811-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503212139.5811-1-ansuelsmth@gmail.com>
References: <20240503212139.5811-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was discovered that some device have CBR address set to 0 causing
kernel panic when arch_sync_dma_for_cpu_all is called.

This was notice in situation where the system is booted from TP1 and
BMIPS_GET_CBR() returns 0 instead of a valid address and
!!(read_c0_brcm_cmt_local() & (1 << 31)); not failing.

The current check whether RAC flush should be disabled or not are not
enough hence lets check if CBR is a valid address or not.

Fixes: ab327f8acdf8 ("mips: bmips: BCM6358: disable RAC flush for TP1")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/mips/bmips/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index ec180ab92eaa..66a8ba19c287 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -110,7 +110,8 @@ static void bcm6358_quirks(void)
 	 * RAC flush causes kernel panics on BCM6358 when booting from TP1
 	 * because the bootloader is not initializing it properly.
 	 */
-	bmips_rac_flush_disable = !!(read_c0_brcm_cmt_local() & (1 << 31));
+	bmips_rac_flush_disable = !!(read_c0_brcm_cmt_local() & (1 << 31)) ||
+				  !!BMIPS_GET_CBR();
 }
 
 static void bcm6368_quirks(void)
-- 
2.43.0


