Return-Path: <linux-kernel+bounces-32965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C291183628D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08E11C27157
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC5F3D544;
	Mon, 22 Jan 2024 11:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rQdEXeE6"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A9B3D3B6;
	Mon, 22 Jan 2024 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924112; cv=none; b=AIdCycMQrlsM8hjBlleivNd1wLdFx3y2YSu5CTrJInGNnlHmMEnY0Gu5++IBKcoKre9oVsfKSzmLjIB7JES5hD7cjOhUSTTq4smu7m/9fy6t4IaeYeAbkxkTwUtFhIFzU3+SJCJx1aIX3anzi0pRiC1HkmPCJhi6IdXTq7jLS8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924112; c=relaxed/simple;
	bh=nRr2BPtGcBu5pcM6iVkEYQLLgGdpvWXGhuM0c/DPEgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLgHqzzGtq59nJ8/jnnyMGOBieciwP8Dpb/TXZTaCmeXu24EndTGOlQJ7SIRUkG4JizcsGi/8gZ9RxW43sh20Wdt0TYYayF1fp/ULFlzEGw2+MoHAURA+tg5YZUjCCw1KxLQQ41qOD21WIqbiritB07UImk34B4lwtIQW/gI42A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rQdEXeE6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705924108;
	bh=nRr2BPtGcBu5pcM6iVkEYQLLgGdpvWXGhuM0c/DPEgs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rQdEXeE6APfjlEqIznt/dRrwf0AmmPXSLMDIE+pr6elKrQhWHhX4/Rr7hFXN623zu
	 zumK2YP9SI3rRcXJbA/mrzV/H7qUzjLoz4oonwVokvoo/Z9G6P131J+KK2rih7oRWL
	 o2ZRqtjLTILNqW4JBlUdDBumWGtT6zL9uHpoOwqfY9kXhwW5iXkp1i/kUIrt/WjM7B
	 qfXuHcpgQ+kUbtxwzJxmZYoTHobyIb68o5tCx9Q9k8O6N6RNqi0HdgfYmNaFJoBupl
	 ys0IlGRgOUODL8YcCrUr8wxihHLLpIrs5b6x4eQLnmhqz3cQXd1n4D8XhbRdVRaov6
	 ktRhQctjjVs1Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EA8F237810CD;
	Mon, 22 Jan 2024 11:48:27 +0000 (UTC)
Message-ID: <9d3623f8-697b-44ab-a9eb-9d2d305b0e5c@collabora.com>
Date: Mon, 22 Jan 2024 12:48:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: msm8956-loire: Add SD Card
 Detect to SDC2 pin states
Content-Language: en-US
To: Marijn Suijten <marijn.suijten@somainline.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, Luca Weiss <luca@z3ntu.xyz>,
 Adam Skladowski <a39.skl@gmail.com>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, Martin Botka <martin.botka@somainline.org>,
 Jami Kettunen <jami.kettunen@somainline.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240121-msm8976-dt-v2-0-7b186a02dc72@somainline.org>
 <20240121-msm8976-dt-v2-6-7b186a02dc72@somainline.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240121-msm8976-dt-v2-6-7b186a02dc72@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/01/24 23:33, Marijn Suijten ha scritto:
> In addition to the SDC2 pins, set the SD Card Detect pin in a sane state
> to be used as an interrupt when an SD Card is slotted in or removed.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
> index b0b83edd3627..75412e37334c 100644
> --- a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
> @@ -264,10 +264,27 @@ &sdhc_1 {
>   	status = "okay";
>   };
>   
> +&sdc2_off_state {
> +	sd-cd-pins {
> +		pins = "gpio100";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};

Are you sure that you really don't want card detect during system suspend?

You could simply add a sdc2-cd-pins out of sdc2_{on,off}_state and add use it for
both default and sleep.

pinctrl-0 = <&sdc2_on_state>, <&sdc2_card_det_n>;
pinctrl-1 = <&sdc2_off_state>;

Cheers,
Angelo

> +};
> +
>   &sdc2_on_state {
>   	clk-pins {
>   		drive-strength = <10>;
>   	};
> +
> +	sd-cd-pins {
> +		pins = "gpio100";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		input-enable;
> +		bias-pull-up;
> +	};
>   };
>   
>   &sdhc_2 {
> 



