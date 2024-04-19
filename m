Return-Path: <linux-kernel+bounces-151876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD098AB521
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B66DB2200E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1847D416;
	Fri, 19 Apr 2024 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRkntIG+"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDE11E86C;
	Fri, 19 Apr 2024 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713551903; cv=none; b=MR0N8+8HPjkpovd42CEw/jyCoHjKdYaRhOCLTbRkILVvjVlk2aelSxhUss+zDJvphUY2ImeFivHjZcPD7AdUBF8EO8aq1YCg4aKkkRb0dlk7KRh0j+5bsmIW5yMkfXG4iKvTbh1oM5Pql98TmQzkFj7O0aeFzKTT8mJ+MLQvmW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713551903; c=relaxed/simple;
	bh=0794coGXwWMtAvlcUEIOVxQQsL80fpcv5KtBJGHQpuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lG9TRZw4grWBQoAbaGwtbUQbnPMydt1nSGDGRxso7tZ9mdHGmtDes0Z0mCvhe3DQ5Smd8UtlqHHx+yldna9nZ9bIuuj9O8CncOZmsEEiwJOIXjhkwALRr/wap1LC/NHO1t42xC/zPTZDPU/8kMryzMQIhV3/icRUuUeoIxS9ysU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRkntIG+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ecff9df447so2250334b3a.1;
        Fri, 19 Apr 2024 11:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713551901; x=1714156701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JuZSTZnNzCxhRSwnzEB/Lxgf0qm4GBVk8TZC9GmL7I=;
        b=GRkntIG+wRGggxFamoY/zWzdqRbhLYMS+2ev+e7U6oWNpK7wJ/lIcK9IhB5m/qnBoO
         wHkWZX+5QmUeVva6dmULZ+hRgzSfEyQspXx1TxAo5nMXtah8Hepfrff82IfTKs+94GFs
         21MPJCVLGfK/2iq/s1U+2A8HaCioQuYh7VYgBNYB63GAtRx6FO3HFd0MAzhipwrXH5eg
         NbWKxbFwV/Zrnk4ECfQQB5cg5uiQr703iWh4rpSYTA/A7Bc1tAd7EyOmBdoIkh6ATC6s
         9i7s6m6JZktyXQDXAV7D6kVLUWj+JBc2STGeSqVOkrRwFVfhC/C+wvR5kABDHyG5ouym
         sbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713551901; x=1714156701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JuZSTZnNzCxhRSwnzEB/Lxgf0qm4GBVk8TZC9GmL7I=;
        b=bC7Z70g7I+hFA3FPuBTnOhd2wR5l1oSMUvHLcEMD25NdCSgsOduQFNzH7AHMRaVeZH
         yRB7023uwt+dMthlB7pI29puqXYNc72imdW47U2ud94LUwuDpJDmBIbDHxxK44jSLPCM
         AbA3xkior3fTB29cLsEUYfdwKJ4w4KQfv34wuXMFU3qgwy/A0d8t8jrzJ3MGK01JyPhz
         F86zqoOPHmust7QM12R+s60bzkqYhL7vlu5RA9Bi+y3kYcIA/lNhcI1HepMHnn1LAyhF
         eYxj5GoXYj8njfs2r8GmWiRFMMUFsOWbDBc19NdHKAD3E8KVr/r5jn07QgiNfScyTjYC
         yG9A==
X-Forwarded-Encrypted: i=1; AJvYcCW41qBg8TK+HQugMXbY1EJLQLaKONRs4Nsk5Ny1ffEyWkBkE1N4/xor3qksjH9jdLepuQ4ICM7HxMzyjkTN9dYvu7uR8BrbbCgg7X9mS59ACYWy4WsDJvTTSF5Di+MHaLWdHoSaQP0CHGryTmfA/qdsDb9rgo8t2+YQkr0ShYiF
X-Gm-Message-State: AOJu0YzZnErIX9cpTdFJejtBSWpsOO2y9xQs24ggkHEVHt9ty7ShAr8/
	dI23LRSO3ndZ6MHJo2oSx5y/brTc2TxVTjVUDWQ8mNGAOvHsJ8otstpxZ2NZIIw=
X-Google-Smtp-Source: AGHT+IEnXpX6JCBQcHLnKTVVD6sHxQxVwIOm1zC6z5uIFUJ1vyQlFkPJZ/YthDb24nPLel9roEXBCA==
X-Received: by 2002:aa7:8885:0:b0:6ea:afcb:1b4a with SMTP id z5-20020aa78885000000b006eaafcb1b4amr3905514pfe.8.1713551901414;
        Fri, 19 Apr 2024 11:38:21 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id a15-20020aa780cf000000b006f0830a298dsm3549071pfn.156.2024.04.19.11.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:38:20 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+393d0ef63475d9bb1f16@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	syzkaller-bugs@googlegroups.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net,v3] net: ppp: Fix deadlock caused by unsafe-irq lock in ap_get()
Date: Sat, 20 Apr 2024 03:38:15 +0900
Message-Id: <20240419183815.30147-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000423dd10611261d47@google.com>
References: <000000000000423dd10611261d47@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


read_lock() present in ap_get() is interrupt-vulnerable, so the function needs to be modified.


Reported-by: syzbot+393d0ef63475d9bb1f16@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
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

