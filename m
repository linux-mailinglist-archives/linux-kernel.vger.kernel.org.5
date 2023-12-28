Return-Path: <linux-kernel+bounces-12822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3367281FA7A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 19:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E540A2840AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 18:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296E7101D3;
	Thu, 28 Dec 2023 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjPjXU5Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFD7101C2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d560818b8so36346765e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 10:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703786931; x=1704391731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FAtcntG8ypvRUDwxTiWN+z6lqK7JJWqkVBNemEwPM+4=;
        b=HjPjXU5Q0TQP7pxX/iQlK6ZUSO2GIPVhePwG9B9e5hJCMBnObJi9d8FIrNAQ0/S+lP
         O88We3xd4LPXkHNF9nA8WdsqtAHZDYU12PWnZxO2B9q5QvbY3MGeGFH7BLCHhI0thejN
         c6reMKxo1tt4cWQIbe5QjxoPApRLhjUz5gBJjL9s77rAm0Wvii3cZQRRZUvFgmLWCjdk
         /QMHmCRay6HKoY5Wlq2tWz4/VZszOuCGj0qpEQ4WNg7ZNi/i4i3cwf+ZT3qdEhhMr5GG
         NrAnDrBxitaxyIZ+NCWY95HQfduNiZ/W/F1QDEZSdTIN4LlojT8edH+lzh8SlPsMfwpf
         4low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703786931; x=1704391731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAtcntG8ypvRUDwxTiWN+z6lqK7JJWqkVBNemEwPM+4=;
        b=MBaYOU2ic6Fd1DOuUENG71VexdQQgI06jjaeEbaxAnTxO9U1Z157KvcSCOawv1smqI
         HsgypbKx8uNT88WwaKfejuzunTaWYygYFgDtzqlZhriQlFpryEDB2CRu1r06a4SG3DEO
         O+CV5w4LptP1Xl+AmxurqkPAubxOhPHcpVcWEg+it8UygobgLWQsEJYE++8/8GnAZ7yu
         vAQ47mzpMuzrSEHgTD57M6pOav0Skkodnjt1f4Lf9dT8zKzldYPD3I7ddX1ohEsvtb/T
         gJ7OgsbOlKkHD56s2S0FcRAUduPgAvMsNV7hqdDs4UeHjOQikskXSuHpU35y4MRO7ImR
         xqDA==
X-Gm-Message-State: AOJu0YxDn/7LHZsOh1vKhWP5UDuIhrymMWtPhX8UnDdbLGmYxI4nliGp
	4H0chLNoN2W5yF71a8VGl4wx30TYdgB1Ww==
X-Google-Smtp-Source: AGHT+IEKkp91zCCmGbASJKwtp6m7YPk3kallFC76X+kJjQwt6KEc5+Gw/V+8gcOg9x2E2NehOGgGJQ==
X-Received: by 2002:a05:600c:b50:b0:40d:5c7d:20f4 with SMTP id k16-20020a05600c0b5000b0040d5c7d20f4mr1750992wmr.31.1703786930790;
        Thu, 28 Dec 2023 10:08:50 -0800 (PST)
Received: from localhost.localdomain (bl17-216-113.dsl.telepac.pt. [188.82.216.113])
        by smtp.googlemail.com with ESMTPSA id hg12-20020a05600c538c00b0040c41846923sm35557891wmb.26.2023.12.28.10.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 10:08:50 -0800 (PST)
From: Malkoot Khan <engr.mkhan1990@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Malkoot Khan <engr.mkhan1990@gmail.com>
Subject: [PATCH] ipc/msg.c: Use C99 flexible array for mtext
Date: Thu, 28 Dec 2023 18:07:06 +0000
Message-Id: <20231228180706.110337-1-engr.mkhan1990@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the transition to C99 standards compliance, this patch replaces the
deprecated one-element array with a flexible array member. The C99 standard
introduces flexible array members for cases where the size of the array is
not known at compile time and can vary during runtime. The flexible array
'mtext[]' does not consume space in the structure itself; it's a marker for
the compiler to address variable length data directly following the struct
in memory. This approach is more aligned with modern C practices and
improves the maintainability of the kernel code.

Signed-off-by: Malkoot Khan <engr.mkhan1990@gmail.com>
---
 ipc/msg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index fd08b3cb36d7..ee6af4fe52bf 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -978,7 +978,7 @@ SYSCALL_DEFINE4(msgsnd, int, msqid, struct msgbuf __user *, msgp, size_t, msgsz,
 
 struct compat_msgbuf {
 	compat_long_t mtype;
-	char mtext[1];
+	char mtext[];
 };
 
 long compat_ksys_msgsnd(int msqid, compat_uptr_t msgp,
-- 
2.34.1


