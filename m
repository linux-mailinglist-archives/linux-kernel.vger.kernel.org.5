Return-Path: <linux-kernel+bounces-85124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A098D86B0B3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CB1BB244AB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E5014DFEC;
	Wed, 28 Feb 2024 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDU0VdTa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80A073508;
	Wed, 28 Feb 2024 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127977; cv=none; b=qQlfGT3auSSmpbhGjSF3zlICZuvne6xYMnS97z7G8JoBBPr6vVzzVLQyolBUo61DFAZSB93D2rYqmtv4o3XWe7YKv1scW37bOFb+HjdbVi6Lv3pAj8vfCr1z7gg6L3u7ZgAnEi5KDazsxrnGXaZd7L5D+rzTI8qGpYuaDr04pJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127977; c=relaxed/simple;
	bh=3Vcpm99aT373qBNpg2K7uKjx9Rk2wfgmFCPnKtQmc/U=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=PqbRg4FElMZ/nsDwy1ESLNmhzYZWJXqC72bWbcQ8YWosu7HhstLGhROlFf0oEYK2WUhndh3sUzzc2b/7WU+7xQShAM/Jvf4vYfPkr33FC8+s3endtlUqi/LK32pGZb1bNOPTPONRnL905RzheW960lqXtMyUkwIiLdQ6hF5B2/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDU0VdTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F2BC433C7;
	Wed, 28 Feb 2024 13:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709127977;
	bh=3Vcpm99aT373qBNpg2K7uKjx9Rk2wfgmFCPnKtQmc/U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=eDU0VdTazddFdW5eVo1UVUNlFp9S1yKdFPotCSwJsSrtAl3vSr6a+zf79B0umnhtJ
	 lolZ2BacU1j3+v+Z3WW6Ujjrn9lib5sDzmJ5BQIpKmsSm+bZpkU5SgEVNMwg1ghd5Q
	 bJ/2z6BQn/BYPlEOb2FV4ZisN2JuaNORlB8jcV56g4jsOhowS0PiAQhyzUia9mS0v5
	 ld8lnt3YiOXdjX7GwEcJ+0FdcwdAWFvbhun2ehrlvsDxY7YYjkWzhEx8tkKkScSgiE
	 zAKwrzo+SRJMaYLiL9PwZchNcJ5UjQZ9HpFkzAkRfseU9nOF1AqnkKvySLko/REjRE
	 zm5Gkla3ZV54Q==
Date: Wed, 28 Feb 2024 07:46:16 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: conor+dt@kernel.org, linux-rockchip@lists.infradead.org, 
 robh+dt@kernel.org, linux-kernel@vger.kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, quentin.schulz@theobroma-systems.com, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
In-Reply-To: <20240227164659.705271-1-heiko@sntech.de>
References: <20240227164659.705271-1-heiko@sntech.de>
Message-Id: <170912782011.3288301.9840425544379703699.robh@kernel.org>
Subject: Re: [PATCH 0/4] Add support for Theobroma-Systems Tiger SoM


On Tue, 27 Feb 2024 17:46:55 +0100, Heiko Stuebner wrote:
> This adds support for the rk3588-based Tiger system-on-module from
> Theobroma Systems and includes support for the combination with
> the Haikou-baseboard.
> 
> Included is also a fix for the rk3588's i2s nodes to remove a
> yet-unsupported devicetree property that slipped in.
> 
> 
> Heiko Stuebner (4):
>   arm64: dts: rockchip: drop rockchip,trcm-sync-tx-only from rk3588 i2s
>   dt-bindings: arm: rockchip: Add Theobroma-Systems RK3588 Q7 with
>     baseboard
>   arm64: dts: rockchip: add RK3588-Q7 (Tiger) SoM
>   arm64: dts: rockchip: add Haikou baseboard with RK3588-Q7 SoM
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |   6 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3588-tiger-haikou.dts | 266 +++++++
>  .../arm64/boot/dts/rockchip/rk3588-tiger.dtsi | 691 ++++++++++++++++++
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |   2 -
>  5 files changed, 964 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
> 
> --
> 2.39.2
> 
> 
> 


My bot found new DT warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y rockchip/rk3588-tiger-haikou.dtb' for 20240227164659.705271-1-heiko@sntech.de:

arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dtb: syscon@fd5a8000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/soc/rockchip/grf.yaml#






