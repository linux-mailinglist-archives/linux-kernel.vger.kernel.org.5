Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E23578BD05
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjH2Cs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbjH2Csk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:48:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABF7B9;
        Mon, 28 Aug 2023 19:48:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3110ab7110aso3278367f8f.3;
        Mon, 28 Aug 2023 19:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693277315; x=1693882115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5U/KM6uPr54/9201v9JYDgXTLbCj0HPAtJ+9zX5H1pE=;
        b=M5C3mys2rhW4hfezIDkUlksFg2D+Nkm/MJ4d8ZQNSdmCIsnx2j0BN97ptgyFsHRiFb
         dNIvqnWeE5ayM82LQBNrCqrhFkjAEBJYJd9Zmk9JShH1nrkY4A1sU95osMzbIZXIOzPa
         g3VTQ1Ip7SPxA57Tyfh4QBM4fUJf/gIb3jTUBiPQJYJWAItIcSsFCJ1sLUGghH1zIprj
         fLwFW/HUIWNClDndQFKSyylSh+b+hEuV7FjWyvoBiiiiY/2c7bDF1QSgTtNSS2q6VRuW
         gCYH6nLpNq0oIZItqpIMe/mg/CVfpL4hLmPOfVneTi3aJjUHPlgRqh44A+/v1x3v2vJH
         GAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693277315; x=1693882115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5U/KM6uPr54/9201v9JYDgXTLbCj0HPAtJ+9zX5H1pE=;
        b=Ju3Lel5jubQfADhsgENfRKMqDJK/LV8qT4xNjywuq2uy6RPQwLTgoWI8rUjo95+ax3
         cwLDkkjDwTydHGePmNos6i2FQsXa3C4M55fczJ3OxC6sBg+lNI/08JJkt7Kh+sj0B+Ci
         yAKooEEWIUQQ13XmR0SCrEyZVtBEHuKrLqp9BowjVqQU0MB/hEViSEqWctmfkJt5NNN6
         0P2PHbQKNiTlOY5Qm4l7THx/5TC+AeKkueMZZ3wBaTk8sFnimUaBkpHCnc/XqRZRBsDp
         nKXaEMk8nFk/gSthxGJnX4lma/O2ofojOoPz86GiZAnorKugUBaCMzHkW2o46u72G7Sz
         LaOQ==
X-Gm-Message-State: AOJu0YwztTDA+7QzQyj4AtOIKLUeMKS1YzP7c3CjYvlKg698zOAkdzLZ
        hZbzsNhp56/+yDXwGHyZxm1llvdVOtz7kR4g7l4=
X-Google-Smtp-Source: AGHT+IEssPdEDJ5bk9HEtOGmoWQ40At4qkMzSz+f3wfL8+0wpLpiSq30hbQa2Ix5xXfYw0vOwhNTjuuSRNRFC4zglx4=
X-Received: by 2002:adf:fc0b:0:b0:317:69d2:35be with SMTP id
 i11-20020adffc0b000000b0031769d235bemr18772643wrr.30.1693277314960; Mon, 28
 Aug 2023 19:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <391c4270-637a-2afb-210d-6b6dfef01efa@intel.com>
 <20230828100313.3051403-1-benchuanggli@gmail.com> <CAG-rBig+koxDf3TuC-0p=tcBY_2WM1sPCvRDtjRmR7AnikrN-A@mail.gmail.com>
In-Reply-To: <CAG-rBig+koxDf3TuC-0p=tcBY_2WM1sPCvRDtjRmR7AnikrN-A@mail.gmail.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Tue, 29 Aug 2023 10:48:08 +0800
Message-ID: <CACT4zj-BaX4tHji8B8gS5jiKkd-2BcwfzHM4fS-OUn0f8DSxcw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
To:     Sven van Ashbrook <svenva@chromium.org>, skardach@google.com
Cc:     adrian.hunter@intel.com, SeanHY.chen@genesyslogic.com.tw,
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

Hi Sven and Stanis=C5=82aw,

Sorry for Stanis=C5=82aw, I have seen your reply, but I only reply to this
Regarding the location of the source codes, if the maintainers don't
comment. I'll follow them too. :)

On Tue, Aug 29, 2023 at 6:51=E2=80=AFAM Sven van Ashbrook <svenva@chromium.=
org> wrote:
>
> Hi Ben, thank you for reviewing this patch. See below.
>
> On Mon, Aug 28, 2023 at 6:03=E2=80=AFAM Ben Chuang <benchuanggli@gmail.co=
m> wrote:
> >
> > There is a situation for your reference.
> > If `allow_runtime_pm' is set to false and the system resumes from suspe=
nd, GL9763E
> > LPM negotiation will be always disabled on S0. GL9763E will stay L0 and=
 never
> > enter L1 because GL9763E LPM negotiation is disabled.
> >
> > This patch enables allow_runtime_pm. The simple flow is
> > gl9763e_suspend() -> LPM enabled -> gl9763e_resume() -> LPM disabled ->=
 (a)
> > (a) -+--> idle -->  gl9763e_runtime_suspend() -> LPM enabled
> >      |
> >      +--> no idle -> gl9763e_runtime_resume() -> LPM disabled
> >
> > This patch disables allow_runtime_pm. The simple flow is
> > gl9763e_suspend() -> LPM enabled -> gl9763e_resume() -> LPM disabled (n=
o runtime_pm)
> >
> > Although that may not be the case with the current configuration, it's =
only a
> > possibility.
> >
>
> Thanks so much for bringing this up. We have discussed internally and
> as far as we know, the current patch will work correctly in all cases.
> Could you verify our argument please?
>
> The following assumptions are key:
>
> 1. If CONFIG_PM is set, the runtime_pm framework is always present, i.e. =
there
> cannot exist a kernel which has PM but lacks runtime_pm.
> 2. The pm_runtime framework always makes sure the device is runtime
> active before
> calling XXX_suspend, waking it up if need be. So when XXX_suspend gets ca=
lled,
> the device is always runtime active.
> 3. if CONFIG_PM is set, runtime_pm can only be disabled via
> echo on > /sys/devices/.../power/control, and then the runtime_pm framewo=
rk
> always keeps the device in runtime active. In such case LPM negotiation i=
s
> always disabled.
>
> Using these assumptions, we get:
>
> Runtime_pm allowed:
> =E2=80=94------------------
> gl9763e_runtime_resume() -> LPM disabled -> gl9763e_suspend() -> LPM enab=
led
> -> gl9763e_resume() -> LPM disabled -> (a)
> (a) -+--> idle --> gl9763e_runtime_suspend() -> LPM enabled
> |
> +--> no idle -> nothing - already runtime active -> LPM disabled
>
> Runtime_pm not allowed:
> =E2=80=94----------------------
> gl9763e_runtime_resume() always called -> LPM always disabled
> gl9763e_suspend() -> LPM enabled -> gl9763e_resume() -> LPM disabled
>
> In all above cases the LPM negotiation flag is correct.
>

My concern is that when runtime_pm is false, gl9763e is disabled LPM
negotiation, gl9763e can't enter L1.x and s0ix may fail.
It seems that runtime_pm will always exist and that's ok.

> > >
> > > sdhci doesn't know anything about the bus.  It is independent
> > > of PCI, so I can't see how it would make any difference.
> > > One of the people cc'ed might know more.  Jason Lai (cc'ed)
> > > added it for runtime PM.
> > >
> >
> > As far as I know, when disabling LPM negotiation, the GL9763E will stop=
 entering
> > L1. It doesn't other side effect. Does Jason.Lai and Victor.Shih have a=
ny comments
> > or suggestions?
>
> Sounds like everyone assumes that you can freely change LPM
> negotiation on the PCIe
> bus after the cqhci_suspend() and sdhci_suspend_host() calls, so we will =
assume
> that too.

Ah, I suppose cqhci_suspend() may need to be done first safely, then
gl9763e_set_low_power_negotiation(slot, true).

Best regards,
Ben Chuang
