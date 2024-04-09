Return-Path: <linux-kernel+bounces-136622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEBF89D63D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4951F21B51
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898D88172D;
	Tue,  9 Apr 2024 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apNOILVl"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321FB1272A7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657110; cv=none; b=Y/d+Q7ZvaTxQz/rLaxTBTj2r5pbY5cgKfgLrD8uadTTOavLTfLgLvRqLqnjttsBXk0Y9kUZ5R1fMPs/HLgupdlYqL5Lbkhu/DQhqLiQNK9O2fPoqd1xttzR08M1P1mkhOdzARFVovWQou7FobDQddhsjKdsJvWnfmJdCW1XCDD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657110; c=relaxed/simple;
	bh=gwLvLFd0MMGWfdLzPnwLoZ10qVGdHNimIcL5XjfxALo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q/z2EI1wWLqrG1HLJJhRnmgakGUtMl55fCDlerFHt8LDIT0uZu5kLNxFPH1JsyXsQTs8luCJpv46QX2+QVAv8rF+A7g+CSP4w4a8BCSLTbz9j2UsKCDxQRXcIXZOr6AOW9KwuhRVgAxSaNCH18mF1BM2cuHrkJKMvgLHaFYdJFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apNOILVl; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516c403cc46so9882277e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712657107; x=1713261907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PXxs/Ql+oc0xYZASgCwylM08ISKpd1PCbAaMTA3JecA=;
        b=apNOILVlczF5mu2rlzuDkA22dZq34+KhW+VCa70to20egjGXmPO4MYBeaHRrd38VfM
         UH7HrqFrwVvDD2jjR3LtQmoqdFPVmJc7fo0WnkA0pkaFrfWmGW2BNsbZJgE/5JZnkHd6
         4Ap7b590h2qEJxRwjlzghxnhEO/hVivAzcLb3kfkFYJ9qATm9DFYbAdKjUQMk0K0iLOd
         xfc6Y3PMJSGdCm5lubnj58g5lW3YJh3ncWZmCcl+FNeX93KuTXratPL8nv6eumgj4oEo
         1n1zV1tBTObDZkxec699/6T/KQpynfzwxNypcgHemFbe0p5NS6k0joUJPY2IojoWkMWz
         zGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657107; x=1713261907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXxs/Ql+oc0xYZASgCwylM08ISKpd1PCbAaMTA3JecA=;
        b=evwfCc0q2rFluv74w9FaZXX29UJ1EuQmr6CpcRcHnSTHnR1KT1lvlH2mXVD3ECCk8K
         NvZEsXkTrVkdShhXoAS68eOzXrWvkEpVG2ib4pc1D8UGHxGvN/P/5cEL0QnIBV9pibwU
         hwVMcRbelUmMKkWc18QjhG/guc1Tn3SLJYsmTp0FrI/vUHOcT6WWDvb0c30UM9l5Tmc1
         E5dR/HyZHJLQDTv2XSMS8ex7Dn20gzFsCmCdjXxlAmmk7uT13JBO9FL9pwHnCaKcy45d
         pbd9I4Nj5UWiy+dDqqbjVlb0/fe5++37agEcTQllFX34WQq9yWJh41tMs2H0WY8N5Ejw
         Wvbg==
X-Forwarded-Encrypted: i=1; AJvYcCUpzQlu0YtnlCBNbar1kz9/QPe6gShExECZLTGHhfpXFVQuiBlnkXAmB9uLFBg3Y+R8TepRmPJZPHFKrpdwxQ0yMb8lNXqj91rjGGqK
X-Gm-Message-State: AOJu0Yxc5jCO5OS2j5Nl4uarZlZY45inrIWz1XL85Fn3zLk4IWxGxAvU
	SKRcXBe+k981XxrnFhUYlu3MyPNDu+rcDZmX7WuqOKfs1ku2+rgi
X-Google-Smtp-Source: AGHT+IHiShZZFYnaU6RfBf4Sv081zS+Y/tNycmSdq/qOEexL/e0yWa05idMYnTICjPoH7ZYOmlIqZQ==
X-Received: by 2002:a05:6512:2387:b0:515:d176:dfd1 with SMTP id c7-20020a056512238700b00515d176dfd1mr11744378lfv.56.1712657106947;
        Tue, 09 Apr 2024 03:05:06 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id qs1-20020a170906458100b00a4e6626ae21sm5496681ejc.0.2024.04.09.03.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:05:06 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/6] locking/atomic/x86: Improve arch_atomic*() family of functions
Date: Tue,  9 Apr 2024 12:03:51 +0200
Message-ID: <20240409100503.274629-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following patch series improves x86 arch_atomic*()
family of functions and merges x86_32 and x86_64
arch_atomic64_fetch_{and,or,xor}() functions.

The patch series enables impressive assembly code
reductions for x86_32 target and lowers future maintenace
burden and technical debt of the source code by unifying
several functions between x86_32 and x86_32 targets.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>

Uros Bizjak (6):
  locking/atomic/x86: Introduce arch_atomic64_try_cmpxchg to x86_32
  locking/atomic/x86: Rewrite x86_32
    arch_atomic64_{,fetch}_{and,or,xor}() functions
  locking/atomic/x86: Use READ_ONCE before atomic{,64}_try_cmpxchg loops
  locking/atomic/x86: Merge x86_32 and x86_64
    arch_atomic64_fetch_{and,or,xor}() functions
  locking/atomic/x86: Define arch_atomic_sub() family using
    arch_atomic_add() functions
  locking/atomic/x86: Reorder a couple of arch_atomic64 functions

 arch/x86/include/asm/atomic.h      |  50 ++++++++++----
 arch/x86/include/asm/atomic64_32.h | 103 ++++++++++-------------------
 arch/x86/include/asm/atomic64_64.h |  44 +-----------
 3 files changed, 75 insertions(+), 122 deletions(-)

-- 
2.44.0


