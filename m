Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2839778525C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjHWIKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbjHWIHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:07:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFECFCD0;
        Wed, 23 Aug 2023 01:07:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 614606169A;
        Wed, 23 Aug 2023 08:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40C4C433C9;
        Wed, 23 Aug 2023 08:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692778055;
        bh=DKUQM41foKKTMLclFZMHgMlMQ0+CfODASqrhcrxiLiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BUi5xHQMkD9wnMF3HYgny1D6ePPp0QYGCYJUAY0oBlMh6TOilSPip8ly62ehruXSZ
         4JVR/5iqGCK4epW9hY/kWoQYPr7fS4cai8T7I92LHPIvm6I0tX1zcMAF8OEogT0mjQ
         usVMxItxedLpST1dG7KNLATFlGNNiwThsYd9EVxtMpKWB1TMXw5k0RFgO6Y/oMgJfB
         ZFqkGShwGhKi0KIlfys9Iyt94+dEdPuuhCgPqX2QuZ/h4vYItGFLeG98XCIZKPIITm
         6NmE6ZJJ3nnXx/4rZ+ZMyEaqfOrkD3VLIYh0GQfnUXFzTAnYEyy+8Vc6tMj7i/DMZT
         /W6HgPrSclgTQ==
Date:   Wed, 23 Aug 2023 13:37:18 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: qcom-hw: add a 4th frequency
 domain
Message-ID: <20230823080718.GJ3737@thinkpad>
References: <20230821-topic-sm8x50-upstream-cpufreq-4-domains-v1-0-2d4d9fc828d8@linaro.org>
 <20230821-topic-sm8x50-upstream-cpufreq-4-domains-v1-1-2d4d9fc828d8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230821-topic-sm8x50-upstream-cpufreq-4-domains-v1-1-2d4d9fc828d8@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 09:39:13AM +0200, Neil Armstrong wrote:
> On new platforms, a 4th frequency domain is used, document it.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

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
>  
>    '#freq-domain-cells':
>      const: 1
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
