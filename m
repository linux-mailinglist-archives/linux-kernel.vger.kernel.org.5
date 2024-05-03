Return-Path: <linux-kernel+bounces-167334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 243B38BA80C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3438BB216E8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CF3147C7F;
	Fri,  3 May 2024 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoeVTlqx"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA37146A63;
	Fri,  3 May 2024 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714722562; cv=none; b=kXZBrMCYA8XL/7C8EpGCnUddlekVwsZ8hCw/EVlAAwodzAkfwJYNiDFSWc+t92WzBCjuToTdlAtvs1FAxZQ1WZZSSRk6vX9WmFC7yyN++byiZRzeWZ2nB4b7sqZc89oqyGqwtrNBtSLoAo1kiAhICujaH4kEm2cN29A10Qcnh1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714722562; c=relaxed/simple;
	bh=4QF8U70AN9B9tTKvuL5gDNX37P8EgEKiUun+MstwZHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZKwS+WzKXeGgYbJK1x8/8soYan04Z6br9RQd5Zv9fRlF+L5XY+AdI5+QxmzryCrtPzgsiZBNt1iu222gblv9QwR6NwkW5N5S0HSak7NBriB+WBjeGrEWAOGClZS/ZzG0n0dX1SP947hZijVzvi88x/vjtJr/kr0YV5e+leepRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoeVTlqx; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso6299671a12.2;
        Fri, 03 May 2024 00:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714722560; x=1715327360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kApy9Rzo6wQrZI2czzyA0vwJXbNC/JWyyMd3bdTRDF8=;
        b=MoeVTlqxpTOd1t2BtEiLraVmeSid7QbGLI+f7TX4n2TZNO1xJPnTAhrppc7HXU26xr
         XB5s4BjkcUUA6ZmCrISfYSyK/VdHBMQJI8sI/LYtjDyOP8ofMqHyeUEqtpGUcSo5LAfp
         Oa05CVB+7HlReY3PbOY4vupO8i4yXnOnz3KapJiPiMfhp+jvn+RFBDgPYsCq3K0ewYOW
         GQ4ANJXn0vJka/dEluF/k7i8L1jZCO9QeGNFSi1u8ouQoR7WMSyIq7UhpDkI5oF/A9vr
         1gcb0u36jTFaY6Y7Dw6QEjLZZmQgQPsztZSumW6K4Y0ZmsFkjhMzrFIAQSJIJSmkv79N
         DPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714722560; x=1715327360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kApy9Rzo6wQrZI2czzyA0vwJXbNC/JWyyMd3bdTRDF8=;
        b=ppr8pOjRvkMIEPnQIhxXMl3nUnE0lFMMHwamm5wTpBBl8ig69gvOVPFobl34dB1BCn
         2RJ2AE7685s6Bt+e8ueB+BzJfaGJE0ys9ABrGWy50sT8i9y4PvHyCxDO2TosCTH2/vmf
         AhFuedMKo24RrCFkmUO8rmtJtGtrj5zXvVhTxIkcNNA8VLufFb3lGAYDu6ALMplemgs5
         Moc050/y+OYUXJ8nix/BKOQiRLTb8I6jdw+pk7YsYF3yJj/lRAAZTPytcKbty+XD/QTL
         acVt0qIt6OrRzU4/XZe9p3ZdPu3PUVliiG0K14VOzkPvmFw5oHEka7Uc4Muu6sMz7Aj2
         XXKg==
X-Forwarded-Encrypted: i=1; AJvYcCX+eQLAZlRMqAsx3QB4IOq6Rs0YIu+gIAehZovHr7LJFunqlxjq2v7KGeq6W9m5Zft5sFp0WaoPTW6MR1MOeXO7bnI5J8W/MPJE4ADT
X-Gm-Message-State: AOJu0Yypot9/uXjkY1jOmk2TxkC5OnTPCU9WviPfQVEKpZcbibIulpmo
	UXUrCyS2EABT2TqBCeDzrHlM1hqULuW0ZWtiQ8o5rK4EcW5/vvuGIoLuR8Hh
X-Google-Smtp-Source: AGHT+IGtp3Ug6ioWBn98+IKRWbb60loiywGfib6DuJbYFoD3t72QiSlJGqtgbNz8Ssx/fMzxzewuUA==
X-Received: by 2002:a05:6a20:a122:b0:1af:6a37:3cfd with SMTP id q34-20020a056a20a12200b001af6a373cfdmr2430354pzk.24.1714722559798;
        Fri, 03 May 2024 00:49:19 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.200])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090322ce00b001e3d2314f3csm2609836plg.141.2024.05.03.00.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 00:49:19 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-block@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Xu Panda <xu.panda@zte.com.cn>,
	Justin Stitt <justinstitt@google.com>,
	Yang Yang <yang.yang29@zte.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: fix buf size for strscpy()
Date: Fri,  3 May 2024 15:48:37 +0800
Message-ID: <20240503074845.12181-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strscpy() takes the total size of destination buffer as the argument,
including the space for the terminating null character.

The actual length of the buffer should be len(str) + 1, which can be
seen from the indexes where null characters are written in the code
before the commit in question, and 'sizeof(buf) - 1' right above
the problematic codes.

Without the additional 1 size and the absence of checkes against -E2BIG,
strscpy() will angrily eat the last character of the source string. In
my situation, strscpy() will take away one character before the comma
"," (which is presumably the right bracket ")") in parse_parts(), making
parse_subpart() unable to 'strchr(++partdef, ')')' and producing the
following error message:

  cmdline partition format is invalid.

Fixes: 146afeb235cc ("block: use strscpy() to instead of strncpy()")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 block/partitions/cmdline.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
index c03bc105e575..6d8401ce2943 100644
--- a/block/partitions/cmdline.c
+++ b/block/partitions/cmdline.c
@@ -81,7 +81,7 @@ static int parse_subpart(struct cmdline_subpart **subpart, char *partdef)
 
 		length = min_t(int, next - partdef,
 			       sizeof(new_subpart->name) - 1);
-		strscpy(new_subpart->name, partdef, length);
+		strscpy(new_subpart->name, partdef, length + 1);
 
 		partdef = ++next;
 	} else
@@ -139,7 +139,7 @@ static int parse_parts(struct cmdline_parts **parts, const char *bdevdef)
 	}
 
 	length = min_t(int, next - bdevdef, sizeof(newparts->name) - 1);
-	strscpy(newparts->name, bdevdef, length);
+	strscpy(newparts->name, bdevdef, length + 1);
 	newparts->nr_subparts = 0;
 
 	next_subpart = &newparts->subpart;
@@ -151,7 +151,7 @@ static int parse_parts(struct cmdline_parts **parts, const char *bdevdef)
 		length = (!next) ? (sizeof(buf) - 1) :
 			min_t(int, next - bdevdef, sizeof(buf) - 1);
 
-		strscpy(buf, bdevdef, length);
+		strscpy(buf, bdevdef, length + 1);
 
 		ret = parse_subpart(next_subpart, buf);
 		if (ret)
@@ -264,7 +264,7 @@ static int add_part(int slot, struct cmdline_subpart *subpart,
 
 	label_min = min_t(int, sizeof(info->volname) - 1,
 			  sizeof(subpart->name));
-	strscpy(info->volname, subpart->name, label_min);
+	strscpy(info->volname, subpart->name, label_min + 1);
 
 	snprintf(tmp, sizeof(tmp), "(%s)", info->volname);
 	strlcat(state->pp_buf, tmp, PAGE_SIZE);
-- 
2.43.0


