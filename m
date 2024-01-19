Return-Path: <linux-kernel+bounces-31113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E67D83292D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B591C23509
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DB74F1E6;
	Fri, 19 Jan 2024 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDQge1Su"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B753C464;
	Fri, 19 Jan 2024 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705664952; cv=none; b=DSD8MlLddXK3i3/BBvn1A8QKLk8LQPuHN9O5JQMeUWD0IwJu831XCtfakb+8fA4uA3mh58P1KJPClxBfAujC9P5jcxSXbtsTkUdCGxO6wT24O4ml1eGxzQiJ7mJHjUf4eRluqNaJSMb4DipHe6otYYijKQE6WGoEkFnJ+kgg8Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705664952; c=relaxed/simple;
	bh=LnEgDAcwP4asiG6e18d2KxL1mA9Y9YwIw9Zsoo4csx0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=n7NKdVzIWXW9jjIvAFnQvbSqEifgH8FrBCGGGqg5vWTCb76P7kduGpoPtPOYhSgfBEVI2x1SxsV+VAN05O5NvuLIhasxPDXhx5ht1bFd9chKBXkLx5Ww8+2/ithjCxfEZ9p+6yo3rF1QBuMyIuektht3U1STRAUS40M65pZnbi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDQge1Su; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C39C433F1;
	Fri, 19 Jan 2024 11:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705664952;
	bh=LnEgDAcwP4asiG6e18d2KxL1mA9Y9YwIw9Zsoo4csx0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gDQge1Su6vAyXza69IzAcqZ0y7pQHMlk7gzoYq76/S1tHrU3fFroBDheye9q8br7L
	 SHq6zycveQwIHdwCrGQ+MQYIKUgVBZehA1S/st+WH1daX7eeB9IN86ozTyY2d5qdA4
	 lvSBFWc5Fom1EELluxPybs1k2bVYDJv6Dq8KbK87JO9/vDp6DhzgSlOwI1haVws1fF
	 qkqZzgwuj9zXB3j+jRb9WzNeIQpCbjjGdwUFMrmMbUrdiM0sYsAAnBJ+qiaNDjK0Ap
	 aBweExTuOs/2+bDg35CFb6uppZ0XqtthXnpyh2uLOxmBvp9qIDkkj2MAG5Vj14h9Cl
	 jMq0/DN+u95cg==
Date: Fri, 19 Jan 2024 05:49:10 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: gregkh@linuxfoundation.org, conor+dt@kernel.org, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, 
 matthias.bgg@gmail.com, linux@roeck-us.net, heikki.krogerus@linux.intel.com, 
 cy_huang@richtek.com, linux-arm-kernel@lists.infradead.org, 
 chunfeng.yun@mediatek.com, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20240119094105.98312-1-angelogioacchino.delregno@collabora.com>
References: <20240119094105.98312-1-angelogioacchino.delregno@collabora.com>
Message-Id: <170566494967.3600611.15278394895468454608.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: mt6360-tcpc: Drop
 interrupt-names


On Fri, 19 Jan 2024 10:41:04 +0100, AngeloGioacchino Del Regno wrote:
> This IP has only one interrupt, hence interrupt-names is not necessary
> to have.
> Since there is no user yet, simply remove interrupt-names.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml        | 5 -----
>  1 file changed, 5 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.example.dtb: mt6360@34: tcpc: 'interrupt-names' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6360.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.example.dtb: tcpc: 'interrupt-names' is a required property
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mt6360-tcpc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,mt6360.example.dtb: pmic@34: tcpc: 'interrupt-names' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6360.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,mt6360.example.dtb: tcpc: 'interrupt-names' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mt6360-tcpc.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240119094105.98312-1-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


