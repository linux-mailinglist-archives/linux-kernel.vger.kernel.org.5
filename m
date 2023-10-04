Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4DB7B7CCF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242086AbjJDKE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjJDKEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:04:55 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B86D83
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 03:04:51 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-4527d65354bso989069137.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 03:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696413890; x=1697018690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMELFoOHqrq2qjYrgWfDqbUH1J8YwQQlpJkVwboYtS0=;
        b=XuuBaoFkQdLbxJJZ0i9HMDnu+u6PHO/9qCMM0mH9iqz6yiDGx9IQfrHS7B0J8qq4/S
         fTgMio5dQdrW6BdyZVABjfc7sw3776gjfEnGPiKfwvYZKNBdc3hAEMcALDoxg+j+8mg+
         1owFrQajbMLLagS6ecVsu1MM+yCLNFGdj0S995R4J4joqmMHVVBgdPkWQ1GbnhMVg4z3
         Ssv2RYZQhYuf+jYcQDc/qaMIK31L64UsasbPX+IT9RYnVxKuyBdo05W0NynpxEWK/d4+
         vVSO8XxsNtFPEwOLE7QCR0FCkqUP6566MG7pJ+QMW/+scvSIWgreJQnvvAS9+VRbVewG
         KhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696413890; x=1697018690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMELFoOHqrq2qjYrgWfDqbUH1J8YwQQlpJkVwboYtS0=;
        b=G6tdjb4CSZbT7apbxkfQ1QLTnMjaqjaBtIsL6ezxC8Ub5Mas9aGt42q9Gn6u/pHbdd
         1T4DYGLDyeihcksSyD9OGGyEGmYXkAPFZ4MBV/wXpdb4CzHsLLSbLbPlKJXu+Je5HxRB
         A8S/vb8NIlN9JllqDYddjtn2Jn7mb+9g65mnruEEMrbq47pDsPXPaFgIz3PHFA6EuDGg
         4fv2oSZ1FHju6SqddqMn/s2O0VRMSqBIaJm2etKSWu4jSulqZZSI/wG3wLoRc7xxW3YF
         /UEOXGU2oNE5it1kdt8VU6rCG5TlSqfEW8m0bBtP2r3Wr8S2hau+Ju1szydXYxSQLjbc
         5MaQ==
X-Gm-Message-State: AOJu0Yyu83XcZMe4ITWW4NjXuQzErIRUw7L+5a6uNMxDApOqtKjR/T3i
        mIgmR74+8HyCXdi4zombgScEEg4jkWgcAR8PbOWQ9Q==
X-Google-Smtp-Source: AGHT+IHfzt5HM1Sbq001SWA0TWSGaVAUdcRdztDff9M5pbaXeVHCX8GGkCvQYu5thG2Jy/NVEx6Y4cUxfv1FL+aDnw4=
X-Received: by 2002:a67:f4d3:0:b0:452:66a7:1ac with SMTP id
 s19-20020a67f4d3000000b0045266a701acmr1671784vsn.6.1696413890436; Wed, 04 Oct
 2023 03:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230911094443.14040-1-brgl@bgdev.pl> <cd4df23c-cc02-6723-e36d-34ca03409e6e@nvidia.com>
 <CAMRc=MeWXapho1bsX9Si5uSx7MWVhpT2cqrv5S+qPo51Ko=Vtg@mail.gmail.com>
 <7766de61-a046-3e17-1322-28bd7f1e61da@nvidia.com> <CAMRc=Mfbt0iUbM42zR0ZrBWgbQkctQm3LxwiFFP5dXNuQC-EqA@mail.gmail.com>
 <59ea74ba-b951-cf89-9d7f-bc7212ddb08a@nvidia.com>
In-Reply-To: <59ea74ba-b951-cf89-9d7f-bc7212ddb08a@nvidia.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 4 Oct 2023 12:04:39 +0200
Message-ID: <CAMRc=MeuMkExMef1fsEV9pPHyshGTLJLSHpT2vjLVXgEm6CD3A@mail.gmail.com>
Subject: Re: [PATCH] hte: tegra194: improve the GPIO-related comment
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        timestamp@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 6:42=E2=80=AFPM Dipen Patel <dipenp@nvidia.com> wrot=
e:
>
> On 10/3/23 1:58 AM, Bartosz Golaszewski wrote:
> > On Mon, Oct 2, 2023 at 6:27=E2=80=AFPM Dipen Patel <dipenp@nvidia.com> =
wrote:
> >>
> >> On 10/2/23 1:33 AM, Bartosz Golaszewski wrote:
> >>> On Fri, Sep 29, 2023 at 11:38=E2=80=AFPM Dipen Patel <dipenp@nvidia.c=
om> wrote:
> >>>>
> >>>> On 9/11/23 2:44 AM, Bartosz Golaszewski wrote:
> >>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>>>
> >>>>> Using any of the GPIO interfaces using the global numberspace is
> >>>>> deprecated. Make it clear in the comment.
> >>>>>
> >>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >>>>> ---
> >>>>> This was part of a wider series but since this is independent, I'm =
sending
> >>>>> it separately.
> >>>>>
> >>>>>  drivers/hte/hte-tegra194.c | 13 ++++++++-----
> >>>>>  1 file changed, 8 insertions(+), 5 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.=
c
> >>>>> index 6fe6897047ac..9fd3c00ff695 100644
> >>>>> --- a/drivers/hte/hte-tegra194.c
> >>>>> +++ b/drivers/hte/hte-tegra194.c
> >>>>> @@ -407,12 +407,15 @@ static int tegra_hte_line_xlate(struct hte_ch=
ip *gc,
> >>>>>               return -EINVAL;
> >>>>>
> >>>>>       /*
> >>>>> +      * GPIO consumers can access GPIOs in two ways:
> >>>>>        *
> >>>>> -      * There are two paths GPIO consumers can take as follows:
> >>>>> -      * 1) The consumer (gpiolib-cdev for example) which uses GPIO=
 global
> >>>>> -      * number which gets assigned run time.
> >>>>> -      * 2) The consumer passing GPIO from the DT which is assigned
> >>>>> -      * statically for example by using TEGRA194_AON_GPIO gpio DT =
binding.
> >>>>> +      * 1) Using the global GPIO numberspace.
> >>>>> +      *
> >>>>> +      * This is the old, now DEPRECATED method and should not be u=
sed in
> >>>>> +      * new code. TODO: Check if tegra is even concerned by this.
> >>>> This use case is to do namespace mapping from gpio subsystem to hte.=
 Few doubts:
> >>>> 1. What does deprecate mean here? Does gpio subsys not use global sp=
ace anymore?
> >>>
> >>> It does but we don't want to expose this to external users in any way
> >>> anymore (and haven't to for years). This is what deprecated means.
> >>> Users should deal with opaque GPIO descriptors not global GPIO
> >>> numberspace.
> >>>
> >>>> 2. If yes, what GPIO number is set when it comes from gpiolib-cdev, =
as based on that I may have to
> >>>> reflect in the mapping, tegra194_aon_gpio_map for example.
> >>>
> >>> Why DO you have to use a GPIO number though? If HTE needs just a
> >>> number from some HTE numberspace (which in itself may be unnecessary)
> >>> then why not just keep a local IDA for it? Do you have to know the
> >>> GPIOs internal numbering scheme to make it work?
> >>
> >
> > Dipen,
> >
> > Please set your mailer to wrap lines around at 80 characters as is
> > customary on the mailing list.
>
> my email client misfired, will make sure. Thanks.
> >
> >> humm, overall, I just need to know which GPIO it is, for example, GPIO=
 controller X Port A GPIO number 3
> >> to do proper mapping.
> >> Continuing from above example, the hte driver gets:
> >> - GPIO Controller X from DT node
> >> - the rest details in current code gets it from [1] and [2]
> >>
> >> If there is alternate method exists, I would like to explore. I think =
IDA will not help in this case as ID assigned
> >> does not hold meaning in this context.
> >>
> >> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/drivers/gpio/gpiolib-cdev.c?h=3Dv6.6-rc3#n760
> >
> > Here: any reason why we have to translate the desc to the global GPIO
> > numberspace? Can we just pass the descriptor pointer directly to the
> > HTE subsystem?
> Sure, if from GPIO descriptor with combination of any helper APIs from
> the GPIO subsystem can help identify the GPIO pin, we can eliminate the n=
eed
> to pass global number (I assume gpio desc
> can be only accessed/manipulated using GPIO subsystem APIs)
>
> >
> >> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/drivers/hte/hte-tegra194.c?h=3Dv6.6-rc3#n421
> >
> > I still don't understand why you need to know the GPIO base? I'm not
> > quite sure what the role of line_id is in this driver. Is it only to
> > index the array?
> >
> > Please bear with me, I don't know this subsystem very well.
>
> Sure, no problem. Let me see if I am able to elaborate:
>
> 1. Map arrays' indexes are GPIO offsets so to avoid having
> the extra field for the GPIO numbers.
>
> 2. The HTE driver needs to know exact GPIO to enable corresponding bits
> in its registers. For example, hte register bit 3 would correspond to
> GPIO 6 of GPIO controller X. If gpio descriptor is passed here, I think
> I would need to do some conversions to identify the GPIO to enable
> corresponding register bits. In the current scheme of things,
> I though it was easier to identify passing the output of the desc_to_gpio=
* API.
>
> 3. Since GPIO global space is runtime, need base to calculate the offset
> where offset does not change. So in the above example, gpio cdev would pa=
ss
> 306 and HTE does simple conversion from the base, ie. 306 - 300 =3D 6.
> Now 6 will serve as pin number as map array index to find the register.
>
> 4. Overall, I rely on base + global number to do namespace conversion
> between gpio and hte subsys as far as gpio-cdev use case is concerned.
>

Ok, so you *don't* need the global numbers, just controller-relative
offsets. This makes sense. This ties nicely into my plan for removing
all accesses to gpio_chip except for GPIO providers.

Looking at the tegra dts I'm surprised that the GPIO controllers that
use the HTE don't take the hte_lic or hte_aon phandles as arguments.
How exactly do they resolve the HTE device to use for timestamping?

In any case, I think this commit is still correct.

Bart

> >
> > Bart
> >
> >>
> >>>
> >>> Bart
> >>>
> >>>>> +      *
> >>>>> +      * 2) Using GPIO descriptors that can be assigned to consumer=
 devices
> >>>>> +      * using device-tree, ACPI or lookup tables.
> >>>>>        *
> >>>>>        * The code below addresses both the consumer use cases and m=
aps into
> >>>>>        * HTE/GTE namespace.
> >>>>
> >>
>
