Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5632F7E3746
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjKGJLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbjKGJLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:11:14 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68E210D2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:10:20 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-4ac89e8e964so95937e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1699348220; x=1699953020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xulp6w5/Ri/9r9/SFm3g0afSqwuslLKNN9sBarwCc+M=;
        b=w5Xz9J/CCdvsdQSp89wd++1zXUYR8bQSlv2+zbLdC18+QOc5/TfmCfGY3tFmqWrZlm
         o61vPIWpMEbg2loSN4kbI3YwLFP4ywEcnMU8OfbZopPYEFnRPaULWQMncZAH6ogZ3EqJ
         a5ArBVg+FsQ2z97LOgttaSH8y5dEeha7sAzOB25JfTruC2XKYnCCf9uV4dnmIBXPoUJ0
         3y4eNojx6YNng489kcqzckojc/u+bOn0lrPKo7kkgiv2fvYWy++BxyZ9ORqJbZKSMzC6
         Y91LcJyOvAjxJb+BULQKoMx0uUcDEVLe9oB7jT9t6Thdoc7yp7ZD968HDcFyUL9fBLxg
         XajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348220; x=1699953020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xulp6w5/Ri/9r9/SFm3g0afSqwuslLKNN9sBarwCc+M=;
        b=dCz3lnE0bQ0gGKJcBki7irxpzEqKT6eSGPOEU/sVYksOiwQB+yVGyUM2xKWPgg3zFx
         QHcEKHZI2cpuphI9K3S3Pw1m6mCFIJ5NEen9sJpdDG0Civ1AoEsd/m7lKmqErgcQYeMD
         UURcfPj5e4hWm8Vv9L+PRO1Wi/a1bVJ0Pgzlr85JY62rfJHzHFYIrAYDsE4FI3ukxjPn
         TjhdNb+ZrkXQCZQ2xR9mcsAn8GH9GBBQl09Ca6R9nwvR3lN/wkSQdzlxrR2O6isj8Pdn
         j6MQ8VZMM1gxKvSbkwFEVRI44tIPG30F7p4RCh517U8cX5OmniXYGw9RAzYO18+mCBX+
         xC6A==
X-Gm-Message-State: AOJu0YzgDFrgA43wrK4opUctudbLsIef86mJlqF+4iFMpK1iYox1HFwj
        8siBQ0C1i/4A/I+ZSZF9caRpi0ngQ3gOTZE647Uixw==
X-Google-Smtp-Source: AGHT+IFDFaKR9NMG4dZaJMkah2C97w13KEHk1neO0arRwkZJctjZwUSTptdJ2oiPbGmmc1T2lRbCx09xouJlEYXIl8I=
X-Received: by 2002:a1f:ac95:0:b0:496:2282:5c2f with SMTP id
 v143-20020a1fac95000000b0049622825c2fmr27964014vke.6.1699348219878; Tue, 07
 Nov 2023 01:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20231107003603.20973-1-rdunlap@infradead.org>
In-Reply-To: <20231107003603.20973-1-rdunlap@infradead.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 7 Nov 2023 10:10:08 +0100
Message-ID: <CAMRc=MfECR_HDgqH3EPub=8GaV3OuHeSMnAxmuwnT=frztQPkQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: davinci: also select PINCTRL
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, patches@armlinux.org.uk,
        Russell King <linux@armlinux.org.uk>
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

On Tue, Nov 7, 2023 at 1:36=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> kconfig warns when PINCTRL_SINGLE is selected but PINCTRL is not
> set, so also set PINCTRL for ARCH_DAVINCI. This prevents a
> kconfig/build warning:
>
>    WARNING: unmet direct dependencies detected for PINCTRL_SINGLE
>      Depends on [n]: PINCTRL [=3Dn] && OF [=3Dy] && HAS_IOMEM [=3Dy]
>      Selected by [y]:
>      - ARCH_DAVINCI [=3Dy] && ARCH_MULTI_V5 [=3Dy]
>
> Fixes: f962396ce292 ("ARM: davinci: support multiplatform build for ARM v=
5")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: lore.kernel.org/r/202311070548.0f6XfBrh-lkp@intel.com
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: patches@armlinux.org.uk
> Cc: Russell King <linux@armlinux.org.uk>
> ---
> KernelVersion: 6.6
>
>  arch/arm/mach-davinci/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> diff -- a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
> --- a/arch/arm/mach-davinci/Kconfig
> +++ b/arch/arm/mach-davinci/Kconfig
> @@ -10,6 +10,7 @@ menuconfig ARCH_DAVINCI
>         select PM_GENERIC_DOMAINS_OF if PM && OF
>         select REGMAP_MMIO
>         select RESET_CONTROLLER
> +       select PINCTRL
>         select PINCTRL_SINGLE
>
>  if ARCH_DAVINCI

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
