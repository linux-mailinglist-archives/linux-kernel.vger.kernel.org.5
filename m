Return-Path: <linux-kernel+bounces-66242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACDA8558FA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 03:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB02289828
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580C14691;
	Thu, 15 Feb 2024 02:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9K6T7Ft"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CEE3FC7;
	Thu, 15 Feb 2024 02:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707964900; cv=none; b=glftnda6vuXXBv6rHPVet7B3kSnlkdOiigmcfNjzmCgpvuqukStorwOTRYl5eZI5pwPqIhzscCKVjpUOrAzVsPX6LVjJUuOx9uWIrmY7vFj1p4tLl84uzqBE/i16JljabpNDtKVMAufaqd+Dl3yYzgnFArgAFBnhygG/HCtkDKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707964900; c=relaxed/simple;
	bh=gfoCUu9D/q3M+PGkJekBGFp/SGs/cma2Lv5kzV3+/EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLxplk5rx70kVLNr/RyjlRElKa4ZCvqYx6UGtsu+JCUBsR+YBivmxh9Lo5wy2dSFnnPj9YiXDdqVEi5hWKnhF1y3gctdZngC6zOEVreRT7f//yVl7j0nPB4OltZMJLbkkY/xeparADp1j0EXteiUh6OPQAfkcGspYuUI3GIkz7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9K6T7Ft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351F1C433C7;
	Thu, 15 Feb 2024 02:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707964899;
	bh=gfoCUu9D/q3M+PGkJekBGFp/SGs/cma2Lv5kzV3+/EU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B9K6T7FtMDbM1caYDERATDW5et7A+dPRbzRygNys6yjkAEmQtUMGBr0OWsDT6jECZ
	 MMQmUjQT13EdKjfcKIk4MbrDKaoxlNBB/u+jVfeD5MsJ47K+AeWu+U8J05BB7jPros
	 FSgbZa/Hr9c56TkLPve6/bG5heYFbN6+l4esLw6sIKYCBz818odcip+Zn0AwPV6Ksp
	 wd5jwVMMF1v9wO7dHMhhSaXBx39abf9jNJq1YtLzpO6LTpuCJuGna6BwYUmmSnUujJ
	 UXUvsDMCFhLuJt7930ei9DcIsY+83GjXeC6WR3PdtdZJpt3NErUm90eGO3Gl5trpFg
	 SIu9sYZb5HV4Q==
Date: Wed, 14 Feb 2024 20:41:37 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krishna Kurapati <quic_kriskura@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com, 
	quic_jackp@quicinc.com
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sa8295p: Enable tertiary
 controller and its 4 USB ports
Message-ID: <mko2tdjrc4fbpbuig7o4jbznzxr7y6fsw42synu6yur4qzjgtt@nd7eyojiruvd>
References: <20240213082724.1789096-1-quic_kriskura@quicinc.com>
 <20240213082724.1789096-3-quic_kriskura@quicinc.com>
 <efbd57e8-6cbb-480e-b2d5-1d064a27b3a4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efbd57e8-6cbb-480e-b2d5-1d064a27b3a4@linaro.org>

On Tue, Feb 13, 2024 at 09:39:51AM +0100, Krzysztof Kozlowski wrote:
> On 13/02/2024 09:27, Krishna Kurapati wrote:
> > Multiport USB controller (host-only) of SA8295 ADP has 4 Type-A ports
> > exposed for connecting peripherals. The VBUS to these peripherals is
> > provided by TPS2559QWDRCTQ1 regulators connected to these ports. Each
> > regulator has an enable pin controlled by PMM8540. Since these regulators
> > are GPIO controlled regulators, model them as fixed regulators and keep
> > them Always-On at boot since we are wakeup capable and we don't need to
> > turn them off on suspend. Also since we don't enter device mode, these
> > regulators can be kept on.
> > 
> > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 83 ++++++++++++++++++++++++
> >  1 file changed, 83 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > index fd253942e5e5..49418843c214 100644
> > --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > @@ -9,6 +9,7 @@
> >  #include <dt-bindings/gpio/gpio.h>
> >  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> >  #include <dt-bindings/spmi/spmi.h>
> > +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> >  
> >  #include "sa8540p.dtsi"
> >  #include "sa8540p-pmics.dtsi"
> > @@ -108,6 +109,46 @@ edp3_connector_in: endpoint {
> >  			};
> >  		};
> >  	};
> > +
> > +	regulator-usb2-vbus {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "USB2_VBUS";
> > +		gpio = <&pmm8540c_gpios 9 GPIO_ACTIVE_HIGH>;
> > +		pinctrl-0 = <&usb2_en>;
> > +		pinctrl-names = "default";
> > +		enable-active-high;
> > +		regulator-always-on;
> > +	};
> > +
> > +	regulator-usb3-vbus {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "USB3_VBUS";
> > +		gpio = <&pmm8540e_gpios 5 GPIO_ACTIVE_HIGH>;
> > +		pinctrl-0 = <&usb3_en>;
> > +		pinctrl-names = "default";
> > +		enable-active-high;
> > +		regulator-always-on;
> > +	};
> > +
> > +	regulator-usb4-vbus {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "USB4_VBUS";
> > +		gpio = <&pmm8540g_gpios 5 GPIO_ACTIVE_HIGH>;
> > +		pinctrl-0 = <&usb4_en>;
> > +		pinctrl-names = "default";
> > +		enable-active-high;
> > +		regulator-always-on;
> > +	};
> > +
> > +	regulator-usb5-vbus {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "USB5_VBUS";
> > +		gpio = <&pmm8540g_gpios 9 GPIO_ACTIVE_HIGH>;
> > +		pinctrl-0 = <&usb5_en>;
> > +		pinctrl-names = "default";
> > +		enable-active-high;
> > +		regulator-always-on;
> 
> Why all these regulators are always on? If USB controller does not probe
> for any reason, why keeping them enabled? These must not be always-on,
> but instead used by connector as VBUS supply (or by whatever you have
> there for USB).
> 

I'm not too concerned about keeping the lights on in this scenario, but
if we can describe this properly let's do so (and let's do so on other
boards with connectors as well).

We'd have a set of usb-a-connector nodes, that we can tie to the nodes
in the USB/phy, and the supply. But so far we've associated a connector
with a port manager, here we don't have one of those, so where would the
node reside and who should acquire and drive the vbus-supply?

Regards,
Bjorn

> Best regards,
> Krzysztof
> 

