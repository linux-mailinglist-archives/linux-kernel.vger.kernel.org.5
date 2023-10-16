Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559957CB1ED
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjJPSD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbjJPSD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:03:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481A4EB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:03:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE11C433C9;
        Mon, 16 Oct 2023 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697479405;
        bh=cDqOHBDA5sbY8y5If7BevRuuz2CJcTopzlG8CQRr2AE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jcY1Mg2aUxBHZjp+t2axFYVkPigBmbnkMqlmGGzpE7BagcZmgjaVOPsQdyXhSLPgj
         8MJOGK07bmGeYKXvVWGxW9sPe7m1H1cyZHKRE50A+5DhQxCyhi5SJIf0LdSpbqXaCZ
         xJH5Qhom2DGL9r8fJX0YeNJSoe1IPqGacKpdTG+0=
Date:   Mon, 16 Oct 2023 20:03:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: ti,tps6598x: Disallow undefined
 properties
Message-ID: <2023101616-fantastic-spearman-b1e4@gregkh>
References: <20231016155527.2973385-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016155527.2973385-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 10:55:27AM -0500, Rob Herring wrote:
> Device specific bindings should not allow undefined properties. This is
> accomplished in json-schema with 'additionalProperties: false'. With this,
> the 'connector' child node needs to be defined to prevent warnings.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/usb/ti,tps6598x.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> index 5497a60cddbc..6ab674dea4c6 100644
> --- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> @@ -32,11 +32,14 @@ properties:
>      items:
>        - const: irq
>  
> +  connector:
> +    $ref: /schemas/connector/usb-connector.yaml#
> +
>  required:
>    - compatible
>    - reg
>  
> -additionalProperties: true
> +additionalProperties: false
>  
>  examples:
>    - |
> -- 
> 2.42.0
> 
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
