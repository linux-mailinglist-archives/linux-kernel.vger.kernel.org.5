Return-Path: <linux-kernel+bounces-161428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655BE8B4BDD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79984B213B1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC746BB44;
	Sun, 28 Apr 2024 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewnwoOS5"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B740653;
	Sun, 28 Apr 2024 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714308916; cv=none; b=h8zwB5iH75+4PualyMAmqOmDL/nF6X8KE/JUJhg06cIt3rkw7CmZdzCtA5gAcrWFsB8s7ZPRSIHW05x3RvceyuWi44qd4oxW9X+o2rvRkk2iZGN8ucKogfdcWvetgXTh/ZFsPMApqR3P78JZ4/+olKcZXw6bzKj9PeBBG6sCXRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714308916; c=relaxed/simple;
	bh=EqN3AP8Sh1imWVLeXIIlEyo40sn1YcwBLc9TZ8TVZNY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kF+uh8KKUHkiHj/e5bQu0F8Q28x1k/Nk5zrbduFhQiRn7nEMnPa7Ti+r8ZE2mmpgEDw+hxdJOda8Ye59Wo95QXkpEa9D0OcVM2af3rQ7VRzYLSPBJE/r7I48Lw+68k0gXVnKjvfx4ZtlJlqNVjn2wiQfp11FOPdfVl8+SWtCWfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewnwoOS5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e8bbcbc2b7so32938635ad.0;
        Sun, 28 Apr 2024 05:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714308915; x=1714913715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TjsuFATNEaZUjTBdhjsGIqrTD0yuEnlIqwErMycmCrA=;
        b=ewnwoOS5VnRMa5huuFyWqQnrf2pDPy8NIJtXeozC88YGbT63MO0vTeM+5HoDenpdHB
         2QKVrTt6uCNMs9mtw1eCV/hoQKCL8S2zmI+KTv2JmXbRUlQGC39OUYo9EkP4lLzr802Y
         +40qIRvaJwFuvnI1Ffd1J7lEitdZLgwak564OLdSDvQCotDhtxiTNyaa+1KVq3UNE6LI
         hUT/k76Xs8GdtV1tvlIoHn3LiQSmhcMjeXRqvWsphNBlFByhl/o5actLBK43WBBv98IR
         sJeoTxgckonTUA495VExYRY4JCmh5lH2H7oxqUHt9jykwP3v1zq+gBbeY0ujCboH+T+Q
         ub6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714308915; x=1714913715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjsuFATNEaZUjTBdhjsGIqrTD0yuEnlIqwErMycmCrA=;
        b=ktAfaJ5cKSxZjE+qOyyzcrnkF32y/QZgwK9WT0XppXivjvC/TVOhQCbcfmVaazS9O1
         bKAlvzUsPMkfe1/QyaOqWOZ+jGIFQfvZSEH1Angwj19ilUsqHtPoajE5BfjyeanxtGR4
         rayTH61L7VUbFWxXtJLG4GIRbdwEngl5huM0X6uReqaoD0UTGNBMIbHA6byIzambPqxf
         oGz4BPxU353jalA8uH1Grj5oJAT4nPf5as/5Bkm8ETFVqKKKa2Dv2Qo0o4knnaaSzSOm
         9MEhtOKai1CGuvAq+QblmwKJFyIT6YWyZbXEu1+zGGdgiZhEN4OJ+tfWBsq/Ufk5JLDL
         zxjg==
X-Forwarded-Encrypted: i=1; AJvYcCVsmzb6dMmT4whmAMAVUn1B1FHMv61+zP5KwCZXISAvnNZahsYkyw9p9yzZJ92bca5OaBxJhLunZqM3jWjE+KA0BDrEbTfEpvJCmQQM
X-Gm-Message-State: AOJu0YyS9hitHlNzVscVEX2QnnWW/7SrSczSz147kpA+OzSMtFcGoYiW
	NczrXjwoaCG8sGXdjiqQdkaR+LJ/ldl8wgMavYTE6/FvwBcmWiH2
X-Google-Smtp-Source: AGHT+IG6ZIZB+OcAdME79YJfQMhBFiZCjAOr2DEI+5ogOCjicZpNZOJ3Y4zTzDHsSEK/+XIM5Y+31Q==
X-Received: by 2002:a17:902:d345:b0:1e4:24cc:e025 with SMTP id l5-20020a170902d34500b001e424cce025mr9669614plk.59.1714308914715;
        Sun, 28 Apr 2024 05:55:14 -0700 (PDT)
Received: from localhost.localdomain ([49.142.40.215])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090274c800b001e28d18bd52sm18456937plt.232.2024.04.28.05.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 05:55:14 -0700 (PDT)
From: skseofh@gmail.com
To: robh@kernel.org,
	saravanak@google.com,
	rppt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daero Lee <daero_le.lee@samsung.com>
Subject: [PATCH] of: of_reserved_mem: clean-up reserved memory with no-map
Date: Sun, 28 Apr 2024 21:55:05 +0900
Message-Id: <20240428125505.434962-1-skseofh@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daero Lee <daero_le.lee@samsung.com>

In early_init_dt_reserve_memory we only add memory w/o no-map flag to
memblock.reserved. But we need to add memory w/ no-map flag to
memblock.reserved, because NOMAP and memblock.reserved are semantically
different.

Signed-off-by: Daero Lee <daero_le.lee@samsung.com>
---
 drivers/of/of_reserved_mem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 8236ecae2953..1c916da8adaf 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -91,7 +91,8 @@ static int __init early_init_dt_reserve_memory(phys_addr_t base,
 		    memblock_is_region_reserved(base, size))
 			return -EBUSY;
 
-		return memblock_mark_nomap(base, size);
+		if (memblock_mark_nomap(base, size))
+			return;
 	}
 	return memblock_reserve(base, size);
 }
-- 
2.25.1


