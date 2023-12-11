Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFBB80DDFE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345543AbjLKWIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345529AbjLKWId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:08:33 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE13CA6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:08:39 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso5825e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702332518; x=1702937318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlYlHCXGFU5KZ74rv5ll10Sv9Er2/TqtV7SmAS1Ie5U=;
        b=fmleqSyAoJZqKuOxvTFhOA72jJdQb1AodQZBs7Isl+mYKM2JAp+t/WS7sNwTgrC7f6
         PvzJ84i3Ehl2rZtYUIquiqD0yt0BnyokdTCq613WvfAhYZ/I+KeJYsfFztW+o0pFISym
         MTnwHdfk3l+mTsASlFujN0Ga3bMl9gn265etgTGWuZskylOJB96pvBDI6W8EfzKm4evc
         Rq4+s8ZApP0TLCE52ZZekDQfh4S1NmeKTTMOAuC6Aiw9TohCoI5LohgNJs9DXtqm8G5a
         UPpQrUXd1PyrNOv+ZYj+hCqrsc02r1yLkQye6yKzNgYZBm52NthWo2HPsxu4G+3wm5v7
         2FCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702332518; x=1702937318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlYlHCXGFU5KZ74rv5ll10Sv9Er2/TqtV7SmAS1Ie5U=;
        b=pporcD/PKuqlEZz6vD/ol7qj2D/HvGzySpy9UbA7DeQHBkArvxjvxkjzPkbc3j7oZ0
         8/Q3g1T6h5Zbr/hES22YMltgQoheO1DAacAatIdojmodzm54AZh71KQVA/TaZzBUDdRW
         8crF+pXDCp8ONF8oFuEEWhJopncl17awAgNYwHidxC9kxowEfUu8vATEDHcUGbQfMiQP
         qypW1FY2cA+4kvjwgEMyC6cOdubokDPGw5d0+3q7EsSrdXfi58QZfe9hNkiqOENU7jfs
         C9DpVB5cg6OtPGXNUGuIU0elSAFVPdjG3I4mmj7dpoE0kTp8ArJRfyqirFU7sY9rWvLp
         6Jlw==
X-Gm-Message-State: AOJu0YySVxpnr2IALYyTcvhcsTh6OgY2x0b0+VHA921gOhEKVQd9jwBP
        hZ7ozfntLYMmWOH/GWC+6OwOivUsiOL9n3N5dln6yw==
X-Google-Smtp-Source: AGHT+IFuAyP9/JaBzGe8rYcHm/Q0KPYoxSvmWT8WuQnqhqw+DqOV8MCYwzViQ3hUogw+SsUQ69z4RZeaHd1XvbCJjYE=
X-Received: by 2002:a05:600c:2941:b0:405:320a:44f9 with SMTP id
 n1-20020a05600c294100b00405320a44f9mr243192wmd.5.1702332518004; Mon, 11 Dec
 2023 14:08:38 -0800 (PST)
MIME-Version: 1.0
References: <20231204221932.1465004-1-rmoar@google.com> <CABVgOS=5Y_CrTZ4hs57UGdR_p1aK2+1w2-aZ9EVELsbRdVvqTg@mail.gmail.com>
In-Reply-To: <CABVgOS=5Y_CrTZ4hs57UGdR_p1aK2+1w2-aZ9EVELsbRdVvqTg@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Mon, 11 Dec 2023 17:08:26 -0500
Message-ID: <CA+GJov5qipT2EV2+UjtRzvjjtTA_OOtOgZKbRiitmYpbrXrE9A@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] kunit: move KUNIT_TABLE out of INIT_DATA
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        sadiyakazi@google.com, keescook@chromium.org, arnd@arndb.de,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 9, 2023 at 2:48=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> On Tue, 5 Dec 2023 at 06:19, Rae Moar <rmoar@google.com> wrote:
> >
> > Alter the linker section of KUNIT_TABLE to move it out of INIT_DATA and
> > into DATA_DATA.
> >
> > Data for KUnit tests does not need to be in the init section.
> >
> > In order to run tests again after boot the KUnit data cannot be labeled=
 as
> > init data as the kernel could write over it.
> >
> > Add a KUNIT_INIT_TABLE in the next patch for KUnit tests that test init
> > data/functions.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
>
> I think this actually fixes a potential bug, as we loop through the
> list of suites after init has ended in the debugfs logic.
>
> So maybe this is:
> Fixes: 90a025a859a3 ("vmlinux.lds.h: add linker section for KUnit test su=
ites")
>
> Regardless, I'd love to get this in, even if we don't manage to get
> the rest of the series in soon.
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David

Hello!

Thanks for reviewing! I will be adding this fixes tag. Should I make
this a separate patch for the next version?

Thanks!
-Rae

>
> >  include/asm-generic/vmlinux.lds.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vm=
linux.lds.h
> > index bae0fe4d499b..1107905d37fc 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -370,7 +370,8 @@
> >         BRANCH_PROFILE()                                               =
 \
> >         TRACE_PRINTKS()                                                =
 \
> >         BPF_RAW_TP()                                                   =
 \
> > -       TRACEPOINT_STR()
> > +       TRACEPOINT_STR()                                               =
 \
> > +       KUNIT_TABLE()
> >
> >  /*
> >   * Data section helpers
> > @@ -699,8 +700,7 @@
> >         THERMAL_TABLE(governor)                                        =
 \
> >         EARLYCON_TABLE()                                               =
 \
> >         LSM_TABLE()                                                    =
 \
> > -       EARLY_LSM_TABLE()                                              =
 \
> > -       KUNIT_TABLE()
> > +       EARLY_LSM_TABLE()
> >
> >  #define INIT_TEXT                                                     =
 \
> >         *(.init.text .init.text.*)                                     =
 \
> >
> > base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> > --
> > 2.43.0.rc2.451.g8631bc7472-goog
> >
