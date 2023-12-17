Return-Path: <linux-kernel+bounces-2662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4427481601C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D826C1F21900
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59E344C8F;
	Sun, 17 Dec 2023 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="YbpPTZaM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267017F8;
	Sun, 17 Dec 2023 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1702826302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YgdXduRKDjKkV05w+ashYe1V8iCTBHNOlwTcti7d7Bg=;
	b=YbpPTZaMhsYWWeel0FpSWWui3jWQCJDkCzwfrjdtdVcTx4QXzqWGYEigcgHzvtexY1gOMr
	hdyQAVCBWOGEuUcgc+e+So8VjVf5EXUezhH9cHLatf0z3ZLyAZYcsDj3MmEkDedK4GqmVK
	Oe/hZCNMcTLTFP1HSx1QgPYLm5lHS507rbHVQN1dUwwftIM74vDS/Cgklpqoxidor5qV7Z
	E6c3pscZ9brmaPVCcjNd9d3FlLdMnDPRqdUNvrWUDzBPQW6jqFbmsoB1PXBhPzHJAmpUvo
	d0dymju33bXOjBWSzTJVqZ3npBfIeoyQxNB+WjrubYZNFy341ROC7gB+wkobLA==
Date: Sun, 17 Dec 2023 16:18:22 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Stefan Nagy <stefan.nagy@ixypsilon.net>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Increase maximum frequency of
 SPI flash for ROCK Pi 4A/B/C
In-Reply-To: <20231217113208.64056-1-stefan.nagy@ixypsilon.net>
References: <20231217113208.64056-1-stefan.nagy@ixypsilon.net>
Message-ID: <edda17071180a91658ced910bdb54be7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-12-17 12:32, Stefan Nagy wrote:
> The ROCK Pi 4A/B/C boards come with a 32 Mbit SPI NOR flash chip (XTX
> Technology Limited XT25F32) with a maximum clock frequency of 108 MHz.
> Use this value for the device node's spi-max-frequency property.
> 
> This patch has been tested on ROCK Pi 4A.
> 
> Signed-off-by: Stefan Nagy <stefan.nagy@ixypsilon.net>

Looks good to me.  It would be nice, if you have time, to include some 
SPI benchmark results before and after the change in the commit message.

Otherwise,

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> Changes from v1:
> - Use the maximum clock frequency the SPI chip actually supports
>   instead of the SPI clock frequency limit of 50 MHz set by the
>   Rockchip SPI driver.
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
> b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
> index d5df8939a..c68f45849 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
> @@ -19,6 +19,6 @@ &spi1 {
>  	flash@0 {
>  		compatible = "jedec,spi-nor";
>  		reg = <0>;
> -		spi-max-frequency = <10000000>;
> +		spi-max-frequency = <108000000>;
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
> b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
> index bee6d7588..6ea3180e5 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
> @@ -37,7 +37,7 @@ &spi1 {
>  	flash@0 {
>  		compatible = "jedec,spi-nor";
>  		reg = <0>;
> -		spi-max-frequency = <10000000>;
> +		spi-max-frequency = <108000000>;
>  	};
>  };
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
> b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
> index de2ebe4cb..5274938bf 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
> @@ -49,7 +49,7 @@ &spi1 {
>  	flash@0 {
>  		compatible = "jedec,spi-nor";
>  		reg = <0>;
> -		spi-max-frequency = <10000000>;
> +		spi-max-frequency = <108000000>;
>  	};
>  };

