Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFDE7B549D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbjJBOIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbjJBOIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:08:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC059B;
        Mon,  2 Oct 2023 07:08:33 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so169895375e9.2;
        Mon, 02 Oct 2023 07:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696255712; x=1696860512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cTarZETHcAW0O9gfgdeOmaYr0S0MXF7s2VIEeHUmcR4=;
        b=SJje1GeqxE8qTzdXRLfHvTodMBGbPVSReWgR1T910IUdNMUQQsMR71fugaZ3+N8q7/
         x5A2O3bt2bx90rcM/Yhj3nkZgF41jGILmalbsJCiWLQEjOnlpdrzeIyF5Cnuc3y6XR6Z
         A0hP78El6h6XnKOj67c4NgXWNAhJdHo/Dd4A0KzYT1CPdGHMZiP9bbZ+kCg++Hc9frGw
         EwMuoovrjyWhUlpnYcQ6CJSvx1FGsuwwbJt6DwVAqmjdElHIckYAExfngPCu322skAH9
         WSch4LylOqH4Lxu0IMHfLK9VaMYEtRtzTVENEIpu/ZGrePR/36/zyV+JZfD9iZjRlpOs
         Uqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696255712; x=1696860512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTarZETHcAW0O9gfgdeOmaYr0S0MXF7s2VIEeHUmcR4=;
        b=D6qdVBYtq/hXzXPn2R+z3ZwdjBuDUYj/MIe3hECasXoWplGaOQD19/B6EEa1iIXCzK
         +mHMfT0+MyvFjJO/HFaE5bWXD9rYQ1WWtXyY9bg39fbSKcEXloRvjDxbNUVcAFXnRLqH
         QAshxzFchJkeSENeZ3m+JarQbK/jmoo2++b2o36ALAmcbpIvuIt2bIQfjcQetME2EqRe
         cr1YI4ZTtvFB13DJ5N+vPAqxjHnaywq1HKk/Z4qWHiqC77/LrYzBA4Y4p7pVuMUY8XnT
         msKULqj6SDws7d0px7R/2Y+EHlwChBfXpCHHvT5qZUbMg2xBSK7UAhKUJ8fBVYOqYg5P
         EI2w==
X-Gm-Message-State: AOJu0Yw52gWk7d89Jg0QyOK7V+H9IYwWprfz9qm63dI7gtaY3qd+SXn9
        n6Y9gQYdXbSQCyu5HxIfJ18=
X-Google-Smtp-Source: AGHT+IHTjP7xN/k5l+ale+TeCr5ZaZiwPFG0fqsQfhW/XlK6NBRW1AXXmqSYhc7YJirO93LThQiL2A==
X-Received: by 2002:a7b:ce09:0:b0:405:3dbc:8821 with SMTP id m9-20020a7bce09000000b004053dbc8821mr9371184wmc.22.1696255711367;
        Mon, 02 Oct 2023 07:08:31 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id d29-20020adfa41d000000b003197869bcd7sm23150227wra.13.2023.10.02.07.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 07:08:31 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Lee <igvtee@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>, stable@vger.kernel.org
Subject: [net PATCH] net: ethernet: mediatek: disable irq before schedule napi
Date:   Mon,  2 Oct 2023 16:08:05 +0200
Message-Id: <20231002140805.568-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
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

While searching for possible refactor of napi_schedule_prep and
__napi_schedule it was notice that the mtk eth driver disable the
interrupt for rx and tx AFTER napi is scheduled.

While this is a very hard to repro case it might happen to have
situation where the interrupt is disabled and never enabled again as the
napi completes and the interrupt is enabled before.

This is caused by the fact that a napi driven by interrupt expect a
logic with:
1. interrupt received. napi prepared -> interrupt disabled -> napi
   scheduled
2. napi triggered. ring cleared -> interrupt enabled -> wait for new
   interrupt

To prevent this case, disable the interrupt BEFORE the napi is
scheduled.

Fixes: 656e705243fd ("net-next: mediatek: add support for MT7623 ethernet")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 82b51072aad8..7669b446915a 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3172,8 +3172,8 @@ static irqreturn_t mtk_handle_irq_rx(int irq, void *_eth)
 
 	eth->rx_events++;
 	if (likely(napi_schedule_prep(&eth->rx_napi))) {
-		__napi_schedule(&eth->rx_napi);
 		mtk_rx_irq_disable(eth, eth->soc->txrx.rx_irq_done_mask);
+		__napi_schedule(&eth->rx_napi);
 	}
 
 	return IRQ_HANDLED;
@@ -3185,8 +3185,8 @@ static irqreturn_t mtk_handle_irq_tx(int irq, void *_eth)
 
 	eth->tx_events++;
 	if (likely(napi_schedule_prep(&eth->tx_napi))) {
-		__napi_schedule(&eth->tx_napi);
 		mtk_tx_irq_disable(eth, MTK_TX_DONE_INT);
+		__napi_schedule(&eth->tx_napi);
 	}
 
 	return IRQ_HANDLED;
-- 
2.40.1

