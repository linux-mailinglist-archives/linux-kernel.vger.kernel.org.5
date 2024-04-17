Return-Path: <linux-kernel+bounces-148721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F068A869D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0131B276DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E0A15CD7D;
	Wed, 17 Apr 2024 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWxEEv9M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8088147C65;
	Wed, 17 Apr 2024 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365167; cv=none; b=SWhCilq50PwIPWhzOHlSDLQm4pHNREvwT0d2k8wIOf51EhLj99HV0NiJCn/Wz11vxwHy+fGu18RozorKtXexsBggOS5f3OKECjnKS9PSWDeRybLvZeun0Xx2QcFzIJQKbyoNVR80BPpIePN4Fz5Ar/4/EdlIzJ7e3MDyWopxjGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365167; c=relaxed/simple;
	bh=nwth5K18kK83UEi6wJP8xI+BquYnAkr+5HwUfVqks2I=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=FFujX5PAeilcyakrW/QZkuGWpDt1Q8w9hBt+38jvXb8xn6Fa70D1Wvrr4siQOsNxAKXWznRSoxSM0VlvvHCFin5oUAZLjEijYGnAWByDWqOzjC7cNLYlWkbxEJAfR40mtYXWFei1XXpd7CGebFB8lp6WkgQz89gxTqKTHSVh5N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWxEEv9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D001CC072AA;
	Wed, 17 Apr 2024 14:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713365167;
	bh=nwth5K18kK83UEi6wJP8xI+BquYnAkr+5HwUfVqks2I=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=dWxEEv9MWury7ESRzv4VAracOQqSoBTNibogzr/ULzntrtu8esj6MLIYcKnK4VJyw
	 mTvoCy2FnphHIQgBdOcw1kzzfjP1K45LkwhFVr6ix5bkJujSu0wL2GLlPPau+0XcCo
	 V4wKLoNi6AY2V4gtS7WRRHuKeqONlr/zG00WloTFCqN/DWro2fvZkg8BDt0L35H2A7
	 wvOUwLt857rSQKOkH5cdrnZohxwdFi8qYVjf86bpCZBStFq+EQUcRJltrrdfIBjJjE
	 FnK+5xUluymEBSkw9S11qe6kxGylIL0Xw1tH0E0zNH5VIVp3lBp3jfI6Hd53dTNKTf
	 d3N5zciNi+kHA==
Date: Wed, 17 Apr 2024 09:46:05 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, linux@ew.tq-group.com, 
 alexander.stein@ew.tq-group.com, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 netdev@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 devicetree@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240417-mcp251xfd-gpio-feature-v1-4-bc0c61fd0c80@ew.tq-group.com>
References: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
 <20240417-mcp251xfd-gpio-feature-v1-4-bc0c61fd0c80@ew.tq-group.com>
Message-Id: <171336511901.2347835.5918715791284546096.robh@kernel.org>
Subject: Re: [PATCH 4/4] dt-binding: can: mcp251xfd: add gpio-controller
 property


On Wed, 17 Apr 2024 15:43:57 +0200, Gregor Herburger wrote:
> The mcp251xfd has two pins that can be used as gpio. Add gpio-controller
> property to binding description.
> 
> Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml: properties: '#gpio-cells' is a dependency of 'gpio-controller'
	from schema $id: http://devicetree.org/meta-schemas/gpios.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240417-mcp251xfd-gpio-feature-v1-4-bc0c61fd0c80@ew.tq-group.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


