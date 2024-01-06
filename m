Return-Path: <linux-kernel+bounces-18738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A76E5826264
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 00:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E921F218F0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 23:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825D7101DB;
	Sat,  6 Jan 2024 23:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2c6fGJo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B2101EF;
	Sat,  6 Jan 2024 23:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89546C433C8;
	Sat,  6 Jan 2024 23:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704583557;
	bh=Al9b7pXV2lMcYDhcUjppfXRiqoAACjOOL3wemTiQtUI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=n2c6fGJonpcZprmd/eax+R8i0wY9VB49sLj49dwj9ucUWWWpzqJ34Kiwq0MLJsBEJ
	 XqR6vG4mQyXVb9rPwLafKhOMAwIZpEIg9zbesMeS5nK5GuktOVeiw80vzWlqsXMJ78
	 NtlnY33fo8Zx87jO7u1/W3OnE+KRxO7JupxFeOaqTpPRRyQ14TWaPXYZOyulrvHpyC
	 VNrObERZ8qJv2gmOoBPrLwSbTiqHArdos5QwGD0ZGHgI/F35YR1mjQMfemWFAyYcxG
	 VvFX8KM6Klks+2+V9qmKnYBjVJ4bp4hEl+/cArWadL0rzSg1M45+TVHnZYMb0w3xNI
	 WMZHZMDypYJ9A==
Received: (nullmailer pid 2165963 invoked by uid 1000);
	Sat, 06 Jan 2024 23:25:55 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240106-pxa-pwm-yaml-v2-1-9578ff5f2d7f@skole.hr>
References: <20240106-pxa-pwm-yaml-v2-1-9578ff5f2d7f@skole.hr>
Message-Id: <170458355548.2165868.8484556713925715613.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: pxa-pwm: Convert to YAML
Date: Sat, 06 Jan 2024 16:25:55 -0700


On Sat, 06 Jan 2024 21:45:46 +0100, Duje Mihanović wrote:
> Convert the PXA PWM binding file from TXT to YAML.
> 
> The original binding does not mention any clocks, but the PWM controller
> will not probe without a clock.
> 
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---
> Changes in v2:
> - Rename to marvell,pxa-pwm.yaml
> - Note addition of clock property
> - Update trailers
> - Link to v1: https://lore.kernel.org/r/20240105-pxa-pwm-yaml-v1-1-4ded9d00c38f@skole.hr
> ---
>  .../devicetree/bindings/pwm/marvell,pxa-pwm.yaml   | 51 ++++++++++++++++++++++
>  Documentation/devicetree/bindings/pwm/pxa-pwm.txt  | 30 -------------
>  2 files changed, 51 insertions(+), 30 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/pwm/pwm-pxa.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240106-pxa-pwm-yaml-v2-1-9578ff5f2d7f@skole.hr

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


