Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD197FE964
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 07:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344654AbjK3Gzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 01:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3Gzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 01:55:46 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67E91AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 22:55:47 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231130065541epoutp04a11682981492da02cda5cf684b37485d~cVDQGXd562703127031epoutp04j
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:55:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231130065541epoutp04a11682981492da02cda5cf684b37485d~cVDQGXd562703127031epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701327341;
        bh=M3WQo99x16DxEeS8ZvdjBiRfWBfFI96MpCrGA2ivIO8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YGh7T36IrKF7nyHljg331GfZ7dziZriq+0eSq4e3OZevNufjCJ0eUrgpcq34qdz1m
         zJcngzVUhk0uTBBtSGnxkMWMFbwgpYEBZxnzcwirX9PeN9vdyCV5c6HTohIhCoOmik
         UCmdIrqdvV6JkN8QTulm0LLPoZQa28vYtvtEwSqQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231130065540epcas2p12b9245d20693a8696c738df3b1839873~cVDO_dT2s1368613686epcas2p1c;
        Thu, 30 Nov 2023 06:55:40 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.99]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Sgn5R6pjMz4x9QK; Thu, 30 Nov
        2023 06:55:39 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.DE.10006.BE138656; Thu, 30 Nov 2023 15:55:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231130065539epcas2p2b3a7a9a83eed1b37bea7e4bae101287e~cVDOE_zSl0407704077epcas2p2H;
        Thu, 30 Nov 2023 06:55:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231130065539epsmtrp2d57f31985f2487fbb836776a58151707~cVDOEYbyE1048910489epsmtrp2H;
        Thu, 30 Nov 2023 06:55:39 +0000 (GMT)
X-AuditID: b6c32a45-179ff70000002716-ca-656831ebedb9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.E5.08755.BE138656; Thu, 30 Nov 2023 15:55:39 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231130065539epsmtip2f983996f97b3f4870fb03788ce67539e~cVDN1B6Mm1544015440epsmtip2n;
        Thu, 30 Nov 2023 06:55:39 +0000 (GMT)
Date:   Thu, 30 Nov 2023 16:30:45 +0900
From:   Youngmin Nam <youngmin.nam@samsung.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     tomasz.figa@gmail.com, krzysztof.kozlowski@linaro.org,
        s.nawrocki@samsung.com, alim.akhtar@samsung.com,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pinctrl: samsung: add irq_set_affinity() for non
 wake up external gpio interrupt
Message-ID: <ZWg5/rorgfSM/5UO@perf>
MIME-Version: 1.0
In-Reply-To: <CAPLW+4=QQR_u0Fi2L0orQFTd-_UpYZAQ94Je772Vs-2WKZGuiA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmqe5rw4xUg0lNxhYP5m1js9j7eiu7
        xZQ/y5ksNj2+xmqxef4fRovLu+awWcw4v4/J4vCbdlaL531A1qpdfxgduDx2zrrL7nHn2h42
        j81L6j36tqxi9Pi8SS6ANSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8x
        N9VWycUnQNctMwfoKCWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFp
        XrpeXmqJlaGBgZEpUGFCdsbWTUdZCxZqVPR/SW1gbJTpYuTkkBAwkZjX9pC5i5GLQ0hgB6PE
        zhl/WSGcT4wSH/vOQmW+MUqc77nNCNPy8eE3JojEXkaJJ9/fsoIkhAQeMkrcag3sYuTgYBFQ
        ldi1VRwkzCagK7HtxD+wXhEBPYl1M1+xg/QyC/QySayf2cIEkhAWyJK4s7GbBcTmFVCW+Pbi
        JROELShxcuYTFpCZnAKBEr2/w0F6JQSmckhs+faIFeIgF4nDLXuhjhOWeHV8CzuELSXx+d1e
        Ngg7W2L1r0tQ8QqJ9ns9zBC2scSsZ+1gvcwCGRJNW7cxg+ySALrhyC0WiDCfRMfhv+wQYV6J
        jjYhiE41iV9TNkBtlZHYvXgF1EQPiWeTN7FDgmc3s8SX5rlsExjlZiH5ZhaSbbOAxjILaEqs
        36UPEZaXaN46GyosLbH8HweSigWMbKsYxVILinPTU4uNCgzhMZ2cn7uJEZxYtVx3ME5++0Hv
        ECMTB+MhRgkOZiUR3utP01OFeFMSK6tSi/Lji0pzUosPMZoCY2kis5Rocj4wteeVxBuaWBqY
        mJkZmhuZGpgrifPea52bIiSQnliSmp2aWpBaBNPHxMEp1cDk3rQw8JJ5m64644Qkx2fHl197
        zXc0fM2tLJGj35IviCbPFu9VPGsjYznlylX/oMzZzL8y45at5Pt2btNSwdd68qUek7Zn1U7p
        23XM+2DmqScPGs4ozxW9stQzduXuI6nLw9pfpJSv15t6wivYcYvl4lbhtWrnGk51pj0Mi79i
        eVzVfc2Ot1scS2ZvyAnJEOm4kpIUe7rO26i68n9tp2mdQbK5dtun3d0PIrmZemd/D+t0mK4k
        XzG3PrfqZKZZ05ONYW/yys9M/SuttnLin5Ztdk3SWjfW+QTFrdr1RDXwefcKwSK5b59mn/NJ
        ev3Q6/4ChkVLSt7niUw6o+38VarGzIet0Er++tmG5p4n4i5KLMUZiYZazEXFiQCjcUTuNQQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSvO5rw4xUg8XfhS0ezNvGZrH39VZ2
        iyl/ljNZbHp8jdVi8/w/jBaXd81hs5hxfh+TxeE37awWz/uArFW7/jA6cHnsnHWX3ePOtT1s
        HpuX1Hv0bVnF6PF5k1wAaxSXTUpqTmZZapG+XQJXRvfZ7ILDqhWP3y5ib2DcL9nFyMkhIWAi
        8fHhN6YuRi4OIYHdjBKnlt5mh0jISNxeeZkVwhaWuN9yhBWi6D6jxLKFU4EcDg4WAVWJXVvF
        QWrYBHQltp34xwhiiwjoSayb+YodpJ5ZoJ9J4v2uD2BDhQWyJB4+PM8GYvMKKEt8e/GSCcQW
        EtjLLLHsuyJEXFDi5MwnLCA2s4C6xJ95l5hBdjELSEss/8cBEZaXaN46GyzMKRAo0fs7fAKj
        4CwkzbOQNM9CaJ6FpHkBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgmNHS3MG4
        fdUHvUOMTByMhxglOJiVRHivP01PFeJNSaysSi3Kjy8qzUktPsQozcGiJM4r/qI3RUggPbEk
        NTs1tSC1CCbLxMEp1cCkvnru8WtLyq137U1d/sH7DZdIXM61hM5WgUWJEddef+vSO/7tZuCz
        fyc+TLj2J2ztXbdS/S7/T4bOYdrPWa57Vm01kvs373bb2vDYdWXWDHdu3PRmPZqoPX1+XIog
        20zrgGfr7196ytBy9ALni/RG5xkXdSZvSNKqPVlrfto27sfMaxMbf1i+38d4rS7oEFNPnOf/
        zqo/ldfcpOrtrnm3a205EmA0a0Xte0umrg+3JUy0zNMeuX+6ddL0hKCJcFdhfVxq2tVzvhO+
        Hfg/7+GMCAeP6DUixtc4l4YwmWZlTTt1ftvxZWstWFfnzSrYcjbx1Jnf+VKn0v+VOBrr1Vyx
        U5jlXVr7WpJv20sT6ZMMSizFGYmGWsxFxYkAk4ubjQgDAAA=
X-CMS-MailID: 20231130065539epcas2p2b3a7a9a83eed1b37bea7e4bae101287e
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----beKDcrNeaD4oBIFRuchmvdVAwfnDGI5TYPt7fforSuRq9wgD=_42057_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231126091120epcas2p4a1320e3b0f9be8f8a0f575a322981d38
References: <CGME20231126091120epcas2p4a1320e3b0f9be8f8a0f575a322981d38@epcas2p4.samsung.com>
        <20231126094618.2545116-1-youngmin.nam@samsung.com>
        <bb738a6b-815d-4fad-b73f-559f1ba8cd68@linaro.org> <ZWU75VtJ/mXpMyQr@perf>
        <1fd55b36-0837-4bf7-9fde-e573d6cb214a@linaro.org>
        <CAPLW+4n0SAOTb6wocY-WjkxgSFMbx+nVuqdaPcNYVDsbfg+EfA@mail.gmail.com>
        <ZWbjPIydJRrPnuDy@perf>
        <CAPLW+4=QQR_u0Fi2L0orQFTd-_UpYZAQ94Je772Vs-2WKZGuiA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------beKDcrNeaD4oBIFRuchmvdVAwfnDGI5TYPt7fforSuRq9wgD=_42057_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Wed, Nov 29, 2023 at 12:48:56PM -0600, Sam Protsenko wrote:
> On Wed, Nov 29, 2023 at 12:32 AM Youngmin Nam <youngmin.nam@samsung.com> wrote:
> > > I tried to test this patch on E850-96, and an attempt to write into
> > > smp_affinity (for some GPIO irq) also fails for me:
> > >
> > >     # echo f0 > smp_affinity
> > >     -bash: echo: write error: Input/output error
> > >
> > > When I add some pr_err() to exynos_irq_set_affinity(), I can't see
> > > those printed in dmesg. So I guess exynos_irq_set_affinity() doesn't
> > > get called at all. So the error probably happens before
> > > .irq_set_affinity callback gets called.
> > >
> > > Youngmin, can you please try and test this patch on E850-96? This
> > > board is already supported in upstream kernel. For example you can use
> > > "Volume Up" interrupt for the test, which is GPIO irq.
> > >
> >
> > I intened this affinity setting would work only on *Non* Wakeup External Interrupt.
> > The "Volume Up" on E850-96 board is connected with "gpa0-7" and
> > that is Wakeup External interrupt so that we can't test the callback.
> >
> 
> Oh no. It was really silly mistake on my part :) But please check my
> answer below for good news.
> 
> > I couldn't find out a pin for the test on E850-96 board yet.
> > We can test if there is a usage of *Non" Wake up External Interrupt of GPIO
> > on E850-96 board.
> >
> > Do you have any idea ?
> >
> 
> Yep, just managed to successfully test your patch on E850-96. My
> testing procedure below might appear messy, but I didn't want to do
> any extra soldering :)
> 
> Used GPG1[0] pin for testing. As you can see from schematics [1],
> GPG1[0] is connected to R196 resistor (which is not installed on the
> board).
> 
> I've modified E850-96 dts file like this:
> 
> 8<---------------------------------------------------------------------------->8
>         gpio-keys {
>                 compatible = "gpio-keys";
>                 pinctrl-names = "default";
> -               pinctrl-0 = <&key_voldown_pins &key_volup_pins>;
> +               pinctrl-0 = <&key_voldown_pins &key_volup_pins &key_test_pins>;
> 
>                 ...
> 
> +               test-key {
> +                       label = "Test Key";
> +                       linux,code = <KEY_RIGHTCTRL>;
> +                       gpios = <&gpg1 0 GPIO_ACTIVE_LOW>;
> +               };
>         };
> 
> ...
> 
> +&pinctrl_peri {
> +       key_test_pins: key-test-pins {
> +               samsung,pins = "gpg1-0";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +       };
> +};
> 8<---------------------------------------------------------------------------->8
> 
> It appeared in /proc/interrupts as follows:
> 
>     87:          2          0          0          0          0
>  0          0          0      gpg1   0 Edge      Test Key
> 
> Then I touched R196 resistor pads with my finger (emulating key press)
> and looked again at /proc/interrupts:
> 
>     87:        444          0          0          0          0
>  0          0          0      gpg1   0 Edge      Test Key
> 
> Then I reconfigured smp_affinity like so:
> 
>     # cat /proc/irq/87/smp_affinity
>     ff
>     # echo f0 > /proc/irq/87/smp_affinity
>     # cat /proc/irq/87/smp_affinity
>     f0
> 
> Then I messed with R196 resistor pads with my finger again, and
> re-checked /proc/interrupts:
> 
>                CPU0       CPU1       CPU2       CPU3       CPU4
> CPU5       CPU6       CPU7
>      87:        444          0          0          0        234
>   0          0          0      gpg1   0 Edge      Test Key
> 
> And without this patch that procedure above of course doesn't work.
> 
> So as far as I'm concerned, feel free to add:
> 
> Tested-by: Sam Protsenko <semen.protsenko@linaro.org>
> 
> [1] https://protect2.fireeye.com/v1/url?k=d3eebafe-8c7293d4-d3ef31b1-000babe598f7-06c0db00473e1bca&q=1&e=855a917d-d0f9-49cd-8e05-7cccf44d06a8&u=https%3A%2F%2Fwww.96boards.org%2Fdocumentation%2Fconsumer%2Fe850-96b%2Fhardware-docs%2Ffiles%2Fe850-96b-schematics.pdf
> 
> Thanks!
> 
Thanks for your test Sam. It's really great work.
I confirmed the patch did work by following your test sequence as below.

* Before
     CPU0       CPU1       CPU2       CPU3       CPU4 ...
87:    40          0          0          0          0 ... gpg1   0 Edge   Test Key

* After
87:    40          0          0          0         22 ... gpg1   0 Edge   Test Key

Krzysztof,
Sam and I tested this patch on e850-95 board.
Let me update commit message with test result and will update patchset.

Thanks.

------beKDcrNeaD4oBIFRuchmvdVAwfnDGI5TYPt7fforSuRq9wgD=_42057_
Content-Type: text/plain; charset="utf-8"


------beKDcrNeaD4oBIFRuchmvdVAwfnDGI5TYPt7fforSuRq9wgD=_42057_--
