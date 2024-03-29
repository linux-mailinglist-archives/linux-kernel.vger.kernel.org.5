Return-Path: <linux-kernel+bounces-125437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C52C8925EB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA221F232EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1508F13B59A;
	Fri, 29 Mar 2024 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGGzvyaI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423811369BC;
	Fri, 29 Mar 2024 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746568; cv=none; b=BC4V9bkv96NOoqE880TWW9CKaDws8FkUc9tkDMHdZBulBlyBNHCemh8UaagPeTYWzfomo046tsy4VCKqkVsRgr4GkMm6EC+I9Sl9ENBelPYyTjnx9tjmHLl12FJt4zZYQq71fO2h/dZn+jYa5O22h2qTDjG8M+3j4WHqpCChWI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746568; c=relaxed/simple;
	bh=frTIQdPZxPcetXeIcI9VZPItbQuzzwbyhxpVJqnP89s=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=F+F82fqUw8avZdmwCptRuii5zByVUf5dMAE0I7lxYkUyWfllTRtOUc7n8WvsV/SNbNcT5V5yiArkXbRnXhPua7sl9FSJlE4LubulMs0bUQ8Zc2rr1NDio+abWj6uGQRvi4+PlfOMLj1i+N4UAeRvGXRvaUhUz+XxR9qCfT8vl+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGGzvyaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E699AC433C7;
	Fri, 29 Mar 2024 21:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711746568;
	bh=frTIQdPZxPcetXeIcI9VZPItbQuzzwbyhxpVJqnP89s=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=UGGzvyaIzrQ834whCRMuyMdA6c/lXXAzqJh8Owr/G7ImZkQD7/0qfr4d03ggrjX9O
	 mYUGGAW06AGURYegfFWo2aAxPClo2qSf4GwZbrPuNOQF0MRMgiSsNh6E46hnHuJmoD
	 F6UipWhZO8KoQzWUK67j/JY80MHIxMHtobu1+zBqffw4LXknPiyt3p52y6eE8n29S8
	 KcCiD9R9WMfgrjYHNSIbsgHQq1pL/UWJVvWf5fifmFnW7ipGJjXz86/tTFWOj6Kpe4
	 uHt7ivYfPlmGXg5aLlkMKyJRAsJ3ky8QwJPvqOFGAXZLzdPu73faqQefuaaMSp+L7c
	 3JcJk5rYdjWcA==
Date: Fri, 29 Mar 2024 16:09:26 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Witold Sadowski <wsadowski@marvell.com>
Cc: conor+dt@kernel.org, linux-spi@vger.kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, pthombar@cadence.com, 
 linux-kernel@vger.kernel.org, broonie@kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20240329194849.25554-2-wsadowski@marvell.com>
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240329194849.25554-2-wsadowski@marvell.com>
Message-Id: <171174656589.1187012.1155192030576815322.robh@kernel.org>
Subject: Re: [PATCH 1/5] spi: cadence: Add new bindings documentation for
 Cadence XSPI


On Fri, 29 Mar 2024 12:48:45 -0700, Witold Sadowski wrote:
> Add new bindings:
>  - mrvl,xspi-nor compatible string
>    Compatible string to enable Marvell XSPI modification
>  - Multiple PHY configuration registers
>  - base for xfer register set
> 
> Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
> ---
>  .../devicetree/bindings/spi/cdns,xspi.yaml    | 84 ++++++++++++++++++-
>  1 file changed, 83 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/cdns,xspi.yaml: properties:compatible: [{'const': 'cdns,xspi-nor'}, {'const': 'mrvl,xspi-nor'}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/cdns,xspi.yaml: properties:compatible: [{'const': 'cdns,xspi-nor'}, {'const': 'mrvl,xspi-nor'}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/cdns,xspi.yaml: ignoring, error in schema: properties: compatible
Error: Documentation/devicetree/bindings/spi/cdns,xspi.example.dts:88.23-24 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:427: Documentation/devicetree/bindings/spi/cdns,xspi.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240329194849.25554-2-wsadowski@marvell.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


