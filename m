Return-Path: <linux-kernel+bounces-75517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CF985EA09
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB192B255FA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157C0127B52;
	Wed, 21 Feb 2024 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LUbsc7jb"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9118C86AE5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550590; cv=none; b=LU3Rz/Ws6xlO3dyp1EK3i65mhRRBuwtTuB1spRiEj0xEFFJ2XMVo1WSa31bW+MbbkOo6jOld8ioy1oJ4rVaEs9nYJuFQg+2Mcfp7pS8KhqIQw/wDhfXLzkQdurL1r96zi5OOUQEMLPFPDluNyb41Yv3F1kVSUaViasYVJHmPH0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550590; c=relaxed/simple;
	bh=X1NMDwHNhaKtxaj2FzCnTNuRqpHnDCkiz42J4qyGhbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FjdQg39HEAL1Y7JdrbGmhzIUWyoVyFYtiqBPXA6N7P0CGDNFtIYEh5aBpY8GK3rpUt+cQSA50Qnjh92aNNR9truGt2/g2w8ja7xd2/E4p+Gx3Iz/K/EQ6BmTbYiU2YbHTCc8GcCqrPEXf+3NTG/WqIKh7imugahHgcTUPqx31iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LUbsc7jb; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d2531294faso18591691fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708550587; x=1709155387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZIfDFB+qHZTbDlUkJ5JuuXvN55Ime5SO9Jy3E23hCo=;
        b=LUbsc7jbvQDwU/Bl92PpwY3ti3O5wypNeXzPVhtsIkkGuy4HWpcMZyAkdzv9rNCrhi
         wime29P+pOnRy2peg9VHdgK33jbHOvu/vib7L56yqAWyPn0ygt3IrtKKTi/uRLFRgcz3
         c7UU8vQstjVZRj8JPaBjav7ZGvqTG+CeLKNrX1sR0QejFrBu6GP4W62UOL3a3wMQ/c/F
         OSpjrMv2sLWbad2/57tsMA5S7AJxcnCnqUxmlp5PQM6iWshh9CitAmLL0B4WytxHXvzj
         hMA/3WODy0lqx8uPpXtv8ZsJevlLimMoquqL0ZJXvJWF7sejVLJF+rQ72g6NPoE8Lccx
         VWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550587; x=1709155387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZIfDFB+qHZTbDlUkJ5JuuXvN55Ime5SO9Jy3E23hCo=;
        b=E+kOdMeAlu+YDCZlukH+Apeec6iRTofxG7Hk1tHCbc/Ju7/K3E7m34+cZgcrZFPaiI
         t3sTbhjYLjLF83Htp/uDBtYXIiU54hrtOOQeNk4gfalpcg+uCCybqBF2D0MuP3w2qLsT
         2ELwh4f1Ul5HnCKtwoOM0LAH+EpC5KLXqU2Gv6Kk8TaSyrnQ6xsZDoA9qsIeTi9VvDyi
         07DeoUoakPHZCMxYnp+qxgpU5a94htIUdr61PsESc8dN8GoVZO72nkoCiScTd3bXOm4M
         D2yfVaNwE98w8ANO/6SYHNMZbw3z2USElFBERfy5J0q1H24t8QkneNRjIQweFYl+vJyL
         lBEA==
X-Forwarded-Encrypted: i=1; AJvYcCXsZlrvGxNsc4jYhnRwJ0U/gJCL/MNhRtVVU05Z72xDSH0td5P3KM/62F+IZ8Wlnh9FBq+Qp8b/YcYvq+cZCK5r160ivZQeSdK89QCS
X-Gm-Message-State: AOJu0YxDZJxA6FDQ5i1Lcald9ztp249tk1no1A99RABESe5S+Av0VoLT
	IFY8v7sVxhXewDcXml42wbMmLvvqE0brFGe1lMlA8Ce0/c0xTuLktOoko2N95Hg=
X-Google-Smtp-Source: AGHT+IHq2DLVLSFzSPemSHRm0Ae2jTGQJlFvDdgNXpeOtMl7Jqw9w4zx6e6ZEqEfO44c8it6sq7Lsw==
X-Received: by 2002:a2e:b8c8:0:b0:2d0:c77c:b1ca with SMTP id s8-20020a2eb8c8000000b002d0c77cb1camr14817121ljp.49.1708550586825;
        Wed, 21 Feb 2024 13:23:06 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h14-20020a056402094e00b005644221a3desm4018764edz.3.2024.02.21.13.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:23:06 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Feb 2024 22:23:00 +0100
Subject: [PATCH v2 1/2] mmc: sh_mmcif: sg_miter does not need to be atomic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-fix-sh-mmcif-v2-1-5e521eb25ae4@linaro.org>
References: <20240221-fix-sh-mmcif-v2-0-5e521eb25ae4@linaro.org>
In-Reply-To: <20240221-fix-sh-mmcif-v2-0-5e521eb25ae4@linaro.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailer: b4 0.12.4

All the sglist iterations happen in the *threaded* interrupt handler
and that context is not atomic, so don't request an atomic
sglist miter. Using an atomic miter results in "BUG: scheduling while
atomic" splats.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 27b57277d9ba ("mmc: sh_mmcif: Use sg_miter for PIO")
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Geert, it'd be great if you could test this!
---
 drivers/mmc/host/sh_mmcif.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 1ef6e153e5a3..669555b5e8fa 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -607,7 +607,7 @@ static void sh_mmcif_single_read(struct sh_mmcif_host *host,
 			   BLOCK_SIZE_MASK) + 3;
 
 	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
-		       SG_MITER_ATOMIC | SG_MITER_TO_SG);
+		       SG_MITER_TO_SG);
 
 	host->wait_for = MMCIF_WAIT_FOR_READ;
 
@@ -662,7 +662,7 @@ static void sh_mmcif_multi_read(struct sh_mmcif_host *host,
 		BLOCK_SIZE_MASK;
 
 	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
-		       SG_MITER_ATOMIC | SG_MITER_TO_SG);
+		       SG_MITER_TO_SG);
 
 	host->wait_for = MMCIF_WAIT_FOR_MREAD;
 
@@ -710,7 +710,7 @@ static void sh_mmcif_single_write(struct sh_mmcif_host *host,
 			   BLOCK_SIZE_MASK) + 3;
 
 	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
-		       SG_MITER_ATOMIC | SG_MITER_FROM_SG);
+		       SG_MITER_FROM_SG);
 
 	host->wait_for = MMCIF_WAIT_FOR_WRITE;
 
@@ -765,7 +765,7 @@ static void sh_mmcif_multi_write(struct sh_mmcif_host *host,
 		BLOCK_SIZE_MASK;
 
 	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
-		       SG_MITER_ATOMIC | SG_MITER_FROM_SG);
+		       SG_MITER_FROM_SG);
 
 	host->wait_for = MMCIF_WAIT_FOR_MWRITE;
 

-- 
2.34.1


