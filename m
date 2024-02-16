Return-Path: <linux-kernel+bounces-68685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 478B1857E64
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE391F28185
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43EE12AAED;
	Fri, 16 Feb 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDfHSmzo"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02FA12B161;
	Fri, 16 Feb 2024 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092098; cv=none; b=NJkNoDM9M025Zn/j2gM3UXmF3nln2SWR2ZEREkg8Qg8WJxZNRiFcHVssf6pTg+dkh9WqOXWatWjuw4MizAvAxcPeLldo1Y/K3oeUsw/J/7o3YFalRiZu5gQcJblGVshyafXWCd8M4tQcLYEpSmQDtpZI+WyIhxYcye4hinCywFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092098; c=relaxed/simple;
	bh=d8pToZA1jpUwW5HzAAHzbXqghxDmyWgMr2MFwaonsxw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qiZzIAImyhdj5tDUsA4FuwNXllzZu4OTaE7Vnr/COTsz1V5Cm5KJlaHp7jaAmPmcmnXjXDMyH/GrbYRhbVfK76zTX6M6TcwbQ0EWW9syRyOER3D5jBGeaS8jGIkTEpAT6aG30x5oEky9Zl4pqhqux20qiLpJXgI5zFwDbYsgOj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDfHSmzo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso5088095e9.0;
        Fri, 16 Feb 2024 06:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708092094; x=1708696894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A2/YFfgwfHYSxwxWTvNkKbHonwdcruw/j5bwCG3hZOs=;
        b=dDfHSmzoLvakPylaSoZYQ4jcNeABUHAwknTd9BCYfyLi6IqFRQnuaTXoJMsRDjFB+V
         Udg5Wbqk2Rzvmv2UaIg62UqRv/UQqZ33J5ps4JN744J5zjzZn1jKrwxboi4AHjcP25GS
         lWGsWdX+OgJyTzZvka1FJ8dqrIYr3WZhK22qEIqszTI3Ju5oFDwYUffwnZEwAvJrDrvk
         O16f1mLYhfiYflZ7bJyvyxUKRI95e4LoNwrbNq16tt2r3con1tVueOl0u8aGh/eOexHn
         oSzVOThyvqp3ChddpCJott9WDf9ylgcbWprivPxhQty/EWizHrUW+HqWMZi9kjz4Dgwq
         ZjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092094; x=1708696894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2/YFfgwfHYSxwxWTvNkKbHonwdcruw/j5bwCG3hZOs=;
        b=X8L50ScJOHfrkGBlKnGWC9tAe2a8c+16FPVkf8xB6uCrlXGvHBhZinkm02he4SFNwa
         mDN1EYW6zNepTHb4T7khDo6yKOy7T1BjiPgp8zSkPd4eeTd94HxDTvNqdXz8Ppdhv3OW
         FfyvfiQEUtoRuSg0kXUpZww7gfbqR+yK11TWEywXW6c9YgI7sDyf6b4iRI0oBS7yY5JG
         l2uTnfmVfUvehu0NztkHwZAeNVLmLq9bSfRrQm029BHt3j0FcvstdLRyuCwMd4UBQAJw
         2j60rhPBGrYt3Es99cbvefsoY5PAe1x9trsLGsiv6bfUk9LBCNUFb8abNIKIlj58CGZU
         PKmA==
X-Forwarded-Encrypted: i=1; AJvYcCXIkmfvDdXDmakJT1xaDFqGJd7naohkJ4gcEEMr8AFk/O9hbdEYJ4308CbnzAR0cuI9XrcXp64CjXa1ZaoG5tvnI3S9vOx5t0zUCq7KPwdMcGlJNtrfEppjBSsJ2AsZZd8JGZ8BDuun
X-Gm-Message-State: AOJu0YxVtnCg+69AsM8hohBQ+l2p177r9pA1u5w5cnLmDXBfv6R3BCqB
	2dvdSUt9tx4545qCT2fvpN6vuw61q4WjoNuijGJ67qxoj5I/pQiFa6FM+ZJoN9M=
X-Google-Smtp-Source: AGHT+IFnQbiJ3YyfMzriFViiWy6mCaGYupN8LYi/oUxibxzSy511u45FH/UfALiDqBEU/rMk1AmHVw==
X-Received: by 2002:a05:600c:602a:b0:412:19cc:ef65 with SMTP id az42-20020a05600c602a00b0041219ccef65mr3638398wmb.29.1708092093860;
        Fri, 16 Feb 2024 06:01:33 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id u19-20020a7bc053000000b00411e75eb83fsm2364914wmc.18.2024.02.16.06.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 06:01:33 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] clk: cdce925: Remove redundant assignment to variable 'rate'
Date: Fri, 16 Feb 2024 14:01:32 +0000
Message-Id: <20240216140132.2108665-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable 'rate' being assigned a value that is never read, the
assignment is redundant and can be removed.

Cleans up clang scan build warning:
drivers/clk/clk-cdce925.c:104:3: warning: Value stored to 'rate' is
never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/clk/clk-cdce925.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/clk-cdce925.c b/drivers/clk/clk-cdce925.c
index b0122093c6ff..e48be7a6c0e2 100644
--- a/drivers/clk/clk-cdce925.c
+++ b/drivers/clk/clk-cdce925.c
@@ -101,7 +101,6 @@ static void cdce925_pll_find_rate(unsigned long rate,
 
 	if (rate <= parent_rate) {
 		/* Can always deliver parent_rate in bypass mode */
-		rate = parent_rate;
 		*n = 0;
 		*m = 0;
 	} else {
-- 
2.39.2


