Return-Path: <linux-kernel+bounces-75518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2A585EA0A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3410D1C23E26
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE2E12837C;
	Wed, 21 Feb 2024 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EihzY5jA"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7367C126F2A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550591; cv=none; b=Gf3FqoSYpvhogWz4Ao4WyXaNQihoqL8QBK308kA59kLDnRj/W3rRIEUT5UN2K3qLUA/nqfL02pWK4tObhv03QnnnD+9TLxrlp63PI1RtVlIRWSZFZ4lqCs+YFvJRvVxasCXbbtZZz5glQWSSwOI2C2nJba0dYsHyhPL/bas9rHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550591; c=relaxed/simple;
	bh=Q97GKjG618rmqzYhuKBwtMVC+Xp1EdypCJVY/5vfUc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nabHzdxNlLW587kcAxKPCNV15RH8864LSDkgsJWgmuikupPUYmOStYIEwrf040ALlhKqbr+f656wVsVR8JFDGX2I76E4LJw0WN7PdJr7vVG6/84tBeVF2Lkb0XHLCW8B4zrVq/sfrPx9cZ/2UsQJaXCznfaXUa/3AAGLMqGF/yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EihzY5jA; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5645960cd56so5429890a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708550588; x=1709155388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SSSSEzfunpVKo3VA6iNBnH3HhYtnjVDxAPoRZgjZUQ=;
        b=EihzY5jAsxL8fZz8P2tCF4cQT2GaF5bo/XJZrTehc8gltRmqiCU5QtV3c+14kki8b6
         6fxn+LhdhhgpPkjy5W1i6kakUe14QhDMzU6RhONg2zo6bCXP4rLqZvS9rqQVPXuu3BTT
         dMxQeAFiCspT59Sm1ygXneojtZGCLanNgHn0NoovtbPndbK4Re8DjrntuvvEp3vKCnhS
         yvERnGG11hHezSrea65BN/wnD7BgcR14skMVdwfnszYWb9XsN6KixIEzBzGoe6qcPzTY
         +27JZlr2x5w5v2n0mUD3B6NjvoEiP2n4sFweNypOU4LnRGXwXpEDcvGxaApGjsnHIIEv
         IhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550588; x=1709155388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SSSSEzfunpVKo3VA6iNBnH3HhYtnjVDxAPoRZgjZUQ=;
        b=clALUf6A5MRmXpVO5K1iAfKf2oJ9gFY2gwKL4aKf3/RSPz+ORgWRlEoRaZrvX9vJUP
         AuJ2ricIZ/CRiERmrOFFpLOA5nlgicRwDDCxzpgFBRUEYjFfdjA1QmHEGdki6vjBZIqe
         1X+HHFrMR6Wzuyu0y0jn7ySigJuH2X6WsH+a2sG5cpgVXpN7RxJcw3dd1iYbdAd9oodm
         lKblKCN5vYnQRZebGO+13P3zggk7Pc3l2VQXMZVE/M07sRM+UPamKoFtUDLAg8jllkZh
         24xCzVvab4HdjgavKc2O8J9e+S9fyi6L7II6vG1jgIsJDpdsFdvZxJZI5KgK8pvtTUxl
         mSQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGigmEM2r64yepnWqmxWsA2ce94urGraYqBClzR6yJUFpIBaVlnyxsUTCICNhWWmC4/CcH0yl39Pp/xlXM4h5QzpOqCXVrhX1ZuZfu
X-Gm-Message-State: AOJu0Yz6GgLgpYDvEM21N530/Fjnn9KxgMPBYSRJ/CAGUHmzZpy7JRXu
	vW5WbCmdDbLYOvgXWwYM/dNcNUQ60VIX39GjXSE4HUQ8RpjRg+rSRmD5YXRstUc=
X-Google-Smtp-Source: AGHT+IETkKAOcMl6EOtyDkXpzlXf09WLA7KktxIAQUyZJqVUTFRkn9d1Km8IRmcUakvpCDMyUAyXkQ==
X-Received: by 2002:aa7:d609:0:b0:565:26f7:4bf8 with SMTP id c9-20020aa7d609000000b0056526f74bf8mr357391edr.8.1708550587743;
        Wed, 21 Feb 2024 13:23:07 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h14-20020a056402094e00b005644221a3desm4018764edz.3.2024.02.21.13.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:23:07 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Feb 2024 22:23:01 +0100
Subject: [PATCH v2 2/2] mmc: sh_mmcif: Advance sg_miter before reading
 blocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-fix-sh-mmcif-v2-2-5e521eb25ae4@linaro.org>
References: <20240221-fix-sh-mmcif-v2-0-5e521eb25ae4@linaro.org>
In-Reply-To: <20240221-fix-sh-mmcif-v2-0-5e521eb25ae4@linaro.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailer: b4 0.12.4

The introduction of sg_miter was a bit sloppy as it didn't
exactly mimic the semantics of the old code on multiblock reads
and writes: these like you to:

- Advance to the first sglist entry *before* starting to read
  any blocks from the card.

- Advance and check availability of the next entry *right after*
  processing one block.

Not checking if we have more sglist entries right after
reading a block will lead to this not being checked until we
return to the callback to read out more blocks, i.e. until the
next interrupt arrives. Since the last block is the last one
(no more data will arrive) there will not be a next interrupt,
and we will be waiting forever resulting in a timeout for
command 18 when reading multiple blocks.

The same bug was fixed also in the writing of multiple blocks.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 27b57277d9ba ("mmc: sh_mmcif: Use sg_miter for PIO")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 669555b5e8fa..08b4312af94e 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -653,6 +653,7 @@ static bool sh_mmcif_read_block(struct sh_mmcif_host *host)
 static void sh_mmcif_multi_read(struct sh_mmcif_host *host,
 				struct mmc_request *mrq)
 {
+	struct sg_mapping_iter *sgm = &host->sg_miter;
 	struct mmc_data *data = mrq->data;
 
 	if (!data->sg_len || !data->sg->length)
@@ -661,9 +662,15 @@ static void sh_mmcif_multi_read(struct sh_mmcif_host *host,
 	host->blocksize = sh_mmcif_readl(host->addr, MMCIF_CE_BLOCK_SET) &
 		BLOCK_SIZE_MASK;
 
-	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
+	sg_miter_start(sgm, data->sg, data->sg_len,
 		       SG_MITER_TO_SG);
 
+	/* Advance to the first sglist entry */
+	if (!sg_miter_next(sgm)) {
+		sg_miter_stop(sgm);
+		return;
+	}
+
 	host->wait_for = MMCIF_WAIT_FOR_MREAD;
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
@@ -684,11 +691,6 @@ static bool sh_mmcif_mread_block(struct sh_mmcif_host *host)
 		return false;
 	}
 
-	if (!sg_miter_next(sgm)) {
-		sg_miter_stop(sgm);
-		return false;
-	}
-
 	p = sgm->addr;
 
 	for (i = 0; i < host->blocksize / 4; i++)
@@ -698,6 +700,11 @@ static bool sh_mmcif_mread_block(struct sh_mmcif_host *host)
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
 
+	if (!sg_miter_next(sgm)) {
+		sg_miter_stop(sgm);
+		return false;
+	}
+
 	return true;
 }
 
@@ -756,6 +763,7 @@ static bool sh_mmcif_write_block(struct sh_mmcif_host *host)
 static void sh_mmcif_multi_write(struct sh_mmcif_host *host,
 				struct mmc_request *mrq)
 {
+	struct sg_mapping_iter *sgm = &host->sg_miter;
 	struct mmc_data *data = mrq->data;
 
 	if (!data->sg_len || !data->sg->length)
@@ -764,9 +772,15 @@ static void sh_mmcif_multi_write(struct sh_mmcif_host *host,
 	host->blocksize = sh_mmcif_readl(host->addr, MMCIF_CE_BLOCK_SET) &
 		BLOCK_SIZE_MASK;
 
-	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
+	sg_miter_start(sgm, data->sg, data->sg_len,
 		       SG_MITER_FROM_SG);
 
+	/* Advance to the first sglist entry */
+	if (!sg_miter_next(sgm)) {
+		sg_miter_stop(sgm);
+		return;
+	}
+
 	host->wait_for = MMCIF_WAIT_FOR_MWRITE;
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
@@ -787,11 +801,6 @@ static bool sh_mmcif_mwrite_block(struct sh_mmcif_host *host)
 		return false;
 	}
 
-	if (!sg_miter_next(sgm)) {
-		sg_miter_stop(sgm);
-		return false;
-	}
-
 	p = sgm->addr;
 
 	for (i = 0; i < host->blocksize / 4; i++)
@@ -799,6 +808,11 @@ static bool sh_mmcif_mwrite_block(struct sh_mmcif_host *host)
 
 	sgm->consumed = host->blocksize;
 
+	if (!sg_miter_next(sgm)) {
+		sg_miter_stop(sgm);
+		return false;
+	}
+
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
 
 	return true;

-- 
2.34.1


