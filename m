Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1ABC79D531
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjILPmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjILPmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:42:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA50710DE;
        Tue, 12 Sep 2023 08:42:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134D2C433C7;
        Tue, 12 Sep 2023 15:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694533363;
        bh=A9IHpP6N316XfcpL5X56A92IaXw42P2If+Z8SUyUWI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3BrWE/7RbfM1QWdm8ZFo2E/rhhf/ftEQCSvzgrUU15e4Ly0NWaWQRogxrkeiGicS
         CqhUOYHptTl+2V28epsDtyRwDLuLQ3I5bIxofPXOh376f6lWenJmazIEHdwZn2XRoq
         C+614udDKn5KhmW96reganCO7bT++uvdkjKU/no24EUNsfc8yX+juJCFZ1RigXQOuy
         ieSZ/PfKWmkMt/39ne26y7JonMfxcv+oJDemareMcSugualICdMOf4f/6S45dfdKFZ
         qN9hHMTx78zki2XczUY8Zj4deB6p8rC13WBXGDVGCmK54nbCQT8M49vQ+01FMZxfJY
         wFk5Q499efOng==
Received: (nullmailer pid 842293 invoked by uid 1000);
        Tue, 12 Sep 2023 15:42:39 -0000
Date:   Tue, 12 Sep 2023 10:42:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     ilia.lin@kernel.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, rafael@kernel.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: opp: opp-v2-kryo-cpu: Document named
 opp-microvolt property
Message-ID: <20230912154239.GA833216-robh@kernel.org>
References: <20230909165739.1036263-1-robimarko@gmail.com>
 <20230909165739.1036263-2-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230909165739.1036263-2-robimarko@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 06:56:01PM +0200, Robert Marko wrote:
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
>  .../bindings/opp/opp-v2-kryo-cpu.yaml         | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> index bbbad31ae4ca..6f216306a7eb 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> @@ -63,6 +63,12 @@ patternProperties:
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
> @@ -71,6 +77,24 @@ patternProperties:
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
> +          in the efuse for the speed and the pvs.

What is "pvs"?

> +
> +          The qcom-cpufreq-nvmem driver will read all these values
> +          and assign the correct named property.

Specific driver details don't belong in binding. If there's some detail 
or requirement of all consumers, then that is fine here.

> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix

The common binding already defines the type. Drop.

> +        minItems: 1
> +        maxItems: 8   # Should be enough regulators

Does this really vary from 1 to 8 entries? Looks like copy-n-paste.

> +        items:
> +          minItems: 1
> +          maxItems: 3

Do you really need to support both single voltage and <nom min max> 
forms?

Rob
