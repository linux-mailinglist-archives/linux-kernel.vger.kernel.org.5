Return-Path: <linux-kernel+bounces-15155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 083458227E0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 05:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF731C22E1F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 04:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A3F171CA;
	Wed,  3 Jan 2024 04:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gvax/kdu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48834171C4;
	Wed,  3 Jan 2024 04:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328E9C433C8;
	Wed,  3 Jan 2024 04:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704257567;
	bh=tvCyrRIjW1YlwmYYyoZdYaJ+9swtlUUOKuunbAY/B6k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Gvax/kdu8sOeGWftPJ+HJSaZgv9R0lLMMmsU/2hMWmqUvdTFNc1nWQ4c/Wvoov3ou
	 DwSyj1TH1iEDxx4976xYd4r1iLwsXGMiKUwWpqEw0NzSN2HCHvyq5jfST7qwh/HxAg
	 kdmA+PwBCDXGBA3cLrmjONDJCCnJlNx39JGlplelxfquBrphYM8lFWjbvbIidioYjt
	 CMe+kuWTS0RnoUf+QqAkUpyouexD+iXxdrjp/zlsOusR51f7hUVLs3+Fob3nZvPcKo
	 BwX/qvoySp7VLWiMbsqrNCQGpWyFr2Uny36Lla35QkERqOAU8WZGA36a6q1vOblgCe
	 2jB0siUwz3sJA==
Received: (nullmailer pid 227217 invoked by uid 1000);
	Wed, 03 Jan 2024 04:52:44 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, devicetree@vger.kernel.org, linux-media@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Robert Foss <rfoss@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20240103-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v1-1-abacaa63a961@linaro.org>
References: <20240103-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v1-0-abacaa63a961@linaro.org>
 <20240103-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v1-1-abacaa63a961@linaro.org>
Message-Id: <170425756490.227176.673951175372345550.robh@kernel.org>
Subject: Re: [PATCH 1/3] media: dt-bindings: media: camss: Add
 qcom,sc8280xp-camss binding
Date: Tue, 02 Jan 2024 21:52:44 -0700


On Wed, 03 Jan 2024 02:18:39 +0000, Bryan O'Donoghue wrote:
> Add bindings for qcom,sc8280xp-camss in order to support the camera
> subsystem for sc8280xp as found in the Lenovo x13s Laptop.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/media/qcom,sc8280xp-camss.yaml        | 512 +++++++++++++++++++++
>  1 file changed, 512 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.example.dts:26:18: fatal error: dt-bindings/clock/qcom,sc8280xp-camcc.h: No such file or directory
   26 |         #include <dt-bindings/clock/qcom,sc8280xp-camcc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240103-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v1-1-abacaa63a961@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


