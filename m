Return-Path: <linux-kernel+bounces-126907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7924894440
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6728E1F22FFB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D08B54780;
	Mon,  1 Apr 2024 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/sAar2h"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E1D4CE13;
	Mon,  1 Apr 2024 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992145; cv=none; b=GgAVwgfy7aEjHKbneave8L0YH2bHd8ZhevLLjdOcB+oU0/k5GaMU+7OxjAB+kwo5vly8NHHDFN/E04D5da0xeQqAm6Gd/PRW6aeQIs50TyASe+pkU3nU8zdZnx+ljffaZL3fYaBqkG0xRhvO0hh6P0Rw2xBwvS8ASs9mFE6/Er0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992145; c=relaxed/simple;
	bh=CxY9nXW1hVEgbJ5ecFj7xTbyz8bGSq73NPWXUvZKeKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGL4b3WARdWwQCC0mhv6xEoVIx37t+367wREPAofORVD0ZYkAvV1acErdHHyIAJDJzwYhyxvbj45CAoeq9WaB5R/XpxU6YoSrQP6RqZC789yEJP/wed6Ts5pCx1+CVVrHUkRwCGdE4+he8xyWeyBgr2osFUSUSmjIt8jb7tN+Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/sAar2h; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41568096c4aso5065535e9.0;
        Mon, 01 Apr 2024 10:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711992142; x=1712596942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NmRsn0Berr4z7goR5yIjjpeRZ2GOU9/19ILobGgMh8=;
        b=i/sAar2hW5BN36Q/FLSbZW+oEhyOe8taA+FounuDat6Ps2vykZeHpR/ad7obwxtZ1J
         4sVMCicVwNi/8uZrDLDbHI6bkzNCl2iLPg9Z/x896jE3e12IiL/NojYUUeNw9CjL33uL
         Iu/lXWp7ay+AjKNuBLaHpi2oLM8uFGGzzW/wW67+edKTPwxAseZl4KEYsCJnp8VjVxGD
         JEf+x8GgS8cy1R0xmIHHctLHVQuHmfj1jmR8AJBq6nJGUN7Fpe8U0tl1BPr/Yi+f4nUA
         2YoDyiJ4B56SVIel6p+86GNzRNgl96haha3wIegbdtTtPJKZu57AuP0erOgZzENpYx7W
         sPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711992142; x=1712596942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NmRsn0Berr4z7goR5yIjjpeRZ2GOU9/19ILobGgMh8=;
        b=EDrUobVsyfs+FczTjnH/ZdllMwt5cJ+j4QwajXPG2URe3Yx2M0OiDXsZIxGyXN4syb
         0oelRq+CVnsOqyWEq83d5g8AqtjLZtnBSGas/lSlHSQspiVsJnsPkT87JiVo05I5WJsX
         BWfHto711CW6vH2ssU2MLZkRpreMecVP9wCVASpdOS1BAIB0HeDCAq8xlM96DLQVGNEf
         zjUiGLlzG496MdrUuHNH4yo5GTr54s0Zn8LPRK8OB1MHAiHBLdZZAEaMwLI5HUCv9CGm
         Oehjj1kZxILzGsdUe9BiUOmouGk3ZbZK7UVLnfb/NOaGn08WQaTuqIBPOgHhaIyoY0SR
         EQQg==
X-Forwarded-Encrypted: i=1; AJvYcCUT5JqdvqTd13K451p/re8cav1p+bsmkjj38qfskAersg2KMXS/TG+6OQ4UrqL4FHIR1+jcEZtm72kMBj7Bz3RpzImUMrMDFW+1A5ksapN+1t3w0TRkrzyjZ2lCY6MpeXp5AiRFEikez0DdPD9l4xBZ3dfq2UlcuIXw
X-Gm-Message-State: AOJu0Yz70fdK/LTqddJ0TJzJkain6YHjSomkLZZn5n68q8XztwJxuEFC
	b5rpeHxyMyLBU2IepWOxtTlIEmlkdK/cW4xwV1Cl3qTXsEEKgB0j
X-Google-Smtp-Source: AGHT+IF7qDw4OYTUfwtrPFxRFHl7OnB6w0EP8S3/nDjMxJRuz8/tfJ5ctsfOUdlzA+65fOKrkjP/XA==
X-Received: by 2002:a05:600c:4f93:b0:414:a76:3d5e with SMTP id n19-20020a05600c4f9300b004140a763d5emr6478769wmq.28.1711992141906;
        Mon, 01 Apr 2024 10:22:21 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id t20-20020a05600c199400b0041401eb021asm15273108wmq.24.2024.04.01.10.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 10:22:21 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	=?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 1/2] x86/bpf: Fix IP after emitting call depth accounting
Date: Mon,  1 Apr 2024 19:18:59 +0200
Message-ID: <20240401172157.5717-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240401172157.5717-1-ubizjak@gmail.com>
References: <20240401172157.5717-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adjust the IP passed to `emit_patch` so it calculates the correct offset
for the CALL instruction if `x86_call_depth_emit_accounting` emits code.
Otherwise we will skip some instructions and most likely crash.

Fixes: b2e9dfe54be4 ("x86/bpf: Emit call depth accounting if required")
Link: https://lore.kernel.org/lkml/20230105214922.250473-1-joanbrugueram@gmail.com/
Co-developed-by: Joan Bruguera Micó <joanbrugueram@gmail.com>
Signed-off-by: Joan Bruguera Micó <joanbrugueram@gmail.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a7ba8e178645..e55745f512e1 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -480,7 +480,7 @@ static int emit_call(u8 **pprog, void *func, void *ip)
 static int emit_rsb_call(u8 **pprog, void *func, void *ip)
 {
 	OPTIMIZER_HIDE_VAR(func);
-	x86_call_depth_emit_accounting(pprog, func);
+	ip += x86_call_depth_emit_accounting(pprog, func);
 	return emit_patch(pprog, func, ip, 0xE8);
 }
 
-- 
2.42.0


