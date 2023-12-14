Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF5681282E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbjLNGdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjLNGdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:33:36 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC59B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:33:41 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35f418f394dso21335795ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702535621; x=1703140421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQa3Oh83Y7BJ5yvT1MB3NL690VGSVlOorSazsJGg8O8=;
        b=DvBunkzR3aTXEws5zejCNZYt1dYO8HtNv22PpeD6BZKmjD3eCmS2gsZcsK+FCMSpNb
         QS8k2g9Z/aROFkkN6BnY14YNekty0/5l1xGNxGO8EhvXOGrstspSFxWTH4A+zvTVeNQX
         ddp6QzKJ2HIh72VkQS49DM8JLBZGnlhsln2b/UPTx4iJI7cFrm3RaHr2zH1kfyuFaHLP
         CTzk3hfIXFofXherSmYH5jbKYjpSmUuChlAw5RCe3HjNi6pOWBfnnrTNKgtIZ2o/Qr8C
         E5Ox8aAYefsHXyyeGqzoEMbb4p0l2CPZOs9xkm1cuTOEvAsuRQarmwSElYU9rjTfgSb2
         z6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702535621; x=1703140421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQa3Oh83Y7BJ5yvT1MB3NL690VGSVlOorSazsJGg8O8=;
        b=lRzGynY7NjYQ2u0RBCw3XOpjLgBiYY6qCftWfU+4K7pmntReJQRf5nkmuaOesTJf6p
         Cmaa6nneCGDLojun2yqpAZoNryzoHUyasLwCXWCpMWOT5kUTPrA+1uqETUYxVq1VlDg7
         8Cn2daviy/iyzxpf+LZx07Nhww9IdZXESoIjrd9Bje3dSzDtB12ZLJtTJWL3GuPvLOET
         LtwQzT1vifi7KqvZG39eDIrAVpwdhhKzRJqdVXahq2ynZ5cqKT80H4lMViuChDylVVQt
         y5Zf84mOX4ZdTrGnYTHwDzf0i/EIsN+qYXxluVL2VEmQHZbaMkK/i9B/4MiQOFcxG/O8
         nDcA==
X-Gm-Message-State: AOJu0Yw1ptAgI985u8Fuhz7QP1qXGSp28fMZUeFi5ebNgkixAPzY/B4Q
        qUkQP2+oyHppVFwGSbw/3Sq6
X-Google-Smtp-Source: AGHT+IEz9WJYleLURMpZ+fxmZXd0E4sPrwuGGZyApaPAAwDEgLTtswTy+mHFNCYGonBLoIypIEFaLQ==
X-Received: by 2002:a05:6e02:184b:b0:35d:6d53:5439 with SMTP id b11-20020a056e02184b00b0035d6d535439mr14590043ilv.11.1702535621114;
        Wed, 13 Dec 2023 22:33:41 -0800 (PST)
Received: from localhost.localdomain ([117.213.102.12])
        by smtp.gmail.com with ESMTPSA id q19-20020a170902bd9300b001cc2ebd2c2csm11639491pls.256.2023.12.13.22.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 22:33:40 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     kishon@kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] PCI: epf-mhi: Fix the DMA data direction of dma_unmap_single()
Date:   Thu, 14 Dec 2023 12:03:28 +0530
Message-Id: <20231214063328.40657-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the error path of pci_epf_mhi_edma_write() function, the DMA data
direction passed (DMA_FROM_DEVICE) doesn't match the actual direction used
for the data transfer. Fix it by passing the correct one (DMA_TO_DEVICE).

Fixes: 7b99aaaddabb ("PCI: epf-mhi: Add eDMA support")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Bjorn, Krzysztof, I'd like to apply this patch to MHI tree on top of eDMA
async patches due to dependency:
https://lore.kernel.org/linux-pci/20231127124529.78203-1-manivannan.sadhasivam@linaro.org/

 drivers/pci/endpoint/functions/pci-epf-mhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 472bc489b754..d3d6a1054036 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -424,7 +424,7 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
 	}
 
 err_unmap:
-	dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_FROM_DEVICE);
+	dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_TO_DEVICE);
 err_unlock:
 	mutex_unlock(&epf_mhi->lock);
 

base-commit: f5668f251e29292326e45a022f933c15740a8af2
-- 
2.25.1

