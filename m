Return-Path: <linux-kernel+bounces-26087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9EE82DB4E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0541F228C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1A110795;
	Mon, 15 Jan 2024 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qv4qfy7y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10620847A;
	Mon, 15 Jan 2024 14:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558BFC433C7;
	Mon, 15 Jan 2024 14:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705329175;
	bh=UDXSE/qtWCzHMmFjVVnygMyOMC3FExubEjUc3q/oLS4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=qv4qfy7yX9RT7tt6dA8ycrcxnkTXIoJBSli7ZdjMfsr9t82l5SQlV87dVby8LzqXL
	 /bo5NU4pAq98klmQM3D/S42jcMrERTJOGfUjwzku+B3nBX+3wPwVIQ6YQqXn81EEff
	 gJzx65ym3W8YnUgTk2ItqzqsS8mxAm85nvu2lcPZcuSsEpOPUAbvGP6p+RRScFLLc5
	 2SpyPkLbCaQHNXx8OTzwuVFHf+Wa/46vd0B2Su73cO0UnWAycTEF0ts2NpymAe36+K
	 bW10U8+uPblfgY3wGlU0eoEWO2V69ehcxXcTPf2yJot/pmZOWtD1JB+ubVeeDAqyqz
	 OsmZKr1Zc6K/A==
Date: Mon, 15 Jan 2024 08:32:54 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Maxime Ripard <mripard@kernel.org>
In-Reply-To: <20240115132009.101718-2-raphael.gallais-pou@foss.st.com>
References: <20240115132009.101718-1-raphael.gallais-pou@foss.st.com>
 <20240115132009.101718-2-raphael.gallais-pou@foss.st.com>
Message-Id: <170532917312.565061.10381473169126019945.robh@kernel.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: display: add dt-bindings for STM32
 LVDS device


On Mon, 15 Jan 2024 14:20:04 +0100, Raphael Gallais-Pou wrote:
> Add "st,stm32mp25-lvds" compatible.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
> Depends on: "dt-bindings: stm32: add clocks and reset binding for
> 	    stm32mp25 platform" by Gabriel Fernandez
> 
> Changes in v3:
> 	- Clarify commit dependency
> 	- Fix includes in the example
> 	- Fix YAML
> 	- Add "clock-cells" description
> 	- s/regroups/is composed of/
> 	- Changed compatible to show SoC specificity
> 
> Changes in v2:
> 	- Switch compatible and clock-cells related areas
> 	- Remove faulty #include in the example.
> 	- Add entry in MAINTAINERS
> ---
>  .../bindings/display/st,stm32-lvds.yaml       | 119 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/st,stm32-lvds.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/st,stm32-lvds.example.dts:18:18: fatal error: dt-bindings/clock/st,stm32mp25-rcc.h: No such file or directory
   18 |         #include <dt-bindings/clock/st,stm32mp25-rcc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/display/st,stm32-lvds.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240115132009.101718-2-raphael.gallais-pou@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


