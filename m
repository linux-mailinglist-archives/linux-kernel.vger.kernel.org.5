Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D621C7D84E5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345301AbjJZOhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345180AbjJZOhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:37:03 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9651B2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:37:01 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1ea48ef2cbfso611559fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698331020; x=1698935820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0qleFEJdG0zueinUIrhZg05/V5NAw4EtMg/L1WU73us=;
        b=gz5p2yr4tSr0IV+WxdEQi2jepkXqTeImV3K+znSaDf4kMHSQEszK8jT0WOX8GAKL5j
         5h3Q47OaQhDjGKz9Mgk54ZsUhkCkoXfVxBwPslnOIyg0YVWAx/zLGXbgCr9yMANbpGn9
         GqEGAhZNvU3+XEY6BZyyK6TnzqWOkICUazoGX+JI5eVB09IWSwXtK9CFvqHy/rTKICh5
         P0Lk9HSgktsyW+6Wjf8mu5JPD/yoiXNm+4NI5lgYqY9o952rJlIuHXpRqy6nRiMkIm9M
         jdL8WKklwQ/CZKdJLRWpzBHGjqr6lszh1DICjQDoVbE3mE4b2f7iF1jrBdUXSqBvdC94
         LWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698331020; x=1698935820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qleFEJdG0zueinUIrhZg05/V5NAw4EtMg/L1WU73us=;
        b=Aygec2G/3hQQPjFtoXEImnPNwLIzQHPIWEZctTLikgt6GhZmRAcwqigDbEK97PeoAy
         dYoNwjdc4wjVut6qAh9JIW3Zd3MVyI0QNMA2dgMcGmUrEZhR8j4DIlGTb6c0O5JyWR+W
         f19qzWV1+hvwUUh6qWTCMEjwYalNUx/GBFe8GloyRZkqaNVwJJdOD2HmuUPwqDs/bOeD
         dUJ5UrxY7TWntbVUJEpREr5wYyCWXP0g7BdP3iGS362npWoZKSrY/Xn0F3hTeDjqs8w7
         A0RLu6e59cQtrlhPvUczS0WYjfjBgp7TrQd0FAds3S/gmNz0Wp09I4L+vcrC67dM7QOj
         HIHg==
X-Gm-Message-State: AOJu0Yx9PyjOD+Ngn/XIzQtanLbPnVt6aYWER4JkWzItUpKazTYWmOBi
        x3RWDoUOoE8NE7YAFsxfXJaGdC5saePY7UzkDYubJA==
X-Google-Smtp-Source: AGHT+IFzO5fLLLCSGUIZrhR1xwkvkiqrpeK/PDBIT4lzxm4y31BDe65GR+q2L7o3FGE3xTEAsLhmmntURr0yQsFbULI=
X-Received: by 2002:a05:6870:c49:b0:1ea:385:518b with SMTP id
 lf9-20020a0568700c4900b001ea0385518bmr21485497oab.3.1698331020473; Thu, 26
 Oct 2023 07:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231016080205.41982-1-tomeu@tomeuvizoso.net> <20231016080205.41982-2-tomeu@tomeuvizoso.net>
In-Reply-To: <20231016080205.41982-2-tomeu@tomeuvizoso.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 26 Oct 2023 16:36:24 +0200
Message-ID: <CAPDyKFqEP50MBE0_t5tAfsrdx8EOy5MGQWqfX0a_8FA-3cJe8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] pmdomain: amlogic: Fix mask for the second NNA mem PD domain
To:     Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc:     linux-kernel@vger.kernel.org, Da Xue <da@libre.computer>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 at 10:02, Tomeu Vizoso <tomeu@tomeuvizoso.net> wrote:
>
> Without this change, the NPU hangs when the 8th NN core is used.
>
> It matches what the out-of-tree driver does.
>
> Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

The change looks good to me, but I have been awaiting an ack from some
of the platform/soc maintainers before applying.

That said, it looks like we need a fixes/stable tag too. Is there a
certain commit this fixes?

Kind regards
Uffe

> ---
>  drivers/pmdomain/amlogic/meson-ee-pwrc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/amlogic/meson-ee-pwrc.c b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
> index cfb796d40d9d..0dd71cd814c5 100644
> --- a/drivers/pmdomain/amlogic/meson-ee-pwrc.c
> +++ b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
> @@ -228,7 +228,7 @@ static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_audio[] = {
>
>  static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_nna[] = {
>         { G12A_HHI_NANOQ_MEM_PD_REG0, GENMASK(31, 0) },
> -       { G12A_HHI_NANOQ_MEM_PD_REG1, GENMASK(23, 0) },
> +       { G12A_HHI_NANOQ_MEM_PD_REG1, GENMASK(31, 0) },
>  };
>
>  #define VPU_PD(__name, __top_pd, __mem, __is_pwr_off, __resets, __clks)        \
> --
> 2.41.0
>
