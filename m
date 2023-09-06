Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669DB793A82
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbjIFK7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbjIFK7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:59:50 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204271BB;
        Wed,  6 Sep 2023 03:59:40 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d7b9de8139fso3011849276.1;
        Wed, 06 Sep 2023 03:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693997979; x=1694602779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TRaWE9RdpS1f61w4iMZcHsGOS8rUsx58CiFxRqJCtY=;
        b=i6/DRY844oKLl1KbkSsms3OlLC0yG3F8xeDTp+8BeUbGsaDxuUxh1LE4rvNyYUmvOO
         00SuKcU+u5s+L9QUtc7TNokEYbWhEL7GYfbvosI33WvwBmsHgBIJkhN54qP0bNBQvynl
         Jw/InX8990BvlD8sSg+DT1D+a/5CiE/Z+IcscgnS88gN/jT0aiJQqex/x7mAndgzXzyn
         pXPIpH34cImIZFP3AmgedTWkoEoaclSibEi3PeA/jmlgG+uBznWTsF6Jb6auN4pTHwww
         kuLCIqBCptMzHGeQx32XM2e1PIEjHpYdS5vfLW/DzN0ZsfwVOaZ9Tk1jL5880ixizY7u
         w7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693997979; x=1694602779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TRaWE9RdpS1f61w4iMZcHsGOS8rUsx58CiFxRqJCtY=;
        b=IpAlW4rkCyI7RHSqc4QUmU8xiC6RUrAfwHcPULsTWD4y3vPHK+P4S7F2jc7ItCeNxy
         mKX1DeActVhp+qYRFmUdNnJC2gSekRaNFCZqoZSTMKLdiEjNc4NBqv/66f9en27oELtM
         jCkQsHaM+z6Xf/Sq3ffAt67NjCRvYE0ntL+OATXAsOZu0eaaSt2EwbUuCwRSw1gYNYmZ
         tTJ/Vb//JuHAoG0J2/umxEB9vtW87UzXST0TZcZkIf62lIngnJv5/YV6jIq1EvggmKj5
         tdzeVzUIBEXGIKTwyR8FvYao2o2b6+bW36IYJj7I9eyxeVAAkfJ2Df8lgMkBvZRWYzdK
         v/yw==
X-Gm-Message-State: AOJu0YwXKNtKdetCnS0nucuY2XE4bXHB55/JafZ2wJ8uxTpCRICZBXWn
        BvUi38kUzKsyv9GHs+2zdpSNrD6e5RjxWE169vI=
X-Google-Smtp-Source: AGHT+IGDVLUdQ05ge/G4dn3Y38GXLHKZ7EF0tbkdsL28txPHQxHktzsEeW+78m6I3GUAbE9DNyViC+klXVifYe3z/QM=
X-Received: by 2002:a05:6902:188:b0:d7f:95f6:e13e with SMTP id
 t8-20020a056902018800b00d7f95f6e13emr3169281ybh.33.1693997979142; Wed, 06 Sep
 2023 03:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xJjK=BaNHa=+OKzOmFtNRYKX_APTp5Zj3g-X_iQcpyK6g@mail.gmail.com>
 <ZPZ2zTS9loj06u31@debian.me> <20230905061739.GX11676@atomide.com>
In-Reply-To: <20230905061739.GX11676@atomide.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 6 Sep 2023 05:59:27 -0500
Message-ID: <CAHCN7xJo=pJkcChHm9AsNQGCJuHXgpRKKRK9ckEwdk3U-41ukw@mail.gmail.com>
Subject: Re: 6.1.y Regression found on AM3517
To:     Tony Lindgren <tony@atomide.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux OMAP <linux-omap@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 11:25=E2=80=AFAM Tony Lindgren <tony@atomide.com> wr=
ote:
>
> * Bagas Sanjaya <bagasdotme@gmail.com> [230905 00:31]:
> > On Mon, Sep 04, 2023 at 11:37:46AM -0500, Adam Ford wrote:
> > > I have an AM3517-EVM board that I am trying to use the latest 6.1.y
> > > stable, currently 6.1.51.
> > >
> > > With git bisect, I narrowed the regression between 6.1.15 and 6.1.16 =
to commit
> > > eaf9b5612a47 ("driver core: fw_devlink: Don't purge child fwnode's
> > > consumer links")
> > >
> > > In the regression, 48002000.scm appears as not ready.  This affects a
> > > variety of dependent peripherals making them unavailable:
> > >
> > > wl12xx_buf platform: supplier 48002000.scm not ready
> > > wl12xx_vmmc2 platform: supplier wl12xx_buf not ready
> > > 48050000.dss platform: supplier display@0 not ready
> > > 48064800.ehci platform: supplier hsusb1_phy not ready
> > > backlight platform: supplier 48002000.scm not ready
> > > display@0 platform: supplier backlight not ready
> > > dmtimer-pwm@11 platform: supplier 48002000.scm not ready
> > > hsusb1_phy platform: supplier 48002000.scm not ready
> > > gpio-leds platform: supplier 48002000.scm not ready
> > > 480b4000.mmc platform: supplier wl12xx_vmmc2 not ready
> > >
> > > If I build 6.1.51 but I checkout drivers/base/core.c from commit
> > > 2455b81afe68 ("driver core: fw_devlink: Add DL_FLAG_CYCLE support to
> > > device links"),
> > > the regression is gone.
>
> Adam, maybe check if 6.1 stable series is missing something to be
> backported from this mailing list thread:
>
> https://lore.kernel.org/lkml/20230207014207.1678715-2-saravanak@google.co=
m/
>
> That email thread version seemed to work for me based on my reply in the
> thread. I recall issues with the earlier revisions but don't remember
> what fixed them.

Tony,

Indeed, it does appear that a patch was missing from the back-ported series=
.

Applying commit 4a032827daa8 ("of: property: Simplify
of_link_to_phandle()") to the 6.1.y branch appears
to fix the regression.

Thanks for the pointer to the series.

Stable group,

Do I need to send a separate e-mail requesting the backporting of that
commit to the 6.1.y branch?

adam
>
> > > I checked the 6.5 kernel, and it appears fine, so I think there is a
> > > possible backport commit missing, and I was hoping Saravana or Tony
> > > might have a suggestion as to which one(s) I should try.  I don't kno=
w
> > > if this is found on other OMAP3 boards, but I wouldn't be surprised.
> > >
> >
> > Thanks for the regression report. I'm adding it to regzbot as stable-sp=
ecific
> > entry:
> >
> > #regzbot ^introduced: eaf9b5612a47f0
> > #regzbot title: keeping consumer links of child fwnode doesn't prepare =
AM3517-EVM suppliers
>
> Regards,
>
> Tony
