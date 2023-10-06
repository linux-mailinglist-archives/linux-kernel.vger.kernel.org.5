Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA217BBF86
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjJFTFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjJFTFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:05:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0F3112
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 12:05:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9b2c5664cb4so91670666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 12:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696619129; x=1697223929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4lreX3SHKEa8+ecJVm/PXdFDdYzsRKnuuuJws5KzVZg=;
        b=gmC6gSWaJWpJUL2bxwjtFYxzeptc5MK8q3Zkpp6/hOuyIzAgG1L8tT3H2fwFbuk0g0
         /yJUeSzLVp6KmPdCfQK+9Nd+dkxAV1252L1Tg7Bpj0Qvo/7FCH4Sawo1zthBot74rqOy
         wWX+dCFXcMGlHrPDAUuqGmGA7VDFm4h7kjTHgR6/WhhPQeartGDw9vV4S8Z6ClSQQRE6
         5jZhYG98uOYRCPuZhh0gshGqJ46wGASre3b5KRaQ4/hsnLfc/XJhlpBojgJ1BQ4vkopw
         GU5N8HuCXzblv9XUrPf+CFYPMgPaXEdRsa/Uju3ZyDOSj9pgQAE4oMfbvgTl8VAOUNsa
         uEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696619129; x=1697223929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lreX3SHKEa8+ecJVm/PXdFDdYzsRKnuuuJws5KzVZg=;
        b=hxp5sGVlS7sx2wRicbBaO5Vp+qCKt/NPitbwudrC8QeOtOK6za7dN+SYyyl24QIj0q
         uGIKPsOutKJlNwsEG4j7QTY145FzslR8vf5L0iiI0VRB7h4hZcDbRnZdXpx9ikBwZxT/
         R1zszLkF8zyljoodS11/JqZ0iC3GoZf2RLI0IDRFO4/C4JtzXNR/E27Bns+E7vfMr5TL
         cEJzaCGqucwKJNY2Ank6jg9Bv+aUwQDb/WO7USJnxWervyPK2cthhGCaL6rO/0H2+sCs
         YFagfHLXkT7xXHba742J/FuxcfK7Ojw6V31WgR6BYCFrP5Aj97HNc01xaioFGSdlecNW
         /Mvw==
X-Gm-Message-State: AOJu0YzIS3b+q9OMQoxr5AXrEhK0/6GMOm9VzqLQiLINGdZjm8FhM3VE
        c1FahYZ54iRSvcRm6VURok90TgbN5q0=
X-Google-Smtp-Source: AGHT+IEQ9iBFt236jfyvvA52ycBLUW+mtonNN2gijec8nrJC/C4dXiDWsZPqvpoqIe5kMoeVQosHng==
X-Received: by 2002:a17:906:530b:b0:9a1:aea8:cb5a with SMTP id h11-20020a170906530b00b009a1aea8cb5amr7653347ejo.1.1696619129491;
        Fri, 06 Oct 2023 12:05:29 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id g20-20020a17090613d400b009b96e88759bsm3406991ejc.13.2023.10.06.12.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 12:05:29 -0700 (PDT)
Date:   Fri, 6 Oct 2023 21:05:27 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] staging: rtl8192e: Remove function
 _rtl92e_wx_set_debug()
Message-ID: <887ca5f66bad5105eeba449a9bd3e40be4b835ce.1696548527.git.philipp.g.hortmann@gmail.com>
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

Remove function _rtl92e_wx_set_debug() as this functionality is not
commonly used and the tool to access it is deprecated.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 40 ----------------------
 1 file changed, 40 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index d4d8d66df82c..ec8e7d5fe634 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -122,25 +122,6 @@ static int _rtl92e_wx_get_power(struct net_device *dev,
 	return rtllib_wx_get_power(priv->rtllib, info, wrqu, extra);
 }
 
-static int _rtl92e_wx_set_debug(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-	u8 c = *extra;
-
-	if (priv->hw_radio_off)
-		return 0;
-
-	netdev_info(dev, "=====>%s(), *extra:%x, debugflag:%x\n", __func__,
-		    *extra, rt_global_debug_component);
-	if (c > 0)
-		rt_global_debug_component |= (1 << c);
-	else
-		rt_global_debug_component &= BIT31;
-	return 0;
-}
-
 static int _rtl92e_wx_set_mode(struct net_device *dev,
 			       struct iw_request_info *a,
 			       union iwreq_data *wrqu, char *b)
@@ -872,22 +853,6 @@ static iw_handler r8192_wx_handlers[] = {
 	[IW_IOCTL(SIOCSIWENCODEEXT)] = _rtl92e_wx_set_encode_ext,
 };
 
-/* the following rule need to be following,
- * Odd : get (world access),
- * even : set (root access)
- */
-static const struct iw_priv_args r8192_private_args[] = {
-	{
-		SIOCIWFIRSTPRIV + 0x0,
-		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "set_debugflag"
-	}
-
-};
-
-static iw_handler r8192_private_handler[] = {
-	(iw_handler)_rtl92e_wx_set_debug,   /*SIOCIWSECONDPRIV*/
-};
-
 static struct iw_statistics *_rtl92e_get_wireless_stats(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
@@ -919,10 +884,5 @@ static struct iw_statistics *_rtl92e_get_wireless_stats(struct net_device *dev)
 const struct iw_handler_def r8192_wx_handlers_def = {
 	.standard = r8192_wx_handlers,
 	.num_standard = ARRAY_SIZE(r8192_wx_handlers),
-	.private = r8192_private_handler,
-	.num_private = ARRAY_SIZE(r8192_private_handler),
-	.num_private_args = sizeof(r8192_private_args) /
-			    sizeof(struct iw_priv_args),
 	.get_wireless_stats = _rtl92e_get_wireless_stats,
-	.private_args = (struct iw_priv_args *)r8192_private_args,
 };
-- 
2.42.0

