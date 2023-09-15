Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3AB7A14F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 06:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjIOE6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 00:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjIOE6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 00:58:41 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F0A2134
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:58:36 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-577fb90bbebso1146349a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694753916; x=1695358716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fhsajtpeOeh2nBytWoKmEmN9EZC9U8e31FJLV6iox60=;
        b=lZ/M2gYzFoXIe586ycgOpV0KFBdVtMzxBZTMLj/kySJdgjTnbnSuRi1YNNDgXlCYjV
         TaRPUxCbs2jqTtJpd+hMoE8abuymSECf2oIj/uo7uHNUlPPv/FtYUolqGBIxYzm9/Oa+
         SDR51MIlJeZBSma3toqdS5h3G77DFUpjdRzZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694753916; x=1695358716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhsajtpeOeh2nBytWoKmEmN9EZC9U8e31FJLV6iox60=;
        b=G9L1VjddVJBMLKBDBY1qUMNagPje5fc5zhIKC0pemfYd/I+gH+mnO/W3KsafKJi+07
         i+GxNs4tmiUwiAzUUdklBf0jcOggT9kJnzAlgIOK0do1S++Vl1GC1syZXggT070JJQGY
         c/tVe7mfVkCH1jZQpOXFH+74cw0Zyoo1VijTUlEesYuGPct7fdvrOFZIUJUWSuEY49dW
         RDhqEhunwcQcJMYYugMgCCo7a36wISNZISI6xEvDt4gAGIjKk0gQD+QSbMHfnb9g9iPR
         zB/SyRVtNWz0MES728GSm2zJXAHXJv6IILc6On3Tbng6+Lu/MuC1jVnJSL/P8/S5tMSr
         xaPw==
X-Gm-Message-State: AOJu0YxFkHBND6/0NxVZvhCsFkYTSYFNWBoYQqV9ui/vzqE/zO6XXP30
        GAtIKjSGLcStSDZXxd8QW8l4Hw==
X-Google-Smtp-Source: AGHT+IHAmWQcAvThssqgWXbggJNS/TydsVAkxf1KlDv9GNBO38qD+u6WVPMGPpXVEOqFJJZtDsV7lg==
X-Received: by 2002:a17:90a:7503:b0:26b:6a2f:7d90 with SMTP id q3-20020a17090a750300b0026b6a2f7d90mr523526pjk.23.1694753916448;
        Thu, 14 Sep 2023 21:58:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w2-20020a170902d70200b001bbaf09ce15sm2448050ply.152.2023.09.14.21.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 21:58:35 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:58:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau/core: refactor deprecated strncpy
Message-ID: <202309142158.9D766D97@keescook>
References: <20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-core-firmware-c-v1-1-3aeae46c032f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-core-firmware-c-v1-1-3aeae46c032f@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 09:40:49PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer without unnecessarily NUL-padding.
> 
> There is likely no bug in the current implementation due to the safeguard:
> | 	cname[sizeof(cname) - 1] = '\0';
> ... however we can provide simpler and easier to understand code using
> the newer (and recommended) `strscpy` api.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/core/firmware.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/core/firmware.c b/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
> index 91fb494d4009..374212da9e95 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
> @@ -79,8 +79,7 @@ nvkm_firmware_get(const struct nvkm_subdev *subdev, const char *fwname, int ver,
>  	int i;
>  
>  	/* Convert device name to lowercase */
> -	strncpy(cname, device->chip->name, sizeof(cname));
> -	cname[sizeof(cname) - 1] = '\0';
> +	strscpy(cname, device->chip->name, sizeof(cname));
>  	i = strlen(cname);
>  	while (i) {
>  		--i;

Yup, consumed by strlen() and snprintf(). Looks like a standard
conversion. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> ---
> base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
> change-id: 20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-core-firmware-c-791223838b72
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
