Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7DA8057C9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345708AbjLEOsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbjLEOsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:48:15 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CEC1A5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:48:20 -0800 (PST)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0E42C40C54
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 14:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701787698;
        bh=qEnhI07ZwfWB+LTPcQ8NmAlx9Ikuvbn1P7U+F8t2Qu8=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=haILexKMUaiNMQEFYfJ0gKo21K+5iThFY+GRe+JqhXD05aOORkVqfnkHq5iQOWn/v
         BjljVTWQBhsfUG+08P7sebKP7crSdnFIKYyYNckZcs7gR9pOeO1v8Q3lvBCg+l0IQP
         4ZFCpoY1Gxwlnbqvnck1BHO9N9nQUPi8JTnJoYJ59IX6/YhiYfJnYZ/5Eb0kvanb4z
         11uhD+um6+3YDoH/EipdSAeqAaaAgC+dnnUYalfYU5i3W2UtQpNKEs+nWQZy0JmzSD
         6FmZqId5EiF+gJxjNaDwf4D4d0SjVwYAM3VLUdd1yCtHLulaBMvqfzc7XjDm6a8AVl
         hE3NZeOg0hyQw==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-423e91275deso81579451cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 06:48:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701787697; x=1702392497;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEnhI07ZwfWB+LTPcQ8NmAlx9Ikuvbn1P7U+F8t2Qu8=;
        b=tacSBCS1XK/4aeuO89Z5npj3s+N6YsxIcJXi5PTaMChzD24xGQXL7x5wry0HU8iJD/
         FrZ+6BQM+cLzBu6YoAVKGYlNVizYUPweV9LUg5ziUvq9REl69LaWW87T9WG3wOehZcSi
         zuRq060GAeiVMhIk3yChdcyJWeCjl2z41AW14H/DZLSDziCF55yGCdiA2Jn8gnWWvs5O
         fOMKCPNVuC6XIanoY82h65VFDvrLwkL4SpkkbFhRrWUmaZlcw8ASNsoDCOrcQtpYnnTE
         cvH4DxOx0Oe1lhiZXleIyygkg3ol9XaVJ6dhE18zYOIqy5cnBBHzdD0vuyENRN9EXlcs
         tYEg==
X-Gm-Message-State: AOJu0YwtGEZQcceZirIpu6xD7WRYVhhqItXFBAL9Pah6TS03XzPGXGax
        d4gwHUYAiqJbZelb92/QdkV2laBN7c/uf/BC00y7JFQ6aGh/4xVUnROfSduspMf+ZaHPMhjMAyR
        YJ0+I6grAovVxYSZCcynLfaoAeZy4T7VNIebya2Q/d7t0iwNNLymSsHXNFw==
X-Received: by 2002:a05:622a:1710:b0:425:4043:50dd with SMTP id h16-20020a05622a171000b00425404350ddmr1598956qtk.108.1701787697063;
        Tue, 05 Dec 2023 06:48:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG71k7SKMvRXL2M2tH5A/loLjfSKdVaIPyTunW1cRPFE3sVg34XcteHWngtpsKmAJPNbO86Hgqy82wP/ARNZmE=
X-Received: by 2002:a05:622a:1710:b0:425:4043:50dd with SMTP id
 h16-20020a05622a171000b00425404350ddmr1598950qtk.108.1701787696839; Tue, 05
 Dec 2023 06:48:16 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Dec 2023 06:48:16 -0800
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <ZW8zHoVWf94FDTx7@xhacker>
References: <20231129-th1520_mmc_dts-v7-0-c77fc19caa6f@baylibre.com>
 <20231129-th1520_mmc_dts-v7-2-c77fc19caa6f@baylibre.com> <CAJM55Z-qc7gc0fO-K8byqvpOBjDxFD4dP57mFHuijvpOzBWObQ@mail.gmail.com>
 <ZW8zHoVWf94FDTx7@xhacker>
Mime-Version: 1.0
Date:   Tue, 5 Dec 2023 06:48:16 -0800
Message-ID: <CAJM55Z9tPTu4N4UVCBs1AJYWrWxMUDL+8FpVZtGx4yQgKenWSQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] riscv: dts: thead: Add TH1520 mmc controllers and
 sdhci clock
To:     Jisheng Zhang <jszhang@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Drew Fustini <dfustini@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jisheng Zhang wrote:
> On Mon, Dec 04, 2023 at 01:47:45AM -0800, Emil Renner Berthing wrote:
> > Drew Fustini wrote:
> > > Add node for the SDHCI fixed clock. Add mmc0 node for the first mmc
> > > controller instance which is typically connected to the eMMC device.
> > > Add mmc1 node for the second mmc controller instance which is typically
> > > connected to microSD slot.
> > >
> > > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > > ---
> > >  arch/riscv/boot/dts/thead/th1520.dtsi | 25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >
> > > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> > > index ba4d2c673ac8..af4fdcd82e0b 100644
> > > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > > @@ -146,6 +146,13 @@ uart_sclk: uart-sclk-clock {
> > >  		#clock-cells = <0>;
> > >  	};
> > >
> > > +	sdhci_clk: sdhci-clock {
> > > +		compatible = "fixed-clock";
> > > +		clock-frequency = <198000000>;
> > > +		clock-output-names = "sdhci_clk";
> > > +		#clock-cells = <0>;
> > > +	};
> > > +
> > >  	soc {
> > >  		compatible = "simple-bus";
> > >  		interrupt-parent = <&plic>;
> > > @@ -304,6 +311,24 @@ dmac0: dma-controller@ffefc00000 {
> > >  			status = "disabled";
> > >  		};
> > >
> > > +		mmc0: mmc@ffe7080000 {
> > > +			compatible = "thead,th1520-dwcmshc";
> > > +			reg = <0xff 0xe7080000 0x0 0x10000>;
> > > +			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
> > > +			clocks = <&sdhci_clk>;
> > > +			clock-names = "core";
> > > +			status = "disabled";
> > > +		};
> > > +
> > > +		mmc1: mmc@ffe7090000 {
> > > +			compatible = "thead,th1520-dwcmshc";
> > > +			reg = <0xff 0xe7090000 0x0 0x10000>;
> > > +			interrupts = <64 IRQ_TYPE_LEVEL_HIGH>;
> > > +			clocks = <&sdhci_clk>;
> > > +			clock-names = "core";
> > > +			status = "disabled";
> > > +		};
> > > +
> >
> > Hi Drew,
> >
> > This doesn't seem to match the documentation shared here:
> > https://lore.kernel.org/linux-riscv/5f437109d2be2b8843f549a661054a2e3ec0d66e.camel@xry111.site/
> > From the TH1520 System User Manual.pdf in there, I'd expect something like
>
> >
> > 	emmc: mmc@ffe7080000 {
> > 		compatible = "thead,th1520-dwcmshc";
> > 		reg = <0xff 0xe7080000 0x0 0x10000>;
> > 		...
> > 	};
>
> Hi Emil,
>
> I think this isn't necessary. From other soc dts files, I see such
> naming, but lots socs just use mmc0, mmc1, and so on.

No it certainly isn't necessary. Those labels are purely for us humans to read
and are not present in the dtb. But that's exactly why I think it'd be a good
idea match the labels with the documentation, so it will easier for us humans
to match up the device tree source to documentation.

> And IIRC, the host for sd and sdio can support both, IOW, below
> sdio0/sdio1 may be used for sdcard.

Yes, all of the EMMC, SDIO0 and SDIO1 seem to be instances of the same IP.

/Emil
