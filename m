Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D1D7B47A9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbjJANog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbjJANof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:44:35 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B62E5
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:44:32 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52f1ece3a76so4227362a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 06:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696167870; x=1696772670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ym31JZcesETa7AS2f1umn/B+sSEpEuK3mEbxds3x3JU=;
        b=FR0F59Po9/alv7OBvUB5uBSPYOZJTl2FmjKNXha64wsmsV0UAgc2WCo4zy/Pi/d1Zo
         khivLauYZTrR9gCPQPy1z1RyZvTqlbNkFif69HHNgjs4cTb0f8Bl22Ak1zz8mRy/mfz2
         OpFVQItLWlhLmyhNFlkTqIVAJTRmcK1n6jG53NumkztWeVXkA76X971sXvqi4L/VZW0x
         MHWC2Nwp7+AGPCXu4GTOxZHmbDl3W/l6yXHkdcwcty+2mIBnAqczPhPrC8moW7rVXi16
         5xplX1Ued5Qq9YNKuS72rX24nN8yVZ7cPfG5cHfdpQOoEGsNSvR3JrcaB4ZjzERgzTal
         53XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696167870; x=1696772670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ym31JZcesETa7AS2f1umn/B+sSEpEuK3mEbxds3x3JU=;
        b=TQs/76+XdejAqXEuwOoiaROxoOZrpCjUNeqf01ZugXK41e7lKYs6Eypyol+8uM1nMO
         v2xSUA3iNBD8Zxnyt3NNu1VIVw3Ww7FnkK3TQ5kSetlYI12yBIeFkW1hH7AzbDXhtgtu
         X+ayOzGY3rvmev7Qj1ZMwaLp93dXwjEHkTkZEgdJgeMubC+G0nQKiHgzlWxr68S4WGXr
         1zLdfoggoUo2hEm5Y3SdVLskFWp84fCm6brzFMZ0uAV1lH+w29UBqc7CaE8sfinSek1V
         fVNOPpYkYLS77CyIJGmBIfR181Sjna5mGU9TeA+XwExpxKX+Jz/02Q2pKIgTxS/xdQ81
         DU+w==
X-Gm-Message-State: AOJu0YzYaYWU+Ijj8+dXw5gHuyvubmFdLFIOH5JW6EwTfCzI7odvZe0r
        0+ytynmHeyvprJg5AIN9V9w=
X-Google-Smtp-Source: AGHT+IHCNDyM0yg+CQz5dfSM+EKe4Pd0E59Hd3zoNa1XRQq0Z9Lrjh/ux+e26rZ84y08df6ru7jkGQ==
X-Received: by 2002:a17:906:74d4:b0:9ad:dfe7:b361 with SMTP id z20-20020a17090674d400b009addfe7b361mr6959151ejl.5.1696167870325;
        Sun, 01 Oct 2023 06:44:30 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id i22-20020a17090671d600b009a193a5acffsm15232229ejk.121.2023.10.01.06.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 06:44:30 -0700 (PDT)
Date:   Sun, 1 Oct 2023 15:44:28 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] staging: rtl8192e: Remove broken function
 _rtl92e_if_silent_reset()
Message-ID: <8b1b04b512b5691968a49308fdc052973fbe5032.1696165351.git.philipp.g.hortmann@gmail.com>
References: <cover.1696165351.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696165351.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the function _rtl92e_if_silent_reset() is called the variable
priv->rst_progress is set to RESET_TYPE_SILENT.
Since priv->up is always true the function is left at "if (priv->up) {"
without resetting. Now the function _rtl92e_if_silent_reset() is like
deactivated because the equation at the very beginning is false:
"if (priv->rst_progress == RESET_TYPE_NORESET) {"
This leads to a state where the driver hangs in the reset state and
cannot go forward.
In 30% of the cases the wlan is disconnected and cannot reconnect. The
rest of the time it continues working but no reset is done at all.
Further requests for reset are ignored. Remove broken function
_rtl92e_if_silent_reset() and remove return value of
_rtl92e_if_check_reset() to avoid compiler warnings.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 113 +------------------
 1 file changed, 3 insertions(+), 110 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 11d20fc11a7d..43533410f8d6 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -958,7 +958,7 @@ static enum reset_type _rtl92e_rx_check_stuck(struct net_device *dev)
 	return RESET_TYPE_NORESET;
 }
 
-static enum reset_type _rtl92e_if_check_reset(struct net_device *dev)
+static void _rtl92e_if_check_reset(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	enum reset_type TxResetType = RESET_TYPE_NORESET;
@@ -979,112 +979,8 @@ static enum reset_type _rtl92e_if_check_reset(struct net_device *dev)
 		   RxResetType == RESET_TYPE_SILENT) {
 		netdev_info(dev, "%s(): TxResetType is %d, RxResetType is %d\n",
 			    __func__, TxResetType, RxResetType);
-		return RESET_TYPE_SILENT;
-	} else {
-		return RESET_TYPE_NORESET;
-	}
-}
-
-static void _rtl92e_if_silent_reset(struct net_device *dev)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-	u8	reset_times = 0;
-	int reset_status = 0;
-	struct rtllib_device *ieee = priv->rtllib;
-	unsigned long flag;
-
-	if (priv->rst_progress == RESET_TYPE_NORESET) {
-		priv->rst_progress = RESET_TYPE_SILENT;
-
-		spin_lock_irqsave(&priv->rf_ps_lock, flag);
-		if (priv->rf_change_in_progress) {
-			spin_unlock_irqrestore(&priv->rf_ps_lock, flag);
-			goto END;
-		}
-		priv->rf_change_in_progress = true;
-		priv->reset_in_progress = true;
-		spin_unlock_irqrestore(&priv->rf_ps_lock, flag);
-
-RESET_START:
-
-		mutex_lock(&priv->wx_mutex);
-
-		if (priv->rtllib->link_state == MAC80211_LINKED)
-			rtl92e_leisure_ps_leave(dev);
-
-		if (priv->up) {
-			netdev_info(dev, "%s():the driver is not up.\n",
-				    __func__);
-			mutex_unlock(&priv->wx_mutex);
-			return;
-		}
-		priv->up = 0;
-
-		mdelay(1000);
-
-		if (!netif_queue_stopped(dev))
-			netif_stop_queue(dev);
-
-		rtl92e_irq_disable(dev);
-		del_timer_sync(&priv->watch_dog_timer);
-		_rtl92e_cancel_deferred_work(priv);
-		rtl92e_dm_deinit(dev);
-		rtllib_stop_scan_syncro(ieee);
-
-		if (ieee->link_state == MAC80211_LINKED) {
-			mutex_lock(&ieee->wx_mutex);
-			netdev_info(dev, "ieee->link_state is MAC80211_LINKED\n");
-			del_timer_sync(&ieee->associate_timer);
-			cancel_delayed_work(&ieee->associate_retry_wq);
-			rtllib_stop_scan(ieee);
-			netif_carrier_off(dev);
-			mutex_unlock(&ieee->wx_mutex);
-		} else {
-			netdev_info(dev, "ieee->link_state is NOT LINKED\n");
-			rtllib_softmac_stop_protocol(priv->rtllib, 0, true);
-		}
-
-		rtl92e_dm_backup_state(dev);
-
-		mutex_unlock(&priv->wx_mutex);
-		reset_status = _rtl92e_up(dev, true);
-
-		if (reset_status == -1) {
-			if (reset_times < 3) {
-				reset_times++;
-				goto RESET_START;
-			} else {
-				netdev_warn(dev, "%s():	Reset Failed\n",
-					    __func__);
-			}
-		}
-
-		ieee->is_silent_reset = 1;
-
-		spin_lock_irqsave(&priv->rf_ps_lock, flag);
-		priv->rf_change_in_progress = false;
-		spin_unlock_irqrestore(&priv->rf_ps_lock, flag);
-
-		rtl92e_enable_hw_security_config(dev);
-
-		if (ieee->link_state == MAC80211_LINKED && ieee->iw_mode ==
-		    IW_MODE_INFRA) {
-			ieee->set_chan(ieee->dev,
-				       ieee->current_network.channel);
-
-			schedule_work(&ieee->associate_complete_wq);
-
-		}
-
-		rtl92e_cam_restore(dev);
-		rtl92e_dm_restore_state(dev);
-END:
-		priv->rst_progress = RESET_TYPE_NORESET;
-		priv->reset_count++;
-		priv->reset_in_progress = false;
-
-		rtl92e_writeb(dev, UFWP, 1);
 	}
+	return;
 }
 
 static void _rtl92e_update_rxcounts(struct r8192_priv *priv, u32 *TotalRxBcnNum,
@@ -1114,7 +1010,6 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 				  struct r8192_priv, watch_dog_wq);
 	struct net_device *dev = priv->rtllib->dev;
 	struct rtllib_device *ieee = priv->rtllib;
-	enum reset_type ResetType = RESET_TYPE_NORESET;
 	static u8 check_reset_cnt;
 	unsigned long flags;
 	struct rt_pwr_save_ctrl *psc = (struct rt_pwr_save_ctrl *)
@@ -1232,13 +1127,11 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	spin_lock_irqsave(&priv->tx_lock, flags);
 	if ((check_reset_cnt++ >= 3) && (!ieee->is_roaming) &&
 	    (!priv->rf_change_in_progress) && (!psc->bSwRfProcessing)) {
-		ResetType = _rtl92e_if_check_reset(dev);
+		_rtl92e_if_check_reset(dev);
 		check_reset_cnt = 3;
 	}
 	spin_unlock_irqrestore(&priv->tx_lock, flags);
 
-	if ((priv->force_reset || ResetType == RESET_TYPE_SILENT))
-		_rtl92e_if_silent_reset(dev);
 	priv->force_reset = false;
 	priv->reset_in_progress = false;
 }
-- 
2.42.0

