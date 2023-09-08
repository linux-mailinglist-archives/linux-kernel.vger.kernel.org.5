Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B45C7983BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241192AbjIHIKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240812AbjIHIKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:10:54 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B2A1BE6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 01:10:50 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d7f1bc4ece3so1637643276.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 01:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694160650; x=1694765450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LX8a9RtwGTkNLy+xzOfITbjsoPIkf7czyOLexbXeC30=;
        b=Ta0p6zxQby92DMNhDSTt1AvTBovOoRn8asPZr1gk8V+gWfRAw2lZ8kV6N2h5VheLA9
         JTwBoy+SlBso8p8yiQeZw9m8VIslhXrjcvZ5E2UZym2iFFPZRUZ19C2h6TFQcteH11vf
         tCWseemtS2uDnmZUvC5Xigx02zT3ivXvtqF0lUjngafAifpN9hdj6jNDqYqLTE2gaMBu
         iytiWf5lqdP3in57u48TCk3CgK/d/Em9rG3zXv15NAbtJ7j+4oUTFyWueOaeLjTW0u68
         rBdsg0qwP0Cvh4Mrxlp0yxGPAiscP+VSfYH4+kJmZCpGHS0cI2peLG93YXdqz4+8AHmr
         5rqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694160650; x=1694765450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LX8a9RtwGTkNLy+xzOfITbjsoPIkf7czyOLexbXeC30=;
        b=q+J5xN+rFIteAssSJ90Xl4RFK7azC89EkcT+1MmwsDbwPki6Fk6rAc9T58971Xo34a
         dhHxOUjrnaIyWrPCk2aVzLU6/NHPkdaHRZHOzMxXeHv86uP4X5mPvRwQ5PYLOf9O0xLV
         WTTDzNyplftnR+pHSNxIgzsuQbpGhNMLJDDeV4MvVuDauUxHO+IoZlqBxEE68TXH4beb
         YZgfTaDLhgomjSd3gCfh3x665q+xYJ3doCcfIYoMi1wNaa2j4RpYIT2nc6YV4NqTSL/d
         8tGqw0JiBXpcWGoViohMxa89kJ+faAcx7LFm4C+S1heO2MnlFLu10Onf245y09cFrNQ7
         VejQ==
X-Gm-Message-State: AOJu0YwNYllt89UewBIbUtN2nVBki0qyG7wAz2HRG1d16pRmu/TJoI6F
        7Gn07hGg6S53NmFPD32AyT84ZoF77ZJCiuZ9P8sAxQ==
X-Google-Smtp-Source: AGHT+IEIhWm+dbLokHs4WzlKU9nNAycGL1sYfhy4ej/rUnehmE6v6eMqoNyWh18rq8tDXFFLvVdbX78B2EnbokZq5wM=
X-Received: by 2002:a5b:c4d:0:b0:d80:14ed:d294 with SMTP id
 d13-20020a5b0c4d000000b00d8014edd294mr1579706ybr.36.1694160649746; Fri, 08
 Sep 2023 01:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <a03a6e1d-e99c-40a3-bdac-0075b5339beb@gmail.com>
In-Reply-To: <a03a6e1d-e99c-40a3-bdac-0075b5339beb@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Sep 2023 10:10:37 +0200
Message-ID: <CACRpkdahWm9aP+UasDx=s3th+vyjAfuWrKB5HS9BKEbz90ZmKw@mail.gmail.com>
Subject: Re: ARM BCM53573 SoC hangs/lockups caused by locks/clock/random changes
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        openwrt-devel@lists.openwrt.org,
        bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafal,

On Mon, Sep 4, 2023 at 10:34=E2=80=AFAM Rafa=C5=82 Mi=C5=82ecki <zajec5@gma=
il.com> wrote:

> I'm clueless at this point.
> Maybe someone can come up with an idea of actual issue & ideally a
> solution.

Damn this is frustrating.

> 2. Clock (arm,armv7-timer)
>
> While comparing main clock in Broadcom's SDK with upstream one I noticed
> a tiny difference: mask value. I don't know it it makes any sense but
> switching from CLOCKSOURCE_MASK(56) to CLOCKSOURCE_MASK(64) in
> arm_arch_timer.c (to match SDK) increases average uptime (time before a
> hang/lockup happens) from 4 minutes to 36 minutes.

This could be related to how often the system goes to idle.

> +       if (cpu_idle_force_poll =3D=3D 1234)
> +               arch_cpu_idle();
> +       if (cpu_idle_force_poll =3D=3D 5678)
> +               arch_cpu_idle();
> +       if (cpu_idle_force_poll =3D=3D 1234)
> +               arch_cpu_idle();
> +       if (cpu_idle_force_poll =3D=3D 5678)
> +               arch_cpu_idle();
> +       if (cpu_idle_force_poll =3D=3D 1234)
> +               arch_cpu_idle();
> +       if (cpu_idle_force_poll =3D=3D 5678)
> +               arch_cpu_idle();
> +       if (cpu_idle_force_poll =3D=3D 1234)
> +               arch_cpu_idle();

Idle again.

I would have tried to see what arch_cpu_idle() is doing.

arm_pm_idle() or cpu_do_idle()?

What happens if you just put return in arch_cpu_idle()
so it does nothing?

Yours,
Linus Walleij
