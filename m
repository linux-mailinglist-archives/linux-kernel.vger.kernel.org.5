Return-Path: <linux-kernel+bounces-124084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 517348911FB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07FF81F22F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CEC39863;
	Fri, 29 Mar 2024 03:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdA+CtW4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFC137165;
	Fri, 29 Mar 2024 03:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711682844; cv=none; b=qVWo3iTDAhoQvF3Fcvwx4FZ3mz9cT9ZsCiUkOI99zJ5ugfEOQd0TynKZRgQWlmdDA+WptZwqv1o/cNt8LPjGpiIRNcOm5L2H6/ZAVzDTa0cmbbMan6xLTjyQ151K+NdpUEYkBGS/ZPCdi8Am5/7ZMg6xRkXxHXVuaNwChHhNOK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711682844; c=relaxed/simple;
	bh=XBq7FAybfYroiUaOkqQ3iC8DyKkn51xgtrLSf+qdjHA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=e9oS7Snp7bR4hn7x0VAsK5B4Lhohcn9dsuPy0JMBSVbvAFXs2+GGMoDhQcyiM54qYMFU5/ls6igFj33hVPm5oORCkomnBubOgaEvLqZrUBvt9hodtqQMe6SWxzGjh+eMWK6jzlINBsKHBWY20wYVbHuA/H3R9puXKE9L+eAFUD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdA+CtW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411BBC433C7;
	Fri, 29 Mar 2024 03:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711682843;
	bh=XBq7FAybfYroiUaOkqQ3iC8DyKkn51xgtrLSf+qdjHA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ZdA+CtW4oY+yEwX6Dm9kleIytrg9GiQhcUWg7JwWD4ChR05odzEMLEqbtMU6N9iPU
	 +KU+8FrfGcVnw+jsZEHJOprtzaSmRSmG/3Ug4iiG+8KFs7b41e0gRMkwjK0U8rJYdh
	 jgTJYTknlff0yujt1Ljv0T8nl7Iufr/ACtIlrwdv1CMHqsmRpIKjTLjiRKaSkIkXKL
	 SYf/6A1l2rMp/I1GzTp89uf7FLLQxH70IfhjSCQl0dtGZQLqELvJ92695MhkGedZ7u
	 eR6aqA3IT4/V1No8i7lCLkyF9wpZowAOjRg9VHaa8YxtcTmk5KOnzR6lDMZRWLF4cJ
	 aNJ6gHyEtTM8g==
Date: Thu, 28 Mar 2024 22:27:22 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-spi@vger.kernel.org, Qingfang Deng <qingfang.deng@siflower.com.cn>
In-Reply-To: <20240329015147.1481349-1-dqfext@gmail.com>
References: <20240329015147.1481349-1-dqfext@gmail.com>
Message-Id: <171168284116.1622438.12291948892971487712.robh@kernel.org>
Subject: Re: [RFC PATCH 1/2] spi: dt-bindings: add Siflower Quad SPI
 controller


On Fri, 29 Mar 2024 09:51:46 +0800, Qingfang Deng wrote:
> From: Qingfang Deng <qingfang.deng@siflower.com.cn>
> 
> Add YAML devicetree bindings for Siflower Quad SPI controller.
> 
> Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
> ---
>  .../bindings/spi/siflower,qspi.yaml           | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/siflower,qspi.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/siflower,qspi.example.dtb: spi@c200000: reg: [[0, 203423744], [0, 4096]] is too long
	from schema $id: http://devicetree.org/schemas/spi/siflower,qspi.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/siflower,qspi.example.dtb: spi@c200000: Unevaluated properties are not allowed ('reg' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/siflower,qspi.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240329015147.1481349-1-dqfext@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


