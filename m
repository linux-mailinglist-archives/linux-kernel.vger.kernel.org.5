Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F659803C17
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjLDRxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjLDRxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:53:12 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64463116
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:53:18 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a1a58fbe5e1so298777866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701712394; x=1702317194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5o4kl72J4dnliAxYr60gM/uEi8xxxJtEIon7STyN2k4=;
        b=Aw9rgs6wJ20EQr0cae1TXtQS5RVismJldtq1jQL/YmZyBS2pVC88F07Npc2wyxxtxC
         4OSEeW1Ov9+XkHg1+mNszJIdSu1zvD58aC/ZXoNLAD3gMBSpO/cNjUvKOPHJiJlHCIZP
         +HDC+1neJZ9dqbGWo0VMdwUODTc3cwoICpPOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701712394; x=1702317194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5o4kl72J4dnliAxYr60gM/uEi8xxxJtEIon7STyN2k4=;
        b=rQBqfDcXoGaQJWl+HjaiR3VFY3QANsswZP6OE6/sdlfeh/M0zeaVDjBSe2Fi48wEKn
         1tfy6uWy4APalh2FLmBLkKE5nVoSGC2X18bG25HB+jy0id6iSo8UNMXFvI3qgt3TqdZV
         3iI6eILRXXxSPufOiAunsI17LWD0yluGpt8teBAE4vc+pTfCZJoO4MqjSH04nKQLAkxa
         vfdBLJ6tagGEMXGmP11LcstiuX0D9oBGtEZhhFurB9sfCADQKfFB2xdjczLq2SpGwnsT
         XPhwEwh0bfGTda0MpbpCsj7KfGSmQf/G9OgThGHAMitwkbibLFNoJzPcFV1PpcPkmcd8
         EbbA==
X-Gm-Message-State: AOJu0YzFTLiipN2EejLv3XOvcBY65Q1ROkSWCXwJ1HdUj2jLxv7V3uZC
        pBmkMUBg5kabeHJamENrblRSB+pjFqclTCjJvFEUSoXW
X-Google-Smtp-Source: AGHT+IGaHzIOPSu6mnKv+x9LGAu+P7Re4ngh6zFjnLbcibfG0V0QLMUAvnfEyO+NkfKOwC8jdFsgVA==
X-Received: by 2002:a17:906:6b94:b0:a19:a19b:c743 with SMTP id l20-20020a1709066b9400b00a19a19bc743mr3279034ejr.147.1701712394078;
        Mon, 04 Dec 2023 09:53:14 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id y20-20020a17090668d400b00982a92a849asm5535400ejr.91.2023.12.04.09.53.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 09:53:12 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40b422a274dso1775e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:53:12 -0800 (PST)
X-Received: by 2002:a05:600c:4507:b0:40a:483f:f828 with SMTP id
 t7-20020a05600c450700b0040a483ff828mr458557wmo.4.1701712392461; Mon, 04 Dec
 2023 09:53:12 -0800 (PST)
MIME-Version: 1.0
References: <20231129172200.430674-1-sjg@chromium.org> <20231129172200.430674-3-sjg@chromium.org>
 <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de> <CAPnjgZ25xoXsi74XYY0E8ucQiowQqPdZgUHrfVNAYWKZEYODHg@mail.gmail.com>
 <875f0dbc-1d78-4901-91b2-6ad152bcea5a@pengutronix.de> <CAPnjgZ0UCkm5QCx+JXe1ggSshozPnOLB6cN=UoJyMn6S4wfFkg@mail.gmail.com>
 <06281f7c-e0f2-405c-95a9-0f7e9e84a7f6@pengutronix.de> <CAPnjgZ2TT+0BvbjwfnGLQ3EPEXnLW6f1epiFdaBHRYaSAn5xsA@mail.gmail.com>
 <8fbc81b1-31ab-46b0-87f4-b8bd8e8e2b47@pengutronix.de> <CAPnjgZ1iyxk0bb56QR10N5aSphRYhLsw7Ly=z2i6rQCxP_AYPw@mail.gmail.com>
 <5e8f42f8-2b03-4033-b6d2-9b3139f081d5@pengutronix.de> <CAPnjgZ2RjNzqJTRZSWvuscQhs+f8CG=fDcEO=qKXNeQLP53LnQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ2RjNzqJTRZSWvuscQhs+f8CG=fDcEO=qKXNeQLP53LnQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 4 Dec 2023 09:52:56 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WXQrbnjeVOLp--vmLzScvW9VLFRu+apSY4WnL9JFk-AQ@mail.gmail.com>
Message-ID: <CAD=FV=WXQrbnjeVOLp--vmLzScvW9VLFRu+apSY4WnL9JFk-AQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] arm64: boot: Support Flat Image Tree
To:     Simon Glass <sjg@chromium.org>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tom Rini <trini@konsulko.com>,
        lkml <linux-kernel@vger.kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Dec 2, 2023 at 8:37=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Ahmad,
>
> On Thu, 30 Nov 2023 at 19:04, Ahmad Fatoum <a.fatoum@pengutronix.de> wrot=
e:
> >
> > Hello Simon,
> >
> > On 30.11.23 21:30, Simon Glass wrote:
> > > On Wed, 29 Nov 2023 at 12:54, Ahmad Fatoum <a.fatoum@pengutronix.de> =
wrote:
> > >> On 29.11.23 20:44, Simon Glass wrote:
> > >>> On Wed, 29 Nov 2023 at 12:33, Ahmad Fatoum <a.fatoum@pengutronix.de=
> wrote:
> > >>>>
> > >>>> On 29.11.23 20:27, Simon Glass wrote:
> > >>>>> On Wed, 29 Nov 2023 at 12:15, Ahmad Fatoum <a.fatoum@pengutronix.=
de> wrote:
> > >>>>>> On 29.11.23 20:02, Simon Glass wrote:
> > >>>>>>> On Wed, 29 Nov 2023 at 11:59, Ahmad Fatoum <a.fatoum@pengutroni=
x.de> wrote:
> > >>>>>>>> The specification says that this is the root U-Boot compatible=
,
> > >>>>>>>> which I presume to mean the top-level compatible, which makes =
sense to me.
> > >>>>>>>>
> > >>>>>>>> The code here though adds all compatible strings from the devi=
ce tree though,
> > >>>>>>>> is this intended?
> > >>>>>>>
> > >>>>>>> Yes, since it saves needing to read in each DT just to get the
> > >>>>>>> compatible stringlist.
> > >>>>>>
> > >>>>>> The spec reads as if only one string (root) is supposed to be in=
 the list.
> > >>>>>> The script adds all compatibles though. This is not really usefu=
l as a bootloader
> > >>>>>> that's compatible with e.g. fsl,imx8mm would just take the first=
 device tree
> > >>>>>> with that SoC, which is most likely to be wrong. It would be bet=
ter to just
> > >>>>>> specify the top-level compatible, so the bootloader fails instea=
d of taking
> > >>>>>> the first DT it finds.
> > >>>>>
> > >>>>> We do need to have a list, since we have to support different boa=
rd revs, etc.
> > >>>>
> > >>>> Can you give me an example? The way I see it, a bootloader with
> > >>>> compatible "vendor,board" and a FIT with configuration with compat=
ibles:
> > >>>>
> > >>>>   "vendor,board-rev-a", "vendor,board"
> > >>>>   "vendor,board-rev-b", "vendor,board"
> > >>>>
> > >>>> would just result in the bootloader booting the first configuratio=
n, even if
> > >>>> the device is actually rev-b.
> > >>>
> > >>> You need to find the best match, not just any match. This is
> > >>> documented in the function comment for fit_conf_find_compat().
> > >>
> > >> In my above example, both configuration are equally good.
> > >> Can you give me an example where it makes sense to have multiple
> > >> compatibles automatically extracted from the device tree compatible?
> > >>
> > >> The way I see it having more than one compatible here just has
> > >> downsides.
> > >
> > > I don't have an example to hand, but this is the required mechanism o=
f
> > > FIT. This feature has been in place for many years and is used by
> > > ChromeOS, at least.
> >
> > I see the utility of a FIT configuration with
> >
> >     compatible =3D "vendor,board-rev-a", "vendor,board-rev-b";
> >
> > I fail to see a utility for a configuration with
> >
> >     compatible =3D "vendor,board", "vendor,SoM", "vendor,SoC";
> >
> > Any configuration that ends up being booted because "vendor,SoC" was ma=
tched is
> > most likely doomed to fail. Therefore, I would suggest that only the to=
p level
> > configuration is written into the FIT configurations automatically.
>
> Firstly, I am not an expert on this.
>
> Say you have a board with variants. The compatible string in U-Boot
> may be something like:
>
> "google,veyron-brain-rev1", "google,veyron-brain", "google,veyron",
> "rockchip,rk3288";
>
> If you then have several FIT configurations, they may be something like:
>
> "google,veyron-brain-rev0", "google,veyron-brain", "google,veyron",
> "rockchip,rk3288";
> "google,veyron-brain-rev1", "google,veyron-brain", "google,veyron",
> "rockchip,rk3288";
> "google,veyron-brain-rev2", "google,veyron-brain", "google,veyron",
> "rockchip,rk3288";
>
> You want to choose the second one, since it is a better match than the ot=
hers.
>
> +Doug Anderson who knows a lot more about this than me.

Hopefully this is all explained by:

https://docs.kernel.org/arch/arm/google/chromebook-boot-flow.html
