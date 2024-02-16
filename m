Return-Path: <linux-kernel+bounces-68545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACC2857C15
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3791C2123F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6951478666;
	Fri, 16 Feb 2024 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUGPy5Av"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964AE2CCB4;
	Fri, 16 Feb 2024 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084249; cv=none; b=PfOERHExzDDk4HtLWIPugmGyhw4FI/JVi4bsRB8Qb0FAkrF8OUXrKTtSBposKfyiXsDr4FKj/YvgUWOpRCBQMUH+J9NhuCTwi51bOH90CXik8OvL9tjWZX2cLkLu3hMUJgDvWm/pJ06WKU7/Nsv2KBmPg0Vzv2/v8gG3X+wpoFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084249; c=relaxed/simple;
	bh=AiU58fW8589Er/kH29F1GSX891zw5yt01fhJPkopF3E=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=nGVG7rv4jIO8Ep92C3eKb0XmftdZlHxIHV04uaL7T864SiY802SWLJUmLfQR22smY9O1SemwOQ9XeSM9ljLGC3JGSYRWirmX/gsFx9kz0PqU3VqOUr+c1GLRafvllLyfpXNI1JYS1WB6+xaBDLZHNV/2WDA4yY0Q/U80bHC4hUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUGPy5Av; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE243C43390;
	Fri, 16 Feb 2024 11:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708084249;
	bh=AiU58fW8589Er/kH29F1GSX891zw5yt01fhJPkopF3E=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=UUGPy5Av1ojPWp42CYdGf9u/2Z4rZP3UEy5r5beg06iuD29Y4Wlo0BrlIii/S23eT
	 1So5b8OUy5EciC2sUMfxbkTDH8suyWqFQ6FVOh43Wv/UpIFvQ9Zge95niV/kP4c6ho
	 m9RLnEWUhglFZjIxeEM0rd59krjGiIjtvBwa5evTkml5XPdYv6bznRrKKs5Z3GAjo6
	 hPkkHLLd3nCyGS50aXOWBYbZ1/2voafgC9mY6Gr2DGJqw1PcAH4WhcOpKAn6v3zHaC
	 sUwC9FSwkwJLbtSxAm60D92MIO/1N7H9XCEccBK2WsXdkPOadRU5SaZQrBhiuH4IjS
	 6YOvWQH1Fh6bA==
Date: Fri, 16 Feb 2024 05:50:47 -0600
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
Cc: netdev@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>, 
 Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 devicetree@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Rob Herring <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Salil Mehta <salil.mehta@huawei.com>, Yang Xiwen <forbidden405@foxmail.com>
In-Reply-To: <20240216-net-v2-4-89bd4b7065c2@outlook.com>
References: <20240216-net-v2-0-89bd4b7065c2@outlook.com>
 <20240216-net-v2-4-89bd4b7065c2@outlook.com>
Message-Id: <170808424648.2323386.17364036307896639662.robh@kernel.org>
Subject: Re: [PATCH v2 4/6] dt-bindings: net: add hisilicon,hisi-femac


On Fri, 16 Feb 2024 18:02:03 +0800, Yang Xiwen wrote:
> This binding gets rewritten. Compared to previous txt based binding doc,
> the following changes are made according to the TRM:
> 
> - No "hisi-femac-v1/2" binding anymore
> - Remove unmaintained Hi3516 SoC, add Hi3798MV200
> - add MDIO subnode
> - add ahb bus clock, phy clock and reset
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../bindings/net/hisilicon,hisi-femac.yaml         | 117 +++++++++++++++++++++
>  1 file changed, 117 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/net/hisilicon,hisi-femac-mdio.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.example.dtb: ethernet@9c30000: mdio@1100: False schema does not allow {'compatible': ['hisilicon,hisi-femac-mdio'], 'reg': [[4352, 32]], '#address-cells': [[1]], '#size-cells': [[0]], 'status': ['okay'], 'ethernet-phy@1': {'reg': [[1]], '#phy-cells': [[0]]}}
	from schema $id: http://devicetree.org/schemas/net/hisilicon,hisi-femac.yaml#
Documentation/devicetree/bindings/net/hisilicon,hisi-femac.example.dtb: /example-0/ethernet@9c30000/mdio@1100: failed to match any schema with compatible: ['hisilicon,hisi-femac-mdio']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240216-net-v2-4-89bd4b7065c2@outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


