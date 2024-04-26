Return-Path: <linux-kernel+bounces-160614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E5B8B401C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71A9285355
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD2418EA5;
	Fri, 26 Apr 2024 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuXXwib5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D492A14A96;
	Fri, 26 Apr 2024 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714159380; cv=none; b=Hp4ldS0B34Rt2oIE3EWVtAAqCXBADwkA4HZezyFDlDEZE58mil4jY94roOGciG6SAq6U5VQ/wfKvfLtwOcJCBcJFyOyVY2LUhlD2ba2QUMPkUbkAn+4vrO/vHWzd2TnQrm8HEgy8jYXtyHjQ3D9lGNfk5XCHvQefQ6H+AoAWZUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714159380; c=relaxed/simple;
	bh=OVSV+SEbfc1zfz8pX7msAmdgQGOL8Hi8WJYW9BAU2nE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=B8D17R8v+E5+KfEUhwr1uoytK4HgzvZFuEIcnR9GA6fDtghTNaLTIZqgtuCCMC5W2yZbQxULckd6K4a/T/vEoinGpiuyIzGF8foklePi1waKs8oUtJ7Lj8UOs1K6NoXIO5eLqrItuFItbkhUsbtMpWXhRaJEqlM6+324Cv0ococ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuXXwib5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7ECC113CD;
	Fri, 26 Apr 2024 19:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714159380;
	bh=OVSV+SEbfc1zfz8pX7msAmdgQGOL8Hi8WJYW9BAU2nE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=FuXXwib59Ax8JB6ZoL3eNtEqvuZOmWn8LSE502+HTxnWty4srsSsbymxgckesNsc5
	 EJVSYuzSMp4X144+as44CQavQyCxyCtaoyX5l7YTFA/9lEGA48ML4ohyshbUOQkAE7
	 o8NAJtUAtfpCFlnpRwawwpBiUJc5ku/V6WmIsVSoU4fsdzLHEULYulqfDpSu5ICRTD
	 yJJIRyJN6w/4vxb1AhJNzbkHP5Iq4CHQUImy0z/+qYNwCYa3QGeY19e7YC3pyB2UrQ
	 5nX/zHDoAV1BUZxUIj1gKEtBOVBE38hgoE+YqRzpEJShq+2bm2kD7qkhkZJdUNhLy/
	 ik9D6unUNlMQw==
Date: Fri, 26 Apr 2024 14:22:58 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 Alexandre TORGUE <alexandre.torgue@foss.st.com>, devicetree@vger.kernel.org, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 linux-stm32@st-md-mailman.stormreply.com, Mark Brown <broonie@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Pascal Paillet <p.paillet@foss.st.com>, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20240426203245.v2.1.Ia0a99d90acb512aa020a6e7a8cca8cc1b71f1759@changeid>
References: <20240426183253.1360098-1-patrick.delaunay@foss.st.com>
 <20240426203245.v2.1.Ia0a99d90acb512aa020a6e7a8cca8cc1b71f1759@changeid>
Message-Id: <171415937701.2720387.9777987349037944096.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: st,stm32mp1-pwr-reg:
 add compatible for STM32MP13


On Fri, 26 Apr 2024 20:32:50 +0200, Patrick Delaunay wrote:
> Add new compatible "st,stm32mp13-pwr-reg" for STM32MP13 SoC family.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
> Changes in v2:
> - update for Rob review, only add compatible for STM32MP13 family
> 
>  .../devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml    | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml:15:5: [warning] wrong indentation: expected 6 but found 4 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml: properties:compatible:oneOf: [{'const': 'st,stm32mp1,pwr-reg'}, {'const': 'st,stm32mp13-pwr-reg'}] should not be valid under {'items': {'propertyNames': {'const': 'const'}, 'required': ['const']}}
	hint: Use 'enum' rather than 'oneOf' + 'const' entries
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240426203245.v2.1.Ia0a99d90acb512aa020a6e7a8cca8cc1b71f1759@changeid

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


