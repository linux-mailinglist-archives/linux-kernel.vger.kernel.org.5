Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24DF77AF1A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 03:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjHNBJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 21:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjHNBJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 21:09:15 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEF312D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 18:09:14 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40fe9c38800so22950531cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 18:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691975353; x=1692580153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z39hsVEXdUQ6zyNr9B1NB0tHQHTCQbBTm2J5hNMMMZ0=;
        b=FqQcgMQQcSsm0MQFpqR3cKlEAFrB68Sef+1DSekVS7nzxO4KnwancdahLuauSt2pwz
         k1yakpc4aW8G5lApsu1Az3pNEcBZHMfHpnSO8L0mSvAAvjtal9tDydKBZwB+w6B+6ann
         tl0vf7EdltUsWJzW+lcBpTZaBv+5SJr9ZEyiZ7gSdXj//nYqw5Cg2NgmbutlFXcr7ld5
         6zU10zjATNtQuekv0Hu4OTDZp32NLBoF22VeTN6iOgMnZzQfJigcQyXRra0GVe2HAwIS
         q2yRixkWFUXFhvmiM6UhtLhUgASY23NNSA8o9DPmQ3oBo4+As7u+xOw8XgVFGAcSRaOH
         G7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691975353; x=1692580153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z39hsVEXdUQ6zyNr9B1NB0tHQHTCQbBTm2J5hNMMMZ0=;
        b=CoMC9s/93Xb6Jy/s4oLdgc4if68FWntCp7VkmfIzQ3kbl08aaANwYIiMMnVZmclqE4
         lifO7ppEafojfXF43xYp3Ihh0SjcwJf0a4nmty6jrzp8CBIzwyiwIR0mOOgM9I0TYO+I
         C//xhYkNTx+i9qPoauJGbHwKDiAd4aQ6u/vOD0WRUqJX0MYivcOP/fg2NbNwbJ1zYgBR
         lyK3sWda0XKl/zfeJTr0irpCVbR3H+CNwTWwu+sDDKWmWv4pue8OXUQBgYDwOf4XGeni
         UPG9CxgdhE9O1i4VK2omuQxfZQ4/BcuvRdxBFxk6aBJ5ZUKJWdeM9kweExlh5dAPBP8W
         231Q==
X-Gm-Message-State: AOJu0YwlIwOW5nW7HsUDmM9ttHS7ruMvQP9Sedj3aTz40tuyWOQC2i8y
        1hEq+bM58tcPg/cpWFFaVslkoRAT6U4=
X-Google-Smtp-Source: AGHT+IGJoeT5OB2DJvvWDFhtBSBwiknL//jZ5DnGBsIKTaFhTIxfRdG6r5BNMGouvWRp9biHd0rDGg==
X-Received: by 2002:ac8:5bc3:0:b0:40f:2e2c:6df4 with SMTP id b3-20020ac85bc3000000b0040f2e2c6df4mr11111479qtb.6.1691975353425;
        Sun, 13 Aug 2023 18:09:13 -0700 (PDT)
Received: from localhost (rrcs-108-176-112-203.nys.biz.rr.com. [108.176.112.203])
        by smtp.gmail.com with ESMTPSA id g3-20020ac870c3000000b0040f200feb4fsm2719805qtp.80.2023.08.13.18.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 18:09:13 -0700 (PDT)
Date:   Sun, 13 Aug 2023 18:09:12 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 4/4] genirq/irq_sim: shrink code by using cleanup helpers
Message-ID: <ZNl+uKweuqJKaMcb@yury-ThinkPad>
References: <20230812194457.6432-1-brgl@bgdev.pl>
 <20230812194457.6432-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812194457.6432-5-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 09:44:57PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Use the new __free helper from linux/cleanup.h to remove all gotos and
> simplify the error paths.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  kernel/irq/irq_sim.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> index a8b013d0c5be..202beb1169c9 100644
> --- a/kernel/irq/irq_sim.c
> +++ b/kernel/irq/irq_sim.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/irq_sim.h>
> @@ -170,34 +171,29 @@ static const struct irq_domain_ops irq_sim_domain_ops = {
>  struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
>  					 unsigned int num_irqs)
>  {
> -	struct irq_sim_work_ctx *work_ctx;
> +	struct irq_sim_work_ctx *work_ctx __free(kfree) = NULL;
> +	unsigned long *pending __free(bitmap) = NULL;

Why initializing here as NULL ...
  
>  	work_ctx = kmalloc(sizeof(*work_ctx), GFP_KERNEL);
>  	if (!work_ctx)
> -		goto err_out;
> +		return ERR_PTR(-ENOMEM);
>  
> -	work_ctx->pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
> -	if (!work_ctx->pending)
> -		goto err_free_work_ctx;
> +	pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
> +	if (!pending)
> +		return ERR_PTR(-ENOMEM);

and overriding immediately after that? Not familiar to __free()
machinery in details, although. Does it require initialization?

Thank,
Yury
