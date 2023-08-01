Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05F176AB3B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjHAIlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjHAIlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:41:14 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB26D10FE;
        Tue,  1 Aug 2023 01:41:07 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9bf52cd08so82445661fa.2;
        Tue, 01 Aug 2023 01:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690879266; x=1691484066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fEDttWqgK0CFKCWb2NcBurYWAnq5TrPHr/6xcJLjutQ=;
        b=JmTFmA/YwVf47WGQzgGNC9Gx2CdqnxgNkk6BJi/OVBNaULhsSmi2x3Jvs7ZplJjAwM
         ypvMQDX5HWHnKwcQ+/XV+dnvaNL+pvtqYjC5KrKANuSkIYgZ9G4Xza0bNQF1hq3+Vcp9
         wcLoiajHTwANqrXpV7M1yZa/+1/WWdIW7gXuW4YAXxBsanf7mPrll6cidJQ0pJ1eMCkD
         W1CEIGvZeEHlcbYNVju3/FKKEC9cqwqJz1hIRrgQZeb7LbSWYV8BeAtNMPg0/YkxPPZ6
         G+ctwUMYFMSx9T6PLHB7HNiY9XTDYB0/4UDlOq42vEhzHc/cUhMXYNsZbwTEY8q/Br5/
         Ah9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690879266; x=1691484066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEDttWqgK0CFKCWb2NcBurYWAnq5TrPHr/6xcJLjutQ=;
        b=RDQi7l2rOND2f2mSKnMRWZdmRjqbGOu2ZAEXZA0hsdS9feodgZuhfCsPaKFNbiS9Qv
         NwhYGTPIdL6h1TgOPhspVeCFdYjwirEyJvWb/znqEMWb3b/3+QijU+cW+1tH6seZl+CR
         vjZrg0KB7Pu+sgSoUAD25tAWF60HiDPo17OIZX/z2h5kJLeAdT/BkCgIUKyj/2I5apc5
         lZxLXc21Zw22IFRJ1QF7KPjGJZWN97pt+FwjiRYYa1aEZYFI+H2Kb2BnVwOGrtM3aoYM
         dyht7N7Ua1HxilmJdPHVbhM6WdaZFMzmTHFpvXzW2KHQmJFqpwtUON6Xk1WkMbR01YMf
         htMg==
X-Gm-Message-State: ABy/qLbQwn6JRKEXUh+e4zLmFwPVOJs9uSwJnK1UhMqNpYvENMq97luy
        mWfLu8eD8Y0lWJw1mT47Ofw/m3pWzMm5qK6efko=
X-Google-Smtp-Source: APBJJlHigaiD/soq+foL/ueHdSCoL9kwM9uOiteOXtMYbntsGWOD4BdKieuCUt+o8fwYXw0uO3/Sy5quE1gVN+fCcDI=
X-Received: by 2002:a2e:8ec3:0:b0:2b6:e12f:267 with SMTP id
 e3-20020a2e8ec3000000b002b6e12f0267mr1845557ljl.5.1690879265602; Tue, 01 Aug
 2023 01:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230727202126.1477515-1-iwona.winiarska@intel.com> <20230727202126.1477515-4-iwona.winiarska@intel.com>
In-Reply-To: <20230727202126.1477515-4-iwona.winiarska@intel.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 1 Aug 2023 11:40:54 +0300
Message-ID: <CAP6Zq1hh_wr81L4vtYDct69rrqdSrxjap9-uZfvmt0xMvrfRJQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] ARM: dts: nuvoton: Add PECI controller node
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Avi Fishman <avifishman70@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Iwona,

I have done r-b, Just could you do a small modification

On Thu, 27 Jul 2023 at 23:23, Iwona Winiarska <iwona.winiarska@intel.com> wrote:
>
> Add PECI controller node with all required information.
>
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> ---
>  arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
> index c7b5ef15b716..cccc33441050 100644
> --- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
> +++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
> @@ -220,6 +220,15 @@ kcs3: kcs3@0 {
>                                 };
>                         };
>
> +                       peci0: peci-controller@f0100000 {
Please modify the peci0 to peci we have only one PECI controller.
> +                               compatible = "nuvoton,npcm750-peci";
> +                               reg = <0xf0100000 0x200>;
> +                               interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +                               clocks = <&clk NPCM7XX_CLK_APB3>;
> +                               cmd-timeout-ms = <1000>;
> +                               status = "disabled";
> +                       };
> +
>                         spi0: spi@200000 {
>                                 compatible = "nuvoton,npcm750-pspi";
>                                 reg = <0x200000 0x1000>;
> --
> 2.40.1
>

Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>

Thanks,

Tomer
