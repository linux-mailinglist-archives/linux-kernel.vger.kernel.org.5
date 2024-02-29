Return-Path: <linux-kernel+bounces-86711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F9386C967
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13754285B81
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB877D3F2;
	Thu, 29 Feb 2024 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPc9qsae"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDBE76EF5;
	Thu, 29 Feb 2024 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709210746; cv=none; b=vFGcBs7MSSEM2x/GEXwSaj4MY52pNJaFWBvYOUFdG9NnL/jUCrmZlYLjIDW+YOOmpNUUL7+hi0zO6QM15+wEHzYtT2DoWuRNtw78lVz7R7Jq9Z1NDhiGGqeS73YjVbPaT/k/f7rMeKAIE42w70iJSbcH5DKr5+xQlMsRM1qMnLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709210746; c=relaxed/simple;
	bh=tvUemNZGsvgO/MlGsGtmZDvktWQt7kfF2MN28m+YPqk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Qc1GxHv8EW1OUa200PTt1ZyUhuFQFRM/ZgSpp5Si5nQVVvpThCqS5WWoliCjGAKeooQ5bG0kFsF53hsSwkYd6vrpB9YiD4Ask0jk2utIVO32sc2sUngHnPi4A6enHRrwdEsDPIVa1ZzEksZ+27rMJhZOqT8/9rIEUmjyBiS0mnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPc9qsae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70969C433F1;
	Thu, 29 Feb 2024 12:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709210745;
	bh=tvUemNZGsvgO/MlGsGtmZDvktWQt7kfF2MN28m+YPqk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=JPc9qsae5yF7nYjMqTu1ZQijy9A2/KAgWvqucCqIxGSPEmFAz4rUDm5SWJnNN5kIz
	 w/bDCFpYr51AEIIZAhe3ghx3EouHVQoLlMDaxgSdoybVEsC0m4YV5L5Z55FK3WakB6
	 5fORxIEQzoqnA1a604a3wStSKs03djYlmHcCMXuLz3TK24iqv4sbbx329bTnGU5381
	 /DLR4DA2JgbMsdU7j5/o3k1L50NQCZPKpDdehR6ySH3tg9dyCYoLTzWT9KPWHMuH1S
	 UC7KLZI8Stekbah4qVgm/YYb5d+rsCqZZ6zigFWOjeBO3rHRM2B68jelpb2gYI0vqL
	 TGaITSn6E+Miw==
Date: Thu, 29 Feb 2024 06:45:44 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Rob Herring <robh+dt@kernel.org>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240229-pio4-pinctrl-yaml-v1-3-c4d8279c083f@microchip.com>
References: <20240229-pio4-pinctrl-yaml-v1-0-c4d8279c083f@microchip.com>
 <20240229-pio4-pinctrl-yaml-v1-3-c4d8279c083f@microchip.com>
Message-Id: <170921074336.3023845.8016971743332587819.robh@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: pinctrl: at91-pio4: convert Atmel's
 PIO4 bindings to json-schema


On Thu, 29 Feb 2024 17:09:32 +0530, Balakrishnan Sambath wrote:
> Convert the existing text DT bindings of Atmel's PIO4 pincontroller to
> yaml based DT schema.
> 
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> ---
>  .../bindings/pinctrl/atmel,at91-pio4-pinctrl.txt   |  98 ---------------
>  .../bindings/pinctrl/atmel,sama5d2-pinctrl.yaml    | 140 +++++++++++++++++++++
>  2 files changed, 140 insertions(+), 98 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pinctrl/atmel,sama5d2-pinctrl.example.dts:27:18: fatal error: dt-bindings/pinctrl/sama5d2-pinfunc.h: No such file or directory
   27 |         #include <dt-bindings/pinctrl/sama5d2-pinfunc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/pinctrl/atmel,sama5d2-pinctrl.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240229-pio4-pinctrl-yaml-v1-3-c4d8279c083f@microchip.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


