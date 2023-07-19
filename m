Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F527592A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjGSKUi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Jul 2023 06:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjGSKUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:20:36 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C749C1FC1;
        Wed, 19 Jul 2023 03:20:34 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-57712d00cc1so72262117b3.3;
        Wed, 19 Jul 2023 03:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689762034; x=1692354034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8xlYNFf/a39O3VPYimQAUU/7iL+qckkwD3VbduIJH0=;
        b=TU/LqEu9f/+Ndbnrshlo48Eo5dbYlPiAXI8jW9lq9Vz2G+oAa7rn9/YGSWkeg0SFSh
         +BLNPN6V4GPZJyfuEHPOrDXQ4DmMXfQBjbpNYv2Dj5MCLeTSJW1sysMephdwQzQjYmjP
         ex1HaOngrrRLscdg7R7+AETe8hKO1OVvbq6izUG4RSEmzae4JbFvcD0JZSSE0f+eB4Lt
         l9B06zlLlxYR7TyUbiySUTTOEIteyAZGgqEgF/XSXTE9pxcJbf1jT/udehjN4SZ7oPWG
         kbc1WEkzfyMIvz9MqF3I4qK9WsDGQGE+7VDQgXv1UyGs6aqzvsmp27pWckfPphMl9CiR
         nO8w==
X-Gm-Message-State: ABy/qLYRSnMHK+pc5MW7NaxUX2Dzwa/b6bztmK0YJKJkoZ5i33m9cOxb
        PROzfz/LFqYq9ec098cS67wGJO7DsyA6+Q==
X-Google-Smtp-Source: APBJJlGDza1O/MKxeLvSe9lgsoZzBllLaDcnLZFXYgmu4ppRzLM6l/3u3QyzP+AqQ7nFRzWTJhmYcw==
X-Received: by 2002:a81:6057:0:b0:577:3666:bb4e with SMTP id u84-20020a816057000000b005773666bb4emr5170267ywb.36.1689762033798;
        Wed, 19 Jul 2023 03:20:33 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id c19-20020a814e13000000b005835e458ab5sm501234ywb.44.2023.07.19.03.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 03:20:33 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-caf3a97aa3dso7016764276.1;
        Wed, 19 Jul 2023 03:20:33 -0700 (PDT)
X-Received: by 2002:a25:b322:0:b0:ce5:89ce:a13f with SMTP id
 l34-20020a25b322000000b00ce589cea13fmr2099282ybj.25.1689762033370; Wed, 19
 Jul 2023 03:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <ac8d6190-06ae-b538-1293-07efedbfe94e@gmail.com>
 <CAMuHMdV-wu_XHy_qYGM+_UOAXN8etip731WxmgEmbQdv+SPwbw@mail.gmail.com>
 <ZLaSqhsJr2qH5Y6E@orome> <20230718165716.77hllvxiwia542fu@pengutronix.de>
 <ZLeTZtQ_WVzuUqeM@orome> <20230719101352.qu7az5i5c5lrndwi@pengutronix.de>
In-Reply-To: <20230719101352.qu7az5i5c5lrndwi@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Jul 2023 12:20:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWvDEt3EEQj=KfVJhzT2y50ozNUQE_PpLP3QpzvRwGpLA@mail.gmail.com>
Message-ID: <CAMuHMdWvDEt3EEQj=KfVJhzT2y50ozNUQE_PpLP3QpzvRwGpLA@mail.gmail.com>
Subject: Re: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Randy Dunlap <rd.dunlab@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On Wed, Jul 19, 2023 at 12:13 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> On Wed, Jul 19, 2023 at 09:40:22AM +0200, Thierry Reding wrote:
> > On Tue, Jul 18, 2023 at 06:57:16PM +0200, Uwe Kleine-König wrote:
> > > On Tue, Jul 18, 2023 at 03:24:58PM +0200, Thierry Reding wrote:
> > > > Honestly, do we really need all of this complexity? I have specific
> > > > configurations to test all of the PWM drivers to make sure they build.
> > > > There's probably edge cases that don't get tested, but sooner or later I
> > > > expect some build bot will encounter those and then we can rectify
> > > > things. But in many cases that I've seen COMPILE_TEST just happens to do
> > > > more harm than good.
> > >
> > > Without COMPILE_TEST you'd need to build at least for the following
> > > archs to build all pwm drivers:
> > >
> > >     armv4+5
> > >     armv7
> > >     armv7m
> > >     arm64
> > >     mips
> > >     riscv
> > >     shmobile
> >
> > This one is actually ARCH_RENESAS and is armv7.
>
> Oh indeed. ARCH_RENESAS exists for both arm and shmobile. TIL

No, SH-Mobile can be either sh, arm, or both ;-)

ARCH_SHMOBILE is sh.
ARCH_RENESAS is arm, arm64, or riscv.

The Renesas/arm defconfig is called shmobile_defconfig for
historical reasons.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
