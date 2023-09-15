Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D5F7A14D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 06:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjIOEiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 00:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjIOEiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 00:38:19 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37E21FCC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:38:14 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68fb898ab3bso1414159b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694752694; x=1695357494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P6xmR7jlw0IbB3VWBm5rVQtoneTVrpegGRYEYV8nLys=;
        b=Tcya10FuIFM2FYAxuQE9lVx4+VcqXT9wco0rl0ojZmOK+0fdl0t6dwEokG7B4hRZeO
         skYgar6V/Z4aTGrlKGvUFTQBP0ksWHpXvM6ckpCodRnSNh+s1unRiNKp1W6RX2X+xcb4
         p7vbW40Sw1OOrIBE23UWUGU8IfrFDiiSUUN7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694752694; x=1695357494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6xmR7jlw0IbB3VWBm5rVQtoneTVrpegGRYEYV8nLys=;
        b=Tvw/7Ug259AJngGHrTdnvJtS16wP5AyT3QT3k9ED/7bo235bmhFG5qI3v3MpVVDLU+
         2KS5fXi2PuZKHztFWvPO+W0RFxJjDNFf91NjHLd4yBSUFFCQle1KIldWxEvd5LjVEIRf
         gmP6034SxC21Ce9UnCxwuNQngLWnUYhOSlLhGC7IkXGLCVaD07CPntWN/8up+DBqERWj
         iY1/wDHDFYrZopdjxwwTf2nQgYqs9etjFypjplmmhM+3bnlreVOOO1fOhKmY4g4O+MJl
         yuXq7FPeNXm9szbGWgGJdxG2jYrpuIjqOLwfi1LtmShBK8f3dlIvQh0Fw3j/wwpQPpI5
         giow==
X-Gm-Message-State: AOJu0YznZVy2x8YREYemAYl99cD6/rm6GslizZDqhJVv9QkWLnaVWyFJ
        Nv2/iCEJshbFmFVwr49nuqxGHA==
X-Google-Smtp-Source: AGHT+IFwyKUaO6hudOvRJCuyZ4AGYfBVqP4sKU1jrW6uaQ5K3+beOE0L71mI880YRk0jfwOpAcpWng==
X-Received: by 2002:a05:6a00:21cb:b0:68f:fa05:b77a with SMTP id t11-20020a056a0021cb00b0068ffa05b77amr613661pfj.31.1694752694070;
        Thu, 14 Sep 2023 21:38:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j13-20020aa7800d000000b0068fb1709f52sm2061763pfi.136.2023.09.14.21.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 21:38:13 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:38:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/i915: refactor deprecated strncpy
Message-ID: <202309142137.DDC1D0A@keescook>
References: <20230914-strncpy-drivers-gpu-drm-i915-gem-selftests-mock_context-c-v1-1-c3f92df942e0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-strncpy-drivers-gpu-drm-i915-gem-selftests-mock_context-c-v1-1-c3f92df942e0@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 09:14:07PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer without unnecessarily NUL-padding.
> 
> `ctx` is zero allocated and as such strncpy's NUL-padding behavior was
> strictly a performance hit which should now be resolved. It should be
> noted, however, that performance is not critical in these selftests,
> especially by these margins.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  drivers/gpu/drm/i915/gem/selftests/mock_context.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/selftests/mock_context.c b/drivers/gpu/drm/i915/gem/selftests/mock_context.c
> index 8ac6726ec16b..025b9c773b93 100644
> --- a/drivers/gpu/drm/i915/gem/selftests/mock_context.c
> +++ b/drivers/gpu/drm/i915/gem/selftests/mock_context.c
> @@ -36,7 +36,7 @@ mock_context(struct drm_i915_private *i915,
>  	if (name) {
>  		struct i915_ppgtt *ppgtt;
>  
> -		strncpy(ctx->name, name, sizeof(ctx->name) - 1);
> +		strscpy(ctx->name, name, sizeof(ctx->name) - 1);

I'd expect the "- 1" to go away...

-Kees

>  
>  		ppgtt = mock_ppgtt(i915, name);
>  		if (!ppgtt)
> 
> ---
> base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
> change-id: 20230914-strncpy-drivers-gpu-drm-i915-gem-selftests-mock_context-c-980c8ecc9142
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
