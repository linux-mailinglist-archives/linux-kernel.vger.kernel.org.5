Return-Path: <linux-kernel+bounces-47432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F0E844DD7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE66291DDB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF2EA35;
	Thu,  1 Feb 2024 00:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YX9cNd5n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EFBA47;
	Thu,  1 Feb 2024 00:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706747366; cv=none; b=WSigBhITFNVHdBumvykh3mcaZuLFViq3ZWIT3OXIDcP04pyglqO82is9FkVmUGORmpzsGPrNxeN59DzbGxP6P887Oy8iUQAEFtZlH8BC3nKAEqQTIv3CYabD4oW3jdYjcgHJCYzpBQ+mG0wcTztX8gicE8LS2ldUyNeVGqnMjaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706747366; c=relaxed/simple;
	bh=Y/SrHT/IyBbLZFRWROvBqEmc7qg87vDdOcmhfxplfE8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=a2dfrzlat4rbVL/gxot3B93L2p0/u9LWY0IjNHrb7YnQfEuTOukaFCfsFzSQ/Tzq5Y6KK342YTDJSy/6ZO6+/XleOIyECe483fz/MlOfONE+TKVyUlOmM9uEhBWrXJ5EchrHw6Q/xR6EM0fxNHRv1h6S+etflV1l6Y4JcahcpX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YX9cNd5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D906C433F1;
	Thu,  1 Feb 2024 00:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706747365;
	bh=Y/SrHT/IyBbLZFRWROvBqEmc7qg87vDdOcmhfxplfE8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=YX9cNd5nsMu9TKfXiOzz4km4HlJuBMQkso0yYJqeOGjjo8AhRRItDvOZF9mn52vrQ
	 1EPfCyzhjMubROS/tB2ZSzBAHtsoMiKtGGQ3cfa7G9MS2OB6xp+xEoQ4Dp60+z7qh3
	 M5goLKHRg/M+KyuCIQlfVI0LLmeH06NT5aquJ1kGvZ5f6MvPZGhNAId0PEC/Vr4qNM
	 if5n/GrUki0BLZr5mBhQo+bw2AdCs2HrrwL4mlKohg39g2t85OWG7Aos6/akbggN/j
	 Oh5t2/IwqFTkT3a+FvJnx30OMW4pzElvuc3JkpNUnpTaI4rrYga8eIfNTv7bDTf5E5
	 iCnoUK0OU9QCA==
Date: Wed, 31 Jan 2024 18:29:24 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Brandon Brnich <b-brnich@ti.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 Darren Etheridge <detheridge@ti.com>, Nas Chung <nas.chung@chipsnmedia.com>, 
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Jackson Lee <jackson.lee@chipsnmedia.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20240131234008.2108672-1-b-brnich@ti.com>
References: <20240131234008.2108672-1-b-brnich@ti.com>
Message-Id: <170674736344.2987842.3265742697245667442.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: media: Add sram-size Property for Wave5


On Wed, 31 Jan 2024 17:40:08 -0600, Brandon Brnich wrote:
> Wave521c has capability to use SRAM carveout to store reference data with
> purpose of reducing memory bandwidth. To properly use this pool, the driver
> expects to have an sram and sram-size node. Without sram-size node, driver
> will default value to zero, making sram node irrelevant.
> 
> Signed-off-by: Brandon Brnich <b-brnich@ti.com>
> ---
>  Documentation/devicetree/bindings/media/cnm,wave521c.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/cnm,wave521c.yaml: sram-size: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240131234008.2108672-1-b-brnich@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


