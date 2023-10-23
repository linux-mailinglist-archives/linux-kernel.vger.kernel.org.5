Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7276F7D3BCA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjJWQJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjJWQJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:09:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2260810C;
        Mon, 23 Oct 2023 09:09:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6AD1C433C7;
        Mon, 23 Oct 2023 16:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698077354;
        bh=q3udcmAsMOTYZRfyrRXc6quMPQsnI4nlAxg7mdbb+CM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nvlSqODPE4F0iXpYhyKCYN+IiPr3LmO2vXll5dwXTtPUb2mGp8x9DBelq0ZqWlamt
         2hWzduky8atikefHg47Py6ZY8l+YERO56H2I9/GZT2SZN+cva8dwgSmIYGWvSU/YpJ
         HVxJ63ukz/DmkAwlOm91Pnkpv6Cvz3/m2UPrhmAlcnXsYPjujLKxMC9ecRq/yny/F4
         mduTZhMxLNzqCpzR02a3X0QGxhI/jnh0ja56CQksuJezRrU2+ucDBpf/XtGxH9SRlz
         AEvPclrdYV/Dbq1V4ZaJVrC5zqwktCoUuCRk2i6ohGN4p0d0WCFy9FfP2thxhVhB1q
         nQsg4pRJiY+pg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1quxUf-00025R-0t;
        Mon, 23 Oct 2023 18:09:29 +0200
Date:   Mon, 23 Oct 2023 18:09:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
Subject: Re: [PATCH v13 08/10] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
Message-ID: <ZTaauQewazaaFonF@hovoldconsulting.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-9-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007154806.605-9-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 09:18:04PM +0530, Krishna Kurapati wrote:
> Add USB and DWC3 node for tertiary port of SC8280 along with multiport
> IRQ's and phy's. This will be used as a base for SA8295P and SA8295-Ride
> platforms.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 84 ++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index cad59af7ccef..5f64f75b07db 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -3330,6 +3330,90 @@ system-cache-controller@9200000 {
>  			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		usb_2: usb@a4f8800 {
> +			compatible = "qcom,sc8280xp-dwc3-mp", "qcom,dwc3";

So you went with a dedicated compatible even though you are now
inferring the number of ports from the interrupts property.

Should we drop that compatible again or is there any other reason to
keep a separate one?

> +			interrupts-extended = <&pdc 127 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 126 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 129 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 128 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 131 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 130 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 133 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 132 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 857 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 856 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interrupt-names = "dp_hs_phy_1", "dm_hs_phy_1",
> +					  "dp_hs_phy_2", "dm_hs_phy_2",
> +					  "dp_hs_phy_3", "dm_hs_phy_3",
> +					  "dp_hs_phy_4", "dm_hs_phy_4",
> +					  "ss_phy_1", "ss_phy_2",
> +					  "pwr_event_1",
> +					  "pwr_event_2",
> +					  "pwr_event_3",
> +					  "pwr_event_4";

The interrupt order does not match the binding, where the power event
interrupts come first.

And we probably also want the hs_phy_irqs here after fixing the
incomplete binding.

> +			usb_2_dwc3: usb@a400000 {
> +				compatible = "snps,dwc3";
> +				reg = <0 0x0a400000 0 0xcd00>;
> +				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;

I'd also like to know what that second dwc3 interrupt is for and whether
it should be defined here as well.

> +				iommus = <&apps_smmu 0x800 0x0>;
> +				phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>,
> +				       <&usb_2_hsphy1>, <&usb_2_qmpphy1>,
> +				       <&usb_2_hsphy2>,
> +				       <&usb_2_hsphy3>;
> +				phy-names = "usb2-port0", "usb3-port0",
> +					    "usb2-port1", "usb3-port1",
> +					    "usb2-port2",
> +					    "usb2-port3";
> +
> +				/*
> +				 * Multiport controllers are host only contollers, so

spelling again...

> +				 * the dr_mode can be defaulted to host irrespective of
> +				 * the platform.
> +				 */

I know someone asked you to add a comment, but I think you should drop
it again because it makes little sense in its current form.

This particular controller is always going to be host only so just set
dr_mode here. No one is going to be overriding that.

Any comment would need to be about this particular platform and not make
claims about future controllers.

> +				dr_mode = "host";
> +			};
> +		};
> +

Johan
