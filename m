Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C6075CDF1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjGUQP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjGUQPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:15:37 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0062E44A8;
        Fri, 21 Jul 2023 09:15:00 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-78372b896d0so90665639f.2;
        Fri, 21 Jul 2023 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689956100; x=1690560900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMqpAHzPpQ8p1VY1demvfqMIMPRVFFpZskkZxzdoi/4=;
        b=kOiuronFPr5v6XeELMEAdxOfWvDrFi3wKedhBRC5NHp+m8wIcgNErDvBMkzT+/pwNG
         N8B+ZOLREoBDcA6ZgvBhVI9VBThCndaKBKtuc2b8OUTpBkV2XCEOSPM9P7hl2SQJFFGB
         FFs7P16tclcgZRx3keARryU9ib/Ja1tLL03bKkcscHhgE0YRPsN5hFRcQFmFXpBjeqE6
         y8c9B/wwln73DFqu80WmGYfzv/pKcItBOqT/npi7TQ2rXOw6HMKMHTRH2VrWC8dFsbDD
         vzql/apz7PD6Pjer3SJPrV1dWM5uA/SSxkQnWvM3Bw7UwbZc9g9c7XYGcKzEC6e54P1g
         nFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689956100; x=1690560900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMqpAHzPpQ8p1VY1demvfqMIMPRVFFpZskkZxzdoi/4=;
        b=FknxYQgdkIHbH5+LQ19zM15CjyB8UTJN0Lx9s8KHBhVpSUE/FVZj2wOVWPlBbD1Oul
         msXXIA+NR1/vpilsuiwz9/tiirwLwBL+UZImuE1UGQDIKS0nutm4gPenIEx7J7IUWF1+
         vCR/ugTfUXgDM9J+Gy44WS2xCh4/91H/yFEeLNOcbCu7NB7uaY3p1Ppd7cGxHrEIP97W
         Y4fgWD802zXAv4OQE2LMsRo4xv+pym+tRXnMwyj5Y59sYMhGefxMfq1Qg/LdJ6f+FxPK
         CncM6UwK900yMzZKnowI+wz4dYgnpYcc2xLeRU+nLKtnekoCOK1cclk488Fk+EeOhUvi
         FYow==
X-Gm-Message-State: ABy/qLbREZimhjSTcBZ2nSDaOLhgreTc1ulpY7Tu2ZHS0lnHYNVuRis+
        /LLngUfXrAfVFHF+CkP3YNZ/EAV6/E8=
X-Google-Smtp-Source: APBJJlF+f35Yb0+g5e78f9uulM6sqmJPBfWO7GHpoL7PJLABO7/taWVAd3e1hpvG4e8BOmuIxIh+xA==
X-Received: by 2002:a05:6602:2993:b0:787:8fc:307d with SMTP id o19-20020a056602299300b0078708fc307dmr465985ior.5.1689956100196;
        Fri, 21 Jul 2023 09:15:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j9-20020a02cc69000000b0042b45d29facsm1076088jaq.152.2023.07.21.09.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:14:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 21 Jul 2023 09:14:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>
Subject: Re: [PATCH 1/2] clk: Introduce kunit wrapper around
 clk_hw_init_rate_request
Message-ID: <24a22c85-d4f6-4598-a95f-a1f0503978a2@roeck-us.net>
References: <20230721-clk-fix-kunit-lockdep-v1-0-32cdba4c8fc1@kernel.org>
 <20230721-clk-fix-kunit-lockdep-v1-1-32cdba4c8fc1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721-clk-fix-kunit-lockdep-v1-1-32cdba4c8fc1@kernel.org>
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

On Fri, Jul 21, 2023 at 09:09:32AM +0200, Maxime Ripard wrote:
> Some kunit tests are meant to test the behaviour of providers (and
> most notably __clk_determine_rate()), but don't run those functions with
> the clk prepare_lock held which results in lockdep warning.
> 
> clk_hw_init_rate_request is one of the functions being executed from a
> test which should have the lock held. Let's introduce a wrapper around
> it meant to be used only by kunit tests.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/linux-clk/2b594e50-2bbf-4a2d-88e6-49fc39f3957a@roeck-us.net/
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Link: https://lore.kernel.org/oe-lkp/202301310919.b9d56ee3-yujie.liu@intel.com
> Fixes: 262ca38f4b6e ("clk: Stop forwarding clk_rate_requests to the parent")
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/clk/clk.c            | 26 ++++++++++++++++++++++++++
>  drivers/clk/clk_test.c       |  2 +-
>  include/linux/clk-provider.h | 11 +++++++++++
>  3 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c249f9791ae8..8ee9bd02af76 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -6,6 +6,7 @@
>   * Standard functionality for the common clock API.  See Documentation/driver-api/clk.rst
>   */
>  
> +#include <kunit/test-bug.h>
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/clk/clk-conf.h>
> @@ -1556,6 +1557,31 @@ void clk_hw_init_rate_request(const struct clk_hw *hw,
>  }
>  EXPORT_SYMBOL_GPL(clk_hw_init_rate_request);
>  
> +#if IS_ENABLED(CONFIG_KUNIT)
> +/**
> + * clk_kunit_init_rate_request - Initializes a clk_rate_request
> + * @hw: the clk for which we want to submit a rate request
> + * @req: the clk_rate_request structure we want to initialise
> + * @rate: the rate which is to be requested
> + *
> + * Initializes a clk_rate_request structure to submit to
> + * __clk_determine_rate() or similar functions. Only usable in kunit
> + * test contexts, use clk_hw_init_rate_request() otherwise.
> + */
> +void clk_kunit_init_rate_request(const struct clk_hw *hw,
> +				 struct clk_rate_request *req,
> +				 unsigned long rate)
> +{
> +	if (!kunit_get_current_test())
> +		return;
> +
> +	clk_prepare_lock();
> +	clk_hw_init_rate_request(hw, req, rate);
> +	clk_prepare_unlock();
> +}
> +EXPORT_SYMBOL_GPL(clk_kunit_init_rate_request);
> +#endif
> +
>  /**
>   * clk_hw_forward_rate_request - Forwards a clk_rate_request to a clock's parent
>   * @hw: the original clock that got the rate request
> diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
> index a154ec9d0111..a64f7036baa3 100644
> --- a/drivers/clk/clk_test.c
> +++ b/drivers/clk/clk_test.c
> @@ -2230,7 +2230,7 @@ static void clk_leaf_mux_set_rate_parent_determine_rate(struct kunit *test)
>  	rate = clk_get_rate(clk);
>  	KUNIT_ASSERT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
>  
> -	clk_hw_init_rate_request(hw, &req, DUMMY_CLOCK_RATE_2);
> +	clk_kunit_init_rate_request(hw, &req, DUMMY_CLOCK_RATE_2);
>  
>  	ret = __clk_determine_rate(hw, &req);
>  	KUNIT_ASSERT_EQ(test, ret, 0);
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 0f0cd01906b4..efdebfa3fce9 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -67,6 +67,17 @@ struct clk_rate_request {
>  void clk_hw_init_rate_request(const struct clk_hw *hw,
>  			      struct clk_rate_request *req,
>  			      unsigned long rate);
> +#if IS_ENABLED(CONFIG_KUNIT)
> +void clk_kunit_init_rate_request(const struct clk_hw *hw,
> +				 struct clk_rate_request *req,
> +				 unsigned long rate);
> +#else
> +static inline void clk_kunit_init_rate_request(const struct clk_hw *hw,
> +					       struct clk_rate_request *req,
> +					       unsigned long rate)
> +{
> +}
> +#endif
>  void clk_hw_forward_rate_request(const struct clk_hw *core,
>  				 const struct clk_rate_request *old_req,
>  				 const struct clk_hw *parent,
> 
> -- 
> 2.41.0
> 
