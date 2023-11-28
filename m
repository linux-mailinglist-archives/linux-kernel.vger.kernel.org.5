Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232BA7FAEFD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjK1A0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjK1A0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:26:22 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE8F1B1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:26:27 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231128002623epoutp01e8557e344df2551789723fb48029aa1f~bocxjptl23190531905epoutp01Q
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:26:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231128002623epoutp01e8557e344df2551789723fb48029aa1f~bocxjptl23190531905epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701131183;
        bh=EVAydPHb+iuI0oFgKT1lEvM3GpdgPhV7iSj5fS7WTjc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bYewLQmiQNvtpEScwNoYGjvs2UJGAMClVYNuGnx3ytjqKSbHgJlN13tWdQaSguUB0
         s7IPU1twvcI+rlTie+jydV1j62HMla1DcCDWCmgOh5EP527BY5U3MDG7PxjmwFmKk8
         UFc5vHRRMbE0WUDLZCqz7rhsxJyPGrFphNzDKIeE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20231128002622epcas2p43775dc1c952c850b7974c430e21b3b43~bocw8NHzj1420714207epcas2p4h;
        Tue, 28 Nov 2023 00:26:22 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.68]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SfNYB1z9Gz4x9QB; Tue, 28 Nov
        2023 00:26:22 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.C2.10006.EA335656; Tue, 28 Nov 2023 09:26:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20231128002621epcas2p4379a53cc57d9d26bce92fe0de4722982~bocv8kgXI1420814208epcas2p4r;
        Tue, 28 Nov 2023 00:26:21 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231128002621epsmtrp2d2067952c91203253bb2b1f13175bffe~bocv75cfD0710707107epsmtrp2A;
        Tue, 28 Nov 2023 00:26:21 +0000 (GMT)
X-AuditID: b6c32a45-179ff70000002716-02-656533ae0957
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.3A.07368.DA335656; Tue, 28 Nov 2023 09:26:21 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231128002621epsmtip14a29ac44b55d090894695741d02bfa17~bocvtqbao0187501875epsmtip1M;
        Tue, 28 Nov 2023 00:26:21 +0000 (GMT)
Date:   Tue, 28 Nov 2023 10:01:25 +0900
From:   Youngmin Nam <youngmin.nam@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     tomasz.figa@gmail.com, krzysztof.kozlowski@linaro.org,
        s.nawrocki@samsung.com, alim.akhtar@samsung.com,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, semen.protsenko@linaro.org
Subject: Re: [PATCH v2] pinctrl: samsung: add irq_set_affinity() for non
 wake up external gpio interrupt
Message-ID: <ZWU75VtJ/mXpMyQr@perf>
MIME-Version: 1.0
In-Reply-To: <bb738a6b-815d-4fad-b73f-559f1ba8cd68@linaro.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmhe4649RUg66fvBYP5m1js9j7eiu7
        xZQ/y5ksNj2+xmqxef4fRovLu+awWcw4v4/J4vCbdlaL531A1qpdfxgduDx2zrrL7nHn2h42
        j81L6j36tqxi9Pi8SS6ANSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8x
        N9VWycUnQNctMwfoKCWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFp
        XrpeXmqJlaGBgZEpUGFCdsaKJYsYC/aKVHza9JetgXE7fxcjB4eEgInEhtueXYxcHEICOxgl
        Lq14wQThfGKUWPnsMBuE841R4uLaB0AOJ1jH8w8fWSASexklNr5pZIRwHjJK9K2fyghSxSKg
        KnH08CRmEJtNQFdi24l/YHERAQuJxRsWsoI0MAusZpK4/fE7WEJYIEvizsZuFhCbV0BZor9j
        BpQtKHFy5hMwm1PATuL1PYhtEgKtHBKfjhxnhrjJRWLqnqVMELawxKvjW9ghbCmJz+/2Qt2d
        LbH61yWoeIVE+70eqF5jiVnP2sGOYBbIkHiyAuRSUMgoSxy5xQIR5pPoOPyXHSLMK9HRJgTR
        qSbxa8oGRghbRmL34hVQEz0knk3exA4JlOOMEr/P3GaZwCg3C8k7s5Bsg7B1JBbs/sQ2C2gF
        s4C0xPJ/HBCmpsT6XfoLGFlXMYqlFhTnpqcWGxUYwmM4OT93EyM4kWq57mCc/PaD3iFGJg7G
        Q4wSHMxKIrx6H5NThXhTEiurUovy44tKc1KLDzGaAiNnIrOUaHI+MJXnlcQbmlgamJiZGZob
        mRqYK4nz3mudmyIkkJ5YkpqdmlqQWgTTx8TBKdXAlPq/8skqi/UxScV5WSJFexPSDz5MCH7P
        23bax2k2p6nJ48QqW2El3qzz2U+3a6jOub3fgW/6FJ5FbCFfL7GIX/we2rpCNVJt2vo0yT8X
        C56fq1DvVTr4cfUJubu7L6c7hD1JvOy/MOrO5s07TZplU9JWf8+95Gewc0bOM2v2D98DK7at
        Sbixff63R6q8+6/L37Fnrurc2flTMGSvTFKmTyffH96qxp8vJ6RN/myyTkfpp8u5fQ49c2Un
        HHU051mRFtG895TC6/XnVisWrnc2brgmlbhO/vaV4uvPlHcoxfzpmKu45DLTqdN/DlxJCeNX
        yvD+e/L74ZtTV7WvX+qY5DF5v0xBauUewbytHgdbK5RYijMSDbWYi4oTAQNz9qEtBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnO5a49RUg8azqhYP5m1js9j7eiu7
        xZQ/y5ksNj2+xmqxef4fRovLu+awWcw4v4/J4vCbdlaL531A1qpdfxgduDx2zrrL7nHn2h42
        j81L6j36tqxi9Pi8SS6ANYrLJiU1J7MstUjfLoErY9e5eWwFfwUrftxQamCcwNvFyMkhIWAi
        8fzDR5YuRi4OIYHdjBKX3u1mhUjISNxeeRnKFpa433KEFaLoPqPE771TmEASLAKqEkcPT2IG
        sdkEdCW2nfjHCGKLCFhILN6wEKyBWWA1k8Tmx+/BioQFsiQePjzPBmLzCihL9HfMYAGxhQSO
        M0oceKoOEReUODnzCVicWUBL4sa/l0DLOIBsaYnl/zhAwpwCdhKv7zUyTmAUmIWkYxaSjlkI
        HQsYmVcxSqYWFOem5yYbFhjmpZbrFSfmFpfmpesl5+duYgTHgZbGDsZ78//pHWJk4mA8xCjB
        wawkwqv3MTlViDclsbIqtSg/vqg0J7X4EKM0B4uSOK/hjNkpQgLpiSWp2ampBalFMFkmDk6p
        Bqbnoe/U/jXE/3p/SrM2duMis8jvV/zYwtrlZySsiwyv2nKy86n2AalFaWLnZ8T3m26RTzj5
        2O9oO9Pxr28PZIl7ySikXah48/HRh7NpTFztuacyZl5rDbsz7RrvLdX3f/2jPROZ3J8WBlyR
        nOYzz2RJoav9j2ls7//4Pnes2qLJ8XLmQfXJHRFT3art3t2rznEPka/8euHhRbbL0759sb4X
        fXlu5K6gullVh47tmPHTto318FIRMWU9Ta8dZrXT1/ZuWcGjfZvfZe2lWf0CCqu7j/C+/Flj
        vfQ2O/OP5PY6feM5/CX3t0d52L7mij21ptH2Y7X/uUX35Ixbqq5dk5/VOVk1SWnlbWm+zZvT
        GncrsRRnJBpqMRcVJwIAkEdKm/ICAAA=
X-CMS-MailID: 20231128002621epcas2p4379a53cc57d9d26bce92fe0de4722982
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----SiQCcQFW9qxZh2i62NcUcvIKWR48NBmCWce5.T0aiy9ACrIF=_24d13_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231126091120epcas2p4a1320e3b0f9be8f8a0f575a322981d38
References: <CGME20231126091120epcas2p4a1320e3b0f9be8f8a0f575a322981d38@epcas2p4.samsung.com>
        <20231126094618.2545116-1-youngmin.nam@samsung.com>
        <bb738a6b-815d-4fad-b73f-559f1ba8cd68@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------SiQCcQFW9qxZh2i62NcUcvIKWR48NBmCWce5.T0aiy9ACrIF=_24d13_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Nov 27, 2023 at 10:54:56AM +0100, Krzysztof Kozlowski wrote:
> On 26/11/2023 10:46, Youngmin Nam wrote:
> > To support affinity setting for non wake up external gpio interrupt,
> > add irq_set_affinity callback using irq number from pinctrl driver data.
> > 
> > Before this patch, changing the irq affinity of gpio interrupt is not possible:
> > 
> >     # cat /proc/irq/418/smp_affinity
> >     3ff
> >     # echo 00f > /proc/irq/418/smp_affinity
> 
> Does this command succeed on your board?
> 
Yes.

> >     # cat /proc/irq/418/smp_affinity
> >     3ff
> >     # cat /proc/interrupts
> >                CPU0       CPU1       CPU2       CPU3    ...
> >     418:       3631          0          0          0    ...
> > 
> > With this patch applied, it's possible to change irq affinity of gpio interrupt:
> 
> ...
> 
> On which board did you test it?
> 
> 
I tested on S5E9945 ERD(Exynos Reference Development) board.

> > +	if (parent)
> > +		return parent->chip->irq_set_affinity(parent, dest, force);
> > +
> 
> I think there is a  helper for it: irq_chip_set_affinity_parent().
> 
> 

The irq_chip_set_affinity_parent() requires parent_data of irq_data.
But when I tested as below, exynos's irqd->parent_data was null.
So we should use irqchip's affinity function instead of the helper function.

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

> Best regards,
> Krzysztof
> 
> 

------SiQCcQFW9qxZh2i62NcUcvIKWR48NBmCWce5.T0aiy9ACrIF=_24d13_
Content-Type: text/plain; charset="utf-8"


------SiQCcQFW9qxZh2i62NcUcvIKWR48NBmCWce5.T0aiy9ACrIF=_24d13_--
