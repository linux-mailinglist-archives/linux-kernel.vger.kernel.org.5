Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193F375E4C7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 22:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjGWUSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 16:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGWUSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 16:18:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CD21A4;
        Sun, 23 Jul 2023 13:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADB5B60E9A;
        Sun, 23 Jul 2023 20:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477A7C433C9;
        Sun, 23 Jul 2023 20:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690143515;
        bh=UzbJUNckFj0UU0O71qcKBXOm+lbgXVVLww2cC1XNb/g=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=XdM/sg/kBGd4BmQPsMeEeNPv9tZ27uYAl/T09MqEEK2mzARrBAFFmL0ZcQ1EQYD49
         +7/c+tdKSeAz7gLCAlfYfcJL+17YGySS4qUKPbPHSu4kB/E2HF1ykOPYEAx0MjSFSY
         GsRf/n3YzXGnq6+E+Fha/mkHCtaNjnhEzJNkO3yZNcLQTshThdrmQPcS5YXg75WjNz
         CcLTPSgSMpwAmrYVYaef1756fDCstmMhP/KseNlB8McRApLpPeH99eFjUjSJOVKKmT
         ZHACjK/u57zsi293DIfn2aaO+URnOM9rRqSC/sPi0A1Tl6EFhMzKgA3VuqG4EY2pOM
         /zx3mQIC0/U4w==
Message-ID: <901936f8-3581-7202-b39e-307526a4fd78@kernel.org>
Date:   Mon, 24 Jul 2023 05:18:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] dt-bindings: extcon: siliconmitus,sm5502-muic:
 document connector
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230720080141.56329-1-krzysztof.kozlowski@linaro.org>
 <20230720080141.56329-2-krzysztof.kozlowski@linaro.org>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20230720080141.56329-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 7. 20. 17:01, Krzysztof Kozlowski wrote:
> Document recently added connector for SM5502 MUIC:
> 
>   qcom/msm8916-samsung-serranove.dtb: extcon@14: 'connector' does not match any of the regexes: 'pinctrl-[0-9]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml  | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml b/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
> index 7a224b2f0977..7ef2d9bef72d 100644
> --- a/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
> +++ b/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
> @@ -27,6 +27,10 @@ properties:
>      description: I2C slave address of the device. Usually 0x25 for SM5502
>        and SM5703, 0x14 for SM5504.
>  
> +  connector:
> +    $ref: /schemas/connector/usb-connector.yaml#
> +    unevaluatedProperties: false
> +
>    interrupts:
>      maxItems: 1
>  

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

