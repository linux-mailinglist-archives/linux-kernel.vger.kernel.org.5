Return-Path: <linux-kernel+bounces-69917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F46859034
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA43A1C21653
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE36A7C6C4;
	Sat, 17 Feb 2024 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/YHpuC2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD617C0B1;
	Sat, 17 Feb 2024 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708181721; cv=none; b=jecpJpKWBQGMv2uX0l4MbT/PR98VA8bwL/TRbosatgJ/r2l5yp8/HWI0Ja49vr8Cb+AwNFi/pWnFSkaiKHZV1vyXngEPSVy9ZKlyf5rxtUGmY3miO6SW4smo9r0YeuWrJmJTTTqGEKXC+jr4i2rFkLiWaX5sAyEuXq4Yy0mU9Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708181721; c=relaxed/simple;
	bh=eicC/VhgBa2S/q5nFbRXbBaIGih0GgZsqXc1V3c08P4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=aqNtn0VwSvOV6PJqk65loQH0z9F/1DL5Ns9TiljGwvB9TXkypBZNkEF+1OmZyyOpqE3nQg6tbQfZlNZ5IPr7tS9Yv6p6cZT+qpBAhALSmk8b+5Hu2JqoJ8cPb87klLM1q1ZFYrRpARGZONrOtLu6QEFeuZrdr0pTyo5PLKdTWx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/YHpuC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CFFC433C7;
	Sat, 17 Feb 2024 14:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708181720;
	bh=eicC/VhgBa2S/q5nFbRXbBaIGih0GgZsqXc1V3c08P4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=O/YHpuC2kz2pEhoUuVZ2WKjf/xjV7sQJFEkPbfkWo1i3eGjc+4J2Z6xxmuQu6mfLE
	 bLg8T3invvo9JBAw52oj3l5YsJFVyxAoFrJ7z6AZa6K3/2+O6tuvj8DyU133t/uOZE
	 oks60FNg1cDNgZTuu9h4YQhQpDvesSAnrNwJi30mWjqXa2HZbM6KMBjB/FZP9N4QC6
	 6tp5NLsoh2ANFl7NVO01G08vPZhr67O7xwx8rTZkPmIbjTBkQFQ2u3rFp544/fGkoT
	 bastFFM9vBhTBNgI54dxvQG+9V9Vh+h23lguaXhQfqlDUET8p5uCHbZV+Gqakkh+9H
	 kfJR1/9mxSzFg==
Date: Sat, 17 Feb 2024 08:55:19 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Steven Niu <steven.niu.uj@renesas.com>
Cc: krzysztof.kozlowski+dt@linaro.org, zbigniew.lukwinski@linux.intel.com, 
 linux-i3c@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, 
 alexandre.belloni@bootlin.com, conor+dt@kernel.org
In-Reply-To: <20240217131412.4145506-1-steven.niu.uj@renesas.com>
References: <20240217131412.4145506-1-steven.niu.uj@renesas.com>
Message-Id: <170818171799.2302911.16070158638236981943.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: i3c-hub: Add Renesas RG3MxxB12A1 I3C
 HUB


On Sat, 17 Feb 2024 21:14:11 +0800, Steven Niu wrote:
> Document the Renesas RG3MxxB12A1 I3C HUB.
> 
> Signed-off-by: Steven Niu <steven.niu.uj@renesas.com>
> ---
>  .../devicetree/bindings/i3c/i3c-hub.yaml      | 400 ++++++++++++++++++
>  1 file changed, 400 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/i3c-hub.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/i3c-hub.yaml: id: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/i3c-hub.yaml: id-cp1: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/i3c-hub.yaml: target-reg: missing type definition
Documentation/devicetree/bindings/i3c/i3c-hub.example.dts:18.28-60.11: Warning (unit_address_vs_reg): /example-0/i3c-master@d040000: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/i3c/i3c-hub.example.dts:22.19-59.13: Warning (unit_address_vs_reg): /example-0/i3c-master@d040000/hub@0,0: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/i3c/i3c-hub.example.dts:38.27-42.15: Warning (unit_address_vs_reg): /example-0/i3c-master@d040000/hub@0,0/target-port@0: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/i3c/i3c-hub.example.dts:43.27-50.15: Warning (unit_address_vs_reg): /example-0/i3c-master@d040000/hub@0,0/target-port@1: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/i3c/i3c-hub.example.dts:46.26-49.17: Warning (unit_address_vs_reg): /example-0/i3c-master@d040000/hub@0,0/target-port@1/backend@0,0: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/i3c/i3c-hub.example.dts:51.27-54.15: Warning (unit_address_vs_reg): /example-0/i3c-master@d040000/hub@0,0/target-port@2: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/i3c/i3c-hub.example.dts:55.27-58.15: Warning (unit_address_vs_reg): /example-0/i3c-master@d040000/hub@0,0/target-port@3: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/i3c/i3c-hub.example.dts:78.28-124.11: Warning (unit_address_vs_reg): /example-1/i3c-master@d040000: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/i3c/i3c-hub.example.dts:102.27-106.15: Warning (unit_address_vs_reg): /example-1/i3c-master@d040000/hub@70,3C000000100/target-port@0: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/i3c/i3c-hub.example.dts:107.27-114.15: Warning (unit_address_vs_reg): /example-1/i3c-master@d040000/hub@70,3C000000100/target-port@1: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/i3c/i3c-hub.example.dts:110.26-113.17: Warning (unit_address_vs_reg): /example-1/i3c-master@d040000/hub@70,3C000000100/target-port@1/backend@0,0: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/i3c/i3c-hub.example.dts:115.27-118.15: Warning (unit_address_vs_reg): /example-1/i3c-master@d040000/hub@70,3C000000100/target-port@2: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/i3c/i3c-hub.example.dts:119.27-122.15: Warning (unit_address_vs_reg): /example-1/i3c-master@d040000/hub@70,3C000000100/target-port@3: node has a unit name, but no reg or ranges property
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/i3c-hub.example.dtb: i3c-master@d040000: #address-cells:0:0: 3 was expected
	from schema $id: http://devicetree.org/schemas/i3c/i3c.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/i3c-hub.example.dtb: i3c-master@d040000: hub@0,0: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/i3c/i3c.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/i3c-hub.example.dtb: hub@0,0: $nodename:0: 'hub@0,0' does not match '^i3c-master@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/i3c/i3c-hub.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/i3c-hub.example.dtb: hub@0,0: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/i3c/i3c-hub.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/i3c-hub.example.dtb: hub@0,0: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/i3c/i3c-hub.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/i3c-hub.example.dtb: hub@0,0: target-port@0: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/i3c/i3c-hub.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/i3c-hub.example.dtb: hub@0,0: target-port@0: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/i3c/i3c-hub.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/i3c-hub.example.dtb: hub@0,0: target-port@1: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/i3c/i3c-hub.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/i3c-hub.example.dtb: hub@0,0: target-port@1: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/i3c/i3c-hub.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/i3c-hub.example.dtb: hub@0,0: target-port@2: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/i3c/i3c-hub.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/i3c-hub.example.dtb: hub@0,0: target-port@2: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/i3c/i3c-hub.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/i3c-hub.example.dtb: hub@0,0: target-port@3: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/i3c/i3c-hub.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/i3c-hub.example.dtb: hub@0,0: target-port@3: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/i3c/i3c-hub.yaml#
Documentation/devicetree/bindings/i3c/i3c-hub.example.dtb: /example-0/i3c-master@d040000/hub@0,0/target-port@1/backend@0,0: failed to match any schema with compatible: ['slave-mqueue']
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/i3c-hub.example.dtb: i3c-master@d040000: #address-cells:0:0: 3 was expected
	from schema $id: http://devicetree.org/schemas/i3c/i3c.yaml#
Documentation/devicetree/bindings/i3c/i3c-hub.example.dtb: /example-1/i3c-master@d040000/hub@70,3C000000100/target-port@1/backend@0,0: failed to match any schema with compatible: ['slave-mqueue']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240217131412.4145506-1-steven.niu.uj@renesas.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


