Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7E57B598C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238371AbjJBRx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238484AbjJBRxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:53:23 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6DBDD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:53:18 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ae3d4c136fso457404866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696269197; x=1696873997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2MaU5uH1ibxilRt8t8r3fgvnKByywWaocqW4N/d4Gzk=;
        b=SoxOy1emnlmR6h+G/1RKdiyoGG/2BXnp/xryRjnZBYh2LlS5X0IJPD3MxuVAc/KkSc
         jljs40wn4+5HTbj9ppB0FVJhFHA052kDeoC3XKMSPJ1nJ5863x79aEv1MOqSaeA8uRFL
         7qKxTa50IZAthOa5JP4dqjgqNEfT4P8KofzjdV9HrJb8EmzEY4im0nKlVeRn1uiJ8jU7
         VEZe8i8r7qTcSmwwvcyyudBsVECSLCcYFmjNVfYM0sVb42pPG5qjqt31BE8L/nRSAHGZ
         o5WTL3SQXS6+ybCWBYwbvr9qntX058CAyhEBzBm0oi8ErlkDYf/eaGid5K9milDFd9BC
         jb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269197; x=1696873997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MaU5uH1ibxilRt8t8r3fgvnKByywWaocqW4N/d4Gzk=;
        b=Ntwxex3p9WEdg0Qe4j7D6Zi0ZR/GKJOHOkFhK9kVFguDs+3lJxF0TQNG4S9cWT5xEH
         sK74uBXw3Eo1qn6JTTwnUYrxZmL7XLXKLCLfI9btIPbn0Txl8fgNpOVUpSDGnigO96Dk
         ToLXc0DEeYck0UDRA76XTcds1chmW//tzCXcrO172FoS27sKh3b5N3teIsFxSdvNu0FT
         1lIo7BV2v8qnQh6rzFbb3486KHCBFAd97WTGV6uytK+TOz1srpiqkZmI+1GeCMQlRzen
         LCuczoA6ErhGIqKq7jhPspElFJLY0t3c8lIDZay8dS8WufDjEUFkL0kMexdTygsLplg/
         ywsQ==
X-Gm-Message-State: AOJu0Yzjm+J7MUt1Tk3O4ackDDF4rV14cN65RkDLkxKuPMWrgOo3IQNP
        Uq5r2c3S6Wqs2wIuoighcWs=
X-Google-Smtp-Source: AGHT+IElZXi/rxyi2s/Mir1JaEEMtjtCsyT10UzRXdO6LgYTAhGKUql4RrYmRq8A6fUBMu4KSMxyqw==
X-Received: by 2002:a17:906:25d:b0:9ae:6552:4af6 with SMTP id 29-20020a170906025d00b009ae65524af6mr10156736ejl.1.1696269196905;
        Mon, 02 Oct 2023 10:53:16 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090685c800b009ad7fc17b2asm17457685ejy.224.2023.10.02.10.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:53:16 -0700 (PDT)
Date:   Mon, 2 Oct 2023 19:53:15 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] staging: rtl8192e: Remove unused function
 rtl92e_dm_restore_state()
Message-ID: <be2293f1e50993ae473130403b6150d04427576e.1696266964.git.philipp.g.hortmann@gmail.com>
References: <cover.1696266964.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696266964.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove rtl92e_dm_restore_state() as it is unused. Remove called functions
_rtl92e_dm_tx_power_reset_recovery() and
_rtl92e_dm_bb_initialgain_restore() as well.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 59 ----------------------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h |  1 -
 2 files changed, 60 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 5217ace3f140..8f5e4b932350 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -161,7 +161,6 @@ static	void	_rtl92e_dm_bandwidth_autoswitch(struct net_device *dev);
 
 static	void	_rtl92e_dm_check_tx_power_tracking(struct net_device *dev);
 
-static void _rtl92e_dm_bb_initialgain_restore(struct net_device *dev);
 static void _rtl92e_dm_dig_init(struct net_device *dev);
 static void _rtl92e_dm_ctrl_initgain_byrssi(struct net_device *dev);
 static void _rtl92e_dm_ctrl_initgain_byrssi_highpwr(struct net_device *dev);
@@ -915,64 +914,6 @@ void rtl92e_dm_cck_txpower_adjust(struct net_device *dev, bool binch14)
 		_rtl92e_dm_cck_tx_power_adjust_thermal_meter(dev, binch14);
 }
 
-static void _rtl92e_dm_tx_power_reset_recovery(struct net_device *dev)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-
-	rtl92e_set_bb_reg(dev, rOFDM0_XATxIQImbalance, bMaskDWord,
-			  dm_tx_bb_gain[priv->rfa_txpowertrackingindex]);
-	rtl92e_dm_cck_txpower_adjust(dev, priv->bcck_in_ch14);
-
-	rtl92e_set_bb_reg(dev, rOFDM0_XCTxIQImbalance, bMaskDWord,
-			  dm_tx_bb_gain[priv->rfc_txpowertrackingindex]);
-}
-
-void rtl92e_dm_restore_state(struct net_device *dev)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-	u32	reg_ratr = priv->rate_adaptive.last_ratr;
-	u32 ratr_value;
-
-	if (!priv->up)
-		return;
-
-	if (priv->rate_adaptive.rate_adaptive_disabled)
-		return;
-	if (priv->rtllib->mode != WIRELESS_MODE_N_24G)
-		return;
-	ratr_value = reg_ratr;
-	ratr_value &= ~(RATE_ALL_OFDM_2SS);
-	rtl92e_writel(dev, RATR0, ratr_value);
-	rtl92e_writeb(dev, UFWP, 1);
-	if (priv->tx_pwr_tracking_init && priv->btxpower_tracking)
-		_rtl92e_dm_tx_power_reset_recovery(dev);
-
-	_rtl92e_dm_bb_initialgain_restore(dev);
-}
-
-static void _rtl92e_dm_bb_initialgain_restore(struct net_device *dev)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-	u32 bit_mask = 0x7f;
-
-	if (dm_digtable.dig_algorithm == DIG_ALGO_BY_RSSI)
-		return;
-
-	rtl92e_set_bb_reg(dev, UFWP, bMaskByte1, 0x8);
-	rtl92e_set_bb_reg(dev, rOFDM0_XAAGCCore1, bit_mask,
-			  (u32)priv->initgain_backup.xaagccore1);
-	rtl92e_set_bb_reg(dev, rOFDM0_XBAGCCore1, bit_mask,
-			  (u32)priv->initgain_backup.xbagccore1);
-	rtl92e_set_bb_reg(dev, rOFDM0_XCAGCCore1, bit_mask,
-			  (u32)priv->initgain_backup.xcagccore1);
-	rtl92e_set_bb_reg(dev, rOFDM0_XDAGCCore1, bit_mask,
-			  (u32)priv->initgain_backup.xdagccore1);
-	bit_mask  = bMaskByte2;
-	rtl92e_set_bb_reg(dev, rCCK0_CCA, bit_mask,
-			  (u32)priv->initgain_backup.cca);
-	rtl92e_set_bb_reg(dev, UFWP, bMaskByte1, 0x1);
-}
-
 static void _rtl92e_dm_dig_init(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index 9085a6454cbc..5ae2bf467158 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -178,7 +178,6 @@ void    rtl92e_dm_txpower_tracking_wq(void *data);
 
 void rtl92e_dm_cck_txpower_adjust(struct net_device *dev, bool binch14);
 
-void    rtl92e_dm_restore_state(struct net_device *dev);
 void    rtl92e_dm_init_edca_turbo(struct net_device *dev);
 void    rtl92e_dm_rf_pathcheck_wq(void *data);
 void rtl92e_dm_init_txpower_tracking(struct net_device *dev);
-- 
2.42.0

