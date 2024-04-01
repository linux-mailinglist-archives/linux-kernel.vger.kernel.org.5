Return-Path: <linux-kernel+bounces-126906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE6089443D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D2A1F247E7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A394D9FC;
	Mon,  1 Apr 2024 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyIuFMBr"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3264D108;
	Mon,  1 Apr 2024 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992144; cv=none; b=HRU8+MnYAtVHmnfXsY7HXzSEQu5d6qa0NvJWrmJAAjNfHNYtWKmzyvNEUtDvWVVbKynSZuZeOBe2o0e1iuvEVnjNyfX3Z7rSAkkKFlRbnr0owk449HJtLhxTffS4svB3zhseuVHEX5duBGXIPE5z6/ZTtchvYpTP9H8iWR1ndOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992144; c=relaxed/simple;
	bh=n3qx8PX4JbbZebPyKUvOKWYF9rn/34UmufglT9snIf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NgpKyepws2OgV7vgOtplkThFc08l2WPzpvktgdnELD+Z782aEbiEabGZFYyGIykT873cxjCsC35AHbIBgRiqD4HBIeSUn92AlbEw+xvcYqRlyU9P2oNH/ZhZTVsCTV97equu58vUG/wQnqmZD9dSYbzwekyjU0oc6PjAbADqqTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyIuFMBr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-415a84ea9bbso122565e9.2;
        Mon, 01 Apr 2024 10:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711992141; x=1712596941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGC/TKgrB+BipUfQftnYw5ChRevIFw8JCi+U2tc1K9Y=;
        b=MyIuFMBrN9Th1EIT6wEXaBQbEHAyUS2rydWo9Jn2hNYdRR+GyBATJLRxnKDd94njRz
         dVu2YA+un4Ciy2LRN+qjs/TTagDputU0EsORFXBXBYgzznX0woApz2FJKNZV7oPxVFz0
         IqqSKXjGv3peU7VH2FeLydlsgeyEf6i6I4ro9o/GmW2iHvldzZLiWpUcFXVxRAEkjII9
         WqWMVzF2QChL4d41y4C7MXSgUogGuqSxYk6a4udGjrSSdo57QuwXNE3DimE/p7Bh3RSn
         SXUn1xMvurmblTCKBP/mQp4rBxp/f3T3c6AAola1P8QwAUPWj1xQ5n5aQmCUP1vIPTRI
         WEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711992141; x=1712596941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGC/TKgrB+BipUfQftnYw5ChRevIFw8JCi+U2tc1K9Y=;
        b=rdVF/SoUj7H6CGWkPVu6X8k6y+9Tx5olyDEf2w8W6+iplahfWPuLMebp2jYXnwduhx
         np2csk4fbwWjJ9+YaEG3Ay1NjKfHmIA2OSTv/yV7tfUbWgH0vfETaEJC0MEaV24AYbMC
         bsdrjlUNx87aMrv7E7zudScOY5X+zxyado9q4OtR0XAHilMAVfSoZCOjNuuVC75nHsZJ
         annZLoKEZjS+FqPsZt5i12NZy5Lt8z4fq0N3ivCTpKA4ythH2Qo7RVnaYGpqr2zCOExv
         TJkwTiSW5Etzpwt6sVGgRxbGIZLFtXNIcB0STOjF+Ae/8kELWdfK/nW2hDErU/PTyehc
         KBbw==
X-Forwarded-Encrypted: i=1; AJvYcCXbU7TROc3c1D0Niih11gznI/n31Ly1mycnKZr4EmCuNMT671jl4OS9c2kbAcyaYNh2tJfAt8nic9OTGsXRxpCCNSe55RGYDxetJvvGP5+QL3Td8KgYtbQEtHWoa+MKYsMEd8g8mOY3IDs1eCfFlpAZkieN2YcJPgI/
X-Gm-Message-State: AOJu0YwIHixHgz2ln+Mgj1up+yVj0AOUNzdKs70PSIKLLq5i3JB2uAdn
	Mm5g5EHIkPEawCMXgk36HV/PpzrMXH2fZSssWzXAhY1mTqb7FSbg
X-Google-Smtp-Source: AGHT+IFumMkbth+FRuxtOb0CUug8cOu07jUVwMuGxFXooWULx8JA7teM0x+UwusYqBxv2gUPLxENGw==
X-Received: by 2002:a05:600c:4f86:b0:414:8e02:e441 with SMTP id n6-20020a05600c4f8600b004148e02e441mr8237421wmq.13.1711992141086;
        Mon, 01 Apr 2024 10:22:21 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id t20-20020a05600c199400b0041401eb021asm15273108wmq.24.2024.04.01.10.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 10:22:20 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 0/2] x86/bpf: Fixes for the BPF JIT with retbleed=stuff
Date: Mon,  1 Apr 2024 19:18:58 +0200
Message-ID: <20240401172157.5717-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
  Explicitly list offending commit in the commit message.

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


