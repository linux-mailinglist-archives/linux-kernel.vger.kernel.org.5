Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F777CCB76
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344071AbjJQS7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbjJQS7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:59:23 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350A1FD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:59:19 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7d532da4bso75781177b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697569158; x=1698173958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8DmmIH/lFFfF79wxED+iF4M24NCCZPlLo71IiFH+ro=;
        b=rus6ndFK/otkfmKcPZzg5qAt4ejLRZJyPbkJo9g3auvhtJrD5zRTBQjVkeDvCvdgxZ
         VCURc3+mcaq1aDkYf71C9jEQz8nfx5Jr0o8jQ77jQzcW8CiFkrkNv8cLtC2U2SL4zHiw
         R3n0iDeT69EKFUl8UqFBmmSP75+9haSHxQEt5HTuvXlwibooc+amfBa5T6WpiM6hVaYR
         089yOtPepppbljzfNkZ31yUkBEl4mnNJgYBMin2i6nrQCIQQ7zXivv5kKDsGTXrlamao
         eYUFfvwcYp0tpr+MsRV+8/kovSe28uB8fQr23OWYtxCOgb0gp1aL8sz+V25VUu3pX/zH
         YcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569158; x=1698173958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8DmmIH/lFFfF79wxED+iF4M24NCCZPlLo71IiFH+ro=;
        b=vngfvU807X57huFDJJ4aOO9pRbpS5VKbvSVPUTTOMLfAAdAiTQVYw2D4PJuzHJdgWC
         a2fVSFILKhKoNZIOnBGqGxU220/MceVP1veoybcDq7LdvxXiUgNLFU0pe8j9Gz6vx41U
         aRFMz4Qg0gSb8W5/5ONXRgOM2vI9yac9YpRbCDfjXb39RhevwnhOg/SQOF7v08BLDLUm
         lu+DrDecfkQLWjxNrNseQCbfY5jZB+rq7dB93dBUyj9QTII7PExpau2n5yhlQioKwfT+
         DlxrgqgFGMKl6azx7zx+xT7NOXewfUD8Ion6mgykIhMi5kxmbXeHlLE+kG19b7qI/aBO
         bv4w==
X-Gm-Message-State: AOJu0Yy+FBeirMCfAbvmdfoObdtLtoIq/sVtXdYmyukTmeK46/1CmLsW
        SSnG+cXEOKHLCwfIApokyRaeg5wof2k9pwh8eUQ5Fg==
X-Google-Smtp-Source: AGHT+IFU00Dh8oETlxfp5Omah7Gw+WDzAOFaq+HszRs0k/+e7TNQBuJA4vFQSN1XaWxCLKX0xSzByeCUL7IDachnAvQ=
X-Received: by 2002:a81:924d:0:b0:5a8:1fea:37ee with SMTP id
 j74-20020a81924d000000b005a81fea37eemr3263039ywg.22.1697569158409; Tue, 17
 Oct 2023 11:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231017141806.535191-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbHJHsgJ=3pYveP-x-Vuwwf3ib6TnFOt3UpCrKevf=d1w@mail.gmail.com> <ZS7TuodhwNxU9Ez6@smile.fi.intel.com>
In-Reply-To: <ZS7TuodhwNxU9Ez6@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Oct 2023 20:59:05 +0200
Message-ID: <CACRpkdZfzq81SZnEpB_Acp_=8Xc2TEMNi8yS_j4wNBcQKXgrgg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Revert "pinctrl: avoid unsafe code pattern in find_pinctrl()"
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 8:34=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Oct 17, 2023 at 08:18:23PM +0200, Linus Walleij wrote:

> > In the past some file system developers have told us (Ulf will know)
> > that we can't rely on the block device enumeration to identify
> > devices, and requires that we use things such as sysfs or the
> > UUID volume label in ext4 to identify storage.
>
> While I technically might agree with you, this was working for everybody
> since day 1 of support of Intel Merrifield added (circa v4.8), now _user
> space_ is broken.

Actually, I don't agree with that, just relaying it. I would prefer that we
solve exactly the problem that we are facing here: some random unrelated
code or similar affecting enumeration order of mmc devices.

It's not the first time it happens to me, I have several devices that chang=
e
this enumeration order depending on whether an SD card is plugged
in or not, and in a *BIG* way: the boot partition on the soldered eMMC
changes enumeration depending on whether an SD card is inserted
or not, and that has never been fixed (because above).

> > That said, device trees are full of stuff like this:
> >
> >         aliases {
> >                 serial0 =3D &uart_AO;
> >                 mmc0 =3D &sd_card_slot;
> >                 mmc1 =3D &sdhc;
> >         };
>
> And Rob, AFAIU, is against aliases.
>
> > Notice how this enumeration gets defined by the aliases.
> >
> > Can you do the same with device properties? (If anyone can
> > answer that question it's Dmitry!)
>
> No, and why should we?

Because device properties are not device tree, they are just some
Linux thing so we can do whatever we want. Just checking if
Dmitry has some idea that would solve this for good, he usually
replies quickly.

Yours,
Linus Walleij
