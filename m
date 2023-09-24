Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B187ACBAE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjIXTre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjIXTrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:47:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF69D3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:47:25 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4053c6f1087so42242385e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695584844; x=1696189644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0UiLgnPTra5qLP9o6AOXP+MP5rQqIbxexMkPfbpuaE=;
        b=H/SzwOVDqkexlZ5ZSm95DpXwgArBDtV8rSrUngWzeovNn7CLyXhQrVTahnxuv6eLZM
         Q0g2wGo3L7EBmexnrmzNYLeBjRN3elmBQO+gRRCuOPrnVy78Nj6/271NzgrPb1bAp17K
         pPmhRWxk74ePZm4p5ju6qimLkdH2rkGhrCzYPWyVfTp/AqMsOqZdeVvISG/zpGZ1AZav
         SJnnEhrEw9wPdcry8aN/w5LVkoxPEksZ2/5VKiLaYToYwGZkHkq/lEmYwQkMoSb22HBb
         UfL8jOeJPXVeVntHn9Eqqo6mPXAV1ihulpKGAAvjsLBNKLyGxt7U/57oCJRZGOgLXsMm
         HBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695584844; x=1696189644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0UiLgnPTra5qLP9o6AOXP+MP5rQqIbxexMkPfbpuaE=;
        b=n4LmQ8zpL9seU2m3vvntAUu6rIy/xSB86sUpQ0+E2jYLemEYlC0J6lSEp+fiXoeCa/
         p2UJuDW/kux8Q3pFzI8S66F8OM01flYSlLxgCzOlDByOsTyByX2EbRLwI/iXNQCuarhr
         vrVzrOfDuiu0PH8dWsL59MBQETJWwSsSSkuxTscrEG3+doU+pGn1cC4IBKQtI2xWWzYv
         okE0LuaL2q1fcMpXjCnW5gsz50Wz5xmBK0aJVprdjXgA+7NSTsn7koFU0J6TMQoo7VeQ
         66bk26oOeeKV/gYagbiHnc9Qdqh8UFpb/fC67K61Cty7oNQjayS8MPSbzCJt/EoLv+aK
         IyjA==
X-Gm-Message-State: AOJu0YyFETp/joUEed3VPFtgN96bxoGNeoepvpr6HKjfRBpxV+FER/Zc
        QHbtqwUw309VwvsMPdQ8uAc=
X-Google-Smtp-Source: AGHT+IGDoDkjcAsXY5BDoD37D7SSWWRRbHvSuc/IWVrkcNbbcS4m6aLfl01i4du0XtIIfHFrGLoGGQ==
X-Received: by 2002:adf:ebcc:0:b0:319:85e2:6972 with SMTP id v12-20020adfebcc000000b0031985e26972mr4084047wrn.42.1695584844170;
        Sun, 24 Sep 2023 12:47:24 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id sd6-20020a170906ce2600b00997e99a662bsm5315866ejb.20.2023.09.24.12.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:47:23 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     airlied@gmail.com, liuhaoran <liuhaoran14@163.com>
Cc:     daniel@ffwll.ch, samuel@sholland.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, liuhaoran <liuhaoran14@163.com>
Subject: Re: [PATCH] drm/sun4i: Add error handling in sun4i_layer_init_one()
Date:   Sun, 24 Sep 2023 21:47:22 +0200
Message-ID: <2156768.irdbgypaU6@jernej-laptop>
In-Reply-To: <20230924074216.17390-1-liuhaoran14@163.com>
References: <20230924074216.17390-1-liuhaoran14@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne nedelja, 24. september 2023 ob 09:42:16 CEST je liuhaoran napisal(a):
> This patch adds error-handling for the drm_plane_create_alpha_property()
> and drm_plane_create_zpos_property() inside the dw_hdmi_imx_probe().

dw_hdmi_imx_probe() is not from this driver.

Best regards,
Jernej

> 
> Signed-off-by: liuhaoran <liuhaoran14@163.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_layer.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
> index 98f3176366c0..a3343afb7935 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
> @@ -224,9 +224,22 @@ static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
>  	drm_plane_helper_add(&layer->plane,
>  			     &sun4i_backend_layer_helper_funcs);
>  
> -	drm_plane_create_alpha_property(&layer->plane);
> -	drm_plane_create_zpos_property(&layer->plane, layer->id,
> -				       0, SUN4I_BACKEND_NUM_LAYERS - 1);
> +	ret = drm_plane_create_alpha_property(&layer->plane);
> +
> +	if (ret) {
> +		dev_err(drm->dev, "Failed to install alpha property,
> +			rc = %d\n", ret);
> +		return ERR_PTR(ret);
> +	}
> +
> +	ret = drm_plane_create_zpos_property(&layer->plane, layer->id, 0,
> +					     SUN4I_BACKEND_NUM_LAYERS - 1);
> +
> +	if (ret) {
> +		dev_err(drm->dev, "Failed to install zpos property,
> +			rc = %d\n", ret);
> +		return ERR_PTR(ret);
> +	}
>  
>  	return layer;
>  }
> 




