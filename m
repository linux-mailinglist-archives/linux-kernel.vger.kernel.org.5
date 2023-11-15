Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38827EC7F0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjKOPxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjKOPwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:52:55 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8AF1BF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:52:13 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d852b28ec3bso7508188276.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700063532; x=1700668332; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nl/GtZGBvIjYyrU77SaU/zaNCPsUzyakCfkfS5CUVyA=;
        b=mgQMnBQY8XCSvfOMvEzz1WpA4gb31gkqX9UN5ACLdCIrAuYGeAsWEyJdYM9yY1bV9Y
         kGFjDH+uJV9wcBpHvFZbuvUW825vS1P6mwhbHtqF0Y1+q0pDtH/lvlyC2plHYWbJXKZb
         TRcKbRH0JArMiGvBgZgl5y5Rdo8JQWIf21S3Y2jVpBCqRumY1kHfdgOKlLtf2fs3csvC
         SNrF1BRs1By38/SH8iFSY4AjdLLHm3zTtyiTaXe0lZ4o45BPlSZJXoCD7/obQHGlswfv
         qDldQ1Gl2eV66DPVZZsB0fpPAdrLP+WIMUS/dhPdbyQjK1i6VpcajoJeOLTg1+iUJOAl
         Lbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700063532; x=1700668332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nl/GtZGBvIjYyrU77SaU/zaNCPsUzyakCfkfS5CUVyA=;
        b=UoNqK2xKxxSQ/18+AgwbvNGfyynMR3c59IA+KIj9LdA9t5nqohCc91zx5H0QaehZzm
         /i4qT0XUc1pF+ml8WK8g6ngbWR7xAr1gEuNlqVYVunfQu87lu7VkCdWZPPIY7eVqL5s0
         kb49bc1ekXq/OD94Yj2+E9LQ71m1DEdJsYFCnHoBiYZxqot66C6MtFEIGSCWrp+pYjzG
         0wsLLwe4/Weamtx2wIpWIgfVAqcEtVLe9I8a8lHZl6ze9RbUGpBVr6AXtH0FfQRwtNYR
         K2UpCblGFL161gPULe27KsD2lAraJGfR9rBoC2kNbMUv5Iln3TLXOblgXbc7/pqN6En/
         jBCQ==
X-Gm-Message-State: AOJu0Yw62zpjVMU83ZGpjkZhMBAFbkAt8gm8YYqNvBqBvahPGUKCzZap
        SCqkoIUp31uOpXxS5bybwH6oxmsyEUeYbqOR/pk31g==
X-Google-Smtp-Source: AGHT+IEzfN02zXNZYe7wq1LQwxLuhPnJTlfkFfYCvhwqktqFDoyH/tvLX++NG+ov0may+Csq2S4ITU78lW8TCEox/TQ=
X-Received: by 2002:a25:d843:0:b0:daf:5375:52fe with SMTP id
 p64-20020a25d843000000b00daf537552femr13117763ybg.6.1700063532606; Wed, 15
 Nov 2023 07:52:12 -0800 (PST)
MIME-Version: 1.0
References: <20231114102321.1147951-1-sai.krishna.potthuri@amd.com>
In-Reply-To: <20231114102321.1147951-1-sai.krishna.potthuri@amd.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Nov 2023 16:51:37 +0100
Message-ID: <CAPDyKFpVwKK=fj5c5xTCkVKk3WgpH89ZP1OSdUK72XEXGbkYuA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: arasan,sdci: Add gate property for
 Xilinx platforms
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, git@amd.com, saikrishna12468@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 at 11:23, Sai Krishna Potthuri
<sai.krishna.potthuri@amd.com> wrote:
>
> From: Swati Agarwal <swati.agarwal@amd.com>
>
> Add gate property in example node for Xilinx platforms which will be used
> to ungate the DLL clock. DLL clock is required for higher frequencies like
> 50MHz, 100MHz and 200MHz.
> DLL clock is automatically selected by the SD controller when the SD
> output clock frequency is more than 25 MHz.
>
> Signed-off-by: Swati Agarwal <swati.agarwal@amd.com>
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Note: This patch only updates the example nodes with the gate property for
> Xilinx platforms.
>
> Changes in v2:
> - Updated subject prefix to match with the subsystem.
>
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> index 3e99801f77d2..9075add020bf 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> @@ -226,8 +226,8 @@ examples:
>            interrupt-parent = <&gic>;
>            interrupts = <0 48 4>;
>            reg = <0xff160000 0x1000>;
> -          clocks = <&clk200>, <&clk200>;
> -          clock-names = "clk_xin", "clk_ahb";
> +          clocks = <&clk200>, <&clk200>, <&clk1200>;
> +          clock-names = "clk_xin", "clk_ahb", "gate";
>            clock-output-names = "clk_out_sd0", "clk_in_sd0";
>            #clock-cells = <1>;
>            clk-phase-sd-hs = <63>, <72>;
> @@ -239,8 +239,8 @@ examples:
>            interrupt-parent = <&gic>;
>            interrupts = <0 126 4>;
>            reg = <0xf1040000 0x10000>;
> -          clocks = <&clk200>, <&clk200>;
> -          clock-names = "clk_xin", "clk_ahb";
> +          clocks = <&clk200>, <&clk200>, <&clk1200>;
> +          clock-names = "clk_xin", "clk_ahb", "gate";
>            clock-output-names = "clk_out_sd0", "clk_in_sd0";
>            #clock-cells = <1>;
>            clk-phase-sd-hs = <132>, <60>;
> --
> 2.25.1
>
