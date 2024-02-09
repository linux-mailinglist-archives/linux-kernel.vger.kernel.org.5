Return-Path: <linux-kernel+bounces-59745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC5284FB2A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FFDB1F272C7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5B47EF06;
	Fri,  9 Feb 2024 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9caa+Vk"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EFA53398;
	Fri,  9 Feb 2024 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707500424; cv=none; b=Co+96Vv8Tg0Vm9C0XMyMIaDKOnkmyDc9E90kWgXFzu1NcAYsd9Qw5P+oSNgk9VV1VT7lM+ZgYHBUVU6jsNq8Pp0okvphIwEu+jwREUiBHEHRNQKLjgUWMEBHE4H5XJEd4knE2AqObCPDctFZL8DprZ+98IciGpjJZC0i+XWIc8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707500424; c=relaxed/simple;
	bh=ROnGNfaeD0/YKxBAw8frEflS/rFpbSY/kGI+18buZUA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rMh/8MuuRENQIGf5ccMu3BBtHj1x9/14U7UWfz6Th3AY5Y7/Fp5nMkwdlk/gvektMarOE79+L6oU40JsKWtGod5zqHyULXNI8Pvq1/L7tZ9iJ8xIX/+QpgA+sGqFkx1TReEsaIdvg/AIOLLq1gBAjoIM2VukakMmZTq22On7VSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9caa+Vk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fe03cd1caso11209275e9.0;
        Fri, 09 Feb 2024 09:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707500421; x=1708105221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B7o1axzx5/29BUOyumXHlsexf5uphP2TrHuxCCp3IKM=;
        b=g9caa+VkzUtV/blEzeUhbU2Isp5UIdt0cOrbUVX649ofK/y+qf+qsGcoOHKF/uT+Kf
         ipr7iuvSmrkHZ0B0mpO2h0Kc1y/UxquSThJRo3SJTrleYNlYpTNeIA/5lRAXxgiBAjbV
         WH7fGu1WA+SvIYRqI5dRf2lgTKejbsH2TL7Bsb5fktrYBK39WgQev+ZKRTtPZkbJNeIk
         InXm0ThB7HtBv0XZZfO3GcN4UbXIr/NYDkzLfSKixU7+N2SouQ94pIhz+UUNmu/Esf9Q
         LbLwQfZSg3Vy4bDKoe3+hNvt3XN+NTbP68XlZj1koiLl/9NChp7B0opWcYCwXEemYXFF
         RfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707500421; x=1708105221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7o1axzx5/29BUOyumXHlsexf5uphP2TrHuxCCp3IKM=;
        b=Z/EOx+WT7CruBsp12ez1eodlexGQQSwoallefaa87OayyWRf1ZYt1Qp+NSxWex9mKB
         9QLaZ1WJUN1Ft5s++Yg6y0mMSEIRkA4MLOMBW9cBpIhimBMSjhTdF41SyM5TTjyuZXvg
         dPKLCV7YuLxOMTm4dJPAcQbbS3ayWNdUfTIDFiBOhv2P7rLGkqQJFp+swSvgMfYZYOtw
         i0XZw+mPYAPUn7YGIaipB1zQCdreIFPM2S5Mc3ISdG52YMCigpKPr9dCUf4S5ORkb26g
         ji0rflReOiuJhCVKdCDNFDAbAUopH0G26PD9mWzByvgnCLu3hc2ylVGS6cMlueWy/ICN
         IRvw==
X-Gm-Message-State: AOJu0YyJ0H7Z56PpzGpuilFb7UguR2jnsJxv+IrDiZoVE3p/Jkj+tjH5
	ssqO0Y53gXOSoBxkVJWFkwvw9YBBgSE2YXjkr6+Zv7S59DiZUqwa
X-Google-Smtp-Source: AGHT+IEtokBxjIdNhOmh8A68nah3DLmTE+sLMrL/Kgdxjz5r5d23ErT2ogib9AgEzsuBcTF7twxrIg==
X-Received: by 2002:a05:600c:3b8a:b0:410:773e:c3d8 with SMTP id n10-20020a05600c3b8a00b00410773ec3d8mr15510wms.8.1707500420990;
        Fri, 09 Feb 2024 09:40:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIOqXUw3d1nTfvZcV0yzAkoNyy6hvU6EFjAQHC7E+mtCEA8QlFw80vRI/ONVOrcSeEIHvM9xzcGZjkwDDakAlLwxa2xgDiscZVc118DfVJP82HTimJQ8v1itETxplvM8Z82vn6xRYC30F1iuKBbUyOpFv9kT6fe3pkCt1zS4G/HdoBg0hCjvwyC+dNJ97P3+rlHPbY+0P84ttQ8x3fZQqc5m1b2Q==
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id fs20-20020a05600c3f9400b00410232ffb2csm1249064wmb.25.2024.02.09.09.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 09:40:20 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] mtd: rawnand: remove redundant assignment to variable bbtblocks
Date: Fri,  9 Feb 2024 17:40:19 +0000
Message-Id: <20240209174019.3933233-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable bbtblocks is being assigned a value that is never
read. The assignment is redundant and can be removed.

Cleans up clang scan build warning:
drivers/mtd/nand/raw/nand_bbt.c:579:3: warning: Value stored to
'bbtblocks' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mtd/nand/raw/nand_bbt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index e4664fa6fd9e..a8fba5f39f59 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -576,7 +576,6 @@ static int search_bbt(struct nand_chip *this, uint8_t *buf,
 		startblock &= bbtblocks - 1;
 	} else {
 		chips = 1;
-		bbtblocks = mtd->size >> this->bbt_erase_shift;
 	}
 
 	for (i = 0; i < chips; i++) {
-- 
2.39.2


