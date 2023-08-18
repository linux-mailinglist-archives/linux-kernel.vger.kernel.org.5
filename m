Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D311D78093A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359506AbjHRJ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359586AbjHRJ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:58:54 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F243C23;
        Fri, 18 Aug 2023 02:58:31 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-44c07c2b89aso210800137.2;
        Fri, 18 Aug 2023 02:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692352710; x=1692957510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zt/nNqSziFy/UzuRO2Ohk6c8266cSeqXsVGl3zlIYE8=;
        b=qga2ok8u7YI6EH8QRw/Lq3hjRayxa0y5RCwndnf6ddoKTwoQZvvBTcuWJCQoFH788X
         G+6OSnoWp3znEGLwCXmVnMuUvRTgT6dxPbB5A5Kh98SCu3SPd0l4Rd2pJDe9oV7S4mdm
         DcmGU7gBjtj5zr1W8PvL9Ltk7OYW2yNmSG63ecMOvUEvKaHbdNtfobd0IZuwTDF37So3
         NG4iTifG/qW+kyG4JA+eFElNMEVIPddNn8NEIB5J1MPgVRm9UMiBnvCwPlnwYspekjc0
         9adM2RDa4ITwbGw1WPge3xL0xPKzGaQuxgtIsnJjzOl3s7NMVcs3g2FRyG9SGup2NxNO
         h77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692352710; x=1692957510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zt/nNqSziFy/UzuRO2Ohk6c8266cSeqXsVGl3zlIYE8=;
        b=EaZyF4tXAOyk5e2gACO/RK4WVRQOiTY+DVmHu0EDDxnUTDrzoR3r2D8Lw6owL+6KW5
         arLDP9o2U+aF3wFZj2bQ/9yNcng5r/+NKFL4JKrqM9m+u9NX7kpCYz5KiUDXxxgsIce7
         u/dsqHbbkPxXY7bSjQfL6uAIMJPuGcccpF8/NYOfNRD/i2lOLic5ND0nFURhXKNCtv2y
         Kwja6RXQf9oOmhkyKXfCecfaTbfGlwggplg/rPAdaqRxSfnD6wAoewEU3xObCgjbJ+zI
         7WBP+wS2SuDNV8Il0RkDH/KFVQpGZG21ZkF0fs/NUkgeWesWSgcge9jzo8LVEZMumved
         eitQ==
X-Gm-Message-State: AOJu0Yyvl8UZyVaMpzQbp/ieFVxd9DmKgy0q59GnzfDDgxeyLG8lJwYP
        IFlgKKJ0z+2Ael4aKs+RcjufpzfqMw7pjZiXQJgNIw+J72Y=
X-Google-Smtp-Source: AGHT+IGbLykDXS/NML0nE7pRiGCXAa0buU4HbMsZnj1jOOkjndbbLh1eZ4pqSrp+ySLVy9r/xHwbhi4C50XRZCVeJKw=
X-Received: by 2002:a05:6102:19a:b0:44a:a4ea:3f90 with SMTP id
 r26-20020a056102019a00b0044aa4ea3f90mr2822175vsq.26.1692352709912; Fri, 18
 Aug 2023 02:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230721101349.12387-1-victorshihgli@gmail.com>
 <20230721101349.12387-5-victorshihgli@gmail.com> <CAPDyKFrmwct=b6angucfrKOXneZXe+_2KQ4f--OQEoKD=fc5hg@mail.gmail.com>
In-Reply-To: <CAPDyKFrmwct=b6angucfrKOXneZXe+_2KQ4f--OQEoKD=fc5hg@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 18 Aug 2023 17:58:17 +0800
Message-ID: <CAK00qKB4OLLO0RXDE9XqNCZ-59VRC2knMD=-pBCNzav=pR_nZQ@mail.gmail.com>
Subject: Re: [PATCH V9 04/23] mmc: core: Extend support for mmc regulators
 with a vqmmc2
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 6:28=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Fri, 21 Jul 2023 at 12:14, Victor Shih <victorshihgli@gmail.com> wrote=
:
> >
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Updates in V4:
> >  - Moved the voltage defines into this patch.
> >
> > Update in previous version:
>
> Please drop the version information from the commit message.
>

Hi, Ulf

     I will update this  in the V10 version.

Thanks, Victor Shih

> > To allow an additional external regulator to be controlled by an mmc ho=
st
> > driver, let's add support for a vqmmc2 regulator to the mmc core.
> >
> > For an SD UHS-II interface the vqmmc2 regulator may correspond to the s=
o
> > called vdd2 supply, as described by the SD spec. Initially, only 1.8V i=
s
> > needed, hence limit the new helper function, mmc_regulator_set_vqmmc2()=
 to
> > this too.
> >
> > Note that, to allow for flexibility mmc host drivers need to manage the
> > enable/disable of the vqmmc2 regulator themselves, while the regulator =
is
> > looked up through the common mmc_regulator_get_supply().
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> [...]
>
> Kind regards
> Uffe
