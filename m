Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5197C93DE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 11:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjJNJak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 05:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjJNJae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 05:30:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B68C9;
        Sat, 14 Oct 2023 02:30:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32d895584f1so2545285f8f.1;
        Sat, 14 Oct 2023 02:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697275830; x=1697880630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6koVxPtzrD7o9FAQB6V+JanZ/7Pr8hCJXGDCNd80ek=;
        b=eur3aLFkxrOjy9chQTJcDwiRqTtYFWbbQ7IgUoQiYszOocEh9InZXGfGEcrDMs9QnH
         ve9nw0PqvHGBS7THjENKXQCpiRJBkgfdmxPiOsc2LOVsgu+3X86Il7EMrEIgIPd1rEVg
         d5f1Q4MxDSwDUPk71mAdjU2d+bTQhmCE09ew+YHEAJ3jfs9L9ivCev1/4z7pNeozcC3b
         Cn5wW4dvlSCl1iYEGOSVh/J+CilVAh/8BTp24QthuUQjFpUX0OYhSqfoTOH9Z0yYxesU
         eoLOHs6CDrLQp/hOCdMwjnfGmoReQv6hAbmqFMJTAZTuXYgrmciABSpyBvs1wiezoK3u
         JqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697275830; x=1697880630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6koVxPtzrD7o9FAQB6V+JanZ/7Pr8hCJXGDCNd80ek=;
        b=JcC/yfb6YuwMVUxFid0iY/tJplIF5qH8NV3bDAErPhpq0IhTTxHIEGWHxdZY4ObYSs
         K1HL+JEEvJh1UHOY76Csq6W6zmeL/C0OaogE64BdZiVlfKvzMm3oekw4Wsmvty2qyYbl
         qgNR1g3LsbcNqkRfA3HZeFD3KDqGOyX8/yd/Zi/k8hA/NUmFt/bIZvHnSdnPk07zm3b+
         42zkQvbrrmRf0lfD2nMwSqJw6Sokl9JF4L3n05eyMkeiQvMmE9fc4ozPjIPTTWxzcPV8
         j0yZU0NyrFZ18NKGbavgG3T/QfKZq72QtHxpEalIL94m6WGSl5tCgNoYdN5iZQUfm8kO
         iwEA==
X-Gm-Message-State: AOJu0YxiFudRBlc3RhvhggxUt4GjZIInJNX3yVnsby/xA39rJlRzYUj8
        17MQR/9NwMjUwfsRv08IB/s=
X-Google-Smtp-Source: AGHT+IEa/pVJV1zL9u/NKupVwJHsJkUXFtiQ+cU99ZvrzOeJOLZfsWnPZtcfpWn30eqTT8jSQ+kE6w==
X-Received: by 2002:a05:6000:1946:b0:327:e073:d604 with SMTP id e6-20020a056000194600b00327e073d604mr22673813wry.45.1697275830092;
        Sat, 14 Oct 2023 02:30:30 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id u12-20020adff88c000000b0032d9a1f2ec3sm3691564wrp.27.2023.10.14.02.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 02:30:29 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Simon Horman <horms@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v3 3/4] net: stmmac: move TX timer arm after DMA enable
Date:   Sat, 14 Oct 2023 11:29:53 +0200
Message-Id: <20231014092954.1850-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231014092954.1850-1-ansuelsmth@gmail.com>
References: <20231014092954.1850-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move TX timer arm call after DMA interrupt is enabled again.

The TX timer arm function changed logic and now is skipped if a napi is
already scheduled. By moving the TX timer arm call after DMA is enabled,
we permit to correctly skip if a DMA interrupt has been fired and a napi
has been scheduled again.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 5124ee87286c..240a18b97825 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2545,7 +2545,8 @@ static void stmmac_bump_dma_threshold(struct stmmac_priv *priv, u32 chan)
  * @queue: TX queue index
  * Description: it reclaims the transmit resources after transmission completes.
  */
-static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
+static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
+			   bool *pending_packets)
 {
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
 	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[queue];
@@ -2706,7 +2707,7 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
 
 	/* We still have pending packets, let's call for a new scheduling */
 	if (tx_q->dirty_tx != tx_q->cur_tx)
-		stmmac_tx_timer_arm(priv, queue);
+		*pending_packets = true;
 
 	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
 	txq_stats->tx_packets += tx_packets;
@@ -5572,6 +5573,7 @@ static int stmmac_napi_poll_tx(struct napi_struct *napi, int budget)
 		container_of(napi, struct stmmac_channel, tx_napi);
 	struct stmmac_priv *priv = ch->priv_data;
 	struct stmmac_txq_stats *txq_stats;
+	bool pending_packets = false;
 	u32 chan = ch->index;
 	unsigned long flags;
 	int work_done;
@@ -5581,7 +5583,7 @@ static int stmmac_napi_poll_tx(struct napi_struct *napi, int budget)
 	txq_stats->napi_poll++;
 	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
 
-	work_done = stmmac_tx_clean(priv, budget, chan);
+	work_done = stmmac_tx_clean(priv, budget, chan, &pending_packets);
 	work_done = min(work_done, budget);
 
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
@@ -5592,6 +5594,10 @@ static int stmmac_napi_poll_tx(struct napi_struct *napi, int budget)
 		spin_unlock_irqrestore(&ch->lock, flags);
 	}
 
+	/* TX still have packet to handle, check if we need to arm tx timer */
+	if (pending_packets)
+		stmmac_tx_timer_arm(priv, chan);
+
 	return work_done;
 }
 
@@ -5600,6 +5606,7 @@ static int stmmac_napi_poll_rxtx(struct napi_struct *napi, int budget)
 	struct stmmac_channel *ch =
 		container_of(napi, struct stmmac_channel, rxtx_napi);
 	struct stmmac_priv *priv = ch->priv_data;
+	bool tx_pending_packets = false;
 	int rx_done, tx_done, rxtx_done;
 	struct stmmac_rxq_stats *rxq_stats;
 	struct stmmac_txq_stats *txq_stats;
@@ -5616,7 +5623,7 @@ static int stmmac_napi_poll_rxtx(struct napi_struct *napi, int budget)
 	txq_stats->napi_poll++;
 	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
 
-	tx_done = stmmac_tx_clean(priv, budget, chan);
+	tx_done = stmmac_tx_clean(priv, budget, chan, &tx_pending_packets);
 	tx_done = min(tx_done, budget);
 
 	rx_done = stmmac_rx_zc(priv, budget, chan);
@@ -5641,6 +5648,10 @@ static int stmmac_napi_poll_rxtx(struct napi_struct *napi, int budget)
 		spin_unlock_irqrestore(&ch->lock, flags);
 	}
 
+	/* TX still have packet to handle, check if we need to arm tx timer */
+	if (tx_pending_packets)
+		stmmac_tx_timer_arm(priv, chan);
+
 	return min(rxtx_done, budget - 1);
 }
 
-- 
2.40.1

