Return-Path: <linux-kernel+bounces-18565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80260825F6D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 13:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206B81F221A9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 12:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3BB7460;
	Sat,  6 Jan 2024 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrEdypnU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F363B6FAE;
	Sat,  6 Jan 2024 12:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3244C433C7;
	Sat,  6 Jan 2024 12:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704543350;
	bh=cABL46fpGQIFj7II8jVK92sjpTNi0UyS6ulbvmxPVrI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lrEdypnUC+MOSjqedtjkkPfTB6x/r0bE0Hc2Ss3kMU9J37gDD6dgVHUBpY6TnUSbn
	 KWxm5qt+NWuWzw+lvaf3ukZcegld180sJWUuTfrECUpynNFeZKhxnkiusybA/FHvQI
	 RiFsYM9VvMFkPJXsCj/hrIsfeP8tP66DOrS4+IxyvuXLpdZ56WEz0EMmU1wDYpfCFv
	 XOUv34eDvy2uzbLwGR3Mx5XMsGofQ39eZBW7wIDK8EvyWXoJRDeZp1LHazGcTvG8gk
	 XjLF+3Hquz7LYwrcRySzZ/owtw+dgk517kI5KHKrbGMExcjZ80GYyECH8MXATpSc2P
	 6N0Plih1RItvQ==
Received: (nullmailer pid 914644 invoked by uid 1000);
	Sat, 06 Jan 2024 12:15:48 -0000
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
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, sre@kernel.org
In-Reply-To: <20240106101435.2927116-2-bhavin.sharma@siliconsignals.io>
References: <20240106101435.2927116-1-bhavin.sharma@siliconsignals.io>
 <20240106101435.2927116-2-bhavin.sharma@siliconsignals.io>
Message-Id: <170454334882.914615.2127705669393189024.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: power: supply: stc3117: Convert to DT
 schema format
Date: Sat, 06 Jan 2024 05:15:48 -0700


On Sat, 06 Jan 2024 15:44:34 +0530, Bhavin Sharma wrote:
> Convert the binding to DT schema format.
> 
> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> ---
>  .../bindings/power/supply/stc3117-fg.yaml     | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/stc3117-fg.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/power/supply/stc3117-fg.yaml:4:6: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/power/supply/stc3117-fg.yaml:5:10: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/power/supply/stc3117-fg.yaml:39:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/power/supply/stc3117-fg.example.dts'
Documentation/devicetree/bindings/power/supply/stc3117-fg.yaml:39:1: found a tab character where an indentation space is expected
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/power/supply/stc3117-fg.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/power/supply/stc3117-fg.yaml:39:1: found a tab character where an indentation space is expected
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/stc3117-fg.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240106101435.2927116-2-bhavin.sharma@siliconsignals.io

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


