Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619F478BA65
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjH1Vgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbjH1VgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:36:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9255218F;
        Mon, 28 Aug 2023 14:36:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CB1D61707;
        Mon, 28 Aug 2023 21:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCBEC433C8;
        Mon, 28 Aug 2023 21:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693258572;
        bh=oaay4dQ7Zg/xyNCBkGcO+PhVLgjzFow8Anit155lPiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nXZFrcM3dG7KiY/4NA1Yu8lwwME4Lhx25oosoWagBjRSLW8jftDNCmJx+6HY1LKoE
         6F3Opo1GyjLs5NV+qwMhQO9CvfCZuEBcoyjGA3vQnuwq4Fgz1N25NtW1NqQZHoAjhH
         jHqF8k+wdwtsGTTVayIi9QT9qNy+QP6Qhmq6JJ3nnQ46c3Hw5YO/VLsIRv+POE4D9s
         Np0gFLoADeknEOFmFummuxjaVWL2xQYOUFcsbNZxmpcEUw1USPcFw8XOXZLG1eHZG0
         quMKfHBM1O80+UsYDsyAW6XB+3qL5UfNQ4si9Aqg5+qG/hRjDqfPlnQeTK4xF44TbF
         TWoNw/pRwMRFw==
Received: (nullmailer pid 387503 invoked by uid 1000);
        Mon, 28 Aug 2023 21:36:10 -0000
Date:   Mon, 28 Aug 2023 16:36:10 -0500
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
        Om Prakash Singh <quic_omprsing@quicinc.com>
Subject: Re: [PATCH v3 4/6] dt-bindings: crypto: qcom,prng: document SM8550
Message-ID: <20230828213610.GA386486-robh@kernel.org>
References: <20230828-topic-sm8550-rng-v3-0-7a0678ca7988@linaro.org>
 <20230828-topic-sm8550-rng-v3-4-7a0678ca7988@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828-topic-sm8550-rng-v3-4-7a0678ca7988@linaro.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:04:39AM +0200, Neil Armstrong wrote:
> Document SM8550 compatible for the True Random Number Generator.
> 
> Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Where's Krzysztof's tag?

> ---
>  Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> index 4245c9e424a3..633993f801c6 100644
> --- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> +++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> @@ -16,7 +16,9 @@ properties:
>            - qcom,prng  # 8916 etc.
>            - qcom,prng-ee  # 8996 and later using EE
>        - items:
> -          - const: qcom,sm8450-trng
> +          - enum:
> +              - qcom,sm8450-trng
> +              - qcom,sm8550-trng
>            - const: qcom,trng
>  
>    reg:
> 
> -- 
> 2.34.1
> 
