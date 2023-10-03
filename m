Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28BE7B71CC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240949AbjJCTdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240957AbjJCTdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:33:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BB9E8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:33:44 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9b27f99a356so44422266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696361623; x=1696966423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UFQqJ8FnoiDbXQTYRHGl9/H4vusMfHOBvbL9wqGrJ38=;
        b=MGG5wmR53DQOLU9H5/kh2c7rukUg3P5GlEJXQk1+vHi8FAvJwVXfHb8K/FKmwzWaFx
         qsJO/Lfvz7IxYZ5F6s1HnLOEz0pF1ErKAw9psBdjFd+ZfzCEfVgjQKzCZRFS5hFK8cDM
         1o1qnWDuZ760liqPxngO6jQiRAwe5/ycz/KMD807RPVmcSH/LLfdQUwfQqUA5MGM2ryr
         gK81XvEaKrvwL/D7iYrYt61fJ+lfIyQC1/UJsBZOmFxHxl80Y6oUYI/ex9nyDI19XaX+
         Hm2oI6qBuzek0efiwRoXmwWYOOaSQKXbJtKraF5jDf2f47bALi1dJ0XaNPhBq83cbK7a
         C68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361623; x=1696966423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFQqJ8FnoiDbXQTYRHGl9/H4vusMfHOBvbL9wqGrJ38=;
        b=Cowr+0tMbNjXVrG7h0OtL8a4uav/yT7zEHEeYnySke5GJpiLLm9jIeUekiGGZz+nJY
         F694lJTQTelKYMF/0TgmZt47bj6eJefCyK79MZ9t2KJ0ewyfpNbxXSF2G3Rdd4MYDqkz
         fKhLsXV8gjLme/W0v+KEuTdQwo2i2BwkY2GqoDaiTEfKxc/op5l9DzDmF/noSq9lkkLf
         QHh5DE5tJKwRyZu76cwcYtqY5Wh2WtfKgWH+/dG6mvYrVvjNcEuShxVCf2kY8nO8cfUW
         NyBS08lx8zQo1btjeoJb4+8NjC+1fLd0PC2HGAsuvxtoCIF1K+rSFEjt12qP9KAs9kj6
         mUPg==
X-Gm-Message-State: AOJu0YzG4Hm/bpjSnc4liIxsBXwk38Q4AzSkqsao2Gf4vUatGNk+vR3R
        TfiBTMN6EDkw6OOl9djLToifVBuUib0=
X-Google-Smtp-Source: AGHT+IH4AYER4e688ISlr0WZqOzbOyZdBBQyVL67QhBsYHL/n9LhNaolKHGGmZxBsp2V8wGoFQGcww==
X-Received: by 2002:a17:906:109e:b0:9a1:f96c:4bb9 with SMTP id u30-20020a170906109e00b009a1f96c4bb9mr77552eju.6.1696361623196;
        Tue, 03 Oct 2023 12:33:43 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id j24-20020a170906411800b009b65a698c16sm1489645ejk.220.2023.10.03.12.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 12:33:42 -0700 (PDT)
Date:   Tue, 3 Oct 2023 21:33:41 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] staging: rtl8192e: Remove function
 _rtl92e_wx_set_promisc_mode()
Message-ID: <d318afeae38f14db36da9f2b229ff61535b815c8.1696360404.git.philipp.g.hortmann@gmail.com>
References: <cover.1696360403.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696360403.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function _rtl92e_wx_set_promisc_mode() as this functionality is
not commonly used and the tool to access it is deprecated.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 47 +---------------------
 drivers/staging/rtl8192e/rtllib.h          |  4 +-
 drivers/staging/rtl8192e/rtllib_softmac.c  | 43 --------------------
 3 files changed, 2 insertions(+), 92 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index f28e70a0da4f..2f5acdd71339 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -918,48 +918,6 @@ static int _rtl92e_wx_get_gen_ie(struct net_device *dev,
 	return ret;
 }
 
-#define OID_RT_INTEL_PROMISCUOUS_MODE	0xFF0101F6
-
-static int _rtl92e_wx_set_promisc_mode(struct net_device *dev,
-				       struct iw_request_info *info,
-				       union iwreq_data *wrqu, char *extra)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rtllib_device *ieee = priv->rtllib;
-
-	u32 info_buf[3];
-
-	u32 oid;
-	u32 promiscuous_on;
-	u32 fltr_src_sta_frame;
-
-	if (copy_from_user(info_buf, wrqu->data.pointer, sizeof(info_buf)))
-		return -EFAULT;
-
-	oid = info_buf[0];
-	promiscuous_on = info_buf[1];
-	fltr_src_sta_frame = info_buf[2];
-
-	if (oid == OID_RT_INTEL_PROMISCUOUS_MODE) {
-		ieee->intel_promiscuous_md_info.promiscuous_on =
-					(promiscuous_on) ? (true) : (false);
-		ieee->intel_promiscuous_md_info.fltr_src_sta_frame =
-			(fltr_src_sta_frame) ? (true) : (false);
-		(promiscuous_on) ?
-		(rtllib_EnableIntelPromiscuousMode(dev, false)) :
-		(rtllib_DisableIntelPromiscuousMode(dev, false));
-
-		netdev_info(dev,
-			    "=======>%s(), on = %d, filter src sta = %d\n",
-			    __func__, promiscuous_on,
-			    fltr_src_sta_frame);
-	} else {
-		return -1;
-	}
-
-	return 0;
-}
-
 static int _rtl92e_wx_get_promisc_mode(struct net_device *dev,
 				       struct iw_request_info *info,
 				       union iwreq_data *wrqu, char *extra)
@@ -1037,9 +995,6 @@ static const struct iw_priv_args r8192_private_args[] = {
 		SIOCIWFIRSTPRIV + 0xb,
 		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, IW_PRIV_TYPE_NONE,
 		"lps_force"
-	}, {
-		SIOCIWFIRSTPRIV + 0x16,
-		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 3, 0, "setpromisc"
 	}, {
 		SIOCIWFIRSTPRIV + 0x17,
 		0, IW_PRIV_TYPE_CHAR | IW_PRIV_SIZE_FIXED | 45, "getpromisc"
@@ -1070,7 +1025,7 @@ static iw_handler r8192_private_handler[] = {
 	(iw_handler)NULL,
 	(iw_handler)NULL,
 	(iw_handler)NULL,
-	(iw_handler)_rtl92e_wx_set_promisc_mode,
+	(iw_handler)NULL,
 	(iw_handler)_rtl92e_wx_get_promisc_mode,
 };
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 546eedfeb43e..a02e8c976ca0 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1701,9 +1701,7 @@ void rtllib_stop_protocol(struct rtllib_device *ieee);
 
 void rtllib_EnableNetMonitorMode(struct net_device *dev, bool bInitState);
 void rtllib_DisableNetMonitorMode(struct net_device *dev, bool bInitState);
-void rtllib_EnableIntelPromiscuousMode(struct net_device *dev, bool bInitState);
-void rtllib_DisableIntelPromiscuousMode(struct net_device *dev,
-					bool bInitState);
+
 void rtllib_softmac_stop_protocol(struct rtllib_device *ieee);
 void rtllib_softmac_start_protocol(struct rtllib_device *ieee);
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 11395dbc9d4d..206f8e05d5d0 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -406,49 +406,6 @@ void rtllib_DisableNetMonitorMode(struct net_device *dev,
 	ieee->AllowAllDestAddrHandler(dev, false, !bInitState);
 }
 
-/* Enables the specialized promiscuous mode required by Intel.
- * In this mode, Intel intends to hear traffics from/to other STAs in the
- * same BSS. Therefore we don't have to disable checking BSSID and we only need
- * to allow all dest. BUT: if we enable checking BSSID then we can't recv
- * packets from other STA.
- */
-void rtllib_EnableIntelPromiscuousMode(struct net_device *dev,
-		bool bInitState)
-{
-	bool bFilterOutNonAssociatedBSSID = false;
-
-	struct rtllib_device *ieee = netdev_priv_rsl(dev);
-
-	netdev_info(dev, "========>Enter Intel Promiscuous Mode\n");
-
-	ieee->AllowAllDestAddrHandler(dev, true, !bInitState);
-	ieee->SetHwRegHandler(dev, HW_VAR_CECHK_BSSID,
-			     (u8 *)&bFilterOutNonAssociatedBSSID);
-
-	ieee->net_promiscuous_md = true;
-}
-EXPORT_SYMBOL(rtllib_EnableIntelPromiscuousMode);
-
-/* Disables the specialized promiscuous mode required by Intel.
- * See MgntEnableIntelPromiscuousMode for detail.
- */
-void rtllib_DisableIntelPromiscuousMode(struct net_device *dev,
-		bool bInitState)
-{
-	bool bFilterOutNonAssociatedBSSID = true;
-
-	struct rtllib_device *ieee = netdev_priv_rsl(dev);
-
-	netdev_info(dev, "========>Exit Intel Promiscuous Mode\n");
-
-	ieee->AllowAllDestAddrHandler(dev, false, !bInitState);
-	ieee->SetHwRegHandler(dev, HW_VAR_CECHK_BSSID,
-			     (u8 *)&bFilterOutNonAssociatedBSSID);
-
-	ieee->net_promiscuous_md = false;
-}
-EXPORT_SYMBOL(rtllib_DisableIntelPromiscuousMode);
-
 static void rtllib_send_probe(struct rtllib_device *ieee)
 {
 	struct sk_buff *skb;
-- 
2.42.0

