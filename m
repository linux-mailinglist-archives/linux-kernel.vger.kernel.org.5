Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0FB7CCBC6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344209AbjJQTG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbjJQTGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:06:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763C51B2;
        Tue, 17 Oct 2023 12:06:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b2018a11efso4197817b3a.0;
        Tue, 17 Oct 2023 12:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697569590; x=1698174390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X74HUdsW7jfV9HBl6W8q2e+Tb/QlaXmSgd9sDUUldmw=;
        b=aZJfQghfrHabId4SjASH9tUoByuq7Fe5DQ+B7lZOcddpqmiB+a0Rsfe7JxCV+VWLr+
         6ysIUI9wOWUO+S8YufvIg8gpeBI7QOFnw1EPLphQdHNQC9bCs3MpNxSGVZKeXYD4RfOj
         lZ9bqhBwo5Wvs2ScEJWW5Uv3yDc9jvuH/lW0gNwqOvuqw7ombJFDenbBoQlwR/D7YrTZ
         kc+UQcKytLw+Ps3sjTNCu/Ns9+jbbC2fZcSwtoYxxyek2lnNCb9aliIZPiuLa6hNNJC7
         ucsDeNs19PsL+whdNKAlYZ9KkAq3ZYeQntKj/ajjZgsBOPKFiVd3QYXbE0kiJA+gQ0Y4
         GsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569590; x=1698174390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X74HUdsW7jfV9HBl6W8q2e+Tb/QlaXmSgd9sDUUldmw=;
        b=uo2fLVygdR4uWkSzVC0ypFdn9Q/acYZOSdwdKnHHnZpHFCCubthOPoDuDH0fbdj7jS
         IZZaR44+vLnUbZOhWBEQmrMbT/VO3ZHcsolL4aKqRe7OlOJg5eiIX6BkI84VlolU1TFC
         C6BCopgFUOE+UrVOtuzfxaXgHUdvU5K62TbmQwGYwthBWFEIqgpvnU2YnPCPcIvJcxuK
         6w+zzMpuka0PYmNQ72Zuqj1m5kxP2BY+AWX/gxtPX5VAgKqH8ThagNRhTJ6X3UtD0wKq
         7uijgJYG1VP0SEzmmQoL5oSE67DuL/igTbqiNcSBoTBAfxBvNU/D3WdhRewh7cZjyBOO
         XJbg==
X-Gm-Message-State: AOJu0Yxnh5ulXRUq1wo5ILRiNE4KeSLt+N1Nn+DolqbrUKLqjBY3heGL
        CPM5FhDy4t0Pg/yMnmke4RY=
X-Google-Smtp-Source: AGHT+IEgCGqhRzHdz4LfOpgn9gY4BENB6Qs/KK0GimbsV+aw48rQBEvNseqyaKykuRW1FJ4sJSJ2KA==
X-Received: by 2002:a05:6a20:7f8d:b0:16a:b651:dcd6 with SMTP id d13-20020a056a207f8d00b0016ab651dcd6mr3842233pzj.7.1697569590237;
        Tue, 17 Oct 2023 12:06:30 -0700 (PDT)
Received: from ubuntu ([223.226.54.200])
        by smtp.gmail.com with ESMTPSA id pb11-20020a17090b3c0b00b002794fe14cabsm6879886pjb.12.2023.10.17.12.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:06:29 -0700 (PDT)
Date:   Tue, 17 Oct 2023 12:06:23 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Coiby Xu <coiby.xu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kumaran.4353@gmail.com
Subject: [PATCH 2/2] staging: qlge: Replace the occurrences of (1<<x) by
 BIT(x)
Message-ID: <5a962ea2ab9a40b1da11d95cdaf990002ffed7fa.1697568757.git.nandhakumar.singaram@gmail.com>
References: <cover.1697568757.git.nandhakumar.singaram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697568757.git.nandhakumar.singaram@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to linux coding style. Replace the occurrences of
(1<<x) by BIT(x)

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

