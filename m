Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA92E7FE0EC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjK2UWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjK2UWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:22:22 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE300D67
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:22:28 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cff3a03dfaso1690945ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701289348; x=1701894148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=itd9NKciBX2zxONHPt0DHyuGmDjJYND+/iJlNldlRJY=;
        b=J2uCbEYniFfeHnsTSieSAHMJp/FLKUj9FTHyIB1u0gepIhVTQhx65G60GQO7E8OIcI
         wXp6RutoHOcsXZSS49Cxh7mhLjl3x7ZGZT9wz3Dv1g3y8L5egorFCJD3+NPBEC7nnf6U
         FfvPNp6ie/s+Y5fsR5AxQ9c9EhPhdJt+NUm1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701289348; x=1701894148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itd9NKciBX2zxONHPt0DHyuGmDjJYND+/iJlNldlRJY=;
        b=wNjsR5rPXQSgHsb56MoSgsg6+la01i9R4bBSV5zaXH2V88JDAwfinT6TUv7haT+Uyq
         8tbLjJMZffeInOlE+q4uuISkkYJhMgNjNS/HGGTrGDGun05XMf6XpMRmzYx7oqydxR6+
         GFErKAz5dB58yW4h3QyaF5uULVyZdjqtbtfRuDBbVHU2vK3/lxM1ssGl8GcPN1YvD7PO
         9b1pHAbzVIS/SuqfEuD9DzUe86FwabkELXPOZjPLcnjQu/mhKPB3AgiP2h1yXMbwwdxM
         uPyRGX21lhpDqgzCE1cCeDIgzhel1gAGzkWwCUpHkF59YADkpCx8Y4kB33arz2Y6rO/m
         8GAA==
X-Gm-Message-State: AOJu0YwROJpDPaXUJ6XSQhuys4d+bDaVPHSoEOUuduKnePtQuxMhHTBZ
        NLmfzs2nni6NyHTZjW/KhQUN6EoBG06maVUEFtc=
X-Google-Smtp-Source: AGHT+IGy4I6YEv72N7gHiWShs+tJ4XFlnr2sELy4UZbWmy+HzCFRKq117eRrCVzUM7vWcNMg7dhwJA==
X-Received: by 2002:a17:902:ce8c:b0:1cf:c3f7:7d4d with SMTP id f12-20020a170902ce8c00b001cfc3f77d4dmr16221436plg.67.1701289348165;
        Wed, 29 Nov 2023 12:22:28 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ij30-20020a170902ab5e00b001cc3a6813f8sm12975074plb.154.2023.11.29.12.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:22:27 -0800 (PST)
Date:   Wed, 29 Nov 2023 12:22:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] lkdtm: Add kfence read after free crash type
Message-ID: <202311291219.A6E3E58@keescook>
References: <20231127234946.2514120-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127234946.2514120-1-swboyd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 03:49:45PM -0800, Stephen Boyd wrote:
> Add the ability to allocate memory from kfence and trigger a read after
> free on that memory to validate that kfence is working properly. This is
> used by ChromeOS integration tests to validate that kfence errors can be
> collected on user devices and parsed properly.

This looks really good; thanks for adding this!

> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/misc/lkdtm/heap.c | 64 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
> index 0ce4cbf6abda..608872bcc7e0 100644
> --- a/drivers/misc/lkdtm/heap.c
> +++ b/drivers/misc/lkdtm/heap.c
> @@ -4,6 +4,7 @@
>   * page allocation and slab allocations.
>   */
>  #include "lkdtm.h"
> +#include <linux/kfence.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched.h>
> @@ -132,6 +133,66 @@ static void lkdtm_READ_AFTER_FREE(void)
>  	kfree(val);
>  }
>  
> +#if IS_ENABLED(CONFIG_KFENCE)

I really try hard to avoid having tests disappear depending on configs,
and instead report the expected failure case (as you have). Can this be
built without the IS_ENABLED() tests?

-- 
Kees Cook
