Return-Path: <linux-kernel+bounces-143804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FC78A3DA4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3911F21A68
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E3E4F215;
	Sat, 13 Apr 2024 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1vZeonN"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90464D9F4
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713024941; cv=none; b=o4aZbthfCpNP8BVwwlig9uyAfH2ON9TaGdYYyZxV6B/z/vyGehzjfZCbIoUGnj9mBdRDUfZnI/Lrw07TIOg22/9ldiPqPbUd7JPZiFAbxX/uPY2UaCTbGAZ64615NBLrfhw146xj6nb2h6WHi/5tlRuq91MEUiU03BmdTelN1Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713024941; c=relaxed/simple;
	bh=uULgMz3JKuDpdOau9yZRUpNOUxNPe5WHGUMytORdTxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I6EjXTgJxUG/DGoB4Okpi7SWcqZRk/D5uMhQrO7MSgVtmsCs3u7qq9c/HtA97Jh9+JpHOPzwImpoqO6Gyh4nBCriciGMxm98ycf6uLwXGKjSAsZJVQFJyfCwwT33Onidi/ENJpMV9iOtbNdFcZL4UQ/vrD1jSmniK81YJmuiViE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1vZeonN; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ecf05fd12fso1769834b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 09:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713024939; x=1713629739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ww0eRWU1bZKxz08q8r2/bHR93XGflEa/z2w+7o6mm74=;
        b=f1vZeonNo4X9smP5pJjGLXaIY3a1LaQ8rBS2YSgPC7u9uoubDuduTwtNqADmsYVoME
         ElGeR0Jl55ROMT1Td4UxUwiZpTLc4Mp7osfMmBbd0/6r49OiAImcuob9wUiofOzEInPq
         jxFb8n8EfKgW8B60CopcpMO3UbKDKqQwAD5TKb8REbnB9scRaLXM1K/jU098VUaLPk2H
         57GkpYhIuXwOQQMBuWbkCl7Q4edhO7snAkoM0C8kQgcLyrT0+zfh76k+dvfadCqSwk47
         5SEaDO+kGhBTM58VTCkaspwCC9SlVGg4wU1UAT4xzCDbIN+XGnMZoh0H9ukuqCqiJmeg
         FeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713024939; x=1713629739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ww0eRWU1bZKxz08q8r2/bHR93XGflEa/z2w+7o6mm74=;
        b=QNBc3JpVrbYXv9SyLEei+oWnG9hJFCNVgJDSS4jlIKEm8czqVc359osMAWh0Pm1D06
         Idw5Obw5Yp9KkdDsnWQlaoOOxAvRqRXHhNoN6Oaf04py/VhSUG/PeGMgk3aaLPYB1yoE
         eKeGl8hAqBHFFICid4ImvMX2l+j5qZK6plT9mIOesqu0wMGHq/WQcL2tyxccHyD4ZHta
         CT1/lgOZAJdJR7zqaPxHb4pzeJfg0myP10kao30LVN6TDgxQr92AuGRFw8EbF0Xp6CM3
         KM388tR56t2SjmRAn3fBO8plajiB5PT3v/FX/28qngdDh4I78u6suCfmGa8DSZyvo4iC
         K8xw==
X-Forwarded-Encrypted: i=1; AJvYcCVrcy2N2RqqnH2uRyrWHzCfzn0FDHob6/VXuD6Twh/Hwxow5r6g6RBcocT+OyMByftYl+V2/Pxs7AhFtRysInrZ/9cBrQxiyW5y13Tn
X-Gm-Message-State: AOJu0YxqYF7wtYWjRUy/eSxfnx/1d3GOBhw9UevuiU68raGTUnHCjkIA
	HqdRJ1wKj50FjWIZm1nVE0zYomJbeDuFuQ9IQN7y0V0cImFDNX1wtgAVQYVP
X-Google-Smtp-Source: AGHT+IG3p/D//mMW+/rh6IM3cCgM4vwDigZqhwR6nkapQBxdDAcfZW3ch+Z9gNj5ULt0WKCoSVXyeQ==
X-Received: by 2002:a17:902:64d7:b0:1e5:d083:c5b3 with SMTP id y23-20020a17090264d700b001e5d083c5b3mr3580633pli.5.1713024939128;
        Sat, 13 Apr 2024 09:15:39 -0700 (PDT)
Received: from lima-default.. (1-175-176-70.dynamic-ip.hinet.net. [1.175.176.70])
        by smtp.gmail.com with ESMTPSA id im23-20020a170902bb1700b001e2936705b4sm4863943plb.243.2024.04.13.09.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 09:15:38 -0700 (PDT)
From: Chin-Chun Chen <chinchunchen2001@gmail.com>
To: yury.norov@gmail.com
Cc: linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org,
	Chin-Chun Chen <chinchunchen2001@gmail.com>
Subject: [PATCH v2] include/linux/bitops.h: Fix function fns
Date: Sun, 14 Apr 2024 00:15:27 +0800
Message-Id: <20240413161527.12030-1-chinchunchen2001@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240413061204.10382-1-chinchunchen2001@gmail.com>
References: <20240413061204.10382-1-chinchunchen2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modified the function fns to resolve a calculation error by reducing n first to correctly determine the n-th set bit instead of n+1.

This commit improves the accuracy and reliability of the code.
---
Changes since v1:
* Clarified the commit message.
* Fixed the incorrect operation.

Signed-off-by: Chin-Chun Chen <chinchunchen2001@gmail.com>
---
 include/linux/bitops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e067fe..5842d7d03f19 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -258,7 +258,7 @@ static inline unsigned long fns(unsigned long word, unsigned int n)
 
 	while (word) {
 		bit = __ffs(word);
-		if (n-- == 0)
+		if (--n == 0)
 			return bit;
 		__clear_bit(bit, &word);
 	}

base-commit: 8f2c057754b25075aa3da132cd4fd4478cdab854
-- 
2.40.1


