Return-Path: <linux-kernel+bounces-24068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 887E582B65B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C83E1F25552
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AEE58236;
	Thu, 11 Jan 2024 21:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGXpUEwc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196025821A;
	Thu, 11 Jan 2024 21:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F02C43390;
	Thu, 11 Jan 2024 21:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705006899;
	bh=vT9ATkHQ5EKl+YtVVvA9nkiRWFb45uIc4mz/IoDatf4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MGXpUEwcdY4/WUf4HhEBogM2Y4+pTu1TLKlV3W0hUAeeXFDqNYWs/+EYZd5oOOAub
	 c3J35TZYNdvV5tWuhi2X0olclyw9Z8kY5HXHlGxyytHdpO7R4ENlMAa2h07C2sfJBl
	 CC2MjX55+tqWpK+RqyGLSqjWBr25Y57r147fpiOIuZoPzJq6f4VfuozP/0fxypE5bR
	 lE+O3axKUK8sZRCc+yfHeuDIY81vltyNRYeiPXtUyAsg0sxpFJC5XxA1BmIoDVN5bv
	 znrVKXmLy+mv1xDRDkSA99RemcpHeVl/SvMhkCZO5PYlJxyAeLu4ul1TjAErx/hGSf
	 uH2ZD4Z+dvw/Q==
Date: Thu, 11 Jan 2024 15:01:38 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: kuba@kernel.org, devicetree@vger.kernel.org, pabeni@redhat.com, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 linux@armlinux.org.uk, edumazet@google.com, netdev@vger.kernel.org, 
 andrew@lunn.ch, davem@davemloft.net, hkallweit1@gmail.com, 
 linux-kernel@vger.kernel.org, afd@ti.com, conor+dt@kernel.org
In-Reply-To: <20240111161927.3689084-2-catalin.popescu@leica-geosystems.com>
References: <20240111161927.3689084-1-catalin.popescu@leica-geosystems.com>
 <20240111161927.3689084-2-catalin.popescu@leica-geosystems.com>
Message-Id: <170500673322.1110591.17657743226495430265.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: net: dp83826: add ti,cfg-dac-plus
 binding


On Thu, 11 Jan 2024 17:19:26 +0100, Catalin Popescu wrote:
> Add property ti,cfg-dac-plus to allow for voltage tuning
> of logical level +1 of the MLT-3 encoded data.
> 
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> ---
>  Documentation/devicetree/bindings/net/ti,dp83822.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/ti,dp83822.yaml: ti,cfg-dac-plus: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240111161927.3689084-2-catalin.popescu@leica-geosystems.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


