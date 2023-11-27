Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7367FA406
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjK0PF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjK0PFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:05:25 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42A6AA;
        Mon, 27 Nov 2023 07:05:31 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-da819902678so4007564276.1;
        Mon, 27 Nov 2023 07:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701097531; x=1701702331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A14//g2UoXkLcdPQSx/k3Kefdj+ue5KGp8TIARcBONU=;
        b=I8LJpZ51Rmd3GLFTKtuVTrpb/fOvwIcetGBllIJx13uJcV4gkZ6j4cfiJ2djUtf1ld
         l+iaBWUM4K52tU99JjAhC+vVVfBQrtg7mAGVJta1alH3cf7IG72dE4yupewETfH12P8d
         QZZsOoyd0VVlqC07cgGh1sJhPnOzIzC/Ff44jatsHXEsU4ixJdJs7BtbVWEkgDXYa4xN
         W0IEB5oqXG9wMnqYr26jo5zhhOga2GMSXsggOuAhMkdP4kTsgge5LszoWJeaaAcjuxMJ
         uhH37eMgR+RzVYOWwcsIe/zdg0eGhOKrnwUQrFDNhLYinSt0Q1c81ebZvkvfuUm5kHxU
         e8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701097531; x=1701702331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A14//g2UoXkLcdPQSx/k3Kefdj+ue5KGp8TIARcBONU=;
        b=PG8BOIohJf+FW7qVL0Us8Km4tzlbPFQwuutre7kYvqfSnDNo2cCLovwVMzJvyCE4vd
         JUxNGOGQ6R0wFX4B7ZaYY9re3t/e2EBgr6KsiIraav++Jf1OyyfxFFl/8Z0VPnIS+T+u
         u6w3/yGo+x9vfFdRIKyobUF6Y13hnTJhw2HRZRJFaygc7+CRewc1nv5L1mSwX7huWmS5
         GUFkPy0mKBJRGRHPLQgMsugiciZBz8f3w9CMjVy0kVuZIRR7y6N95a9L+m23FTuiIrxf
         KHsx5uMHdV1KleNixzH197pPuUXszT1Yon0HP0QsMbit8MMcUDJA/5Y37O7tOA5/h5lb
         8UNg==
X-Gm-Message-State: AOJu0YyVoodxCEJglDmac5IVNJPulKFKP7AUHRQPmQPzGXUz3Ag5917r
        DDYomaJK+7HJZZaP3/upQxeZLFoblO0DEZNxWw0=
X-Google-Smtp-Source: AGHT+IFD5Yhlfu1wvzt/S0Z6RQjPCozzczGVg6VzXL32NvqafhWv5m2ewDPmpfJRhWrDAzc1Y5Sk8oPfeca2QTWxtBk=
X-Received: by 2002:a5b:201:0:b0:d9a:3bee:2eeb with SMTP id
 z1-20020a5b0201000000b00d9a3bee2eebmr12061112ybl.60.1701097530941; Mon, 27
 Nov 2023 07:05:30 -0800 (PST)
MIME-Version: 1.0
References: <20231120194802.1675239-1-andriy.shevchenko@linux.intel.com>
 <ZVzy227f3cIiTmtE@smile.fi.intel.com> <CACRpkdZi5uW7saBFFA=VWDYpj_MCw3he2k-CLh__zJzUOOEkyw@mail.gmail.com>
 <ZWCJP48WopQdCp6h@smile.fi.intel.com>
In-Reply-To: <ZWCJP48WopQdCp6h@smile.fi.intel.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Mon, 27 Nov 2023 17:05:19 +0200
Message-ID: <CAP6Zq1jrX+Mg70mWA3hEQDBYBU5PmDPdLPPEOZ5o+fSKw053rA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: nuvoton: Convert to use struct pingroup
 and PINCTRL_PINGROUP()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, 24 Nov 2023 at 13:30, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Nov 24, 2023 at 11:09:07AM +0100, Linus Walleij wrote:
> > On Tue, Nov 21, 2023 at 7:11=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Nov 20, 2023 at 09:48:02PM +0200, Andy Shevchenko wrote:
> >
> > > > The pin control header provides struct pingroup and PINCTRL_PINGROU=
P() macro.
> > > > Utilize them instead of open coded variants in the driver.
> > >
> > > Linus, I dunno if you are going to apply this sooner (assuming Jonath=
an is okay
> > > with the change), but I have a bigger pending series where this will =
be a
> > > prerequisite. So, when I will be ready and if it's not being applied =
(yet),
> > > I'll include it into the bigger series as well.
> >
> > No answer from Jonathan but I just applied another Nuvoton patch from
> > Tomer, so maybe Tomer can look at/test this patch?
Sorry, but I do not have wpcm450 board to test this patch.
In general, the patch looks fine.
>
> Jonathan acked it  in the reincarnation in the series (see my big one).
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Sorry I couldn't help.

Best regards,

Tomer
