Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459317B97F7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbjJDWZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbjJDWZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:25:02 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50380D7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 15:24:58 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d8181087dc9so394933276.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 15:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696458297; x=1697063097; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gH30QPkyF/caBY3YS+rN5NHQoXS59+XKdr7laMCwC0E=;
        b=fH2h1lIEmZYJHcsbKulKvnsi04ejpIVxeUaRQCllnrQWJda+wy3kHaoOb9HRk9YlaV
         1WXtbjXFV9hTY+sUqWVXlhpsg1gC+1RXrYKx1dCKqM06PkDYUg3rcEKNeyGusk6jQ7D4
         XB9kqLYIxTIYaJzqPBA+kZLTaq6i3F3PwuraQdh7IZp1DpIG3TwczGnNtD9+RhOiHhHy
         9INDdQfOd/af2mUdIKVoc8sN+knjNs0GIbqQkSf1BBmcIHVC0gdiV9Uo7sEUmQB2r7s5
         Pw2pQjIcEQJAGrqBHrAOkrgy2EOTmD4WmzMNNPe9+Cwyf4pyvpImziPQ3bh46HpIyEpI
         VuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696458297; x=1697063097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gH30QPkyF/caBY3YS+rN5NHQoXS59+XKdr7laMCwC0E=;
        b=gdUzPsSS4krGi+bd7ghS5MxFVNZvl3Su+FbOiN3h9AO2ONw3ciM0koJUsqT1E5Svlr
         r8Vk/97pbpB1xi7FQpLuTHKd64H9CTNVOyojWplz4GQNIt2qxkPFycrZjfuinkuXikNN
         /3Q6UKuL4iuiY//8RLNz+JwNM9gTMFYnlZaZyd/NVgaIJNMImVZrT93t/LUNtAd2+/pC
         mbD74Ku6FKoardJ8OaCyIXnEqTHenTPGac+drKI6IFQboypdf1zP+Zi0m4GO6X7bLXlt
         s6crCO7vZCkhJ8RJiWgCs04NeXpFAl1pPbYeBdg0uojLqsrf6yTBJ6U3dLSu2kp4U6ot
         Jpcg==
X-Gm-Message-State: AOJu0Yxd0f7ZYFQS55gZ09YRTyCy5h2zvCjXGhueDYXmEZGrsRKXA1kk
        CzSZGTowGVZ6eEnFAhnMVUcpfutVNTJkv3byZUQROw==
X-Google-Smtp-Source: AGHT+IFo+3fXJ8TdbXgEN/Hz8y43/QTFuu7aQACpU8yUl344BH2AOBs1bXzHNFgaMnM5ALFgVPOmBpQhUdPplxGG4hI=
X-Received: by 2002:a25:7797:0:b0:d12:ab1:d88a with SMTP id
 s145-20020a257797000000b00d120ab1d88amr3426559ybc.40.1696458297530; Wed, 04
 Oct 2023 15:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230907095521.14053-1-Julia.Lawall@inria.fr> <20230907095521.14053-5-Julia.Lawall@inria.fr>
In-Reply-To: <20230907095521.14053-5-Julia.Lawall@inria.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Oct 2023 00:24:21 +0200
Message-ID: <CAPDyKFpEdFnJ5p+O2p-gr06mF9ug43Ss-=2uJeSVZzgrcTGzTg@mail.gmail.com>
Subject: Re: [PATCH 04/11] genpd: ti: add missing of_node_put
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Nishanth Menon <nm@ti.com>, kernel-janitors@vger.kernel.org,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, 7 Sept 2023 at 11:55, Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> for_each_node_with_property performs an of_node_get on
> each iteration, so a break out of the loop requires an
> of_node_put.
>
> This was done using the Coccinelle semantic patch
> iterators/for_each_child.cocci
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Applied for next (by amending the change to pmdomain instead of genpd), thanks!

Kind regards
Uffe

>
> ---
>  drivers/genpd/ti/ti_sci_pm_domains.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff -u -p a/drivers/genpd/ti/ti_sci_pm_domains.c b/drivers/genpd/ti/ti_sci_pm_domains.c
> --- a/drivers/genpd/ti/ti_sci_pm_domains.c
> +++ b/drivers/genpd/ti/ti_sci_pm_domains.c
> @@ -153,14 +153,18 @@ static int ti_sci_pm_domain_probe(struct
>                                         max_id = args.args[0];
>
>                                 pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
> -                               if (!pd)
> +                               if (!pd) {
> +                                       of_node_put(np);
>                                         return -ENOMEM;
> +                               }
>
>                                 pd->pd.name = devm_kasprintf(dev, GFP_KERNEL,
>                                                              "pd:%d",
>                                                              args.args[0]);
> -                               if (!pd->pd.name)
> +                               if (!pd->pd.name) {
> +                                       of_node_put(np);
>                                         return -ENOMEM;
> +                               }
>
>                                 pd->pd.power_off = ti_sci_pd_power_off;
>                                 pd->pd.power_on = ti_sci_pd_power_on;
>
