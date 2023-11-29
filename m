Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA61D7FDFAB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjK2StE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2StC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:49:02 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B91F133
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:49:08 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d01c45ffebso881075ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701283747; x=1701888547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmmJDjXSHVVtM0uWk3D52kGsoBdId2LUYqixFeAViCk=;
        b=wSv3oYCKGhvi4kf8tvjLYp4FwzOdWFcWKV6trHgVgYjQ01geGO/7bQMbtnPZTMUF3E
         9+sEmGiBGLD5FamHR0B1IEiP1cPG34FDKRXuh0q4q2U1L+VaBDym3o5K0fbM6djSkEPA
         bX45eFK7YXCmrIaDPI0OPvgkC4b6JhpRdC8Xm0jMML8A7XELkAC7NFrw1rPrY1NYSaOK
         ApiW2eQ0kXomzZPZ6f2IHCgXmNz6LhEDMEJi3Afdsd2noVZYVp45E5DW5E03ggy9E0My
         YAXrwTnKELSHMzfRjyLLl1XSLxOz6199if3cxq8YWehobYzoRyxXxK46PTFz5eOOsUHS
         dYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701283747; x=1701888547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmmJDjXSHVVtM0uWk3D52kGsoBdId2LUYqixFeAViCk=;
        b=AxDGLY9G/Spo1Pz8j2NozHyUcZIFD5obgHRRMQ8T+4vcxR+TGRDw0wEY7w6Oq1eo8N
         X32hdEbCqG2NhJtNKzBY18deLauyNbgW+8t7tXI1dMT86EBVADHLXehCxvgcDnHLjMyS
         uyd8NzU/z8p9yaGewvTj4UOZRRhoesAASQT/YMlHgbLkjQ7Jr3/izatv4TwsX0pdShII
         geU+GReOwoTaOoCip4KgMQjwtZyhA/MMs+T/ehZN6Qdfpayztk5r0/zZpAtHMdqe0T70
         CRj5kfnRjyZZlhrQZJ+/oztIUa3WPJTPnUNYSBDZ+5vhJA2f77dhZlUSeaTj063OPqVg
         fFWA==
X-Gm-Message-State: AOJu0Ywb0ArxoniqDXlv26qrJndOYcEb3FLM3eG4kZharCCRxotdAY2o
        k29oSSU9hF/snHUlmkgKIaAnBhCMEymdCL44pIzxOg==
X-Google-Smtp-Source: AGHT+IH42YLg3I/LNrrXhhzS7bJ0UN+7Cm1cww+4mOEg05pxaNPpggy5c3QxpYyxNjwWapMrvZH8ZkHS1F+kItdM/OU=
X-Received: by 2002:a17:903:183:b0:1cc:449b:689e with SMTP id
 z3-20020a170903018300b001cc449b689emr26526735plg.20.1701283747581; Wed, 29
 Nov 2023 10:49:07 -0800 (PST)
MIME-Version: 1.0
References: <CGME20231126091120epcas2p4a1320e3b0f9be8f8a0f575a322981d38@epcas2p4.samsung.com>
 <20231126094618.2545116-1-youngmin.nam@samsung.com> <bb738a6b-815d-4fad-b73f-559f1ba8cd68@linaro.org>
 <ZWU75VtJ/mXpMyQr@perf> <1fd55b36-0837-4bf7-9fde-e573d6cb214a@linaro.org>
 <CAPLW+4n0SAOTb6wocY-WjkxgSFMbx+nVuqdaPcNYVDsbfg+EfA@mail.gmail.com> <ZWbjPIydJRrPnuDy@perf>
In-Reply-To: <ZWbjPIydJRrPnuDy@perf>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 29 Nov 2023 12:48:56 -0600
Message-ID: <CAPLW+4=QQR_u0Fi2L0orQFTd-_UpYZAQ94Je772Vs-2WKZGuiA@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: samsung: add irq_set_affinity() for non wake
 up external gpio interrupt
To:     Youngmin Nam <youngmin.nam@samsung.com>,
        krzysztof.kozlowski@linaro.org
Cc:     tomasz.figa@gmail.com, s.nawrocki@samsung.com,
        alim.akhtar@samsung.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 12:32=E2=80=AFAM Youngmin Nam <youngmin.nam@samsung=
.com> wrote:
> > I tried to test this patch on E850-96, and an attempt to write into
> > smp_affinity (for some GPIO irq) also fails for me:
> >
> >     # echo f0 > smp_affinity
> >     -bash: echo: write error: Input/output error
> >
> > When I add some pr_err() to exynos_irq_set_affinity(), I can't see
> > those printed in dmesg. So I guess exynos_irq_set_affinity() doesn't
> > get called at all. So the error probably happens before
> > .irq_set_affinity callback gets called.
> >
> > Youngmin, can you please try and test this patch on E850-96? This
> > board is already supported in upstream kernel. For example you can use
> > "Volume Up" interrupt for the test, which is GPIO irq.
> >
>
> I intened this affinity setting would work only on *Non* Wakeup External =
Interrupt.
> The "Volume Up" on E850-96 board is connected with "gpa0-7" and
> that is Wakeup External interrupt so that we can't test the callback.
>

Oh no. It was really silly mistake on my part :) But please check my
answer below for good news.

> I couldn't find out a pin for the test on E850-96 board yet.
> We can test if there is a usage of *Non" Wake up External Interrupt of GP=
IO
> on E850-96 board.
>
> Do you have any idea ?
>

Yep, just managed to successfully test your patch on E850-96. My
testing procedure below might appear messy, but I didn't want to do
any extra soldering :)

Used GPG1[0] pin for testing. As you can see from schematics [1],
GPG1[0] is connected to R196 resistor (which is not installed on the
board).

I've modified E850-96 dts file like this:

8<-------------------------------------------------------------------------=
--->8
        gpio-keys {
                compatible =3D "gpio-keys";
                pinctrl-names =3D "default";
-               pinctrl-0 =3D <&key_voldown_pins &key_volup_pins>;
+               pinctrl-0 =3D <&key_voldown_pins &key_volup_pins &key_test_=
pins>;

                ...

+               test-key {
+                       label =3D "Test Key";
+                       linux,code =3D <KEY_RIGHTCTRL>;
+                       gpios =3D <&gpg1 0 GPIO_ACTIVE_LOW>;
+               };
        };

...

+&pinctrl_peri {
+       key_test_pins: key-test-pins {
+               samsung,pins =3D "gpg1-0";
+               samsung,pin-function =3D <EXYNOS_PIN_FUNC_EINT>;
+               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
+               samsung,pin-drv =3D <EXYNOS5420_PIN_DRV_LV1>;
+       };
+};
8<-------------------------------------------------------------------------=
--->8

It appeared in /proc/interrupts as follows:

    87:          2          0          0          0          0
 0          0          0      gpg1   0 Edge      Test Key

Then I touched R196 resistor pads with my finger (emulating key press)
and looked again at /proc/interrupts:

    87:        444          0          0          0          0
 0          0          0      gpg1   0 Edge      Test Key

Then I reconfigured smp_affinity like so:

    # cat /proc/irq/87/smp_affinity
    ff
    # echo f0 > /proc/irq/87/smp_affinity
    # cat /proc/irq/87/smp_affinity
    f0

Then I messed with R196 resistor pads with my finger again, and
re-checked /proc/interrupts:

               CPU0       CPU1       CPU2       CPU3       CPU4
CPU5       CPU6       CPU7
     87:        444          0          0          0        234
  0          0          0      gpg1   0 Edge      Test Key

And without this patch that procedure above of course doesn't work.

So as far as I'm concerned, feel free to add:

Tested-by: Sam Protsenko <semen.protsenko@linaro.org>

[1] https://www.96boards.org/documentation/consumer/e850-96b/hardware-docs/=
files/e850-96b-schematics.pdf

Thanks!
