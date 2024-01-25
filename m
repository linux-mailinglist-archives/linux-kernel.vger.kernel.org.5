Return-Path: <linux-kernel+bounces-38194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E413A83BC4E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2262B1C25D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057741B95E;
	Thu, 25 Jan 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M7k6wnvA"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1F71B948
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706172628; cv=none; b=VrRLorGWVAASHXl5n0u9KIrj5L2GCZlHVT8j1kiQELrVtNrB/XYU6bMH0Ud2AUQnBx0Q9ygKtYdlEqEW7Yw3P2Py07Jkm9b8JkGcioLmqua0c70Xdc+HO4kTZgPkJALn5yres0dK29qgyO+cx6LOlv357LtotEGKQkVIQOHvdhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706172628; c=relaxed/simple;
	bh=EH+77AGVJlszAEz96TBhp+qKRmGjcsF5K96WCfJ8o8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gmsf9kpEPCH18NngOofXYoZqL1sldmE9DhM4lQtE3zorkUGoGzycLAS/JUz+e42GWGEYfc8IzHmLcGGH3leeJy/oOhzOBtOAKrg75ZS0swpTElvk45X9+sAlLjYbjQgFRp9U4WSgDrifLd8Zgm/aNUOd7QGPSXs04W5O+iZaBsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M7k6wnvA; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50edf4f478eso8492617e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706172624; x=1706777424; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9nzIZ26hgws2/hotMw7rC6A6aDLu0kuLVowyhBFtTbQ=;
        b=M7k6wnvAPH8H2FZTR0S0qE1xM49BOh2/xL5+jjzcRufqlzb9pZ7If9Kw6SECA3VvzU
         /bp9r0+D0xIS+UEEM21K4auvqHADzAmXJ/FHHbIB0ZHyv+tKeskARgDmwC6Jm3cAiFgm
         ofnYXVfjbMlX9tM+ECfeUEWm1Ce5sQgOetTa4ia7RiCTcoZxOlOa+c6iQUTSnOdW9dON
         a/O36/5ISThtaZF9/NFKxD5qm+yQl2Vj1yj3NOcOzWlyBqCYNWg7FfVvJsdxl2CyXsUg
         Es2+Yfalzg6WTWYdbQbzxxnzelvBq713ib6kBhGoKRyPcqUw2mVdoM3+cOuK1CtmKKbp
         Jr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706172624; x=1706777424;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nzIZ26hgws2/hotMw7rC6A6aDLu0kuLVowyhBFtTbQ=;
        b=QTdKwGgI+Io6FXm55ePf0JkkcgREDGMbNx6pqxe44VqxcMb5bpjJ7ai2A5a4npqOT7
         svkXb0rQjhW3ly26CerJmGv5UWwXFPKAmz42L0jT/fJ7ot3xXas2AtzfuE6yU0y2nvO3
         rSrjGe5h8QqX/gBuoDiNwEGVKIHfiGWcKo+edjR//wXAA6Aallzc2vNiQYRSpS86MrAe
         eGN0sWEQeIGf3e7F2Lu2mM5NOxeGCnOMHoNa40kQjTIX81thBYs3RzQXxhdJLJxkPlMs
         9AQC/yKCQ0dpiyOh039pWaYUG38d01mBzqPNX6CnmZR1PBDceE6Gwxi9/iDUGFijMX0u
         rm7w==
X-Gm-Message-State: AOJu0YxoxdHXZiY+YnEK/LKW8eGpT92Fq99/eorsYIc7T/2CGCZcm7Rl
	UVgzYos23AABrPhlpcnhjnhVvJhkPmbKqdV0FEhy0Koo6L2gMss4FV3dIojj5lM=
X-Google-Smtp-Source: AGHT+IHJWD3jYEqjozXgzWqcokqJicSTE9IHnA8mciO79pYDUDuyeYTZkSPRMPQqEFQzjJkNW8gzTg==
X-Received: by 2002:a19:8c1e:0:b0:50e:7a04:2229 with SMTP id o30-20020a198c1e000000b0050e7a042229mr356615lfd.25.1706172624565;
        Thu, 25 Jan 2024 00:50:24 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a6-20020a194f46000000b00510189e1581sm201522lfk.249.2024.01.25.00.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 00:50:24 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 25 Jan 2024 09:50:23 +0100
Subject: [PATCH] mmc: core Drop BLK_BOUNCE_HIGH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-mmc-no-blk-bounce-high-v1-1-d0f92a30e085@linaro.org>
X-B4-Tracking: v=1; b=H4sIAM4gsmUC/x3MQQqAIBBA0avErBswEbKuEi3KJh1KDaUIorsnL
 d/i/wcyJaYMffVAooszx1DQ1BUYNwVLyEsxSCGVaKRC7w2GiPO+4RzPYAgdW4eLVqR1p00rWij
 xkWjl+x8P4/t+a5/YAGgAAAA=
To: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The MMC core sets BLK_BOUNCE_HIGH for devices where dma_mask
is unassigned.

For the majority of MMC hosts this path is never taken: the
OF core will unconditionally assign a 32-bit mask to any
OF device, and most MMC hosts are probed from device tree,
see drivers/of/platform.c:

of_platform_device_create_pdata()
        dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
        if (!dev->dev.dma_mask)
                dev->dev.dma_mask = &dev->dev.coherent_dma_mask;

of_amba_device_create()
        dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
        dev->dev.dma_mask = &dev->dev.coherent_dma_mask;

MMC devices that are probed from ACPI or PCI will likewise
have a proper dma_mask assigned.

The only remaining devices that could have a blank dma_mask
are platform devices instantiated from board files.

These are mostly used on systems without CONFIG_HIGHMEM
enabled which means the block layer will not bounce, and in
the few cases where it is enabled it is not used anyway:
for example some OMAP2 systems such as Nokia n800/n810 will
create a platform_device and not assign a dma_mask, however
they do not have any highmem, so no bouncing will happen
anyway: the block core checks if max_low_pfn >= max_pfn
and this will always be false.

Should it turn out there is a platform_device with blank
DMA mask actually using CONFIG_HIGHMEM somewhere out there
we should set dma_mask for it, not do this trickery.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/queue.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index a0a2412f62a7..316415588a77 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -351,8 +351,6 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 	if (mmc_can_erase(card))
 		mmc_queue_setup_discard(mq->queue, card);
 
-	if (!mmc_dev(host)->dma_mask || !*mmc_dev(host)->dma_mask)
-		blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_HIGH);
 	blk_queue_max_hw_sectors(mq->queue,
 		min(host->max_blk_count, host->max_req_size / 512));
 	if (host->can_dma_map_merge)

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240124-mmc-no-blk-bounce-high-d84e8898c707

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


