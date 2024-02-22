Return-Path: <linux-kernel+bounces-76263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AD685F4E0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04C12887C4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585203987A;
	Thu, 22 Feb 2024 09:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mq6ogYCl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9180739854;
	Thu, 22 Feb 2024 09:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708595084; cv=none; b=fiq3kEHMgYwsZAAbszYosNhrwhHn4kT7tnhbl5nnUZx5kcMQNU6//7AtPx8x2uX5hbNOJ43rdntiK5Yt1fsHkg0fsZmHpc6jMmyjmvTWB3PEQn1XLmigGe9BD9seeLUQMfxsLcQihJKxzF77MK6/a0RvyDuTcV2PUgrr/vDGK2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708595084; c=relaxed/simple;
	bh=AZb0GKWTjyQuJy4d01ujzb9cgMUxShN7fSsHS7F4YvU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=nfIy2DrSXJARaQqS+8wpu35K/V/rqTnol2odOj7iBXmoR9JsOoIESW+6yACcd1Rqt3AM5Lo8lHWvvWWSAscoBQIosABC+EQ8OvnX0ljs2pIlV45oxVZ5Ve5hxQnqWizo6YsEafEvUKJJ/JVjz5zeGn4gcGmsZDq8dqKctfRJC5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mq6ogYCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78F5C433F1;
	Thu, 22 Feb 2024 09:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708595084;
	bh=AZb0GKWTjyQuJy4d01ujzb9cgMUxShN7fSsHS7F4YvU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=mq6ogYClJpPyCBivw+KiXP03j3AHNQyc/WKFJWpx0X+9+Nc7Wy9VFgTHToteLVyW0
	 9stLolKoOtDMbXFjfk6b9yz4DYhIwxtKdyBA5pIF5m8+XQzl4FvDMp9sNFq9D1hgfP
	 h4W0ZK/g0bys6rwMFCHoExcbTC2GagotPpR6paBLOUi9lf86G/lirnFmsGh4XzB6rF
	 4H1tEYPtXKSqc19nrmNVXo3jSQixt1DJrLe9AJk89w96C2BjZGL0dZTGPHXvfY8Ytw
	 FQbeIWjF4QEVQxcrTQ/poZ29/znbqlQrmy500yfAiCiK1ZR/flaqllVLjpdV5DPr93
	 dyFNZJMojeVjw==
Date: Thu, 22 Feb 2024 02:44:42 -0700
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Seven Lee <wtli@nuvoton.com>
Cc: KCHSU0@nuvoton.com, devicetree@vger.kernel.org, SJLIN0@nuvoton.com, 
 YHCHuang@nuvoton.com, broonie@kernel.org, lgirdwood@gmail.com, 
 robh+dt@kernel.org, CTLIN0@nuvoton.com, supercraig0719@gmail.com, 
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, scott6986@gmail.com, 
 dardar923@gmail.com, alsa-devel@alsa-project.org
In-Reply-To: <20240222083825.190854-2-wtli@nuvoton.com>
References: <20240222083825.190854-1-wtli@nuvoton.com>
 <20240222083825.190854-2-wtli@nuvoton.com>
Message-Id: <170859508176.1881441.18147139867694471359.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: Added schema for
 "nuvoton,nau8325"


On Thu, 22 Feb 2024 16:38:24 +0800, Seven Lee wrote:
> Added a DT schema for describing nau8325 audio amplifiers.
> 
> Signed-off-by: Seven Lee <wtli@nuvoton.com>
> ---
>  .../bindings/sound/nuvoton,nau8325.yaml       | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml: properties:nuvoton,dac-vref:enum:0: 'VDDA' is not of type 'integer'
	hint: An integer type must have integer constraints
	from schema $id: http://devicetree.org/meta-schemas/types.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml: properties:nuvoton,dac-vref:enum:1: 'VDDA*1.5/1.8V' is not of type 'integer'
	hint: An integer type must have integer constraints
	from schema $id: http://devicetree.org/meta-schemas/types.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml: properties:nuvoton,dac-vref:enum:2: 'VDDA*1.6/1.8V' is not of type 'integer'
	hint: An integer type must have integer constraints
	from schema $id: http://devicetree.org/meta-schemas/types.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml: properties:nuvoton,dac-vref:enum:3: 'VDDA*1.7/1.8V' is not of type 'integer'
	hint: An integer type must have integer constraints
	from schema $id: http://devicetree.org/meta-schemas/types.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/nuvoton,nau8325.example.dtb: codec@21: nuvoton,dac-vref:0: [2] is not one of ['VDDA', 'VDDA*1.5/1.8V', 'VDDA*1.6/1.8V', 'VDDA*1.7/1.8V']
	from schema $id: http://devicetree.org/schemas/sound/nuvoton,nau8325.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/nuvoton,nau8325.example.dtb: codec@21: Unevaluated properties are not allowed ('nuvoton,dac-vref' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/nuvoton,nau8325.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240222083825.190854-2-wtli@nuvoton.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


