Return-Path: <linux-kernel+bounces-111814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C63488714B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D263B20BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6945604BA;
	Fri, 22 Mar 2024 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+6NjRLI"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8519660254
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126376; cv=none; b=UGxmPGToh4/BhHoQQQX3Wf52c9fB1A8CHdd+psJKDXwqzAY0BDgKs4+ItJPNXOvMSVq91zbOVE3tU901RREiJzpBUhC9rnAm0qWLoyr3F0fNPX5jZGNkOU/IF550tXhVHmGklunxEutTcQugpFf77iGZ+aYjFNhkX/Qn9gbnp1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126376; c=relaxed/simple;
	bh=vHCEtQUNKboF1EBobqFitqfcjvkiF76fENvbIuSp/p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDoQ0Br7ZENzYHQF0sdk6cBLDuRu5EiwXhPDanAz/+JgIladYsu1hayuRx3B2xr1AI5D3fZBfGSe+l/3vBfo9/K0CgR/ArL3APSvtB2FnvzYkQNjSOTuDpjljRmUs++jJNusuABicMk1QpxOC1G8ZzZYN36/tVQ7L+gXzMHtNik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+6NjRLI; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-789e4a4d3a5so160939085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126372; x=1711731172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZ0GbtudtLz2tjdpQffeTy/JKfNLrKUmMY/gqagEmlQ=;
        b=g+6NjRLITYdScf+tGlwFJl7BJJCuvxaeWN8LDlsu0d2xQ3bGOBqFReT5Nsa89+hN/S
         Tu3UXbDtfcDjPBfKP9ljoaUBC7q91xecP/y3e+ezGB/RYErWlxICqBjkpD0ZSkjDVtdY
         JDq+eKxHEq1I+TL+jTssJ2wmHBfzrZlx+RVJJUQHbY/mtRUu5lldWi+Af5Js/K21asWy
         xT1D43q7zPk42/IkmTg405knmwlvXebbYYP2sJuQwWQXPj3LyJ75o1JD0QwZ9gQMmBDG
         imbmWRNlDl28NPNx90oCpvGJvs+mvTf+/Dhtdk02e/pmw1skASPyxoK0bn3MIV1LpqCo
         Asvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126372; x=1711731172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZ0GbtudtLz2tjdpQffeTy/JKfNLrKUmMY/gqagEmlQ=;
        b=r8rYAspJG3ASrN3PKAlrwOxVHu5dcofPKLV+gYH0kNkgrFIPfaRWm0CxaaNlOKQrRw
         r8NMqxBe+I7ay9QhlO3VY8/cF6lSSYsk8qMnVeVjuHg6dq073+sHLasPyHO0C4jIr1sI
         bWKZjHLBED2BIEdb9BaZiHtxHztlrUVusjOJB/06KX3o6dLDCCWF4fhZLr+Kl8OwcRnz
         bWmwnygO4KGN7DrXFOlbq6KikeW5mSGI7uZJsuac8n/rFvfY1IMQcVUiduIkw+RQKUyw
         vx1PJo2E9n4HIx6CcCS103LkvgTpECQ1pnPcYbtE1fMh/zXFfoqyEQQZ5BF8J6vKV1La
         0moQ==
X-Gm-Message-State: AOJu0YwQrtJIeeG/7eM4lB81/uco5GX3oniOV3LAdgtIww2pP9p7cqXB
	dNvEyyOfk9t0s08jqPfgSFKDxP5a8HtVaGDkyvevh0K86Y0fcYuwE/vp/J8=
X-Google-Smtp-Source: AGHT+IHYguapQSmH5+/TDI2EpFKsaKdcAAFmZIGnZVztKI7x9IXwVGFPaJNPesx49FQClUBMfkh38Q==
X-Received: by 2002:a05:620a:16dc:b0:78a:2809:dc69 with SMTP id a28-20020a05620a16dc00b0078a2809dc69mr3143112qkn.51.1711126372661;
        Fri, 22 Mar 2024 09:52:52 -0700 (PDT)
Received: from citadel.lan (2600-6c4a-4d3f-6d5c-0000-0000-0000-1019.inf6.spectrum.com. [2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id j1-20020a37ef01000000b00789e9bbf962sm894901qkk.133.2024.03.22.09.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:52:52 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	David.Laight@aculab.com,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 05/16] x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
Date: Fri, 22 Mar 2024 12:52:22 -0400
Message-ID: <20240322165233.71698-6-brgerst@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322165233.71698-1-brgerst@gmail.com>
References: <20240322165233.71698-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang may produce R_X86_64_REX_GOTPCRELX relocations when redefining the
stack protector location.  Treat them as another type of PC-relative
relocation.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/tools/relocs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index e7a44a7f617f..adf11a48ec70 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -31,6 +31,11 @@ static struct relocs relocs32;
 static struct relocs relocs32neg;
 static struct relocs relocs64;
 #define FMT PRIu64
+
+#ifndef R_X86_64_REX_GOTPCRELX
+#define R_X86_64_REX_GOTPCRELX 42
+#endif
+
 #else
 #define FMT PRIu32
 #endif
@@ -224,6 +229,7 @@ static const char *rel_type(unsigned type)
 		REL_TYPE(R_X86_64_PC16),
 		REL_TYPE(R_X86_64_8),
 		REL_TYPE(R_X86_64_PC8),
+		REL_TYPE(R_X86_64_REX_GOTPCRELX),
 #else
 		REL_TYPE(R_386_NONE),
 		REL_TYPE(R_386_32),
@@ -865,6 +871,7 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 
 	case R_X86_64_PC32:
 	case R_X86_64_PLT32:
+	case R_X86_64_REX_GOTPCRELX:
 		/*
 		 * PC relative relocations don't need to be adjusted unless
 		 * referencing a percpu symbol.
-- 
2.44.0


