Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577E0754E66
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 12:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjGPK6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 06:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGPK62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 06:58:28 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1127C10C8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 03:58:27 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b6ff1a637bso49813051fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 03:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689505105; x=1692097105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCbanyjPWw7wg8GH0dN5PyTlb5CiuUWTxnicJQNXHbM=;
        b=aLW6VFWlrPWXxOJUYy3beiUVjpzMtIgYfqwQ9bp7pv72xkICLAzYV6/caCMKC/WXYW
         Gpkgz9MMTSQ9iBjhTh0EgTgx92vPVcytU5DSdxeqwqPnOzzbxvlQPXQJ8E/Zdcw2zIgH
         GwPwc51VpsziJigC+OGt9fzWmimAnEUpKp/qvUz6bu/TMsd03pOZ7isQS335fawiHsK2
         lTKUBwZP7WEDQwIhgUK0t/VOiTDC6TfOIFcDrb86METzeAFuhqOOMUY5zpG3Zk3hh6Q4
         2vDHRo/kac+paLlvrEWrMw2XT4qFmT4Op0oCfBjaEUXU0wVAcEhWANl2SZ7JkbfDuwS0
         2WDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689505105; x=1692097105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCbanyjPWw7wg8GH0dN5PyTlb5CiuUWTxnicJQNXHbM=;
        b=NVulUdd7QNs6CpikaDTqEY3CtNrJoSOpKIUbEhFIYMDfR/VWSoyEN7GZLR1rcdYnR7
         +THGQwcoctohvkHSWzp3JsuJ2/JrBMVeJzRqOX6H6KyLEPmV9/958ze5HJABhi2ylHs2
         QqfdYZ67V7zZYBC0ReIR3HHj9tm/jVVwjIULc7d6QWBfZq76HZbp/3G8jWP1yqGW6cMP
         jUqW4/YuAXEzxZGDNFpumGavvaERslbkKQLhOZcGSK29BTyeTxzndqw7GjNew1JsU7JX
         8fTVLDGPnTOstK/TGp37FLX2zbzALne+kgbYP9fnMiBMARPzs7/rJ/l/Nim7TnFv0Zzb
         ObVQ==
X-Gm-Message-State: ABy/qLbDeWPSmnFTPefVwv5BugRbjr6xrmBNVuqMEzB9h2x1OcV8tkIZ
        To9blGuPenRKj2qzUp73Hk5eb9QkPMAfubYgE5ZMKg==
X-Google-Smtp-Source: APBJJlG9KY0nqgKStS8Cj/QJYv2YnwextwQh6Qp0TTrsVN7UOiV7VRzjd+KhTjuBY7aqgmuxUOzxihVATqd0G4robx4=
X-Received: by 2002:a2e:868a:0:b0:2b6:9ab8:9031 with SMTP id
 l10-20020a2e868a000000b002b69ab89031mr6640280lji.16.1689505105319; Sun, 16
 Jul 2023 03:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230713202123.231445-1-alex@shruggie.ro> <cad1d05d-acdd-454b-a9f8-06262cf8495b@lunn.ch>
 <CAH3L5QrtFwTqqFKjPrMFCz4JgUWOFWFUJXpN71Gyprcd33A7hg@mail.gmail.com> <ab0ca942-5e84-4663-a0ed-689f023624b6@lunn.ch>
In-Reply-To: <ab0ca942-5e84-4663-a0ed-689f023624b6@lunn.ch>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Sun, 16 Jul 2023 13:58:14 +0300
Message-ID: <CAH3L5QoyOnbLG=pegiAFj0kPkp-mC9edCewxq3OBdGE75+1Jhg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2 net-next] net: phy: mscc: add support for CLKOUT
 ctrl reg for VSC8531 and similar
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
        olteanv@gmail.com, marius.muresan@mxt.ro
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 1:27=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Jul 14, 2023 at 09:09:14AM +0300, Alexandru Ardelean wrote:
> > On Thu, Jul 13, 2023 at 11:35=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> w=
rote:
> > >
> > > > +set_reg:
> > > > +     mutex_lock(&phydev->lock);
> > > > +     rc =3D phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_GPIO,
> > > > +                           VSC8531_CLKOUT_CNTL, mask, set);
> > > > +     mutex_unlock(&phydev->lock);
> > >
> > > What is this mutex protecting?
> >
> > This was inspired by vsc85xx_edge_rate_cntl_set().
> > Which has the same format.

Good news.
Removing this mutex works on a 5.10 kernel, with no issues.

>
> phy_modify_paged() locks the MDIO bus while it swaps the page, so
> nothing else can use it. That also protects the read/modify/write.
>
> Nothing is modifying phydev, so the lock is not needed for that
> either.

I remembered what I was doing wrong in that version that had issues
with the lock.
I was doing some manual page changes, with
phy_base_read/()phy_base_write() functions, which are in this file.

These functions have a warning + dump_stack() for when the
"phydev->mdio.bus->mdio_lock" is not held).
That threw me off initially.

>
> > I'll re-test with this lock removed.
> > I may be misremembering (or maybe I did something silly at some
> > point), but there was a weird stack-trace warning before adding this
> > lock there.
> > This was with a 5.10.116 kernel version.
>
> This patch is for net-next, please test there.

I've been testing on a Renesas board CIP project.
Kernel version (on our board is actually 5.10.83 ; I get them confused
since 5.10.xxx seems to be used here-n-there).

The kernel is here:
https://github.com/renesas-rz/rz_linux-cip/tree/rz-5.10-cip3

I'm trying to backport some ARCH patches, so that the board boots up.
I "think" I'm half way there; now the kernel prints something to
console and then stops (that's progress from no prints).

Let's see if we get a different consensus on Rob't suggestion; this
patch may require a different V3 :)



>
> When testing for locking issues, and when doing development in
> general, it is a good idea to turn on CONFIG_PROVE_LOCKING and
> CONFIG_DEBUG_ATOMIC_SLEEP.
>
>         Andrew
