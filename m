Return-Path: <linux-kernel+bounces-56629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BD284CCF7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81487B25DD4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C6C7E773;
	Wed,  7 Feb 2024 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fp55w1d1"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A25A10F;
	Wed,  7 Feb 2024 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316713; cv=none; b=biGnd/NKY8U1c+UMABqCZo1UNsOtPKKLd5ZKfcmT35jbs1xh/eqPuU5O+fm8UTQnLtGu3dVq7T6Z6X33sdy73bx3HTTFg3pQtP75bJuoTYcRRpxxFfVxl3qmR22VpK7i0c/EHrtYMVjcQFccGSXUuwWc80kjo7j3/mtF0gt6VW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316713; c=relaxed/simple;
	bh=Y42qZrTeT1zrticJCI2eB78hvcGQgoC9z0KtHukNgEk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Gu5nnZwBWdaT1wE0dSkSShDAvED+04Bu880XNlVq67iB9TQ53T6xSrLa35hRvZxs6t7ACOsuHeWBguXtx/cGnX3BZ5Cd3h2CSOnJnB0oXoBZzqaQL6DF4Wim1KoNG0zWZROXNmq48Y25mRr4JyEGtIaojk2gEIqPeb57+cTMpE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fp55w1d1; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2a17f3217aso86098466b.2;
        Wed, 07 Feb 2024 06:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707316709; x=1707921509; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lE++2qVcHW+CEBtsbdN8eH8qiiSu+9Mbj56gyVDwMac=;
        b=fp55w1d1f4fgJiTe5O1p1c16/pEOio2w/3miKjgdLbVEzRRklq6EOP9RjAEVtCRJC8
         l37643r2Poab2vaNXzw5XNO8oWyOtO4mVyi8pBgxel/7KaJSEJ65r/WijN+g9h8ednzK
         dUnwJNMjSPcDq/2C1N5bxYp0U++y8H2US/3eKQMB8l+/tCK3xEXCQc/7OvG8Gbpkzj5b
         LHTT8gshEf0+0fhlmqRaAmmjWP7eXXqhtTo4xVy2FuzjCOJiz92kPcwMie9GXZfZlm8g
         J/UmmkypCjXFYsf/XP7VFUY6iHrR5OdkArakTeMPs7WsKSyf6jPnB00JQtktJI/gTBNG
         6YYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316709; x=1707921509;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lE++2qVcHW+CEBtsbdN8eH8qiiSu+9Mbj56gyVDwMac=;
        b=XICHjH2eccfy8c6zozplcmiQ6yTfIvG1BIIboP1yNel5ow9Y25deIhGuv8COwLyM88
         Hzx2XPp/fY467ree5ouNhWELw7SmxXst5f7mz7WXwFj4Km1HKVYhIPNTHCJoRXmm4bm+
         gLcRr4vimbBy8gAOEmvgklduXbBoOOJL0K7INqEf46l3MX/eD67ckY9fbQtyXUx+RLVT
         7ooufmxSQhMulcn7079cJi7DT7wNPLTZePYJ1/kCcuFD2b2U5oKYo54a9YhrmVdbiBDi
         2U+hTKnFmwjM+kdpDbScIuqXR2BX69RWPHwCilBFUzSepdxzsS9lXDnmkasnzBzjD+Ms
         sarA==
X-Gm-Message-State: AOJu0Yzh3u0s7aXM5+Gu0yFazDSenKZoNMTk/OmRmqSrBZW9Swd7nl2H
	t84z33sPsBWKJLwC6GFZ7XlmstkOLNMOSDr+o/ZFqRXahSagn4Ug
X-Google-Smtp-Source: AGHT+IHZ/o2nyrH1w9/WKrRaDNSV5U88ds7/ilsdYSb4FQ5tw2TG25fyjXJ5DGd3biDOaR4ubXWj8Q==
X-Received: by 2002:a17:906:1c5:b0:a35:103e:3614 with SMTP id 5-20020a17090601c500b00a35103e3614mr3841031ejj.52.1707316708889;
        Wed, 07 Feb 2024 06:38:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1SGCkbFbH5np12iRMTSf3C23VaNyd1pFuBYbaAmdRdkAf7nHEAwZSaqxOWBF+hPrdUQunP/Th/RSqYO6stTgL9/XL6PoB08KvQruhpOOGgEDUM4vK/OtGz/ebYpuGnLUW4K432aGsSTX3ADljRzcFogfQUNj8mzlxV39Szh2T3A9bDoJAI1M2vAxWNRzR/JHpfnREjymvB0B/VuhOLvpEN9uB8IHL48zDAqxlFAfM4baOKxYFfMYmtnXECNQqGBNCpVgxOWeAepvc+Regj52iX2ez
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:81be:a476:88e2:db23])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090699cc00b00a35200615d7sm820909ejn.1.2024.02.07.06.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:38:28 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] dma-contiguous: remove debug code to removed CONFIG_CMA_DEBUG
Date: Wed,  7 Feb 2024 15:38:25 +0100
Message-Id: <20240207143825.986-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit acc2f3e42d4a ("mm/cma: drop CONFIG_CMA_DEBUG") removes the config
CMA_DEBUG and the debug code in cma.c, but misses debug code in
kernel/dma/contiguous.c.

Remove this dead code from this removed config option.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Andrew, please pick this minor clean-up patch of top of the commit above.

 kernel/dma/contiguous.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index f005c66f378c..055da410ac71 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -37,12 +37,6 @@
 
 #define pr_fmt(fmt) "cma: " fmt
 
-#ifdef CONFIG_CMA_DEBUG
-#ifndef DEBUG
-#  define DEBUG
-#endif
-#endif
-
 #include <asm/page.h>
 
 #include <linux/memblock.h>
-- 
2.17.1


