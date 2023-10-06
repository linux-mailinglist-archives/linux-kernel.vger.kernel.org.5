Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B280A7BC042
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjJFUYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjJFUYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:24:01 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD67BBE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:23:59 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27761d85b31so1810744a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 13:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696623839; x=1697228639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yeQqUbIodZOEmRnT0u+h/uvWq4E1WjoaKYarDgehFlU=;
        b=iQRTcKN0wALqRkVkliQHqshB55L2Nmw99XqnJWa2UNQ7C1T36H46nNDrxh7Unz1xAq
         i7rSlm7JXbCY8+buinpGkob+OTERy91GR6oFT7PQuY0WF3aOUUW7/qCfDLMVW2pe4kBz
         YJIAlAC1WVFdoELEYq4iuUBPt4MIG02P0/PDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696623839; x=1697228639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeQqUbIodZOEmRnT0u+h/uvWq4E1WjoaKYarDgehFlU=;
        b=S4/6ial6AXXgW9h+SBT42eWqdP8vSPMNRkLta8fnlMEJgVj+EMblQEXHBbTBWShBCu
         bMDtvj7mUHKfe4jvRQFtcFd4o3Ib8DGCeyq6Dgm2mQGgA7SYT/RmCD0Qbl/0AX7rUIDS
         ljFZ4w6p0lupoeNocqtsu1v/y23uXW9ovcWhjrw3FP95a6VonriQejZxj3MNA32IMYgM
         GjnRTyrrFgbDZZjIjWyKFZLxhwEHVz+PMdso4Rpy0f5VCgXeKxG4IfL5XNNPjCOM5gD4
         M2v1ZfJDUR/Jt/LaydPnhVJU4tK5woXmTi4pcN5BbJPKQfgi9P+PdpP/VlNdpbkq245T
         FGAA==
X-Gm-Message-State: AOJu0YxUYQD6jDa/SNMTGIJidVdXCARXum0iRVe1Nd1h+6B9Ogzz1O+N
        8bVuoFK3/I0upY/UG2+PiBYSyw==
X-Google-Smtp-Source: AGHT+IHEr5nv1cWEM1Y3LbpIOqHG/Lj+SrRUHy4wA915uDKNkG765B0Y8Pm/6H1gh2Qpt05VCVwqjA==
X-Received: by 2002:a17:90a:a085:b0:276:e14a:4991 with SMTP id r5-20020a17090aa08500b00276e14a4991mr8929179pjp.2.1696623839216;
        Fri, 06 Oct 2023 13:23:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001bc68602e54sm4343643pli.142.2023.10.06.13.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:23:58 -0700 (PDT)
Date:   Fri, 6 Oct 2023 13:23:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Bo YU <tsu.yubo@gmail.com>
Subject: Re: [PATCH v2] drm/etnaviv: refactor deprecated strncpy
Message-ID: <202310061323.05B262D@keescook>
References: <20230918-strncpy-drivers-gpu-drm-etnaviv-etnaviv_perfmon-c-v2-1-8ae12071c138@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918-strncpy-drivers-gpu-drm-etnaviv-etnaviv_perfmon-c-v2-1-8ae12071c138@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 01:34:08PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy_pad` due to the fact that it
> guarantees NUL-termination on the destination buffer whilst maintaining
> the NUL-padding behavior that strncpy provides.

Friend ping. Who can pick this change up?

Thanks!

-Kees

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Bo YU <tsu.yubo@gmail.com>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - use strscpy_pad (thanks Kees)
> - Link to v1: https://lore.kernel.org/r/20230914-strncpy-drivers-gpu-drm-etnaviv-etnaviv_perfmon-c-v1-1-3adc2d9bfc52@google.com
> ---
> Similar to [2] which was never picked up. Let's prefer strscpy_pad to strlcpy, though
> 
> [2]: https://lore.kernel.org/all/20190328080918.9290-1-tsu.yubo@gmail.com/
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> index bafdfe49c1d8..dc9dea664a28 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> @@ -511,7 +511,7 @@ int etnaviv_pm_query_dom(struct etnaviv_gpu *gpu,
>  
>  	domain->id = domain->iter;
>  	domain->nr_signals = dom->nr_signals;
> -	strncpy(domain->name, dom->name, sizeof(domain->name));
> +	strscpy_pad(domain->name, dom->name, sizeof(domain->name));
>  
>  	domain->iter++;
>  	if (domain->iter == nr_domains)
> @@ -540,7 +540,7 @@ int etnaviv_pm_query_sig(struct etnaviv_gpu *gpu,
>  	sig = &dom->signal[signal->iter];
>  
>  	signal->id = signal->iter;
> -	strncpy(signal->name, sig->name, sizeof(signal->name));
> +	strscpy_pad(signal->name, sig->name, sizeof(signal->name));
>  
>  	signal->iter++;
>  	if (signal->iter == dom->nr_signals)
> 
> ---
> base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
> change-id: 20230914-strncpy-drivers-gpu-drm-etnaviv-etnaviv_perfmon-c-dd095491dfde
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
