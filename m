Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C1C7BC426
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 04:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbjJGCPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 22:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbjJGCPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 22:15:01 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910991A8
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 19:14:34 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-584a761b301so2043529a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 19:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696644873; x=1697249673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mpftVBDmZlVrcM4E1/xk2GP1ZYmd4Pa5biiRHrPKWo=;
        b=g6suOmYpCsjGqoSf3EpLcaIBTsL+eA/rRIrqweK8N+FDTB7zVurnmFouKvYvKTz16R
         qQ/VQASeIGk61h+HpcqC0bn28/6RQav3aTkEngCbDLEo8mzgFKy4dBk0YyAwljH3De/D
         cxWWRjG/P6kYdYdOHyXXMCIxMKscbpb6L2sKuY9RilSqSf0Jwk+fmY6bwzSxjdCy8cu7
         z8XPptTx2k5dtKHU63VB4VOSelOU6pikBUW/Al+UHd6I1a1OXcqQFJEZgiit0/iVt6ED
         6RPVVtz7Tpaj63xCsR2um1mQEn3rXhEMgaGtS/3pXp50UQJjCXcSDmla4ksJPUzSxG80
         ahTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696644873; x=1697249673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mpftVBDmZlVrcM4E1/xk2GP1ZYmd4Pa5biiRHrPKWo=;
        b=oWFowzpv2B/ntVSFwCeVE3LgNdZs4+aDKEZeJALbKiP4bgA4AFWa16sZE2N/yWVJOZ
         QHJyYBKImukFYHfJWQuuCwCffXNi5vgKRyXnXL10gIFpawk0rkUQg+ywfM65ADyff5R2
         kxafQvYoEsbz6NB177mZoT7jbXSU6AZt63J1K+OG1lW23Jngpmb7sJ+nQmMbK/LZ7BI5
         JinR3EM59X/ZHkUwwf9ZlWX1Sq0gfntdR/9rcaV/pojic76RIC2HuFcm62yWJEBZ7Hoe
         +3MOtE75jiEsA9oMDRaGc2yL9o93BW0MEJ9qKAKPjeLKf2PUN/iklM4WKRbhQGwQvHeo
         YUgg==
X-Gm-Message-State: AOJu0YwUKTqMMcEm+pRiouSJoljQhrHaRlG+pZ6uglfl4NrXcQ/nt9lE
        EZEnolzu1E4CFWmuYF6BnCmK7S9HlbodMuGPag2bHg==
X-Google-Smtp-Source: AGHT+IHPMxkPFA5YVZinAl5IZI/T7jsHLdvSFVbSBBkTfRA5h6555HgxF1kTPgvW3YXh5V+5e1YUQek8qN2ST7BEpjs=
X-Received: by 2002:a05:6a20:9188:b0:14c:d494:77c5 with SMTP id
 v8-20020a056a20918800b0014cd49477c5mr11675121pzd.13.1696644873540; Fri, 06
 Oct 2023 19:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20231006130032eucas1p18c6f5c39614768911730fa6ed0201ee3@eucas1p1.samsung.com>
 <20231006125557.212681-1-m.majewski2@samsung.com>
In-Reply-To: <20231006125557.212681-1-m.majewski2@samsung.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 6 Oct 2023 21:14:22 -0500
Message-ID: <CAPLW+4kmA6iYDPFxyASHLJifz63DRxT9gqQ-AsMAVy0RzoaFRw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix Samsung pinctrl driver static allocation of GPIO
 base warning
To:     Mateusz Majewski <m.majewski2@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 8:01=E2=80=AFAM Mateusz Majewski <m.majewski2@samsun=
g.com> wrote:
>
> The object of this work is fixing the following warning, which appears
> on all targets using that driver:
>
> gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic=
 allocation.
>
> This needs a small refactor to how we interact with the pinctrl
> subsystem. Finally, we remove some bookkeeping that has only been
> necessary to allocate GPIO bases correctly.
>
> Mateusz Majewski (4):
>   pinctrl: samsung: defer pinctrl_enable
>   pinctrl: samsung: use add_pin_ranges method to add pinctrl ranges
>   pinctrl: samsung: choose GPIO numberspace base dynamically
>   pinctrl: samsung: do not offset pinctrl numberspaces
>
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 56 ++++++++++++-----------
>  drivers/pinctrl/samsung/pinctrl-samsung.h |  4 +-
>  2 files changed, 31 insertions(+), 29 deletions(-)
>
> --

Hi Mateusz,

Thank you for handling this! Those deprecation warnings have been
bugging me for some time :) While testing this series on my E850-96
board (Exynos850 based), I noticed some changes in
/sys/kernel/debug/gpio file, like these:

8<-------------------------------------------------------------------------=
----------------->8
-gpiochip0: GPIOs 0-7, parent: platform/11850000.pinctrl, gpa0:
- gpio-7   (                    |Volume Up           ) in  hi IRQ ACTIVE LO=
W
+gpiochip0: GPIOs 512-519, parent: platform/11850000.pinctrl, gpa0:
+ gpio-519 (                    |Volume Up           ) in  hi IRQ ACTIVE LO=
W

-gpiochip1: GPIOs 8-15, parent: platform/11850000.pinctrl, gpa1:
- gpio-8   (                    |Volume Down         ) in  hi IRQ ACTIVE LO=
W
+gpiochip1: GPIOs 520-527, parent: platform/11850000.pinctrl, gpa1:
+ gpio-520 (                    |Volume Down         ) in  hi IRQ ACTIVE LO=
W

-gpiochip2: GPIOs 16-23, parent: platform/11850000.pinctrl, gpa2:
+gpiochip2: GPIOs 528-535, parent: platform/11850000.pinctrl, gpa2:

...
8<-------------------------------------------------------------------------=
----------------->8

So basically it looks like all line numbers were offset by 512. Can
you please comment on this? Is it an intentional change, and why it's
happening?

Despite of that change, everything seems to be working fine. But I
kinda liked the numeration starting from 0 better :)

Thanks!

> 2.42.0
>
