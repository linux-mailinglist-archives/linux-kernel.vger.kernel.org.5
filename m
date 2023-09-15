Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1694C7A1BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbjIOKEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbjIOKEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:04:48 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8108344AE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:02:50 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 589A03F677
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694772168;
        bh=QkyFp7kf2CVO2Ub+8zdfAbl+jurBUvZ+r3KzB+EtSOE=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Cl633bW+qJNcebsrcec5ajCpi/p/4uooYtmUqZHFdVJuY1li6JWm2W68Het3EM1E4
         UBGpdfieeKjRhykQNDs8UxLtaX7iRm6cVHJ6PsU/z2UKhzUi7MVeX1oP/IUBIL3g3q
         1S0DfTnSn78XaO4LrmxnFP1wAzPpxL68mlNPXJe2Aj9VmqJim6IeryxfW2z9rS+/bG
         h8KI2jJ/NKgNAjlzs5sK4GVm+2wxkmougECfwH+FJVwHmenG9iHslENzA1VkS2tbc8
         x66Q0Xj4zyw4LMpVY32E8dyAdoR+2qz1l6CQ9BhGcdfO2F6yNmJ5OjFlnAkH1sqbjH
         rUh9ejCIqiJQA==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-414c43a48fdso21978111cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694772166; x=1695376966;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QkyFp7kf2CVO2Ub+8zdfAbl+jurBUvZ+r3KzB+EtSOE=;
        b=UX64bBmFvWg9hMKCVC5GmxuaEewDvMRMyEzhJT8YJnwsK9ydq4ncT7SHObQ7nUR5kW
         S6ENXcxUsH7bgfg3nPAb4CxBw9o74tZNfVYTnKQ3/AKR/2GOlS2C7wbGG7JifjKTD3it
         NoGplFeG36q5T9g/PkFE1x5PEheqYBWF5Jdkp73XnOZHLs5MKu2Gg9xyvf+zr6rYXm1f
         7oe4mcnuGd0crQznDmCA/uL2JWUuP2yT9lfqLniche5cUm3NtqywRAGQHXLARhZEyB70
         CK7wreX1PNPAD/Y4N7fOFOY0B02CFZN6oN/3+L/rbfo7qW71PfXh5Fk0v4VMMEUuSrMd
         1lbg==
X-Gm-Message-State: AOJu0YxDqUlaHOspgxfPk0BzxxT+VhsNZL5tIsU7ruJHCgaNeZCfpEj6
        WL456sqcxuMXfY6v4FLnu1LT6UMFyHp9cPPtPjG2nAB4tKO9gij85F6yw2LglYZ9Pc4Lbij49nc
        N3lE7ioIgx8L7nCT7DOJsOfxsgPvp/X4VzJxe5v3TcLrrAZn2ceJXlRlvNA==
X-Received: by 2002:a05:622a:50f:b0:413:3384:d43f with SMTP id l15-20020a05622a050f00b004133384d43fmr1205905qtx.11.1694772166706;
        Fri, 15 Sep 2023 03:02:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcuEVbIaKxRfintolzQeQEqh1KYU8VcadUoiPE32/xiQVSV3jCFDSTK9K4fjz4v/l2KVtOBfxlhc7L+2IchGU=
X-Received: by 2002:a05:622a:50f:b0:413:3384:d43f with SMTP id
 l15-20020a05622a050f00b004133384d43fmr1205890qtx.11.1694772166482; Fri, 15
 Sep 2023 03:02:46 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 15 Sep 2023 03:02:46 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <803daa8f-f4bd-34b7-f826-89e1db5f24f6@linaro.org>
References: <20230915072558.118325-1-wangchen20@iscas.ac.cn> <803daa8f-f4bd-34b7-f826-89e1db5f24f6@linaro.org>
Mime-Version: 1.0
Date:   Fri, 15 Sep 2023 03:02:45 -0700
Message-ID: <CAJM55Z-GMm5Hmk7-QWt8Prvp7qyFzOrQVjOjB7jfoX-oiT_C1A@mail.gmail.com>
Subject: Re: [PATCH 10/12] serial: 8250_dw: Add Sophgo SG2042 support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wang Chen <unicornxw@gmail.com>,
        linux-riscv@lists.infradead.org, conor@kernel.org,
        aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski wrote:
> On 15/09/2023 09:25, Wang Chen wrote:
> > From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> >
> > Add quirk to skip setting the input clock rate for the uarts on the
> > Sophgo SG2042 SoC similar to the StarFive JH7100.
> >
> > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>
> Missing SoB.
>
> > ---
> >  drivers/tty/serial/8250/8250_dw.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> > index f4cafca1a7da..6c344877a07f 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -770,7 +770,7 @@ static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
> >  	.quirks = DW_UART_QUIRK_IS_DMA_FC,
> >  };
> >
> > -static const struct dw8250_platform_data dw8250_starfive_jh7100_data = {
> > +static const struct dw8250_platform_data dw8250_skip_set_rate_data = {
>
> Why? What is wrong with old name?
>
> >  	.usr_reg = DW_UART_USR,
> >  	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
> >  };
> > @@ -780,7 +780,8 @@ static const struct of_device_id dw8250_of_match[] = {
> >  	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
> >  	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
> >  	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
> > -	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_starfive_jh7100_data },
> > +	{ .compatible = "sophgo,sg2042-uart", .data = &dw8250_skip_set_rate_data },
> > +	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_skip_set_rate_data },
>
> So devices are fully compatible? Then use compatibility and drop this
> patch entirely.

I'm fine with this, but these are two different companies and SoCs that just
happens to have both implemented the Designware UART with an inflexible input
clock. So if fx. a real quirk is found on the JH7110 then we'd need to either
change the compatible on an unrelated SoC or change compatible on the JH7110 to
something like "starfive,jh7100-uart-with-quirk" and "starfive,jh7100-uart" will
forever be a quirky way to spell "dw8250 with inflexible input clock".
Is that how device trees are supposed to work?

/Emil
>
> Best regards,
> Krzysztof
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
