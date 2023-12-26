Return-Path: <linux-kernel+bounces-11490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA5F81E723
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 12:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CD5282D7B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 11:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F9D4E1D7;
	Tue, 26 Dec 2023 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3MC5N9y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A798D4CE18;
	Tue, 26 Dec 2023 11:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC86FC433C8;
	Tue, 26 Dec 2023 11:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703590741;
	bh=MX3UBJgXM8lU6r9sZry71NogLPti+4Vn4Dz7Ag2mntw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W3MC5N9y4YzONV9v0TyhYpCR1aSRJdSoygocJE7bFIA2aTSBCC6QJGPnQBEUQEZSu
	 nA2vW7p+aIk4gTX2zT8/csS9f4RTormMRUxi6PxYnT1mPAubDC/6e4+twmp1kc4ysE
	 bLgksSvuh6Dv/SwCoLnQ/Kb9Is9McoVnax30x39RDDS+BorwKpfIs70wM/7rLZ1oHh
	 ZbOlYXEPtPvryY2U9SZWaE8vLhgE/3csGSNw8E514zngSWGVpSw6R1KnE63BltuoTn
	 JpqVM7mlgthDFqM7XkPkFla8wT6iGoPYOzOcV5s8hyxNrVoCW0IAPJWAdHkQS3RnU5
	 in7qcgdBrOZig==
Received: (nullmailer pid 2315537 invoked by uid 1000);
	Tue, 26 Dec 2023 11:38:58 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: inochiama@outlook.com, aou@eecs.berkeley.edu, conor@kernel.org, linux-rtc@vger.kernel.org, chao.wei@sophgo.com, krzysztof.kozlowski+dt@linaro.org, unicorn_wang@outlook.com, linux-kernel@vger.kernel.org, palmer@dabbelt.com, conor+dt@kernel.org, a.zummo@towertech.it, dlan@gentoo.org, paul.walmsley@sifive.com, alexandre.belloni@bootlin.com, robh+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20231226100431.331616-2-qiujingbao.dlmu@gmail.com>
References: <20231226100431.331616-1-qiujingbao.dlmu@gmail.com>
 <20231226100431.331616-2-qiujingbao.dlmu@gmail.com>
Message-Id: <170359073827.2315471.1581188151554847748.robh@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: sophgo: add MFD subsys
 support for Sophgo CV1800 series SoC
Date: Tue, 26 Dec 2023 05:38:58 -0600


On Tue, 26 Dec 2023 18:04:28 +0800, Jingbao Qiu wrote:
> Add devicetree binding for Sophgo CV1800 SoC MFD subsys.
> 
> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> ---
>  .../bindings/mfd/sophgo,cv1800-subsys.yaml    | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sophgo,cv1800-subsys.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/sophgo,cv1800-subsys.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/rtc/sophgo,cv1800-rtc.yaml
Documentation/devicetree/bindings/mfd/sophgo,cv1800-subsys.example.dts:25:18: fatal error: dt-bindings/clock/sophgo,cv1800.h: No such file or directory
   25 |         #include <dt-bindings/clock/sophgo,cv1800.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/mfd/sophgo,cv1800-subsys.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231226100431.331616-2-qiujingbao.dlmu@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


