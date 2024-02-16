Return-Path: <linux-kernel+bounces-69254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C90858647
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298A21F24D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F6E6A005;
	Fri, 16 Feb 2024 19:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUJNyjx0"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCA8133439;
	Fri, 16 Feb 2024 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112500; cv=none; b=u2euYP6mgxZ0wP+bPzDShNUY6nz5dauFgJFxln1JdvqqV/q/FvM3ms4yEv0rHpeBDktJ7HZvjx6/7Whk+6wA8rK7HpNXOiO2Q8UlSpSicFLR+vnU5QUCnCxN0KkS5kVEgJYpQQfDgerK2JAR4SAVz3caXMJ+AjZfmhEQMhfhk/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112500; c=relaxed/simple;
	bh=DH/uzdUlbeC3FFPnken3LFbJuJQKwv/KhPhyiaVAszY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tKletxDgtc9wx0fXMDSQDVU/WwPVbu7FUxoImRLtfE4FDjCtVJnkFfIouH4MBg6qjrEQUb0XGJ6jJLV78kmISjQaUDLiNyEXpoyqZMgM+w1iWD1djnrHhLe1hG27Z1PT5HGGMAZcrqNqTCzwTIWfoLAsD2/ql6x3oYDh+ou7X1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUJNyjx0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d746856d85so10598795ad.0;
        Fri, 16 Feb 2024 11:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708112498; x=1708717298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=33ahW5QYorwTpyWJJP/aIrICM0csSVst9XZI4ba5EMo=;
        b=CUJNyjx0Bui4DQWkeC4jrArnS9c1N1XsiSS1qRX9HCS7U+P2rJ1wUe22BZS8ATzU4a
         DAG2At7ZhaUHbFTF2eKKzTcg2EyWAasxWDrUau84VbsynQLkjYHB0EqZPNHxGBqeAj2C
         q9n1NvVNJoHmjghKJuzz3BXjWqHac4MLk1/FHlB1jDMGC9maetdQJIMCtF7onTkkbzvG
         TgqJDfbAZTkA3SsZBysocFVjtaES8wEyr+xaogfX6N519poCkTJzB7wMFBlcumgU78D6
         K8sbSxm4RfMzoy9PNmlOeB8z+az9o4FGYm89jDiWy4gjeyYjkBneY9W0JvwmyYe0YpdO
         +OMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708112498; x=1708717298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33ahW5QYorwTpyWJJP/aIrICM0csSVst9XZI4ba5EMo=;
        b=AkXobaXJwW4HYld4rAGuefqvGrEoa5cBWCqI5mhCyA9pH2POCBUbEOnmA5LZPGW+gb
         2NCD2NaNzmG8az1DnC4Lj7uQbAdTtW4R4fF/DYOPgD7WnfnlH+4yeOS3XE/E7t1uuxfC
         RO3I1woe9WfrOOqervxHJiBM1ORtCXMvtI7twXGMqKISFVPVzzPBkgfx2VJX8ldQ7A/y
         +mnrvr0j/CIa4EivWHcEn1MLkyY+gHJHsSgtFbZ7kVBCbbpMf7tHCepaepZ4ZlQnh284
         qwTlR1uZCj5uVTdvxcuIeIondl39Z/05m3Ps/gJF3tnFnm5F1npfGNJMhM/ZsLKJ/wSU
         3PlA==
X-Forwarded-Encrypted: i=1; AJvYcCUx7+SGwBT0EVJumNXaid5sQH245AQ4i6L3A6Au5k4QB0MXmFQKS+uZUV+DV8ZIOy1+4qwAsPQR6f2RYOEM8345i5ZmltmcN9eLkMhB
X-Gm-Message-State: AOJu0Yw3R9jpra3kPLyOV5W49ZuHTJEAMIJc08vBrfEwAUFxpchfM5zb
	RuoN0PqCrw6HS3G1YX1KpFkU8DGUA36aH5FQYBZWVaYOBj01ggpViRg8ih+O
X-Google-Smtp-Source: AGHT+IGQoEmo/X2Fh8UUX4sWu+Gjv5w2XE861xwFe5+3cEGaTpeCejaqfIOTd8V+lh5n/WOgCC1ZoA==
X-Received: by 2002:a17:902:ef96:b0:1db:3004:aa9f with SMTP id iz22-20020a170902ef9600b001db3004aa9fmr5050384plb.5.1708112498416;
        Fri, 16 Feb 2024 11:41:38 -0800 (PST)
Received: from prabhav.. ([2401:4900:1c62:ed3c:fec:32d0:af06:85d0])
        by smtp.gmail.com with ESMTPSA id v6-20020a170903238600b001d9bd8fa492sm217800plh.211.2024.02.16.11.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 11:41:37 -0800 (PST)
From: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Subject: [PATCH] Writing the first patch correcting the spelling mistake.
Date: Sat, 17 Feb 2024 01:11:26 +0530
Message-Id: <20240216194126.13336-1-pvkumar5749404@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
---
 Documentation/bpf/verifier.rst               | 10 +++++-----
 Documentation/process/submitting-patches.rst | 12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifier.rst
index f0ec19db301c..1b39809277d2 100644
--- a/Documentation/bpf/verifier.rst
+++ b/Documentation/bpf/verifier.rst
@@ -9,15 +9,15 @@ First step does DAG check to disallow loops and other CFG validation.
 In particular it will detect programs that have unreachable instructions.
 (though classic BPF checker allows them)
 
-Second step starts from the first insn and descends all possible paths.
-It simulates execution of every insn and observes the state change of
+Second step starts from the first instruction and descends all possible paths.
+It simulates execution of every instruction and observes the state change of
 registers and stack.
 
 At the start of the program the register R1 contains a pointer to context
 and has type PTR_TO_CTX.
-If verifier sees an insn that does R2=R1, then R2 has now type
+If verifier sees an instruction that does R2=R1, then R2 has now type
 PTR_TO_CTX as well and can be used on the right hand side of expression.
-If R1=PTR_TO_CTX and insn is R2=R1+R1, then R2=SCALAR_VALUE,
+If R1=PTR_TO_CTX and instruction is R2=R1+R1, then R2=SCALAR_VALUE,
 since addition of two valid pointers makes invalid pointer.
 (In 'secure' mode verifier will reject any type of pointer arithmetic to make
 sure that kernel addresses don't leak to unprivileged users)
@@ -323,7 +323,7 @@ Register liveness tracking
 
 In order to make state pruning effective, liveness state is tracked for each
 register and stack slot. The basic idea is to track which registers and stack
-slots are actually used during subseqeuent execution of the program, until
+slots are actually used during subsequent execution of the program, until
 program exit is reached. Registers and stack slots that were never used could be
 removed from the cached state thus making more states equivalent to a cached
 state. This could be illustrated by the following program::
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 66029999b587..34a68836aa60 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -5,7 +5,7 @@ Submitting patches: the essential guide to getting your code into the kernel
 
 For a person or company who wishes to submit a change to the Linux
 kernel, the process can sometimes be daunting if you're not familiar
-with "the system."  This text is a collection of suggestions which
+with "the system". This text is a collection of suggestions which
 can greatly increase the chances of your change being accepted.
 
 This document contains a large number of suggestions in a relatively terse
@@ -468,11 +468,11 @@ ask to have an Acked-by: line added to the patch's changelog.
 Acked-by: is often used by the maintainer of the affected code when that
 maintainer neither contributed to nor forwarded the patch.
 
-Acked-by: is not as formal as Signed-off-by:.  It is a record that the acker
-has at least reviewed the patch and has indicated acceptance.  Hence patch
-mergers will sometimes manually convert an acker's "yep, looks good to me"
-into an Acked-by: (but note that it is usually better to ask for an
-explicit ack).
+Acked-by: is not as formal as Signed-off-by:. It is a record that the
+acknowledger has at least reviewed the patch and has indicated acceptance.
+Hence patch mergers will sometimes manually convert an acknowledger's
+"yep, looks good to me" into an Acked-by: (but note that it is usually
+better to ask for an explicit ack).
 
 Acked-by: does not necessarily indicate acknowledgement of the entire patch.
 For example, if a patch affects multiple subsystems and has an Acked-by: from
-- 
2.34.1


