Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B8478E3DF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 02:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243324AbjHaAU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 20:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjHaAU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 20:20:27 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C004BE;
        Wed, 30 Aug 2023 17:20:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52713d2c606so221903a12.2;
        Wed, 30 Aug 2023 17:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693441223; x=1694046023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9cTUiRTcMYqhtEMxnwb8DlAD19IswY7y/gCbaQ+V6Y=;
        b=piiCd2guvuggFvoMCdnsZ3K6EohylG4xwE6u1rmRNo5V5Vgl6ocvdQAS7y4yC8WgyD
         5BXgFclAp8X1kWgNbu+1yK21Tomdbl4bnEeG7HfvkwZRBCT6Q+380vKRnapbNLCwgGx4
         q+sylyqZCPSojNYnqOXx4ZuvhUnak1cPrnGgksN989ON1xV6zIszrEUSRc0bYlRHNnVq
         vLJonMv5XBLinXrJC2zRcRha7jqA9c5FAt0U+2hbDGrMjv09L4hmGOLYPS+l0/IuWP28
         m4/XPi3n/ePaFBhvwZMRMQvIT1vnRS9wHnkZQEdzHNC97Wm4QEBnSqdLGPtOQB8QPue5
         1gPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693441223; x=1694046023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9cTUiRTcMYqhtEMxnwb8DlAD19IswY7y/gCbaQ+V6Y=;
        b=fJLQKRYYHOeRsfLh8o5J2uYzj7lQLr/hYttPNb6yh8KA0N3tLUCmr8jOI5vxzHx1qh
         v0uxBX+GDEUtE4D+D/kQqHRnQ3jX44nQ8m+hzUsdGjPzwIgCSeL45MgO4YogqW503xsr
         aQCdLH8PowoODTY+EKciJ9MBZtBotR28OTwSyEWE8MTVXZZTq5DwpierEBOFo23KrjaD
         rMND8Eg3NegqEHUuF29rgt4ar4MB1DkGkGgRCq4uTwKt9XqVT52B5CJOz+akpV8/XUSQ
         qPhKXj3DnTzqTAdszZSJcoJNwm17bTatuBqtvanHBwxfAHyUczVSSaGdTppNkTv3+5dK
         UJLg==
X-Gm-Message-State: AOJu0YzB3vfEBY3xzoLXmQm65vsXfOzXxH6aLCMMzdudgjdYCEzt7A2v
        L51VTpG0VMEuWH8Jv0MMJzlEQIzOe4f8Qjk6Blc=
X-Google-Smtp-Source: AGHT+IHm7k6OxDln7z/XYZdpIY3YtxSHNRTpCJ1iCdW76E+h+G1eBVIT9iDnBEV3zTGnwiAW+9ZensLKX2joawQZ0t0=
X-Received: by 2002:a05:6402:7d7:b0:522:3a0d:38c2 with SMTP id
 u23-20020a05640207d700b005223a0d38c2mr2756822edy.9.1693441222498; Wed, 30 Aug
 2023 17:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <391c4270-637a-2afb-210d-6b6dfef01efa@intel.com>
 <20230828100313.3051403-1-benchuanggli@gmail.com> <CAG-rBig+koxDf3TuC-0p=tcBY_2WM1sPCvRDtjRmR7AnikrN-A@mail.gmail.com>
 <CACT4zj-BaX4tHji8B8gS5jiKkd-2BcwfzHM4fS-OUn0f8DSxcw@mail.gmail.com>
 <CAG-rBihBkTeZR6yMSF+5zg-h1U1pxGuN-nv=Y7DXLvxV435hDw@mail.gmail.com>
 <CACT4zj_84eCYOq56zdqaydaEGqyqBrXDrsTkDRyCntvVF78-0A@mail.gmail.com> <CADj_en4MTtqm0VSs2=1K5VB0fpZjga3ttMLE7RoEGQgxvQ8XFA@mail.gmail.com>
In-Reply-To: <CADj_en4MTtqm0VSs2=1K5VB0fpZjga3ttMLE7RoEGQgxvQ8XFA@mail.gmail.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Thu, 31 Aug 2023 08:19:54 +0800
Message-ID: <CACT4zj-JuKgnL9QLH_+5auhjWsiB74wMoSaetOKT7vWJvgTNLg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
To:     =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <skardach@google.com>
Cc:     Sven van Ashbrook <svenva@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        adrian.hunter@intel.com, SeanHY.chen@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, jasonlai.genesyslogic@gmail.com,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        reniuschengl@gmail.com, stable@vger.kernel.org,
        ulf.hansson@linaro.org, victor.shih@genesyslogic.com.tw,
        victorshihgli@gmail.com
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

Hi Stanis=C5=82aw,

On Wed, Aug 30, 2023 at 3:32=E2=80=AFPM Stanis=C5=82aw Kardach <skardach@go=
ogle.com> wrote:
>
> On Wed, Aug 30, 2023 at 4:27=E2=80=AFAM Ben Chuang <benchuanggli@gmail.co=
m> wrote:
> >
> > Hi,
> > On Wed, Aug 30, 2023 at 12:35=E2=80=AFAM Sven van Ashbrook <svenva@chro=
mium.org> wrote:
> > >
> > > + Rafael for advice on runtime_pm corner cases.
> > >
> > > On Mon, Aug 28, 2023 at 10:48=E2=80=AFPM Ben Chuang <benchuanggli@gma=
il.com> wrote:
> > > >
> > > >
> > > > My concern is that when runtime_pm is false, gl9763e is disabled LP=
M
> > > > negotiation, gl9763e can't enter L1.x and s0ix may fail.
> > > > It seems that runtime_pm will always exist and that's ok.
> > > >
> > >
> > > Thank you. I believe we can address your concern.
> > >
> > > - XXX_suspend/XXX_resume (i.e. classic suspend/resume) depends on
> > >   CONFIG_PM_SLEEP. This always selects CONFIG_PM. This always include=
s
> > >   the runtime_pm framework. So, if XXX_suspend/XXX_resume gets called=
,
> > >   the runtime_pm framework is always present, but may not be actively
> > >   managing the device.
> > This is ok.
> >
> > >
> > > - "when runtime_pm is false" AFAIK the only way to disable runtime_pm
> > >   when CONFIG_PM is set, is to write "on" to /sys/devices/.../power/c=
ontrol.
> > >   See https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-devi=
ces-power
> > >   In that case, the runtime_pm framework will activate the device, ca=
lling
> > >   XXX_runtime_resume() if necessary. Are there other ways of disablin=
g it?
> > >
> > > - if /sys/devices/.../power/control is "on", then:
> > >   gl9763e_runtime_resume() always called -> LPM always disabled
> > >   gl9763e_suspend() -> LPM enabled -> gl9763e_resume() -> LPM disable=
d
> > >   In between "classic" XXX_suspend and XXX_resume, LPM will be enable=
d,
> > >   so the device can enter L1.x and S0ix.
> > In this cas, after gl9763e_resume(), it is LPM disabled.
> > Is there no chance for gl9763e to enter L1.x again when the system is i=
dle?
> With runtime PM disabled via sysfs, the short answer is not since
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Df9e5b33934cec24b8c024add5c5d65d2f93ade05.
>
> The longer answer is:
> 1. System boots up with LPM flags in PCI config space in default value
> (might be LPM enabled).
> 2.1. If runtime PM is disabled before first runtime suspend -
> registers will be left in their default state.
> 2.2. If runtime PM is disabled after first runtime suspend, the device
> will be woken up and the gl9763e runtime resume callback will disable
> LPM.

OK. Thank you for your answer.

Best Regards,
Ben Chuang

> >
> > >
> > > And the LPM negotiation flags look correct.
> > > Does that address your concerns?
> >
> > Best regards,
> > Ben Chuang
>
> --
> Best Regards,
> Stanis=C5=82aw Kardach
