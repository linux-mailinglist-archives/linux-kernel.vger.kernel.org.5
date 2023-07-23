Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB12975E4C4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 22:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjGWUPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 16:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGWUPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 16:15:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C50124;
        Sun, 23 Jul 2023 13:15:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48CB760E97;
        Sun, 23 Jul 2023 20:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAE6C433C7;
        Sun, 23 Jul 2023 20:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690143302;
        bh=BxZaHURXwkjPGFxPvzAMNYtUqkgw4GCOxzt/zMOvrHg=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Chc4V5NHaMHQ+UI/tPi52BqdBNGm5Oony2YwjwpAYYlSES/xfnpBH/IJ64njyoK61
         SvfSG1XrolnkUW/f8czNgvdIUCDJStjzoKGQkgmHS5odTKBc51gl+nsVxjgeTIT/Ei
         26E+IY9DiXNhMXO3uecikn/sWK4Bk7YL+rguBeoyCQZ0IxGQX4M59OaqS5s1WU1chS
         c/NXNA1V8kgHzYeBb0ADZXGF3F9njRT3QLGaVfEYRO5VyWv0S8Nqzj82Rm8npN9qoH
         InM7QA6nrkBfKBrFvCjA2e8OuujsIDdFIVqxvU1IuSWrdnEUVXEI0fa0RnGOqjKaAw
         Sn1JynIKrjqnA==
Message-ID: <5bd268c7-96eb-26b3-7c9c-7e43fbfd729e@kernel.org>
Date:   Mon, 24 Jul 2023 05:14:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: extcon: maxim,max77843: restrict
 connector properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230720080141.56329-1-krzysztof.kozlowski@linaro.org>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20230720080141.56329-1-krzysztof.kozlowski@linaro.org>
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
> Do not allow any other properties in connector child, except what
> usb-connector.yaml evaluates.
> 
> Fixes: 9729cad0278b ("dt-bindings: extcon: maxim,max77843: Add MAX77843 bindings")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/extcon/maxim,max77843.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml b/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
> index 128960545640..55800fb0221d 100644
> --- a/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
> +++ b/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
> @@ -23,6 +23,7 @@ properties:
>  
>    connector:
>      $ref: /schemas/connector/usb-connector.yaml#
> +    unevaluatedProperties: false
>  
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports

Applied it. Thanks.
-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

