Return-Path: <linux-kernel+bounces-63676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A255D85331B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43798B219E6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE3E57893;
	Tue, 13 Feb 2024 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uf9NvRug"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ECA57873
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834545; cv=none; b=nxKHHpvsjrdVq6a5NbBQEwFaJy22Wsgs6HMUsMtS5p9BFqo1XxYaiOUrX8Z3YLEMFNI5tSzun0E3IY7oUMR8707PeOhJdMh1m6wS+0CAKDQwoUrrb13+4qQ2r+IGVrRxLNRENDKXKhcn2chDlesIbe9UCnIfafWiTqaq3Hz3X94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834545; c=relaxed/simple;
	bh=pUBYHNSuGacf4iIVwOjdBuoUvYgyjDhRc9q2OchczGk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u9PFgFttXgLR9GosgaRnCzLLs4/hznrpWOUyfHV6a3pN5b1b2U5/yVKbGsul3PNRCh6mGIHn3DyjyAIx6x2tsig/O8riiHUxOo7bMpZXreuNYNQecHZYMbdG29vowFChbvsSxMhYc7ZTD1cB2R3TR8ux/ryEhPBjF80YpuS1LLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uf9NvRug; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607838c0800so8079627b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707834542; x=1708439342; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eGMdDRwTTa13t5SlPIuZSJHa36hYXdnKoaK7iYV4TM8=;
        b=uf9NvRug9SZAMLsDKJh4L93SqwDj9LqZwSoT14c83/+5CDdCTRW8VIKIxkSXGpCioI
         /Ba8NPA0vA4b7eLWuaww7sMnr1Vx0kWurhkPtL3WzDJTXhGJq8lslpwaLcTs1bpLN2iC
         Zc6EJjpf3V05eu0DKvPuYDmxMCICi3Zh9tO2kOZICf7yxXY0FahBstxOUKb1IQmxBQ7F
         2alrgRlN5HRE5BnGikBOFQ/6tgH6bIci6MpvHkPBCUWtQj9s7Q5uOK/xMCyktRWiIa66
         zYd5/vbIK8J/x06Pt6YoPSL266x4WW/FYs5oxWpvyzBWZ+3gYRwZexcW+zQopjD44ta8
         H/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834542; x=1708439342;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eGMdDRwTTa13t5SlPIuZSJHa36hYXdnKoaK7iYV4TM8=;
        b=cbwX/36WgHjGPhNYAL/6RJP1zQuiz+5Sx/CHDzmWKHfe6mvQxkRR0Qu7Z78Y8c6nfR
         CwvAz4igWGtuO2jB8Ne6Yx18yJx34N2JL6MgsDG6LbBvXCXta7QjxPvpGkRd1fQlTaBl
         nEo5Tvh5R3VjpswRDIYUQGeUc417fm+GTdtPLlHJAiLnO7DVpdsdfi2aQXMVQ0EjvCRJ
         AUa0UPFq6Kgmh4+4y8nWt1AHtNrqWDV41IJJQ/6ezHodi1yhS/i4RuDxG7VuXV8MQ3Nu
         2/zuO81J53Gkk4QVkdlSaXumdCd20HSwayvyBXV2KpiKg3mMo/xniOMQbhPt7WkMLdZB
         tP6w==
X-Forwarded-Encrypted: i=1; AJvYcCV/ROWtHSVL4gthMIudCU9Sfqu99ATwDZKFdrUkPnRSFTc7YlOjKyjNWj/Wj1NDZG1JR8NlRwCcGKsnyFzzTmCLTf0TJ3i6zducMOMx
X-Gm-Message-State: AOJu0YxHsC5TMGppArQDlIUOsTy1LxEx2PZqgBo3Waz2mJ2O47js7N8a
	HzZ6Q/QXAI40Y4Z4fdBRcPNhdmNgd/AApzfJiosA7s919FiBmz0p1+7Gc5+KNlzHb/hjbnaH558
	5khiWpSmYRn5sWra30w==
X-Google-Smtp-Source: AGHT+IEjRJkAWZBtGKgOvWcIgZrlfSHYWUmdK6a6QAGG5yPvxwXI45ku3lc1Z4IJzt1ZqVxJm+1omyh4oxPsoQYL
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a81:920c:0:b0:5ff:6ec3:b8da with SMTP
 id j12-20020a81920c000000b005ff6ec3b8damr564874ywg.1.1707834542765; Tue, 13
 Feb 2024 06:29:02 -0800 (PST)
Date: Tue, 13 Feb 2024 14:28:56 +0000
In-Reply-To: <20240213142632.2415127-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213142632.2415127-1-ericchancf@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213142856.2416073-1-ericchancf@google.com>
Subject: [PATCH v3 1/4] riscv/barrier: Define __{mb,rmb,wmb}
From: Eric Chan <ericchancf@google.com>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

Introduce __{mb,rmb,wmb}, and rely on the generic definitions
for {mb,rmb,wmb}.
Although KCSAN is not yet support,
it can be made more consistent with generic instrumentation.

Signed-off-by: Eric Chan <ericchancf@google.com>
---
 arch/riscv/include/asm/barrier.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
index 110752594228..4c49a8ff2c68 100644
--- a/arch/riscv/include/asm/barrier.h
+++ b/arch/riscv/include/asm/barrier.h
@@ -20,9 +20,9 @@
 	__asm__ __volatile__ ("fence " #p "," #s : : : "memory")
 
 /* These barriers need to enforce ordering on both devices or memory. */
-#define mb()		RISCV_FENCE(iorw,iorw)
-#define rmb()		RISCV_FENCE(ir,ir)
-#define wmb()		RISCV_FENCE(ow,ow)
+#define __mb()		RISCV_FENCE(iorw,iorw)
+#define __rmb()		RISCV_FENCE(ir,ir)
+#define __wmb()		RISCV_FENCE(ow,ow)
 
 /* These barriers do not need to enforce ordering on devices, just memory. */
 #define __smp_mb()	RISCV_FENCE(rw,rw)
-- 
2.43.0.687.g38aa6559b0-goog


