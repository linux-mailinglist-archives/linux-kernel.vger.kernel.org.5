Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511F07CB273
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjJPSYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbjJPSYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:24:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CA2F1;
        Mon, 16 Oct 2023 11:24:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BC8C433C7;
        Mon, 16 Oct 2023 18:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697480648;
        bh=GBLmmoSGCW+tXYLIivo4TbRnr1P9ngnwrM2YJKL/bTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NY/8pAvpcvypSxypkIyxpEKPZ2SjHbhFGQ7w8hgRGa6P7HMv4guIeH3axU4oXf32l
         d8/Y4VDpRmoSxbEOwlETjLdRsI4p19cYlw5bkkdz8Znp8B7YZ4/2SDvaTaEvfeQVyM
         IbJz56sAcc5WwG6WSwpAvdWiZM5OEY5NQztADQAwjiCOh3F3PvAVB9aqNH4kycx2fS
         sH0ZlX6VXq7PkCm9SJWkAEaVEmT+NaBSNHiGr6V6wV5jUtysv3vt0GQkQJjiqsJpt+
         bcIj7Mp3upbMBI8s7K/b25pGompYe/FBdN03b4M22Er6sLHlmkWBgD1uq1Dd5bbGYS
         H6lOV1MRqhn0g==
Date:   Mon, 16 Oct 2023 11:27:55 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Om Prakash Singh <quic_omprsing@quicinc.com>
Cc:     neil.armstrong@linaro.org, konrad.dybcio@linaro.org,
        agross@kernel.org, conor+dt@kernel.org, davem@davemloft.net,
        devicetree@vger.kernel.org, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        marijn.suijten@somainline.org, robh+dt@kernel.org, vkoul@kernel.org
Subject: Re: [PATCH V2] dt-bindings: crypto: qcom,prng: document SA8775P and
 SC7280
Message-ID: <gud3cwxig4plnayez3guchyx27thi722gcl6bvdzvv23p3y3av@37kyt5nmx6sg>
References: <20231016143428.2992168-1-quic_omprsing@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016143428.2992168-1-quic_omprsing@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 08:04:28PM +0530, Om Prakash Singh wrote:
> Document SA8775P and SC7280 compatible for the True Random Number
> Generator.
> 
> Signed-off-by: Om Prakash Singh <quic_omprsing@quicinc.com>

Thanks for the quick update, Om.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
> 
> Changes in V2:
>   - Squashed two separate patches for SA8775P and SC7280 in one.
>   - Sort entries in alphabetic order.
> 
>  Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> index 633993f801c6..13070db0f70c 100644
> --- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> +++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> @@ -17,6 +17,8 @@ properties:
>            - qcom,prng-ee  # 8996 and later using EE
>        - items:
>            - enum:
> +              - qcom,sa8775p-trng
> +              - qcom,sc7280-trng
>                - qcom,sm8450-trng
>                - qcom,sm8550-trng
>            - const: qcom,trng
> -- 
> 2.25.1
> 
