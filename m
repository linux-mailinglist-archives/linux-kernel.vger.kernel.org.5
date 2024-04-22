Return-Path: <linux-kernel+bounces-153619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4F78AD072
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3BBDB22365
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD661534ED;
	Mon, 22 Apr 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7b5Y6P6"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EBB152E00
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799086; cv=none; b=izOcTG8MBaXw3utHQMOX5iyjxZ6tkP55UbuRB/GJ0rsMHc5crfzqazzAVhi6UQNsKGUe+g2N7S/seHfOMiXxBXqp/sRsHMuGHHEE+RJy2sph1mrFk8u0scUYH6hRo18jVOAUOXq328IU6Gp5Dhbmw4ovTTh5d3mI2ByQ4NYQDjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799086; c=relaxed/simple;
	bh=CPFR15tneOJhQk78oq0la/KY9saekh5nLt/B0kR7pgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D8Uw49HOsGfHdrHXTW42vmNAjkLnMXfuzsaxu3LNQEdLOmDJlBiFSFZNqLqVQAA8sX0ytBArzo9YzQMlnHqsFZ29PoyLwz/hV1R1P0CZf1emifyX2JHZYhIByS9zjgObNtIA5doWGWAxcGIOxWSqc/vD1hdfYoPqPyGzYItGlj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7b5Y6P6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a52223e004dso427041366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713799083; x=1714403883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XoZ7uxBwOV+P0LIe5TJy7U0wCKeVYjyqLxxE3vM9H8g=;
        b=c7b5Y6P6zq5PuzgwzVmE1ishKOfsVMMBWufFDtl8X8VL3g6WKxZfZC6rGm3rso9eom
         KGY3iMbZCveQdJVouL5bCZC81T3rHntmDxLhQ7bcm5wwwBqAETaGm8tZYm6R1kIDg/qe
         UwdpcBAx9NXeAjfz6ZGk51zibagJs6FlHcthc+X2t93nF7mhwNx0jT8WLaV9p1r9LalK
         HXM+On7vzGc1QEkaKfxokY1o5GcgC2e5KZ7iyG50VdVYspVr5a+XLETD5KPs1BcAZBJJ
         KEhL6/JtJ51oul+rhLKf2f/LyCLv3HM2VZ8M01wFN3BVePKzeWvipDyDHPSQ7Lll+AdS
         PsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713799083; x=1714403883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XoZ7uxBwOV+P0LIe5TJy7U0wCKeVYjyqLxxE3vM9H8g=;
        b=UdCOs5Pkw3gGIOEI6ENACQvF0OwAQT4mBmkXzh6N6XyglY+2/PHG0oqEHoIrMGLo0c
         USoe8LlNdEbQBWfFTSW3oG/nJjRtVHYmPAu/0tRbw7FHE0k97g1fOEj8d2jbbVIOMwmt
         XWoCtPSKKcYzvPdubl/QnqodDNSlJ101ihSP/Yw7xb6n2fTWd2i1Whj88HwkFkJGNzWS
         zuS8QK42UQ7ezAFu2jB92okq2/LlPaO9Iywf2geq7CZPDPg2v0WH9Z6oSDcW0xxmKjhX
         2X7LB/JEKXzEyf5p96OGoghFzW0NQ7WODLUUcfF2aAf2kpXz6w+ezCeiePRp7Q1B2HMs
         sGWw==
X-Forwarded-Encrypted: i=1; AJvYcCXLrHSw4CU1Ys/kuvyBPxtHcMsIVNJqZ9+DO1z3R0gccdQUgMTUSdnglYhUxxdjh5RlH7aQ1Q5sqGIOLWR32qD8Sx8vl/tau7oASyBa
X-Gm-Message-State: AOJu0Yz1WAZSGbnbPqgf7XQfCyPeJmZtmc+Nt7Acmdng5neQ1srgJ7QX
	WyyZhjbCtARcVB8gKOre+QOEvH1KZglbj+Np7pTfsv2mg6IGFItw
X-Google-Smtp-Source: AGHT+IFNUoquNfec2rdeReTvl6zW7v/GVP3i0BHHhkx77exmBOIvBiAo2nTafKORGBFvhFmwwJq4lA==
X-Received: by 2002:a17:907:8691:b0:a56:ee1:5695 with SMTP id qa17-20020a170907869100b00a560ee15695mr1967638ejc.19.1713799082877;
        Mon, 22 Apr 2024 08:18:02 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id u14-20020a170906b10e00b00a5534758ef7sm5932108ejy.148.2024.04.22.08.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:18:02 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] locking/pvqspinlock/x86: Use _Q_LOCKED_VAL in PV_UNLOCK_ASM macro
Date: Mon, 22 Apr 2024 17:17:35 +0200
Message-ID: <20240422151752.53997-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use _Q_LOCKED_VAL instead of hardcoded $0x1 in PV_UNLOCK_ASM macro.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 arch/x86/include/asm/qspinlock_paravirt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 466af57b8ed6..0a985784be9b 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -40,7 +40,7 @@ __PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath, ".spinlock.text");
 #define PV_UNLOCK_ASM							\
 	FRAME_BEGIN							\
 	"push  %rdx\n\t"						\
-	"mov   $0x1,%eax\n\t"						\
+	"mov   $" __stringify(_Q_LOCKED_VAL) ",%eax\n\t"		\
 	"xor   %edx,%edx\n\t"						\
 	LOCK_PREFIX "cmpxchg %dl,(%rdi)\n\t"				\
 	"jne   .slowpath\n\t"						\
-- 
2.42.0


