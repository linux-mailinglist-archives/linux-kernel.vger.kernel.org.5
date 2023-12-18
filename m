Return-Path: <linux-kernel+bounces-4253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5B68179E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DB7284288
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBEF1DDD1;
	Mon, 18 Dec 2023 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tbau4Ucg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803161DDF8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5c1b986082dso2338301a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702925091; x=1703529891; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Umcq9pE2qVMi4A7br5lqgMwWQo55dWONwlMYoYlXcJc=;
        b=tbau4Ucg+1TSUNp8jNMUSJsGz+aUm+qOHGKLlgp78HyMP16dUN0uQ4avAIwQsExeH3
         zrs2fwKJBV/HnAhUhzN42cdgYp8qA+LxJojrBB+EglGlI1nOceHTkL8KWXsv9Yct4Zxc
         RQGMuhaQVJ7kPdNIvOF5iilSSkzxk+QHqcnH1d0sL8uybgTyeRRtNFsCq5NmpLfifGxK
         vBghrJf1qxarj7+wUDRPVy3xn905zbcrQrFGUminaDVpPeAUxTGUoYPfFILvMZ6JoWpb
         tsXl5vhtEqxw7d9WscB/hRfAH6x6RtsBGDhP+1QGDmOwS+Cu+ClIp9dqhomF8e4I0C1B
         BZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702925091; x=1703529891;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Umcq9pE2qVMi4A7br5lqgMwWQo55dWONwlMYoYlXcJc=;
        b=lkMq6JbvoZLpU7pNknbebwPS+IAWhB8n0Sem75mlpz5AZOc1Oq/jm7X/LKyi0lCC9a
         cuGIihW1nMR0rJmqnN0vGx4h2Dk89+JzMBraU8TcPEujJCka7zCEj3OqDC5RgrFb5TG6
         lsJQFAlYJcrDNQkq9mvTeE8pNhSxnaA/t3GL5fnF57tuZM3ouLTUWPYQ6mwTV9qxVmtS
         OggIrgYIGxmnZ/NuMV0uX46aGI5kJs3WbiScCWNpCzLgQNGuqt3MBJuf+XuE3rh6x2kB
         Ltx/seeixBYwKEvIcR36uZaKCT1V1s00UW+pI21SBu+orymIdq53hv9WR4ozytAf5/YM
         VFIw==
X-Gm-Message-State: AOJu0YwRApdR9FD6hKNozskWVAl4Pha9dLvd8J+Mx3G2nhBXG96qvah2
	ABlptjqMZNIRaz8zwF9bI5CSIupzJeDF
X-Google-Smtp-Source: AGHT+IFE5E5xs9/zAhH8vcnygkkfl0PCpr5tsTnZBHzOIorNrVpXpn3X2Q2hh1/CdP4PLIOh1kQR2Ti1FTom
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a65:6a43:0:b0:5cd:9db5:bea with SMTP id
 o3-20020a656a43000000b005cd9db50beamr67169pgu.5.1702925090774; Mon, 18 Dec
 2023 10:44:50 -0800 (PST)
Date: Mon, 18 Dec 2023 18:44:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAB6TgGUC/4XSTWrDMBAF4KsEr+ui0f90lXuULix5xhEkcbGDa
 Qm5e2VTSuo4aDmG782T5Gs10pBorN5212qgKY2pP+dBveyqeGjOHdWpzXMlhVQgha6PKYyXIZ2
 7AzUtDTVJ5Uk2bIhildXnQJy+lsT3jzwf0njph+9lwQTz1+dZE9RQR9sqbRsZ0OG+6/vuSK+xP
 83Zv9BsQ8cYjVPCqMbtu1OTjoubS0yysFjOiwMrF6UGYfSd/9sLm07UKrAjp4IFu134GRQMaNr
 InCvdw6WxKjRWubE23gnfssdg1ifWBa9nzwF0BHSaae1NwZvsmcGjxnxybdfe3vuNF7Ozl5Ykg
 2Afce1dwbvsyQoJyoKn2K69L3ifvWwiYvQIIT6cHwsesxeK8+MyKY1x7UEUAkDkBLQNSiusJ+s fEqCUMP/11ptAxonQtv/u4Ha7/QDw4iUK3QMAAA==
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702925089; l=1752;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=RDM8JOpRAJHGe23evuBZKylujjf7/Qb+zvnBcMz4jJs=; b=EEkbJY4feebHBYM69j9pAsvv38o2vJRW6XvSDPqCCEOT19ZRXkDrfelwZHecR/aI/ZfyTTqmn
 VhWknFpcrqbD4c74Bz7DycdCrOCDvDb1BCDJTNZ87dmBQUQl5wTvmrz
X-Mailer: b4 0.12.3
Message-ID: <20231218-libstringheader-v3-0-500bd58f0f75@google.com>
Subject: [PATCH v3 0/2] shrink lib/string.i via IWYU
From: tanzirh@google.com
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev, 
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

 arch/arm/include/asm/word-at-a-time.h     |  1 +
 arch/arm64/include/asm/word-at-a-time.h   |  1 +
 arch/powerpc/include/asm/word-at-a-time.h |  1 +
 arch/riscv/include/asm/word-at-a-time.h   |  1 +
 arch/s390/include/asm/word-at-a-time.h    |  1 +
 arch/sh/include/asm/word-at-a-time.h      |  2 ++
 arch/x86/include/asm/word-at-a-time.h     |  1 +
 fs/namei.c                                |  2 +-
 include/asm-generic/word-at-a-time.h      |  1 +
 include/linux/kernel.h                    |  7 -------
 include/linux/wordpart.h                  | 17 +++++++++++++++++
 lib/string.c                              | 14 +++++++-------
 12 files changed, 34 insertions(+), 15 deletions(-)
---
base-commit: ceb6a6f023fd3e8b07761ed900352ef574010bcb
change-id: 20231204-libstringheader-e238e2af5eec

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>


