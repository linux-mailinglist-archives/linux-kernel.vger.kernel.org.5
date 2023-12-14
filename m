Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17048128BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbjLNHHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjLNHHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:07:46 -0500
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C2DBD;
        Wed, 13 Dec 2023 23:07:51 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1702537669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YeV7T88snl53RFgpuP4C5JHNb6hLjpYKE/XnNP2YYbo=;
        b=jjnrRkZ7xobzuw20PCR8x87LIc5aCuTeZvPA1ATgp61Ob8c/IHBiA3KpL7OlX/A5FEMTBK
        eUtLAKy3AaB3m7DXp+U5mWfZU5UoqzIkqiJvYEJXMDEsJFwB8qzpeu3R9CLSeuL8gvZWsi
        Q2DlKKoADIRC8eLLfY6DNzI6PQW3t4Xk6k5nmOE+i5CskTn7KMG4zrHWlXg9UFg/6Pl1SF
        +AYG/kYPYVJ2iq86dHc46/1Vsj+qlUv0itifPkOC67ubwBkoPlcOSbV9QEcFqr0MhE8Kt4
        8sfMjNtvC6spnDRu3IBRAA2ZM9J/2itTShoEjzXI+C+1T8SA4GWtI2DKMTfMFw==
Date:   Thu, 14 Dec 2023 08:07:48 +0100
From:   Dragan Simic <dsimic@manjaro.org>
To:     Trevor Woerner <twoerner@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] arm64: rockchip: dts: rk3328-rock-pi-e: add
 gpio-line-names
In-Reply-To: <20231213160556.14424-1-twoerner@gmail.com>
References: <20231213160556.14424-1-twoerner@gmail.com>
Message-ID: <62a0261fba6aecf5b28c4c55eb38ea51@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-13 17:05, Trevor Woerner wrote:
> Add names to the pins of the general-purpose expansion header as given
> in the Radxa GPIO page[1] following the conventions in the kernel
> documentation[2] to make it easier for users to correlate the pins with
> functions when using utilities such as 'gpioinfo'.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> changes in v2:
> - fix subject from "amd64..." to "arm64..."
> ---
>  .../boot/dts/rockchip/rk3328-rock-pi-e.dts    | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
> b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
> index 018a3a5075c7..3169c0854061 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
> @@ -388,3 +388,56 @@ &usbdrd3 {
>  &usb_host0_ehci {
>  	status = "okay";
>  };
> +
> +&gpio0 {
> +	gpio-line-names =
> +	/* GPIO0_A0 - A7 */
> +	"", "", "", "", "", "", "", "",
> +	/* GPIO0_B0 - B7 */
> +	"", "", "", "", "", "", "", "",
> +	/* GPIO0_C0 - C7 */
> +	"", "", "", "", "", "", "", "",
> +	/* GPIO0_D0 - D7 */
> +	"", "", "", "pin-15 [GPIO0_D3]", "", "", "", "";
> +};
> +
> +&gpio1 {
> +	gpio-line-names =
> +	/* GPIO1_A0 - A7 */
> +	"", "", "", "", "", "", "", "",
> +	/* GPIO1_B0 - B7 */
> +	"", "", "", "", "", "", "", "",
> +	/* GPIO1_C0 - C7 */
> +	"", "", "", "", "", "", "", "",
> +	/* GPIO1_D0 - D7 */
> +	"", "", "", "", "pin-07 [GPIO1_D4]", "", "", "";
> +};
> +
> +&gpio2 {
> +	gpio-line-names =
> +	/* GPIO2_A0 - A7 */
> +	"pin-08 [GPIO2_A0]", "pin-10 [GPIO2_A1]", "pin-11 [GPIO2_A2]",
> +	"pin-13 [GPIO2-A3]", "pin-27 [GPIO2_A4]", "pin-28 [GPIO2_A5]",
> +	"pin-33 [GPIO2_A6]", "",
> +	/* GPIO2_B0 - B7 */
> +	"", "", "", "", "pin-26 [GPIO2_B4]", "", "", "pin-36 [GPIO2_B7]",
> +	/* GPIO2_C0 - C7 */
> +	"pin-32 [GPIO2_C0]", "pin-35 [GPIO2_C1]", "pin-12 [GPIO2_C2]",
> +	"pin-38 [GPIO2_C3]", "pin-29 [GPIO2_C4]", "pin-31 [GPIO2_C5]",
> +	"pin-37 [GPIO2_C6]", "pin-40 [GPIO2_C7]",
> +	/* GPIO2_D0 - D7 */
> +	"", "", "", "", "", "", "", "";
> +};
> +
> +&gpio3 {
> +	gpio-line-names =
> +	/* GPIO3_A0 - A7 */
> +	"pin-23 [GPIO3_A0]", "pin-19 [GPIO3_A1]", "pin-21 [GPIO3_A2]",
> +	"", "pin-03 [GPIO3_A4]", "", "pin-05 [GPIO3_A6]", "",
> +	/* GPIO3_B0 - B7 */
> +	"pin-24 [GPIO3_B0]", "", "", "", "", "", "", "",
> +	/* GPIO3_C0 - C7 */
> +	"", "", "", "", "", "", "", "",
> +	/* GPIO3_D0 - D7 */
> +	"", "", "", "", "", "", "", "";
> +};

The formatting should be a bit different, i.e. all lines following 
"gpio-line-names =" and providing the value should be indented one tab 
position further.
