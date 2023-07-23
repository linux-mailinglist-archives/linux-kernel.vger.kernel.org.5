Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4DE75E0AC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 11:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjGWJTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 05:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGWJTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 05:19:03 -0400
Received: from out-31.mta1.migadu.com (out-31.mta1.migadu.com [IPv6:2001:41d0:203:375::1f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6B81A4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 02:19:00 -0700 (PDT)
Date:   Sun, 23 Jul 2023 19:18:33 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1690103938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IO21JPPuUrj/PlAXDeK+XBpU+sX32D1I5JxlNyZ8yxY=;
        b=mcwgGlOY5K72c1mv4IEZ+ALhpmQdPQLC1UgX47qkA5/+JSNYwpY8Cbd4NhspuL3PWggka9
        +Tp2jHAzGIGtZ+JuagzBwKyIzPP4siFbdcgs9wfpdyem9y9iriwEX2r/aqTGuhjvxzxVc8
        ffa1A5ycZ+NBiAjPiudgTs4V6MapEdVyYxclJ00yN+6eNL1aELb4lfhWFJ1WSBK6Ym3pvX
        iHirF0aGQHxKYK4bD6TTz55DuI0c8aHiu3JIsxqxZyBIlO4uLbCcLECpeLw+D+a9YodbAA
        1kEm/i/2HNZZMAsB1qWQpVcPCfX4wgOS3u0c0vrGCvo+vo7rBRMASZjEesF1ow==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     linux-sunxi@lists.linux.dev
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/4] riscv: dts: allwinner: d1: Add CAN controller
 nodes
Message-ID: <ZLzwaQlS-l_KKpUX@titan>
References: <20230721221552.1973203-2-contact@jookia.org>
 <20230721221552.1973203-4-contact@jookia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721221552.1973203-4-contact@jookia.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 08:15:51AM +1000, John Watts wrote:
> ...
> +			/omit-if-no-ref/
> +			can0_pins: can0-pins {
> +				pins = "PB2", "PB3";
> +				function = "can0";
> +			};
> ...
> +		can0: can@2504000 {
> +			compatible = "allwinner,sun20i-d1-can";
> +			reg = <0x02504000 0x400>;
> +			interrupts = <SOC_PERIPHERAL_IRQ(21) IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_CAN0>;
> +			resets = <&ccu RST_BUS_CAN0>;
> +			status = "disabled";
> +		};

Just a quick late night question to people with more knowledge than me:

These chips only have one pinctrl configuration for can0 and can1. Should the
can nodes have this pre-set instead of the board dts doing this?

I see this happening in sun4i-a10.dtsi for instance, but it also seems like it
could become a problem when it comes to re-using the dtsi for newer chip variants.

John.
