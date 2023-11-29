Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A697FE170
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjK2Uzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjK2Uzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:55:48 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B10510C8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:55:54 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7c45fa55391so54852241.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701291353; x=1701896153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QI6JHtznXvmxE5PL87iXN1BnHx/Zg4tCgMdyIcxQ2lA=;
        b=Q9qz13YamJMrwWsjqeLFo5h+5Vbr0FA8GXo5AVwhWZNPZ9z6GEjF45I0W3tEFts2fV
         83Qg/42aqwRBqxYO70bAi3+euKE4dCAkdI808ykqIuQaCkiM/htlVtrms/b+IeKcTjKU
         d1AwXtFeBjylbSg5xHTfr7V7RGIl8Isl9lpIxQ0P7P6zkCyRZ2OJpDvA94jLU3Z10E5a
         fixKx3MeL2j2yxYSAZu3ihBahvPg2SPq0LuCiIiUyZPZTAEks1g2kiZqFYkOpC1VltC0
         aD4z12O83brRfboYOAInH9lBLBuZoXAxdvrk1vaiN/cXWSWkGlic1hl0AFIM70ndf3lg
         YxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701291353; x=1701896153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QI6JHtznXvmxE5PL87iXN1BnHx/Zg4tCgMdyIcxQ2lA=;
        b=GCULbeIiFEV5FZxuhoLwRVUeK6u8tgcO0UgCJ6RyyeMwSomrfN1MrNqOcNq93FRuyV
         YUq4kVPqEtEo1URMWqEL3n4SaC/7tZRX0hoEpCcimprN8ix8nWLWtZ4vFAuZ/kE6wTib
         yTSaExkptyP5uAg4xuugaUncGVnCT7RAykmIylzL0BE/C9+UVwNAg3nzYl9YqG+4mcpl
         wFwU8gdXxCO0AIQ67aE1luc9bpR0nItpV8EgsCkYDFUjTlgtJ7OzH/OH5RjCESZg0yIW
         OlBN2GmwHe/0RiEE2BkqEllYcZBIOrilLmFe5tOxKs01Ce7kDl4VL4Ll6JR0rg+aVBGQ
         mi0w==
X-Gm-Message-State: AOJu0YxBY5WZokI4IaXRQ+cZDsqT7zQUyGejy+NNj/6Q2bWCF8QtPiEj
        hy4BYDrkeSm2JM7BeV3Fo7UgISG9lrHXIFou3uZXwT9uXcUBrabF
X-Google-Smtp-Source: AGHT+IFYja56yAWBv64kZZunPEALyydYma3ufW+t+R0uNHZSBEmO8UtfKU/tUiufd3UXP+tq6eccK0k3AG7Z4sn8Heg=
X-Received: by 2002:a05:6102:e13:b0:462:dd0d:d028 with SMTP id
 o19-20020a0561020e1300b00462dd0dd028mr23246126vst.2.1701291353734; Wed, 29
 Nov 2023 12:55:53 -0800 (PST)
MIME-Version: 1.0
References: <20231129142411.76863-1-brgl@bgdev.pl> <20231129142411.76863-10-brgl@bgdev.pl>
 <CAMRc=MfL2nHF78TUmRjRSUC-2zyMjWotzU7Tv_27mVJPLET40Q@mail.gmail.com> <ZWdQK1kUe3zLqWIb@smile.fi.intel.com>
In-Reply-To: <ZWdQK1kUe3zLqWIb@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 29 Nov 2023 21:55:42 +0100
Message-ID: <CAMRc=Mc8Aahg1gD7DDtMOx77F2N9J10K+BBokY5w2ZDSG0ZJmg@mail.gmail.com>
Subject: Re: [PATCH 09/10] gpiolib: use gpiochip_dup_line_label() in for_each helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 3:52=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Nov 29, 2023 at 03:43:32PM +0100, Bartosz Golaszewski wrote:
> > On Wed, Nov 29, 2023 at 3:24=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
>
> ...
>
> > Any ideas how to handle this one? I was thinking something like:
> >
> >     for (i =3D 0, char *p __free(kfree) =3D label; i < size; i++)
> >
> > would work but it doesn't.
>
> Probably you want to ask Peter Z for this.
>

Before I do, I'll give DEFINE_CLASS() a chance as it looks like it
could be the answer looking at how scoped_guard works.

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>
