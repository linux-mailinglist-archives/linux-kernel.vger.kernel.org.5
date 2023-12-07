Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EF6808A50
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443276AbjLGOSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443235AbjLGORW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:17:22 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C911732
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:17:19 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5d77a1163faso5983417b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701958638; x=1702563438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M60Jgfh6iu6z8nYVF4PYMb9c5IiQooWLUZtkA7L/n1Y=;
        b=vw4UvRucLn8DLHozaNOns+nIvOqtskgyfKn9vefIVrEkKzcbblitcxoV6QPNQzlo84
         F5/YIvqgxRdbpLza5fEmbqGpTntrx54FNBMdwPtLWYgXK/QrTOJ6OOcC+YFyECXwiBBv
         LoFuKXHCP7U8Gxw4a8ZT6Kld1NZKAT5+KH9WA73Z+0olOkpl3pkDHr438IQ4qdiEK4zd
         z4f+PM5BpkauuOjTyjSQDGIcmHrHILD6yIJ56X2sx6lq4Mb61W4V8Zg9TgShy6mkKc1t
         oGc3mnAvGxkjfwC7JB4VBXnWPOPWBs1lFGB1Srm35IhBqWwgrK9zUu1JVzbD1wSXISDE
         sxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701958638; x=1702563438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M60Jgfh6iu6z8nYVF4PYMb9c5IiQooWLUZtkA7L/n1Y=;
        b=hc/Ugd7ft4ElBxfCOAMcN13xmaLguC02u+gbwvMZz50FDSJRiWIyUoAvQmN6pX2Vox
         vdV3Jh9RRxCnq7IdL+pDHVHUOjquJAe216z5rF6s+zy12T0sw2iu3bRkT8zYobqZ+BSJ
         9OOO7wTS1Y6benuUWCSux/7/qysncVheV4kdjEVm5Caw7NbiGF8oma/QJohDUO68TCRC
         ktFChfDeSCMCTmh1B2OnrXQnjukA9Kqap1Xvo1DY+Rswa0MPx2Z6oA+nyU+MHZWBUcVt
         yhN5Cw+Ozisj/hUb4rsR8Dx4XA6fJi6ZfzNc8iEhK5iupF4zM8pqIXRpp1pyFanNLSpK
         ubnw==
X-Gm-Message-State: AOJu0Yx/vgKLG25l8Ma27cuu65+x18/Js3Cic6ZhISEuQmBn3uXh2tqn
        hi6kJ8IczDvT4Ou6It23r7iNE8NxqfGYEk1q8JYtBw==
X-Google-Smtp-Source: AGHT+IEJGe7l15a+9BqxmN89FyS7HOqKVFKB5un980cU1GLW108tgLGrnl+y2KomHMfyrWQKOt4HmdV1dNngzFGLsVA=
X-Received: by 2002:a81:430a:0:b0:5d7:1940:3efc with SMTP id
 q10-20020a81430a000000b005d719403efcmr1641052ywa.45.1701958638280; Thu, 07
 Dec 2023 06:17:18 -0800 (PST)
MIME-Version: 1.0
References: <20231206055855.21092-1-rdunlap@infradead.org>
In-Reply-To: <20231206055855.21092-1-rdunlap@infradead.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 Dec 2023 15:16:42 +0100
Message-ID: <CAPDyKFqrgnyQyY1u47j7VSdJE7GVvHBQ1RKG+=ZNx9a-eEbu+Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-omap: don't misuse kernel-doc marker
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2023 at 06:58, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Use "/*" instead of "/**" for common C comments to prevent warnings
> from scripts/kernel-doc.
>
> sdhci-omap.c:3: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> sdhci-omap.c:3: warning: missing initial short description on line:
>  * SDHCI Controller driver for TI's OMAP SoCs
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202311201117.lFxgJTK6-lkp@intel.com/
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org

Applied for next, thanks!

Kind regards
Uffe


> ---
> This does not Close the report since there are also some warnings for
> missing-prototypes.
>
>  drivers/mmc/host/sdhci-omap.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -- a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * SDHCI Controller driver for TI's OMAP SoCs
>   *
>   * Copyright (C) 2017 Texas Instruments
