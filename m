Return-Path: <linux-kernel+bounces-43667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BCC84176A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8EB1F240EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E6B125D5;
	Tue, 30 Jan 2024 00:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1WLJsFk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE12410FD;
	Tue, 30 Jan 2024 00:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706574106; cv=none; b=gDXVfLbwOekqEk9dwtqNyV9+grsWGHnHQCxZHNVF9ON3slnICQPGnB7m6stBdINpY1x5+YxhYnnrHlhIO2GbBF0Y+7KWuEQQCw+nyb5CoS9WMPXk15yg4/ml1lJTYsh0WcuytI2yoFXYiNye0eHHNkIw1i5SbgGOopODQ8jIgUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706574106; c=relaxed/simple;
	bh=WwZr4D28HIW9IF6cl2zLedh8M7SwhhFpFoQUPwdLlsU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=l5zsGrEWQgK+d70/nRVL2ZrF7UC0E+1eIvflE2twF0IF4OxHVa3nAceHN5WaQycFjorr3KiEVwyGYHncDIKSVlOho8kS3LPOurLpYPtas2j60UYx4lItvqfXBKSv81SsmAG982vMbWnVDFy6gkJv6TkXSXsN0EVlMR5KADt0m5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1WLJsFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EA5C433C7;
	Tue, 30 Jan 2024 00:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706574106;
	bh=WwZr4D28HIW9IF6cl2zLedh8M7SwhhFpFoQUPwdLlsU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=U1WLJsFkOGJjOIY1YaD79ArO8XZDUAkFrGAEv5/FI30ISmVlBJb2nFf1vMZdjD6ZJ
	 rYzCVoLxXRWjVMXzNy8DZLDqTSYMy6cu18EdnSTXA2mGe0K+opaK70UnwJuHqP8SMq
	 DJPZEKFzfsPlFyyKaUaX+wpsskdJOFmH/ZvMQ9zGnd/6FO+rZ4s0ZrQ09lIq94TwlF
	 8TqsximYHyRRNHBiQG8SXo5YQcVpkXAf9Cy/CVgBZWiW63wMkFWAFOQ1B0WKhj8rUy
	 LZpi3hK1DPnnr2m43sk5vd0xIoJ0/KiALRxMDAeHGz9BLcpxJosc/kt8sP612TOiW2
	 DQrldaHAo7qcQ==
Date: Mon, 29 Jan 2024 18:21:45 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Charles Perry <charles.perry@savoirfairelinux.com>
Cc: bcody@markem-imaje.com, yilun.xu@intel.com, trix@redhat.com, 
 avandiver@markem-imaje.com, linux-fpga@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, hao.wu@intel.com, mdf@kernel.org
In-Reply-To: <20240129225602.3832449-2-charles.perry@savoirfairelinux.com>
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com>
 <20240129225602.3832449-2-charles.perry@savoirfairelinux.com>
Message-Id: <170657410397.50510.3267645071897066696.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: fpga: xlnx,fpga-slave-selectmap: add
 DT schema


On Mon, 29 Jan 2024 17:56:01 -0500, Charles Perry wrote:
> Document the slave SelectMAP interface of Xilinx 7 series FPGA.
> 
> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
> ---
>  .../fpga/xlnx,fpga-slave-selectmap.yaml       | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-selectmap.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-selectmap.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
Error: Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-selectmap.example.dts:19.9-14 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-selectmap.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240129225602.3832449-2-charles.perry@savoirfairelinux.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


