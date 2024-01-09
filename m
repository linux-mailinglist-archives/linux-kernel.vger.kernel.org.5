Return-Path: <linux-kernel+bounces-21174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0D6828B42
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942A9283D36
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6C03B794;
	Tue,  9 Jan 2024 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0eRHKFL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8923BB24;
	Tue,  9 Jan 2024 17:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B37C43390;
	Tue,  9 Jan 2024 17:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704821366;
	bh=c+gLcfL86VXXDQGcoWlKSAU2T+iwkLzgo1A26ePprwY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=h0eRHKFLFczLzYmZog7EpW5yCoNe8k9dsIan0ZkJ5pABPRcEvZXA/urUm5UwgvXVo
	 JTl9f+57vN37PZRMLyOuPSIukfnrO5NqyqmEcTV1qLfVjizWGZjALV9hg/w+CpzAkw
	 PHxCBh171p9rIrcCWqJ0TAmMIUa88NWL1OGfQ2ioWObbXBvmZ6F9C4yhbkQo2q81pe
	 i3lgndJr8VaexH21F2X1uLbyS5OFhaXihv0zRfViuDSv0lrKeHsTGW8L2EoRf2gmep
	 KPMFdYqiBq1wX8E2fyqV9twGC9CCTUZLC5HmA5xy0vOita9BvsoPLasS2z6SNfRhhb
	 x2XwgFxtYO1GA==
Received: (nullmailer pid 2805791 invoked by uid 1000);
	Tue, 09 Jan 2024 17:29:24 -0000
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
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-media@vger.kernel.org, Todor Tomov <todor.too@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, Robert Foss <rfoss@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
In-Reply-To: <20240109-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3-2-b8e3a74a6e6a@linaro.org>
References: <20240109-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3-0-b8e3a74a6e6a@linaro.org>
 <20240109-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3-2-b8e3a74a6e6a@linaro.org>
Message-Id: <170482136406.2805773.11743678782463697327.robh@kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: media: camss: Add
 qcom,sc8280xp-camss binding
Date: Tue, 09 Jan 2024 11:29:24 -0600


On Tue, 09 Jan 2024 16:06:03 +0000, Bryan O'Donoghue wrote:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240109-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3-2-b8e3a74a6e6a@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


