Return-Path: <linux-kernel+bounces-150573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571298AA116
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF006B20C93
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC87176FD3;
	Thu, 18 Apr 2024 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxDOm3sz"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB07174EF1;
	Thu, 18 Apr 2024 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713461459; cv=none; b=tTF4asgCP+33MMCvy+ZPPraJtRHRApeZClK2O40hYtdxKrRoJRv0mUT+Z7L6OeqTTC+LxMU0dsrCqADDb1uf2pRAB1KDBvKhg3AirrIes6GCWYs73omulGnh9h8TVk9TbNXzq0dsEDW7ZmXa3YnGaa0V0x3ffpxNaK4sVHiC6DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713461459; c=relaxed/simple;
	bh=+lewmFERRt+YPRyf4LGmEgUD5Sx3IL/S5o3dHvzf/S0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KRckot9is/C3H8/KwUWsNj7Yh9AyjO1t+yDBo0lUFRIuFjgSpyKxcZosIEmWdaZR1lhggJK/YxX1x00sJEKxgBtuio+l+BekKTlINHDx6xyRpcRzo7MjZuDT+cMaCwZpE+o+n2oTOgOKnpWrKLM0nb6KIkHxfwlkeLwcCCDkl5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxDOm3sz; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso755131a12.0;
        Thu, 18 Apr 2024 10:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713461458; x=1714066258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sic30g8pQM0MgGpABfp+RQkYvfgOJnSukraCHCD0dbo=;
        b=BxDOm3sz2Rup3CVK5RI5CqBrD8AD5aiVPnWpJ4YvHIJ73u4FzuQSo0Yegb8m2Tu5f7
         VlljKpPNHeBs78c1uztKMtwvk4sN2R+06mKYJEwlUqoNUX58jQg6c5IQDvUVbfmgvOVU
         bicfdUSEMXJ9KFjbhBbHvTFCnJlAehyqS14wWnLqI1fnZydEFimFXjg+B0JJMGcwTKhB
         8RUREh/c41qDcU4oeNjibcD0TDqY0ShFqO+VGMLATbBPMe7cu3nH4TEinSLhmLv9JSYn
         0dJf1lN6IJk9bFNCPURyeAS8y2sJvWuSY056WKrHxdycMZPlZUebDcku5c4o4CuAOMmB
         0JhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713461458; x=1714066258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sic30g8pQM0MgGpABfp+RQkYvfgOJnSukraCHCD0dbo=;
        b=T3bxQ+XS1SwMgkJjdadQjNUhd9OKFXu0q1W3hRplIS072AIRPaZSaVCpdb40CNZwV6
         wqnASWBCB1WGe2Y3tLEp7WmJ8NAcZOsAbf92wM7CJyEeaADLdCgjhgsimsvcl0s2yO0u
         AeJWraL06g0CxLV0XePP/GUXGNBxEGaJxYG5t5Iz5P/+5V6dsw0ujP71pNHaBiBjPTSR
         aEQ/D3nbG2HNhXexepTm7GQwDHn4W6FbsHddCOr5BwXQb2vXE41re8czNs/M6F7d+Gtp
         cXwahsvIYezZ34+xQnSW+8gpAZIpl2GfiDtLsJa4xMzIrS2n7J2hpXZftJRFJaISZH+f
         xByg==
X-Forwarded-Encrypted: i=1; AJvYcCXEPWjNKP+pI8DARXvd7a3WIm00cN1xI+v0k/Y+hoMKqq0yrrWuOOFZmgBsEDrXV56ySBblMoR+j5HnyQ2q+ELPKKYX8cH4qYeIT8txO8QtCjCVUgKFRRvq/VMreqDeJ0X0mJkNxatkTxR0ICVZmyeWAYCPBSaOmLTsDcCW/0IAog==
X-Gm-Message-State: AOJu0YyPIk7MlQurwgfknM4Hzv7ew7wPwIlWPBlhgxI5okoXOAqiK+la
	CcgGm26InZuXZouJ4+jSaKSkTRlHK9MtcNTTZh32aytmqnFupdsi
X-Google-Smtp-Source: AGHT+IGdiQPfFfe2JKLEjmGLZmK/OGwloZWthLXdWhEOZPU0dgtw2G/27Zx3J3bYnzb6rRqPwR/fVw==
X-Received: by 2002:a05:6a20:dd88:b0:1a3:6a19:9f5f with SMTP id kw8-20020a056a20dd8800b001a36a199f5fmr3849016pzb.26.1713461457564;
        Thu, 18 Apr 2024 10:30:57 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id o13-20020a056a001b4d00b006e6c733bde9sm1732556pfv.155.2024.04.18.10.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 10:30:57 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: ajk@comnets.uni-bremen.de
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+8e03da5d64bc85098811@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] hams: Fix deadlock caused by unsafe-irq lock in sp_get()
Date: Fri, 19 Apr 2024 02:30:37 +0900
Message-Id: <20240418173037.6714-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


read_lock() present in sp_get() is interrupt-vulnerable, so the function needs to be modified.


Reported-by: syzbot+8e03da5d64bc85098811@syzkaller.appspotmail.com
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/net/hamradio/6pack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 6ed38a3cdd73..f882682ff0c8 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -372,12 +372,13 @@ static DEFINE_RWLOCK(disc_data_lock);
 static struct sixpack *sp_get(struct tty_struct *tty)
 {
 	struct sixpack *sp;
+	unsigned long flags;
 
-	read_lock(&disc_data_lock);
+	flags = read_lock_irqsave(&disc_data_lock);
 	sp = tty->disc_data;
 	if (sp)
 		refcount_inc(&sp->refcnt);
-	read_unlock(&disc_data_lock);
+	read_unlock_irqrestore(&disc_data_lock, flags);
 
 	return sp;
 }
-- 
2.34.1

