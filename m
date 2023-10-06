Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6027BBF7D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjJFTFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbjJFTFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:05:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F577126
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 12:05:04 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b2d64c9307so97625866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 12:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696619102; x=1697223902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=twZki8w+uSIknxeG/1Xm/hRx3jP9PNleQggQAAtzt9M=;
        b=kXYXoUSLH3/FW0IxSH3OzBa3QalT0fzVlWlf7LwwmbpRkc+u9TkNLcwSnmfzgPwKTA
         vGIF55b5jR1+ivvf8CTs+OXs52TdYRiJ9AtLQc+X4MWXnDWNVhfDThYKBTJeXRjqnBZA
         iFTYJht2Nk14e2v3LixhopQFwFbGV0li2zAPPfD0gXgDF2WB29480m+3Us7hmtUKcGXJ
         bMZ7ph+7fds31LpGTj+6RodylAjguWlcQ13C3KwXNXm0Y1GP1cCPORUDcBhuBYtOVbWe
         ykIfrZxO6IC7yM1uu50yEmIofEFWjKYgHzxS6KA4VE3VkW3Rmb8QJO4fo3QeT3ZTg3zh
         B8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696619102; x=1697223902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twZki8w+uSIknxeG/1Xm/hRx3jP9PNleQggQAAtzt9M=;
        b=duCoFBp8dIknhSb+STIIHET/f50+KC7yDBXSMLxm7mNjM2P0J1z+dP5YwWrQWdUCU7
         01ycr5SnQlNOwvseZIC20QRveRVmoPUYRgfbaamLT1JIbscWeQMSkm17Hjh5EZTd7Eou
         s424gqf/mTIegZFFA+g7yVLLO5WSIOPuyot9CHmTIQGGIac8m/ccbcOGfccQ9MTaVZKz
         5IO94hF0KS/SHAzpp6hFZKuEVfXn/re74SoaxriZ5qY1d/V6ueuZgNUpk1hnyPfBFZ2/
         gutWFmeWHiAJmGXY6WI1LhMWgjujndbUhODGCz11aUpLm/I8BRe/g3R7kzCVifpVoSSu
         5N3A==
X-Gm-Message-State: AOJu0Yw7IHImnUJFA131e4J1XLJAG/gUr/lT14emFwzqCd6WveuiEUub
        Vb8sr/nW94VJKRIR2t72gZc=
X-Google-Smtp-Source: AGHT+IERjSYnMDWJyyNYqjqazcemZh6LO2GQiCT7dnPc+/TP9DrQk7KrxJUf/ZeoVvrVks/phO6LeA==
X-Received: by 2002:a17:906:7389:b0:9b2:71f2:bd11 with SMTP id f9-20020a170906738900b009b271f2bd11mr7155082ejl.4.1696619102334;
        Fri, 06 Oct 2023 12:05:02 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id e12-20020a17090681cc00b009a9fbeb15f2sm3291667ejx.62.2023.10.06.12.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 12:05:02 -0700 (PDT)
Date:   Fri, 6 Oct 2023 21:05:00 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] staging: rtl8192e: Remove function
 _rtl92e_wx_adapter_power_status()
Message-ID: <2fc8f18019c760125ae7c52c765271d2877c52bd.1696548527.git.philipp.g.hortmann@gmail.com>
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

Remove function _rtl92e_wx_adapter_power_status() as this functionality
is not commonly used and the tool to access it is deprecated.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 37 ----------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 35f25c60dfb9..27309df925ba 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -122,34 +122,6 @@ static int _rtl92e_wx_get_power(struct net_device *dev,
 	return rtllib_wx_get_power(priv->rtllib, info, wrqu, extra);
 }
 
-static int _rtl92e_wx_adapter_power_status(struct net_device *dev,
-					   struct iw_request_info *info,
-					   union iwreq_data *wrqu, char *extra)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rt_pwr_save_ctrl *psc = (struct rt_pwr_save_ctrl *)
-					(&priv->rtllib->pwr_save_ctrl);
-	struct rtllib_device *ieee = priv->rtllib;
-
-	mutex_lock(&priv->wx_mutex);
-
-	if (*extra) {
-		priv->ps_force = false;
-		psc->bLeisurePs = true;
-	} else {
-		if (priv->rtllib->link_state == MAC80211_LINKED)
-			rtl92e_leisure_ps_leave(dev);
-
-		priv->ps_force = true;
-		psc->bLeisurePs = false;
-		ieee->ps = *extra;
-	}
-
-	mutex_unlock(&priv->wx_mutex);
-
-	return 0;
-}
-
 static int _rtl92e_wx_set_debug(struct net_device *dev,
 				struct iw_request_info *info,
 				union iwreq_data *wrqu, char *extra)
@@ -927,10 +899,6 @@ static const struct iw_priv_args r8192_private_args[] = {
 	}, {
 		SIOCIWFIRSTPRIV + 0x1,
 		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "activescan"
-	}, {
-		SIOCIWFIRSTPRIV + 0x6,
-		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, IW_PRIV_TYPE_NONE,
-		"set_power"
 	}
 
 };
@@ -938,11 +906,6 @@ static const struct iw_priv_args r8192_private_args[] = {
 static iw_handler r8192_private_handler[] = {
 	(iw_handler)_rtl92e_wx_set_debug,   /*SIOCIWSECONDPRIV*/
 	(iw_handler)_rtl92e_wx_set_scan_type,
-	(iw_handler)NULL,
-	(iw_handler)NULL,
-	(iw_handler)NULL,
-	(iw_handler)NULL,
-	(iw_handler)_rtl92e_wx_adapter_power_status,
 };
 
 static struct iw_statistics *_rtl92e_get_wireless_stats(struct net_device *dev)
-- 
2.42.0

