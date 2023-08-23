Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CACE785C47
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbjHWPiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237278AbjHWPiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:38:11 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81599E50;
        Wed, 23 Aug 2023 08:38:09 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bc886d1504so4381831a34.0;
        Wed, 23 Aug 2023 08:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692805089; x=1693409889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4SkKlAbqJpn3W9mREOS7xdidgwXt26+Nc2zXplGeHM=;
        b=D3j+jtASsvw3oke8XXXeyrK5llBEgvl5isUWuMzWxMymFNaa10eJZPCl/WFl5UmCmT
         ARkI86XYumfasFLi9MCQKAFd+vV2g2xPPc5Wc26RLOWIgNaXY92kiocVAoVCcFxuUypS
         5yFbM5osKf0erPayZYbXXIyLGkDQWuUkNIvhKo56/PNYIGChjZgV5WsqCCLJthl6flTB
         4IvhDDG78OvABM7jTj9CdCrczGuHelz2BtL6rpUSDn1kYBYJlAwgYPRjdIpkEOif61wF
         xclKxq1b1p94bEb1FWcPcxGC1eYCYvlT6wMXhHG5D8axEKX8bjaLvF7OT5hOrAEV2C3N
         C+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692805089; x=1693409889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4SkKlAbqJpn3W9mREOS7xdidgwXt26+Nc2zXplGeHM=;
        b=epNWMeOxcXxZeDSE5IVFgIqe2zrVE36sOZEbxl59FMWZ+OGx7Ylh9rqcNSan/2t3O1
         YNCDJdyZ/dQtKF1wSHtxtuLP8ap4CIZoM9+tRMHr4bvlK2fuQ794KFczExs0t+Fin0B8
         QyKt+5tZplVmt0g4mX9FTJOyzqbzyfFcNw6U+WbeU+HTBFRUYIE26OCMv657JmVIg1Ld
         Sy5XqIUbZ7EfWDmfPh5oCsaIrAQwySU7vZxLAwjo7B9A4BfHpmGYCCPj9CCh0awJlnSg
         q41l1usJlAUSUKMwf037ZKO54djXCIN/vCzmSmY34Eh7ASFwKfeWCpZfxMF+sNwqnzfq
         G+5A==
X-Gm-Message-State: AOJu0Yz3eFq/CTVffL7/OSp2cTDwZNkjIu1tIkEfgo+X4J1xGoAUEpzH
        L3psgUQWtZ09Agsv4voAoOw=
X-Google-Smtp-Source: AGHT+IGDtTWQriiaiDHkSAZKWgk7OvDpXpVUuf0KtOeULPl1ptD4cv0ietjjTEiml/7ncCSA/eRZLQ==
X-Received: by 2002:a9d:6c45:0:b0:6b9:b665:7f with SMTP id g5-20020a9d6c45000000b006b9b665007fmr12824092otq.17.1692805088733;
        Wed, 23 Aug 2023 08:38:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bt18-20020a632912000000b0056b920051b3sm6267366pgb.7.2023.08.23.08.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 08:38:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 23 Aug 2023 08:38:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        kernel test robot <lkp@intel.com>,
        linux-watchdog@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: stm32: Drop unnecessary of_match_ptr()
Message-ID: <970cbe44-9958-4315-b112-74f34bf97740@roeck-us.net>
References: <20230823151059.2356881-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823151059.2356881-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 10:10:59AM -0500, Rob Herring wrote:
> With COMPILE_TEST recently enabled, 0-day reports a warning:
> 
> drivers/watchdog/stm32_iwdg.c:215:34: warning: 'stm32_iwdg_of_match' defined but not used [-Wunused-const-variable=]
> 
> As STM32 platforms are always used with DT, drop the of_match_ptr().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308211837.4VBSUAtZ-lkp@intel.com/
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/stm32_iwdg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> index 570a71509d2a..9a554a3db4e2 100644
> --- a/drivers/watchdog/stm32_iwdg.c
> +++ b/drivers/watchdog/stm32_iwdg.c
> @@ -288,7 +288,7 @@ static struct platform_driver stm32_iwdg_driver = {
>  	.probe		= stm32_iwdg_probe,
>  	.driver = {
>  		.name	= "iwdg",
> -		.of_match_table = of_match_ptr(stm32_iwdg_of_match),
> +		.of_match_table = stm32_iwdg_of_match,
>  	},
>  };
>  module_platform_driver(stm32_iwdg_driver);
> -- 
> 2.40.1
> 
