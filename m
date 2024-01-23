Return-Path: <linux-kernel+bounces-36152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42927839C62
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8B72B2168E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A905537F0;
	Tue, 23 Jan 2024 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gV1vZT+g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515D76ADE;
	Tue, 23 Jan 2024 22:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049502; cv=none; b=TaLl6C22GVY44ql2ZmalaN449xNa1qG+UYP2+muD5ODOJ89vV+eLFsCBcyExOgxIuFNmRLXOf4JSInzr8iCU+EY0nOg2RVMmKUaCT+fz4CoK0QYgiKs2dA57ac5yeKytBh73mr7AQ+eB2aEzVibkx666FTOcNanhgeYrnge07Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049502; c=relaxed/simple;
	bh=/DMGv7HfPRC+XJk0/nfDyPf+n+rMzldKRmicjf3Yozc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=lsATQxwCDdYpJqpsF8tN9KeUgadzQafnxg8taKHXMUajX3ztjgVQx9oQ6R9mik3aCf506b4yln2gYfeub5/Hx8m0fsGaBy7Kv/1gcACEcpTaH3vGw+L6+RQkhj3JCCL4fhQM8+KLf12zrEgvuuPDqV2bA81K7gHKhWR3Ji5phUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gV1vZT+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3719C433F1;
	Tue, 23 Jan 2024 22:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706049501;
	bh=/DMGv7HfPRC+XJk0/nfDyPf+n+rMzldKRmicjf3Yozc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gV1vZT+gAFjlN9VtnZ6Lum9jgUx7VAoDhiGadatbjAQF1BMQd0ZFbBQ3ZK67EA6L8
	 wps5Ngks/NSUtIv1qyNhmUp+YBGGMfabpFVMmUOexiU3Q8wzCzq0DbqNNU8bNh1Bzn
	 yMS/yrmZX6+PwE055zv64PTnm7+NWKLbYR1t0A+BXKHyivTK0xrYAgkWbXBduStiEy
	 eHV6/R8VoT9x6lIntBdIAg91B//Z9oa64dieNE2TMLPgdZBh0KGoD1L6DEkFo9o3m5
	 4cQW25G3SN24YlwsjPnUmW5BdRt9gqg5OKOaYxJ7OWURoKgHNvKvE2bDXMU3mY9TLm
	 v9tt6dPQg8JIA==
Date: Tue, 23 Jan 2024 16:38:20 -0600
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
Cc: conor.culhane@silvaco.com, linux-serial@vger.kernel.org, 
 zbigniew.lukwinski@linux.intel.com, joe@perches.com, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org, 
 frank.li@nxp.com, devicetree@vger.kernel.org, miquel.raynal@bootlin.com, 
 alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org, 
 jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 krzysztof.kozlowski@linaro.org
In-Reply-To: <20240123212549.3858137-3-Frank.Li@nxp.com>
References: <20240123212549.3858137-1-Frank.Li@nxp.com>
 <20240123212549.3858137-3-Frank.Li@nxp.com>
Message-Id: <170604949961.2185792.3557017002643301182.robh@kernel.org>
Subject: Re: [PATCH v3 2/8] dt-bindings: i3c: svc: add proptery mode


On Tue, 23 Jan 2024 16:25:43 -0500, Frank Li wrote:
> Add proptery 'mode' to distinguish work at 'controller' or 'target' mode.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v2 to v3
>         - using 'mode' distringuish master and target mode
> 
>  .../devicetree/bindings/i3c/silvaco,i3c-master.yaml   | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml:26:4: [warning] wrong indentation: expected 4 but found 3 (indentation)
/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml:30:9: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/i3c/silvaco,i3c-master.example.dts'
Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml:30:9: mapping values are not allowed in this context
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/i3c/silvaco,i3c-master.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml:30:9: mapping values are not allowed in this context
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240123212549.3858137-3-Frank.Li@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


