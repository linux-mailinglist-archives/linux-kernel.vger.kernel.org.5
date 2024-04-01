Return-Path: <linux-kernel+bounces-126966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D616E894514
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6382826AD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CAE51C46;
	Mon,  1 Apr 2024 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4qKkxsI"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6506F9DF;
	Mon,  1 Apr 2024 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711997919; cv=none; b=PgL4dVDnYqAFQWS54kIABv/GxpZchFaAL8WywV8QKILyBgVs51XKIk2WyUDUknkKhomMKEvAtlKtFAmJR3j5L/ZYj+l11+U2CLnaCzR5gTwiqc5a2Qpiu9zNDg2uFBVbe5nsu/1BLLRYGlMyzgVWKlmcgFhpNShz3EzT+8w2+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711997919; c=relaxed/simple;
	bh=YWHUIgLMiMZ2jXULgbtRL+ztS40FgjOzHIbjMY/P2rU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZWK3y3H7dX7XTWktAb2ElJlXbpJqyBdBpq4vE691WCNLEeI2PnoVeZYmhfdSbPxrS1v3YES1XnC1+CzSZafgFOzwLolgwy2SoWh0luiE8+9VZ+4AXLqfXiOuGfdFsmfKcYYTBHd2CcImb+sjWnIfucLlGVrx+QO01lfTNgw4HlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4qKkxsI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4156e4bcb29so2698075e9.0;
        Mon, 01 Apr 2024 11:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711997916; x=1712602716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ero9KmAvRNgKfLB4qNrFeWjCYI07UblF7EFztccvHSc=;
        b=k4qKkxsIM8b0244QUvpBOIC3KVDlozUXqQs2be/zANWQ1xiwUpzphwhP1mW/ENG0um
         m/BKvtW+wFGW2bx4XGfnkZfesjMjD3kge0S1W98edMM3mUXRyfYFkujOKmYVp6rJga7Q
         x/GL0ye4GTqz7CsilbY63KVTBnbAMPzXSJo8fabgOB6YVIaP7q5koCambadubqZZg/E0
         dWJqrOXAqt+JKX2m8GnzImVM/YKe3vPzh0bO4piA2hrpT2cZAR81QctXEXne9me2pVrA
         8MHqTIUbmYHzhi+Osz601sgNb0RpuYI0uxg5xJrB8MbY5SM1kgVCDmhhWTBpsq0Lnv8p
         AOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711997916; x=1712602716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ero9KmAvRNgKfLB4qNrFeWjCYI07UblF7EFztccvHSc=;
        b=kgah3UbWcOLmye7O6R17XVMfQ1h7+gPyhDCNpSPA+N+b7+w7XU02DxNPDLgc1EryTx
         U4Y0nQJgOLSluJg8Wa6GeEJkpGwA+ahgPcgFm3Je5LJql8w8iUw8XNZvFrEQEAfVrhC5
         jmetfZTa3Pf+a28udyu6hqOPbWTgJGaVu+vAOfEwRJo38CcU/1YKNrwHv8xW9nKOWL/9
         hj9ygwUrL62/liszFqgEeArOaoPsMODqD7uScKA5nP13HSSVEmqsaeaUib3m7gNnjWrN
         OdTwzCKnk3QigKNCcOieFiBhmS4BIbtHpS+aLeedhUOjIdNOS3OBvxL86LEh8OmGvhMw
         xi0g==
X-Forwarded-Encrypted: i=1; AJvYcCUqtXHON4V/V40DH7Ixk4ePK119uR7Myf284Ef6IqZblt1O3Wl9Db9/q8XGA4dfidTC+GLDpSdyHIPQjaxhKFjwpv3y8/tqL3Fh8UgNjNnLNuy/pp6V/cHrMQE4VvSNXNMvR2pcZyKd17ZoPFj9VkKyNYUibIMLIQ5U
X-Gm-Message-State: AOJu0Yzafp5l8AoZqJOWQXfKfmYBs5aDbvu0jrwYkWZAcyjoAHEIYMW9
	BITnR3bAbvR8s3EMx4xivfhQF4ZfpF/Aw1RQlexuLIVWpxU9Fvzl
X-Google-Smtp-Source: AGHT+IHNzFxoASVoUaU3W9DsOYRJ9n4cCBP+Z3CJSc1aJXhhBGlILL/S6oFg0kCAat6O9LaK87e8vg==
X-Received: by 2002:a05:600c:450b:b0:412:ed3f:1b4b with SMTP id t11-20020a05600c450b00b00412ed3f1b4bmr6598296wmo.11.1711997915870;
        Mon, 01 Apr 2024 11:58:35 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041552dbc539sm10950986wmk.11.2024.04.01.11.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 11:58:35 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH RESEND bpf v2 0/2] x86/bpf: Fixes for the BPF JIT with retbleed=stuff
Date: Mon,  1 Apr 2024 20:55:28 +0200
Message-ID: <20240401185821.224068-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Joan Bruguera Micó <joanbrugueram@gmail.com>

Fixes two issues that cause kernels panic when using the BPF JIT with
the call depth tracking / stuffing mitigation for Skylake processors
(`retbleed=stuff`). Both issues can be triggered by running simple
BPF programs (e.g. running the test suite should trigger both).

The first (resubmit) fixes a trivial issue related to calculating the
destination IP for call instructions with call depth tracking.

The second is related to using the correct IP for relocations, related
to the recently introduced %rip-relative addressing for PER_CPU_VAR.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
v2:
  Simplify calculation of "ip".
  Add more details to the commit message.

Joan Bruguera Micó (1):
  x86/bpf: Fix IP for relocating call depth accounting

Uros Bizjak (1):
  x86/bpf: Fix IP after emitting call depth accounting

 arch/x86/include/asm/alternative.h |  4 ++--
 arch/x86/kernel/callthunks.c       |  4 ++--
 arch/x86/net/bpf_jit_comp.c        | 19 ++++++++-----------
 3 files changed, 12 insertions(+), 15 deletions(-)

-- 
2.42.0


