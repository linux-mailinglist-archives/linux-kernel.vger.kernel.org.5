Return-Path: <linux-kernel+bounces-118219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D312488B63F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5973B2E88F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182CE1BC4F;
	Tue, 26 Mar 2024 00:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjPrIo17"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92CB1B28D;
	Tue, 26 Mar 2024 00:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711413706; cv=none; b=A6bpKX4t3s1XLH1zT4ZQYq+FNEUYpoHOWPXQRuEUxSkvD8LzviBgng6+L0014TzmJtcFwYSVJKq0VagvXBdY0fajXP4Yh3Yk6VyUBNixi7vl9jReMtf4J0Bdr2Yn4l+WVBblVFWRyokjv2ZXZRqloerZ50gwtpW0JClr4OjQSpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711413706; c=relaxed/simple;
	bh=sO0d/mps9kdY+m5kw8PixGdK4LtIlRtqftGoHYkhLKM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L6dah08sICqHaw7vavSGem953zcAIxVi7jOuAN9tJ+SubHNyEiaZuES7ib0HoMj/ny8B/bnwuPmwFKR+JvdV/p5jN9A+LB5hg/DHjqKWHENcYTm/CUdSVwt351rhg7hVYXQ7EwEhFcOnuD6xDxXY+GpzgVxTMTwsFau4zA9BsSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjPrIo17; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ea8a0d1a05so1931425b3a.1;
        Mon, 25 Mar 2024 17:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711413704; x=1712018504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oZ0qd1iGxtr/mWs3kOYHpeMOliTzM44U+9k3boYAHSY=;
        b=bjPrIo17hZCEh+E0X3m2J3ArqkUjbUvIEmYIKLw+WTgiwfpHvaBLEFfDHi3t2YchbY
         RbLqeYKujv24L+PmZR+xREPgkI7OaxugCGvNnThbisSS7jfo5DSTKIsa3VY0DIPEy+2g
         asKklHk4gAjQjFuLhU6a/lSFEHjPYQEkxS97T0PKkdcD4lVDsY1xCCPNH9DiligRiyQT
         GKopjLnI+i6uctSjQmxvuxehspv6l6u/KM1I9z5FeaDHBORcTo4RLO0HLnGscSoJYLTB
         xTsftPzVh0XMq9s85JhrZyjf8mSZsWjWh+cerReqf/XiWZf6Xuj6Q9oVGUo8mPi5nQMq
         Qxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711413704; x=1712018504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZ0qd1iGxtr/mWs3kOYHpeMOliTzM44U+9k3boYAHSY=;
        b=TaZOlAQaNogdje6sNtxlngi4uM6R0eCHnJsQKFkX9V9sbTGP+MzxtjZSBjFwLB3Bt/
         osW0qZ6/ifD43tCgsguo4HuyuKzVj+w0pBWJmmbR3yqq4bI56RM/QoIwIyyNq2V4cTfE
         X0rZjSG+IqKD8KP23j/1bE+vDLzW9fLUtNajQK9HNPo4aTYMauv2f8StMmB5rfaFJPdD
         cxWELZIIb9caGFtSV5JDw6LWjvhC+pCoGxQfH+KMDseTjS3xqnP53Vh1eN0X+er3H45e
         P65QmZwGT1iCOenUb5QVyFz3nFYQvOVOL5LQpgps9dzFXfFYJ0OMzYowrCnyTrMBZBVu
         wzRg==
X-Forwarded-Encrypted: i=1; AJvYcCX5ruWUurh4ZuKVsgx+vtmdi/kOXNXRoUCir1dv+HsZyXggu7Gnzk78hRPHjyDppfICqgJYBrzj3hfBGZa+THOB8MI+bA72lAvq8Pwu
X-Gm-Message-State: AOJu0Yw7ozq19rX/FsH+5rEEqlFyJZzw864EHC4Op3tNEewIAtDeuQar
	2JIKMT3wYXpdqc+Wxf/zY/EYIV36Rmdpi4yYrm/nsEcLPUilx9ns
X-Google-Smtp-Source: AGHT+IEYA+WGKNoGVFoskptYgEJAnpjVW/jus1NyBr8FPL7f00woF98aIvALMq/Ie3Y4t7IfilsxDg==
X-Received: by 2002:a17:903:228f:b0:1e0:b5d3:3f99 with SMTP id b15-20020a170903228f00b001e0b5d33f99mr8045499plh.26.1711413704161;
        Mon, 25 Mar 2024 17:41:44 -0700 (PDT)
Received: from localhost.localdomain ([190.196.101.184])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b001e0a80bc0casm5005148plg.8.2024.03.25.17.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 17:41:43 -0700 (PDT)
From: Camila Alvarez <cam.alvarez.i@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Camila Alvarez <cam.alvarez.i@gmail.com>,
	syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
Subject: [PATCH] fix array-index-out-of-bounds in bpf_prog_select_runtime
Date: Mon, 25 Mar 2024 21:38:35 -0300
Message-Id: <20240326003832.102750-1-cam.alvarez.i@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF documentation specifies that the maximum stack depth for a BPF
program is 512 bytes. This is not enforced when selecting a bpf
interpreter, thus casuing an index out of bounds error when trying to
obtain an interpreter with a bigger stack size.

This patch enforces the stack size to be not bigger than
512.

Reported-by: syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
Signed-off-by: Camila Alvarez <cam.alvarez.i@gmail.com>
---
 kernel/bpf/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 696bc55de8e8..8167b3a721e9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2196,7 +2196,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 		BUG_ON(1);
 		return 0;
 }
-
+#define BPF_MAX_STACK_SIZE 512
 #define PROG_NAME(stack_size) __bpf_prog_run##stack_size
 #define DEFINE_BPF_PROG_RUN(stack_size) \
 static unsigned int PROG_NAME(stack_size)(const void *ctx, const struct bpf_insn *insn) \
@@ -2345,7 +2345,7 @@ static void bpf_prog_select_func(struct bpf_prog *fp)
 {
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 	u32 stack_depth = max_t(u32, fp->aux->stack_depth, 1);
-
+	stack_depth = min_t(u32, stack_depth, BPF_MAX_STACK_SIZE);
 	fp->bpf_func = interpreters[(round_up(stack_depth, 32) / 32) - 1];
 #else
 	fp->bpf_func = __bpf_prog_ret0_warn;
-- 
2.34.1


