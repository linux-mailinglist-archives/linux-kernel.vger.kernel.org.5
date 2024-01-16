Return-Path: <linux-kernel+bounces-27291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA4C82ED63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1122285799
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977791B7FD;
	Tue, 16 Jan 2024 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQUkAm9A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F7F1B5BF;
	Tue, 16 Jan 2024 11:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F047C43390;
	Tue, 16 Jan 2024 11:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705403329;
	bh=UBxcbAnXiks5IiAwgVqn56UX+EH62CTPUKLNeWoIi7w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=VQUkAm9A2QilJX7x2yVaKl/d9/RSzntd55pS7Xev/oZ17pR4WvPvX3Y+E47jGx8Xr
	 eBO/wp4+0fsP5LgE2NV0bvlck439YvZTva/CZUQOH08csOTb7M0uGefH7ocNUZHkrP
	 VaVFADSpZAqGD9dkz8gMFLlulmrTkDNH9c/6w67Z1T6bFmmOIjiokSIrk645mLtLIh
	 h7mPj5rVy1g+/VqE5XzrT2FUzsTp/4pzdTQ9m7UI4qb/D/HONMuAbNpHCUuQRC+Yy3
	 s6n39AFDMwazRYSaDygMtstg8GkAfEDBYFi5cmecdWEBwz4MXgjvbkQgRAcThdPG/F
	 mZdeCJHTKGscA==
Date: Tue, 16 Jan 2024 05:08:48 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Tim Lunn <tim@feathertop.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Lee Jones <lee@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Zhang Qing <zhangqing@rock-chips.com>, Chris Zhong <zyw@rock-chips.com>, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 devicetree@vger.kernel.org
In-Reply-To: <20240116084618.3112410-4-tim@feathertop.org>
References: <20240116084618.3112410-1-tim@feathertop.org>
 <20240116084618.3112410-4-tim@feathertop.org>
Message-Id: <170540332496.3326672.17840639764491593170.robh@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: rockchip: Update rk809 example with
 audio codec properties


On Tue, 16 Jan 2024 19:46:18 +1100, Tim Lunn wrote:
> Update the example provided to include the properties for using
> rk817 audio codec.
> 
> Signed-off-by: Tim Lunn <tim@feathertop.org>
> ---
> 
>  Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/mfd/rockchip,rk809.example.dts:39.32-33 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/mfd/rockchip,rk809.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240116084618.3112410-4-tim@feathertop.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


