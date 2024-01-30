Return-Path: <linux-kernel+bounces-45369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8405D842F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D09AEB2209A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD057D406;
	Tue, 30 Jan 2024 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DfwzKkph"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF66E78666
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706652533; cv=none; b=Inn1id/Q0piB33/4QI8/6MpzrqIxPa5y/4/KRFBVVRhjYTyFlA4XgYlOtNJaXoqKfLSO2ck719Pl4OiNpbSfQ7T8jTmdnCbMo73iD/1mEbkqFzBMCUwkG0uuYhAcitW6v0K6sa2BPF/wsNX58sZJTL+xm97RXwKq0CEOw6ajvtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706652533; c=relaxed/simple;
	bh=wLXGJX7ZPdzpVptP9s9CeY5Mk/dYYO7q22+aMQXDhEk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tnFjtQEvgjIrV/kkY64R5K/DFfzkIb5g5wxENUCxjCT8R6FD/s0GAsasadKxF+UE+p35tX5ZQBOnvuFZbsba3OuqSXEFyUnEDOXmataJXIOq6mvxiwr1XDbjfA5f+yzsdPI0ZUezAZrauSrSew6NJvcwnOHg2DW4vZOJf4W01qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DfwzKkph; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7bfeba24176so190195339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706652531; x=1707257331; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g4o2DS6nz22ReCocFZD628QsKvugxD4ZslaXCuzueXU=;
        b=DfwzKkphw8jwyDxJz9WhaQDTNiKDQV5tBFiKlNr+Zqp1BnHq+QU5MSjB1R+Yt6iTLg
         pFDTZcM+hR2Km1eLLeH28rO9iFEDeZGyCMQabNMFvJJ43DtN008EBwmG2d4MY5LHT2Ma
         muaJILsQfTlExfDhgteyQE1VB8u1CmOxuHATGBSWiN1GLFlA5IpVuSLapRLezgq0dtt0
         ICJ16ofmfI9pGGQI1IawQqtqk2yJdRhugCQCRd61yG7AXTkb0uI4yTuNUuzOj7zACg2A
         7esCWmbadlYzakLT2/UZhkQdByT7OAhbEYdN+Myo4BSRspMnD0lY6HiCDJ0AnGnZPBuI
         J6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706652531; x=1707257331;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4o2DS6nz22ReCocFZD628QsKvugxD4ZslaXCuzueXU=;
        b=NvHAwZj2U+kDGADbDoqnA8HNIvDi1WPjinJGC6v5Dw5V3iprvXy5sSVcz0oD38OEFp
         nEfsPESVBB5zObgsTM2PD0LCbrhpWDKzrK/v43OU8FWMAQTQiQhiUvkfLAxQmWez8D1h
         nJQYTnQP3WVgaz/96zRxtytlWNtLWFXc3lzF/27YCqKb+VoScJ3stF1jDlRx+dX/Od3D
         nn+MPQgugtJAmcd+zAiW9gE0sT1uSft/5KtH6vjcAh4FhIP8sbzUlA1ekMkMvsB8NAus
         6zDpQHFrxSJT0lyqVq/GwOnJAmDLwsNZa1Mh/Y6bf7JCrL8q7VUyh6fKEHUkryFNRIjH
         goBg==
X-Gm-Message-State: AOJu0YwHrxUwgXpQXwxaWX6OuriPlOVAYW0N9NkTrEQ92kUo83D2//QA
	s+wBD/pcpIVUA7e5ioDAGFJYLu8buRZk+PBNth6xzMbzjuCMzuorPvR96F3JnpYKaRwJpmsLEgp
	1dNN+jlppuvprmxEln+6G23wnlC9Baw==
X-Google-Smtp-Source: AGHT+IFCRfKhWZRTr+KDp9L4a02S08LEimE8qMaXDlyq6BDCOhXQB2PbalDDpVRn2ZzbZOn51uX14mS9ojwXOeRzWTiU
X-Received: from loughlin00.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:1b6f])
 (user=kevinloughlin job=sendgmr) by 2002:a5d:9907:0:b0:7bf:e3a5:ccea with
 SMTP id x7-20020a5d9907000000b007bfe3a5cceamr11521iol.0.1706652530978; Tue,
 30 Jan 2024 14:08:50 -0800 (PST)
Date: Tue, 30 Jan 2024 22:08:43 +0000
In-Reply-To: <20240121182040.GBZa1geI5NxWSslvt0@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240121182040.GBZa1geI5NxWSslvt0@fat_crate.local>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240130220845.1978329-1-kevinloughlin@google.com>
Subject: [PATCH v3 0/2] x86: enforce and cleanup RIP-relative accesses in
 early boot code
From: Kevin Loughlin <kevinloughlin@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Pankaj Gupta <pankaj.gupta@amd.com>, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Dionna Glaze <dionnaglaze@google.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-coco@lists.linux.dev, 
	Ashish Kalra <ashish.kalra@amd.com>, Andi Kleen <ak@linux.intel.com>
Cc: Adam Dunlap <acdunlap@google.com>, Peter Gonda <pgonda@google.com>, 
	Jacob Xu <jacobhxu@google.com>, Sidharth Telang <sidtelang@google.com>
Content-Type: text/plain; charset="UTF-8"

SEV/SME code can execute prior to page table fixups for kernel
relocation. However, as with global variables accessed in
__startup_64(), the compiler is not required to generate RIP-relative
accesses for SEV/SME global variables, causing certain flavors of SEV
hosts and guests built with clang to crash during boot.

These crashes highlight a broader problem wherein the toolchain does
not guarantee that early x86-64 code executes correctly at any offset.
While Ard has been looking into overhauling the early x86-64 code
going forward [0], the signficant proposed changes are unfortunately
not backport-friendly.

Instead, this patchset continues the approach of fixing the immediate
problem of SEV-SNP boots crashing when built by clang, providing a
backport-friendly set of changes needed to successfully boot SEV-SNP
hosts and guests. In particular, this patchset is a cleanup of V2 [1],
which introduces a macro to force RIP-relative addressing in early
SEV/SME global variable accesses and existing head64 global accesses.

V2 -> V3: Rename RIP_RELATIVE_ADDR(), remove fixup_*(), cleanup style
V1 -> V2: Use GET_RIP_RELATIVE_PTR() macro to avoid -fPIE compilation

[0] https://lore.kernel.org/lkml/20240129180502.4069817-23-ardb+git@google.com/T/
[1] https://lore.kernel.org/lkml/20240111223650.3502633-1-kevinloughlin@google.com/

Kevin Loughlin (2):
  x86/sev: enforce RIP-relative accesses in early SEV/SME code
  x86/head64: Replace pointer fixups with RIP_RELATIVE_ADDR()

 arch/x86/coco/core.c               | 22 +++++---
 arch/x86/include/asm/mem_encrypt.h | 32 +++++++++--
 arch/x86/kernel/head64.c           | 88 +++++++++++++-----------------
 arch/x86/kernel/head_64.S          |  4 +-
 arch/x86/kernel/sev-shared.c       | 52 +++++++++---------
 arch/x86/kernel/sev.c              | 13 +++--
 arch/x86/mm/mem_encrypt_identity.c | 50 +++++++++--------
 7 files changed, 143 insertions(+), 118 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


