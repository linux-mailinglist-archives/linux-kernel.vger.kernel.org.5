Return-Path: <linux-kernel+bounces-143773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246AE8A3D47
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3523281FBD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE01D45C16;
	Sat, 13 Apr 2024 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPqPPQGs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FEB262BD;
	Sat, 13 Apr 2024 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713021652; cv=none; b=EyzT2bf02XH3SWoGkuvVKJf5vGjy6ZXrqaES3K4Juf9Tvj2ccET/nGMJkYOYCdY5ge8K1/SPzRzv0ySQF7CJi0zQSFF0X5MSqO5vpvncb1asW5i7yAoeLPley7QcSqmFqWQiT8bUXbMz+nYjN6U8rbVURACWH7zCqFy15CtH7XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713021652; c=relaxed/simple;
	bh=e9sE+dyxMVm/wZqrlIHJYPdoNQMkHpKh3LVnji1NKjI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Pdmkxx4yTM4LHzC+M896A+Za+Vcl7fo0dDxvj+G/MCz24U8v4lh/6Arzw5jki4zzX971Ap9jf2/HNbeGpaA8mwLh0VWIc2Y+0rO4CvG3el7l9Y27pjZ+0ELmuw2fDcrp4W93eanJ1Qu+NrqXpa2fQ89Nj5oaL58sisPK4iY62Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPqPPQGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BCFC113CD;
	Sat, 13 Apr 2024 15:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713021651;
	bh=e9sE+dyxMVm/wZqrlIHJYPdoNQMkHpKh3LVnji1NKjI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=UPqPPQGsT44tnV1v64hDHxQL7MTvJtHYutVf0Z1GXK2weBYVXMUZFeq9DyZ6nZ7wv
	 YqUH3CMUsWktkQrCtRpzOsQmp9Zytyn0bmgShOf4zdyCVKVLaM0IwOrY8yuttHwAZ3
	 ejXiwByZgKTxL4q/ivOBrfhzuDKczp9qyhGUzkXbdP2msWtPRVE6n7gONhbRlEXvXx
	 Wi8bHE6xLBBD8BZ6piTuvV8rD2I3BgAzIbRu0Oycg4zqv33qJlzE3wsGV+KYlpmSK8
	 A/O9u+ifMeM/9Ndk2TRZ0X5CdyFW7Uik/1JS4RVSZmq4zXkge0ovdFBjJzrHN4pAiq
	 mcQRc+/T1KuUg==
Date: Sat, 13 Apr 2024 10:20:50 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Etienne Buira <etienne.buira@free.fr>
Cc: Johan Jonker <jbx6244@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 Dragan Simic <dsimic@manjaro.org>, shironeko <shironeko@tesaguri.club>, 
 Jonas Karlman <jonas@kwiboo.se>, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
 linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <ZhqO-DEmh-6TeHrt@Z926fQmE5jqhFMgp6>
References: <ZhqO-DEmh-6TeHrt@Z926fQmE5jqhFMgp6>
Message-Id: <171302164916.1347779.204678982671031418.robh@kernel.org>
Subject: Re: [PATCH] Avoid error message on rk3328 use


On Sat, 13 Apr 2024 15:56:08 +0200, Etienne Buira wrote:
> rockchip,rk3328-grf-gpio is handled as syscon, but syscon mandates
> presence of gpio,syscon-dev node (or it will call dev_err() when probed).
> Correct rk3328.dtsi and related documentation to follow syscon's
> expectations.
> 
> Signed-off-by: Etienne Buira <etienne.buira@free.fr>
> ---
>  .../devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.yaml      | 2 ++
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi                        | 1 +
>  2 files changed, 3 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.example.dtb: gpio: 'gpio,syscon-dev' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/rockchip,rk3328-grf-gpio.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/ZhqO-DEmh-6TeHrt@Z926fQmE5jqhFMgp6

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


