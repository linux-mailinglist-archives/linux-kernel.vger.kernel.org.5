Return-Path: <linux-kernel+bounces-109818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC15D88560F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF5928255E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B0F381B9;
	Thu, 21 Mar 2024 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CNUJSkW5"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D0B53E12
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711011068; cv=none; b=pUwBeGGLxUQLejr7lgQTfU8d4KwANZpSXOi6nVZXITgj5OQLLkBlh3fvzVTcSxXWx00YHR+Ogd/ZEHIq8FL1VJGhOS3qKQvJMYViD3RC7sUGGWYMPKVmPv1NDl1dbskit3PsAyLFQX0859aY6PtqBij3g6nAUvr3inVUiF0BgkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711011068; c=relaxed/simple;
	bh=Qv0uJqFhMtAx1X6+XG2ureaXkoHplsppJbmPG09HXsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNU2PLvKk0TVmTTPR5uh3va8x09hjL/+3/X4Dvcv33Tttv3El/Tzposq67pF/ZtQfcGR4TAEaj0HdHepJA4E/aSJEKqgu0ULyKwEDs8izw2ulVQqeaxH7APIXR+ROKkFjwx+j6NBx/JHFI0cJzlJM5q0JZk8PT6JHN76KBULlIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CNUJSkW5; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c38eced701so462398b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1711011065; x=1711615865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqNG2RpJPlr1g6cb+Y3gz6tpiaBtzhG+qVD6/FBVn0g=;
        b=CNUJSkW5GE0NLx2WDDlZa5mENellXTjS28tHso8Setqg/Oq/YJXk3DHFbdX52mel+Z
         C7JLamXfQdHk0/0jSnMFPsfia+ZaUzDZcQFfWwajSSUrhgrhI8OBoAWtPgA6tVqEzov3
         /z0/FPFMzefB1RZ7Owy7Z1nD0M4WelocyCpcR9zRbwcE2HFcqYYnty/vXmQ3veW+aPJv
         xwjybwou5bQeqz8KrUm6U3Pq1PLUkin9j1q1pVpqqbeCa3vl5LDVCzwI1/DZ6EKEYgNS
         BH+exQUu0Zpj5tdJ24/g2jMml80h0tQ383DCOmigJ1earr98MO7es4wfuOb8+8MKWAyx
         hO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711011065; x=1711615865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqNG2RpJPlr1g6cb+Y3gz6tpiaBtzhG+qVD6/FBVn0g=;
        b=MqjrONFxRQrp12CPPucQuQ0XqJU7eF1jwWOVFFKwx+rgqh/OLbtyz3La/7lKisnhij
         Yl3WsS8N22FXbJk5jS2Rp82hxYkYYiIIeKpMK0aKkkeihQvbD4mttn4wxy27vFTqu/kf
         kmLup3WglSH1J5BPCVKSIOrvo+ZQ9CgdPUWG0kg6M56nQzmFv1zgSkF9uAWERi9ZalfD
         tU2nq1YPMDjwvSj+3QaNVurzve9FTY+lL6mWVLaoEScNBcLv6UdDWUXf2aAVGSlesEk9
         dCYc3C9uu27LdKl88BGQtH0VmNwi2ruoelV4p3wLEfCHLiOkXjAAiDdDd6JvAWc6TYzz
         1G6A==
X-Forwarded-Encrypted: i=1; AJvYcCV8OC1e7VTfCqmE46nv3bAI+Owj8MlQ/xFMUDahqyKY/ivRuqTows3ePX19Mlj8wXm+gjrrhUlc0fDsDupDR31HDBq5pRKsxYi2T2gh
X-Gm-Message-State: AOJu0YyGexr8mZp3ba3sJ6FjjMAIhiUNFv/bR94NBhApoT2mxwFzjAf0
	nPDbfH4zNPZKfi8EuHUnWVLOcmhpLbZQ8OjC+MmQ/hsxoWjdeEkoBaYYQKGSNKc=
X-Google-Smtp-Source: AGHT+IHwDM9ixAq9INkO3i418iZWmEpmXTd0fk8UuLCRGi37vLFEzQGRGixGXgfcb4sMkROFJd9img==
X-Received: by 2002:a05:6808:2102:b0:3c3:980d:3700 with SMTP id r2-20020a056808210200b003c3980d3700mr1825504oiw.8.1711011065475;
        Thu, 21 Mar 2024 01:51:05 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id x3-20020a544003000000b003c3753dd869sm2275409oie.58.2024.03.21.01.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 01:51:05 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Atish Patra <atishp@atishpatra.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 2/2] RISC-V: KVM: Fix APLIC in_clrip[x] read emulation
Date: Thu, 21 Mar 2024 14:20:41 +0530
Message-Id: <20240321085041.1955293-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321085041.1955293-1-apatel@ventanamicro.com>
References: <20240321085041.1955293-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The reads to APLIC in_clrip[x] registers returns rectified input values
of the interrupt sources.

A rectified input value of an interrupt source is defined by the section
"4.5.2 Source configurations (sourcecfg[1]–sourcecfg[1023])" of the
RISC-V AIA specification as:

    rectified input value = (incoming wire value) XOR (source is inverted)

Update the riscv_aplic_input() implementation to match the above.

Fixes: 74967aa208e2 ("RISC-V: KVM: Add in-kernel emulation of AIA APLIC")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/kvm/aia_aplic.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kvm/aia_aplic.c b/arch/riscv/kvm/aia_aplic.c
index 5e842b92dc46..b467ba5ed910 100644
--- a/arch/riscv/kvm/aia_aplic.c
+++ b/arch/riscv/kvm/aia_aplic.c
@@ -197,16 +197,31 @@ static void aplic_write_enabled(struct aplic *aplic, u32 irq, bool enabled)
 
 static bool aplic_read_input(struct aplic *aplic, u32 irq)
 {
-	bool ret;
-	unsigned long flags;
+	u32 sourcecfg, sm, raw_input, irq_inverted;
 	struct aplic_irq *irqd;
+	unsigned long flags;
+	bool ret = false;
 
 	if (!irq || aplic->nr_irqs <= irq)
 		return false;
 	irqd = &aplic->irqs[irq];
 
 	raw_spin_lock_irqsave(&irqd->lock, flags);
-	ret = (irqd->state & APLIC_IRQ_STATE_INPUT) ? true : false;
+
+	sourcecfg = irqd->sourcecfg;
+	if (sourcecfg & APLIC_SOURCECFG_D)
+		goto skip;
+
+	sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
+	if (sm == APLIC_SOURCECFG_SM_INACTIVE)
+		goto skip;
+
+	raw_input = (irqd->state & APLIC_IRQ_STATE_INPUT) ? 1 : 0;
+	irq_inverted = (sm == APLIC_SOURCECFG_SM_LEVEL_LOW ||
+			sm == APLIC_SOURCECFG_SM_EDGE_FALL) ? 1 : 0;
+	ret = !!(raw_input ^ irq_inverted);
+
+skip:
 	raw_spin_unlock_irqrestore(&irqd->lock, flags);
 
 	return ret;
-- 
2.34.1


