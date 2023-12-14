Return-Path: <linux-kernel+bounces-111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 240B8813C58
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38072837D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26576D1AF;
	Thu, 14 Dec 2023 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IuQccIbw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3786A001
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbcca4c56b9so3181611276.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 13:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702588044; x=1703192844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GxLPM1oqmNGerHkMNP4+xZeFGhPzqpzdxyTLE69WerU=;
        b=IuQccIbwI3t5RGVq8DSFSZJWDzoaPScLNd1aOXKEjA7vD3C4mQ1BfJ1znZUgqvzj3T
         6HgaXXvX85AAVKQT3JO7c12sz9TYXyAHOFOkWwcv9F2pjYx/dEVs/UHsQwYt9fleu5N+
         /8F4ObHSFH7Yft4MGk0n3dbBpswpNnhqYpsNqkzi/dRAExG7DvknNwgFY4xCI6goB99N
         08lPbAna4ZewPuZYgih7v20YAXq3Fjv4oOSriZVHOj/4CWiNn40Bp2EeJZ2LJ7Ax/xzP
         q8Gn/9judnOrjyS4Rh7KAUpYN/0Gw9alm1Wpuip9EbwYMH0Z64Ogh8iN2XH6+r3JYRRX
         3nLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702588044; x=1703192844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GxLPM1oqmNGerHkMNP4+xZeFGhPzqpzdxyTLE69WerU=;
        b=nCZ38JJutuu4Oowv2BULlOajOuyf67sEBjQZYzTt8it2fP0gGAIEwckit4QyksBsPp
         askwaLKAnX8BqD5JLXwl/j5DE3rLAJ1fl/HgUblpYuwOL3yypcQPsSPcJTYu9ZpiVqqz
         ote85epAaod5FLP/38IAP8uLSRR26fXoLuj2iZ+myHqvW7UyufhTPSUUwGGFRvOxDeW/
         qJLnmk0RqQgVtRZOBSKx2w3UleIu1Xq9LI3ooDS7zU2ZXEWHwfU1Lsd3AG0LrZ/EX0lp
         ytywQuBHXCwFlH6nXJwF88XxLb9YOGktxFFPfrU26CABFfCkTgVNo33wv+DClp5/Xw1w
         fO2A==
X-Gm-Message-State: AOJu0Yw9uI+IU9hTv1GYsNQTzhk2HmnSU90Avb6eWm7UPX+xiFoLpccM
	Kq19M5IgGk+2YDDA/RbCGHeLxh6KpoRz
X-Google-Smtp-Source: AGHT+IFWZSkq0B2/TbJ3gU0ovel02eHeHOYebHA23VSPZ2uOaylOSpizkT8NynTvz1Zj6UyJGHB/+sVru/Fc
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a05:6902:1345:b0:db7:e75c:24c1 with SMTP
 id g5-20020a056902134500b00db7e75c24c1mr14651ybu.9.1702588043996; Thu, 14 Dec
 2023 13:07:23 -0800 (PST)
Date: Thu, 14 Dec 2023 21:06:12 +0000
In-Reply-To: <20231214-libstringheader-v2-0-0f195dcff204@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214-libstringheader-v2-0-0f195dcff204@google.com>
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702588040; l=815;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=7hhCHMZ64vzG26ydgTYNXlYZ8X3Olq+V06BfdYggSYo=; b=2xXCyTjP9XZppKjpc3ICzOEWNBCWkOuL3pfPLeXwpxUsepeC/rvl31dRR4SAvkKaJIwOJisuM
 2Trf8HpEghbDFhMnztWWFe/NalZlfE8igHkdkOqJ0RQ2b/MWRjjy72t
X-Mailer: b4 0.12.3
Message-ID: <20231214-libstringheader-v2-1-0f195dcff204@google.com>
Subject: [PATCH v2 1/2] sh: Added kernel.h to word-at-a-time
From: tanzirh@google.com
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="utf-8"

This patch includes linux/kernel.h in asm/word-at-a-time.h for the
sh architecture. WORD_AT_A_TIME_CONSTANTS depends on kernel.h.
Making this implicit dependancy explicit allows for later improvements
in the lib/string.c inclusion list.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sh/include/asm/word-at-a-time.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/include/asm/word-at-a-time.h b/arch/sh/include/asm/word-at-a-time.h
index 4aa398455b94..f680f5f1d626 100644
--- a/arch/sh/include/asm/word-at-a-time.h
+++ b/arch/sh/include/asm/word-at-a-time.h
@@ -5,6 +5,7 @@
 #ifdef CONFIG_CPU_BIG_ENDIAN
 # include <asm-generic/word-at-a-time.h>
 #else
+#include <linux/kernel.h>
 /*
  * Little-endian version cribbed from x86.
  */

-- 
2.43.0.472.g3155946c3a-goog


