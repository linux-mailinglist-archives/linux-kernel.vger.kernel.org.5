Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F25B7F1359
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjKTMbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTMbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:31:19 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1557F7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:31:15 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4094301d505so13876745e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700483474; x=1701088274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U+ygfjyW2dtt7SNYdGG+a1RKbTlkp8CN0gh3juIVK50=;
        b=gpu1ivGulkhKvdk5so7NtuqUMLlTWTuX2mLaMv/JBLnR0LBsI2dEjcgi7Qp7MSKHn2
         FygvSfqECuoRMQCyIuRPi9ZOLY9a5PMZppkIIzTLBbYmgvtY8jF2jBTmhqSVXhsZS+yS
         csbso2McCRZwKQgOsE69KSLlhM2kpAm++D1lLEoCWTdEz23Pnov9FSY60q90uSx+L6u9
         oA8nK54+DUqOlEBcLBGLwtqoORc8Q1uVQj7lX4ET3zsOODF86cTNubXKLLPmtv0ciQyz
         0JmQBuNQxfgrF6DXu5vx0NrivkQ9ed6rxwGA4DSVX4qZUD0GMneKiXEmSYnw4AFoVgHJ
         WHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700483474; x=1701088274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+ygfjyW2dtt7SNYdGG+a1RKbTlkp8CN0gh3juIVK50=;
        b=QUiOQOQV52MvYsribu35HjpF2uUQHBONxogdE0GBeixgxJR3Eg070YPFa5YfQ/DCAv
         himABcEQKHicsT2XWajNdk2mjBlyAs90rRJI/cFaSVhkcfBBwlnEAlcXj9BwcVjVKQO3
         5dh+hUHNy3hFl+z9SfyNDj/H9HQQZkOGfcvE6XPQxgSIY8QLFSgVVtGRLhUvCfnF6rb2
         xpdATELJpmZS/TE0FsXddm75WlnhK1rK1skdkDnysppS4f8WPnvegiKUe8yJJmWHTAnV
         Owj/cyOBILcuJxbRlEHx7y9gApR1SDoPL0KTwe/3XM3xgakZOJ9Ci1c5pGYDXd6Un7Uh
         w3pQ==
X-Gm-Message-State: AOJu0Yy4g4/CQkvYEYnMErhsjM/zG42wOT+IhrW7iBUm3eaGfssRSs6v
        FdOtnmD/p2PExnHQ7ib5pm0UHg==
X-Google-Smtp-Source: AGHT+IFH5ZY2W8nrgFtr/VHzEM4XPB2oiuC34QYENqeI3k2VGALPT0oPN0iCaxJHt7hbpyaLHA4VRA==
X-Received: by 2002:a5d:4382:0:b0:32d:a7b0:62b with SMTP id i2-20020a5d4382000000b0032da7b0062bmr3677437wrq.26.1700483474267;
        Mon, 20 Nov 2023 04:31:14 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d4-20020a5d4f84000000b0032d96dd703bsm11077492wru.70.2023.11.20.04.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 04:31:13 -0800 (PST)
Date:   Mon, 20 Nov 2023 07:31:10 -0500
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Su Hui <suhui@nfschina.com>,
        "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtl8xxxu: correct the error value of 'timeout'
Message-ID: <456145f7-9c6e-4231-aec4-9c02511b6550@suswa.mountain>
References: <20231113054917.96894-1-suhui@nfschina.com>
 <e8b847437ab242d18108d9364360bb8a@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8b847437ab242d18108d9364360bb8a@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 06:42:50AM +0000, Ping-Ke Shih wrote:
> > diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> > b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> > index 43ee7592bc6e..9cab8b1dc486 100644
> > --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> > +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> > @@ -4757,6 +4757,12 @@ void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv)
> >          *   RxAggPageTimeout = 4 or 6 (absolute time 34ms/(2^6))
> >          */
> > 
> > +       /* REG_RXDMA_AGG_PG_TH + 1 seems to be the timeout register on
> > +        * gen2 chips and rtl8188eu. The rtl8723au seems unhappy if we
> > +        * don't set it, so better set both.
> > +        */
> > +       timeout = 4;
> > +
> >         page_thresh = (priv->fops->rx_agg_buf_size / 512);
> >         if (rtl8xxxu_dma_agg_pages >= 0) {
> >                 if (rtl8xxxu_dma_agg_pages <= page_thresh)
> 
> The logic here is:
> 
> 	page_thresh = (priv->fops->rx_agg_buf_size / 512);
> 	if (rtl8xxxu_dma_agg_pages >= 0) {
> 		if (rtl8xxxu_dma_agg_pages <= page_thresh)
> 			timeout = page_thresh;
> 
> Do you know why 'timeout = page_thresh;'? Intuitively, units of 'timeout' and
> 'thresh' are different. Maybe, we should correct here instead?
> 

Yeah.  That's strange.  I'm not convinced this fix is correct.  I'm
hesitant to suggest this but maybe the following is the correct fix?
It just silences the warning but doesn't change runtime.

I don't know.  *shrug*.  One thing that we could do is just leave the
warning as-is until someone who knows better than we do can take a look
at it.

regards,
dan carpenter

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 43ee7592bc6e..68d9b4a0ee63 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4759,16 +4759,16 @@ void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv)
 
 	page_thresh = (priv->fops->rx_agg_buf_size / 512);
 	if (rtl8xxxu_dma_agg_pages >= 0) {
-		if (rtl8xxxu_dma_agg_pages <= page_thresh)
-			timeout = page_thresh;
-		else if (rtl8xxxu_dma_agg_pages <= 6)
-			dev_err(&priv->udev->dev,
-				"%s: dma_agg_pages=%i too small, minimum is 6\n",
-				__func__, rtl8xxxu_dma_agg_pages);
-		else
-			dev_err(&priv->udev->dev,
-				"%s: dma_agg_pages=%i larger than limit %i\n",
-				__func__, rtl8xxxu_dma_agg_pages, page_thresh);
+		if (rtl8xxxu_dma_agg_pages > page_thresh) {
+			if (rtl8xxxu_dma_agg_pages <= 6)
+				dev_err(&priv->udev->dev,
+					"%s: dma_agg_pages=%i too small, minimum is 6\n",
+					__func__, rtl8xxxu_dma_agg_pages);
+			else
+				dev_err(&priv->udev->dev,
+					"%s: dma_agg_pages=%i larger than limit %i\n",
+					__func__, rtl8xxxu_dma_agg_pages, page_thresh);
+		}
 	}
 	rtl8xxxu_write8(priv, REG_RXDMA_AGG_PG_TH, page_thresh);
 	/*
