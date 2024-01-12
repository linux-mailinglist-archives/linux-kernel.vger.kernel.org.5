Return-Path: <linux-kernel+bounces-24214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5D282B930
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F92728A738
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D4D10F1;
	Fri, 12 Jan 2024 01:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dMZsS4fI"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA91EC5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e7ac088580so105811297b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 17:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705023579; x=1705628379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qjkb+fNJWR6xhFFz1SHKSBqJRogg6FXIJfRr2JQH98A=;
        b=dMZsS4fIa72aynn00oBeZ51LNlIImr0aHMtGFTr8zC4M3H2mAjDJWbvaEKnI8Yp5tN
         +/On4+hka1qcPBUQ/pXpA7nUwHFcKW88C/MpfDhp5ANTOua5MEO7DSPHiWuSOa6ZREDR
         NVBDAU1dmGfUHAXtuLcMXFLs02xRQbklDBXpv47+yjHHcKHw4+hU41eiIjJXKY+VvW+3
         4W0M1vjf3KrAMcqfho09P8UgBXUleICgod43bNAT5Evzx36AIblu0NFRQk8NuphN44/W
         XtRq44s6aWFRx3cQnvxp53nbgYLX54hAfG+tE5rvAcKD8oFETeY0DQGlewKJyIpb+tgu
         gy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705023579; x=1705628379;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qjkb+fNJWR6xhFFz1SHKSBqJRogg6FXIJfRr2JQH98A=;
        b=ha63q1SeaF1UqOjF/UbQAt3Tb4u7pR1FWWkqqmCUfCuf/Jdko41rM0HTizaGM48nqQ
         KwTVGchqGG/zpmcELwpa93L4dc4n2p3AIgLo6IPXhwYT4zOQmsxlXIsBeh2nLp2bVRr4
         3UH3wUxaiBbC0hASXPti0TY11BqgKbufeLYnA/ebMjsRsnB3lAFke0X/gfYgtP9nGAOL
         x+DVg0sg08oOaIwyeC9IAwyiZMhdNhKd1wTZKnUMS01VClHkz7TDWmH81Uj2dJq9nf5a
         Qx2TSsx8WlLmSrnjsWayyhpP+d2JJPf0JNd510qCs8yUS7ObJqD2uquL0ICpwqZa6mjW
         7A7w==
X-Gm-Message-State: AOJu0Ywu7Z1jfHJLFnugPvNfyxSBierLIYwzkqb0Swztyz+e9O6gyTUc
	b9RSvjcWZMPZ+aH7QctXPjYD5mvSB4DRdP7RRA==
X-Google-Smtp-Source: AGHT+IGzJzjHd+iigkHZAN1EU611VoZCrWCQGShoybdldgtRabz4JD0KU6CFkn8b9WwpgLdsvL/6X/kfzfQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:ab5b:bf4d:6e91:c0b3])
 (user=surenb job=sendgmr) by 2002:a0d:f983:0:b0:5fa:4896:7114 with SMTP id
 j125-20020a0df983000000b005fa48967114mr361857ywf.5.1705023579073; Thu, 11 Jan
 2024 17:39:39 -0800 (PST)
Date: Thu, 11 Jan 2024 17:39:35 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240112013935.1474648-1-surenb@google.com>
Subject: [PATCH 1/1] userfaultfd: avoid huge_zero_page in UFFDIO_MOVE
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: sfr@canb.auug.org.au, david@redhat.com, peterx@redhat.com, 
	aarcange@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Suren Baghdasaryan <surenb@google.com>, syzbot+705209281e36404998f6@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

While testing UFFDIO_MOVE ioctl, syzbot triggered VM_BUG_ON_PAGE caused
by a call to PageAnonExclusive() with a huge_zero_page as a parameter.
UFFDIO_MOVE does not yet handle zeropages and returns EBUSY when one is
encountered. Add an early huge_zero_page check in the PMD move path
to avoid this situation.

Reported-by: syzbot+705209281e36404998f6@syzkaller.appspotmail.com
Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Applies cleanly over linux-next, mm-stable and mm-unstable branches

 mm/userfaultfd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 216ab4c8621f..20e3b0d9cf7e 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1393,6 +1393,12 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
 				err = -ENOENT;
 				break;
 			}
+			/* Avoid moving zeropages for now */
+			if (is_huge_zero_pmd(*src_pmd)) {
+				spin_unlock(ptl);
+				err = -EBUSY;
+				break;
+			}
 
 			/* Check if we can move the pmd without splitting it. */
 			if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
-- 
2.43.0.275.g3460e3d667-goog


