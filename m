Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED5276FE4E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjHDKUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHDKT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:19:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1EC2118
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:19:58 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe1e44fd2bso75655e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 03:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691144396; x=1691749196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EpS0BMomvLcLosH0n3oTZl+kwzi/lkliHRMULd3Y+8=;
        b=ZwPvk/yH5kYz92/l5aHMVvCqdbqpFWf8njn7T37ek79AR5hckiZxhaVBHq1KwR/UV+
         ryGMvy1xTvi1BQgiXr/m44lqC4ZWU0uAxOSbZMd1PQBBiT7OYGCQ6zbkqsjo2oDQDr2X
         SG/kMjiq0bB3RQ4XPQueyuG0iv0SRAaX7YZY/31k9N0ar4975LmiwmJo4v4rlESTm2sr
         K+TSBEtBEJzBxT6EI/O7IQQC7aVq+EGb6kujOUHzNaQ6Qk12iJf7H1DN8XOW6WjY3JVg
         WUT08P/yuU15aMYdZZGsLnRrdmY31G71WSRvZ96ZS172KhK8o+5+dhFgBY8xRPUxfQZU
         IWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691144396; x=1691749196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EpS0BMomvLcLosH0n3oTZl+kwzi/lkliHRMULd3Y+8=;
        b=j/kCZkMH9v8TgdKuOXL6OmYmOzVv0GKeXt5mIW0iLBj1mfVmKlioIUC0gBQxodrFOi
         NRVbqZ58cfByp46EGbkj+i90i7fw/NRjQFDXdMBwSk4Mvh3bsTZBn36isWIfSfi/efoa
         mbctil0dz7l2XDVeOn0Ru+2ToFVucqmetPsAF2T0gr2LS3mSwGEfynfJ7Zas5q1vJKtS
         YT6Q4vFN27DJOITTdkpm1Ibga/ZX/a+W4dEmAKkSM+YXjPVa/rTj1NgyEO1jG8DZNoT1
         9R8IdaX7zkYUC8vqd+mC8A5ebVqxmdsYzVuaGXnfmHbnaNEZOVX0GxvJOd5IX/swEVEV
         4l8A==
X-Gm-Message-State: AOJu0YwpRpiOVfH9zGQyTrz/LmfR1XsG6XB9GldazbsyC14a8PXco9VG
        RuqQvZw9fwGxZzG2u/L0k2XNlj3PFX1uK5BOpOvJtw==
X-Google-Smtp-Source: AGHT+IHTPJOUgMMTx+b5xtE4xcZE+at2fSux7/FeFS2nemnumlru9GyrHv9zIfKBMV3+CSDubQ44Nqyp7zrukV9Y3Ag=
X-Received: by 2002:a05:600c:510e:b0:3f7:e463:a0d6 with SMTP id
 o14-20020a05600c510e00b003f7e463a0d6mr37103wms.0.1691144396424; Fri, 04 Aug
 2023 03:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230803144227.2187749-1-nogikh@google.com> <CAHCN7x+8Qq6w0eRC0NwBfhgS7XH7fmmPr9xwhR54rWFNY37Ugg@mail.gmail.com>
 <9e77ccc3-07db-f1fe-ef99-981852d4772b@infradead.org> <CAHCN7xKG=8ygSi8st31fe+t3Mn+k-7VUHKixFCZUuuDLOX8-kQ@mail.gmail.com>
 <d8a57aee-bb8a-dc5a-7c4f-b8a293d37bec@infradead.org> <CAHCN7xKnRAmKh60dAtVaxz-dQtjzhBNtS0aN2swmddfo5FAD-Q@mail.gmail.com>
 <b43e642d-8aa1-fb8a-6bff-86039a06d57b@infradead.org>
In-Reply-To: <b43e642d-8aa1-fb8a-6bff-86039a06d57b@infradead.org>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 4 Aug 2023 12:19:44 +0200
Message-ID: <CANp29Y6_VcgQAHERdaXUqBZahfFkJ=ksvjVVeMkZz88Xxjz1jw@mail.gmail.com>
Subject: Re: drivers/gpu/drm/bridge/samsung-dsim.c link error
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Adam Ford <aford173@gmail.com>, l.stach@pengutronix.de,
        inki.dae@samsung.com, jagan@amarulasolutions.com,
        m.szyprowski@samsung.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, dvyukov@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 4:47=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> On 8/3/23 19:42, Adam Ford wrote:
> > On Thu, Aug 3, 2023 at 9:37=E2=80=AFPM Randy Dunlap <rdunlap@infradead.=
org> wrote:
> >>
> >> On 8/3/23 19:26, Adam Ford wrote:
> >>> Where/how was the .config generated?
> >>>
> >>
> >> Aleksandr posted a link to the config file above.
> >
> > I get that, but I am not sure how this was generated.
> >
>
> Nor am I. Alexsandr can hopefully tell us.

We take a defconfig and apply a number of modifications on top of it
(*). Some configs are enabled (e.g. various sanitizers), some are
disabled (e.g. a number of heavy subsystems are disabled for instances
that run on qemu w/o hardware acceleration).

We rely heavily on olddefconfig to detect inconsistencies during
config generation (we regenerate them manually once in a while and the
tool makes sure our changes do not contradict KConfigs) and to
automatically correct inconsistencies when a kernel is being
(re-)built (there's no other way -- something constantly changes in
the mainline tree and it's impossible to keep track of it all
manually).

In this particular case, we indeed disabled CONFIG_GENERIC_PHY, but
left other dependent configs enabled and `make olddefconfig` could
unfortunately neither help us detect the problem nor resolve it during
the build :(

(*) FWIW here's a doc for reference:
https://github.com/google/syzkaller/blob/master/dashboard/config/linux/READ=
ME.md

>
> >>
> >>> Are you building linux-next or something else?  The .config file
> >>> generated when I build the arm64 defconfig  show both enabled:
> >>
> >> linux-next.
> >>
> >>
> >>> $ grep GENERIC_PHY .config
> >>> CONFIG_GENERIC_PHY=3Dy
> >>> CONFIG_GENERIC_PHY_MIPI_DPHY=3Dy
> >>>
> >>
> >> Yes, this is not a defconfig file.
> >
> > I know, but it is a .config file that is generated from make defconfig
> > ARCH=3Darm64
> >>
>
> Not necessarily. It could be generated by 'make randconfig'.
>
> >>>
> >>>> but yes, selecting GENERIC_PHY (needed in 3 places) does fix the war=
nings
> >>>> and build error.  2 instance in drm/bridge/Kconfig and one in
> >>>> drm/bridge/cadence/Kconfig (found by inspection).
> >>>>
> >>>> I had no problem replicating the kconfig warnings and build error.
> >>>
> >>> If you can replicate the problem, I'd suggest submitting a patch.
> >>
> >> Sure, I'll do that.
> >
> > Great!  thanks.

I see the patch has already been sent. Thank you very much!

> >
> > adam
> >>
> >> --
> >> ~Randy
>
> --
> ~Randy
