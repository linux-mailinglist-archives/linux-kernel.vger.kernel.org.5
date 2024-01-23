Return-Path: <linux-kernel+bounces-35874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F0F8397DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84ED4B28867
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09B382D9E;
	Tue, 23 Jan 2024 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8BjuF13"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1841F81AAA;
	Tue, 23 Jan 2024 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035056; cv=none; b=jO19DbnENaU+a5vEOQ2IeEKgVGLcQHSr2mGB4+3xbhqIuUv9WDT43GMT30hmheNF054PZrzoHzzz1SIxSITnFhlbwMg2mV405G4SBvs+UCLiDHjdwPJ383pQPbHDsAugSFUeOW3cIwYxWBpWJvBcvlGN+uvahIzCBiaAjzWbX7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035056; c=relaxed/simple;
	bh=8m2Zq7ijQyatx8o/IUFi8SWV/Zz6InYrOWTjszWImjM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=M3uoS4n9q/qR+gS5QfClT/EFMTd3ui/nHe2gDLIJ6rwY+MfAsCKPudEmFL1LKvACw+DLrId5gI6ycpXhFvbuGTGy+ipvJIwLi/OmjB39K8cg8VGKEL3f2GYB4lZT1G/yBzt33Wnh9+2ljKxi7bygI6Alg435V17vjZx9KOaRmj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8BjuF13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BD4C433C7;
	Tue, 23 Jan 2024 18:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706035055;
	bh=8m2Zq7ijQyatx8o/IUFi8SWV/Zz6InYrOWTjszWImjM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=k8BjuF13zgdh7RVsunlDv9qYUH3Opz/bXKNc5HpdI6t5cM6toGctWAIgC2FQxi1Zy
	 3C35TX3vzPGjgtW86pQPSJhN33sTVohzSWpMiqaQey85iZEeax8GBG10Y5zGa9tdv0
	 LLIWKIs1W4ugvkLN2eRz56LqFEE8coosczHfjC0TGeM0YMxaC23JW8HxzDJ9yPuQNm
	 YmjVpBVKsWi0d3aGyqoPPRpWWRNdJSdj/Av5waFT3p8ybF+NbBmBHDx6LS1ulvJhbV
	 CFjyUHM9+Oaf/RmaWnAP/WZ9vv4iPwMJ53pzpdAAFkIJhdDqqlYsNE5PqvS0qYICFu
	 oKlsbkBdBgArw==
Date: Tue, 23 Jan 2024 12:37:34 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org, 
 mark.rutland@arm.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
 robh+dt@kernel.org, conor+dt@kernel.org, balbi@kernel.org, 
 mathias.nyman@intel.com, sergei.shtylyov@cogentembedded.com, 
 thinh.nguyen@synopsys.com, gregkh@linuxfoundation.org, pku.leo@gmail.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240123170206.3702413-1-Frank.Li@nxp.com>
References: <20240123170206.3702413-1-Frank.Li@nxp.com>
Message-Id: <170603505074.1430842.17793534991296017470.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add system bus request
 info


On Tue, 23 Jan 2024 12:02:05 -0500, Frank Li wrote:
> Add device tree binding allow platform overwrite default value of *REQIN in
> GSBUSCFG0.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml    | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/usb/snps,dwc3.yaml:447:43: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/usb/snps,dwc3.example.dts'
Documentation/devicetree/bindings/usb/snps,dwc3.yaml:447:43: mapping values are not allowed in this context
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/usb/snps,dwc3.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml:
mapping values are not allowed in this context
  in "<unicode string>", line 447, column 43
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml:
mapping values are not allowed in this context
  in "<unicode string>", line 447, column 43
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml:
mapping values are not allowed in this context
  in "<unicode string>", line 447, column 43
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml:
mapping values are not allowed in this context
  in "<unicode string>", line 447, column 43
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml:
mapping values are not allowed in this context
  in "<unicode string>", line 447, column 43
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml:
mapping values are not allowed in this context
  in "<unicode string>", line 447, column 43
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml:
mapping values are not allowed in this context
  in "<unicode string>", line 447, column 43
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml:
mapping values are not allowed in this context
  in "<unicode string>", line 447, column 43
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml:
mapping values are not allowed in this context
  in "<unicode string>", line 447, column 43
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/realtek,rtd-dwc3.yaml:
mapping values are not allowed in this context
  in "<unicode string>", line 447, column 43
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/fsl,imx8mq-dwc3.yaml:
mapping values are not allowed in this context
  in "<unicode string>", line 447, column 43
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/intel,keembay-dwc3.yaml:
mapping values are not allowed in this context
  in "<unicode string>", line 447, column 43
/Documentation/devicetree/bindings/usb/snps,dwc3.yaml:447:43: mapping values are not allowed in this context
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240123170206.3702413-1-Frank.Li@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


