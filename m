Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423C67C5F36
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjJKVlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjJKVlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:41:06 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975719E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:41:05 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-57b6c7d0cabso188876eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697060465; x=1697665265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C9utCBiCdOTyVV2yijJlin/2F56vToEAaXQDWZUK9xk=;
        b=KfXaPkm7m+oRIwlMiiIHcsazYgkO86v1Sj8k3lCn9TH50FLrc2yiYBBJ5R5cjl0DPG
         L1Xo7xDo9UrUr/nnsmadHroZ+fPaC8ZadTSjcIMxr5eqah8BKMR6KZUwRCoeXhkmtnxf
         BPhnkM6Q4Vj5NR0J9d61kFaJAjFyllD+i6ums=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697060465; x=1697665265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9utCBiCdOTyVV2yijJlin/2F56vToEAaXQDWZUK9xk=;
        b=GFwuotKeFvP30Ol8MUsPoRw6hSJLR0n5LZQGNytlxhjLoSqU2pbBYLTwxWygKtPJl1
         JrJY/gQ2uwka8e8nb8qXzMbDh8VMpg3JRN47Qdc2qDJ91WQlxx/eAQHlloqGwH0Wv6om
         y5uYlJ6fk21aSupMSyRjvMY7OD56vEJStcQvOA5ls5DzSGDMHMxUuoKrBdA9iicch3n4
         Xv3NQeA14/6vp5UhzT4cQy1RwjlFKIXS9dgys+nyIO0qYAyF2xNa8abhJ7QyQvrGndVT
         wzzPdI25+PXjIEEse3YfU8v7kZekbVuiI2S/TSvOY9jzgY3VhuIn/yWoM1L4UZo9uGiP
         pjrQ==
X-Gm-Message-State: AOJu0YyfyIfyo2qkYtdyx9Nmy1ntzzN5g/bdN3CQ/Ehs0F+15TjfsIWS
        n3fWjLyt+P8xUe+suPyJ+sUE/Q==
X-Google-Smtp-Source: AGHT+IHI060ARBfAOQ+6J3AvSpXVQH9lS2coXsGbCtUx/R3qXp2HCId6KikW4ulIVwWsbBAQB9J9FA==
X-Received: by 2002:a05:6358:2496:b0:13a:cb52:4837 with SMTP id m22-20020a056358249600b0013acb524837mr20580632rwc.31.1697060464890;
        Wed, 11 Oct 2023 14:41:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c26-20020aa781da000000b0068be3489b0dsm10864161pfn.172.2023.10.11.14.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:41:04 -0700 (PDT)
Date:   Wed, 11 Oct 2023 14:41:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] clk: socfpga: agilex: Add bounds-checking
 coverage for struct stratix10_clock_data
Message-ID: <202310111439.35CB04432F@keescook>
References: <cover.1697059539.git.gustavoars@kernel.org>
 <fd4cd8503316d536e1a84fa2ae5bdefdd4b24afe.1697059539.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd4cd8503316d536e1a84fa2ae5bdefdd4b24afe.1697059539.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 03:35:26PM -0600, Gustavo A. R. Silva wrote:
> In order to gain the bounds-checking coverage that __counted_by provides
> to flexible-array members at run-time via CONFIG_UBSAN_BOUNDS (for array
> indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions),
> we must make sure that the counter member, in this case `num`, is updated
> before the first access to the flex-array member, in this case array `hws`.
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
> case in `struct sstratix10_clock_data`:
> 
> drivers/clk/socfpga/stratix10-clk.h:
>   9 struct stratix10_clock_data {
>  10         void __iomem            *base;
>  11 
>  12         /* Must be last */
>  13         struct clk_hw_onecell_data      clk_data;
>  14 };
> 
> Hence, we need to move the assignments to `clk_data->clk_data.num` after
> allocations for `struct stratix10_clock_data` and before accessing the
> flexible array `clk_data->clk_data.hws`. And, as assignments for both
> `clk_data->clk_data.num` and `clk_data->base` are originally adjacent to
> each other, relocate both assignments together.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Yeah, ew. That's super tricky. Nice find.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
