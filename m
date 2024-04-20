Return-Path: <linux-kernel+bounces-152155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEAB8AB9F5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 08:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9EC1C20963
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 06:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B09205E26;
	Sat, 20 Apr 2024 06:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT4LVqY3"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C18D530
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713593366; cv=none; b=SnDysIw6A+0ZU1wWxwKIMYsffwCdzuRQmbVps7irPmLUPeP/YztkylP5gUCEuBqH/ND3nY0WS5k/D7QEHRUfnqGjmTFLJX6U9TFmausuSTBYkotMfjywKlJ5xphBhEJvhlV4JnxP6gF3zrdu0s8mBBmTuVYfEI6u5zWS0HCqVZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713593366; c=relaxed/simple;
	bh=tWjsshuqL/FSN2Xo9GvQlgkjq/UO1lzCxdW/bJ5IO7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qt7WDTME2mrHUkW7jgmIp4i6dTYKdfjPJMjWw0yj7DFf/rkZ3K792nbwH/9H4R/xJ39FYTAfjUiVf76UKX8BNfC4S9bP9ZH7BJ1YSlC8gTiNWeq4YRPH6wHflP1x4ggBJce2sl4OCalG9lKt+Ly6M8o2JxylEy5uGo72XCE+gXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XT4LVqY3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e3c9300c65so25906185ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 23:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713593363; x=1714198163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nE5w7D/lU8OIxsycPHIsLjk5ZbbABF6HdCzwL7rsxw=;
        b=XT4LVqY3Koza5oGkyZluALH/3v5a6twM8EcX9bxAA3j7rP4Xh452p4TgztUrTnrz8o
         FUO1m34iMWQb5CfXFpGm0pnOCmyIQrS1nFozQn0rRYlU5w4wACE8bEBt7Q1cmLktVyhU
         UyYdoXwdyc230rTbzZCikXBPvI0oapjLl3TTX6U0kjbMHc3RqYcVQzWeDryf03y4vov8
         t1F/9gvlzZfz5tnTaSe5oC3zsQvvhWM/IesCL4Arg5+9HUh6O+1a8dpOLTk0sZG8lMTR
         SsWpdIy0S0Qfvm6I0rDDbRd5D2EhthnArgjVBNNWXIzksGbVtXT4nftLG/YUco6Yqn4U
         u5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713593363; x=1714198163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nE5w7D/lU8OIxsycPHIsLjk5ZbbABF6HdCzwL7rsxw=;
        b=O9qmnH8aFSgcnJAaiI4tfCYBaEhmeosj3ATHDwSMM3RlJdDpUwbWZCUOJy5d61uX8S
         6KuwlTHuAAZ0i57Fl6SkcCR5QCeZS8UkyTiYDrOvYYPuvAeszrdHSSRHLEbS69uwwZAk
         wTPZ4urBRAIF16+P/1p2LKZNfG7oOcUK6SxgZJDCsV2zjsxt22jAXYpSGXC+rrBTY1jn
         5lJ/PMaSCDJle24O0DWGnwdbidKjllsIt39GIgVjgYiNYLXOG8naOEIClYgQYgaLXcMR
         3iZCCbr4nQrduQ5xBEGQcdm6nblFjsAkyCsyITkJWyrtDWmPXmJ87bUb2eIhgd7XqUWD
         kvvA==
X-Gm-Message-State: AOJu0Yx2iM5iUU766QosMG3SfAwHJyn7Sp9O66bCHI4fWlyAb8vP2qR+
	nU8hqGOXcfRQLNeV88FF5c4jw03pp5zxZKEQFxjUpBhdQ/Ymcrtx
X-Google-Smtp-Source: AGHT+IH2kES2MIuVxLmHkK2KjZRhIrvTRwA7FdcFaawkyzaCEongK2jb+IE4XuBWUbx8t1++dkrFSg==
X-Received: by 2002:a17:903:32cf:b0:1e4:45b8:7b6 with SMTP id i15-20020a17090332cf00b001e445b807b6mr5014103plr.48.1713593363212;
        Fri, 19 Apr 2024 23:09:23 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902dad200b001e0937a77e8sm4332106plx.200.2024.04.19.23.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 23:09:22 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+8e03da5d64bc85098811@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hams?] possible deadlock in serial8250_console_write
Date: Sat, 20 Apr 2024 15:09:19 +0900
Message-Id: <20240420060919.62280-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000005e18f00615207de6@google.com>
References: <0000000000005e18f00615207de6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test deadlock in serial8250_console_write

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/net/ppp/ppp_async.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index c33c3db3cc08..d12b8155e839 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -134,11 +134,11 @@ static struct asyncppp *ap_get(struct tty_struct *tty)
 {
 	struct asyncppp *ap;
 
-	read_lock(&disc_data_lock);
+	read_lock_irq(&disc_data_lock);
 	ap = tty->disc_data;
 	if (ap != NULL)
 		refcount_inc(&ap->refcnt);
-	read_unlock(&disc_data_lock);
+	read_unlock_irq(&disc_data_lock);
 	return ap;
 }
 
-- 
2.34.1

