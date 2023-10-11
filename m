Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC727C497A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344193AbjJKFyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344167AbjJKFys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:54:48 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B795F94;
        Tue, 10 Oct 2023 22:54:46 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-4527d436ddfso2473018137.1;
        Tue, 10 Oct 2023 22:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697003686; x=1697608486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiBJtKSXozbM0r46s6SPSgE4x00q8wuaRms3SXA5/DM=;
        b=GD1bzNVTm6EgK1eEEzL4tYSV0pe3Kf9MNyz/czGLnxM4im///+MEi7i/wxhxPMeyAT
         +gIyTgobrl1jukAECl1f5FSqpNMI1QLglM0jdQHnoGJzWmkX6disbSw79tZYF1pW99yB
         tcSa1VTU7Igonhn9MO1UuA4lffZu0pQjmNPP4dlHRFbbJiE7Y1Qgkmpq5aM2+qczgxXY
         FOP2IR9fQsgax03lXhjxCZha1Kb2F0I0iPBglv9TsCYfdTxeXlk4406ZecnDIaOrrUvb
         BeVBXO6nkMoAnGYX/IfLvmoxVt4ys5D7py5XR902VHExjPGEp03aLaOqVW1AdTwJudAE
         v/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697003686; x=1697608486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiBJtKSXozbM0r46s6SPSgE4x00q8wuaRms3SXA5/DM=;
        b=RCCHi3kE+0vkywnF6bPkbFOD58Yilm26yFJ8OQp9qsFBrcCwLjO2IX8aUvhrW5oUNl
         xzNLsnzWNusljoJs+36MFR5bWogum0kW4kvDIFnP88QYAFrUClaXQ1q52/bFiXy//k/L
         dMpSbyctNhz+hzpwN+H6enJSdfoHWWD5708eQv8p5KAsDwVk53nzxocZWNtm23s42UAx
         o/MoVWtDXgTaqh3TX0cJagpqULFQVXxNLZuNrUXD+Gb16/+bGShfk7JivqLpCMdc92Py
         f59SoYWQ5W4Se3vn1j4CsQ6/3nxETshdIcW96Lr62FQLS72apVXACxCprIKFs6tbGWw3
         Offw==
X-Gm-Message-State: AOJu0YyNGebjOXzQv+ugPqsu+O1hrYS+DliNAgbzH0BwsGqgr0pZ9NjS
        Xlg1BGJ1Ae5BKVCypLseQ5migzlKYIzpRZWoEeJBn5KJ1FQ=
X-Google-Smtp-Source: AGHT+IHA9B34pMhcmDUBfDewbK1peGnr0ieNQbmb7QYwL7I9suY7sO1Vkh0n8/Iorr3X+CjyMV9ta3PrINSdPOu6mrE=
X-Received: by 2002:a67:fe88:0:b0:44e:9313:b045 with SMTP id
 b8-20020a67fe88000000b0044e9313b045mr19458526vsr.7.1697003685723; Tue, 10 Oct
 2023 22:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231010151709.4104747-1-andriy.shevchenko@linux.intel.com>
 <20231010151709.4104747-3-andriy.shevchenko@linux.intel.com>
 <3e1e6acf-5862-9f35-cbe6-72bb17cf3851@nvidia.com> <147fe15c-13d3-60dc-bd49-cd0cb40126e9@nvidia.com>
In-Reply-To: <147fe15c-13d3-60dc-bd49-cd0cb40126e9@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 Oct 2023 08:54:09 +0300
Message-ID: <CAHp75VdgM0riV6Y2PHnU14ZTN_4-eiXevFhi-gsbQPwrkicArw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] hte: tegra194: don't access struct gpio_chip
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        timestamp@lists.linux.dev, linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
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

On Tue, Oct 10, 2023 at 10:31=E2=80=AFPM Dipen Patel <dipenp@nvidia.com> wr=
ote:
> On 10/10/23 9:19 AM, Dipen Patel wrote:
> > On 10/10/23 8:17 AM, Andy Shevchenko wrote:

> >> +                    hte_dev->gdev =3D
> >> +                            gpio_device_find_by_fwnode(of_fnode_handl=
e(gpio_ctrl));
>
> I think there is typo for of_fnode*. Should it be of_fwnode*?

Yep, it's a typo, can you. fix manually for the test, please?

--=20
With Best Regards,
Andy Shevchenko
