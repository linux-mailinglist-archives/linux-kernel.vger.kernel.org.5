Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63649799C05
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 01:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345243AbjIIXXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 19:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345126AbjIIXXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 19:23:48 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6F319F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 16:23:44 -0700 (PDT)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0669A3F640
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 23:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694301823;
        bh=g38mnsqH2vU/74bmC9caLvWkHP+AyVA0JTu2qX2Y3fc=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Sy4cnsrk55+5F31kzQ6FhxWUB3RSbeTHxpqKVHZsMhrHLkqPblIUoYsYWZohzTbjD
         hgdbCZxhqYk/1bfp/rJanwvFKJoVxuW9rN3GIu43bPOvuD4SOC24mR/xH361oE5u36
         TFMn4Z1gQi+lRZdxH6WD7S9gOGxgeD0Z6QIkJDnl7pRmaJ3c146jsoIrqeUYaZyzJv
         tC2i9Npy8QC6xR02jujv+ZEvx/yjG9YfUGZnXq93TJdRYtdwYp14YOXLHqrXpUiiRg
         y/3A1UlFJfYxMcJZZDNkeznqfymDuyokB6qGfZC6F15pyKVJRME4FjbIjMVnLGaHpE
         Ai8ss4mNtXRzA==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41362ffd32aso38254481cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 16:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694301821; x=1694906621;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g38mnsqH2vU/74bmC9caLvWkHP+AyVA0JTu2qX2Y3fc=;
        b=cxZ5e50qQ0PoFIbuvx8Axe0bpU6wvY5SFRXiKKLqcMBC4uRUF42lbiiJHD77TYjogc
         0uvcCm05wOWk+PapmWO+7AKav/b4MiqHTtptVTjOTtYEYb863N1cz66iQnAMYTpAYjy7
         Gjl7bfpsKqcFILg9xMkIaKlsCVF+5o+V3QtJFeUtcOmFoWkLlVqao7w0tMHNZtSjGwxC
         QrvNt+i59PdDjD+A9ilrTpAI4/P3aJ14uXEBJjW75VikJ4oc0vVGHv5uqOvLXskVFHJT
         9askP8iYHYNA3x1PG1T8oLxveCqxQ8b930cmh6OHihbpy7z95vvcnuphcVlubHnBa7kN
         sWYw==
X-Gm-Message-State: AOJu0Yxk3g8hl8d+GO6CJZ7QZDaMiVlzTM5b9gZxfewnNg+fYq99PZoL
        eaX/W1MVjR4pMwor/xHLW6R9RcgSSPrAQTQQKXFvGbdEQSvJe889F8aTUG18mZPPYv9oWAQnTxl
        Ft2pyy4R3nbN9gU4GPTY1rsfVx/0Zg0OiU32drjwcS+sd5uAfgfmYghF8yg==
X-Received: by 2002:ac8:5fd1:0:b0:403:3583:68eb with SMTP id k17-20020ac85fd1000000b00403358368ebmr8328322qta.19.1694301821760;
        Sat, 09 Sep 2023 16:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEligNCMo7eGYPMSQx5GN7uRZvx7+f7h9gFSFY5WF33IvudVpZLJQrGFnyPQi+7GeUnGV3ayeuhZMSG/0dtB0o=
X-Received: by 2002:ac8:5fd1:0:b0:403:3583:68eb with SMTP id
 k17-20020ac85fd1000000b00403358368ebmr8328310qta.19.1694301821519; Sat, 09
 Sep 2023 16:23:41 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 9 Sep 2023 16:23:41 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20230907053742.250444-4-xingyu.wu@starfivetech.com>
References: <20230907053742.250444-1-xingyu.wu@starfivetech.com> <20230907053742.250444-4-xingyu.wu@starfivetech.com>
Mime-Version: 1.0
Date:   Sat, 9 Sep 2023 16:23:41 -0700
Message-ID: <CAJM55Z9VkLLN9y=1ZBb7g+23vWomgJHKpGe0o9sSv0UEQsdJRg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] riscv: dts: jh7110: starfive: Add timer node
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Walker Chen <walker.chen@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xingyu Wu wrote:
> Add the timer node for the Starfive JH7110 SoC.
>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> Reviewed-by: Walker Chen <walker.chen@starfivetech.com>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index ec2e70011a73..84bb9717be13 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -502,6 +502,26 @@ sysgpio: pinctrl@13040000 {
>  			#gpio-cells = <2>;
>  		};
>
> +		timer@13050000 {
> +			compatible = "starfive,jh7110-timer";
> +			reg = <0x0 0x13050000 0x0 0x10000>;
> +			interrupts = <69>, <70>, <71> ,<72>;
> +			clocks = <&syscrg JH7110_SYSCLK_TIMER_APB>,
> +				 <&syscrg JH7110_SYSCLK_TIMER0>,
> +				 <&syscrg JH7110_SYSCLK_TIMER1>,
> +				 <&syscrg JH7110_SYSCLK_TIMER2>,
> +				 <&syscrg JH7110_SYSCLK_TIMER3>;
> +			clock-names = "apb", "ch0", "ch1",
> +				      "ch2", "ch3";
> +			resets = <&syscrg JH7110_SYSRST_TIMER_APB>,
> +				 <&syscrg JH7110_SYSRST_TIMER0>,
> +				 <&syscrg JH7110_SYSRST_TIMER1>,
> +				 <&syscrg JH7110_SYSRST_TIMER2>,
> +				 <&syscrg JH7110_SYSRST_TIMER3>;
> +			reset-names = "apb", "ch0", "ch1",
> +				      "ch2", "ch3";
> +		};
> +
>  		watchdog@13070000 {
>  			compatible = "starfive,jh7110-wdt";
>  			reg = <0x0 0x13070000 0x0 0x10000>;
> --
> 2.25.1
>
