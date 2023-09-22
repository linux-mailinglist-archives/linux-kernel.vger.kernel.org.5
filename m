Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5BC7AB07A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbjIVLTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbjIVLTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:19:46 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC25CD9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:19:38 -0700 (PDT)
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9A4BF41DB4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695381576;
        bh=1mIxhTKnFz6jPIBGB85iZJtGzL+3q9xOGEF8ZcDvszY=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=sncnI5hhujRbZJa87Wy2M5hnTaqSGgxdN2aMdCOX6Kxql0lojJxt/7OYHLDhITXoC
         WwyPMTzQJZVdXHl+6ykml6ze/wZvhtddLvnDi5Bdi7Z9eCzPHv6fs8dEqj6f2GGojK
         eJr1CUFD/hZ0U9YY5i/5N2tWnf7fScSO9R8N2q+e6uB7cQ8gHl8JHdPiNfkbu9Q+VV
         Ypf9suBpN9R8+60qokxRygZpI7mi5nesCwKtAUHNkm8QfH247uUtGzsodY1NtBhm9K
         GP3gVZS2fXv34eJDc32GrwH5COyoZVb8YMZPlDMdjV9vUqlLF0tJ8vfOGkYJVnEl8O
         T68FqWXTUrpYQ==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-414bbfbdf37so20859591cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695381575; x=1695986375;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1mIxhTKnFz6jPIBGB85iZJtGzL+3q9xOGEF8ZcDvszY=;
        b=Sow7xo2N+6Kf2Xztjc27OA0tstl64ngNcW6Z9hTToP1/gxsUxPq6u+MOMZxaGdCLa+
         TS/6LgCBwcJ31DHSAP1K4V7Khj3/YRwsmdxTGRoUOhi3sEzPBnFlnKcZ5Oa0ZEhwFOuR
         H8SPDhG6MxWTmMjCGPhNfShTBeea1JuQmMvWGY8lIs28x5PTbGglcPQBMtr/Yc+6bXC5
         574EMF9XqUxPwmknsokLkNNHlk74JEWY+nPEMfWRyD/e4/kRj1XiKSaU2nV22Scay/Yu
         E/gNA5WZ/69OmER23UWoB0kaVfifcowpnZSnYTd6i+iXjC4eHNQBU73ksHROenO6uwkb
         2x3A==
X-Gm-Message-State: AOJu0YzOPqY2UbHi4l6ixdrIBSTsYlrsX+Vx/zrXmHdUMew+DpqO792J
        MzsG/3bS6Gf35/bVT8PsMfulEpDX4I0t1GHHEJGjJkTEZtUx7rHenDKpHUUEYEzN575aVCXprOg
        de+cadqUgpyoTvSPP0z1R5v4WU42rzDTaYmDAqwctuF1XukFL8l3oYm9V3w==
X-Received: by 2002:a05:622a:1183:b0:417:98a1:3403 with SMTP id m3-20020a05622a118300b0041798a13403mr8762361qtk.25.1695381575614;
        Fri, 22 Sep 2023 04:19:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF84PCUxr/KMVWHCHR/zUqvpLVX2Rs9nI1gNGBy7jDTcV2nsokG0Xv14fhICpXsCH39rVxLqJq5o09Iq1BDIHM=
X-Received: by 2002:a05:622a:1183:b0:417:98a1:3403 with SMTP id
 m3-20020a05622a118300b0041798a13403mr8762342qtk.25.1695381575315; Fri, 22 Sep
 2023 04:19:35 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Sep 2023 04:19:34 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <0bd1742c-fa39-4f63-a594-6d325dc6b062@codethink.co.uk>
References: <20230915072558.118325-1-wangchen20@iscas.ac.cn>
 <803daa8f-f4bd-34b7-f826-89e1db5f24f6@linaro.org> <CAJM55Z-GMm5Hmk7-QWt8Prvp7qyFzOrQVjOjB7jfoX-oiT_C1A@mail.gmail.com>
 <862905cc-48c3-2dc9-6032-6ee189a629e6@linaro.org> <CAJM55Z8WDcjRER3ffnj+6V=QWEmudZyaO9z2iPUvreU1okq27A@mail.gmail.com>
 <0bd1742c-fa39-4f63-a594-6d325dc6b062@codethink.co.uk>
Mime-Version: 1.0
Date:   Fri, 22 Sep 2023 04:19:34 -0700
Message-ID: <CAJM55Z_M47JA3U40whsRnW-nHN+yjyOo6eCUrGBK-=a1VvHuaQ@mail.gmail.com>
Subject: Re: [PATCH 10/12] serial: 8250_dw: Add Sophgo SG2042 support
To:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wang Chen <unicornxw@gmail.com>,
        linux-riscv@lists.infradead.org, conor@kernel.org,
        aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Dooks wrote:
> On 15/09/2023 11:23, Emil Renner Berthing wrote:
> > Krzysztof Kozlowski wrote:
> >> On 15/09/2023 12:02, Emil Renner Berthing wrote:
> >>> Krzysztof Kozlowski wrote:
> >>>> On 15/09/2023 09:25, Wang Chen wrote:
> >>>>> From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> >>>>>
> >>>>> Add quirk to skip setting the input clock rate for the uarts on the
> >>>>> Sophgo SG2042 SoC similar to the StarFive JH7100.
> >>>>>
> >>>>> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> >>>>
> >>>> Missing SoB.
> >>>>
> >>>>> ---
> >>>>>   drivers/tty/serial/8250/8250_dw.c | 5 +++--
> >>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> >>>>> index f4cafca1a7da..6c344877a07f 100644
> >>>>> --- a/drivers/tty/serial/8250/8250_dw.c
> >>>>> +++ b/drivers/tty/serial/8250/8250_dw.c
> >>>>> @@ -770,7 +770,7 @@ static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
> >>>>>   	.quirks = DW_UART_QUIRK_IS_DMA_FC,
> >>>>>   };
> >>>>>
> >>>>> -static const struct dw8250_platform_data dw8250_starfive_jh7100_data = {
> >>>>> +static const struct dw8250_platform_data dw8250_skip_set_rate_data = {
> >>>>
> >>>> Why? What is wrong with old name?
> >>>>
> >>>>>   	.usr_reg = DW_UART_USR,
> >>>>>   	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
> >>>>>   };
> >>>>> @@ -780,7 +780,8 @@ static const struct of_device_id dw8250_of_match[] = {
> >>>>>   	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
> >>>>>   	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
> >>>>>   	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
> >>>>> -	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_starfive_jh7100_data },
> >>>>> +	{ .compatible = "sophgo,sg2042-uart", .data = &dw8250_skip_set_rate_data },
> >>>>> +	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_skip_set_rate_data },
> >>>>
> >>>> So devices are fully compatible? Then use compatibility and drop this
> >>>> patch entirely.
> >>>
> >>> I'm fine with this, but these are two different companies and SoCs that just
> >>> happens to have both implemented the Designware UART with an inflexible input
> >>> clock. So if fx. a real quirk is found on the JH7110 then we'd need to either
> >>> change the compatible on an unrelated SoC or change compatible on the JH7110 to
> >>
> >> Wait, why? The compatible is still there, so you just add here proper
> >> entry, if ever needed.
> >
> > Sorry, I messed up my example by writing JH7110 where I meant JH7100
> >
> >>> something like "starfive,jh7100-uart-with-quirk" and "starfive,jh7100-uart" will
> >>> forever be a quirky way to spell "dw8250 with inflexible input clock".
> >>> Is that how device trees are supposed to work?
> >>
> >> I don't get this part. But anyway if the blocks are really designed or
> >> done independently and there is no shared part, except the DWC block,
> >> then indeed the compatibility might be just a coincidence...
> >>
> >
> > It is. Sophgo and StarFive are not the same company. Sophgo are using RISC-V
> > cores from T-Head and StarFive are using cores from SiFive. They just happen to
> > both use the Designware UART in the same way.
>
> Out of interest, what's the issue with just providing an fixed clock in
> the device tree for these machines?

You mean adding a "fake" fixed clock to the device tree and specify that in the
uart nodes? That would break the clock dependency, so then you'd need to add
some other way to tell the clock framework not to shut down the real clock.

/Emil
