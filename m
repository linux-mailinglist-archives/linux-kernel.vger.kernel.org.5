Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70A67DCFC6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344511AbjJaO4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344312AbjJaO4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:56:46 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D275DDB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:56:43 -0700 (PDT)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 69AB040633
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 14:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698764201;
        bh=FpYMLQZ13miVSKwRHhEO2KWJ/cMhZ5Lcm8HLU14KOBM=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=NwdX/EV3J5mNeImayDdHQ+qLASS7cpGxKokVn01JmSwpQIS7JsnJxDYhC9di/PHmW
         oFxGAyqZDOH6w3J8XqPNQiQfS/gh741tdLf0AQAakebAPE4CQhZ227uk7JVxy+UUro
         f/9xKskH3I9Zy3afaExlQ0EmkSknYQFQAQe0DwKMZUNYGLVlpynmslrtwpmpJUJCrd
         YXoIi6wOIZpo5MiZppkyWQAu0vDroP7Yv5mBx4uPXoujjlk13g6KfidBNDeTQb1HRH
         0+xj3HpAV8HdEong04gjW89fbaWW2NvO3lEhqHDmIQ7WKo5NZbJI6hqbOVuPAXk9Pv
         Xe97n78amBYdw==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41cb7904d5aso69982651cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698764199; x=1699368999;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpYMLQZ13miVSKwRHhEO2KWJ/cMhZ5Lcm8HLU14KOBM=;
        b=u0e5MjCaHlfiL/SK9pKSHRWBfLSj7ELJtcBdw2G/fnxw/CBs3kd+l1AsCCVpob/DJy
         +JQAxsT93NJwWBqWvEHVLlr7o+Ly4fDrRD2t12kD3X+AyqQNcEZdhxHpQ6dTGwj9WWIN
         n8jYD8I1IvIPyhECIogf0T4y5oQWPDo0Ps7nb+JPBouFre+gguz58Oxy87nKLFYfKQPG
         HBe1gCN/sXsEZ4ZP4AAQ19lH1m6kKBA8ttGBBXgPo9bUWEX0FawyT8sW45beGlQsUE5c
         v4dt8kLLbU1k+swEH17k0GCWCbVwkKfAZ7Rl+JuskZ4gwFtnKxuBqdsZS063URhhb13c
         RANg==
X-Gm-Message-State: AOJu0YywgmZeJWhwmB4zHjw3OxvA+BqAQ/NI5MeZpq3Od+nQpXxOvS7o
        3RbY5A70RP/NusUmlxwSIzoeWBg1nxmGvmQTolzHEY+ZenJonsB+fdYrI5NP5arRjIls29HeEuX
        mfn3elc4bw5sGr3PgTMitluzugxBaVNh76/Y9xOnd8i4yLd+rE2/EQAouCg==
X-Received: by 2002:ac8:7f83:0:b0:41e:204b:f931 with SMTP id z3-20020ac87f83000000b0041e204bf931mr17140720qtj.42.1698764199269;
        Tue, 31 Oct 2023 07:56:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhxXT6zh5apbHzBARYifBNWbjuGUA0HkX/8LhJMxPXwDzweT07IN3atmh/TMSuRVNN9nyxQvVV4SHG8UkDbZU=
X-Received: by 2002:ac8:7f83:0:b0:41e:204b:f931 with SMTP id
 z3-20020ac87f83000000b0041e204bf931mr17140690qtj.42.1698764198975; Tue, 31
 Oct 2023 07:56:38 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 31 Oct 2023 07:56:38 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <9b8c9846-20be-4cfa-aff5-f9ae8ac2aba4@lunn.ch>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-9-cristian.ciocaltea@collabora.com> <9b8c9846-20be-4cfa-aff5-f9ae8ac2aba4@lunn.ch>
Mime-Version: 1.0
Date:   Tue, 31 Oct 2023 07:56:38 -0700
Message-ID: <CAJM55Z_+A1jceB5QWwZ9=roAs7jeAb7E-CEdw3mSOng=jyVDYg@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] riscv: dts: starfive: Add pool for coherent DMA
 memory on JH7100 boards
To:     Andrew Lunn <andrew@lunn.ch>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Lunn wrote:
> On Sun, Oct 29, 2023 at 06:27:08AM +0200, Cristian Ciocaltea wrote:
> > From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> >
> > The StarFive JH7100 SoC has non-coherent device DMAs, but most drivers
> > expect to be able to allocate coherent memory for DMA descriptors and
> > such. However on the JH7100 DDR memory appears twice in the physical
> > memory map, once cached and once uncached:
> >
> >   0x00_8000_0000 - 0x08_7fff_ffff : Off chip DDR memory, cached
> >   0x10_0000_0000 - 0x17_ffff_ffff : Off chip DDR memory, uncached
> >
> > To use this uncached region we create a global DMA memory pool there and
> > reserve the corresponding area in the cached region.
> >
> > However the uncached region is fully above the 32bit address limit, so add
> > a dma-ranges map so the DMA address used for peripherals is still in the
> > regular cached region below the limit.
> >
> > Link: https://github.com/starfive-tech/JH7100_Docs/blob/main/JH7100%20Data%20Sheet%20V01.01.04-EN%20(4-21-2021).pdf
> > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> > ---
> >  .../boot/dts/starfive/jh7100-common.dtsi      | 24 +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> > index b93ce351a90f..504c73f01f14 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> > +++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> > @@ -39,6 +39,30 @@ led-ack {
> >  			label = "ack";
> >  		};
> >  	};
> > +
> > +	reserved-memory {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +
> > +		dma-reserved {
> > +			reg = <0x0 0xfa000000 0x0 0x1000000>;
>
> If i'm reading this correctly, this is at the top of the first 4G of
> RAM. But this is jh7100-common.dtsi. Is it guaranteed that all boards
> derived from this have at least 4G? What happens is a board only has
> 2G?

Yes, both the BeagleV Starlight and StarFive VisionFive V1 boards have at least
4G of ram and there won't be any more boards with this SoC. It was a test chip
for the JH7110 after all.

There aren't really any limitations on where this pool could be placed, so I
just chose to wedge it between ranges reserved for graphics by the bootloader.
If anyone has a better idea please go ahead and change it.

>
> It might also be worth putting a comment here about the memory being
> mapped twice. In the ARM world that would be illegal, so its maybe not
> seen that often. Yes, the commit message explains that, but when i
> look at the code on its own, it is less obvious.
>
> > +			no-map;
> > +		};
> > +
> > +		linux,dma {
> > +			compatible = "shared-dma-pool";
> > +			reg = <0x10 0x7a000000 0x0 0x1000000>;
> > +			no-map;
> > +			linux,dma-default;
> > +		};
> > +	};
