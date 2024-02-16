Return-Path: <linux-kernel+bounces-69484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFD8858A2F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9315C1C21EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564B7148FE6;
	Fri, 16 Feb 2024 23:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOHzZTAK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D45639856;
	Fri, 16 Feb 2024 23:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708126382; cv=none; b=JQ/SijuPGO3lZ+0FT3igybLATaSbmOHjqYuwhAr/smoW4HtDfQvQCiJWvWNgkJYZ4Iyj0lo/vUR3VHuJJFJ0fXtWk5CpA1VAUveuw9ZmddvxmnvrZ46lD6fcB5VxwaLfkZiiYj44Ie+v4dUoelOoUsyVwM2EqIGng+3/NWxGFkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708126382; c=relaxed/simple;
	bh=eqVzyEMsGzU657cg5/N5H+3Tf21cigAxeHyuccXXgEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMmuuD781GV7+f68zdMBL/OOLaUGaQvGqeOCGV8Llb6MT0jIYcRqCx8LP5nZPOptsXnCfDZDSHwSupOEvERZVuljeeZzxGhKkuYgAXWn/+7BsMpRdN2M7LUKr9bQm/kaShPtxPpc0FlkgFJDXoNQyeRrEEVpkVcPKFeli6UIEV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOHzZTAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EDEC433C7;
	Fri, 16 Feb 2024 23:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708126382;
	bh=eqVzyEMsGzU657cg5/N5H+3Tf21cigAxeHyuccXXgEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DOHzZTAKXDMXVosB9ZTMu4Vk/VyP/ne+gcWYQw0EtOFXZqpynenXuhA/3PJUB4qNW
	 Ia1LBgtti9/hEfOTDKQeXusVVjevKoi+g7dILsjdCphDv7F1HGJU7TkFKm2DhmCVnf
	 eEy/uNUOknF08EHNhXM5zCRZ7hjfrnm7D1NVMaWZ7RZBEGZh+VBbyG/2I3dF5+zgkx
	 s4J981HBjC7TLcZUYVUpABzR2yvdL44rmmORY8UhYeuOEpLt39o5TUfH60v4TLAmGU
	 d8s92TIxRY8SJTeK36DWAEWVb5XrK1kFbsDRDmzlczZSSHLpuq4U/0X5VUZKDOx17Q
	 mG/P4X4cFo8YQ==
Date: Fri, 16 Feb 2024 17:32:59 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krishna Kurapati <quic_kriskura@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com, 
	quic_jackp@quicinc.com
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sa8295p: Enable tertiary
 controller and its 4 USB ports
Message-ID: <bwy4gpmhjkrumow6yjas6rww3eqzjheondafoenyvh3ugsp7oo@6jlpt5cx6zty>
References: <20240213082724.1789096-1-quic_kriskura@quicinc.com>
 <20240213082724.1789096-3-quic_kriskura@quicinc.com>
 <efbd57e8-6cbb-480e-b2d5-1d064a27b3a4@linaro.org>
 <mko2tdjrc4fbpbuig7o4jbznzxr7y6fsw42synu6yur4qzjgtt@nd7eyojiruvd>
 <1a033944-9361-4576-8807-35a68c1e8548@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a033944-9361-4576-8807-35a68c1e8548@linaro.org>

On Thu, Feb 15, 2024 at 09:19:39AM +0100, Krzysztof Kozlowski wrote:
> On 15/02/2024 03:41, Bjorn Andersson wrote:
> > On Tue, Feb 13, 2024 at 09:39:51AM +0100, Krzysztof Kozlowski wrote:
> >> On 13/02/2024 09:27, Krishna Kurapati wrote:
> >>> Multiport USB controller (host-only) of SA8295 ADP has 4 Type-A ports
> >>> exposed for connecting peripherals. The VBUS to these peripherals is
> >>> provided by TPS2559QWDRCTQ1 regulators connected to these ports. Each
> >>> regulator has an enable pin controlled by PMM8540. Since these regulators
> >>> are GPIO controlled regulators, model them as fixed regulators and keep
> >>> them Always-On at boot since we are wakeup capable and we don't need to
> >>> turn them off on suspend. Also since we don't enter device mode, these
> >>> regulators can be kept on.
> >>>
> >>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 83 ++++++++++++++++++++++++
> >>>  1 file changed, 83 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> >>> index fd253942e5e5..49418843c214 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> >>> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> >>> @@ -9,6 +9,7 @@
> >>>  #include <dt-bindings/gpio/gpio.h>
> >>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> >>>  #include <dt-bindings/spmi/spmi.h>
> >>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> >>>  
> >>>  #include "sa8540p.dtsi"
> >>>  #include "sa8540p-pmics.dtsi"
> >>> @@ -108,6 +109,46 @@ edp3_connector_in: endpoint {
> >>>  			};
> >>>  		};
> >>>  	};
> >>> +
> >>> +	regulator-usb2-vbus {
> >>> +		compatible = "regulator-fixed";
> >>> +		regulator-name = "USB2_VBUS";
> >>> +		gpio = <&pmm8540c_gpios 9 GPIO_ACTIVE_HIGH>;
> >>> +		pinctrl-0 = <&usb2_en>;
> >>> +		pinctrl-names = "default";
> >>> +		enable-active-high;
> >>> +		regulator-always-on;
> >>> +	};
> >>> +
> >>> +	regulator-usb3-vbus {
> >>> +		compatible = "regulator-fixed";
> >>> +		regulator-name = "USB3_VBUS";
> >>> +		gpio = <&pmm8540e_gpios 5 GPIO_ACTIVE_HIGH>;
> >>> +		pinctrl-0 = <&usb3_en>;
> >>> +		pinctrl-names = "default";
> >>> +		enable-active-high;
> >>> +		regulator-always-on;
> >>> +	};
> >>> +
> >>> +	regulator-usb4-vbus {
> >>> +		compatible = "regulator-fixed";
> >>> +		regulator-name = "USB4_VBUS";
> >>> +		gpio = <&pmm8540g_gpios 5 GPIO_ACTIVE_HIGH>;
> >>> +		pinctrl-0 = <&usb4_en>;
> >>> +		pinctrl-names = "default";
> >>> +		enable-active-high;
> >>> +		regulator-always-on;
> >>> +	};
> >>> +
> >>> +	regulator-usb5-vbus {
> >>> +		compatible = "regulator-fixed";
> >>> +		regulator-name = "USB5_VBUS";
> >>> +		gpio = <&pmm8540g_gpios 9 GPIO_ACTIVE_HIGH>;
> >>> +		pinctrl-0 = <&usb5_en>;
> >>> +		pinctrl-names = "default";
> >>> +		enable-active-high;
> >>> +		regulator-always-on;
> >>
> >> Why all these regulators are always on? If USB controller does not probe
> >> for any reason, why keeping them enabled? These must not be always-on,
> >> but instead used by connector as VBUS supply (or by whatever you have
> >> there for USB).
> >>
> > 
> > I'm not too concerned about keeping the lights on in this scenario, but
> > if we can describe this properly let's do so (and let's do so on other
> > boards with connectors as well).
> > 
> > We'd have a set of usb-a-connector nodes, that we can tie to the nodes
> > in the USB/phy, and the supply. But so far we've associated a connector
> > with a port manager, here we don't have one of those, so where would the
> > node reside and who should acquire and drive the vbus-supply?
> 
> usb-connector binding has vbus-supply and its node could be top-level.

Introducing usb-connector nodes toplevel, with vbus-supply sounds
reasonable. But to my knowledge there's today no way to acquire a
handle to that regulator, unless you have a struct device for the
connector node.

> However don't some USB phys also take that regulator?
> 

I don't think it's appropriate to add the supply to any of the phys,
some of the connectors has 2 phys others has 1 phy.

Representing the vbus in the connector but driving it from the phy
(we will need to figure out which one) sounds reasonable. We just need
to make sure this doesn't conflict with the fact that some TCPM
implementations also seems to drive vbus.


I would like this to be properly modelled, but it seems reasonable to
punt that to the todo list for now.

Regards,
Bjorn

> Best regards,
> Krzysztof
> 

