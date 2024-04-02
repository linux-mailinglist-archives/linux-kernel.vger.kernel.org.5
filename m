Return-Path: <linux-kernel+bounces-128396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B12F895A4E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DEB8B2256D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD28815990C;
	Tue,  2 Apr 2024 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="XZg5fpzW"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922752AD1E;
	Tue,  2 Apr 2024 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712077113; cv=none; b=vDEnnZfja4jcUl7sGAdi2IVTiCC7hFNgFX8L1QVaDZScks2XDfZIRTIK2xuhK43EnVAIGiQ6skACYRPguaZnq8MCh6GxbnOGu6iP8L8jYPuYH4GzL9un6wq4u6DRrzUYANqc8M35lUvETIrOwirMLaj/aXoNX5xhTa+D3MzNmzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712077113; c=relaxed/simple;
	bh=wOvlVcl5Y+hKCXh5u+EybZ08B+K533ukXPTMhetj+lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9QBonq00EwmvUY8gANKeOlTLZUDDw0D/NzDs6clQqPUruuqHiR6u9HzhvN5/0WRDJGvqnZdnehPWPWfQIWfVJLg1mRtAQTEJ4YgmDNIqs5iW3DJhxUT4zXOQs3MoNvixqvClfqAhNLxQ2Ar7u7ar0TLR9lrmS4v0LGrpPI2518=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=XZg5fpzW; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 2C3601FE3C;
	Tue,  2 Apr 2024 18:58:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1712077108;
	bh=utzYA5Fyh93RENun8mB8vS2Q+ce6cCxI3nfBu0JZLuQ=; h=From:To:Subject;
	b=XZg5fpzWJVjLjWUgVBHzBN3Lf4Xij4d/DO/83txUtyC96G7UJ8KGQBnmKxhaWOtws
	 N7NKacSxaMn44EQlJojNvJFu50IgdKTmi0Jug3rDfV20lClorRfJ11DR9DptVapvWl
	 Fs3fh693ovE+QOiv87lOIhkwN4Lwr6UiTuzVR8n5U6QBfL7CAg6ZO4GIiaWVUWb065
	 7pr/oAJavB8cqnTIC0kFvln/KZk1/hpM9WK+5JyHl0LUXrSZPlSwSxy1jdf1vp+RC7
	 qbacOxptg7mgrUvbR8aYwu+8DXZEwewAIvfT3uGz3C0+7IQZmuC1fmep/UdazNNRpo
	 /+LR6uq7BPkYg==
Date: Tue, 2 Apr 2024 18:58:24 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Michael Walle <mwalle@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s: Disable ethernet ports by
 default
Message-ID: <20240402165824.GA32125@francesco-nb>
References: <20240402151802.3803708-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402151802.3803708-1-mwalle@kernel.org>

Hello Michael,

On Tue, Apr 02, 2024 at 05:18:02PM +0200, Michael Walle wrote:
> Device tree best practice is to disable any external interface in the
> dtsi and just enable them if needed in the device tree. Thus, disable
> both ethernet ports by default and just enable the one used by the EVM
> in its device tree.
> 
> There is no functional change.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> This should also be true for all the other SoCs. But I don't wanted to
> touch all the (older) device trees. j722s is pretty new, so there we
> should get it right.
> ---
>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 5 +----
>  arch/arm64/boot/dts/ti/k3-j722s.dtsi    | 8 ++++++++
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index d045dc7dde0c..afe7f68e6a4b 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -224,14 +224,11 @@ cpsw3g_phy0: ethernet-phy@0 {
>  };
>  
>  &cpsw_port1 {
> +	status = "okay";

status should be the last property, according to the dts coding guidelines.

>  	phy-mode = "rgmii-rxid";
>  	phy-handle = <&cpsw3g_phy0>;
>  };

Francesco


