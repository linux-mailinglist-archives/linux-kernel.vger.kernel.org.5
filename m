Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A667B5AFC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238593AbjJBTID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238508AbjJBTIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:08:02 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D83FB8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 12:07:57 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59f6492b415so717147b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696273676; x=1696878476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rmc9UhseFksEdDITv3F/3jm8YMdDBWzzJohJtnGnXjU=;
        b=nfmCxh2FEdtHYX7N1jXciR3+YrofZjoj1wcurWy7QPOCc/vGjWtizEDpCMAVk6u9zx
         xXB0Dmm6DdSkUQqDf6syedKoY/ny67yV3EarD9WAkHZVYkyWkje9Vl24TAaEiwkRAlxI
         EyegEu9rAbE0do9LPjL8gGWm39yLeD/gDq3V0EDXG9wbmZvGsH8q7bXFhA4Xp5ivQrEr
         ZZLgnoPGJrneXZXP9TdLAy5VxNthm89x7zAyZuKImS90OXTOH07K9MT7mLmEEVJeYzCk
         KxbHhpSxRvlqtX0haW8kuW/3yqVz9YtEbMuwXaEKRbv96apgymBZMHYnoCSeLwX0EVNl
         kaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696273676; x=1696878476;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmc9UhseFksEdDITv3F/3jm8YMdDBWzzJohJtnGnXjU=;
        b=ZQkFhQvEXV/L6yrmTqKurZgbeiLVcfHFc0guI9rYox5/puzCDNnEVzRuuh4vkz2a5N
         qDkSa9Bg64m/P8qVc2TK36XvJSfVkHRnFSkR6VCF6wHxrIV1iqdZ7hqWWaD/QKHVktbN
         4qwupA79aBR8PGODs0MGajue4aM3ZeVx5jkkLSPGn4EYWpoGNacvJkWXnVvfyP9wObxu
         tT45NMHxpLa7HhYiN+L3DNdAtA49l9hbcVX9HGFMCNpnbO9AIOatdwveeySn2kArcFSR
         QETIkhXcW0QcCzv0gVKxlDQFbKVPEEA3Hn7J5ZsFANM+Uqf5XD6KbkpbPZL72jk2EjQL
         TSQg==
X-Gm-Message-State: AOJu0YwuQcOeqhn7w+Ygw3UeRJ8HgjGZDPDkqMngDOp7AtjTzNyfbepr
        IaSCBs0G4ytFuy53DvNqeacRflL/+rTvZ0+ibeialg==
X-Google-Smtp-Source: AGHT+IE1JrIrY1n+TmWeXAPMMw9OHXqDFx4xwDPDYnC7lMVlyFIt2/ecPox6VXkrkjGpSF10v4GOksD6+fFpl7t6pjk=
X-Received: by 2002:a0d:db0d:0:b0:589:f9c3:8b2e with SMTP id
 d13-20020a0ddb0d000000b00589f9c38b2emr397493ywe.20.1696273676349; Mon, 02 Oct
 2023 12:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230930102218.229613-1-robimarko@gmail.com> <20230930102218.229613-2-robimarko@gmail.com>
In-Reply-To: <20230930102218.229613-2-robimarko@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 2 Oct 2023 22:07:44 +0300
Message-ID: <CAA8EJpoTsHhAVT3b84BC7Brvh=AUOUYSB_Z+_R-9OQ-u9BpH8A@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] dt-bindings: opp: opp-v2-kryo-cpu: Document named
 opp-microvolt property
To:     Robert Marko <robimarko@gmail.com>
Cc:     ilia.lin@kernel.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sept 2023 at 13:22, Robert Marko <robimarko@gmail.com> wrote:
>
> From: Christian Marangi <ansuelsmth@gmail.com>
>
> Document named opp-microvolt property for opp-v2-kryo-cpu schema.
> This property is used to declare multiple voltage ranges selected on the
> different values read from efuses. The selection is done based on the
> speed pvs values and the named opp-microvolt property is selected by the
> qcom-cpufreq-nvmem driver.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes v5:
> * Fix typo in opp items
>
> Changes v4:
> * Address comments from Rob (meaning of pvs, drop of
>   driver specific info, drop of legacy single voltage OPP,
>   better specify max regulators supported)
>
>  .../bindings/opp/opp-v2-kryo-cpu.yaml         | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> index 27ea7eca73e5..8d2a47e9a854 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> @@ -65,6 +65,12 @@ patternProperties:
>            5:  MSM8996SG, speedbin 1
>            6:  MSM8996SG, speedbin 2
>            7-31:  unused
> +
> +          Bitmap for IPQ806X SoC:
> +          0:  IPQ8062
> +          1:  IPQ8064/IPQ8066/IPQ8068
> +          2:  IPQ8065/IPQ8069
> +          3-31:  unused
>          enum: [0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
>                 0x9, 0xd, 0xe, 0xf,
>                 0x10, 0x20, 0x30, 0x70]
> @@ -73,6 +79,23 @@ patternProperties:
>
>        required-opps: true
>
> +    patternProperties:
> +      '^opp-microvolt-speed[0-9]+-pvs[0-9]+$':
> +        description: |
> +          Named opp-microvolt property following the same generic
> +          binding for named opp-microvolt.
> +
> +          The correct voltage range is selected based on the values
> +          in the efuse for the speed and the pvs (power variable
> +          scaling).

I suppose that simple 'true' schema should be enough since this is
already mostly described in opp/opp-v2-base.yaml

> +        minItems: 1
> +        maxItems: 4 # Up to 4 regulators: Core, Mem, Dig and HFPLL
> +        items:
> +          items:
> +            - description: nominal voltage
> +            - description: minimum voltage
> +            - description: maximum voltage
> +
>      required:
>        - opp-hz
>
> @@ -258,6 +281,22 @@ examples:
>              };
>          };
>
> +        /* Dummy opp table to give example for named opp-microvolt */
> +        opp-table-2 {
> +            compatible = "operating-points-v2-kryo-cpu";
> +            nvmem-cells = <&speedbin_efuse>;
> +
> +            opp-384000000 {
> +                opp-hz = /bits/ 64 <384000000>;
> +                opp-microvolt-speed0-pvs0 = <1000000 950000 1050000>;
> +                opp-microvolt-speed0-pvs1 = <925000 878750 971250>;
> +                opp-microvolt-speed0-pvs2 = <875000 831250 918750>;
> +                opp-microvolt-speed0-pvs3 = <800000 760000 840000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <100000>;
> +            };
> +        };
> +
>          smem {
>              compatible = "qcom,smem";
>              memory-region = <&smem_mem>;
> --
> 2.41.0
>


-- 
With best wishes
Dmitry
