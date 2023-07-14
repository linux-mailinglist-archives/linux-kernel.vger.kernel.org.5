Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D5A7536B3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjGNJf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbjGNJfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:35:18 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03AB3AB5;
        Fri, 14 Jul 2023 02:34:58 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b703c900e3so25433421fa.1;
        Fri, 14 Jul 2023 02:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689327268; x=1691919268;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=319xj+Bvw/t8XftWtBPIDtvZAknBgoYfRmK9iRu0nCQ=;
        b=FmJNLsSxnyQGa2hlWCZvrYEg9Iz2Jku3fWJ9dOKYwugzlR1FqCv5g7MI7xjm7YRlYG
         x9ssnFZg+/mMBsFIUUfRlpwQnvmSGfmXWDtd47k3CopnLGIUjEQ/fGqf69KmfwoaC4Qq
         U59lPozyz2z3ruWIizP6nClpDH9aBaaerVIaVCPpoT7VOVohTpgPV+YbMVsEkW020lpE
         TGZcQY5IjBUVaLWbSlMmRIUE+Y1V7PtHzkDWYYpFgTZ77DZKi234M0FmZNjY29dGKk/3
         JJcUkxJOwB/osz72LBFhvDPhJTnBTvIpLBSKREei6hA8tH8oT9mMYzjrxc/43hDNHYLg
         J/4g==
X-Gm-Message-State: ABy/qLbMugWazh1+1b3qPie5L7JOv1K2VM5RozB48zSInKwAePkTt/a+
        QenAjhLULcnPKuagN6cPlIYj6jWBP6/M3KOgKRxicmOX
X-Google-Smtp-Source: APBJJlFwb+212L3SRkqSxOzBhBHdFw9JLFCb0RgcKAtKkzmn+t2CMOvyxqsGYYdgBti+gf8e1ghfWoUTZP/J1eq5uaQ=
X-Received: by 2002:a2e:7a0e:0:b0:2b6:fa92:479e with SMTP id
 v14-20020a2e7a0e000000b002b6fa92479emr3580876ljc.42.1689327267603; Fri, 14
 Jul 2023 02:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <085541814ebe2543cb7e8a31004c0da3e7d5b6eb.1688760111.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <085541814ebe2543cb7e8a31004c0da3e7d5b6eb.1688760111.git.christophe.jaillet@wanadoo.fr>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Fri, 14 Jul 2023 11:34:14 +0200
Message-ID: <CANBLGcz+9V9mWQM6Xt9_F_1q3GhCS0zNisrtYPa=SwNT+tGEyQ@mail.gmail.com>
Subject: Re: [PATCH] clk: starfive: Simplify .determine_rate()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Hal Feng <hal.feng@starfivetech.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 at 22:02, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> jh71x0_clk_mux_determine_rate() is the same as __clk_mux_determine_rate(),
> so use the latter to save some LoC.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks!
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  drivers/clk/starfive/clk-starfive-jh71x0.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c b/drivers/clk/starfive/clk-starfive-jh71x0.c
> index b372083d11c3..aebc99264a0b 100644
> --- a/drivers/clk/starfive/clk-starfive-jh71x0.c
> +++ b/drivers/clk/starfive/clk-starfive-jh71x0.c
> @@ -174,12 +174,6 @@ static int jh71x0_clk_set_parent(struct clk_hw *hw, u8 index)
>         return 0;
>  }
>
> -static int jh71x0_clk_mux_determine_rate(struct clk_hw *hw,
> -                                        struct clk_rate_request *req)
> -{
> -       return clk_mux_determine_rate_flags(hw, req, 0);
> -}
> -
>  static int jh71x0_clk_get_phase(struct clk_hw *hw)
>  {
>         struct jh71x0_clk *clk = jh71x0_clk_from(hw);
> @@ -261,7 +255,7 @@ static const struct clk_ops jh71x0_clk_gdiv_ops = {
>  };
>
>  static const struct clk_ops jh71x0_clk_mux_ops = {
> -       .determine_rate = jh71x0_clk_mux_determine_rate,
> +       .determine_rate = __clk_mux_determine_rate,
>         .set_parent = jh71x0_clk_set_parent,
>         .get_parent = jh71x0_clk_get_parent,
>         .debug_init = jh71x0_clk_debug_init,
> @@ -271,7 +265,7 @@ static const struct clk_ops jh71x0_clk_gmux_ops = {
>         .enable = jh71x0_clk_enable,
>         .disable = jh71x0_clk_disable,
>         .is_enabled = jh71x0_clk_is_enabled,
> -       .determine_rate = jh71x0_clk_mux_determine_rate,
> +       .determine_rate = __clk_mux_determine_rate,
>         .set_parent = jh71x0_clk_set_parent,
>         .get_parent = jh71x0_clk_get_parent,
>         .debug_init = jh71x0_clk_debug_init,
> --
> 2.34.1
>
