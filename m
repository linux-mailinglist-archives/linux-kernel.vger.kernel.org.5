Return-Path: <linux-kernel+bounces-27290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAE082ED61
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40731F2444D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B601AAB5;
	Tue, 16 Jan 2024 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPPGEEQt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7478E1A590;
	Tue, 16 Jan 2024 11:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AE5C433F1;
	Tue, 16 Jan 2024 11:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705403327;
	bh=kJGk0fjidgmzt3ZWgK7tdK17z1gn1n+qBqI3dXSdxbo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QPPGEEQtJlx2/mNwA1qsS0qhQ9WYxoeJknVaQhBPzj4yPVjIbC2ITWDvgRfx4Bguz
	 F8GYZb5yBjzlwEicvSFgNGcHPI9bdPvaMkf78ofPZf8mpy12Bpnf/GENKSZlEe4Bii
	 tiFu+k5ZaNGnwhhibIVscyUtL65C5xp5qB8wudfBM8rGHmqXg7tnq9ipAyIbgxT+PO
	 UFAhDs3dczpZIJnn+/L3GwvwnX83vf5FxqSftYiM8jJHwTSeZaYmZlZkHZnitwec2Y
	 JbtFTaOaqhrKapB5PtuUSuMHtsFJGk8Dg4PoBKXXITlc7Cj1uhyFIpqRBkeBqnkxW2
	 tAAAGjm/BHS+w==
Date: Tue, 16 Jan 2024 05:08:46 -0600
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
Cc: Conor Dooley <conor+dt@kernel.org>, Chris Zhong <zyw@rock-chips.com>, 
 Zhang Qing <zhangqing@rock-chips.com>, Lee Jones <lee@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240116084618.3112410-3-tim@feathertop.org>
References: <20240116084618.3112410-1-tim@feathertop.org>
 <20240116084618.3112410-3-tim@feathertop.org>
Message-Id: <170540332448.3326634.4106682214139586687.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: rockchip: rk809 fix compatible string
 in examples


On Tue, 16 Jan 2024 19:46:17 +1100, Tim Lunn wrote:
> Fix typo in the example specifying wrong compatible string
> 
> Signed-off-by: Tim Lunn <tim@feathertop.org>
> ---
> 
>  Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/rockchip,rk809.example.dtb: pmic@1b: 'vcc10-supply', 'vcc11-supply', 'vcc12-supply' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240116084618.3112410-3-tim@feathertop.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


