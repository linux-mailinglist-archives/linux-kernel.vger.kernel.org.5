Return-Path: <linux-kernel+bounces-20119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6808279FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949DC1C22166
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FC055E77;
	Mon,  8 Jan 2024 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJysBBxa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0AA55E64;
	Mon,  8 Jan 2024 21:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1719AC43390;
	Mon,  8 Jan 2024 21:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704748180;
	bh=tOZeUwu8Ym50TZyoye/7s3VUIMz/brOfUTrnWpL/6c0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LJysBBxajBMPFfDATpJd+uWkPL3Z5fpOojms4mGLvOAO91gF1W9TpCFLbFI6b/Vg9
	 FXZn+YmoSnguYsVRJSiuSOOny/i5cwbpl3Zdv/iitV3842uA67jdfd8ERQD1josYtm
	 Vcc+YUiyGE4jvoONH9istQxAVsBTOloUmkURe68BEBS8U0NVZppgbFNbVKik4XeZZe
	 VfGMuvKJy74wu1sbbyFS6GlX20UK+unzrDKJJDDyrwd1mUyLmLxyjf84eNQaSwaVDm
	 hZ8fwKSbS8gQW9SenAcToLaAj1yYZjNJokMkcpzwic95/GRBpstaVco5lDsWZqDidv
	 Bac3fPiapXvnA==
Received: (nullmailer pid 2140736 invoked by uid 1000);
	Mon, 08 Jan 2024 21:09:36 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: robh+dt@kernel.org, venture@google.com, linux-kernel@vger.kernel.org, sboyd@kernel.org, tali.perry1@gmail.com, linux-clk@vger.kernel.org, yuenn@google.com, mturquette@baylibre.com, openbmc@lists.ozlabs.org, benjaminfair@google.com, krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, devicetree@vger.kernel.org
In-Reply-To: <20240108135421.684263-2-tmaimon77@gmail.com>
References: <20240108135421.684263-1-tmaimon77@gmail.com>
 <20240108135421.684263-2-tmaimon77@gmail.com>
Message-Id: <170474817687.2140623.4004065884295248395.robh@kernel.org>
Subject: Re: [PATCH v22 1/8] dt-bindings: clock: npcm845: Add reference 25m
 clock  property
Date: Mon, 08 Jan 2024 14:09:36 -0700


On Mon, 08 Jan 2024 15:54:14 +0200, Tomer Maimon wrote:
> The NPCM8XX clock driver uses 25Mhz external clock, therefor adding
> refclk property.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/clock/nuvoton,npcm845-clk.yaml      | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.example.dtb: clock-controller@f0801000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/clock/nuvoton,npcm845-clk.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.example.dtb: clock-controller@f0801000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/clock/nuvoton,npcm845-clk.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240108135421.684263-2-tmaimon77@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


