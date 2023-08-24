Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECF5787A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243702AbjHXV3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243708AbjHXV3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:29:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D211BCC;
        Thu, 24 Aug 2023 14:29:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AFCE63F71;
        Thu, 24 Aug 2023 21:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA961C433C7;
        Thu, 24 Aug 2023 21:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692912546;
        bh=Nfn1uNPGA9g+LWHP/3mUozCS5vINoOG8VlgUTdOkQIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XOFbYKVl8IN8F+7YJy7gCUSHtpo5yJrbqew1xj1kBL93Atjr7q7zoOvOU9vSJMUXL
         SBoxuPtt0rIm4RsqefITQ9FWbLWIJQZ78g4v99V5pniwIEV6NOFqnq6DkKpAPfxh03
         J26BuAFBh8WqWGizsJzPG4BaIcUTC12DykdzvB8HhO5QjaVCPyvVZyZn6KpBAZvkqC
         zUVsIB6UFj7oY203HDDhNjsnbsx6qNfXq5Lky6qcF8SDSCrFJ0oXl/cH+aZDlmfgfk
         T9gSBhxJjNhd26mFw0a5gN0ph/bHv1qj9O4A+KGDHuKqirH2M5Gsmrgy61OOCyiXax
         OMo/n/FBYJdug==
Received: (nullmailer pid 1456158 invoked by uid 1000);
        Thu, 24 Aug 2023 21:29:03 -0000
Date:   Thu, 24 Aug 2023 16:29:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?77+8T20=?= Prakash Singh <quic_omprsing@quicinc.com>
Subject: Re: [PATCH v2 1/7] Revert "dt-bindings: crypto: qcom,prng: Add
 SM8450"
Message-ID: <20230824212903.GA1453763-robh@kernel.org>
References: <20230824-topic-sm8550-rng-v2-0-dfcafbb16a3e@linaro.org>
 <20230824-topic-sm8550-rng-v2-1-dfcafbb16a3e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824-topic-sm8550-rng-v2-1-dfcafbb16a3e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 01:33:20PM +0200, Neil Armstrong wrote:
> This reverts commit b9296bb41275 ("dt-bindings: crypto: qcom,prng: Add SM8450"),
> since the RNG HW on the SM8450 SoC is in fact a True Random Number Generator,
> a more appropriate compatible should be instead as reported at [1].
> 
> [1] https://lore.kernel.org/all/20230818161720.3644424-1-quic_omprsing@quicinc.com/
> 
> Suggested-by: ￼Om Prakash Singh <quic_omprsing@quicinc.com>
> Suggested-by: ￼Konrad Dybcio <konrad.dybcio@linaro.org>

Is it just me or looks like an unrenderable character in these.

> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/crypto/qcom,prng.yaml      | 24 +++++-----------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> index 36b0ebd9a44b..bb42f4588b40 100644
> --- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> +++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> @@ -11,13 +11,9 @@ maintainers:
>  
>  properties:
>    compatible:
> -    oneOf:
> -      - enum:
> -          - qcom,prng  # 8916 etc.
> -          - qcom,prng-ee  # 8996 and later using EE
> -      - items:
> -          - const: qcom,sm8450-prng-ee
> -          - const: qcom,prng-ee
> +    enum:
> +      - qcom,prng  # 8916 etc.
> +      - qcom,prng-ee  # 8996 and later using EE
>  
>    reg:
>      maxItems: 1
> @@ -32,18 +28,8 @@ properties:
>  required:
>    - compatible
>    - reg
> -
> -allOf:
> -  - if:
> -      not:
> -        properties:
> -          compatible:
> -            contains:
> -              const: qcom,sm8450-prng-ee
> -    then:
> -      required:
> -        - clocks
> -        - clock-names
> +  - clocks
> +  - clock-names
>  
>  additionalProperties: false
>  
> 
> -- 
> 2.34.1
> 
