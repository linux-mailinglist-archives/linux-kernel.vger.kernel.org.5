Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C0D76764A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbjG1TZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjG1TZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:25:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C447EBF;
        Fri, 28 Jul 2023 12:25:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56947621C6;
        Fri, 28 Jul 2023 19:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B841BC433C8;
        Fri, 28 Jul 2023 19:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690572334;
        bh=qH1nMUGykA7IWroSLrtgzIBQVATyMiX9LOfbhqrxnCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MyekAuRWYrWF8Bfcy8zUZmFKfQkpRfhHg1zBF2knIkchaUQAABmkH6WDpAaOWY9r8
         sbYBm6PmuVC9YSADMFoeaN075qzxBp0919SqFOZHNOouXoZrvtggIZkYDVWr7OrmXC
         OlOqhriyPWjoLNbjM7/RQN41HTo7gJlEctQGbbPG4HOIeNrdvFWrCiwSugVgxs7zY6
         PA6tENOgbrdZadK2w0BAxc1RQaBh5X0xFF8LHwbioUf2BRO0NWV8bgGTGEGBnrELcq
         M+PFLb/DyNjxV4zzlVX5lDnRUwUq8iby/VDEzaRwkfzGv4lz66+0gaAC56PRXOXuO+
         KVv3TdHhcYz5w==
Received: (nullmailer pid 1172453 invoked by uid 1000);
        Fri, 28 Jul 2023 19:25:32 -0000
Date:   Fri, 28 Jul 2023 13:25:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Varshini Rajendran <varshini.rajendran@microchip.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, jerry.ray@microchip.com,
        durai.manickamkr@microchip.com, andrew@lunn.ch,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 49/50] dt-bindings: arm: add sam9x75 curiosity board
Message-ID: <20230728192532.GA1169417-robh@kernel.org>
References: <20230728103106.267793-1-varshini.rajendran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728103106.267793-1-varshini.rajendran@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 04:01:06PM +0530, Varshini Rajendran wrote:
> Add documentation for SAM9X75 Curiosity board.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> index dfb8fd089197..15b11feae46a 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> @@ -99,6 +99,12 @@ properties:
>            - const: microchip,sam9x60
>            - const: atmel,at91sam9
>  
> +      - description: Microchip SAM9X7 Evaluation Boards
> +        items:
> +          - const: microchip,sam9x75-curiosity
> +          - const: microchip,sam9x7
> +          - const: atmel,at91sam9

Has this compatible been useful in prior use? Can s/w make some decision 
based on it? If not, I'd drop it.

Rob
