Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C539802F53
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjLDJxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjLDJxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:53:10 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E40D6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:53:16 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5c85e8fdd2dso46615757b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701683595; x=1702288395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4N5YX1BKV8oox5fEfVsppXE4Fy2jzNA7d1t/N82c1Q=;
        b=Z1ihlZp5OvACtHh8wDM8HVv9cYHgGpVvf6XuwF/q1xhvV3BuS5YPMfHQnyiYd/WR49
         YSv4lnUiHpL+ELL6YxhotvcpuHrUFm0VCRJc28m5EpLM1Lo9NH7UBOmiaoBkuHstMi0n
         tNJdaZIZxjmvlUUA8HIdNTScCS59ruHrdze4WNXHCUAkuAHm/3Kj3f/e9BoTcSgBSTMi
         V7Bn11D5fI+sxqeUyRvq3KrXk2Wjfeb78tazkOp3CpwrAmcEkED+7ziK6SN57BszxQrr
         AO9JtIBXhy5u4eA3vnkRLu3xzC16lXXws//SNG98yv+L7pThx6HjOCUS1JNk5exGiK8P
         hSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701683595; x=1702288395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4N5YX1BKV8oox5fEfVsppXE4Fy2jzNA7d1t/N82c1Q=;
        b=OVFwfud+b8ZGq/jTC4krE2xVhyRlPnETY1nuy5qfzqnvvSq3ipSXfgtRnDxUANd5p+
         zjcqfQazUkB57lwI9GfDhahcLSKvGXh3f8XBvg2GqtoEADC/KfB6y/xvA6U2FxhSk8RW
         tdl8UeEj1WTyDKR1aVZ0truKbw9KEUuovGQPMCPkfsmOGzyP1pVFNLkqTRBGOwhPNRPd
         XW8cyye9w0Qr+UpdPVMUEVMLPFXYivAonzMN7X1FBwf1pO1BTOpAJ5FPFiY+wMFjhdOp
         1v7uj064OVuJoBQU3idp5tXVzqFYsTg6+rAvHufubQsMNHYkcbQs1BKHYAByE/H/92/B
         UViQ==
X-Gm-Message-State: AOJu0Yz620l7x/YgI9VCXSMKCzyvNcIEe8RQsdi+ZxJG1r4G4w15nwZG
        RqukI59bYWD32sVrB8YC2WQDrEcxGVkxz6BlZIJB7g==
X-Google-Smtp-Source: AGHT+IHcnTMe/JadPl1Hll5euXLI4XbibjJDI0jfVQz3qrgnV13paxopm65SeTqFDG1zbpo/IAuRT5PYQjZPVvBBMpw=
X-Received: by 2002:a81:ae05:0:b0:5d4:1fe1:312d with SMTP id
 m5-20020a81ae05000000b005d41fe1312dmr5265235ywh.17.1701683595605; Mon, 04 Dec
 2023 01:53:15 -0800 (PST)
MIME-Version: 1.0
References: <20231128-j7200-pinctrl-s2r-v1-0-704e7dc24460@bootlin.com>
In-Reply-To: <20231128-j7200-pinctrl-s2r-v1-0-704e7dc24460@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Dec 2023 10:53:04 +0100
Message-ID: <CACRpkdbsOxxemqe023jsE8vCxgY763CAZJ-Ru9dLTr=5-wqzBA@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl: pinctrl-single: fix suspend/resume on j7200
To:     Thomas Richard <thomas.richard@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        theo.lebrun@bootlin.com, u-kumar1@ti.com
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

On Tue, Nov 28, 2023 at 4:35=E2=80=AFPM Thomas Richard
<thomas.richard@bootlin.com> wrote:

> Thomas Richard (3):
>       dt-bindings: pinctrl: pinctrl-single: add ti,j7200-padconf compatib=
le
>       pinctrl: pinctrl-single: add ti,j7200-padconf compatible

Patch 1 & 2 applied to the pin control tree, thanks!

>       arm64: dts: ti: k3-j7200: use ti,j7200-padconf compatible

Please funnel this through the SoC tree.

Yours,
Linus Walleij
