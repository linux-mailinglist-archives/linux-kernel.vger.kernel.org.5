Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC647E046D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377756AbjKCOKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjKCOKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:10:51 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74201BC;
        Fri,  3 Nov 2023 07:10:48 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66d17bdabe1so12151176d6.0;
        Fri, 03 Nov 2023 07:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699020648; x=1699625448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5W49N27vw9jOm9+4pPULDzBZuABdJpU1QuOPyzMTHnI=;
        b=jNCCh9Tc4vVEmOvKtqLxlf3MkbWV/DAqNVXnmNs9+LpRJ57w1ySocOIuHxuqkkOPK1
         jVzNs2CDdCWHk1hDZFPLsxEcGRusL3r4JoL6nq7KqpWBVs1bwY5IH7Whkkzo8NgKVlC5
         K8EzthnF2lTXcK+qJXpXJEDj5SY3hoenH/sMDoK81gdNBccEIvcou1xLlWW06tLN2rA8
         9I2mMkB0Avx2zbn/slDfU4FYDvsZuGTfVqN730bJHeSOIyUMlILpDEUoFEZB7tTZb1h+
         iMubqDXkpzmq605BimXAHiaS2nIq0pWsKc3xvCWpQRTe4bkLiSHru81YJkj3cOZpA0xU
         4SmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699020648; x=1699625448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5W49N27vw9jOm9+4pPULDzBZuABdJpU1QuOPyzMTHnI=;
        b=Frc41Ws9lz1YJA9l88QFUdbpXhNeumjexZU54gbKF5gtYjMC/h0uOHqjlqIN+PYra9
         6i17HBeXZsbK15I1TDboMhSNpAV15+MCCKcToZAOHDF3nn8IoYGnKfmpkDxGcQNNxSHy
         fl51OG0srEamBQVYyE/7Fq0RxtpjEfpv0EJiMAtOQhTvztZTCPj6Pa7eG+r7+trUEFRO
         NAxopIg0HJmuwk/Urf92k7D28NQEKwWyQS/tcp+jSKYPLO+pfClf+AYK4HygPH3mUeCs
         IzbX1/pUKICQh2zRPICGIghNeFZiTTy/WjEzWoaMNzqlWlhWZIcgRMIiesr1SBCzj3Pb
         prgQ==
X-Gm-Message-State: AOJu0Yxg8AZg6D502ojkRuny3S2YFC6VXnNfu4XPOo8STm9bmeUOS8N3
        bOewQI4OYJPUJCdk0ZMOhTzX2VOHInqxvaYo6Ac=
X-Google-Smtp-Source: AGHT+IFb8OYMuucg4Zy1aJQZQRMqHPlAFieCVY0pctec2q1cchpTXIEq8PB/AwOyv3SJ3UUh4oVZn+F6hZFgmGXTSdk=
X-Received: by 2002:ad4:5bc8:0:b0:670:ad82:9b13 with SMTP id
 t8-20020ad45bc8000000b00670ad829b13mr19283524qvt.50.1699020647866; Fri, 03
 Nov 2023 07:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231102132616.1130960-1-eblanc@baylibre.com> <CAHp75VdvR0H7XVLWGqdZqSgoHprUUPQHGiyWEEaHjTgEbeinqQ@mail.gmail.com>
 <CWOGMAUT9MKY.2IBKELIOR1CF7@burritosblues> <CAHp75VdV5A+WpWj2eY9o_2wwPB7GTi6Eig7YyV8urdv1P3utgQ@mail.gmail.com>
 <CWP1UD343WSC.32F81J6ROV2YO@burritosblues>
In-Reply-To: <CWP1UD343WSC.32F81J6ROV2YO@burritosblues>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 3 Nov 2023 16:10:11 +0200
Message-ID: <CAHp75VcGMHQGU5DA=iZc=eJbLVfiNqgzsLJCFRxNFAJCZefG+A@mail.gmail.com>
Subject: Re: [PATCH v8] rtc: tps6594: Add driver for TPS6594 RTC
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        jpanis@baylibre.com, jneanne@baylibre.com, u-kumar1@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 10:55=E2=80=AFAM Esteban Blanc <eblanc@baylibre.com>=
 wrote:
> On Thu Nov 2, 2023 at 5:46 PM CET, Andy Shevchenko wrote:
> > On Thu, Nov 2, 2023 at 6:17=E2=80=AFPM Esteban Blanc <eblanc@baylibre.c=
om> wrote:
> > > On Thu Nov 2, 2023 at 5:00 PM CET, Andy Shevchenko wrote:
> > > > On Thu, Nov 2, 2023 at 3:26=E2=80=AFPM Esteban Blanc <eblanc@baylib=
re.com> wrote:

...

> > > > > Notes:
> > > > >     This patch was picked from a series since there is no depende=
ncy between
> > > > >     the two patches.
> > > >
> > > > Not sure if RTC maintainer uses the b4 tool, but as I said in previ=
ous
> > > > email for pinctrl change, there is no need to resend. b4 has an
> > > > ability to select patches from the series to be applied.
> > >
> > > Oh that's good to know, I was not aware of that.
> > > I resent it because there was some minor nits that I fixed on both
> > > patches.
> >
> > Ah, that was not reflected in the changelog...
>
> Just after the line you quoted, there is "Changes since v7". Maybe I
> should have put it near the other ones. Sorry about that.

It's me who misinterpreted that as changes _in_ v7. Thanks for clarifying.

--=20
With Best Regards,
Andy Shevchenko
