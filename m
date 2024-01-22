Return-Path: <linux-kernel+bounces-32601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10F2835DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC4D288897
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D1539FEB;
	Mon, 22 Jan 2024 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jLmcULa1"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45239852
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914772; cv=none; b=nsBnguFs3XL5Pne+puROHYqiQGJkw5fRnmepV2lhch2a+rVHHzMIDi0O4k7wlcFIZNMxn3WTc3A+XYYSvYDYAg0gIhg2DBsovR7iKvR1Cr8ogW0lG2mXYAX8V3EIdqY7AKKu6DHh1uddfXI9INVojvqBJKMmOmHw/XJPxcqSNDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914772; c=relaxed/simple;
	bh=7WqvfI2V9xt/Od2Zwwt1owQ25hJdvvX/uuPnR9lgy1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AVmzjKWJPlwnOleqBPIKjEG2lD5QBoC0wPKtg21YyaA/yAehLjcunkSTFtjnZZZrBfEwZf+raSaPNy4QYbNVRTYXHXW8XCPlGOwBC0EFMqnVJThLzxO8jky8cqZ4Ppg+wdIHAsCluZ5imlY9Y8QMaOU/HRrYaciZgMPJsNpmrxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jLmcULa1; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9dacc912so3473093276.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705914770; x=1706519570; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=anpwjJFJvKmui4DbRVFl+bq/czyO2Fw5IsMP2KX6EWQ=;
        b=jLmcULa1WyQQmLpq+xiWSpwC4o/CGgXinM1ss1d9caPF2VERjWmSGEpW2QB+S9PBBn
         AdzGNiMS7rOxsekj2iRm+BXlDHvdRxfiwR1P7JR5gBzkC8YUsXuME8svP7Zn/dyg/U/k
         0s+X3BNQyQCW6EEoZjd9S9Wsk3Kv2orP3IdXVWJ+RS0N2eCg+OySHK0MbjsjUheKOxfq
         lf0ULmV8tXBpZ/p/pYGwqk2A+3vp5S50erpiHKQItMYQKksz2/TeTTYzyzeU3bdsJCYC
         Kf6Nwco7FcKxOBa6DYUZs/n1BxgsM3om31rgI5caY0HbKPkfJvJ+WRFgTIjfiZ3E64WU
         Jl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705914770; x=1706519570;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anpwjJFJvKmui4DbRVFl+bq/czyO2Fw5IsMP2KX6EWQ=;
        b=hv854aYOMJwXQCAjwq/0/XHRpdtxF77eUi6bXYCi3rb1ePmC7zAKe9w0ZuaD9SlHmh
         +vEMaplgMlKmdowzEfbQ2nvIiLmmo5XiWQ1f9FfI4ypvAwHivxMey7Z4X/frQvtXltVq
         EopNxUqSw5wP8ZZ6tw2bSwE3MiBw/rjqzr8iGakLxm4jB1VDF2aQoOS3aaq5+0RBoEj4
         tjBl305jE7gSqbUA3+e9rzISuV4Ew3iTBJjU+cIieU9jKvQtYRcFkuri7WY7HO0VtfH7
         5ieV4KFzTxVmbK71QCTSL2p3l4JgYWiqvxWZRhKFIsIQ69dNVCBDA60GHSnHGRxA+kCm
         5WAA==
X-Gm-Message-State: AOJu0YwXpjkI/Ti7LT/kc9LxXtOtHl827pf/H2W+Em+umCEzsSGWq/Tl
	E7llfI1Aha/dHyJ2NqobWyinjq+a/BQx55A2obLP2IE5vPEctUhKLOaIMn1GdI2J8lECbH5rwnC
	+Od6VkuEJ36PO68lp+nXrs7MEwd9Yus7Q5UjZUlfShwZr/jQ2m1S4H2xuaPDz4CzMKsI4oTGRfh
	n7xx23YtcIbyTpgRVzsmrPs3SulSJafQ==
X-Google-Smtp-Source: AGHT+IFFPnrivenEXAeTge4xUB//ErQJ/nlZj8/EpO9cvDlG7OSkvrz/wCrriJHLaNBS6+w1f6cwmANP
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1808:b0:dc2:3426:c9ee with SMTP id
 cf8-20020a056902180800b00dc23426c9eemr240839ybb.11.1705914769920; Mon, 22 Jan
 2024 01:12:49 -0800 (PST)
Date: Mon, 22 Jan 2024 10:08:55 +0100
In-Reply-To: <20240122090851.851120-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122090851.851120-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1581; i=ardb@kernel.org;
 h=from:subject; bh=thQkn6eFYWU4rIO38nRY5rSfaRiPUJPmqajniqH14XU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWdwXL25bMmmm1ZFF9evWDmkTcTIha1sGp3zPaal+6zr
 4qB+1xVRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIGztGhtPFZyb/Xb5FN/f7
 90CdRWd52mdPLC3t2LdyTaY67xfrJysZ/gpIeM4/a/g0Y3fTyS5Nqasbk9+o34rxme419eRVjen fGRkA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122090851.851120-10-ardb+git@google.com>
Subject: [RFC PATCH 3/5] btf: Avoid weak external references
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

If the BTF code is enabled in the build configuration, the start/stop
BTF markers are guaranteed to exist in the final link but not during the
first linker pass.

Avoid GOT based relocations to these markers in the final executable by
providing preliminary definitions that will be used by the first linker
pass, and superseded by the actual definitions in the subsequent ones.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 2 ++
 kernel/bpf/btf.c                  | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index a39e050416c7..ef45331fb043 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -456,6 +456,8 @@
  * independent code.
  */
 #define PRELIMINARY_SYMBOL_DEFINITIONS					\
+	PROVIDE(__start_BTF = .);					\
+	PROVIDE(__stop_BTF = .);					\
 	PROVIDE(kallsyms_addresses = .);				\
 	PROVIDE(kallsyms_offsets = .);					\
 	PROVIDE(kallsyms_names = .);					\
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 596471189176..a659fc7045bb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5581,8 +5581,8 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	return ERR_PTR(err);
 }
 
-extern char __weak __start_BTF[];
-extern char __weak __stop_BTF[];
+extern char __start_BTF[];
+extern char __stop_BTF[];
 extern struct btf *btf_vmlinux;
 
 #define BPF_MAP_TYPE(_id, _ops)
-- 
2.43.0.429.g432eaa2c6b-goog


