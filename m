Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3086803535
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbjLDNkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbjLDNkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:40:11 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D60172B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:39:46 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7c45acb3662so1147925241.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701697185; x=1702301985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aykN48i+e3OoDO3X840k13yYydXS1iFRL8bf9Vv0ZMg=;
        b=0NulV3dgLKw3VvWNZc6KYS1u6UI4h7GORzUkyGe8vAgKx8Drd/Aw2hP23YEOGiMIr1
         Q42PZi+VncLXclLeRIoPW2MHdb6qkNK1xgnyMfKAJIHB3Xz+wRzisoAiA+zKooNkKFiC
         HYKVFZP/L48KskyI6j0OQ2hX6j030r+OkZxUjdeRfWnFlcM7XK864AzHxGa8F8PQ2A2T
         /23yeIUv0vaqU34LXkQS/w2Iete/BdieUBtidFFaC7notEUeDHfqaIJqg0FafoR+zdER
         EYPkr0qqRJI8L5NtmT8D0om2vsO/Cw7haDutdOmZqT+ReG+JPrOq+kVUs7NiQ/kWQdkC
         DZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701697185; x=1702301985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aykN48i+e3OoDO3X840k13yYydXS1iFRL8bf9Vv0ZMg=;
        b=fLbN4wrGRW4yLFA8iPq73AWEDOfY6ZUeyTdNlCFjypmHPGiISrvPUfTHK3cMVMA7Ai
         /9Ha32IiNin4zuMn1bpQsU/nTpHkFW4KXzRa4iX2FxDnTQR00kbMElaNctSLeo4lAWrD
         eORKNNM42IIybRTD7wVVMe8/WA6rjUopyB9I9TmbqG/EHFpEEBmAwgHDGObcoPy01Rdu
         wjH6hHOZ2dKLH43HiG6ffzQ9QCF+mEtCqf9tQ1FtrfdJyOt/+JltCu5bBubZYa1hE0tD
         ks1rTYtu40nLatemyVA/3mj7WS+rgd1bFyleoKPdSyhNilbDZlhmqplN03AIa8adNSAN
         PoOw==
X-Gm-Message-State: AOJu0Yx4sGSliMHbUbSF7gOv2l4/rc86GTgSbybsFmYqLf8TWYkN0puk
        12TOpuNWFFEUd04OvQppKvu78yWKze4pHIi4hEbZdOq+MwKOiYAz
X-Google-Smtp-Source: AGHT+IEkIy6UUCzB9F0dzSqV4WUQqHoTfYB3bCQ8j9jAbkYaTLAsdfBIdzsdB1eOollkeIade3UxRTTmDTxTpIl8oNY=
X-Received: by 2002:a05:6122:32cf:b0:4b2:c555:12fc with SMTP id
 ck15-20020a05612232cf00b004b2c55512fcmr982063vkb.27.1701697185442; Mon, 04
 Dec 2023 05:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20231204093509.19225-1-brgl@bgdev.pl> <20231204093509.19225-10-brgl@bgdev.pl>
 <ZW3TEQok8Ri-epw8@smile.fi.intel.com>
In-Reply-To: <ZW3TEQok8Ri-epw8@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 4 Dec 2023 14:39:34 +0100
Message-ID: <CAMRc=MdaWEv+aj-W8TTJVDgKBOTrMt48ox48e37UAaY8FhorOw@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] gpiolib: use gpiochip_dup_line_label() in
 for_each helpers
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

On Mon, Dec 4, 2023 at 2:24=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Dec 04, 2023 at 10:35:08AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Rework for_each_requested_gpio_in_range() to use the new helper to
> > retrieve a dynamically allocated copy of the descriptor label and free
> > it at the end of each iteration. We need to leverage the CLASS()'
> > destructor to make sure that the label is freed even when breaking out
> > of the loop.
>
> ...
>
> > -             if ((label =3D gpiochip_is_requested(chip, base + i)) =3D=
=3D NULL) {} else
>
> I see, but...
>
> > +             if ((*_data.label =3D                                    =
                 \
> > +                     gpiochip_dup_line_label(_chip, _base + *_data.i))=
 =3D=3D NULL) {}   \
>
> ...can we drop this NULL check by using !(...) notation?
>

I'd rather not. this is already quite hard to understand and a single
`!` is less readable than `=3D=3D NULL`.

Bart

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
