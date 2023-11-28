Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527147FB8D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344474AbjK1Kz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344189AbjK1Kzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:55:42 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391FB189;
        Tue, 28 Nov 2023 02:55:46 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6c4eb5fda3cso5281351b3a.2;
        Tue, 28 Nov 2023 02:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701168945; x=1701773745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDdeUFllCI6cz5ZamrullL8d06k38FlFlbto7fVB9l4=;
        b=B4m/PFfa51fSzsZGi09BtmtawHjidxBuaPIJEj4eHWLt2uldpHfh8fI6CiuzcshL4L
         /lMqMVd3aEacZh59TeNCpGRdlC0rexSRIVhFi0Hry6n9GHF6xZKns0f2LWtIYx3IoJFO
         /XP5sdAWGR1kxS3V+5C4E9Jqoy/FpD2RrEPGG0ODCkvoeD8r4B2Xd64DsuTemUU0vY2t
         IcKm0vXjZzjxyiffMWGWUEITB+xoUAXfySZMevh2Gch2iAnDVyMKJaKDByPGyparw0Jb
         x3OH0khQsZIcwU4M0yqCK/JNnIUZhptwsfzHTTOqwJDUc8QLPYQ/31Lm3+UdqK4ltBxh
         /QOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701168945; x=1701773745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDdeUFllCI6cz5ZamrullL8d06k38FlFlbto7fVB9l4=;
        b=iiVweCLVcP8Rindxxgf4sgp1exw0+M19hy0tcp+WoSkTN1r7PzPMaONo5zLRTn5fHr
         Bya9iQCsCVtF+cDphmQx1hFwUJ6sYvrrF2DYYTO3m5pJI5iq5u1OGrpBqm1rPPzEbqTY
         hR7OYMGhh9E4mZzivBNEXx9C6Pu+f6XGGi25ExOYNWUAg++VxONKk96gZENvt3ooNmva
         1aooTYWLt7PZL/gMZI2yauRdTadzQYdqjxCI5ed5Xw3w3uOVwc8Zr4yzws2dFbjLo/NW
         9K3Gw8kQNHe5h6sVW5SMcsQ2lg1CCVagPvj+LAx+qsGQnJd+j+90pOF81i6X8qCP7yJE
         A+EA==
X-Gm-Message-State: AOJu0YzkUwW5xLnwMZwW5ZbnMKup//GSEUMKENv2XoaWOqWuREz15H5R
        HWyRRRHQU5KlyGa9B4ysqdnqV8QQePuUzy5fsak=
X-Google-Smtp-Source: AGHT+IF24zFZZLIL6TJUNOQhmXdxP/jw4lM1esNCOX7reQjH2BztbwpEI40LFIB0b45T3tk6Lte/jzEWuK1W1Xw9XOk=
X-Received: by 2002:a05:6a20:72a5:b0:18c:1d42:4e13 with SMTP id
 o37-20020a056a2072a500b0018c1d424e13mr15539521pzk.25.1701168945526; Tue, 28
 Nov 2023 02:55:45 -0800 (PST)
MIME-Version: 1.0
References: <20231123132749.108827-1-boerge.struempfel@gmail.com>
 <CAHp75VcBMbENVKhbdJnXHGxAP85_5CMNxoq7JqV5XbUyRLPoaQ@mail.gmail.com> <CAEktqctA0KWmL_W6aVM67DWB0Q6hOWUQqMwkOp6hn4+iouj1cA@mail.gmail.com>
In-Reply-To: <CAEktqctA0KWmL_W6aVM67DWB0Q6hOWUQqMwkOp6hn4+iouj1cA@mail.gmail.com>
From:   =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <boerge.struempfel@gmail.com>
Date:   Tue, 28 Nov 2023 11:55:34 +0100
Message-ID: <CAEktqcuxS1sPfkGVCgSy1ki8fmUDmuUsHrdAT+zFKy5vGSoKPw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: sysfs: Fix improper error handling on failed export
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, bstruempfel@ultratronik.de
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

Hi Andy,

On Thu, Nov 23, 2023 at 4:01=E2=80=AFPM B=C3=B6rge Str=C3=BCmpfel
<boerge.struempfel@gmail.com> wrote:
>
> Hi Andy
>
> thank you for your feedback
>
> On Thu, Nov 23, 2023 at 3:25=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Thu, Nov 23, 2023 at 3:30=E2=80=AFPM Boerge Struempfel
> > <boerge.struempfel@gmail.com> wrote:
> > >
> > > If gpio_set_transitory fails, we should free the gpio again. Most
> >
> > We refer to functions as func() in the text and comments (note parenthe=
ses).
> >
> > GPIO
>
> Thanks for letting me know, I will update the the commit message in
> regards to this.
>
> >
> > > notably, the flag FLAG_REQUESTED has previously been set in
> > > gpiod_request_commit, and should be reset on failure.
> >
> > Same about func().
> >
> > ...
> >
> > Seems the correct fix, but you may also add that no existing user is
> > returning anything except 0 or ENOTSUPP that is converted to 0 in
> > GPIOLIB core code. Hence no Fixes tag is needed, but still possible if
> > maintainers want it.
> >
>
> You are right. For now, all mainline users are returning 0. We only found
> this due to downstream-specific code. I'll add a comment about this not
> affecting any existing users to the commit message.
>

A small update:
I looked through the possible users again, and there seems to be at least
the possibility for some other return values. The reason for this is, that
the .set_config() of the specific gpio driver is called during the
gpiod_set_transitory() call. For example the .set_config() of gpio-aspeed
might in certain (somewhat unlikely) cases return -EPROBE_DEFER as
well as -EINVAL.

However I don't think, that these conditional paths can be reached on a
properly configured system.

Kind Regards,
B=C3=B6rge Str=C3=BCmpfel
