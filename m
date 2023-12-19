Return-Path: <linux-kernel+bounces-5828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F18818FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF081C217BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC1638DED;
	Tue, 19 Dec 2023 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWASHrIn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43C93C6A3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbd59ddfd66so933514276.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703011684; x=1703616484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AH7uJyoYvXfA7ti80+MOcTI9tFmh1yE9F3ak/L9o5YU=;
        b=RWASHrIn3kAs92Xf7MZqKRKxUUiOL31fD5CSJ2+EGbyoTopYQmnzFPO8XZuh1mU1wd
         WGkk5HHkB4R1Bp8FWMj4jodfBZiaSxBP4ZuuXKlb8QRpTAZwGGCAhg6MxpG90dBH1Cl5
         3jpf4BgDrOV6M0otQUiiyvswptcOBjKccI3yDyVQj0Zuju198Cdb/OaSdCNynBoVwZmK
         h979Q4t0KEz0uPD/XxDUArjHXssSzmZwsFx5d3Q1oK+yBc/Xr0paWGhsJ8JVVKFXm081
         UqVy9z2Zc8Nm/ZWI1RdRFJqHDsf11h/zOobAM3vzhE94qIDywg9f9o8QXDry6VH9Zznt
         0jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703011684; x=1703616484;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AH7uJyoYvXfA7ti80+MOcTI9tFmh1yE9F3ak/L9o5YU=;
        b=QZa+WnnG3S3i5xVOXNCRJYOJcLIdYHrZyoJc2QVhwQpL2MkBqFK8zQ2FEKW0ej1qJq
         WBhvgSb+wo8u8/auB9dstZaSQmwo0LfjM49ED3WtDnmujNmmma+NkJt4zk+Vf9G0KBRp
         A8NVgo6AqzI0GIIJYXB59UQKfkdkDyNjyxuDa0NCIRkhnmtDIxvq2HzAFSodJB1gqWnm
         Sd9q6zQcGrg8lHJtRJcy9m/C4EGHC8x35Ehoe0ksh4f6f8z03UxTS7g32b4Eq9F0CSyL
         77UKDxEymBjvur419M2AX4cgpTzZNTAUXCAII0cTdy0Trz5GBjVyMQwCQ15J8fILhFzl
         mwKw==
X-Gm-Message-State: AOJu0YzOopGmkFrYrj/oQhiH2b0ca31G+7d0iHfNXLnzHPRxQnQ4eivn
	JsgWRJw3vfX4nowThpgGp0sPV6gM5fD3
X-Google-Smtp-Source: AGHT+IGRwQkV/1lt+ej3ziev5gc0fbKJoRnteDzvkQztfb3qTo0Aj5J9t0oNYrAHZ41NuVMoMqlvL1V5fBR/
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a25:be92:0:b0:dbd:2c5a:6c53 with SMTP id
 i18-20020a25be92000000b00dbd2c5a6c53mr565316ybk.6.1703011684012; Tue, 19 Dec
 2023 10:48:04 -0800 (PST)
Date: Tue, 19 Dec 2023 18:47:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFjlgWUC/42U3WrjMBBGX6X4ul5m9DMa9arvseyFJM84hjQud
 gm7lLz7ymFZ0tjFuRzD+c6HNPJnM8s0yNy8PH02k5yHeRhPdfDPT005pFMv7dDVuTFgLBpw7XH
 I88c0nPqDpE6mVoxlMUm9SGkq9T6JDr+viT9/1fkwzB/j9OcqOOPy9fusM7bYFuqso2RyDPG1H
 8f+KD/K+LZk/wP9Nhg0Fh8seJvCa/+WhuOVW0qczY7YLOKsNhTjELy74f97cZOD1mYNEmwmpO3
 C34GgGH1XVGulW/Da2O40trWx8xyAO+WY/WZj3uKg9QC586ygwa/EbkfsFrFmdAVjcCqPil0VU
 1AODjBDsNtHFbfBlCQbcvW4jK4a+53GvjZWRY4u1kty9Ghjv9xRUgZvRJnjSky34o2tpEVsSIw
 iKJf4qJiqWIPWZUZOlPJKHHbEoYqFwKAlZCnd/XPgHZ4rb1KJsXDEXOSejzt8rDxYrZuvYl0s9 zzCTgBCTYiUoiEgFuJVAu4lLL8EYp/Fh7rt3ZczuFwufwEJ9zqx+gQAAA==
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703011682; l=2179;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=43BPgdbj/Ms3cbxr1wobnwnr0jH7BWniivgiGR2rpqc=; b=coinp79Ec0TAuh3fiFjsDVNEqMFsREd1n2Mt0feZKhSdtKEaXxLqyVStXKcahXivUexhHkdMi
 bJMQGmZWzlzDrK/7mRiG4DzabmHFPttI3RUcew83zYCphbMi7L0UfF2
X-Mailer: b4 0.12.4
Message-ID: <20231219-libstringheader-v5-0-206d4afd309a@google.com>
Subject: [PATCH v5 0/2] shrink lib/string.i via IWYU
From: Tanzir Hasan <tanzirh@google.com>
To: Kees Cook <keescook@chromium.org>, Nick Desaulniers <nnn@google.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Greg KH <gregkh@linuxfoundation.org>, llvm@lists.linux.dev, 
	Al Viro <viro@zeniv.linux.org.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"

This patch series changes the include list of string.c to minimize
the preprocessing size. The patch series intends to remove REPEAT_BYE
from kernel.h and move it into its own header file because
word-at-a-time.h has an implicit dependancy on it but it is declared
in kernel.h which is bloated.

---

---
Changes in v5:
- Removed bad copyright.
- Link to v4: https://lore.kernel.org/r/20231219-libstringheader-v4-0-aaeb26495d2f@google.com

Changes in v4:
- Fixed personal email client so name appears instead of just email
- Removed kernel.h where not needed.
- Sorted include list in lib/string.c and used linux/limits.h
- Link to v3: https://lore.kernel.org/r/20231218-libstringheader-v3-0-500bd58f0f75@google.com

Changes in v3:
- Moved REPEAT_BYTE out of kernel.h and into wordpart.h.
- Included wordpart.h where REPEAT_BYTE was necessary.
- Link to v2: https://lore.kernel.org/r/20231214-libstringheader-v2-0-0f195dcff204@google.com

Changes in v2:
- Transformed into a patch series
- Changed asm inclusions to linux inclusions
- added a patch to sh
- Link to v1: https://lore.kernel.org/r/20231205-libstringheader-v1-1-7f9c573053a7@gmail.com

---
Tanzir Hasan (2):
      kernel.h: removed REPEAT_BYTE from kernel.h
      lib/string: shrink lib/string.i via IWYU

 arch/arm/include/asm/word-at-a-time.h     |  2 +-
 arch/arm64/include/asm/word-at-a-time.h   |  2 +-
 arch/powerpc/include/asm/word-at-a-time.h |  2 +-
 arch/riscv/include/asm/word-at-a-time.h   |  2 +-
 arch/s390/include/asm/word-at-a-time.h    |  2 +-
 arch/sh/include/asm/word-at-a-time.h      |  1 +
 arch/x86/include/asm/word-at-a-time.h     |  1 +
 fs/namei.c                                |  2 +-
 include/asm-generic/word-at-a-time.h      |  2 +-
 include/linux/kernel.h                    |  7 -------
 include/linux/wordpart.h                  | 14 ++++++++++++++
 lib/string.c                              | 17 +++++++++--------
 12 files changed, 32 insertions(+), 22 deletions(-)
---
base-commit: ceb6a6f023fd3e8b07761ed900352ef574010bcb
change-id: 20231204-libstringheader-e238e2af5eec

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>


