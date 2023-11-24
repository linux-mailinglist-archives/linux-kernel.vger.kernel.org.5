Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C859A7F6B16
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 05:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjKXEAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 23:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXEAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 23:00:08 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D4CD69
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 20:00:10 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231124040006epoutp02267120cc59188b3daa55862da4b32d12~acyPGLJjX2684426844epoutp02e
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 04:00:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231124040006epoutp02267120cc59188b3daa55862da4b32d12~acyPGLJjX2684426844epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700798406;
        bh=pf3jmVTBpWrheHXUATyPoeR56j71D8rsx0Abe4C3N7g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uT+5HS/AlgBib7WQdtcq1MlLoLNnWsk2UJOoJIDwskbn+6zgXk5ZvKiwLajFlqKxm
         aEotZTCHYlQo2ZbRosCl9ZcoDtJPxbZ40RQ54ycLOqWgk8uoBckX8RYlQPuXzD9omA
         r5yYk0h28VdbvMIhHqK4MFUKP4mPLc+Q96HrumlQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20231124040006epcas2p2ca8e46faf34401360c9e91c1be4e3254~acyOrOk9T0544105441epcas2p2z;
        Fri, 24 Nov 2023 04:00:06 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.91]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Sc1Td6Xntz4x9QM; Fri, 24 Nov
        2023 04:00:05 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.70.09607.5CF10656; Fri, 24 Nov 2023 13:00:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20231124040005epcas2p48ec804ea2b2a46a8ef7446ed2b9b1338~acyN2Ztpb0943709437epcas2p4O;
        Fri, 24 Nov 2023 04:00:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231124040005epsmtrp101af3d9615800e25a186ecc4f8a81657~acyN1q-Kg3016830168epsmtrp1N;
        Fri, 24 Nov 2023 04:00:05 +0000 (GMT)
X-AuditID: b6c32a48-bcdfd70000002587-f9-65601fc58d64
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.F8.08755.5CF10656; Fri, 24 Nov 2023 13:00:05 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231124040005epsmtip2041ad14a4aa82cfdd35cba998cb51d9f~acyNmteDu0750007500epsmtip2V;
        Fri, 24 Nov 2023 04:00:05 +0000 (GMT)
Date:   Fri, 24 Nov 2023 13:35:05 +0900
From:   Youngmin Nam <youngmin.nam@samsung.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     tomasz.figa@gmail.com, krzysztof.kozlowski@linaro.org,
        s.nawrocki@samsung.com, alim.akhtar@samsung.com,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: samsung: add irq_set_affinity() for non wake
 up external gpio interrupt
Message-ID: <ZWAn+XzseBTB+KE1@perf>
MIME-Version: 1.0
In-Reply-To: <CAPLW+4kO4wYP=5Sx7dPXU17b_CHBJKN_93GhWtZ60vKgNRTKwQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmme5R+YRUg/nnDC0ezNvGZrH39VZ2
        iyl/ljNZbHp8jdVi8/w/jBaXd81hs5hxfh+TxeE37awWz/uArFW7/jA6cHnsnHWX3ePOtT1s
        HpuX1Hv0bVnF6PF5k1wAa1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5i
        bqqtkotPgK5bZg7QUUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAvMCveLE3OLS
        vHS9vNQSK0MDAyNToMKE7IxZ3eIFK6wrfs/cxdbAuECri5GTQ0LARKJ7wSfGLkYuDiGBHYwS
        v5dfZIFwPjFK/D8xBSrzjVFiwq8+FpiWS1uOM0Mk9jJKLLveA1X1kFGi5951oCoODhYBVYlj
        HaYgDWwCuhLbTvxjBLFFBPQk1s18xQ5SzyzQyySxfmYLE0hCWCBd4uGhH2AbeAWUJeZ0vGGG
        sAUlTs58AhbnFAiUWNR2lA2kWUJgKofE90ePWSFOcpG4u7SNHcIWlnh1fAuULSXxsh8mni2x
        +tclKLtCov1eDzOEbSwx61k72HXMQEe8Wv+OFeQBCaAjjtxigQjzSXQc/ssOEeaV6GgTguhU
        k/g1ZQMjhC0jsXvxCqiJHhKPDm9gh4TJLUaJg/OeskxglJuF5J1ZSLbNAhrLLKApsX6XPkRY
        XqJ562xmiLC0xPJ/HEgqFjCyrWIUSy0ozk1PLTYqMIHHdXJ+7iZGcHLV8tjBOPvtB71DjEwc
        jIcYJTiYlUR4c//EpwrxpiRWVqUW5ccXleakFh9iNAVG00RmKdHkfGB6zyuJNzSxNDAxMzM0
        NzI1MFcS573XOjdFSCA9sSQ1OzW1ILUIpo+Jg1OqgUlWyXIvo6HrHMNv9q9Ptr+z6FnbEM+g
        X83aEdsjbGZe2L+1dSL7Cqm3kWX3Nt327I/cKP5SdOXapm8vy16kqE1fUR6SUv5W+/6S3C1r
        LrVeUPd9P5dZJ8lnceOirt/PDz4vbRA+mLYsO8X1nVxfIOc+beGJok/ev7n3c+3vP1OylFYp
        Xk/Kemcv5L9WdrecwOso503tvXmhrnnXjh203DZ37nuv9IsCOpGZfyfkcKalvvC88P3XqaPa
        5y5eyFg0e8o2e5sXRkxFNtdrOC/dDdD56xf+1s9dvFitfUth6N3ijucsn/7Pu3RgkcyUT/1Z
        cQvtFslzd8Y1LL4x/2HkyxMv7mqwhJW9KlvIztrE4aLEUpyRaKjFXFScCAB6taIqNwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSvO5R+YRUg1vPRSwezNvGZrH39VZ2
        iyl/ljNZbHp8jdVi8/w/jBaXd81hs5hxfh+TxeE37awWz/uArFW7/jA6cHnsnHWX3ePOtT1s
        HpuX1Hv0bVnF6PF5k1wAaxSXTUpqTmZZapG+XQJXRtvWyIKzFhUnNrxkb2B8qN7FyMkhIWAi
        cWnLceYuRi4OIYHdjBLdZ5czQiRkJG6vvMwKYQtL3G85wgpRdJ9RYkrTVCCHg4NFQFXiWIcp
        SA2bgK7EthP/wHpFBPQk1s18xQ5SzyzQzyTxftcHdpCEsEC6xMz3s8BsXgFliTkdb6A232KU
        ONfTygSREJQ4OfMJC4jNLKAu8WfeJWaQZcwC0hLL/3FAhOUlmrfOZgaxOQUCJRa1HWWbwCg4
        C0n3LCTdsxC6ZyHpXsDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzhutDR3MG5f
        9UHvECMTB+MhRgkOZiUR3tw/8alCvCmJlVWpRfnxRaU5qcWHGKU5WJTEecVf9KYICaQnlqRm
        p6YWpBbBZJk4OKUamNqrslTe8m3QrHdivf//40lVBu1vJiuc7b8fPcOeXtF9+MUcH6nCqZ+F
        PrtwHU8NELH8/H/9Wmbht2ePbXEunrzpU8bErjPHX7nmlk6csD9m5pHfF86yLDXTmC/vJ7Mo
        U0D6bgLvbb6csx0SFUG1DhF3khUtTYR5H/xl+JYtONH0tW/iDc3wj+z+/oJW01zmPr176nzG
        m19ZW+Lvrn/XdidfZPXMG50LfK/mf8z7GNy2+Hp6pNxaB+lnBpf2XAi5Mokrq/buYim+N8fc
        xb9eXfMoQfWCY+NXQd91wbU/3Q5au/xb7BYUkhTIpLvg8u/LmxleGKdEbA3mPztB6/3fV8Xm
        +vE5yVvXL9965LjjJWklluKMREMt5qLiRAA5AuxECgMAAA==
X-CMS-MailID: 20231124040005epcas2p48ec804ea2b2a46a8ef7446ed2b9b1338
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----SiQCcQFW9qxZh2i62NcUcvIKWR48NBmCWce5.T0aiy9ACrIF=_65ba_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231119085440epcas2p375fa3b2999e1a3ceeff9949136db7e28
References: <CGME20231119085440epcas2p375fa3b2999e1a3ceeff9949136db7e28@epcas2p3.samsung.com>
        <20231119092909.3018578-1-youngmin.nam@samsung.com>
        <CAPLW+4kO4wYP=5Sx7dPXU17b_CHBJKN_93GhWtZ60vKgNRTKwQ@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------SiQCcQFW9qxZh2i62NcUcvIKWR48NBmCWce5.T0aiy9ACrIF=_65ba_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Tue, Nov 21, 2023 at 12:33:51PM -0600, Sam Protsenko wrote:
> On Sun, Nov 19, 2023 at 2:54 AM Youngmin Nam <youngmin.nam@samsung.com> wrote:
> >
> > To support affinity setting for non wake up external gpio interrupt,
> > we add a new irq_set_affinity callback using irq number which is in pinctrl
> > driver data.
> >
> > Before applying this patch, we couldn't change irq affinity of gpio interrupt.
> > * before
> > erd9945:/proc/irq/418 # cat smp_affinity
> > 3ff
> > erd9945:/proc/irq/418 # echo 00f > smp_affinity
> > erd9945:/proc/irq/418 # cat smp_affinity
> > 3ff
> > erd9945:/proc/irq/418 # cat /proc/interrupts
> >            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7       CPU8       CPU9
> > 418:       3631          0          0          0          0          0          0          0          0          0      gpg2   0 Edge      19100000.drmdecon
> >
> > After applying this patch, we can change irq affinity of gpio interrupt as below.
> > * after
> > erd9945:/proc/irq/418 # cat smp_affinity
> > 3ff
> > erd9945:/proc/irq/418 # echo 00f > smp_affinity
> > erd9945:/proc/irq/418 # cat smp_affinity
> > 00f
> > erd9945:/proc/irq/418 # cat /proc/interrupts
> >            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7       CPU8       CPU9
> > 418:       3893        201        181        188          0          0          0          0          0          0      gpg2   0 Edge      19100000.drmdecon
> >
> 
> Suggest formatting the commit message as follows, to make it more readable:
> 
> 8<-------------------------------------------------------------------------->8
> To support affinity setting for non wake up external gpio interrupt,
> add irq_set_affinity callback using irq number from pinctrl driver
> data.
> 
> Before this patch, changing the irq affinity of gpio interrupt is not
> possible:
> 
>     # cat /proc/irq/418/smp_affinity
>     3ff
>     # echo 00f > /proc/irq/418/smp_affinity
>     # cat /proc/irq/418/smp_affinity
>     3ff
>     # cat /proc/interrupts
>                CPU0       CPU1       CPU2       CPU3    ...
>     418:       3631          0          0          0    ...
> 
> With this patch applied, it's possible to change irq affinity of gpio
> interrupt:
> 
>     # cat /proc/irq/418/smp_affinity
>     3ff
>     # echo 00f > /proc/irq/418/smp_affinity
>     # cat /proc/irq/418/smp_affinity
>     00f
>     # cat /proc/interrupts
>                CPU0       CPU1       CPU2       CPU3      ...
>     418:       3893        201        181        188      ...
> 8<-------------------------------------------------------------------------->8
> 

Thanks for your suggestion. I'll modify it.

> > Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
> > ---
> >  drivers/pinctrl/samsung/pinctrl-exynos.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
> > index 6b58ec84e34b..5d7b788282e9 100644
> > --- a/drivers/pinctrl/samsung/pinctrl-exynos.c
> > +++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
> > @@ -147,6 +147,19 @@ static int exynos_irq_set_type(struct irq_data *irqd, unsigned int type)
> >         return 0;
> >  }
> >
> > +static int exynos_irq_set_affinity(struct irq_data *irqd,
> > +                                  const struct cpumask *dest, bool force)
> > +{
> > +       struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
> > +       struct samsung_pinctrl_drv_data *d = bank->drvdata;
> > +       struct irq_data *parent = irq_get_irq_data(d->irq);
> 
> I'm probably missing something, but: why not just use "irqd" parameter
> and avoid declaring "bank" and "d"? Is "d->irq" somehow different from
> "irqd"?
> 

Yes, irqd->irq is different from d->irq as below.

[  188.230707] irqd->irq is 417
[  188.230837] d->irq is 133

We have to use d->irq(133) instead of irqd->irq(417) because d->irq has GICv3 as a IRQ chip.
To use set_affinity() call back of GICv3, d->irq is needed.

IRQ  HWIRQ  Type   Affinity    IRQ_DESC             CPU0    CPU1    CPU2    CPU3 ... Chip   Name
133    603  Level  0x3ff       0xffffff883b25d800  52260       0       0       0 ... GICv3  11030000.pinctrl
417      0  Edge   0xffffffff  0xffffff883b68a800  52259       0       0       0 ... gpg2   19100000.drmdecon

erd9945: # cat /proc/interrupts | grep gpg2
417:       9250         48         45         45 ...  gpg2   0 Edge      19100000.drmdecon

erd9945: # cat /proc/interrupts | grep 11030000
133:       9250         48         45         45 ...  GICv3 603 Level     11030000.pinctrl

> > +
> > +       if (parent)
> > +               return parent->chip->irq_set_affinity(parent, dest, force);
> > +
> 
> Why not use irq_chip_set_affinity_parent() API?
> 
> > +       return -EINVAL;
> 
> Maybe use something like this instead:
> 
>     if (!irqd->parent_data)
>             return -EINVAL;
> 
>     return irq_chip_set_affinity_parent(irqd, dest, force);
> 
> Can you please test if this code works?
> 

I tested as you suggested as below.

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index bf8dd5e3c3d2..593320b408ce 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -153,14 +153,12 @@ static int exynos_irq_set_type(struct irq_data *irqd, unsigned int type)
 static int exynos_irq_set_affinity(struct irq_data *irqd,
                                   const struct cpumask *dest, bool force)
 {
-       struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
-       struct samsung_pinctrl_drv_data *d = bank->drvdata;
-       struct irq_data *parent = irq_get_irq_data(d->irq);
-
-       if (parent)
-               return parent->chip->irq_set_affinity(parent, dest, force);
+       if (!irqd->parent_data) {
+               pr_err("irqd->parent_data is null!!\n");
+               return -EINVAL;
+       }

-       return -EINVAL;
+       return irq_chip_set_affinity_parent(irqd, dest, force);
 }

[  149.658395] irqd->parent_data is null!!

Currently, irqd->paranet_data is null.

> > +}
> > +
> >  static int exynos_irq_request_resources(struct irq_data *irqd)
> >  {
> >         struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
> > @@ -212,6 +225,7 @@ static const struct exynos_irq_chip exynos_gpio_irq_chip __initconst = {
> >                 .irq_mask = exynos_irq_mask,
> >                 .irq_ack = exynos_irq_ack,
> >                 .irq_set_type = exynos_irq_set_type,
> > +               .irq_set_affinity = exynos_irq_set_affinity,
> 
> What happens if we just assign irq_chip_set_affinity_parent() here?
> Would it work, or Exynos case is more complicated than this?
> 

Yes, I couldn't find how to use irq_chip_set_affinity_parent() directly yet.

> >                 .irq_request_resources = exynos_irq_request_resources,
> >                 .irq_release_resources = exynos_irq_release_resources,
> >         },
> > --
> > 2.39.2
> >
> 

------SiQCcQFW9qxZh2i62NcUcvIKWR48NBmCWce5.T0aiy9ACrIF=_65ba_
Content-Type: text/plain; charset="utf-8"


------SiQCcQFW9qxZh2i62NcUcvIKWR48NBmCWce5.T0aiy9ACrIF=_65ba_--
