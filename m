Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BE87A1C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbjIOKYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbjIOKYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:24:44 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC4C3C39
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:23:40 -0700 (PDT)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 91D9D3F683
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694773418;
        bh=DVQzFwUpbsXuIGkXzoIV2yaJxsbZHyDDscyAWq7j40I=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=VLgLHZCIvZXavGmzi/VrC/fTASD5+EiT9GdMyP7mVN56CdeiRSdTCXcLgRkhUpmzJ
         FDt6MxjrACIt3BUN7g8SygpgHRa43QLRR47w54q5510QpyiN8a5qEewynhSwdPtyY2
         +5IOkA0R+S4mbS782cwQe/nr1NHBgmD8RD8hRGqMbAL1ojctl+ZBzRlrf91A9DwiF7
         +pzAOwwHRmxbe8i8TdMK02RyImOxlWmQGY0nJ2k2DehkxAJOw+toWCeD9jGIOZ17RV
         cbC3CN/xM5+a877Jp+O+w/6Z1+hHXmttX80fR9MJlDilrzNcy3xFpjZm9Fn328LZMg
         31WnMvhILcSTA==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-414bd030211so20701941cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694773416; x=1695378216;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVQzFwUpbsXuIGkXzoIV2yaJxsbZHyDDscyAWq7j40I=;
        b=P0en98f9hpuIiiAZ6YjuknhpSlv6OCo2+Sk9N4Sh0MPKncxjnEczE76wWB/pZ97GHP
         drPBRmnxr8xqOPCfMiL0U5jAYbc2ZAXRHBlVG1Ks2nipaPBk4e8CLUxkLZ0dmiFbl9Xy
         GF4Ew9OoE18YsgMC9Q7sC5GJj4xdafFL9KSK9LvAFhZnRbQuo1VHuIgHfU7Q5vVy1kIp
         hQ62uS47XYsRLhXgBrtYS3V6GMrlaedNBmwlTd/g13fFUsEuKX7/sJvF9S+vw7zuicNW
         pKRX3nUd17gJNUMloL55RZI6qEKiY7A3Nxd/CqZXum/UfaAxO3Txk52kFY5+NNnMumqi
         HpaA==
X-Gm-Message-State: AOJu0YwiMFbn3c8zh9OPv9OPI0j3cxUGy1dfEPOuAIh0dCWpabTPNrdr
        kfA62obvoT0ULYtNASNK//KCPf6KlGKx5lzpSmJ9NvDoFsaat5CQ7rnr5NamPGOmZEEuJwC5Y22
        8pJgJgOdH0wcSo8IJ1O7CqfbqgXWddLCIivU7O/j9xcNv7m8givJb6GTzC/wFKSuOZg==
X-Received: by 2002:a05:622a:1492:b0:403:e1d1:8b91 with SMTP id t18-20020a05622a149200b00403e1d18b91mr1304337qtx.60.1694773416768;
        Fri, 15 Sep 2023 03:23:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEz6XoHpeoa1FTEaRyEIa8VosrmBlxM/6MYyeWBvLfPWnf7jhkHcp8hPE2RmqA1ElsiydQSlVI4+mzX7w4v7/U=
X-Received: by 2002:a05:622a:1492:b0:403:e1d1:8b91 with SMTP id
 t18-20020a05622a149200b00403e1d18b91mr1304322qtx.60.1694773416535; Fri, 15
 Sep 2023 03:23:36 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 15 Sep 2023 03:23:36 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <862905cc-48c3-2dc9-6032-6ee189a629e6@linaro.org>
References: <20230915072558.118325-1-wangchen20@iscas.ac.cn>
 <803daa8f-f4bd-34b7-f826-89e1db5f24f6@linaro.org> <CAJM55Z-GMm5Hmk7-QWt8Prvp7qyFzOrQVjOjB7jfoX-oiT_C1A@mail.gmail.com>
 <862905cc-48c3-2dc9-6032-6ee189a629e6@linaro.org>
Mime-Version: 1.0
Date:   Fri, 15 Sep 2023 03:23:36 -0700
Message-ID: <CAJM55Z8WDcjRER3ffnj+6V=QWEmudZyaO9z2iPUvreU1okq27A@mail.gmail.com>
Subject: Re: [PATCH 10/12] serial: 8250_dw: Add Sophgo SG2042 support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Wang Chen <unicornxw@gmail.com>,
        linux-riscv@lists.infradead.org, conor@kernel.org,
        aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski wrote:
> On 15/09/2023 12:02, Emil Renner Berthing wrote:
> > Krzysztof Kozlowski wrote:
> >> On 15/09/2023 09:25, Wang Chen wrote:
> >>> From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> >>>
> >>> Add quirk to skip setting the input clock rate for the uarts on the
> >>> Sophgo SG2042 SoC similar to the StarFive JH7100.
> >>>
> >>> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> >>
> >> Missing SoB.
> >>
> >>> ---
> >>>  drivers/tty/serial/8250/8250_dw.c | 5 +++--
> >>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> >>> index f4cafca1a7da..6c344877a07f 100644
> >>> --- a/drivers/tty/serial/8250/8250_dw.c
> >>> +++ b/drivers/tty/serial/8250/8250_dw.c
> >>> @@ -770,7 +770,7 @@ static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
> >>>  	.quirks = DW_UART_QUIRK_IS_DMA_FC,
> >>>  };
> >>>
> >>> -static const struct dw8250_platform_data dw8250_starfive_jh7100_data = {
> >>> +static const struct dw8250_platform_data dw8250_skip_set_rate_data = {
> >>
> >> Why? What is wrong with old name?
> >>
> >>>  	.usr_reg = DW_UART_USR,
> >>>  	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
> >>>  };
> >>> @@ -780,7 +780,8 @@ static const struct of_device_id dw8250_of_match[] = {
> >>>  	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
> >>>  	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
> >>>  	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
> >>> -	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_starfive_jh7100_data },
> >>> +	{ .compatible = "sophgo,sg2042-uart", .data = &dw8250_skip_set_rate_data },
> >>> +	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_skip_set_rate_data },
> >>
> >> So devices are fully compatible? Then use compatibility and drop this
> >> patch entirely.
> >
> > I'm fine with this, but these are two different companies and SoCs that just
> > happens to have both implemented the Designware UART with an inflexible input
> > clock. So if fx. a real quirk is found on the JH7110 then we'd need to either
> > change the compatible on an unrelated SoC or change compatible on the JH7110 to
>
> Wait, why? The compatible is still there, so you just add here proper
> entry, if ever needed.

Sorry, I messed up my example by writing JH7110 where I meant JH7100

> > something like "starfive,jh7100-uart-with-quirk" and "starfive,jh7100-uart" will
> > forever be a quirky way to spell "dw8250 with inflexible input clock".
> > Is that how device trees are supposed to work?
>
> I don't get this part. But anyway if the blocks are really designed or
> done independently and there is no shared part, except the DWC block,
> then indeed the compatibility might be just a coincidence...
>

It is. Sophgo and StarFive are not the same company. Sophgo are using RISC-V
cores from T-Head and StarFive are using cores from SiFive. They just happen to
both use the Designware UART in the same way.

/Emil
