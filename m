Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644F678E0C5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239816AbjH3UfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239648AbjH3UfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:35:04 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C596197
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:34:28 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2bcfdadd149so4426521fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693427539; x=1694032339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLCoDOwQGEKKT36J+ipHqolgSMsTG2oKzWJ8DH6wGMg=;
        b=O9hVSsyLQ4gsx7Gr0XMLYe52mvthlsYb0m/5y1ye00mdtBLmFAbZNWkM0C3gg1WY1b
         ob4YYJOb6Z/eDff9RCkV4w+flLrkSm+cSlOObo2YAP4S++TDyboE3KsXUyXuRP2AhpXj
         FyW4VEyiiqk3W7lxIMKRwEAH2s9PvHmcWy2Ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693427539; x=1694032339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLCoDOwQGEKKT36J+ipHqolgSMsTG2oKzWJ8DH6wGMg=;
        b=hv/JgzRzFYVuz35TI7eYdSVZFiMpgw3/xkonkKdx7Xvhc1CXnQoytcPExBCqtLl/do
         ThNSI5JnSpSmyov0m+VtSKmBK2lmeeJKXJm1DsJjrUJaLtXF4Rkb7b5nrUDaqRqR2NMb
         kn3BtnVFiy9xD0vLhSaXkrrTkRplBRht6GhbhMTPuLKxGSwH7uRW942D5OjPixZSEUX4
         64u2J+zdbZijTAxguhSX7nCYOTas7H9wVpyvIn30iicLYMtP7VJNmNbdMl7yPtqmh8ZO
         9mvJEECzg1Eg+0OecS5BtTpTitQ/26E5WG/Stxxe5qXmYJvKqcwyvG7iXFknblqYkulg
         PudQ==
X-Gm-Message-State: AOJu0Yxbkgv30AJkNUlXdbdXATpXgDnNfCDdEUPO8O9/4YJ7TEdTRnfn
        f38Ol8+Qclj0tTwP/P3vqrWCHp97SwCwJwsBuWBK225x
X-Google-Smtp-Source: AGHT+IEY/5xM0J3OqxNQijBitpK63uA3Liuo7B+O9slSIk4YFQG1w51NpRsKTvDiyix4ei/k2iAoLg==
X-Received: by 2002:a2e:9c58:0:b0:2b9:ea17:558b with SMTP id t24-20020a2e9c58000000b002b9ea17558bmr2393052ljj.16.1693427539501;
        Wed, 30 Aug 2023 13:32:19 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id sd26-20020a170906ce3a00b00997d76981e0sm7561532ejb.208.2023.08.30.13.32.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 13:32:18 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so4228a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:32:18 -0700 (PDT)
X-Received: by 2002:a50:8754:0:b0:522:41c9:9b9 with SMTP id
 20-20020a508754000000b0052241c909b9mr3513edv.5.1693427538454; Wed, 30 Aug
 2023 13:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693416477.git.mirq-linux@rere.qmqm.pl> <3240d792149f32fb4164ad7042091daf9f59f9a3.1693416477.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <3240d792149f32fb4164ad7042091daf9f59f9a3.1693416477.git.mirq-linux@rere.qmqm.pl>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 30 Aug 2023 13:32:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UaT9S=MQ5S=bKH8hFv2mZhgaTqLb39O58kBLKiDf8sbg@mail.gmail.com>
Message-ID: <CAD=FV=UaT9S=MQ5S=bKH8hFv2mZhgaTqLb39O58kBLKiDf8sbg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] regulator/core: regulator_lock_two: propagate
 error up
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 30, 2023 at 10:35=E2=80=AFAM Micha=C5=82 Miros=C5=82aw
<mirq-linux@rere.qmqm.pl> wrote:
>
> Fix up error paths from regulator_lock_two(): although it should not
> fail, returning with half-locked state after issuing a WARN() asks
> for even more trouble.
>
> Fixes: cba6cfdc7c3f ("regulator: core: Avoid lockdep reports when resolvi=
ng supplies")
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
> v2:
>   - updated kerneldoc
>   - call ww_acquire_done() on all exits
> ---
>  drivers/regulator/core.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 7201927c5d5b..3f9621621da9 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -209,11 +209,12 @@ static void regulator_unlock(struct regulator_dev *=
rdev)
>   * @rdev2:             second regulator
>   * @ww_ctx:            w/w mutex acquire context
>   *
> - * Locks both rdevs using the regulator_ww_class.
> + * Locks both rdevs using the regulator_ww_class. Returns error if an
> + * unexpected error has been detected during a locking sequence.

I don't believe this is the correct way to document return values in
kernel-doc. See:

Documentation/doc-guide/kernel-doc.rst

Specifically if you run:

scripts/kernel-doc -v drivers/regulator/core.c

You can see that the description of the return doesn't show up in the
proper place.

With that fixed, feel free to add my Reviewed-by tag.

-Doug
