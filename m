Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3B07D4F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjJXMQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjJXMQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:16:36 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8547B10C0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:16:33 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 880A23FAD3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 12:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698149787;
        bh=thwvxYYMUVPSY3nzBc7xApM08Kssn5NAFL9o/BCJG0g=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=nZSj4IliyasfjvdC4ZPXWVk4QNzAZMC4s2MadTa0AMCKlyPrLhK5znrt/M9U7BPKg
         tt3gZObdEneza01sXSXHsFl8poxyaUo/w3/1gTrrVuhqwvqXvSt1o2XNtq9TIotWGB
         3GojfzMSgSTFbLTmAb8j1jO68hOuNuGdA6XbDwDiATUqzkHTEpq3fDVbbeSOufbWHN
         ggvkIkgmtifj5iYtmbaxWf47IIOtt0mRRMM/TCqfTrV+f6BLrYbqcgR4nPBvtei3DF
         IABJGa3LgNJ/wKyvo/jBIE6qFWswb+OKhGCiBNuGJZXHaH7VJVlIE8NkGLW4oDdHjG
         mG36JgrDIcadw==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41cc72fca99so59999971cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698149786; x=1698754586;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thwvxYYMUVPSY3nzBc7xApM08Kssn5NAFL9o/BCJG0g=;
        b=IXgifdMg5+LoQt7tvfCK0qOs8oMtwimqKchk8PpaY72z/7tf9UCmxJRhBblAbr0c1O
         swOXBkm8mgx6MKWIrIRXc93JAGDJQpdDjhOy+TOWgBn6JnjtDgowqN6LBGx7KpHZi3Ef
         UpYcpxRDW+8z5xCTA6ZPr2yjTYCWZYg5UrcgBWFNd0Tl7OWNo2tJuDnyBYAIBOJe46Nm
         uQQCmmHTaaCLaSsGX7F3VChKJ/794A1mP3M7ZtkUHRfcfUCQGnQMFXMFgxA3yMqehFhB
         1x1x45xmlPdarTss1Nw1O293hsW7JNVTw+2SbOrRi/IUncEDp5MyAmdroqGvzwtu80OF
         MAPA==
X-Gm-Message-State: AOJu0YzJ2mw6dHynbJgOr3ALJx9YxQvRSz0rlOcTTGZbHdVW+cFzI32b
        ZkaWAXgleutGrkdRCnJl2fk7xh9y4RalPYf/4XplmgDc40prgHY1kK692+voagd//uzjLFNlwtX
        4YPeIXCmkE4L9NiidVIPvyIPoXPW0jSr3cS5QQIXDrFD/F5I9GWWNLVeb1n4ZtGDPbA==
X-Received: by 2002:a05:622a:2d2:b0:418:152d:bf4 with SMTP id a18-20020a05622a02d200b00418152d0bf4mr13460078qtx.51.1698149786494;
        Tue, 24 Oct 2023 05:16:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOE0qGS2pSUMsJf2A8W5Ex0DMIs+jJV1IcL5+p/qejHg+bJIzitFRzRk24ZJkjngpmMhUlqv5mwknRsepuX1A=
X-Received: by 2002:a05:622a:2d2:b0:418:152d:bf4 with SMTP id
 a18-20020a05622a02d200b00418152d0bf4mr13460067qtx.51.1698149786276; Tue, 24
 Oct 2023 05:16:26 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Oct 2023 05:16:25 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231023-th1520-mmc-v3-6-abc5e7491166@baylibre.com>
References: <20231023-th1520-mmc-v3-0-abc5e7491166@baylibre.com> <20231023-th1520-mmc-v3-6-abc5e7491166@baylibre.com>
Mime-Version: 1.0
Date:   Tue, 24 Oct 2023 05:16:25 -0700
Message-ID: <CAJM55Z-OBUsnybSLTxB8RHwsYuWhsMKVH3x8ana4=LeZ98Yv1Q@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] riscv: dts: thead: Enable BeagleV Ahead eMMC and microSD
To:     Drew Fustini <dfustini@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     devicetree@vger.kernel.org, Han Gao <gaohan@iscas.ac.cn>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drew Fustini wrote:
> Add mmc0 properties for the eMMC device and add mmc1 properties for
> the microSD slot. Set the frequency for the sdhci clock.
>
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> index 70e8042c8304..c4e748827889 100644
> --- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> @@ -52,6 +52,10 @@ &uart_sclk {
>  	clock-frequency = <100000000>;
>  };
>
> +&sdhci_clk {
> +	clock-frequency = <198000000>;
> +};
> +
>  &dmac0 {
>  	status = "okay";
>  };
> @@ -59,3 +63,19 @@ &dmac0 {
>  &uart0 {
>  	status = "okay";
>  };
> +
> +&mmc0 {
> +	bus-width = <8>;
> +	max-frequency = <198000000>;
> +	mmc-hs400-1_8v;
> +	non-removable;
> +	no-sdio;
> +	no-sd;
> +	status = "okay";
> +};
> +
> +&mmc1 {
> +	max-frequency = <198000000>;
> +	bus-width = <4>;
> +	status = "okay";
> +};

Hi Drew,

For the StarFive device tree files we've agreed on sorting by / node, clock
references, and then other node references alphabetically. I'm not
insisting you should do the same, but it would be nice with some system to make
it clear where new node refences should go. Or maybe I'm just not seeing the
system you're already following.

/Emil

>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
