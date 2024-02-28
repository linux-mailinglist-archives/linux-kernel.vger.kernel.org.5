Return-Path: <linux-kernel+bounces-85806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A40F86BAFF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388851F23A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E979071ECB;
	Wed, 28 Feb 2024 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="ba/CQ0Pk"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611C11EEE7
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160744; cv=none; b=InRh1URRTM7HkhU76u0FPZjDgVxXawjfTFmyYeoY4P/RV/DXWn5R2vQXHQygvcT8t+3hw0ZjmAu2RL2hZWr92R3fXMILoRpOp6tvhCbor/hcClP4VjKgdvpBW8wMA/dM4/CzSZWFxQfOsCQ+LdAeurlzm4QpLnvWXVVWo94OH5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160744; c=relaxed/simple;
	bh=ZQCta753ivPoo8b0/ihVIr1oYvphcIvS17YSXyf2fV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OWs4ulJPE8eDEtKs3VX89pTWcBgWbGh+ygmTxoc/JypMXNAyDRBUoUpyuC5qMtFL4jwC6Kf90cDonV4m+f+JDXbDEIB0sUu+EnreiYIEfiCHQaEhvC7qaNkS1UkawlyYpxV6/akRJFOUI3FyKFyE6MjiXNUYZ3i2SIVJOtqLV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=ba/CQ0Pk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4348aaa705so48738766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1709160741; x=1709765541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p68q64fPKpPRnVU3Ta/zu5aSS1cC7AT3EHsyijjzmko=;
        b=ba/CQ0PkDCWH+jZYzyfb0/K+5alngizmRJpTtnaYxzuzFPJsEYW8vLyNJFioq4azcT
         h6dssooKwnTalEPs3WY/GHkFGhZm2EUcGRP+cN0Bby6uFOKjtUEc/qxmxtzapDJPf7Ic
         ZDjlAEuY7bcIHhK5RwYq38ziDaCadeEPfbTEt0cze9QVHoDVyElWMETfVzaZ0Ab+jBaS
         WRkfAX4wT62wcIAlrE9yXhfpK3Z78xFEq+y5Oul5e1brlJeejt1QJgZYRZQ2Lt0BbZpK
         m/aSFbteusCQttoS0iuFXZSNxma5El18SGMcAsaXtJBKcuLpPsjqco7m/j2//vElN+Yy
         VWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709160741; x=1709765541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p68q64fPKpPRnVU3Ta/zu5aSS1cC7AT3EHsyijjzmko=;
        b=lG1vdHKay4Ldl2gSNDyPLh2lxVx6gbL4vsJMErh5l4AVVpP8JIPXnroPWFtNdouCnc
         Q32xHlO9PETA6mChi1YqdOxULWZrSBwSC07oBvLsijrMiPh87/tAk5w+1Ya8RcQuWtdn
         kjYADhBR4NITjYOOAOcj+s41ucAIFd4fZzktLwhXyijbWJtoYTqnsia7XL3IEICg7h9f
         McoeYQIAxW2To5q+ZvqoecDkHqNN7FMLcjUyJXab1XwI91MQlJg5mGViVscPGn33aju1
         83XySsm4/Xfkxb5YanpBQzmW+E+SPdDrp/kqXA+4H8/6T99HZtUjj+sdTDty2nkPOFz3
         vvHw==
X-Forwarded-Encrypted: i=1; AJvYcCUeXx8tMhGXi29rUo44e/HieuE3pRhVvt7WNwnig1j69Co0I1/OR37KV3bfoIgJ3WpSpUJwuVHabOivVJ6J0SpswBOFDU2WTI6Dy6qY
X-Gm-Message-State: AOJu0YzOw0CaEXgYTG+7bew81qXoK7BD/0I7vZH6ChIaEiuzJLFS8v3I
	eKfcefGXeTip8qcBZipOC0MzlEbfbJFn5EdFx1ewmKnEi5MyXznSmgTu+kzp+/JKF8h7HQURehv
	fqndMuA==
X-Google-Smtp-Source: AGHT+IFXxI9A58dhuw3TFJjV1Gqjef2xeIhS2AJ9dF542nq8/YdvfewX1SoXF9u5MsKEXu0DwDs0DA==
X-Received: by 2002:a17:906:b7d4:b0:a3f:7e2:84cc with SMTP id fy20-20020a170906b7d400b00a3f07e284ccmr241976ejb.6.1709160740552;
        Wed, 28 Feb 2024 14:52:20 -0800 (PST)
Received: from fedora.fritz.box (aftr-82-135-80-35.dynamic.mnet-online.de. [82.135.80.35])
        by smtp.gmail.com with ESMTPSA id q11-20020a17090622cb00b00a431e4d5deasm2292785eja.155.2024.02.28.14.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 14:52:20 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] mm: page_alloc: Use div64_ul() instead of do_div()
Date: Wed, 28 Feb 2024 23:49:12 +0100
Message-ID: <20240228224911.1164-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes Coccinelle/coccicheck warning reported by do_div.cocci.

Compared to do_div(), div64_ul() does not implicitly cast the divisor and
does not unnecessarily calculate the remainder.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 150d4f23b010..dfafec7fba1d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5845,7 +5845,7 @@ static void __setup_per_zone_wmarks(void)
 
 		spin_lock_irqsave(&zone->lock, flags);
 		tmp = (u64)pages_min * zone_managed_pages(zone);
-		do_div(tmp, lowmem_pages);
+		tmp = div64_ul(tmp, lowmem_pages);
 		if (is_highmem(zone) || zone_idx(zone) == ZONE_MOVABLE) {
 			/*
 			 * __GFP_HIGH and PF_MEMALLOC allocations usually don't
-- 
2.44.0


