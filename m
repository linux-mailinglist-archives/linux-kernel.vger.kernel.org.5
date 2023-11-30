Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B577FF8A1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345951AbjK3RnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbjK3RnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:43:19 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B39110E4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:43:25 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-4b282c52967so673437e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701366204; x=1701971004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14uxlrCdKAjLbCLx+8PJH1+a+HObuZd4biY2ZHTShlo=;
        b=v2k173ymT1jpTBuz4BsWPyS9ScnMK2ol3X3fCGIJrD1nIaY6QtkAeTJna9xMEltF2g
         heVP1q5Nk2Kwbjk4aK1sII/6JFwqPZtmbR/BtYEClMC7+qt3A9xHJxivuDRiZrEQM0uy
         yiwNlHUqo4BfeVw1W665keCVkpf6xrJxxqQY9QQXik59YvF6cPYpw66bkCG58R60U7ig
         T4MWMTCrEr1Q/r8QMUOrW4P4sQqYirPj1WpFIyJerEwaDwvMMicHRIxCJOpQh0MEAbmW
         /sh2+pdE68mbh7bvIHHbR33acgnEWXhwqcbEKbLSD0A6fEwHgy8X0ooDNP5h5MiUBuyI
         +2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701366204; x=1701971004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14uxlrCdKAjLbCLx+8PJH1+a+HObuZd4biY2ZHTShlo=;
        b=q1N3Ks1anhOpkJEsIOsQr20HvUBjHCjWpkqToxbwSyWNE4SbC4L7dOb8Cz5CeT+zhF
         niTjd7JICliQsdszxuMOK+Ufl+jw88BpyirwmVrXMCig+JWTMrdQNI4NRgYb1mLozUJ3
         F4MX6ePR+prdjqOukSLdUHUz8x4mNtdCD9hRz0gsUoQODCmPNkKjFZr55orhg1k2jf47
         h8reoddUMqgweKD/hQVhCYH0j5OVJwY+LZmHuCZNUZaV8paMz4cDxJKBMu1J4wenVBzE
         EO445im+2M7GDlpb5SVnDcZCeoDdECq+2MkPjnGMAJwKLAPGgSfXqkmqQ9MiODbIm38d
         SBJA==
X-Gm-Message-State: AOJu0YxqECDLge17VSNZ22S2TptnuDQX0FFJc3Ri2Y9xa30yjGSVLy2x
        VjIOTYdgkhJqyf5wsz2qptN4mMaywRlMO2qIcGVkpw==
X-Google-Smtp-Source: AGHT+IHdm5ZfSSccjAd5rIBBdPjUn6kaUJLSr4mGe5naXMKUwGwxR5dee6WeMqL0zbSPV61Ps9+prBL6ttnCB6SOZEk=
X-Received: by 2002:a1f:4a45:0:b0:495:e688:72b7 with SMTP id
 x66-20020a1f4a45000000b00495e68872b7mr16727914vka.4.1701366204615; Thu, 30
 Nov 2023 09:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20231130134630.18198-1-brgl@bgdev.pl> <20231130134630.18198-9-brgl@bgdev.pl>
 <ZWi6V8tG4YoNRkpn@smile.fi.intel.com>
In-Reply-To: <ZWi6V8tG4YoNRkpn@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 30 Nov 2023 18:43:13 +0100
Message-ID: <CAMRc=MfoJ+NFNFand8K7DVZP3Qdz=kp5+XBG_aAJ7-Twq8wvZA@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] pinctrl: sppctl: use gpiochip_dup_line_label()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Thu, Nov 30, 2023 at 5:37=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Nov 30, 2023 at 02:46:28PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Use the new gpiochip_dup_line_label() helper to safely retrieve the
> > descriptor label.
>
> ...
>
> >       for (i =3D 0; i < chip->ngpio; i++) {
> > -             label =3D gpiochip_is_requested(chip, i);
> > -             if (!label)
> > -                     label =3D "";
> > +             char *label __free(kfree) =3D gpiochip_dup_line_label(chi=
p, i);
> > +             if (IS_ERR(label))
> > +                     continue;
> >
> >               seq_printf(s, " gpio-%03d (%-16.16s | %-16.16s)", i + chi=
p->base,
> > -                        chip->names[i], label);
> > +                        chip->names[i], label ?: "");
>
> So, as it's non-ABI change, we still can use "reserved" word here as well
> ("Unrequested" or whatever.)
>

See my other comment regarding the changes in output.

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>
