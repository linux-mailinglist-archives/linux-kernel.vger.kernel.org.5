Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D458077FF79
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355145AbjHQVEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355203AbjHQVEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:04:23 -0400
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7582D7D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
        content-transfer-encoding:cc:content-type:from:subject:to;
        s=s1; bh=TcEEszJfjlCHwKsFpwnWm1d65Qo4xi+W36wwjFhVKOo=;
        b=oDOPIB5D/fL5/fWe3ME9vleCXenp1V7YZDIoGspzOJ2/iWYvxSyEHpVuBoSxTspVvOtu
        1RBmvL0ThLdbBHQY88xK0TZ9SCHWBOyhP6hdJHAhF+IpKf0dWyRoB8ViAo1r/UR0m8KETi
        VfA08g9KcWsgpL4tJL9L6XNoexsB6rKC9fGAmvjeRfPt9deZPM+hHGa8oGm+GamRXjcygT
        xlrfwU/0WJ7hgl5x1A6r2hG8u0q/Po5xtDEjqSTjEIh5T5Wwxr5sERRn3foE8M1c1nldab
        87M0Qi5nG4S00FsMs/VJW8o7Zn6Wu6HC94rhyQPvHTabj5QPAgoZov8TzyZFapIA==
Received: by filterdrecv-66949dbc98-r7x9c with SMTP id filterdrecv-66949dbc98-r7x9c-1-64DE8B54-15
        2023-08-17 21:04:20.267440901 +0000 UTC m=+8544276.233978210
Received: from [192.168.1.50] (unknown)
        by geopod-ismtpd-5 (SG) with ESMTP
        id 4A2qnn0eRB6lO0Onw9U5kw
        Thu, 17 Aug 2023 21:04:19.902 +0000 (UTC)
Message-ID: <86c92a80-38ac-bd5d-2f31-fd003f13d2ed@kwiboo.se>
Date:   Thu, 17 Aug 2023 21:04:20 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Add sfc node to rk3588s
Content-Language: en-US
References: <cover.1692102057.git.efectn@6tel.net>
 <b96e8d517d431d13eedd9c9606523076d72033bf.1692102057.git.efectn@6tel.net>
From:   Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <b96e8d517d431d13eedd9c9606523076d72033bf.1692102057.git.efectn@6tel.net>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h7He8qHGjMdPut1pE?=
 =?us-ascii?Q?dkn9+=2F2DGDvT=2FkkNZp68DzJlYASbgkv9+xcggGU?=
 =?us-ascii?Q?r3Cd2hy7EWNayQYq5V0=2F3cCs2E5vkKxVY3iEd2K?=
 =?us-ascii?Q?Zi+i9woYzXWPtVERWLRbwYxFOAHOBcLpr26Ni+3?=
 =?us-ascii?Q?1uN6l28xOjn=2FGVoj5c56+Xr7lcyxBsZYrYfMY4?=
To:     Muhammed Efe Cetin <efectn@6tel.net>,
        linux-rockchip@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, sebastian.reichel@collabora.com
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-15 14:59, Muhammed Efe Cetin wrote:
> Add sfc node to rk3588s.dtsi from downstream kernel.
> 
> Signed-off-by: Muhammed Efe Cetin <efectn@6tel.net>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index 5544f66c6ff4..a38a0158fce0 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -1424,6 +1424,19 @@ sata-port@0 {
>  		};
>  	};
>  
> +	sfc: spi@fe2b0000 {
> +		compatible = "rockchip,sfc";
> +		reg = <0x0 0xfe2b0000 0x0 0x4000>;
> +		interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;

gic use 4 interrupt-cells, should be:

  interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH 0>;

> +		clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
> +		clock-names = "clk_sfc", "hclk_sfc";
> +		assigned-clocks = <&cru SCLK_SFC>;
> +		assigned-clock-rates = <100000000>;

You should not need to assign clock rate here, do it in your board dts
if you really must.

Regards,
Jonas

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +
>  	sdmmc: mmc@fe2c0000 {
>  		compatible = "rockchip,rk3588-dw-mshc", "rockchip,rk3288-dw-mshc";
>  		reg = <0x0 0xfe2c0000 0x0 0x4000>;

