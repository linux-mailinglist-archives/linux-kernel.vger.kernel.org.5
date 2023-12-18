Return-Path: <linux-kernel+bounces-3862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD58E817422
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD9E28222F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0D537881;
	Mon, 18 Dec 2023 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdEYnNi0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1291D200C0;
	Mon, 18 Dec 2023 14:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438EEC433C8;
	Mon, 18 Dec 2023 14:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702910914;
	bh=Nl/4Qju8StrRIofVcTdVeGpmbqeL4PjNP1NAI3w2Biw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TdEYnNi0HD1pTzTsCxVjg07p8VmSZlcpuYuu9jZDnd4KLp6h24Uox/LC/G5VWYfZI
	 INgPRbB5yVwG+fBPMlXaicwaIWEtC3h4/lbTxT7yf9w7VREY5SBF3xqryU72nnjTej
	 InTQveRKJluXad38RyMvVbvldJk1UnEJMMm7XQFzqZWqYyHyUWUaEWUR2/1dh3gRFd
	 KsDeO4nvGicz+RbzPr8SJHJJrQmsuqWrLjvlTZ3HK7CIv9pVuf5Lfpv/Cgu21gNgdV
	 G7Q7aj+AJabj73GT5d73y0RmbReHZ3NLgA9FYv7h2yekBb3abZa5X8MH5hD6eVSZ12
	 I/4uexH/YOIjQ==
Received: (nullmailer pid 3792451 invoked by uid 1000);
	Mon, 18 Dec 2023 14:48:32 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20231218133722.16150-1-zajec5@gmail.com>
References: <20231218133722.16150-1-zajec5@gmail.com>
Message-Id: <170291091219.3792434.8389294947030479112.robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: layouts: add U-Boot
 environment variables layout
Date: Mon, 18 Dec 2023 08:48:32 -0600


On Mon, 18 Dec 2023 14:37:19 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot env data is a way of storing firmware variables. It's a format
> that can be used of top of various storage devices. Its binding should
> be an NVMEM layout instead of a standalone device.
> 
> This patch adds layout binding which allows using it on top of MTD NVMEM
> device as well as any other. At the same time it deprecates the old
> combined binding.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../bindings/nvmem/layouts/u-boot,env.yaml    | 55 +++++++++++++++++++
>  .../devicetree/bindings/nvmem/u-boot,env.yaml |  6 ++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/nvmem/u-boot,env.example.dtb: partition@40000: 'ethaddr', 'reg' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/nvmem/layouts/u-boot,env.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/nvmem/u-boot,env.example.dtb: partition-u-boot-env: 'ethaddr' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/nvmem/layouts/u-boot,env.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231218133722.16150-1-zajec5@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


