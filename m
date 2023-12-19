Return-Path: <linux-kernel+bounces-6082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7582D819466
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310812882A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A933D0D0;
	Tue, 19 Dec 2023 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHRhp2O4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316C13D0BD;
	Tue, 19 Dec 2023 23:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAEEC433C7;
	Tue, 19 Dec 2023 23:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703027608;
	bh=yXicCXSWH5EUUBda6scEiKgMhU/r4oYSFT679x7VNPY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aHRhp2O4EdVLAoyV/ApY8QUYV5FPZkfNj2W4CU8A0ZKgSuP3F0xx+X6Gtd5fNm/Fc
	 c27q85gkNqomuj+Szm2j9c2ih2je6nDr+xSn11zjz2FJYDin/T+silexxeUSeVBSJ1
	 yRQdFs+rDg3KOC2UKjA25Rd6nutGVeUU1om/S7IvrSanpQBR8YqDcW4WIumQYCmf9W
	 7V3zr8mHxnU0Ibm5h8VmZoXPpvgzWWZV2P2toDFyIcJT07lJmMsd4H5HfgSHc5ZfwI
	 LcKzA++q14dUNHQVn0gJe1xPBghZv5yBd8fxIGewwvxjdznfOC4t5Jf7zw5ZZyCeji
	 Zaj7ejGEyUbkQ==
Received: (nullmailer pid 2025101 invoked by uid 1000);
	Tue, 19 Dec 2023 23:13:26 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: linux-rockchip@lists.infradead.org, Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-kernel@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
In-Reply-To: <20231219-rk3308-audio-codec-v2-2-c70d06021946@bootlin.com>
References: <20231219-rk3308-audio-codec-v2-0-c70d06021946@bootlin.com>
 <20231219-rk3308-audio-codec-v2-2-c70d06021946@bootlin.com>
Message-Id: <170302760623.2025074.2958729782154314139.robh@kernel.org>
Subject: Re: [PATCH v2 2/6] ASoC: dt-bindings: Add Rockchip RK3308 internal
 audio codec
Date: Tue, 19 Dec 2023 17:13:26 -0600


On Tue, 19 Dec 2023 15:54:17 +0100, Luca Ceresoli wrote:
> Add device tree bindings document for the internal audio codec of the
> Rockchip RK3308 SoC.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Changed in v2:
>  - reword commit title
>  - add maxItems to resets
>  - remove quotes from reset-names
>  - use percent values for rockchip,micbias-avdd-multiplier
>  - use name compliant to the docs in the example
> ---
>  .../bindings/sound/rockchip,rk3308-codec.yaml      | 98 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 103 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/sound/rockchip,rk3308-codec.example.dts:20.20-21 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/sound/rockchip,rk3308-codec.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231219-rk3308-audio-codec-v2-2-c70d06021946@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


