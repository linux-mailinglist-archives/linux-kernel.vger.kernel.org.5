Return-Path: <linux-kernel+bounces-132040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D17F1898F07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4781C22127
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A76134411;
	Thu,  4 Apr 2024 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="l9DyFMpu"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E08E12883A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259033; cv=none; b=ARlwAGDjb3xDgUPNIqQI4LEqtQRigJtgHCDY3Cv1+eLlVD69FTUeeqNpLF+2MYhPlUNTpo6d41tffiY2eEELLrwXeVII/TrIbpO5t/5U5YlmJn43aMXpXylmgCc/9FVIXpJfzbfz+o1Q85hvnwVS041V6W4gqRmni/R4h40ix04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259033; c=relaxed/simple;
	bh=dXY4VqV2dgu2W0tvqxrSc6CK/AEkg1qzMSsPoi4MjiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DxAC0jBRnuKblfDtBQT2uKRhZd1+q9M03Fffp3GYjz9eMmA4AMqDDIF8mJ78dQUTGa+3jzayEsFgcSDdRySVZKirqD6bSLcbLaEh/ydUN+b1APAR0QwAXayLgwAhY2P7OExakNa1q7acAhZ8PdrcCvMpurRoAivN2QtoUIgpcx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=l9DyFMpu; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4702457ccbso195183066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 12:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712259029; x=1712863829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YftQBH4K5k1eA4ljqzTyg0/24HcF6aTvgonFgjzZs9Q=;
        b=l9DyFMpuH5iZp8yRXD2IEjiJeCrlX2btyTYA5n84C+kCiWjreXcDNA/9kUdMZhBNSM
         3C3pRkikqkoPJbzOxLv1vn3qfOUdAAIF+GOxRBJywD3+hBk+SgPlAeSR5zmsAmhvIQ6g
         Ibdo4r9at/r3P7RgU8rGqQ9qNWpW6urB/ah0umZ2PALWUinZC8ixt9v8NOeww9Eev1lQ
         /lDRHDMlVRUm06EAAQT94cm4tJ+mntCp8XdV67eM6Dz1UToS4sbgi3nGFOAHtZVlSJPw
         oTW5j4z52ZLsx9Hwqx+rQ7M/rxSwZ5WqwwcjmUlqXgkCzqfKrlPRVRtZu3z/d9CZpBGW
         xx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712259029; x=1712863829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YftQBH4K5k1eA4ljqzTyg0/24HcF6aTvgonFgjzZs9Q=;
        b=lfaBYZf/YsaVWRkDWj2SwFfPEa0JecAFSlSoY2P8I+WdCaMET9jV0TEPyzrMXXkgpL
         hVyNynf2ug/p6vJe58K2b6oJDLY15fC9rGq4uBZWqU89XuPA0kWGzNT0vOB8/4ZBsDsn
         NH+wY7Z7f8b6DL/bPVBXBOFi2dCUXoEk2Uk+fQm0dxKPqyM44phQA+OI1tkkDt1dX2uM
         D70k2GLhL8yaDXgoq9+8wGqkMvcjpfpAH1/ixPKxZ21g7R3JHzatRt3E3p0Wd1fFp++M
         chtbyAMDWVRtx429f6Vx7ge8nAKkjjys5LP83Jl15P09CKawLkJBwg5M8o6PEk7luHer
         CKIA==
X-Forwarded-Encrypted: i=1; AJvYcCWPxYw+dEwMXzSPcUTp3RcvGdxYJYjwc/+832gHuWA3bNHTNbzqzhwgLaZlFpgiOAORZnw0UZrquCyxdo6FgH/LBUusVmA41ztJx2ps
X-Gm-Message-State: AOJu0YwSUJtEHukFCLwqZvL3Qc3hIXEwPv27GG7KFeTozuyrvOUC5WaF
	t8AQm8TkgInoOOJniZlYoeWGOR7s8pgf8zBzJSdhKJQLQchoe47jrbkXET0RTwfn3TcqlmQXWQB
	M
X-Google-Smtp-Source: AGHT+IHCwoiLEcG6OP23A1J6qWX+Ltb1CEDPb6mHfowgHbsbwpZ3SH5Q1cIQNWi+cyWfm3Rk2qcrrQ==
X-Received: by 2002:a17:906:456:b0:a4e:2777:37c7 with SMTP id e22-20020a170906045600b00a4e277737c7mr385955eja.49.1712259029236;
        Thu, 04 Apr 2024 12:30:29 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id t25-20020a170906269900b00a4c9b39b726sm9394909ejc.75.2024.04.04.12.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 12:30:28 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] sparc: Compare pointers to NULL instead of 0
Date: Thu,  4 Apr 2024 21:29:33 +0200
Message-ID: <20240404192932.13075-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following two Coccinelle/coccicheck warnings reported by
badzero.cocci:

	WARNING comparing pointer to 0
	WARNING comparing pointer to 0

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/sparc/prom/tree_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/prom/tree_64.c b/arch/sparc/prom/tree_64.c
index 989e7992d629..88793e5b0ab5 100644
--- a/arch/sparc/prom/tree_64.c
+++ b/arch/sparc/prom/tree_64.c
@@ -332,7 +332,7 @@ prom_setprop(phandle node, const char *pname, char *value, int size)
 
 	if (size == 0)
 		return 0;
-	if ((pname == 0) || (value == 0))
+	if ((pname == NULL) || (value == NULL))
 		return 0;
 	
 #ifdef CONFIG_SUN_LDOMS
-- 
2.44.0


