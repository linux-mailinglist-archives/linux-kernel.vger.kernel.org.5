Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1129A7BBF76
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjJFTEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbjJFTEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:04:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD299C5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 12:04:42 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-533c71c5f37so782333a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 12:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696619081; x=1697223881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YfQMCkdJny7ABVgnCi1T0mf+3QH6oGYzepXmVa+U+pQ=;
        b=nnZbsMeFtuz6Q8B9SDpx7Sba47L1+G5tiXV8SoO55B3/Uivl357TD6XonO74UEaAX+
         DccJKzGDJ57lh6g2xo365s40PSnJse1ImtiQdjUlOf8kwINWyrd4F4fg/nagA4ldTiXq
         6txu/0l3n/XMmrW7T30rFv4OiaKdVpntPxbFpETECtxhZCLonRIoBB57CASDzFJsDwE1
         qWLY2IMIcTB5XduU2MXH5Es9asgbm6nPjYyN/YjJre5Rs6cuWbXz2zF//AhCDXRfvoWT
         RgV79qOZ2cbmcvpgoiXs+GH2FMr1iz0lRI98nbcPc7oygk+eubpPIixNobyhk5on51TZ
         Y8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696619081; x=1697223881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfQMCkdJny7ABVgnCi1T0mf+3QH6oGYzepXmVa+U+pQ=;
        b=QpEhTKAE8IjpddNdBuGX+Td53tP53UMFQO3mA1/vO9m9cvgCHGynTtkqv5mkujMOSc
         7YaU4NTRgyIzntAGjYtgrDh98vmHca7XACIkjpQbyl7XnomIQk/i7BPHD4VhaZZKdQJS
         QNrLM+yHTawJTuJto+3Dxz+41ob7m+oIoMqHpxAKGmpLUv7+29gU+5yMcn0gLfXp9b9E
         whdnFMwRFhDhHTLZ1/QvBjz0F555nfitK/SNzaVW2WZxpiT4JytouWQfGyf6TEE6Mkjr
         foOnghgDy3FC0wvJzsv1EIOw4CwGBff3LHR+yj3juqQ4Mo6sbDmkke33RkOgzLvF5M/i
         JRYA==
X-Gm-Message-State: AOJu0YwIo96hcypZ6cmtl5TRjtijwhQUbMpsN1qs0Iuoqfyk0ZfhYxAA
        cqwTleDbOUDt+OkUX5J4PrM=
X-Google-Smtp-Source: AGHT+IGfUdlu6WLFYTTHiQQyc65bESgM7TGzc0IjN0hdMypUa3bRKUZizsSthk0rXiE6ydKb64e0vA==
X-Received: by 2002:a05:6402:190f:b0:523:220e:a6ca with SMTP id e15-20020a056402190f00b00523220ea6camr9284075edz.3.1696619080370;
        Fri, 06 Oct 2023 12:04:40 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id m10-20020aa7c2ca000000b00537fee52351sm2942875edp.28.2023.10.06.12.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 12:04:40 -0700 (PDT)
Date:   Fri, 6 Oct 2023 21:04:38 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] staging: rtl8192e: Remove function
 _rtl92e_wx_set_force_lps()
Message-ID: <833ccd9d1eee1a350f7801d86116e465b3713327.1696548527.git.philipp.g.hortmann@gmail.com>
References: <cover.1696548527.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696548527.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function _rtl92e_wx_set_force_lps() as this functionality is not
commonly used and the tool to access it is deprecated.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   | 23 +-------------------
 2 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 922231274f4b..4b2ee1684dac 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -370,7 +370,6 @@ struct r8192_priv {
 
 	u16		tx_counter;
 	u16		rx_ctr;
-	bool		force_lps;
 };
 
 extern const struct ethtool_ops rtl819x_ethtool_ops;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index c367e4fa2af1..a85caabcaf6c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -133,7 +133,7 @@ static int _rtl92e_wx_adapter_power_status(struct net_device *dev,
 
 	mutex_lock(&priv->wx_mutex);
 
-	if (*extra || priv->force_lps) {
+	if (*extra) {
 		priv->ps_force = false;
 		psc->bLeisurePs = true;
 	} else {
@@ -169,22 +169,6 @@ static int _rtl92e_wx_set_lps_awake_interval(struct net_device *dev,
 	return 0;
 }
 
-static int _rtl92e_wx_set_force_lps(struct net_device *dev,
-				    struct iw_request_info *info,
-				    union iwreq_data *wrqu, char *extra)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-
-	mutex_lock(&priv->wx_mutex);
-
-	netdev_info(dev,
-		    "%s(): force LPS ! extra is %d (1 is open 0 is close)\n",
-		    __func__, *extra);
-	priv->force_lps = *extra;
-	mutex_unlock(&priv->wx_mutex);
-	return 0;
-}
-
 static int _rtl92e_wx_set_debug(struct net_device *dev,
 				struct iw_request_info *info,
 				union iwreq_data *wrqu, char *extra)
@@ -970,10 +954,6 @@ static const struct iw_priv_args r8192_private_args[] = {
 		SIOCIWFIRSTPRIV + 0xa,
 		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, IW_PRIV_TYPE_NONE,
 		"lps_interv"
-	}, {
-		SIOCIWFIRSTPRIV + 0xb,
-		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, IW_PRIV_TYPE_NONE,
-		"lps_force"
 	}
 
 };
@@ -990,7 +970,6 @@ static iw_handler r8192_private_handler[] = {
 	(iw_handler)NULL,
 	(iw_handler)NULL,
 	(iw_handler)_rtl92e_wx_set_lps_awake_interval,
-	(iw_handler)_rtl92e_wx_set_force_lps,
 };
 
 static struct iw_statistics *_rtl92e_get_wireless_stats(struct net_device *dev)
-- 
2.42.0

