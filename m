Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8151D7F4E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344121AbjKVR0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbjKVR0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:26:43 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC9E92
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:26:39 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-462a0e1245bso1299257137.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700673998; x=1701278798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2shFgJTlJ9h7e3t15BYDPAUoPIZ4uMg+GRBduHwrWE=;
        b=GaraeVTip7HJ4qr8nej5WgeJtW5xWs3FtNGgGPJUvQRMUl2q4/zwnLgEUXKsIF0h9P
         V/aPoXYLzdt1iSb/5ojs0UOyMjpP4ftk+6aoY2qLPVqvHp2xaYLFGo3FUgcfZzvzM3xY
         aHEAxzFMV/CsyqVjS3kYMpJe4NWsebojEr7qRyGFIASwNWhyAX7dCRNNpQtztOLiiQ3j
         Zm34g6RPIMqGBgLntgfgbos+7uMKUoyrnMNiboN4E67x0wz0q9TvXcl9o/E8HjQtwV14
         vd2d2WnRxYlKKs7vm280npjbAcCqTqu0WC45Np4gISUj64Y3bGUs+yJFHIuZSZdaEDXP
         FhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673998; x=1701278798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2shFgJTlJ9h7e3t15BYDPAUoPIZ4uMg+GRBduHwrWE=;
        b=gqi3DyesMgPtJpiMOe5NRQQjm4x/ayoG4X+JaH+HI2TvHiQHEPQLwBZy3MwhXjle+4
         KSCTLyXnxYvsusTfXaxNeumGinn+cfkPV5TnbD4FnkzZghQJtCdgWqUNROws3YGbuYq1
         gavVrcdW35Bfu+qQY32YrmW4XH94IqJEnOobQI6Luc1sVzF7SZNM1H/MgHh/ZRwGeZaG
         WX5K6PKlKykOIPfA1jbCYIasd98UlYlHtwue4qqesTKiIfRtik8WeHbqNkC0TDeRneZB
         fU20fWX9p8IuBlnCu79lQ/8vceIpKR2NRqLZ8bSoMFVVfQv2EuJvxsCERI8FDVkdmBRT
         2tog==
X-Gm-Message-State: AOJu0YzV+n/35E0dqjw7AzWXKvDoqncatFlYw9sPl2WwrsseMsLrFNju
        9dSHczn+Wl4Csx70rgqyo1hmWaPSF5T+p1Jmlqq2BQ==
X-Google-Smtp-Source: AGHT+IFzi7SMG/LyyZzNBXnCal5MiEtxDZ8q1iycJnu3xy9PsdGdlxKP8z69RACANGv6/CKjF+AbqWMoKIiXGT6/D9k=
X-Received: by 2002:a67:fe5a:0:b0:462:8cc4:745 with SMTP id
 m26-20020a67fe5a000000b004628cc40745mr3170192vsr.22.1700673998778; Wed, 22
 Nov 2023 09:26:38 -0800 (PST)
MIME-Version: 1.0
References: <20231122155916.38037-1-brgl@bgdev.pl> <480fef02-09ed-9a32-d5bb-e7114381220c@axentia.se>
 <CAMRc=Mc_KAX0QWSoL9UEwwjFCD=fHv6ydceSYwaY91C=RkURxA@mail.gmail.com> <978e008b-0787-4204-3d5f-16518f35a3c9@axentia.se>
In-Reply-To: <978e008b-0787-4204-3d5f-16518f35a3c9@axentia.se>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 22 Nov 2023 18:26:27 +0100
Message-ID: <CAMRc=Mfo_N75ByOGe0TRxr__ajZ0fdGmzaVu9ig4uSsyMPSOhA@mail.gmail.com>
Subject: Re: [PATCH] eeprom: at24: use of_match_ptr()
To:     Peter Rosin <peda@axentia.se>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

On Wed, Nov 22, 2023 at 6:14=E2=80=AFPM Peter Rosin <peda@axentia.se> wrote=
:
>
>
> 2023-11-22 at 17:57, Bartosz Golaszewski wrote:
> > On Wed, 22 Nov 2023 at 17:41, Peter Rosin <peda@axentia.se> wrote:
> >>
> >> Hi!
> >>
> >> 2023-11-22 at 16:59, Bartosz Golaszewski wrote:
> >>> -             .of_match_table =3D at24_of_match,
> >>> +             .of_match_table =3D of_match_ptr(at24_of_match),
> >>
> >> If you do that, you will need to also add #ifdef CONFIG_OF around the
> >> at24_of_match definition, of you'll trigger a warning about an unused
> >> const variable (for some configs). I think.
> >>
> >> Cheers,
> >> Peter
> >
> > Nope, no warnings even with W=3D2. This is true for unused functions bu=
t
> > unused data structures are just silently removed.
>
> Then I wonder what the difference is from the following?
>
> https://lore.kernel.org/all/202311161306.opyfcoCY-lkp@intel.com/T/#m3a33d=
c4c3221ae167563bcff70757af776cf07b1
>
> It sure looks like the exact same pattern to me.
> I.e. a static const struct of_device_id paired with of_match_ptr().
>
> CHeers,
> Peter

Ah, we need __maybe_unused here.

Bart
