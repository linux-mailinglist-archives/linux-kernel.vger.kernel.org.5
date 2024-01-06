Return-Path: <linux-kernel+bounces-18601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D3E825FE8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540072828F8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB06B79F9;
	Sat,  6 Jan 2024 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ms+Xe2FU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F281ABE5A;
	Sat,  6 Jan 2024 14:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB26C433C7;
	Sat,  6 Jan 2024 14:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704551788;
	bh=Z6nfSKtyFMKfBfwqZITl9eQ0v7SjF99tb+baXN8Wsjg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ms+Xe2FUCLlTFexDslAG8r+I+RMbTNiCsCYj3n1YVIKSanKw90hzwnW6smxVyvvc4
	 kG6c+10QPTixW9eJzoxwEMPn31YEEsnKR23tVSEE2bvgnSGGvrYwgnmVel49XJ/SVd
	 SXS809SpDTQeCZnDcOXM5hqosk5h0qiTzqts14EfKIp/PwhXOjPUI1K1/KxHZPREZQ
	 c5yOJqXs1PZw7VHvSxWwvmhHbXfsbW+WbLUhRxHf6toKzR0SKUPMYPt3ztBnT00t5h
	 FAvOxgB2MoVnd65X6G1iBsw7tmfnqhoeQQHao6+jxh6BXeS4b7BSyAFWWi4lgNGEvN
	 Nymp8pesFy27w==
Received: (nullmailer pid 1158634 invoked by uid 1000);
	Sat, 06 Jan 2024 14:36:26 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, sre@kernel.org, Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>, linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20240106133546.936261-2-bhavin.sharma@siliconsignals.io>
References: <20240106133546.936261-1-bhavin.sharma@siliconsignals.io>
 <20240106133546.936261-2-bhavin.sharma@siliconsignals.io>
Message-Id: <170455178667.1158618.9584358369325670417.robh@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: power: supply: stc3117: Convert to
 DT schema format
Date: Sat, 06 Jan 2024 07:36:26 -0700


On Sat, 06 Jan 2024 19:05:44 +0530, Bhavin Sharma wrote:
> Convert the binding to DT schema format.
> 
> Changes in V2 resolved below errors:
> 	1. string value is redundantly quoted with any quotes (quoted-strings)
> 	2. found character '\t' that cannot start any token
> 
> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> ---
>  .../bindings/power/supply/stc3117-fg.yaml     | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/stc3117-fg.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/power/supply/stc3117-fg.example.dts:18.9-14 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/power/supply/stc3117-fg.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240106133546.936261-2-bhavin.sharma@siliconsignals.io

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


