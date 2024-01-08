Return-Path: <linux-kernel+bounces-19097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E268267EC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0280F1C217F3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 06:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C232B8BF9;
	Mon,  8 Jan 2024 06:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2DN7ekIG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F156E79E0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 06:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dc759c8ddbso1028484a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 22:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704694910; x=1705299710; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IgN1RtSHS+JihbyfrF8H+rWapyEwSGcmrp8GqdU1aGQ=;
        b=2DN7ekIGK1/yLPY1pxIflUzigmiH8i56/hivs7ATSg9Rj7YB4rOQOGV6N63042ryQk
         v7vTvibrGwafN5khBakC3nytLO+qBJ0mIkvNEsAbIWhhG1u/sImHGbH/jkgdEeQN1ccp
         KKA3+rMfbwRqMWUCfqLdupX88ahs4laXFQZe3SXcupyfb1s9wJ7pvCCY7i9xLRPESqkk
         QbYFxi55kYFxuKXxAqrWK8Ri0BvbhKw/v43VdKOzJMAxt00VltsCuvMKyYC3YONejfGF
         ncRGChFwuWh7KpVJnBBwxpSmj1oB7q+reBVOlzX2hJQ2ONjnTNvPLTvCrOkAjS9rIQ42
         I6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704694910; x=1705299710;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IgN1RtSHS+JihbyfrF8H+rWapyEwSGcmrp8GqdU1aGQ=;
        b=FU5j2K3H19LqIoxnj51vQGALU0dFslo9iw+HWLYASEwZScFr5zVUJRLJHHl9x/AU6R
         e8OsT0atEZhpYJtaFIZIR3f58eZBhwlynuY8gxm/djC7dCQ9YmWhiaXJmL62OCbInxN8
         OBvoF683tAI6Hv5q83TBt23Qur2gp6YB1/WJJsZ2mQsMenVkAdj489i74/j/Pw/3+SE6
         uWoiGHQhd/np+rxrVkMr5OSi5fFOb9u9cMYPFL6WcaSWnaye9pzxQrf/8ldxcH8NI7Pp
         CY9QerQJRFzty0awkQ6bK9y2mPBrkEUfURjf7Im1SVN2hYI/PVESYG60R4uZcCDh3eR2
         BuXA==
X-Gm-Message-State: AOJu0Yx1+IwV0bYhOI27bqIgmnYiBcRg8QjB3CYtOPmeJdEHqy8VSR0x
	lKSx9bUudgwHRi4ZE0FT7jM2C2fcACZdaWmXsX59TmwFk0g=
X-Google-Smtp-Source: AGHT+IHHLM64yXuAJqutSrCtJH9wFIuHVngJMBfn7wJwWMQrh6npPEnqoNbWGGHxcbsCZuTJ7MSZxQ==
X-Received: by 2002:a9d:6558:0:b0:6dc:c4:c97 with SMTP id q24-20020a9d6558000000b006dc00c40c97mr1594886otl.11.1704694910008;
        Sun, 07 Jan 2024 22:21:50 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id i12-20020a9d53cc000000b006dba99e1835sm1274322oth.4.2024.01.07.22.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 22:21:49 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v4 0/2] riscv: Create and document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Date: Sun, 07 Jan 2024 22:21:44 -0800
Message-Id: <20240107-fencei-v4-0-d4cf2fb905d3@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHiUm2UC/23NTQ7CIBCG4as0rMUwQ/905T2Mi0IHOwtbA4Zom
 t5d2mg1xuU34XkZRSDPFMQ+G4WnyIGHPo18kwnbNf2ZJLdpC1SoAaCSjnpLLN3Olaqt6tw1SqT
 HV0+O70voeEq743Ab/GPpRpivrwTiOxFBKmnIqhrAGgQ8eI5D4N5u7XARcyXil9RqlZgkWlOib
 gwYcH+k/kgEvUo9/1kVUNSoazLVj5ym6QletJnOEwEAAA==
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Atish Patra <atishp@atishpatra.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704694908; l=1657;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=kIreaapBsnIOgafnWutqHg5bxWxo+ONImq2ZU3lLm5E=;
 b=ei81+ovlZsn5ye8bHDG1IeVHaGGTtLEg4XHJVKc6XwI/8Hr00OB2m23YatRSjeq1jM5jcTeS4
 8vIYF4k9/t2DQEpEQw+fNFyeJBf43MRFboveLsDiG4vGL6Z22QJo4pd
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Improve the performance of icache flushing by creating a new prctl flag
PR_RISCV_SET_ICACHE_FLUSH_CTX. The interface is left generic to allow
for future expansions such as with the proposed J extension [1].

Documentation is also provided to explain the use case.

[1] https://github.com/riscv/riscv-j-extension

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v4:
- Add OFF flag to disallow fence.i in userspace (Atish)
- Fix documentation issues (Atish)
- Link to v3: https://lore.kernel.org/r/20231213-fencei-v3-0-b75158238eb7@rivosinc.com

Changes in v3:
- Check if value force_icache_flush set on thread, rather than in mm
  twice (Clément)
- Link to v2: https://lore.kernel.org/r/20231130-fencei-v2-0-2cb623ab1b1f@rivosinc.com

Changes in v2:
- Fix kernel-doc comment (Conor)
- Link to v1: https://lore.kernel.org/r/20231122-fencei-v1-0-bec0811cb212@rivosinc.com

---
Charlie Jenkins (2):
      riscv: Include riscv_set_icache_flush_ctx prctl
      documentation: Document PR_RISCV_SET_ICACHE_FLUSH_CTX prctl

 Documentation/arch/riscv/cmodx.rst | 88 ++++++++++++++++++++++++++++++++++++++
 Documentation/arch/riscv/index.rst |  1 +
 arch/riscv/include/asm/mmu.h       |  2 +
 arch/riscv/include/asm/processor.h |  6 +++
 arch/riscv/mm/cacheflush.c         | 56 ++++++++++++++++++++++++
 arch/riscv/mm/context.c            |  8 ++--
 include/uapi/linux/prctl.h         |  4 ++
 kernel/sys.c                       |  6 +++
 8 files changed, 168 insertions(+), 3 deletions(-)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231117-fencei-f9f60d784fa0
-- 
- Charlie


