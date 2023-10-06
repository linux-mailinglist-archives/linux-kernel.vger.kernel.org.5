Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E2E7BBF77
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjJFTE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjJFTEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:04:54 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2030BBD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 12:04:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53142351997so840032a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 12:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696619088; x=1697223888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TR+CJlGMm2zmH2722XJ9+Q+Usd9T7hGbLEyurllWFf4=;
        b=kgluek0s+uvEyQmcu+25aEBsEZi0Bb5soXx32Tt8phYeJQwlL5Mp8eP5jykObhAxP9
         KoBfp8hKH0JQ28fiV2KBEZqCWEoZUQDZB5Fv4r0Op8/9Y+AhfWP+CWntRrMYKcPFysJ7
         YVI9Av8cYoQQUW0PIFHr46jE/0u9fcTz6I7updHmqGAtm5K7PaUUAUlDRaH1v7CVevh/
         guDE7Wv189tuG0GaIJKD/KwCPxOkwBunWgeYrP2xupxCXcXz0kd+RjSOHJhi2hTzXIIh
         b0Jc2eMy+DaFMumKscClpm5bSlPqDQT2ZVsAIMkchPB1qSCoAwnKwYsWEh0tF6j5ZCjV
         DpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696619088; x=1697223888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TR+CJlGMm2zmH2722XJ9+Q+Usd9T7hGbLEyurllWFf4=;
        b=Ojai3TUUPrrYAiacU/VKRR3DQfo29JZHGTX8V3qqSIMeS1ccpP2c5ZuIh+JebBQO1+
         deuoyoJ0qrg9qFLdwIMl70ZR7rvb3QLuDYLuuu59PU9m3eTnVOlqeEzvhyzRnpyxbcdx
         tqZsY/rQRKAJV7g/TsjsMcpwFfaEVna3wOMJsT9VpJx2mpSRBI/zzKmpOW5irjk16CdH
         YGAzjIn5sHzZRYFg0oAyIggH0qeFoPSwdFrzG/HwuIGv0CP9utYT6Eu+RQY7FhHZj+2S
         ZFEK1TBJzXvjjgBElQN7clsqhAhEIIJ1PG/z9JfwV/Fp9lPUtehEfG0LfmMZ3QlzV90m
         XepQ==
X-Gm-Message-State: AOJu0YyMbQNM00RhCNkfWl6oFSQAq02R+TGmswJuhL+Jmy/+9ZWcS74x
        UZ9s+Yo8S+Lx5hob8dqvLZE=
X-Google-Smtp-Source: AGHT+IFJa0rsAW6/pfcQurQ+spG1NdYAdUrIbUs5vicN0GDSE5zNFYUTcSuR4wBVRFeK4sa3k5roGA==
X-Received: by 2002:a05:6402:1d53:b0:522:580f:8304 with SMTP id dz19-20020a0564021d5300b00522580f8304mr8605911edb.1.1696619088133;
        Fri, 06 Oct 2023 12:04:48 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id p26-20020aa7d31a000000b00534ac155da7sm2951084edq.29.2023.10.06.12.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 12:04:47 -0700 (PDT)
Date:   Fri, 6 Oct 2023 21:04:46 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] staging: rtl8192e: Remove function
 _rtl92e_wx_set_lps_awake_interval()
Message-ID: <f0bce7933d3d3761ddc42ba64a4ce46827bd3304.1696548527.git.philipp.g.hortmann@gmail.com>
References: <cover.1696548527.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696548527.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function _rtl92e_wx_set_lps_awake_interval() as this functionality
is not commonly used and the tool to access it is deprecated.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 27 ----------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index a85caabcaf6c..35f25c60dfb9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -150,25 +150,6 @@ static int _rtl92e_wx_adapter_power_status(struct net_device *dev,
 	return 0;
 }
 
-static int _rtl92e_wx_set_lps_awake_interval(struct net_device *dev,
-					     struct iw_request_info *info,
-					     union iwreq_data *wrqu,
-					     char *extra)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rt_pwr_save_ctrl *psc = (struct rt_pwr_save_ctrl *)
-					(&priv->rtllib->pwr_save_ctrl);
-
-	mutex_lock(&priv->wx_mutex);
-
-	netdev_info(dev, "%s(): set lps awake interval ! extra is %d\n",
-		    __func__, *extra);
-
-	psc->reg_max_lps_awake_intvl = *extra;
-	mutex_unlock(&priv->wx_mutex);
-	return 0;
-}
-
 static int _rtl92e_wx_set_debug(struct net_device *dev,
 				struct iw_request_info *info,
 				union iwreq_data *wrqu, char *extra)
@@ -950,10 +931,6 @@ static const struct iw_priv_args r8192_private_args[] = {
 		SIOCIWFIRSTPRIV + 0x6,
 		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, IW_PRIV_TYPE_NONE,
 		"set_power"
-	}, {
-		SIOCIWFIRSTPRIV + 0xa,
-		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, IW_PRIV_TYPE_NONE,
-		"lps_interv"
 	}
 
 };
@@ -966,10 +943,6 @@ static iw_handler r8192_private_handler[] = {
 	(iw_handler)NULL,
 	(iw_handler)NULL,
 	(iw_handler)_rtl92e_wx_adapter_power_status,
-	(iw_handler)NULL,
-	(iw_handler)NULL,
-	(iw_handler)NULL,
-	(iw_handler)_rtl92e_wx_set_lps_awake_interval,
 };
 
 static struct iw_statistics *_rtl92e_get_wireless_stats(struct net_device *dev)
-- 
2.42.0

