Return-Path: <linux-kernel+bounces-43562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70894841589
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFFB2891F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C5915AAAB;
	Mon, 29 Jan 2024 22:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9jUHeMO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D411158D99;
	Mon, 29 Jan 2024 22:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706566879; cv=none; b=J8N646pYZAL1anBQ4Cdn8yvPkch7yZx9+kjF54NV9I1ZC2iqSVVvZQWbaaQYPD62wAlNdTBvAABHXwO4SeZW3RDqnyjqir1IsvWv2RNayK1bF86cBTaiO/r15uuQbF61Iiwz6dF2qPaKieAGTRe2Ruix8npo3tiI71ScAkH8hZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706566879; c=relaxed/simple;
	bh=QO6T5tt8NMalRJEwbBqkth8IWMyi4TL9rAZyeRq7xfQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=GfpvIFdQ55lPyVIETPnWCRVVxLZyY41EI9Ya0PtZ0AXgjByvlBekXQ2wqgQFDvkfJSo2dNQvjBgeXdJwmvSF7deFs4XRJyf29DyYrmXEHmwUsixoOmOKso61Fm+td+xrp573frv0+rV5ngR/DYgmuSLbZCP+g0VXWTiGEHZq5CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9jUHeMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB723C433F1;
	Mon, 29 Jan 2024 22:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706566879;
	bh=QO6T5tt8NMalRJEwbBqkth8IWMyi4TL9rAZyeRq7xfQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=c9jUHeMOD/K7aR0Uf+b3B4DBqzuWwA7jfgXE848L4Wsl451pPJPmNH4Rck0a80mfo
	 +XFdvvbNst3mTrfUUMY08jpBWCZrI6/dLIIoZvx7C/++iEd3gkAdW+G+STQU3cJC2x
	 LkGJ5C1ahoTso91BRS7048PwfQA0pltRZt3i0EzLuQDKJiwb7be/Isn5EekdUTiHvc
	 nieGvGjsu1WJTIZtStiGtwGnYOxOVEeZvkbynSWsCgxfcsqnB7VPEkum9Dz2bhiPER
	 i6pY3T44egVesB40L5qXkL0VMVAgPofT0R6oQqyM/f+HICRsv2IYe56u6KXIRf0mtI
	 ZD4g3yGVQZzYQ==
Date: Mon, 29 Jan 2024 16:21:17 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Dragan Cvetic <dragan.cvetic@amd.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Derek Kiernan <derek.kiernan@amd.com>, 
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>, 
 "Erim, Salih" <salih.erim@amd.com>, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240129171854.3570055-1-dragan.cvetic@amd.com>
References: <20240129171854.3570055-1-dragan.cvetic@amd.com>
Message-Id: <170656680094.3132.1588315626789249618.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: misc: xlnx,sd-fec: convert bindings to
 yaml


On Mon, 29 Jan 2024 17:18:51 +0000, Dragan Cvetic wrote:
> Convert AMD (Xilinx) sd-fec bindings to yaml format, so it can validate
> dt-entries as well as any future additions to yaml.
> Change in clocks is due to IP is itself configurable and
> only the first two clocks are in all combinations. The last
> 6 clocks can be present in some of them. It means order is
> not really fixed and any combination is possible.
> Interrupt may or may not be present.
> The documentation for sd-fec bindings is now YAML, so update the
> MAINTAINERS file.
> Update the link to the new yaml file in xilinx_sdfec.rst.
> 
> Signed-off-by: Dragan Cvetic <dragan.cvetic@amd.com>
> ---
> Changes in v2:
> ---
> Drop clocks description.
> Use "contains:" with enum for optional clock-names and update
> comment explaining diference from the original DT binding file.
> Remove trailing full stops.
> Add more details in sdfec-code description.
> Set sdfec-code to "string" not "string-array"
> ---
>  .../devicetree/bindings/misc/xlnx,sd-fec.txt  |  58 --------
>  .../devicetree/bindings/misc/xlnx,sd-fec.yaml | 136 ++++++++++++++++++
>  Documentation/misc-devices/xilinx_sdfec.rst   |   2 +-
>  MAINTAINERS                                   |   2 +-
>  4 files changed, 138 insertions(+), 60 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/misc/xlnx,sd-fec.example.dts:32.29-30 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/misc/xlnx,sd-fec.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240129171854.3570055-1-dragan.cvetic@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


