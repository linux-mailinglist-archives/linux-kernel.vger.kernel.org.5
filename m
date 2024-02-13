Return-Path: <linux-kernel+bounces-63824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D618534E9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD5B1F2B7B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6D55EE72;
	Tue, 13 Feb 2024 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6dYGbKP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895942BB0A;
	Tue, 13 Feb 2024 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838815; cv=none; b=Bx/psWcol+goKkPMyjvtSKxTn/Ya2ZVEsiDRz9fkOrWdXcpT/fvAu3AG+h4JPlPiXt+sXnMYSen/r/eHRztVx8M2ibk+byNIrtbtvD2PwBmvEWX4ox5daI/IywDkBA28g3rw8+mfgDmDsTOO9yvLwzVBuplplMj0u4R7H96/rRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838815; c=relaxed/simple;
	bh=JmajiVMeGbUG4HFBYyxTca1KGVT1oSh0/LH/LKEkvJ4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=bft/IC8QV8/yakagd6iy5/bdLO7hxq959OY180NMfhI25R0X2LLIGrNm0X820nx3D7d/Gk/dHkkH/ulDBs1b/Vmx9hgt1L3ZbbkBQRKhu8/05bsBAHtnbjvzjoMs+V5KA1WE3AFLDw2K4xcCGxxSQqpAPknlBu8rE7Ef+ddpXXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6dYGbKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F76C433C7;
	Tue, 13 Feb 2024 15:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707838815;
	bh=JmajiVMeGbUG4HFBYyxTca1KGVT1oSh0/LH/LKEkvJ4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=g6dYGbKPjQQFYCbry4zR+rem49mPuNDPIM+DPkrvT05yrocfAqVm3uQ4M98mmKxFa
	 lbFW13RvwixjzA8BQzzv1PzjMgqmKbx6CLBwcDkdzhgnB24DZUohfib/NN2RzknBK0
	 VKVu8/KCvML2VSiCoqfTX9y4hf2fMXpaVYzGHpRDxYcl7t+zk0JVvPe40da/KxW7dh
	 O98a798e4PUH5+AAuk6zYhBFJa/5okuQdAgrj16DPoVDm8Gv3T4/dJUktcIa7cmHS2
	 Thi4uFRnjHJed30/JZmYhIzmRv8IzxHfQZbFqK8negW2pKfaRvuS/BrQoiHFa1Oml4
	 FW+mLYxfuTg3w==
Date: Tue, 13 Feb 2024 09:40:13 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Manojkiran Eda <manojkiran.eda@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-aspeed@lists.ozlabs.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 zev@bewilderbeest.net, openbmc@lists.ozlabs.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 jk@codeconstruct.com.au, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Richard Weinberger <richard@nod.at>
In-Reply-To: <20240213-espi_driver-v1-1-92741c812843@gmail.com>
References: <20240213-espi_driver-v1-1-92741c812843@gmail.com>
Message-Id: <170783881259.1420281.1418000696740064343.robh@kernel.org>
Subject: Re: [PATCH] Add eSPI device driver (flash channel)


On Tue, 13 Feb 2024 20:06:08 +0530, Manojkiran Eda wrote:
> This patch adds the driver support for the eSPI controller of
> Aspeed 5/6th generation SoCs. This controller is a slave device
> communicating with a master over Enhanced Serial Peripheral
> Interface (eSPI).
> 
> eSPI supports 4 channels, namely peripheral, virtual wire,
> out-of-band, and flash, and operates at max frequency of 66MHz.
> 
> But at the moment, this patch set only supports the flash channel.
> 
> Signed-off-by: Manojkiran Eda <manojkiran.eda@gmail.com>
> ---
> Hello everyone,
> 
> I'm presenting a revised version of the eSPI device driver patch series found at the following link:
> 
> https://lore.kernel.org/openbmc/20220516005412.4844-1-chiawei_wang@aspeedtech.com/
> 
> This update addresses the issues identified during the review process.
> 
> While the previous patch series attempted to incorporate support for all four different channels of eSPI,
> this new series focuses on upstreaming the flash channel initially, ensuring that all review comments are
> duly addressed, before progressing further.
> 
> Results:
> 
> Successfully conducted a flash update via eSPI.
> 
> Note:
> 
> This marks my inaugural endeavor in contributing code to the kernel subsystem. I kindly request reviewers
> to incorporate as many details as possible in the review comments.
> ---
>  .../devicetree/bindings/soc/aspeed/espi.yaml       | 125 ++++++
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |  16 +-
>  drivers/mtd/mtdcore.c                              |   2 +-
>  drivers/soc/aspeed/Kconfig                         |  10 +
>  drivers/soc/aspeed/Makefile                        |   3 +
>  drivers/soc/aspeed/aspeed-espi-ctrl.c              | 197 +++++++++
>  drivers/soc/aspeed/aspeed-espi-ctrl.h              | 169 ++++++++
>  drivers/soc/aspeed/aspeed-espi-flash.c             | 466 +++++++++++++++++++++
>  drivers/soc/aspeed/aspeed-espi-flash.h             |  45 ++
>  include/uapi/linux/espi/aspeed-espi-ioc.h          | 103 +++++
>  10 files changed, 1134 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/soc/aspeed/espi.yaml:5:6: [error] string value is redundantly quoted with any quotes (quoted-strings)
/Documentation/devicetree/bindings/soc/aspeed/espi.yaml:6:10: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240213-espi_driver-v1-1-92741c812843@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


