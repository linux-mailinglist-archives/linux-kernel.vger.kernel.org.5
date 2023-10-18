Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7FC7CE80F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjJRTrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjJRTrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:47:12 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35736119;
        Wed, 18 Oct 2023 12:47:07 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-583552eafd3so246103eaf.0;
        Wed, 18 Oct 2023 12:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697658426; x=1698263226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLYRVhjiiCAR5NlBeW4PZhPgUBi+QF64GvuGWJOkciM=;
        b=gOCTP0UqR5p2dtAWV8koDUxiBbhj5vH6tzD5HY9fKCsOL16Sr1G4j6qT5NUjEAzRXl
         sLXsu/Xz/u19ZFlLD+80v/7wvXf2UTDxKAoXNft5uWIPPn6HPw3ZkypkI2DCt4UiqxxI
         fDXRnM5zeCPSkx6y1R/1bQ2UZ3kV9G1RaAep4IK5bkBHdeb8xBp/SvMzl/EnGljQjldB
         M8vs0rdUfZpcmWAVkhkMcKPlUAHgFXQvBsPveC8n9kw4CeThY37fL0SQknPm32E7hlYN
         an0rkQ30rl9l47g2eD5c7gqKb/4xuz/kORIL44McIMi2EFFiVT9QgHThWeyUg0UXRm45
         X5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697658426; x=1698263226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLYRVhjiiCAR5NlBeW4PZhPgUBi+QF64GvuGWJOkciM=;
        b=LlNXtbsQCUW2up4hkPHoKFdBFfPZizL7hEtyF/6CuYPtYLkybmRLjIdHDtE/TN9vWJ
         ZB0kq2oYr1+4j2efvoI21tPAwd+b8ak9NagwLAx3NFlTgLDHTe+vIPJXsO3bvcjOs0lZ
         I7K0RzZHHkeL0uu+UB1l9H6n0jKzVuWBWTzUexJu8VHbjJWCbv5tWRHc093bQKhXyo1b
         5Ea7uI1g6CyBb/xn1LCRRE9CGNvxmX09UaCnY8J9Q5/kRvuEp5o5EMABm2A4bKtT7UIW
         aEnpimnDX3utWuZt+iK8AyaIUu7UHD98j5SW1XWKS5hbMUaCQPO5hmkbLvg8i5KCMaHW
         j49A==
X-Gm-Message-State: AOJu0YwUzsno93c9v1DW3A827hIgIGNBvSMN/lYvdqUNDeLdaGaDNiNG
        YzFyliTPXw+BHieX3tccUGk=
X-Google-Smtp-Source: AGHT+IFq8SAUCcmVlpQGElv+BMyPHFtyxBHljIg8rQM6bl1JzamBZvmLTXbsdrKkjnCC5AuHBeIJtA==
X-Received: by 2002:a05:6359:308b:b0:143:3a49:e30d with SMTP id rg11-20020a056359308b00b001433a49e30dmr5134552rwb.12.1697658426121;
        Wed, 18 Oct 2023 12:47:06 -0700 (PDT)
Received: from ubuntu ([223.226.54.200])
        by smtp.gmail.com with ESMTPSA id q4-20020aa78424000000b006b2b53de98esm3703988pfn.75.2023.10.18.12.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 12:47:05 -0700 (PDT)
Date:   Wed, 18 Oct 2023 12:47:01 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Coiby Xu <coiby.xu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kumaran.4353@gmail.com
Subject: [PATCH v2 2/2] staging: qlge: Prefer using the BIT macro
Message-ID: <1bab82b0406a0206f8c85f7cc87e5ea554a9781b.1697657604.git.nandhakumar.singaram@gmail.com>
References: <cover.1697657604.git.nandhakumar.singaram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697657604.git.nandhakumar.singaram@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the occurrences of (1<<x) by BIT(x) in the files under qlge driver
to get rid of checkpatch.pl "CHECK" output "Prefer using the BIT macro"

Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
---
 drivers/staging/qlge/qlge_main.c | 8 ++++----
 drivers/staging/qlge/qlge_mpi.c  | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/qlge/qlge_main.c b/drivers/staging/qlge/qlge_main.c
index 1ead7793062a..9f67e44123cc 100644
--- a/drivers/staging/qlge/qlge_main.c
+++ b/drivers/staging/qlge/qlge_main.c
@@ -2191,7 +2191,7 @@ static int qlge_napi_poll_msix(struct napi_struct *napi, int budget)
 		/* If this TX completion ring belongs to this vector and
 		 * it's not empty then service it.
 		 */
-		if ((ctx->irq_mask & (1 << trx_ring->cq_id)) &&
+		if ((ctx->irq_mask & BIT(trx_ring->cq_id)) &&
 		    (qlge_read_sh_reg(trx_ring->prod_idx_sh_reg) !=
 		     trx_ring->cnsmr_idx)) {
 			netif_printk(qdev, intr, KERN_DEBUG, qdev->ndev,
@@ -3222,13 +3222,13 @@ static void qlge_set_irq_mask(struct qlge_adapter *qdev, struct intr_context *ct
 		/* Add the RSS ring serviced by this vector
 		 * to the mask.
 		 */
-		ctx->irq_mask = (1 << qdev->rx_ring[vect].cq_id);
+		ctx->irq_mask = BIT(qdev->rx_ring[vect].cq_id);
 		/* Add the TX ring(s) serviced by this vector
 		 * to the mask.
 		 */
 		for (j = 0; j < tx_rings_per_vector; j++) {
 			ctx->irq_mask |=
-				(1 << qdev->rx_ring[qdev->rss_ring_count +
+				BIT(qdev->rx_ring[qdev->rss_ring_count +
 				 (vect * tx_rings_per_vector) + j].cq_id);
 		}
 	} else {
@@ -3236,7 +3236,7 @@ static void qlge_set_irq_mask(struct qlge_adapter *qdev, struct intr_context *ct
 		 * ID into the mask.
 		 */
 		for (j = 0; j < qdev->rx_ring_count; j++)
-			ctx->irq_mask |= (1 << qdev->rx_ring[j].cq_id);
+			ctx->irq_mask |= BIT(qdev->rx_ring[j].cq_id);
 	}
 }
 
diff --git a/drivers/staging/qlge/qlge_mpi.c b/drivers/staging/qlge/qlge_mpi.c
index 96a4de6d2b34..ce0b54603071 100644
--- a/drivers/staging/qlge/qlge_mpi.c
+++ b/drivers/staging/qlge/qlge_mpi.c
@@ -113,7 +113,7 @@ int qlge_own_firmware(struct qlge_adapter *qdev)
 	 * core dump and firmware reset after an error.
 	 */
 	temp =  qlge_read32(qdev, STS);
-	if (!(temp & (1 << (8 + qdev->alt_func))))
+	if (!(temp & BIT((8 + qdev->alt_func))))
 		return 1;
 
 	return 0;
-- 
2.25.1

