Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9787745AA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbjHHSov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjHHSoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:44:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6DF155BC;
        Tue,  8 Aug 2023 09:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7F78624A3;
        Tue,  8 Aug 2023 10:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A410EC433C7;
        Tue,  8 Aug 2023 10:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691491356;
        bh=JGo7EBuRfvMkPe2azYS3kN7ld2w91JHGAUkojy0rktE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kS/Q6i3nQ9+WnKOSFTu7PB+OQVPot1K2wUD0sTEvdRrNj4jVLKU4NG5mGsGwk2VSY
         UhUjaaUoswvJqZ/6VjJddcyrwNLSBfB2qmxYgFHInd1f1a4dKiHcyoYRUaq3ht1620
         yk0aYI6UI+bxzZCd7NPIZVIaDk9UrXOQ0xzx51ZO7Kwn1n4Ui3PFnRWslmawb4ZlnD
         6noMzGM+9rOUK1DtPdUAAsZ7JOlfDkdkIgapoyzNv3uO8KmpQ9bFArym8hwrLS6ynr
         T7FFaP8Jg7BJUfNQNa3fc0TS5qoKowHVWTP7c+b1Hw6IEZXXI5F3mpL1x/H4Y4nP/e
         KZXCcq5rUNuXQ==
Message-ID: <e98f134a-a57a-3cbc-3cb1-378d6b411406@kernel.org>
Date:   Tue, 8 Aug 2023 13:42:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/5] dt-bindings: net: Add iep property in ICSSG dt
 binding
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     nm@ti.com, srk@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230807110048.2611456-1-danishanwar@ti.com>
 <20230807110048.2611456-3-danishanwar@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230807110048.2611456-3-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/08/2023 14:00, MD Danish Anwar wrote:
> Add iep node in ICSSG driver dt binding document.

s/iep/IEP here and in subject
s/dt/DT here and in subject

> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> index 8ec30b3eb760..36870238f92f 100644
> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> @@ -52,6 +52,12 @@ properties:
>      description:
>        phandle to MII_RT module's syscon regmap
>  
> +  ti,iep:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    maxItems: 2
> +    description:
> +      phandle to IEP (Industrial Ethernet Peripheral) for ICSSG driver
> +
>    interrupts:
>      maxItems: 2
>      description:
> @@ -155,6 +161,7 @@ examples:
>                      "tx1-0", "tx1-1", "tx1-2", "tx1-3",
>                      "rx0", "rx1";
>          ti,mii-g-rt = <&icssg2_mii_g_rt>;
> +        ti,iep = <&icssg2_iep0>, <&icssg2_iep1>;
>          interrupt-parent = <&icssg2_intc>;
>          interrupts = <24 0 2>, <25 1 3>;
>          interrupt-names = "tx_ts0", "tx_ts1";

-- 
cheers,
-roger
