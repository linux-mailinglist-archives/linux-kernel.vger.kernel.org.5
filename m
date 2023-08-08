Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFA8774338
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjHHR7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbjHHR6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:58:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9362BC8C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:26:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bfcf4c814so857605666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691511970; x=1692116770;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=mFOhD8TvrN3kEaAYXPGjF3oU27kR58bUIX2cHeJs6g4=;
        b=PZLSpR69RMBQyilZN2WmQD85JwYyqFvemcw58IiL6phq8DwXJNn6TnYWSif4ZBBdCZ
         /dnV779vGXfcFqnwyx98kqmow3wJEE0xdMvtDohKjHkPJ0MnWVm4Tl7e+WMtitbRENh2
         d7ASRcWyi0T8sn38pHp7/LwwcUw/j2jMXnhI+Hf4HVYj5DeBUMdEBJlRnKWzM2dFGy7F
         BUIccnQbTkQr39WKkcY2nilILPybuiDEFfs9nf3gmGgla9t2sScCljGJT8IaaHErAEqu
         FbdVtT+QYRExmQb1mW0+GzWYx6PjnkaZvBreOvHkWCN1Wdoipijh847EQdaAovMmXtWw
         dbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511970; x=1692116770;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFOhD8TvrN3kEaAYXPGjF3oU27kR58bUIX2cHeJs6g4=;
        b=Gr7vLPi4CooMm7DKtI1yANYZbveMhPHRyPRSocMtrMRooPmfWIrhI2cfuWUBXQlwFq
         Bm/COWtXF7kn0fqHJYBuGChdPm5bELCApH8vQq32m/as5JdgJCAtVJWfsFMpqtF6i6IF
         34TenjNdVZoFceVtoUOgvJXq/XV2s2/lFT3EkfaSXWGdeRq5FSHopWDG/6ZU+PJPJIMg
         TAPUISwrP1akbWgXgzSOGpdf1p2YldzgsVaTo/XUZ7DXy/YzQzn7dMqw5CQWmGUUFKwR
         Z37ZmpuG70aGcqCIz0yBhbb4R2dk1UU9taKU77Mtqf/NHObUkQb82ebms7TIDWAh9Yx/
         PHmw==
X-Gm-Message-State: AOJu0YyLRlL+SkvfFzIpA2fSIEPguGWRuYSyNK7QdUAM3j4HhH+LdmEE
        U4IrDCIA/U6DRKJXdXY1TKzyk4xZ280nLPbPTmA=
X-Google-Smtp-Source: AGHT+IFozB535bQ3dsOdzC8ibC2SVAdeAA6xH1Rr7AndjIWl+K+Gm3Yi/Og8fGDBzvdPVLlNGUdwCw==
X-Received: by 2002:a05:6000:1247:b0:317:f4c2:a99d with SMTP id j7-20020a056000124700b00317f4c2a99dmr2600500wrx.53.1691501231461;
        Tue, 08 Aug 2023 06:27:11 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:efd4:f3df:2c50:1776])
        by smtp.gmail.com with ESMTPSA id r2-20020a5d4942000000b003063a92bbf5sm13729592wrs.70.2023.08.08.06.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 06:27:11 -0700 (PDT)
References: <20230731042807.1322972-1-wenst@chromium.org>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: meson: meson8b: Simplify notifier clock lookup
Date:   Tue, 08 Aug 2023 15:21:46 +0200
In-reply-to: <20230731042807.1322972-1-wenst@chromium.org>
Message-ID: <1jpm3xoea9.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 31 Jul 2023 at 12:27, Chen-Yu Tsai <wenst@chromium.org> wrote:

> The driver registers a clock notifier by first getting the name of one
> of its clocks it just registered, then uses the name to look up the
> clock. The lookup is not needed, since each clock provider already
> has a clock attached to it. Use that instead to get rid of a
> __clk_lookup() call.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Found this could be simplified while looking through some clk core code.
>
>
>  drivers/clk/meson/meson8b.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> index 827e78fb16a8..c4336ac012bf 100644
> --- a/drivers/clk/meson/meson8b.c
> +++ b/drivers/clk/meson/meson8b.c
> @@ -3793,7 +3793,6 @@ static void __init meson8b_clkc_init_common(struct device_node *np,
>  {
>  	struct meson8b_clk_reset *rstc;
>  	struct device_node *parent_np;
> -	const char *notifier_clk_name;
>  	struct clk *notifier_clk;
>  	struct regmap *map;
>  	int i, ret;
> @@ -3847,9 +3846,7 @@ static void __init meson8b_clkc_init_common(struct device_node *np,
>  	 * tricky programming sequence will be handled by the forthcoming
>  	 * coordinated clock rates mechanism once that feature is released.
>  	 */
> -	notifier_clk_name = clk_hw_get_name(&meson8b_cpu_scale_out_sel.hw);
> -	notifier_clk = __clk_lookup(notifier_clk_name);
> -	ret = clk_notifier_register(notifier_clk, &meson8b_cpu_nb_data.nb);
> +	ret = clk_notifier_register(meson8b_cpu_scale_out_sel.hw.clk, &meson8b_cpu_nb_data.nb);

Hi Chen-Yu,

Your patch seems valid, as CCF stands right now.

However, I believe there is a will to drop the 'struct clk' instance that
automatically gets created with each 'struct clk_hw'. This change would
not help going in this direction

Stephen, what do you think ? 

>  	if (ret) {
>  		pr_err("%s: failed to register the CPU clock notifier\n",
>  		       __func__);

