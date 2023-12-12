Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8681C80F3AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376376AbjLLQyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjLLQyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:54:43 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3AA95;
        Tue, 12 Dec 2023 08:54:49 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3ba10647a19so1473441b6e.3;
        Tue, 12 Dec 2023 08:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702400088; x=1703004888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZ+S0orBz6C1ng5onoO/NzTMLdkN0FeeuOcfpzewD3s=;
        b=WaewN0hwLeWTTwkFfzwHkDGymCE7FrqMoqsQ5pLQya6IJJYJ6PWJj+9MgurHpC43US
         mKtoHo5lAPXhwbJ+qOnSe50usi5364iQFOmVwdCbVwiT9spo3CZgfBZAvjQDUSgcIs57
         TcJNrGA9PUlSxtb/YVNovsRrDEM9TSaT9TUZc7ufpZNhOn+VesbPJEzhfhdOzBLe+Tup
         OyxmMxvCF/lSbC6XNucEfb9uWZt09aP1gaegA7DVMk4iWBcjFCNah1omVk/b6w/NFD9C
         PuIYpstPIRuQygmM3gBCg5H+WGUTjCX1mkIinDOLcxehsZImuPEIfEdFOQPoF/c2/wzj
         WHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702400088; x=1703004888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZ+S0orBz6C1ng5onoO/NzTMLdkN0FeeuOcfpzewD3s=;
        b=gdkD7LXZmmFNUmfpkUyGmEoApMJ8n2TZ5eOaCJb6pDY1c78QMhmXwuccUHiteSnMIF
         xWE97PtfY2X0rXOftCvur6LWLPJMAIRBqi5nvyZ9eYFEqPch20ZyCdfSScvizipW4kfV
         ePeNYG3wc/XwJuoGm38aFJDByk0XFWPBnZXMMhI9+UCdHLVeXGABVt0H6Oqp3GzHnpYu
         rihagKeU/UGBN9iR8sk+llSh7Ni6VYF3cXakqG5bAsdlUyYtVBF7APc5T2WzFdNzem/D
         Erx6HnpaDhRYVbGdi+d+fU1z2CRENxXaVqzOLcC68nPFhwEZzXV6bnHRj+riyWnNvA/f
         UkZA==
X-Gm-Message-State: AOJu0Yw7biIFJ7GA8RC5kPE0ZHHUJ9yCSJ5Kq+otRrE7xaCcxidkyxm/
        d4bhKnDqq0N5LU93wuYI5Mw=
X-Google-Smtp-Source: AGHT+IGJ2u/eLfuLHjm7rOZQXRm7UyYQB4WC6Nc4Q5fBFWnt8iBIvRvKdqdc9NEQZrDNte02vEFkRA==
X-Received: by 2002:a05:6870:d18c:b0:1fb:75a:de85 with SMTP id a12-20020a056870d18c00b001fb075ade85mr7948203oac.115.1702400088572;
        Tue, 12 Dec 2023 08:54:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id lu10-20020a056871314a00b001fb08477cf3sm3259833oac.47.2023.12.12.08.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 08:54:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 12 Dec 2023 08:54:45 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        samin.guo@starfivetech.com, xingyu.wu@starfivetech.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: starfive: add lock annotations to fix context
 imbalances
Message-ID: <794a9aa8-b948-4479-98fd-4417c0f08965@roeck-us.net>
References: <20231122085118.177589-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122085118.177589-1-ben.dooks@codethink.co.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 08:51:18AM +0000, Ben Dooks wrote:
> Add the necessary __acquires() and __releases() to the functions
> that take and release the wdt lock to avoid the following sparse
> warnings:
> 
> drivers/watchdog/starfive-wdt.c:204:13: warning: context imbalance in 'starfive_wdt_unlock' - wrong count at exit
> drivers/watchdog/starfive-wdt.c:212:9: warning: context imbalance in 'starfive_wdt_lock' - unexpected unlock
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/starfive-wdt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
> index 5f501b41faf9..49b38ecc092d 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c
> @@ -202,12 +202,14 @@ static u32 starfive_wdt_ticks_to_sec(struct starfive_wdt *wdt, u32 ticks)
>  
>  /* Write unlock-key to unlock. Write other value to lock. */
>  static void starfive_wdt_unlock(struct starfive_wdt *wdt)
> +	__acquires(&wdt->lock)
>  {
>  	spin_lock(&wdt->lock);
>  	writel(wdt->variant->unlock_key, wdt->base + wdt->variant->unlock);
>  }
>  
>  static void starfive_wdt_lock(struct starfive_wdt *wdt)
> +	__releases(&wdt->lock)
>  {
>  	writel(~wdt->variant->unlock_key, wdt->base + wdt->variant->unlock);
>  	spin_unlock(&wdt->lock);
> -- 
> 2.37.2.352.g3c44437643
> 
> 
