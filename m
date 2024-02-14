Return-Path: <linux-kernel+bounces-64727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A248541FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1ADE284E5C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A54BE62;
	Wed, 14 Feb 2024 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="IBBinqAt"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E343D524;
	Wed, 14 Feb 2024 04:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707884073; cv=none; b=iR5a5wuBXt2dn3EjtSC5eC5WbhVf2ypWgaY2iVkoKtOyM79QEc1AgcGxonqEqlK/Z6BV6W2nEn+zlsHjtT4/AcY6LSmyLE6QiFgrSIodWQyfbttA7GmB0Ggz4BuQSK/MX+xPjatb1Bny9HPjI6PFWk8YgKwJJSUfl4PVFdwY5SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707884073; c=relaxed/simple;
	bh=crnFU8k6nMxj6JY71ROeDrnhyTdlUaUSsz2aPsHqj8o=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BHSWL/hQH0gfw9Eb6LpP4x5gsHLV8EUmGOVG8RQa3e/aP7wJs3Wc3MhDfZHMUXsV7mS00pgqxlsASzMOr5Xz6F6a6iH/4I5V7wTgYXMGxAR2E4MwCUVaRGu/LdWndt7+oW2uLyJ/CDbDhW+OXu3sTOErsiJ26Qm1/EOjAtgv6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=IBBinqAt; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1707884062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eiBT625I2qlHvYLLXothJ7tnuzCBy930SrRvWjZiPo=;
	b=IBBinqAtdzjnhrWHXDlV6WWsjZI6lk67YJJaW7+e/Padr0qOxM3htyl2YEzq6lLLCl6Qvl
	MIJHgmi3mR91OZXfDyjcRThuRIymA499ySpa8osdqDIfd6lxzJ0w0ff57bFgkczwTfwXeL
	r/IZDnEao6NNlMzkjiVT1NB19AmYLj+LXwIHPd66tTse6AZ52+2xZtpMm/uWISCn3wEzZN
	SnKa1YcGaQISsQ4VngTtCs6/7cG6OzMYcE+VGuJTSeHtwKgl9z6eKUFAt/qfaMPK0wLpNM
	Rev1YR2x11cyCPi6/kTxEBdC2x2W+AygUOjAUJE+tr0iN70nc6GJ+MLqtaSg9w==
Date: Wed, 14 Feb 2024 05:14:21 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Tim Lunn <tim@feathertop.org>
Cc: linux-rockchip@lists.infradead.org, Andy Yan <andyshrk@163.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chris
 Morgan <macromorgan@hotmail.com>, Conor Dooley <conor+dt@kernel.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, David Heidelberg
 <david@ixit.cz>, Heiko Stuebner <heiko@sntech.de>, Jagan Teki
 <jagan@edgeble.ai>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Ondrej Jirman <megi@xff.cz>, Rob Herring <robh+dt@kernel.org>, Tianling Shen
 <cnsztl@gmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix vendor strings on Rockchip boards
In-Reply-To: <20240214040731.3069111-1-tim@feathertop.org>
References: <20240214040731.3069111-1-tim@feathertop.org>
Message-ID: <c03220db663279c9e83bab81f3d829e7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Tim,

On 2024-02-14 05:07, Tim Lunn wrote:
> A couple of rockchip boards incorrectly list their vendor as Rockchip
> when they are in fact not manufactured by Rockchip.
> 
> Fix the vendor strings to correctly list the manufacturer

Just checking, have you verified that the old, incorrect "compatible"
strings from the board dts files aren't used anywhere in the kernel 
code,
such as in some drivers?

Otherwise, for the entire series:

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> Tim Lunn (4):
>   dt-bindings: arm: rockchip: Correct vendor for Orange Pi RK3399 board
>   dt-bindings: arm: rockchip: Correct vendor for Banana Pi R2 Pro
>   arm64: dts: rockchip: adjust vendor on Banana Pi R2 Pro board
>   arm64: dts: rockchip: adjust vendor on orangepi rk3399 board
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 8 ++++----
>  arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts    | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts  | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)

