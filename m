Return-Path: <linux-kernel+bounces-119767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E8288CCCA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCF3327BE3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF1813CC4C;
	Tue, 26 Mar 2024 19:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnettQcM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2AA1272D1;
	Tue, 26 Mar 2024 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480317; cv=none; b=WOyuk2Nq55VlEevZS3YiTOLTJtAQR6RjIbVIHUo1OBwcIyWcFGuNr/RDtwNtwYod2gAwLLU7tGUkI5hZRCDRj0+IoZGokkYgZ+M/5vjHeiFeBdiKBxQl9jIbAY5YRRAaQwDKVb7qmcfOnZM2PlBWAvn9Lt5R7P0WLD0+KoSHCdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480317; c=relaxed/simple;
	bh=EZrkA8k/lLE5hJHBsQBbRLVO8mmgDFjXv/SnhYX5MnY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=KZzOY+cr0M2OrcwpvefdwhI7k1F4RvCvY7BLxZfNRN0cAo1tW3VXJUlma+rYRrMiM9+q0xnkWJmZzV/S4OHwLHN3Bepbh7Igp+mpMJV+fkwXhCe8pDB6Mv1hZH64b1O+Cxg6oEz9geR43JoQjRvKNY20Ir+84i3T3kwwiXWzkBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnettQcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68D7C433F1;
	Tue, 26 Mar 2024 19:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711480317;
	bh=EZrkA8k/lLE5hJHBsQBbRLVO8mmgDFjXv/SnhYX5MnY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=TnettQcMgC+GPeIX6M3vDm6KlVguwfzIDMU59TcyqH4VvFiJPA4WA/zlnLxZpsbzX
	 wa13BGPb7IeI73saRTF5+HFwqyZKIKJLr6EROqM+ZneqCGmJ/3DMSMiYGhvEdv4M7O
	 Sk2CxKResm+1raMxyym/kXTs55CzshgXG0YnJFIFKiBfqF8MRDztPCLPQukATnJy/o
	 yrDsddROheOso8oiui8DRH0SUPCf/C75nkTo0OAQQVus4Du45HODXQ+BaMXAlnlGpL
	 1pu4V935oeEAdrhhTqrBkWLMD3f/PFtq1KAp3E6d9nTtSEJuT0rckFZEAMadIBMYzs
	 vBV86TmCwEGbA==
Date: Tue, 26 Mar 2024 14:11:55 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: conor+dt@kernel.org, kernel@collabora.com, devicetree@vger.kernel.org, 
 sebastian.reichel@collabora.com, heiko@sntech.de, 
 linux-arm-kernel@lists.infradead.org, boris.brezillon@collabora.com, 
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <0f3759ee390f245dac447bbee038445ddfecbec0.1711383286.git.dsimic@manjaro.org>
References: <0f3759ee390f245dac447bbee038445ddfecbec0.1711383286.git.dsimic@manjaro.org>
Message-Id: <171148006524.3222394.1157008244152468379.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: quartzpro64: Enable the GPU


On Mon, 25 Mar 2024 17:19:04 +0100, Dragan Simic wrote:
> Following the approach used to enable the Mali GPU on the rk3588-evb1, [1]
> do the same for the Pine64 QuartzPro64, which uses nearly identical hardware
> design as the RK3588 EVB1.
> 
> The slight disadvantage is that the regulator coupling logic requires the
> regulators to be always on, which is also noted in the comments.  This is
> obviously something to be improved at some point in the future, but should
> be fine for now, especially because the QuartzPro64 isn't a battery-powered
> board, so low power consumption isn't paramount.
> 
> [1] https://lore.kernel.org/linux-rockchip/20240325153850.189128-5-sebastian.reichel@collabora.com/
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y rockchip/rk3588-quartzpro64.dtb' for 0f3759ee390f245dac447bbee038445ddfecbec0.1711383286.git.dsimic@manjaro.org:

Error: arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts:288.1-5 Label or path gpu not found
FATAL ERROR: Syntax error parsing input tree
make[3]: *** [scripts/Makefile.lib:427: arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dtb] Error 1
make[2]: *** [scripts/Makefile.build:485: arch/arm64/boot/dts/rockchip] Error 2
make[2]: Target 'arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dtb' not remade because of errors.
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1387: rockchip/rk3588-quartzpro64.dtb] Error 2
make: *** [Makefile:240: __sub-make] Error 2
make: Target 'rockchip/rk3588-quartzpro64.dtb' not remade because of errors.






