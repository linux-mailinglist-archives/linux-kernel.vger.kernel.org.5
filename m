Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C9D7D3D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjJWRQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjJWRQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:16:47 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6E794
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:16:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bd96cfb99cso2697508b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698081405; x=1698686205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UmNA3JhvAwp9p6qqygcIMsmnra1xRqmMhLwxS7P5RI=;
        b=PgePCQ3SwGN8CUZNTlnNuf9F2Xz4N64Ih4Jc4cdXuT0GfuAnG3GXRamrVeg0kiqbpc
         EKK8DCWpQBah5lXojvxtaWEv8zWT2V8g/d2WfsWT3UeYPlwQFXftxxawVGT2RGFWgr1L
         79+eo8smXUYSvwiU1JiVeDH9GOGaIF37mhSKSPL/YRy0amSPy9PWJmkRAbT8HmPR/Mpd
         fCvuN+Q7+dtpxYiFwkdFusSNTh1Grf3hdTSccZeR4fwdS8r1ERaeKBL3M1MsPYLPzK6b
         x/LldLMB5wt4QNeZsqLqFbSrwEMgIcfm9m+re6GqMULpF/7AImYVQ5DUN06TsquBtjnc
         Gzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698081405; x=1698686205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UmNA3JhvAwp9p6qqygcIMsmnra1xRqmMhLwxS7P5RI=;
        b=ZSsFC6T6HyAr6pOSa/NE7s4+h1QaDPi3V5K1Zv4U+ljVARzH7bKieknRzne6g3i9XR
         OLXq0d4cI5OfRcxhyd3/HKuZk7mqNpe9ixwyp0/Leo+c/9qACFt0V15DaKYeTXTM6pKl
         di28BCdo2tmxBxMrUcbwwwXFqfBagRIgXRlyAAfq1pB++51x1OmFARQ/PzhCuDAkKZE1
         gsJ7IS+t3QJE/8zqOoskluGOotZfzR93PkQRaz9LjPJ8ZVUA8cEczZrsDiTbczaNuTQL
         rTLUB3vQJduCU8b4NxCIXv+pIjV94UXxxb4NTlBqJqOUo73i4GuNqPQP3xxQERu0rsQB
         VViQ==
X-Gm-Message-State: AOJu0Yw5gw+voTkj1FD7O3eLOT2EaUEthRXNTKafxo8kMClBRFVXQEkc
        XC5Jlgrg0ATCM4icvm6zOBXn6BC3v4HyEVNvP5+5WA==
X-Google-Smtp-Source: AGHT+IGjInKpQgIG1aOOsF/TPL8qt6E39iqr99A3ZlMym6netNqwXxSEhKKw32twN44OhP4SWSJB0+MDVHKQffPtg9k=
X-Received: by 2002:a05:6a20:4299:b0:15e:bcd:57f5 with SMTP id
 o25-20020a056a20429900b0015e0bcd57f5mr285107pzj.3.1698081404981; Mon, 23 Oct
 2023 10:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231023104820.849461819@linuxfoundation.org> <724521b8-9c63-4645-b3e0-30d9635573a7@linaro.org>
In-Reply-To: <724521b8-9c63-4645-b3e0-30d9635573a7@linaro.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Mon, 23 Oct 2023 11:16:33 -0600
Message-ID: <CAEUSe7-zbuRsgsr2EYq+OeW9iEJyZHmo8u9K3pDCAFRKnCEv0A@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/137] 5.15.137-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, 23 Oct 2023 at 09:11, Daniel D=C3=ADaz <daniel.diaz@linaro.org> wro=
te:
> On 23/10/23 4:55 a. m., Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.137 release.
> > There are 137 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.137-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> We see lots of errors on Arm 32-bits:
>
> -----8<-----
> /builds/linux/drivers/gpio/gpio-vf610.c:249:11: error: 'IRQCHIP_IMMUTABLE=
' undeclared here (not in a function); did you mean 'IS_IMMUTABLE'?
>    .flags =3D IRQCHIP_IMMUTABLE | IRQCHIP_MASK_ON_SUSPEND
>             ^~~~~~~~~~~~~~~~~
>             IS_IMMUTABLE
> /builds/linux/drivers/gpio/gpio-vf610.c:251:2: error: 'GPIOCHIP_IRQ_RESOU=
RCE_HELPERS' undeclared here (not in a function)
>    GPIOCHIP_IRQ_RESOURCE_HELPERS,
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /builds/linux/drivers/gpio/gpio-vf610.c:251:2: warning: excess elements i=
n struct initializer
> /builds/linux/drivers/gpio/gpio-vf610.c:251:2: note: (near initialization=
 for 'vf610_irqchip')
> /builds/linux/drivers/gpio/gpio-vf610.c: In function 'vf610_gpio_probe':
> /builds/linux/drivers/gpio/gpio-vf610.c:340:2: error: implicit declaratio=
n of function 'gpio_irq_chip_set_chip'; did you mean 'gpiochip_get_data'? [=
-Werror=3Dimplicit-function-declaration]
>    gpio_irq_chip_set_chip(girq, &vf610_irqchip);
>    ^~~~~~~~~~~~~~~~~~~~~~
>    gpiochip_get_data
> cc1: some warnings being treated as errors
> ----->8-----

Bisection points to "gpio: vf610: make irq_chip immutable" (upstream
commit e6ef4f8ede09f4af7cde000717b349b50bc62576).

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
