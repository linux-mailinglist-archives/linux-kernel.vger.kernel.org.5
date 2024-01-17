Return-Path: <linux-kernel+bounces-29508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA24830F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBE2284515
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C4428694;
	Wed, 17 Jan 2024 22:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fWqYOPrJ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0252E858
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531175; cv=none; b=kHjfEt1Akhah+xbHVGiq/p5Css7xta7/fu+KJnVgXBCDOn8oCG606sygsUgSQ25ospB/tgTXpv+YcD4Sqocebt2frVYY4QNoiml0soiMAzPwSV9hW2zHL8DzzRZ3haNu7RbXvRL5XMNVkE6LP9OVjayueYlGeAIpNv4f1ppuFSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531175; c=relaxed/simple;
	bh=oRoNsUf+N/66WV9Y3eaIeFuphFtcmnjjyoS3YAhmUgk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	b=mOw3VTOgYN7q5PXdhoUh0h2FIQdPkfE8FyUeLpzCYzLUi7LcFmGEV2dee9D7OMBRXYCFuo/AxmB50ab2SJNK6dLjB8LHFfms6cyIPtYGf8Hl7zSIzTM5flKcavz0/x3C5pwjYqa5ZjRZ6xB+60Kw9ve/F6JBIIhKM9rk1LecpkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fWqYOPrJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc253fee264so510207276.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705531173; x=1706135973; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eLaX/VsA0yABQN8R4nb/2mlejC59XdV0vgZ4D9pH8tM=;
        b=fWqYOPrJCsvZVR9nuCQLf0mAJYaQjM/FKrge94dd/SjNIz4qBuSWF4HhLGThHeKynW
         i8spFJehhXYxItmx6unFG+0ow8iPRThYgrE4LTpNWCK38CAW6izIAJE/7SKvhr77oNUl
         tMdIH16Mq1cJ8fpptNKfhNJqbrXmm157sscNG/wAe+k1YDDRkPdZ0sXwp83Wvu4/69eP
         LzkerM/tjrf50ys3z5rmKBiFDuzBvfO7vg1i6NceAQ1KvleaMLZKX8BzYTdiDeQ/AiBm
         XOxHJ70A7Rw0vxx2byYxnnmw2U2cN923EjHbMn0ZsX5UjzRHRVNrOjRhgjUH/F8ROzAI
         ynwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705531173; x=1706135973;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eLaX/VsA0yABQN8R4nb/2mlejC59XdV0vgZ4D9pH8tM=;
        b=BdDGkJAFAqyQ3oEEx+AT9nIoUypXvZRHp4ci81K4OhJ/LX8ww5zD5yxWPWZqvIf4yL
         GpEnGxjwojsYhu2OMsP+JbVkpTkEsDLvGBmmkUZMRkqBKRdmqMpTDBozW8DojYFRbnc6
         +dWE+7uk3Ur/h7i2NeaTts1k1mxufjiQ2cohvxGRC6O45zgncDg6ef+KSALGO723/oMN
         EdBv2PCEb+0zHb9zIrCCIMYfAx/ZewrKuw4yJqcYcBP3wh6vy02OcDIuIEb5vpKIYHyG
         FkSYooPMbp85yY/qtnFoHz00S7lPEB3Qr0nOG9xl0/e9q0ukHejk3fa8nYlUOu/L7yBm
         ZKXQ==
X-Gm-Message-State: AOJu0YyH+rwESCzN9lY8IgrZTy6IctUUqCtw/NA4twOpWEiEcZWOs7nM
	wtmf4LRQWfKtwmA0OTLPpO+u3+tkHaFFOnW6uJC5Skd5
X-Google-Smtp-Source: AGHT+IHsZ/7oxdx8GaRkhurYhhtKgQfgyIX8pfvjQeNWc76oHlC+X+I8+rm1se2KT8OndYlqqJlgd/y/2fXPbmiP4g==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:9c18:2400:c024:5c4e])
 (user=lokeshgidra job=sendgmr) by 2002:a25:5f4c:0:b0:dc2:5237:81c5 with SMTP
 id h12-20020a255f4c000000b00dc2523781c5mr231325ybm.10.1705531173178; Wed, 17
 Jan 2024 14:39:33 -0800 (PST)
Date: Wed, 17 Jan 2024 14:39:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240117223922.1445327-1-lokeshgidra@google.com>
Subject: [PATCH] userfaultfd: fix return error if mmap_changing is non-zero in
 MOVE ioctl
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com
Content-Type: text/plain; charset="UTF-8"

To be consistent with other uffd ioctl's returning EAGAIN when
mmap_changing is detected, we should change UFFDIO_MOVE to do the same.

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 fs/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 959551ff9a95..05c8e8a05427 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2047,7 +2047,7 @@ static int userfaultfd_move(struct userfaultfd_ctx *ctx,
 			ret = move_pages(ctx, mm, uffdio_move.dst, uffdio_move.src,
 					 uffdio_move.len, uffdio_move.mode);
 		else
-			ret = -EINVAL;
+			ret = -EAGAIN;
 
 		mmap_read_unlock(mm);
 		mmput(mm);
-- 
2.43.0.429.g432eaa2c6b-goog


