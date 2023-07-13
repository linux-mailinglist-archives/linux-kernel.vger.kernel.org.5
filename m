Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EBE751D40
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjGMJb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjGMJbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:31:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D9A12E;
        Thu, 13 Jul 2023 02:31:13 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3facc7a4e8aso874855e9.0;
        Thu, 13 Jul 2023 02:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689240671; x=1689845471;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMVwvredptzXoUFxB3OGmhBpfZn/WXyS0E/tACaQWck=;
        b=Jg8ay29X+g2oz/IgstdBMUaWd89DktJ5HjoUZfTf/gM2L78ulDjm2VKTDE1XHNLGb4
         dmYsRLbl65oByJxwY+qRisEMn+IIAJDrlux+/AAEg64ozYGUhMXpCL1PtaEH/ILESQiz
         q661DYSMKov4rSVGT3MzsGdpXeyHxg0u+TC8n7yaP1cf0bjMB1VSiHvgN33IpVRCo0pa
         V894NUG7RE7+DqEcnn+W9yO0rK81cpi4NVqU+r9vIV3rr7RY0Rs7oFr6IJwYh0CiNB3J
         0RR6SlHBLlIeZVD0MM9YvYwwhb+Kixr3OWFeg89AW2msILYCQe9tqcIuLlQkM+R8WDAT
         cNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689240671; x=1689845471;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AMVwvredptzXoUFxB3OGmhBpfZn/WXyS0E/tACaQWck=;
        b=WPrajAsov26KYY5KEWK7kDNY17GJ8YLpGs600l+yF3bgrWq3QMbK2Y6k2wdFe5vBld
         Qv2jXJHlS9VlrSRRClHc3A3QWAUKMq+82QVqOdrTKFnVZVCAMy025ttrNYL8U4nneVe2
         A/2rx0umPqx/i67NpALXSDX0iCeQ4B8SVbmchXNjvGkpIrasTlZV9fhQI+I6kLCO7dls
         YnoyLWVrGUlfJhINw431jUtzBH/1tj/xSTUTPVGFvhhkWM6V69aLUCZBvjBMFdFdfc05
         jJPkGLa7W7mf5Z23ZEn3AsrZANhmJsqLJg1iUfg9gcOLzOG5CG2H77xoWiPVmYFLlcRx
         fpGg==
X-Gm-Message-State: ABy/qLZqtna3C8q1tlbxCSWLuInzRLIbvfN5dOYUcbKC8dmuBspLw5CC
        Y6UgXWiAo4NC3HfqL4yJpQ7zxCZgeCVHZg==
X-Google-Smtp-Source: APBJJlFc8P5cTqgGx+6vwzI519/iZI1K8cXMHRp+q1GHSB5/UB+uQuvisLbhZqXr3Hy+jZH4HipMfQ==
X-Received: by 2002:a05:600c:5192:b0:3fb:3dd9:89c with SMTP id fa18-20020a05600c519200b003fb3dd9089cmr1027160wmb.0.1689240671165;
        Thu, 13 Jul 2023 02:31:11 -0700 (PDT)
Received: from [192.168.52.185] (ip-037-201-213-172.um10.pools.vodafone-ip.de. [37.201.213.172])
        by smtp.gmail.com with ESMTPSA id b7-20020a05600c11c700b003fc015ae1e1sm7385698wmi.3.2023.07.13.02.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 02:31:09 -0700 (PDT)
Message-ID: <8b57db8d-1d3a-883e-eb8f-ddf15f19d823@gmail.com>
Date:   Thu, 13 Jul 2023 11:31:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        brgl@bgdev.pl
From:   Julien Delbergue <j.delbergue.foss@gmail.com>
Subject: [PATCH] mmc: davinci: Make SDIO irq truly optional
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following error is printed on Logic PD's DA850 EVM:
  davinci_mmc 1c40000.mmc: error -ENXIO: IRQ index 1 not found

Depending on the board, the SDIO interrupt may not be present, so use
the correct function to reflect that and prevent logging an error.

Signed-off-by: Julien Delbergue <j.delbergue.foss@gmail.com>
---
 drivers/mmc/host/davinci_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 7138dfa065bf..fb686c0d171c 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1257,7 +1257,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 
 	host->use_dma = use_dma;
 	host->mmc_irq = irq;
-	host->sdio_irq = platform_get_irq(pdev, 1);
+	host->sdio_irq = platform_get_irq_optional(pdev, 1);
 
 	if (host->use_dma) {
 		ret = davinci_acquire_dma_channels(host);
-- 
2.34.1
