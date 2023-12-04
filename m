Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75615803F0B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbjLDUKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjLDUKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:10:35 -0500
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60780CD;
        Mon,  4 Dec 2023 12:10:41 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1701720639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WaBKyZYjaJtgWFGIGCrbCOxg1wbzLZEM0lX/acM3Eu4=;
        b=NyimGtKF40X/eyneyQwjvGAfs8vHIL9DGnFCDfkXzfMZrxGpjI8gtBwkgZMwwNFUiSHPDM
        UrdaTLTKzN462kra74wKYVdGu5ZwJctWbKiRdNoZUtiiBYGf1hv7QmrEy22stV3R502y+u
        OU+Dh39brqo9Nfy5XPDyObLfBKVbz+e8eLy9PTRaHQBJ++cnnV4GZBBptnpR7uM0YHDnFT
        G7d6ZvvuUlRhuk9ZVySAs/ZB4QUgmiEXk+tE6RziliHj5MdTnm2NkHklljo+GUvWWB8DVD
        uwaGhJ8NZY98CoNHjuumC6AC3YRU9pFXJJRtH6Fg4J4qZoPFPrgRktFYXGNcGg==
Date:   Mon, 04 Dec 2023 21:10:39 +0100
From:   Dragan Simic <dsimic@manjaro.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jay.xu@rock-chips.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] arm64: dts: rockchip: add gpio alias for gpio dt
 nodes
In-Reply-To: <56daeead-1d35-44bb-00c0-614b84a986de@gmail.com>
References: <89f2a229-9f14-d43f-c53d-5d4688e70456@gmail.com>
 <56daeead-1d35-44bb-00c0-614b84a986de@gmail.com>
Message-ID: <87fcf1ed7d10c879bb0c8aa44f004dd5@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-02 19:22, Johan Jonker wrote:
> Rockchip SoC TRM, SoC datasheet and board schematics always refer to
> the same gpio numbers - even if not all are used for a specific board.
> In order to not have to re-define them for every board add the
> aliases to SoC dtsi files.
> 
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  arch/arm64/boot/dts/rockchip/rk3308.dtsi | 5 +++++
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 4 ++++
>  arch/arm64/boot/dts/rockchip/rk3368.dtsi | 4 ++++
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 5 +++++
>  4 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> index 2ae4bb7d5e62..cfc0a87b5195 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> @@ -20,6 +20,11 @@ / {
>  	#size-cells = <2>;
> 
>  	aliases {
> +		gpio0 = &gpio0;
> +		gpio1 = &gpio1;
> +		gpio2 = &gpio2;
> +		gpio3 = &gpio3;
> +		gpio4 = &gpio4;
>  		i2c0 = &i2c0;
>  		i2c1 = &i2c1;
>  		i2c2 = &i2c2;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index e18f7c1c0724..76ea18bf11a0 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -20,6 +20,10 @@ / {
>  	#size-cells = <2>;
> 
>  	aliases {
> +		gpio0 = &gpio0;
> +		gpio1 = &gpio1;
> +		gpio2 = &gpio2;
> +		gpio3 = &gpio3;
>  		serial0 = &uart0;
>  		serial1 = &uart1;
>  		serial2 = &uart2;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> index a4c5aaf1f457..fc7e3f2bc786 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> @@ -20,6 +20,10 @@ / {
> 
>  	aliases {
>  		ethernet0 = &gmac;
> +		gpio0 = &gpio0;
> +		gpio1 = &gpio1;
> +		gpio2 = &gpio2;
> +		gpio3 = &gpio3;
>  		i2c0 = &i2c0;
>  		i2c1 = &i2c1;
>  		i2c2 = &i2c2;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index da0dfb237f85..dec2705d035d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -20,6 +20,11 @@ / {
> 
>  	aliases {
>  		ethernet0 = &gmac;
> +		gpio0 = &gpio0;
> +		gpio1 = &gpio1;
> +		gpio2 = &gpio2;
> +		gpio3 = &gpio3;
> +		gpio4 = &gpio4;
>  		i2c0 = &i2c0;
>  		i2c1 = &i2c1;
>  		i2c2 = &i2c2;
> --
> 2.39.2
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
