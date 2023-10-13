Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817CF7C8430
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjJMLQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjJMLQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:16:10 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCCBD7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:16:07 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5794C3F722
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 11:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697195765;
        bh=YtqXYMDeVBp0iq45r4Ku35W5aryODZRVP0gBJg/Jrhg=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=hM1QRtzpQVIYyKR60YLr9yb6oJVDOGPKX7Of1XvjakQYGUGuc6dPaR53fqzjUr0qO
         QmoJZmOlFXlPAi0o3o9kHoGN8LhT4dtYHhvkRHk1Lona3zBbN0tLRI7/GUSfGGWG2Y
         3lbrjzVwznrzmAUszanXej/rfmg5Cf6XK2KlNo0kbv2id8IcHIC7AUN412iPMQxFKF
         AQFsyKmFnuPJTL6SB9EOAFZoGFzVeWR+9JugyVkCBwJGf1CJgDnL92wSP1B8cSv0sS
         nhtCTrFoTtnhqNxCfXqiYD8KjAZi33enLkOFqrliys3vUSpGNVH3EPT8jaKgrFryw7
         xxmgZMVj/OfTw==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41b19dc9ee4so18538471cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697195764; x=1697800564;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YtqXYMDeVBp0iq45r4Ku35W5aryODZRVP0gBJg/Jrhg=;
        b=QVl0Tu+ynaYpjbmVrLfE9dvouBFClwRh6KHoNrzelwypYT/p5uk63EKrkBiVMQ6DPy
         yr220AaYzvBoqfnP/XbGnDpgsblh5Zh9jcTz7cbrMu2Bawm+WT5oSGtxpPoXj/Yl+8xX
         99dldmSlD0MTfu102CtU2f5KKqE7E2eq7AQyeib/9fhg9KCjd3t8DuLDlLNAOSRdBziw
         9UuVm1jtrXfbSWKfXu2lB1voM/oIRm669Ws+wF/dLa32mTH/2jV83wtRJ+gfOBydmz9T
         xy0IcokLsfDIb6LggjK5V/jOZ2BnNxyqAYqCA/mLN7nx67Y7Qd1RRmlg2cLKhP7mvLgG
         JCQQ==
X-Gm-Message-State: AOJu0YwDaoqreczO/9BbVg/TUEp77vJ3PepPb9JlvUZgrDzyJn4j7s6j
        uwL4qZWRKGBkELnRLBRvWA/7EFCvS8zIoyKHJc+Eri2gV+A1F7363Ujh0QHuR6qNE+J7l7cMOCN
        SoneI1foa72zvC5ufKTlfpS4lePS0UyUGSvXkTxWvtNcUHg3w90hPHhuzcA==
X-Received: by 2002:a05:622a:190a:b0:418:c70:113e with SMTP id w10-20020a05622a190a00b004180c70113emr29420337qtc.40.1697195764220;
        Fri, 13 Oct 2023 04:16:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqa6O42MZPuRQEylkmYqh/sPI6dX2Nr8H6zR/JgoLbM1SlKfTaPLKB6Fy+0N0lhpS63jYsCX2I1+w+84+R8Ik=
X-Received: by 2002:a05:622a:190a:b0:418:c70:113e with SMTP id
 w10-20020a05622a190a00b004180c70113emr29420316qtc.40.1697195763893; Fri, 13
 Oct 2023 04:16:03 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Oct 2023 04:16:03 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <926ee8c7-fab9-49d5-831e-48c886c4bc44@starfivetech.com>
References: <20231012081015.33121-1-xingyu.wu@starfivetech.com>
 <20231012081015.33121-3-xingyu.wu@starfivetech.com> <338544e7-0be8-47c1-a7d7-89990da305d3@wanadoo.fr>
 <926ee8c7-fab9-49d5-831e-48c886c4bc44@starfivetech.com>
Mime-Version: 1.0
Date:   Fri, 13 Oct 2023 04:16:02 -0700
Message-ID: <CAJM55Z-hsebX9e3+MNc0GcXO=ao7OB=EYWXp865VQg3L3gyPJw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] clocksource: Add JH7110 timer driver
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     aou@eecs.berkeley.edu, conor@kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, p.zabel@pengutronix.de,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        samin.guo@starfivetech.com, tglx@linutronix.de,
        walker.chen@starfivetech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xingyu Wu wrote:
> On 2023/10/13 1:53, Christophe JAILLET wrote:
> > Le 12/10/2023 =C3=A0 10:10, Xingyu Wu a =C3=A9crit=C2=A0:
> >> Add timer driver for the StarFive JH7110 SoC.
> >>
> >> Signed-off-by: Xingyu Wu <xingyu.wu-bONrM45KWFOXmMXjJBpWqg@public.gman=
e.org>
> >
> > ...
>
> It looks normal in my email and the web. Is this due to some settings?
>
> >
> >> +static int jh7110_timer_probe(struct platform_device *pdev)
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 struct jh7110_clkevt *clkevt[JH7110_TIMER_CH_MAX];
> >> +=C2=A0=C2=A0=C2=A0 char name[4];
> >> +=C2=A0=C2=A0=C2=A0 struct clk *pclk;
> >> +=C2=A0=C2=A0=C2=A0 struct reset_control *rst;
> >> +=C2=A0=C2=A0=C2=A0 int ch;
> >> +=C2=A0=C2=A0=C2=A0 int ret;
> >> +=C2=A0=C2=A0=C2=A0 void __iomem *base;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 base =3D devm_platform_ioremap_resource(pdev, 0);
> >> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(base))
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev_err_probe(&pdev=
->dev, PTR_ERR(base),
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "failed to map register=
s\n");
> >> +
> >> +=C2=A0=C2=A0=C2=A0 rst =3D devm_reset_control_get_exclusive(&pdev->de=
v, "apb");
> >> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(rst))
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev_err_probe(&pdev=
->dev, PTR_ERR(rst), "failed to get apb reset\n");
> >> +
> >> +=C2=A0=C2=A0=C2=A0 pclk =3D devm_clk_get_enabled(&pdev->dev, "apb");
> >> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(pclk))
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev_err_probe(&pdev=
->dev, PTR_ERR(pclk),
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get & enable=
 apb clock\n");
> >> +
> >> +=C2=A0=C2=A0=C2=A0 ret =3D reset_control_deassert(rst);
> >> +=C2=A0=C2=A0=C2=A0 if (ret)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev_err_probe(&pdev=
->dev, ret, "failed to deassert apb reset\n");
> >
> > Hi,
> >
> > I'm not very familiar with the reset_control_[de]assert() functions, bu=
t shouldn't this be undone by a reset_control_assert() call if an error occ=
urs later?
>
> In this case, the reset controller is set from 'assert' state to 'deasser=
t' state. If it is failed and still 'assert' state, I don't think it need t=
o call reset_control_assert().

The problem is if the assert succeeds, but the probe function fails later. =
Then
there is nothing to undo the deassert. A common pattern I see is something =
like
this:

static void jh7110_timer_reset_control_assert(void *data)
{
	reset_control_assert(data);
}

...

	ret =3D reset_control_deassert(rst);
	if (ret)
		return dev_err_probe(...);

	ret =3D devm_add_action_or_reset(&pdev->dev,
jh7110_timer_reset_control_assert, rst);
	if (ret)
		return ret;

/Emil

> >
> >> +
> >> +=C2=A0=C2=A0=C2=A0 for (ch =3D 0; ch < JH7110_TIMER_CH_MAX; ch++) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkevt[ch] =3D devm_kzallo=
c(&pdev->dev, sizeof(*clkevt[ch]), GFP_KERNEL);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!clkevt[ch])
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -ENOMEM;
> >> +
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snprintf(name, sizeof(name=
), "ch%d", ch);
> >> +
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkevt[ch]->base =3D base =
+ JH7110_TIMER_CH_BASE(ch);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Ensure timer is disable=
d */
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 jh7110_timer_disable(clkev=
t[ch]);
> >> +
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rst =3D devm_reset_control=
_get_exclusive(&pdev->dev, name);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(rst))
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn PTR_ERR(rst);
> >> +
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkevt[ch]->clk =3D devm_c=
lk_get_enabled(&pdev->dev, name);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(clkevt[ch]->clk=
))
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn PTR_ERR(clkevt[ch]->clk);
> >> +
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D reset_control_deas=
sert(rst);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn ret;
> >
> > Same here.
> >
> >> +
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkevt[ch]->evt.irq =3D pl=
atform_get_irq(pdev, ch);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (clkevt[ch]->evt.irq < =
0)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn clkevt[ch]->evt.irq;
> >> +
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snprintf(clkevt[ch]->name,=
 sizeof(clkevt[ch]->name), "%s.ch%d", pdev->name, ch);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 jh7110_clockevents_registe=
r(clkevt[ch]);
> >> +
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D devm_request_irq(&=
pdev->dev, clkevt[ch]->evt.irq, jh7110_timer_interrupt,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_TIMER =
| IRQF_IRQPOLL,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkevt[ch]-=
>name, &clkevt[ch]->evt);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn ret;
> >> +
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D jh7110_clocksource=
_init(clkevt[ch]);
> >
> > Does something should be done if this fails?
> >
> > CJ
>
> Yes, it should be call reset_control_assert() here and I will add it in n=
ext version.
>
> >
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn ret;
> >> +=C2=A0=C2=A0=C2=A0 }
> >> +
> >> +=C2=A0=C2=A0=C2=A0 return 0;
> >> +}
> >> +
> >> +static const struct of_device_id jh7110_timer_match[] =3D {
> >> +=C2=A0=C2=A0=C2=A0 { .compatible =3D "starfive,jh7110-timer", },
> >> +=C2=A0=C2=A0=C2=A0 { /* sentinel */ }
> >> +};
> >> +MODULE_DEVICE_TABLE(of, jh7110_timer_match);
> >> +
> >> +static struct platform_driver jh7110_timer_driver =3D {
> >> +=C2=A0=C2=A0=C2=A0 .probe =3D jh7110_timer_probe,
> >> +=C2=A0=C2=A0=C2=A0 .driver =3D {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "jh7110-timer",
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .of_match_table =3D jh7110=
_timer_match,
> >> +=C2=A0=C2=A0=C2=A0 },
> >> +};
> >> +module_platform_driver(jh7110_timer_driver);
> >> +
> >> +MODULE_AUTHOR("Xingyu Wu <xingyu.wu-bONrM45KWFOXmMXjJBpWqg@public.gma=
ne.org>");
> >> +MODULE_DESCRIPTION("StarFive JH7110 timer driver");
> >> +MODULE_LICENSE("GPL");
> >
>
> Thanks,
> Xingyu Wu
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
