Return-Path: <linux-kernel+bounces-152651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2201D8AC203
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 01:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C1C1C2084D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 23:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CAE4500C;
	Sun, 21 Apr 2024 23:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="lDCQsaSe"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35CC1DDE9
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 23:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713741523; cv=none; b=PqBwSWVZ7SsCbud3x8+iiBOe86hAX6GfZ5R2RliQ+aFNoI6vJsDq6G3TL79fnJlisHsK+Euc/0exNIgUA69AkB//6uZU3qahJ37Y/Mywz7j/FETYlPoLWAgqO3gcuTGTcFY871cEllfUJnF/cS2Me6rn2OKr9xTlQ8m+H64m1uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713741523; c=relaxed/simple;
	bh=CTyarZ1awuxFYwd99GIUJv3pxap0WzEGyctYTHZyS+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJc5IOAyvcS2Z7ulX5oGTW1O5fmQoTYQU6z+OxNfZ8X+RXxiZkG7my9aFGCeJu8hq7Z3uAZ8ZA8Bm3uckZqfphLF6Ff5euqbxcYxyn9VfCk9bKDS0lt/ArB8JmesbxqSNxOxyEitF/Cvd73S/IFw+ghAgIB68wEwmAlXhkvtoaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=lDCQsaSe; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-343c891bca5so2933835f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 16:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1713741520; x=1714346320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWBuK7qeNlFWu7rmYrrR+LglSXjPogokNYMEE0Z/71E=;
        b=lDCQsaSePfGgcNx03ffWdQJIBp36GYk8EF+iJvx3W3T0NZs1A5pAQ5HqnYsNBFHMW7
         CQ3SlFROT+ehJGjU38eri2IJAJN61LxGMEl1uqZl7NkryGgcSd9R8Q6n+2G4qyRPWlWV
         I9MXB0st6McZGOGAOn/rzRioe29MLXHPEKFmW+eUSUQRqYzQei/dGd2LjsoVLkvD151R
         nmnAN3FmRQn5ZQv8y7bpWf4URd/84/isjcGVji/1Z9AGzBVimhmR6H4vroJQZ95z5etV
         MwDRV/lxFWVxehNT5Y2CSVKVmbvJpa3nlmdM1E/OcsTiXZ00p5smGZ356BJdpUgYEKa1
         Niag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713741520; x=1714346320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWBuK7qeNlFWu7rmYrrR+LglSXjPogokNYMEE0Z/71E=;
        b=FqTV+fHMr8nnu2lPL2WUwFt3R7giQSpCeKSB15D/Pm7beFPRLvkVDpRYIr7EGMKcOy
         p6oUuzNh8cfZ4NV6z7xOZ1dC5sBR+HIDCeTUjpxqAwSyKJYaMrak7eZrJ1ugQ6hsP4kn
         3e87IJTcpksO8fa0dhPaymsdy+V/28Iv2kXaVA5DlESPdFkQKI1zwITMx81nBmBVZrQg
         oRD0nkZ2cJe98FO5aZXA0nUovNPatBQHxXv61miK+ybzVeFscMJWjDUdoqg3fC3qf7Cl
         ZmShFtlrIwTzFAc2O69THwjgO3d1ptcmpZQ+61kPImttsN3d9uTWI5qCWplBUViA0AiF
         XJAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO3ASM4jo8oyIb+M5sZzFqnleEeChr3s4Itqwkdo+fFdX/BYQiJER1NL8YK426CCUDqO1D8CUrAuVz1Hoyt0j5sKv3k3cakBZzgIi0
X-Gm-Message-State: AOJu0YzRGInv8iv1ajyUhHf0aCYlYZGznNWHMUUprvRHBXIC/iFUPIRe
	EFfqEorjAoGRZmQIwz6gpUed+ChIPB3bUKNZNpiO6s01b4mKedKEdx2PdPVX+Zc=
X-Google-Smtp-Source: AGHT+IFWSmfJ72X7g8dU7M8HNn9yWBaIOFg2hetvc42ZItdCPLols4PP5UoNx738YHLnSSovVIi/Gw==
X-Received: by 2002:adf:e3cb:0:b0:33e:7f51:c2f9 with SMTP id k11-20020adfe3cb000000b0033e7f51c2f9mr7621909wrm.49.1713741520066;
        Sun, 21 Apr 2024 16:18:40 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d43d2000000b0034a25339e47sm9549282wrr.69.2024.04.21.16.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 16:18:39 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: longman@redhat.com
Cc: boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	thorsten.blum@toblux.com,
	will@kernel.org
Subject: [RESEND PATCH] lockdep: Use str_plural() to fix Coccinelle warning
Date: Mon, 22 Apr 2024 01:17:56 +0200
Message-ID: <20240421231755.955755-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <9b15de60-b593-4b0c-bacc-ebe79de5d541@redhat.com>
References: <9b15de60-b593-4b0c-bacc-ebe79de5d541@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
string_choices.cocci:

	opportunity for str_plural(depth)

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Acked-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 151bd3de5936..31d7720c9b8d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -786,7 +786,7 @@ static void lockdep_print_held_locks(struct task_struct *p)
 		printk("no locks held by %s/%d.\n", p->comm, task_pid_nr(p));
 	else
 		printk("%d lock%s held by %s/%d:\n", depth,
-		       depth > 1 ? "s" : "", p->comm, task_pid_nr(p));
+		       str_plural(depth), p->comm, task_pid_nr(p));
 	/*
 	 * It's not reliable to print a task's held locks if it's not sleeping
 	 * and it's not the current task.
-- 
2.44.0


