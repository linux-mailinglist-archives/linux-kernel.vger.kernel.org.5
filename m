Return-Path: <linux-kernel+bounces-8118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B713281B259
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32E1FB21CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6A74CB22;
	Thu, 21 Dec 2023 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2E0Ar17"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2B74CB20;
	Thu, 21 Dec 2023 09:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24674C433C9;
	Thu, 21 Dec 2023 09:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703150719;
	bh=h5FfKcmX1h2CBN7uYHKgWA9iWr+dI00FJt+rdcmVXHg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=a2E0Ar17bKOR0RpDNgWbsS0OvBqldmTW+euxBc6XlIZmxDmn9SAqLOQGUXdxeEOWU
	 /Qd4V3ue4Bbs0W5AoFv1a1/vwaQYZlMupRaA3UXWe78clnRXgviOhJidccodjb+CBv
	 ZtvwSUiotQA5g8S93q6+kc67JXg5n8hxD7NIWF4gR/CCgNIor7xllMoSx3lsVWLe1+
	 pVRtMVhtHXxgWiPfWYDETWhuOaPZXzCm1GGElW/Oa49yXgf7uptIQG+4nMTHINhhIa
	 QBWYmy6HlZ9xSQBo2VzJ/7SxbJYKRGUekIJnUhEmy41IO5z1rlVaAdoQpqJpIhl/UJ
	 xPKKsxWKCKbYg==
Received: (nullmailer pid 2898108 invoked by uid 1000);
	Thu, 21 Dec 2023 09:25:17 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Alex Soo <yuklin.soo@starfivetech.com>
Cc: Hal Feng <hal.feng@starfivetech.com>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Albert Ou <aou@eecs.berkeley.edu>, Paul Walmsley <paul.walmsley@sifive.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Ley Foon Tan <leyfoon.tan@starfivetech.com>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>, linux-gpio@vger.kernel.org, Jianlong Huang <jianlong.huang@starfivetech.com>, Drew Fustini <drew@beagleboard.org>, Emil Renner Berthing <kernel@esmil.dk>, Linus Walleij <linus.walleij@linaro.org>
In-Reply-To: <20231221083622.3445726-2-yuklin.soo@starfivetech.com>
References: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
 <20231221083622.3445726-2-yuklin.soo@starfivetech.com>
Message-Id: <170315071703.2898091.9670838272789709931.robh@kernel.org>
Subject: Re: [RFC PATCH 1/6] dt-bindings: pinctrl: starfive: add JH8100
 pinctrl bindings
Date: Thu, 21 Dec 2023 03:25:17 -0600


On Thu, 21 Dec 2023 16:36:17 +0800, Alex Soo wrote:
> Add dt-binding documentation and header file for JH8100 pinctrl
> driver.
> 
> Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> ---
>  .../pinctrl/starfive,jh8100-aon-pinctrl.yaml  | 183 +++++++++++
>  .../starfive,jh8100-sys-east-pinctrl.yaml     | 188 +++++++++++
>  .../starfive,jh8100-sys-gmac-pinctrl.yaml     | 124 +++++++
>  .../starfive,jh8100-sys-west-pinctrl.yaml     | 188 +++++++++++
>  .../pinctrl/starfive,jh8100-pinctrl.h         | 303 ++++++++++++++++++
>  5 files changed, 986 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh8100-aon-pinctrl.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-east-pinctrl.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-gmac-pinctrl.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-west-pinctrl.yaml
>  create mode 100644 include/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-gmac-pinctrl.example.dts:18:18: fatal error: dt-bindings/clock/starfive,jh8100.h: No such file or directory
   18 |         #include <dt-bindings/clock/starfive,jh8100.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-gmac-pinctrl.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231221083622.3445726-2-yuklin.soo@starfivetech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


