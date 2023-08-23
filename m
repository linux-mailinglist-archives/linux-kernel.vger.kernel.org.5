Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3392D7858F9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbjHWNSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbjHWNSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:18:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A967610DA;
        Wed, 23 Aug 2023 06:17:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 579F1623F1;
        Wed, 23 Aug 2023 13:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AE7C433CA;
        Wed, 23 Aug 2023 13:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692796605;
        bh=4jpQ82SurpTqv5hqqyer8JNbZbU4RFFtxP8IYYNAfHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e1dlSrcy55V9O0ORBtS6WDFQC3dXEa8+doy+S6NRYo7q/VHxtxa3zeXx4cSneBazt
         NH1fa1IXOvsQl/6JaiJMvaoGf9rhxX82eJk043ZRkv4jUBLDYRsBvM5mJOtubAmIIT
         XwWbEM17PyM+ix5IGZTnOuhLy/RcCVgZJAq0dVU+dbWqRQteIwPvR7GI2WHxpimsJ4
         jH69yXvQ1ofZ2kxR1H+uvcMiKJ5XPoFZUD7rPt92b2h7Ux7mmhtxRLHh/Z3fDoEyZe
         9fB+jd6X+jQskbPeDbscnhhteiyEgKK7jDqoxnUoeF5tXXdJ28Vr01ysGKK51eE3M7
         O6pGxXIjZJWNw==
Received: (nullmailer pid 2180656 invoked by uid 1000);
        Wed, 23 Aug 2023 13:16:43 -0000
Date:   Wed, 23 Aug 2023 08:16:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: qcom-hw: add a 4th frequency
 domain
Message-ID: <20230823131643.GA2164592-robh@kernel.org>
References: <20230821-topic-sm8x50-upstream-cpufreq-4-domains-v1-0-2d4d9fc828d8@linaro.org>
 <20230821-topic-sm8x50-upstream-cpufreq-4-domains-v1-1-2d4d9fc828d8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821-topic-sm8x50-upstream-cpufreq-4-domains-v1-1-2d4d9fc828d8@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 09:39:13AM +0200, Neil Armstrong wrote:
> On new platforms, a 4th frequency domain is used, document it.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> index a6b3bb8fdf33..c1d225fcf2d5 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -49,6 +49,7 @@ properties:
>        - description: Frequency domain 0 register region
>        - description: Frequency domain 1 register region
>        - description: Frequency domain 2 register region
> +      - description: Frequency domain 3 register region
>  
>    reg-names:
>      minItems: 1
> @@ -56,6 +57,7 @@ properties:
>        - const: freq-domain0
>        - const: freq-domain1
>        - const: freq-domain2
> +      - const: freq-domain3
>  
>    clocks:
>      items:
> @@ -69,7 +71,7 @@ properties:
>  
>    interrupts:
>      minItems: 1
> -    maxItems: 3
> +    maxItems: 4
>  
>    interrupt-names:
>      minItems: 1
> @@ -77,6 +79,7 @@ properties:
>        - const: dcvsh-irq-0
>        - const: dcvsh-irq-1
>        - const: dcvsh-irq-2
> +      - const: dcvsh-irq-3

Truly useless names with foo<index>...

Acked-by: Rob Herring <robh@kernel.org>
