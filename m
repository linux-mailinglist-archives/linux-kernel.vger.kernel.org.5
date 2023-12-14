Return-Path: <linux-kernel+bounces-110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B62813C57
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F031C21B88
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAB76D1BC;
	Thu, 14 Dec 2023 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zK/oBF4S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575A06ABBE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbccc6dfa6cso909997276.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 13:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702588042; x=1703192842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=89BRmpC4+tGVLj0OdN3wgdyTYPw2O8NyPVJ2rVYBYWo=;
        b=zK/oBF4SgkYQ5xaW59MHa2kqg31OwdfD1DHqHDOx9Y0QEbHNeBrUS81VD29icpPb7A
         +jXEut6P3DVktbrTyVETejtaoJsOFoVHpyqtT2HUtDhVf+rql66BkA13xT0RhwmUo4Md
         vVoEjYh43XiBEePnhyiTBLFdwYK39rlFxHnhZFrj8Ka/+DLei6NKq9XLqPz5vLoyyjKR
         /mYXL/ubOoZ1nn4r6xXzQJOfw5RB8s2zFqb9IHHcP4F1fSrwpIezyh/k/zJLZCd/UMXc
         rVbDoRTxyUTkNaRrXEw5CQARUBAX6SIVjx+7XMA3XWIsMc+3Q0cqqX8lXD96kSF8ukPX
         kgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702588042; x=1703192842;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=89BRmpC4+tGVLj0OdN3wgdyTYPw2O8NyPVJ2rVYBYWo=;
        b=l8hwft6wiAbwlquain/f0DPgZ0DUoFLah9sHAiHG3ZQAnKdtLpibW0/xADgpW4+9Zw
         CPvmEGcgK19/tIHqqlUuynTdRhVjcrnhlUTdL6M5oJAJBOnqaLMyhlK+kHynxAU1LBZT
         UQSkF2sMJbZ+caJ4J9OOzMcCG4bVstAxRkUAUzvUIlXjqDuXu7zbfp5nGItCdOVeeorX
         suHijrZ0SFwSMdBauHBONQKK33U9MLm0J+muG9KQEVkO7t1pLTXa0jRlcZC/EQQDBchk
         sn6mgoHH98jRJjcVDgcLvaWkvqggdIrTPFzqFkldVWE5iudjciMBidRFtBR7Ecdxw7Sf
         c/zA==
X-Gm-Message-State: AOJu0YzphGdrmTsla5OyjqWnb2xqNaTALzAocXCyAeqVxxnF4LYKRkdX
	mqbbiLALOYCDK1AGLRNdLQPp/BJ3Zi0z
X-Google-Smtp-Source: AGHT+IEak763aS1pPeNAnQmbROsMYYd/NkIf8EJCbCwXKVTEc2nsI06I4KxK9BsEah7aSYwzYu2IrKAJ3sKL
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a05:6902:81:b0:dbc:5587:a079 with SMTP id
 h1-20020a056902008100b00dbc5587a079mr192237ybs.4.1702588042049; Thu, 14 Dec
 2023 13:07:22 -0800 (PST)
Date: Thu, 14 Dec 2023 21:06:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAENue2UC/4XSTWrDMBAF4KsEr+ui0c9I01XuUbqQ5JEjSOJiB
 9MScvfKoZTESdFyDN97I8nnZuIx89S8bc7NyHOe8nAsg3zZNHHnjz23uStzI4VUIIVu9zlMpzE
 f+x37jseWpXIsfTLMsSnqc+SUv66J7x9l3uXpNIzf14IZlq//Z83QQhuxUxq9DGRp2w9Dv+fXO
 ByW7F9onkObKBqrhFHebvuDz/urW5aYZaVYLsUhKRulBmH0jf/rhadOtCoky1YFBLxb+FqsKsW
 qFGvjrHBdchTMenFd8XrxKYCOQFYnXntT8ab4lMCRpnIAjWuPt/7JxePiJbJMIJKLtPa24m3xj
 EKCQnAcu7V3Fe+Klz4SRUcQ4sP5qeKpeKFSedzESlNcexCVABAlgdCTRIGO0T0kQC1h+XnRmcD GitB1d3dwuVx+AMor9c6kAwAA
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702588040; l=922;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=nZp1XvZPyepFJiRIjWff+689JRuWK2jeokDFwb+Pi2g=; b=yfdKwq1qTjzEfhbEEXr5IeMJ/rmRQ4DlYIo+Nul0PS3tzNUos1O7TrQ3BjAxNCL7XeJ3I7Xmt
 GTka5JhU0eSCsswrfahAS7Z3dPLTiceY8Q/arMYPCqqlHpuyexd/7Fr
X-Mailer: b4 0.12.3
Message-ID: <20231214-libstringheader-v2-0-0f195dcff204@google.com>
Subject: [PATCH v2 0/2] shrink lib/string.i via IWYU
From: tanzirh@google.com
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev, 
	Al Viro <viro@zeniv.linux.org.uk>, Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"

This patch series changes the include list of string.c to minimize
the preprocessing size. The patch series intends to remove kernel.h
which causes problems in the sh architecture because kernel.h is 
not properly declared in asm/word-at-a-time.h

---

---
Changes in v2:
- Transformed into a patch series
- Changed asm inclusions to linux inclusions
- added a patch to sh
- Link to v1: https://lore.kernel.org/r/20231205-libstringheader-v1-1-7f9c573053a7@gmail.com

---
Tanzir Hasan (2):
      sh: Added kernel.h to word-at-a-time
      lib/string: shrink lib/string.i via IWYU

 arch/sh/include/asm/word-at-a-time.h |  1 +
 lib/string.c                         | 14 +++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)
---
base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
change-id: 20231204-libstringheader-e238e2af5eec

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>


