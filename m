Return-Path: <linux-kernel+bounces-67963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7268573AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC9C281BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E3CFBE5;
	Fri, 16 Feb 2024 02:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3nJ1BYW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9371ADF78;
	Fri, 16 Feb 2024 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708049365; cv=none; b=kMokT3WAi9G7CD5R3MVHec3Lx3cWLKhrA405HLaViuNVCrD7yBr23Xu4ResCIpX4yIB6wrDxjtsAtK4COQAK1aZixo1MEDnevPP0IVb9m2AthmnMs4iUVgPQe0L3pGKmzq7kiM8aYbEEQ/UZ5dKuBJDHSG9aHbbI75vSkRhCktw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708049365; c=relaxed/simple;
	bh=R6YaCx87OajfziAtKms75OZbQL7/Cg1LbkGn3m8IZcY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=c8p+oQ7yo6AEV3r9dbJi2A+A21tBpNvihodG5egDr8eHOHLeIwolPi9SW7hInEgkejCtEfVOe0TNbVlpcJ8SBzdUckzlu5pIircRa1KlRKlQPD6keawLD0UX9L6VHzdmXz3EVcRlSy5UtXB5MrlFgxzAFqs7bYtsMNGCs1olJBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3nJ1BYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF687C433C7;
	Fri, 16 Feb 2024 02:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708049365;
	bh=R6YaCx87OajfziAtKms75OZbQL7/Cg1LbkGn3m8IZcY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=T3nJ1BYW+Ox+ZMCSGe2a5xt2XlX2IJUNozev7jae2DIdfSssONLQa+7iLt/pcvDbh
	 cmHEevaWAV/Ux1WVMTv1vPpdZ38pitGaIF61+ccyXLlA+HnCJw4A4bMJLZ4fJbPTy2
	 s8XZE2spxUnOplgw76K87AaA8Ffdu3ZWy3WgnIvNttu72ltWV1GIJUbQCNMR1yRpd+
	 GREhW+P7BFsOet5YNiX/QesGpwKPRC9BIJsmgRisxOWguIcx/yzqGvTqWbpXMFFLVF
	 r4EfpUNrXlx2Jj+iPQk2UvUImue+pLXyWahrc5Ys9ER3uPtHxblMGUB0L+jKa8NwM6
	 FGQiad/OoI87g==
Date: Thu, 15 Feb 2024 20:09:23 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, 
 Paolo Abeni <pabeni@redhat.com>, Conor Dooley <conor+dt@kernel.org>, 
 Yisen Zhuang <yisen.zhuang@huawei.com>, netdev@vger.kernel.org, 
 Salil Mehta <salil.mehta@huawei.com>, devicetree@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, 
 Yang Xiwen <forbidden405@foxmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Eric Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>
In-Reply-To: <20240216-net-v1-4-e0ad972cda99@outlook.com>
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-4-e0ad972cda99@outlook.com>
Message-Id: <170804935994.836701.6122628077585764606.robh@kernel.org>
Subject: Re: [PATCH 4/6] dt-bindings: net: add hisilicon-femac


On Fri, 16 Feb 2024 07:48:56 +0800, Yang Xiwen wrote:
> This binding gets rewritten. Compared to previous txt based binding doc,
> the following changes are made:
> 
> - No "hisi-femac-v1/2" binding anymore
> - Remove unused Hi3516 SoC, add Hi3798MV200
> - add MDIO subnode
> - add phy clock and reset
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../devicetree/bindings/net/hisilicon-femac.yaml   | 125 +++++++++++++++++++++
>  1 file changed, 125 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/hisilicon-femac.example.dtb: /example-0/ethernet@9c30000/mdio@1100: failed to match any schema with compatible: ['hisilicon,hisi-femac-mdio']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240216-net-v1-4-e0ad972cda99@outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


