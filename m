Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6E37EE476
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344093AbjKPPef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjKPPee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:34:34 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851A4195
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:34:30 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5446c9f3a77so1497221a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700148869; x=1700753669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVNPAkisoMvkTyEW/8SK0tYA7Rxlmav3LfVvFoFHM20=;
        b=TWBX3+dFKB6YDGnBNNRGVJsl1S5ajnnZVcPODjnz5+0EnYsMt0l12mH9Pr+eRfXaS0
         HJOSnoNEtSNYX5hMHEd6Hkg/3DuV0C8srrxjzV/FTQgS5Dz/y2RubeGZukn0i1cBTFws
         Gt1j26x+Jy21AAXtTqPE19RbWB9zCwjO9kwV45o69i09K2cIWi6/v2/DZw5Iz8CctgRK
         1jkYg5QkuLlBQwplsYv4TMV7eXGY/i1Dmk11zB3bOUAcp/P4m7gpw5OLbHzmgXw6EbQN
         pb6P8b8pa3XWwdaApSx5oqk0UUmXGaVPLiu9+2NKkpZmo8VuR6kG8I9aJaRgzfASmL4q
         zmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700148869; x=1700753669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVNPAkisoMvkTyEW/8SK0tYA7Rxlmav3LfVvFoFHM20=;
        b=LtvKY8YznVo5jODFLXaq2qqU3aFq4p+qcTLsK0wiw/3HKFW38wsSjjeW4q6N8StqIO
         bC934ZMsaWZj7VHS4sJMlMCUABCI+XJ9NlaPN6B9kBZi6sMRwFKZKmkLDCctOurJI23V
         iu3/3jyvrSRy4FrswfnUG80NCO2TU3Ot157NREohLoRPaJ6NUPobemiwC2vb64PA5F3A
         8l3V0CMR4+1YLba08qwHFGhQJAyf2HoMDMBz52+tKXiQ15UgQ/xwly8omICYKOH+5G6A
         pcZC/MjXFlsTl4NbfqF6kUbCBFUxA2tToFf0B12MH/bd2TcnG0Yb0bctdAssfOiPwi1x
         Gi5g==
X-Gm-Message-State: AOJu0YyTOoLUXeq/0yHyzqwWzwVhvTEKDq9THiE2/iVsBiGJANcHXnsQ
        /j35FMGtAPadNsK1xS2gchT/KbqDFAa8Qcbe1mzNqA==
X-Google-Smtp-Source: AGHT+IGU8LjTyWo7/9a7JJdcmY7OssfjuZLP7hCvG5OsrxE9r6+CaW//NaZNOOaBBhBG0Oezv/75uldG2UfPdUmoR4M=
X-Received: by 2002:a17:906:2348:b0:9d0:51d4:4d87 with SMTP id
 m8-20020a170906234800b009d051d44d87mr12024787eja.62.1700148868828; Thu, 16
 Nov 2023 07:34:28 -0800 (PST)
MIME-Version: 1.0
References: <20231110102054.1393570-1-joychakr@google.com> <CACRpkdZ9RHcHh4o5g62ywK0eQHpLZuGUF0Ud6jogk9Sfqe4krA@mail.gmail.com>
 <ZVQkLqDB3KtOlIpK@surfacebook.localdomain>
In-Reply-To: <ZVQkLqDB3KtOlIpK@surfacebook.localdomain>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Thu, 16 Nov 2023 21:04:15 +0530
Message-ID: <CAOSNQF3QeFd857RCJE8wfJ=__-K7Bi4vfMeTVP-+O+LJ7y9SmQ@mail.gmail.com>
Subject: Re: [RFC PATCH] PM: runtime: Apply pinctrl settings if defined
To:     andy.shevchenko@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, manugautam@google.com,
        aniketmaurya@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 7:21=E2=80=AFAM <andy.shevchenko@gmail.com> wrote:
>
> Tue, Nov 14, 2023 at 02:01:48PM +0100, Linus Walleij kirjoitti:
> > On Fri, Nov 10, 2023 at 11:21=E2=80=AFAM Joy Chakraborty <joychakr@goog=
le.com> wrote:
> >
> > > Apply pinctrl state from  runtime framework device state transtion.
> > >
> > > Pinctrl states if defined in DT are bookmarked in device structures
> > > but they need to be explicitly applied from device driver callbacks
> > > which is boiler plate code and also not present in many drivers.
> > >
> > > If there is a specific order of setting pinctrl state with other driv=
er
> > > actions then the device driver can choose to do it from its pm callba=
cks,
> > > in such a case this call will be a no-op from the pinctrl core framew=
ork
> > > since the desired pinctrl state would already be set.
> > >
> > > We could also add a Kconfig knob to enable/disable this, but I do not
> > > see a need to.
>
> Besides questionable code style (inline functions in the C file)...

Sure, I can change that.

>
> > It has a certain beauty to it does it not!
> >
> > The reason it wasn't done like this from the start was, if I recall cor=
rectly,
> > that in some cases a device needs to do the pin control state switching
> > in a special sequence with other operations, that can not be reordered,
> > i.e.:
> >
> > 1. The pin control state change is not context-free.
> >
> > 2. The order of events, i.e. context, does not necessarily match the
> >      order that Linux subsystems happen to do things.
> >
> > When looking through the kernel tree I don't see that people use
> > the sleep state and idle state much, so we could very well go
> > with this, and then expect people that need special-casing to name
> > their states differently.
> >
> > What do people thing about that?
>
> ...I think the patch is incomplete(?) due to misterious ways of PM runtim=
e
> calls. For example, in some cases we force runtime PM during system suspe=
nd
> which may have an undesired effect of the switching pin control states
> (hence glitches or some real issues with the hardware, up to hanging the
> system). Some pins may be critical to work with and shuffling their state=
s
> in an unappropriate time can lead to a disaster.
>
> So, I would consider this change okay if and only if it will have a detai=
led
> research for all existing users to prove there will be no changes in the =
whole
> set of possible scenarious (of system sleep / resume, runtime, runtime wi=
th a
> custom ->prepare callback and so on).
>

I tried to place the calls to set the pinctrl states after driver/user
callback  based on my understanding of runtime code so that existing
users do get a chance to set the state with any special sequence that
needs to be performed post which doing another call to set the state
would be ignored in the pinctrl framework.

But this only would be possible with the assumption that even in any
special sequences executed by users they set nothing but "default"
state in runtime_resume, "idle" state in runtime_idle and "'sleep"
state in their runtime suspend callbacks.
And like Andy mentions about "->prepare callback", if there are
drivers that are setting pinctrl state "default", "sleep" or "idle"
from any callback but
...
int (*runtime_suspend)(struct device *dev);
int (*runtime_resume)(struct device *dev);
int (*runtime_idle)(struct device *dev);
...
it could indeed be a problem.
I'll dig into users of pinctrl_select_sleep/default/idle and see if
there are such cases or if it could be done in some other way.

Thanks
Joy

> --
> With Best Regards,
> Andy Shevchenko
>
>
