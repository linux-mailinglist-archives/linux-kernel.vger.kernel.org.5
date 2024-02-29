Return-Path: <linux-kernel+bounces-86666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E14C386C8B4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C921C21532
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573E67CF24;
	Thu, 29 Feb 2024 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAH4ilpd"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145417C6D6;
	Thu, 29 Feb 2024 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208078; cv=none; b=lKquJqn188q8pg63kDBTHvnwGQfNkHI7dClM7IoV5j8tU6PRQxV9l0sp6HRxoNRaGZjFc/hxPvHM2rKCjUeaIUswM96kOr29hqYgFgatdQ2p1d+15hdyBwXfCsBgGeltAvxJaP2dp9bEEz9j+mtmKqJVnEa9m2YrHbbiwANZONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208078; c=relaxed/simple;
	bh=tsUHJaDpIn+D7l8huEZQkJle1PO20bTndyJz5QMVCEo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jlMkJtvZErX8or9YZeYECgABFmxJiXxjNDhxAL9rTTjL8rHG1TVPjtEMEvMPQXxQX098ph9PPsEw6VgmhAu+UN4yPTjAOkzj4hZ5FDfHJ0AuaX9vippVzsPNGhASzoykteLcukzscmEejDxHSofDnK2fgir7feg2O7xXwg4wGa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAH4ilpd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412ae15b06fso5384455e9.1;
        Thu, 29 Feb 2024 04:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709208075; x=1709812875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eEAjs0RdcfPAuQlAjUQMeit5zsCbuLGbEFFZ96le7No=;
        b=cAH4ilpdJzUckdKdvbUUDS6Chf1yRH0fkgvUyYhiMhD6ogeewvsl7ZzncF1EqQdxQ6
         6s/zQGVkHKFhD/fKlM+0zKB4XCKaXgoBomIT/6vX7mnKDHbfYTE6eTcmIucRk+rdmCxW
         wz3j9QPUK4prwOHZcw2yLOg8Oax1IMtXxqFkmOJPg9l+TZLWjpC3wlksbsYdTRH4tST4
         kD/G4acW2h8fRBYDtmnKwTpwWMO7LO4nCwHzqpdgeLud1FyaOCusdTra9Dmeu6mE2UPl
         AKxHdEpMt93Kfskvn2GCTGkhbyfVqqYlDFrPOXSUkM1aHc7By07m0H/UHKwGHkQpbTHi
         tX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709208075; x=1709812875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eEAjs0RdcfPAuQlAjUQMeit5zsCbuLGbEFFZ96le7No=;
        b=HezhTVJYRz9T/47J1m8egtKR7uaCtmYG4gUYGutMhJS2BqJqroPuX4AEaO1S3oOxoN
         G0nZ0MbJ2xVPOAEvBggcp5nSy/HHLKtJtc5cXGPxvjjSFnpdKo2J37rJDj6Usb/u/cG5
         M34xUJPe6z898Pkj0NTliGfs8UME7ROnjoP8LnCeGt/oVh1qLJw7uVEFP5A/lk0IPT8m
         7X9SMfYsqwJqSJqqkvtdLyFiup3oKTucc/fMVVjQfqPSSotHk+xIcfEVEDDwDlOhQMu0
         LIm1o3t2Ibi4yoGu/fEIMW1AEzoNtVAZ2KrJIVupoU97cP0WybCX6RlnsWvgdIKY2vxL
         vUkA==
X-Forwarded-Encrypted: i=1; AJvYcCVLYDZVMlzvvcKwWhpV5jJ+MfeF/BFOGDApPHb5uqX6z9fTQn/BJdLdYVtMA57QW1lp8VjzUu/c6udHTghXjYd+lcKeNAzjDCbqASKaV7pphcaIlEP+ehrCUEeg7+Lnmg+hA5Vo/OanCCo=
X-Gm-Message-State: AOJu0Yxl2cfNOacXp2oGctGuXmc3X/0F05eAQpQP9lED3btuh57/3O19
	FUmt/z8pmprspypdlZJKTpQ59rbiZXlLLrThVWDqpcAxSgk99NvDJ7p9ilUAD/Q=
X-Google-Smtp-Source: AGHT+IHC3vwxsZB7sP4Fov8PtZ8j3jocrLNBn1PvwUm276KL0P9EU9+xvQoaqFjvMvY+vAlNTY8CIg==
X-Received: by 2002:a05:600c:4ed4:b0:412:9842:c4f2 with SMTP id g20-20020a05600c4ed400b004129842c4f2mr1610641wmq.12.1709208075311;
        Thu, 29 Feb 2024 04:01:15 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b00412a31d2e2asm1908421wmq.32.2024.02.29.04.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 04:01:14 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: fbtft: remove unused variable 'count'
Date: Thu, 29 Feb 2024 12:01:14 +0000
Message-Id: <20240229120114.219085-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable count is being initialized and incremented but it is never
actually referenced in any other way. The variable is redundant and can
be removed.

Cleans up clang scan build warning:
drivers/staging/fbtft/fbtft-core.c:330:6: warning: variable 'count' set
but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/fbtft/fbtft-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 68add4d598ae..38845f23023f 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -327,7 +327,6 @@ static void fbtft_deferred_io(struct fb_info *info, struct list_head *pagereflis
 	unsigned int dirty_lines_start, dirty_lines_end;
 	struct fb_deferred_io_pageref *pageref;
 	unsigned int y_low = 0, y_high = 0;
-	int count = 0;
 
 	spin_lock(&par->dirty_lock);
 	dirty_lines_start = par->dirty_lines_start;
@@ -339,7 +338,6 @@ static void fbtft_deferred_io(struct fb_info *info, struct list_head *pagereflis
 
 	/* Mark display lines as dirty */
 	list_for_each_entry(pageref, pagereflist, list) {
-		count++;
 		y_low = pageref->offset / info->fix.line_length;
 		y_high = (pageref->offset + PAGE_SIZE - 1) / info->fix.line_length;
 		dev_dbg(info->device,
-- 
2.39.2


