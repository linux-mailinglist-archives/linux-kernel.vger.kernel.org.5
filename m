Return-Path: <linux-kernel+bounces-150380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 817B48A9E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36931C21032
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D1A16C6AF;
	Thu, 18 Apr 2024 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DTNgL942"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3F4165FDF;
	Thu, 18 Apr 2024 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453714; cv=none; b=WajEzu8Z9lkMVp1f0n7HyNg+gIILx9aplSJoadhYJ9gNmTq0gVKvsbTrI72RCVzOWJqhvfGBZAlOC3zHxhgfAAivfMZ4JeScZLwrvoE4nNP5MCtps3RFUgGAclvgOW1YvfNNsFTZYR9X0dCc4GHAmItdv1n0X+PGv3qTe7MM0XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453714; c=relaxed/simple;
	bh=Sj2T2GqmIXzYV36d3EH7j3YeXoPD5SdRIQ7jgKqJp9I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YuGbCABmpGzVzSsku1e8kAXeUQp8ISmTHRXiCcpkbcLlOq/PZL6nLG59izsSolfN0W61NrXOlfgaE7cxQUtsFoQPWLD4P7Bzx+7+sm+hA65zEZ2JCN3bZRCdXzKt8n/7jLOS1L+9gGlkJrbAK30CoHQuHKguElB3I9BFIe+b0EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=DTNgL942; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713453710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7fMWbqaFsM/KieslA1BmEyHQ9S+JXnIJSHWI/V0HmwY=;
	b=DTNgL942/Wl+ESKEy5T4jd5tiyNq98yzPLKFVmAjoOiafOhRweIifgH5G5h9BzErnZD4jO
	qXf/GrNGGrBE/rL6WnmDA26kBoQQxcz9IWcgMvyQmhtRuSVMDcl+9z7fezhZ2RnJJ8armz
	vDOAy1VPZMHXCiRmDlv3jdkkcXzTeXgTBkZkU/QxYFbm58SqGCTU3iCZTITn4jbPylEz0J
	ps1WORSL7vBbliWPSTUMo6/17ACwAd6frS+VxQKwQ7vjwnIDjbkqELT9N/p9miqMihCIKz
	8wmIqPalOVcpur0S9uzYCWWUq1pxeJ+MIp4YcmTpiC1btN4TpDkYlgUgAsA2wg==
Date: Thu, 18 Apr 2024 17:21:49 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring
 <robh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: correct the model name for
 Radxa ROCK 3A
In-Reply-To: <20240418130120.67663-2-amadeus@jmu.edu.cn>
References: <20240418130120.67663-1-amadeus@jmu.edu.cn>
 <20240418130120.67663-2-amadeus@jmu.edu.cn>
Message-ID: <39e73428856a6fdf698a5efe6311af0f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-18 15:01, Chukun Pan wrote:
> According to https://radxa.com/products/rock3/3a,
> the name of this board should be "Radxa ROCK 3A".
> Also update compatible to match the model name.
> 
> Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> index c62230308457..e859c075bd46 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> @@ -8,8 +8,8 @@
>  #include "rk3568.dtsi"
> 
>  / {
> -	model = "Radxa ROCK3 Model A";
> -	compatible = "radxa,rock3a", "rockchip,rk3568";
> +	model = "Radxa ROCK 3A";
> +	compatible = "radxa,rock-3a", "rockchip,rk3568";
> 
>  	aliases {
>  		ethernet0 = &gmac1;

