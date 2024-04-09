Return-Path: <linux-kernel+bounces-137244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF6A89DF66
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898F4289E02
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D28137930;
	Tue,  9 Apr 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="ldJj2zY8"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E405C136E16
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676988; cv=none; b=Y2HXiM/pVA9XRL4KxG1M16IrxgqG5mLH0RBxP7II958jD2lH4gD8WILTyXBOAF7p0zQQ4dqWvKG+AfhJc7fI77jLNz8rvaloUBvmoQjWs1DuKcTPYLe1vr2hnHNl/HkHjynXGma3Up1OJtoKuK9aG/9wW8FBg7tRFflyCQHfTXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676988; c=relaxed/simple;
	bh=0quX4igVUBv0PjMU/FXlfx9DZgCOO6LJrjDtLL6paP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fvPwtr3Odh0aPaTRcPjOlnO7qaylelN61yKf8XmSbzkLc54dMStmhNLuV+Qqbo4ATa8h2WP64qS/lqPXql1LJ5Vvm93v2WrBDetBM1dHby05ZfXRww/gcJsPhN5c3pVk1Mnc90rxn71o/ToMeJ1fhZ91NCXbqKQbDJ+nOdnW1vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=ldJj2zY8; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e6f4ee104so1614420a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712676985; x=1713281785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oOph0FaIWn1WLk74ILFxXXN8KiIBmlIobvlKfK86XFk=;
        b=ldJj2zY8DuAuD989VdUOp+44AYSjj6WZCLsytjTumhz9I3rGGY9rCNDvcmKPqYTSa4
         zY4qZk2gJ4fB0GjDirSPfpMqwoqli7iFtdlB7jQNDzKzX5WFQ2wz7xKWKBTueSjZ2RM0
         J3DXOuu3D/tYuazQRj8ZXSlSC76QV0gu0ERKR2+9jtv/4KNKZuKOnZhIelZV9Vp3Xv8A
         YTUj60yL5zAeFruFJK5zjnIOBwOnNqv8Qf/ZmEMVgP7eTR+PEzBMbLqWXEPhodPBSOxa
         q71h9vj2fOYP8kfB8PcCmK0y47TkSz4c1ZWtxI1O3ukaSazdefn0w1upgR2hNycZQXvg
         Voug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676985; x=1713281785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOph0FaIWn1WLk74ILFxXXN8KiIBmlIobvlKfK86XFk=;
        b=Qzj6L4SBOFhvkNijchwdraOctfBqh50ZA08yWJdxl19SUYOBFEojmY207ViJGEe8Kn
         tDqtQc04YPJKeg2EE8NjFhxcmxxBK1ibMxwN6Qq+IhYBhdD2HMJ1n+5lwMu61Za+y+8x
         TjSCzPddBsv/XLta2LrvpF7bG7+yoVKYfaZsADGAaf4v1+spgjS0zLdwLbARNkH4V48G
         MMqXXBevqsTZ7KjE53FOnkyOCxyt9Wj5QcaY3dcp+1e08NM/NV/xbeM/0nusI7RfIUdK
         XD5jnHQgc6oCVKQej0xgVC2aQP/d+RMK7QvhSowM3fgOHVStsqwkdggKsEOe9QBVvQn7
         R32w==
X-Forwarded-Encrypted: i=1; AJvYcCUbN+qtY22kdTmVrjnXvjNqOh8YnRxVcmGzGVdjRxd5+V97nU3Nxktzn4Bbx48yzOfobORsK6hcXGhkLVzjJ9aWEOdyZ3KV4yCZnZlU
X-Gm-Message-State: AOJu0Yz5yipHhW00sG3w1yZ5z3lnCMAOSLgyp/n8U+uVc1S3rnYZ9YbK
	Ib2kBNqhcRR9IMs6X5/pgFfgqKHZHBbh8fYK1A6vSdKjmseHXbSHINLxzL5RfHF4bfE1tMHFyyg
	j
X-Google-Smtp-Source: AGHT+IEjc6dYjz2VkqbE4sv+esMTP2o8UAMrIoQVAD1/6yseAStzbyBLZZBf89n2JUrtgOdfCYDWNA==
X-Received: by 2002:a50:c348:0:b0:56d:c6e9:ca01 with SMTP id q8-20020a50c348000000b0056dc6e9ca01mr8509919edb.15.1712676985086;
        Tue, 09 Apr 2024 08:36:25 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id r8-20020aa7c148000000b0056e78e90a1dsm320344edp.49.2024.04.09.08.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:36:24 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: John Crispin <john@phrozen.org>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] MIPS: ralink: Use min() to fix Coccinelle warning
Date: Tue,  9 Apr 2024 17:35:20 +0200
Message-ID: <20240409153519.291205-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
minmax.cocci:

	WARNING opportunity for min()

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/mips/ralink/timer.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/mips/ralink/timer.c b/arch/mips/ralink/timer.c
index 54094f6e033e..d271ac98312a 100644
--- a/arch/mips/ralink/timer.c
+++ b/arch/mips/ralink/timer.c
@@ -75,11 +75,7 @@ static int rt_timer_request(struct rt_timer *rt)
 
 static int rt_timer_config(struct rt_timer *rt, unsigned long divisor)
 {
-	if (rt->timer_freq < divisor)
-		rt->timer_div = rt->timer_freq;
-	else
-		rt->timer_div = divisor;
-
+	rt->timer_div = min(rt->timer_freq, divisor);
 	rt_timer_w32(rt, TIMER_REG_TMR0LOAD, rt->timer_freq / rt->timer_div);
 
 	return 0;
-- 
2.44.0


