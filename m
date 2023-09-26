Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D8A7AF06E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbjIZQPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjIZQPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:15:51 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DB5EB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:15:44 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5809d5fe7f7so3575459a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695744944; x=1696349744; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRdqgJyQK3irEtjIY1sArYtpNHn/PRA/0ZX748jQzQY=;
        b=bu2VYweTHprrVlbLyI9oJpJHMlvU3jTbkmRs3/fc9GaNb3nC+0JVmdfJtTwIV+wH+d
         KKa0cDBuTusQa8FLmC0PGvSJcLwgIh7HiL0W8HZqcZXpym2MvIKsMXaIVnB115MSMAgk
         4w+GUpEcHsbb8HHJgQcKfSRbU6SP1eSKI2Hm43lnYYE1ik43mUjgiZN3zbJAuz8fNT9x
         s13VoKRZQaJ7PEEuJdbolH2/vlSSt8rdX2EcG8s8FWwHpRJcAYIkoS8v1NX5GkK6QyZ1
         nuGw7HJ+DwV5yoYifeLpO3CKx8uqMpL8nCbLBp/nyojvXut48RHCKTEsm0y3NGeJV9Y2
         qGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695744944; x=1696349744;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRdqgJyQK3irEtjIY1sArYtpNHn/PRA/0ZX748jQzQY=;
        b=MUXj9u78KmfP769JszEoVWs7VzNBsAyPGBy6xg3hDvX9K6NSZHI/1vXxBH1FDF9v5C
         wlugPw8+zYs8GeaCJ2p3FX4MKQvcHq7j8HHK4+7PE8dEaMBIp/FoH2M9kfUXkzgkENlx
         WOGoHlSTaVrMToq6SVpPUEg0iEtLLIGyABVqMGvQQc2fV/YS8D2wnHYzWoSDA04M4/U8
         aXnJsL3jEqYbe3B/IFlxCvcT8/XnlxUdtUCPYyELIrf5CTdzKdrc30RzrKE7OemkMfVy
         AU3AeI03r2DmowXdoQav0cspUkyqRRiYq1Zdeb2SG1HfjZ0DdiP0G5sNgRUUsAONfeGw
         3DqQ==
X-Gm-Message-State: AOJu0YzY3Uf3FjHmprg6jrqlZJAlAjfrwGomLd8/XqaSo3s5yFb4G4cx
        fDusatzFqZlVZ93y2RRd2LQ=
X-Google-Smtp-Source: AGHT+IFXLvCotTkZMZBPmnG02w7NedZk/zhSuvc2WviLKsRzD4FgX7KWHq4bVqvEckO2k6XogENstw==
X-Received: by 2002:a05:6a20:9383:b0:14b:8023:33c8 with SMTP id x3-20020a056a20938300b0014b802333c8mr8948104pzh.2.1695744943745;
        Tue, 26 Sep 2023 09:15:43 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id i13-20020aa78d8d000000b00689f8dc26c2sm10132400pfr.133.2023.09.26.09.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 09:15:42 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     gregkh@linuxfoundation.org, kamrankhadijadj@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] staging: ks7010: disable bh on tx_dev_lock
Date:   Tue, 26 Sep 2023 16:13:23 +0000
Message-Id: <20230926161323.41928-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As &priv->tx_dev.tx_dev_lock is also acquired by xmit callback which
could be call from timer under softirq context, use spin_lock_bh()
on it to prevent potential deadlock.

hostif_sme_work()
--> hostif_sme_set_pmksa()
--> hostif_mib_set_request()
--> ks_wlan_hw_tx()
--> spin_lock(&priv->tx_dev.tx_dev_lock)

ks_wlan_start_xmit()
--> hostif_data_request()
--> ks_wlan_hw_tx()
--> spin_lock(&priv->tx_dev.tx_dev_lock)

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/staging/ks7010/ks7010_sdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index 9fb118e77a1f..f1d44e4955fc 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -395,9 +395,9 @@ int ks_wlan_hw_tx(struct ks_wlan_private *priv, void *p, unsigned long size,
 	priv->hostt.buff[priv->hostt.qtail] = le16_to_cpu(hdr->event);
 	priv->hostt.qtail = (priv->hostt.qtail + 1) % SME_EVENT_BUFF_SIZE;
 
-	spin_lock(&priv->tx_dev.tx_dev_lock);
+	spin_lock_bh(&priv->tx_dev.tx_dev_lock);
 	result = enqueue_txdev(priv, p, size, complete_handler, skb);
-	spin_unlock(&priv->tx_dev.tx_dev_lock);
+	spin_unlock_bh(&priv->tx_dev.tx_dev_lock);
 
 	if (txq_has_space(priv))
 		queue_delayed_work(priv->wq, &priv->rw_dwork, 0);
-- 
2.17.1

