Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CB78118F0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377895AbjLMQQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378934AbjLMQPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:15:44 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824DF181
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:15:50 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-20316647099so873229fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702484150; x=1703088950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5XWSXMuQI8BI27DjafZ4lKITNNCK67srbDQ/z6mcEI=;
        b=jAqjbAhu40L8XpY/FnbgTCGqyAnN+HRcEw5P40Dqg7bWwuvWF1xU/Wwp63kLyg39wv
         nLB9iSgeytjhW9kT1P0Y6/ewNFM+KJ96lOtDcLcRFWQI82v/WCMUG1p5mgLQ6785rfGB
         p9gsnmZBhkIIWTnqcOaPBSSkyb9xSGogB1yzAmb0M4OO2MhVYDruQoRuwNPiPIt01cft
         5Aor9lLApHt4ihRXGlpL1lReFl36pzAbT916UOidrXNwhmD1OfGu3zTgWh86JsVy6FT8
         IFC/DfkOon7MmaljykrHf/sbNuL4zBzDlcRgknOiAvcikpVZU6EaeB84ZPf6NGnxE0cF
         YgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484150; x=1703088950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5XWSXMuQI8BI27DjafZ4lKITNNCK67srbDQ/z6mcEI=;
        b=aozU1qEXxc4UCqeS3ZYYBrVoZH/RnF66fKCpNTJoes7UCRFAZheiF5Uf3Xl/o/mgsE
         Tu7Z16Pdw4ovURuH3cwkTU5TKT5x8aRGEiZcGvnQY9Rquonj/dORJKf+HlpEW+vL/VwF
         y3CM5IHtkjJj2ZmkJIQcl2qGNLxA6R8ig9em6HkK3L12i6W72GeMGBIu2V7J1E+Wo7ks
         8Waehy2J68D14/fx+sTMe6tWBaC/RGolNFKLJejXmX45bpKevx9hxlqlDx0NoU+nXvob
         YqFmZw4X1uIdoNCqBMssXSd2JRShymCTVuTPbLDa5GY4WupMMlsjsVCzN9o1zpfBm5md
         RQsQ==
X-Gm-Message-State: AOJu0YxWoZhLOsgzEDOJO+O1elMksSqCnKemfR4c9jY8XwgeFm6JEGuc
        f/t1InQdNH0Vy4D3WuOWoHkw4aI7P2rDPF8aBwGq1Q==
X-Google-Smtp-Source: AGHT+IFraZO3jsnWkGUMiU4lZ1k+V+8gA8whh3mCPldcM0DVWAezqrzi89KMaZmw3vakQVagqavL7HbgEe41mndYEvA=
X-Received: by 2002:a05:6870:392c:b0:203:13ec:ab01 with SMTP id
 b44-20020a056870392c00b0020313ecab01mr2449120oap.86.1702484149882; Wed, 13
 Dec 2023 08:15:49 -0800 (PST)
MIME-Version: 1.0
References: <20231212054253.50094-1-warthog618@gmail.com> <20231212054253.50094-2-warthog618@gmail.com>
 <ZXm3rayrcvfO1t1Z@smile.fi.intel.com> <ZXm_WsIpgIyOUNHt@rigel>
 <CAMRc=Mfri8K4ZqcHb_eQY6gi+q_-uBZc2wiMrrb-+a7Tric3FA@mail.gmail.com>
 <ZXnU3tMYCc2Rw8Qv@rigel> <ZXnX8jPHxRLW8lhi@smile.fi.intel.com>
In-Reply-To: <ZXnX8jPHxRLW8lhi@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 13 Dec 2023 17:15:38 +0100
Message-ID: <CAMRc=Mfj_4YvQVP=UWkULBwJniDDjapttU+qSgqfN5ZWNgikKw@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Kent Gibson <warthog618@gmail.com>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 5:12=E2=80=AFPM Andy Shevchenko <andy@kernel.org> w=
rote:
>
> On Wed, Dec 13, 2023 at 11:59:26PM +0800, Kent Gibson wrote:
> > On Wed, Dec 13, 2023 at 04:40:12PM +0100, Bartosz Golaszewski wrote:
> > > On Wed, Dec 13, 2023 at 3:27=E2=80=AFPM Kent Gibson <warthog618@gmail=
.com> wrote:
> > > > On Wed, Dec 13, 2023 at 03:54:53PM +0200, Andy Shevchenko wrote:
> > > > > On Tue, Dec 12, 2023 at 01:42:50PM +0800, Kent Gibson wrote:
>
> ...
>
> > > > > > +static struct supinfo supinfo;
> > > > >
> > > > > Why supinfo should be a struct to begin with? Seems to me as an u=
nneeded
> > > > > complication.
> > >
> > > I think we should keep it as a struct but defined the following way:
> > >
> > > struct {
> > >     spinlock_t lock;
> > >     struct rb_root tree;
> > > } supinfo;
> >
> > That is what I meant be merging the struct definition with the variable
> > definition.  Or is there some other way to completely do away with the
> > struct that I'm missing?
>
> Look at the top of gpiolib.c:
>
> static DEFINE_MUTEX(gpio_lookup_lock);
> static LIST_HEAD(gpio_lookup_list);
>
> In the similar way you can simply do
>
> static DEFINE_SPINLOCK(gpio_sup_lock);
> static struct rb_root gpio_sup_tree;
>

The fact that this has been like this, doesn't mean it's the only
right way. IMO putting these into the same structure makes logical
sense.

Bart

> > > > Yeah, that is a hangover from an earlier iteration where supinfo wa=
s
> > > > contained in other object rather than being a global.
> > > > Could merge the struct definition into the variable now.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
>
