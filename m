Return-Path: <linux-kernel+bounces-167708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7018BADC8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CB2283936
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D5015358B;
	Fri,  3 May 2024 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8pxkAeR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D115358C;
	Fri,  3 May 2024 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714743297; cv=none; b=QdDI7ui1SE8JkdrvIddevXD/wh+CrcgphpEO3lca11r4Ex6/r+Dwt1ouKzeUTxTL3UXxXYzX+RRiyPnHCkkg+O3Gc+5D0t0MBfwyiUKcp/dulvnoTKj0+47P85km0GALALDGRJGHM5L3J1ln5QWKWKCDf2AncaIlJueFSugTcww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714743297; c=relaxed/simple;
	bh=AGslWhle4NIaFIY0mVoJpE21AAJwhRwa4mBQbv6ZRFM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ZbJR8BoAB0xNMdbXKEZA52H3HLQaEMQIy4+bExftRviAXcSzqF4uD9hM6QPNWrbhO6u0eFBnnh0Vr7+XUb2UscEUOd4rTGiaB8H+ugWSpVJIAiRb9kmRX1KjI3i6PtRQtDZ7IRKFlNkToL8v8T9vZ6HfqLqT+VJNGQmXgq5tuGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8pxkAeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD5EC2BBFC;
	Fri,  3 May 2024 13:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714743297;
	bh=AGslWhle4NIaFIY0mVoJpE21AAJwhRwa4mBQbv6ZRFM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=k8pxkAeRmvIoVFkp6t0iXIq3Gk4/1zk2zsNC6IImZ8848Oj6h/sv3hrHQbujGE8F9
	 Th53FltcJuJmWM2gttqffpQyn0Npyg8ipLNkJYhLH+ngxHqDK3G1LS+F2YNbjnur/a
	 R/IHfBkmS4ZD0JOoIfMgS+WDOyoynrWM0NOQaiPZlSb3RgE2ljKQ9+zpVOgoblwOg7
	 AMSE0fgJ+qkieWzWp+Dv9EdL1WrF4lrrEqD70VPZHcX4aYP5DYV9BCv4w+Seaa6lsj
	 J083SIH0G8vlrWMiVw/r9Cj97UYB9BVmfr3uAj+Q6fBKCffkmIgaQWIMwcnGC6hsgZ
	 OY1Fxq7Iuc7jg==
Date: Fri, 03 May 2024 08:34:55 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Alex Soo <yuklin.soo@starfivetech.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Drew Fustini <drew@beagleboard.org>, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Ley Foon Tan <leyfoon.tan@starfivetech.com>, 
 Jianlong Huang <jianlong.huang@starfivetech.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Emil Renner Berthing <kernel@esmil.dk>
In-Reply-To: <20240503111436.113089-2-yuklin.soo@starfivetech.com>
References: <20240503111436.113089-1-yuklin.soo@starfivetech.com>
 <20240503111436.113089-2-yuklin.soo@starfivetech.com>
Message-Id: <171474329596.655929.15885006298482703153.robh@kernel.org>
Subject: Re: [RFC PATCH v3 1/7] dt-bindings: pinctrl: starfive: Add JH8100
 pinctrl


On Fri, 03 May 2024 19:14:30 +0800, Alex Soo wrote:
> Add documentation and header file for JH8100 pinctrl driver.
> 
> Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
> ---
>  .../pinctrl/starfive,jh8100-aon-pinctrl.yaml  | 260 ++++++++++++++++++
>  .../starfive,jh8100-sys-east-pinctrl.yaml     | 222 +++++++++++++++
>  .../starfive,jh8100-sys-gmac-pinctrl.yaml     | 162 +++++++++++
>  .../starfive,jh8100-sys-west-pinctrl.yaml     | 219 +++++++++++++++
>  .../pinctrl/starfive,jh8100-pinctrl.h         |  13 +
>  5 files changed, 876 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh8100-aon-pinctrl.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-east-pinctrl.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-gmac-pinctrl.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-west-pinctrl.yaml
>  create mode 100644 include/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-gmac-pinctrl.yaml:109:7: [warning] wrong indentation: expected 4 but found 6 (indentation)
/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-west-pinctrl.yaml:96:7: [warning] wrong indentation: expected 4 but found 6 (indentation)
/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-east-pinctrl.yaml:99:7: [warning] wrong indentation: expected 4 but found 6 (indentation)
/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-aon-pinctrl.yaml:136:7: [warning] wrong indentation: expected 4 but found 6 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-gmac-pinctrl.yaml: properties:compatible: [{'items': [{'const': 'starfive,jh8100-sys-pinctrl-gmac'}, {'const': 'syscon'}, {'const': 'simple-mfd'}]}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-gmac-pinctrl.yaml: properties:compatible: [{'items': [{'const': 'starfive,jh8100-sys-pinctrl-gmac'}, {'const': 'syscon'}, {'const': 'simple-mfd'}]}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-west-pinctrl.yaml: properties:compatible: [{'items': [{'const': 'starfive,jh8100-sys-pinctrl-west'}, {'const': 'syscon'}, {'const': 'simple-mfd'}]}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-west-pinctrl.yaml: properties:compatible: [{'items': [{'const': 'starfive,jh8100-sys-pinctrl-west'}, {'const': 'syscon'}, {'const': 'simple-mfd'}]}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-east-pinctrl.yaml: properties:compatible: [{'items': [{'const': 'starfive,jh8100-sys-pinctrl-east'}, {'const': 'syscon'}, {'const': 'simple-mfd'}]}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-east-pinctrl.yaml: properties:compatible: [{'items': [{'const': 'starfive,jh8100-sys-pinctrl-east'}, {'const': 'syscon'}, {'const': 'simple-mfd'}]}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-aon-pinctrl.yaml: properties:compatible: [{'items': [{'const': 'starfive,jh8100-aon-pinctrl'}, {'const': 'syscon'}, {'const': 'simple-mfd'}]}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-aon-pinctrl.yaml: properties:compatible: [{'items': [{'const': 'starfive,jh8100-aon-pinctrl'}, {'const': 'syscon'}, {'const': 'simple-mfd'}]}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-gmac-pinctrl.yaml: ignoring, error in schema: properties: compatible
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-west-pinctrl.yaml: ignoring, error in schema: properties: compatible
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-east-pinctrl.yaml: ignoring, error in schema: properties: compatible
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-aon-pinctrl.yaml: ignoring, error in schema: properties: compatible
Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-west-pinctrl.example.dtb: /example-0/soc/pinctrl@123e0000: failed to match any schema with compatible: ['starfive,jh8100-sys-pinctrl-west', 'syscon', 'simple-mfd']
Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-gmac-pinctrl.example.dtb: /example-0/soc/pinctrl@12770000: failed to match any schema with compatible: ['starfive,jh8100-sys-pinctrl-gmac', 'syscon', 'simple-mfd']
Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-east-pinctrl.example.dtb: /example-0/soc/pinctrl@122d0000: failed to match any schema with compatible: ['starfive,jh8100-sys-pinctrl-east', 'syscon', 'simple-mfd']
Documentation/devicetree/bindings/pinctrl/starfive,jh8100-aon-pinctrl.example.dtb: /example-0/soc/pinctrl@1f300000: failed to match any schema with compatible: ['starfive,jh8100-aon-pinctrl', 'syscon', 'simple-mfd']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240503111436.113089-2-yuklin.soo@starfivetech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


