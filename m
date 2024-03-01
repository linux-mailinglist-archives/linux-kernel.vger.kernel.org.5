Return-Path: <linux-kernel+bounces-88554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C05286E354
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3896284ECC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B020C6F50F;
	Fri,  1 Mar 2024 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wUo3hmm2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D983433AE;
	Fri,  1 Mar 2024 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303380; cv=none; b=JYJ5mVI5LBjZ1ibG3M9LbGyVsDOTLpGeq5AEO7kWd4D4YrPu4HCJD2LVnBk63w41gwARlX+7XLB/hArpgF11Xs0gg3xs0ybpdifvfoJkQ2jixon17rLp5OvDOqY4LVLjQ3xqv1Ouxys5nwmuus5157/XB5b0P+fwzL0my5m3hmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303380; c=relaxed/simple;
	bh=nvJnYNYyucBPeQr/nVGXVi1XuD8qdFqM2n7ZyMnuH2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSu3gN4B8yQGCCfduy84C7ms99+MTnMvdpFAIQgXcl6ocGlel0tSpId0eXJeavPr9P52N1pmdr4O5J0FV02K9jWlzCNukqYZnYU8zyXtSdCKxAvUcdkWrLvRGCHsoq+fvBjbFYz3VKhKhX+0WeoqnHY1bl7TfF0KE+/DfYpVCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=wUo3hmm2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709303376;
	bh=nvJnYNYyucBPeQr/nVGXVi1XuD8qdFqM2n7ZyMnuH2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wUo3hmm2q3+B1Uo6imzzhxD0/dknlOteIL3PKRiEDs6phs4YxTT94I9OikTFIYiAg
	 zxnEAnBzipMkhh7lpBZivCrdb8RPiuYBuApDBzp6oMIGYwhDdWyZaTKCqfIyBB8GS3
	 6bJ4w9L+f2h1WGp+ijiepRUkzDbLim+gXSG6rE5IRu0KoOIqzIOtOOGx0YhgiPENxJ
	 J8KDugMpceDKF4jCHJ3WRmP6C77TOwsfX7e0PK9qfFk89fr3iY0b/ASPmDM+1IhsHr
	 coUZteLM2TEZlPROEHJWCKmcSB5kN7f6vcg8xfQ3PN/pjHP7izjlEPzXdfVhZiSi/D
	 gpFDmzJxaVDGA==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BC4553782076;
	Fri,  1 Mar 2024 14:29:33 +0000 (UTC)
Date: Fri, 1 Mar 2024 09:29:20 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: mediatek: cherry: Describe CPU
 supplies
Message-ID: <d18d9397-37d1-45b0-ad1e-239d64360e38@notapiano>
References: <20240110142305.755367-1-nfraprado@collabora.com>
 <20240110142305.755367-2-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240110142305.755367-2-nfraprado@collabora.com>

+CC Nicolas Dufresne <nicolas.dufresne@collabora.com>

As he told me he was experiencing the hangs fixed in this series too.

On Wed, Jan 10, 2024 at 11:23:01AM -0300, Nícolas F. R. A. Prado wrote:
> Describe in each CPU node the regulator supplying it.
> 
> Fixes: 260c04d425eb ("arm64: dts: mediatek: cherry: Enable MT6315 regulators on SPMI bus")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
> Changes in v2:
> - Moved supplies to CPU nodes
> - Added fixes tag
> 
>  .../boot/dts/mediatek/mt8195-cherry.dtsi      | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index 3c6079edda19..1f3a6755f155 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -264,6 +264,38 @@ &auxadc {
>  	status = "okay";
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&mt6359_vcore_buck_reg>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&mt6359_vcore_buck_reg>;
> +};
> +
> +&cpu2 {
> +	cpu-supply = <&mt6359_vcore_buck_reg>;
> +};
> +
> +&cpu3 {
> +	cpu-supply = <&mt6359_vcore_buck_reg>;
> +};
> +
> +&cpu4 {
> +	cpu-supply = <&mt6315_6_vbuck1>;
> +};
> +
> +&cpu5 {
> +	cpu-supply = <&mt6315_6_vbuck1>;
> +};
> +
> +&cpu6 {
> +	cpu-supply = <&mt6315_6_vbuck1>;
> +};
> +
> +&cpu7 {
> +	cpu-supply = <&mt6315_6_vbuck1>;
> +};
> +
>  &dp_intf0 {
>  	status = "okay";
>  
> -- 
> 2.43.0
> 

