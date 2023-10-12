Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274427C725F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379476AbjJLQV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347214AbjJLQVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:21:54 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFDAD3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:21:53 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-35135f69de2so3864565ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697127711; x=1697732511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RnUFxt3XAIfdwYUO6iyQ755NzkFZ938qAzLabRmEMTQ=;
        b=d+3GRbglvabl4y+TsD+IcaJJU519pJzthI44hy4yhPvi1kbuCYST1O1fhX9q8318Zp
         Cxzc9QiDe+Uvhvu13I0SQqTJRKE9lewB2YqnhCujV0c0/Oqzp+E5tA8S3J+Eriaj4KFJ
         /MJKPnVlQx0XjThtngEQ3CaWqhbKURERvrco8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697127711; x=1697732511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnUFxt3XAIfdwYUO6iyQ755NzkFZ938qAzLabRmEMTQ=;
        b=rP9Ra4/bkdH75u5JY9u3tvD2m53D2DAhdKAdXRJncD3vy/oyWgzbd4aLIWMIx/IbBP
         qNq04dRY4N/U3ulEKxAFc/t/ZWKjZWN7CNSoI4YPLqBx1BFaUtDocMYukwdhixcqJ6DX
         oVkea2Chp72ADnlWWzwAlcdJdsbqO6a8GukCQW85bT9d4xLkZZqSgetIa0C0lkhwYUvd
         MY2ojxg8ttS0VGCx01o/65j2zg4yVbUqu9tA9gGlXQ29+qFB9z7876oNoI2L+YHVp9qH
         NwtAxV/4c729T37uAetzsIq7RWqN8zGc/qRD6ZNwCE8qdOy1ki7chgbRRBd9KdrQw9nb
         bgJA==
X-Gm-Message-State: AOJu0YwlRXDVhQbpnV5jRgIibQEBQkMjXHI0y8e8fvWYMOvIAvI7fDIq
        KJFXDQOM02YGO5xNeS/wqb2ruA==
X-Google-Smtp-Source: AGHT+IEWGQ9eUG3d0le5HxUu8fZk/NWTi2Ecg9QtVgd0vbLPSzFyiDtZh8Vq3M+46SAhJg6gaiMmZg==
X-Received: by 2002:a05:6e02:b22:b0:34f:f6f0:d4eb with SMTP id e2-20020a056e020b2200b0034ff6f0d4ebmr30650521ilu.21.1697127711489;
        Thu, 12 Oct 2023 09:21:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n7-20020a62e507000000b00693411c6c3csm11927054pff.39.2023.10.12.09.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:21:51 -0700 (PDT)
Date:   Thu, 12 Oct 2023 09:21:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] clk: visconti: Add bounds-checking coverage
 for struct visconti_pll_provider
Message-ID: <202310120921.3F24CB2E@keescook>
References: <cover.1697076650.git.gustavoars@kernel.org>
 <675633f7ae9893371d35b238f06fd02a3acffebb.1697076650.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <675633f7ae9893371d35b238f06fd02a3acffebb.1697076650.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 08:18:45PM -0600, Gustavo A. R. Silva wrote:
> In order to gain the bounds-checking coverage that __counted_by provides
> to flexible-array members at run-time via CONFIG_UBSAN_BOUNDS (for array
> indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions),
> we must make sure that the counter member, in this particular case `num`,
> is updated before the first access to the flex-array member, in this
> particular case array `hws`. See below:
> 
> commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
> __counted_by") introduced `__counted_by` for `struct clk_hw_onecell_data`
> together with changes to relocate some of assignments of counter `num`
> before `hws` is accessed:
> 
> include/linux/clk-provider.h:
> 1380 struct clk_hw_onecell_data {
> 1381         unsigned int num;
> 1382         struct clk_hw *hws[] __counted_by(num);
> 1383 };
> 
> However, this structure is used as a member in other structs, in this
> case in `struct visconti_pll_provider`:
> 
> drivers/clk/visconti/pll.h:
>  16 struct visconti_pll_provider {
>  17         void __iomem *reg_base;
>  18         struct device_node *node;
>  19 
>  20         /* Must be last */
>  21         struct clk_hw_onecell_data clk_data;
>  22 };
> 
> Hence, we need to move the assignments to `ctx->clk_data.num` after
> allocation for `struct visconti_pll_provider` and before accessing the
> flexible array `ctx->clk_data.hws`. And, as assignments for all members
> in `struct visconti_pll_provider` are originally adjacent to each other,
> relocate all assignments together, so we don't split up
> `ctx->clk_data.hws = nr_plls` from the rest. :)
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks good; thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
