Return-Path: <linux-kernel+bounces-43119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E68840BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442511C22F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A4115B2EF;
	Mon, 29 Jan 2024 16:32:44 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870FF15AAC2;
	Mon, 29 Jan 2024 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545963; cv=none; b=R3BY9hL0LdZCF5PmDOaDN8w8e555BaN/QaMPOcH/xEtVMVAYnzoxtM90uRi+7KMb9nlVSlC78jfIYx12MCc1GOSCA6GOWmdo7UvFm3zYUbT8d/dIIvqm8VBFgmrotP1OENDNHC4UW0eacdh2uPxXc0L9oW9L3S6cDTmUl0XYCZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545963; c=relaxed/simple;
	bh=lDpi9yvbwgMWUDTs/NOybqvQB2F3saU706v68qcn0g4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcC4i+x2Cor5DtRZghUIAFR3g8EDmcu/sxEakG5DGslwDQv+i8M3IYXY+EAk6k7COBOq7GvmHxCiQ3sqc5yMz9tD+kXMIdiyWm5of2ns8tbeJ/0JNDmAvGcFS3dW0uzE1FzXek3mH0TJu1YMHYXQMz7oGuMRieVnSqx+iAsifLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 092F461E5FE05;
	Mon, 29 Jan 2024 17:31:53 +0100 (CET)
Message-ID: <2c37a716-e4bb-4db3-a95f-a40e05b28cad@molgen.mpg.de>
Date: Mon, 29 Jan 2024 17:31:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: mt8183-pico6: Fix bluetooth
 node
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240126063500.2684087-1-wenst@chromium.org>
 <20240126063500.2684087-3-wenst@chromium.org>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240126063500.2684087-3-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chen-Yu,


Thank you for your patch.

Am 26.01.24 um 07:34 schrieb Chen-Yu Tsai:
> Bluetooth is not a random device connected to the MMC/SD controller. It
> is function 2 of the SDIO device.
> 
> Fix the address of the bluetooth node. Also fix the node name and drop
> the label.

Excuse my ignorance: Is this a cosmetic fix or does it fix the device 
somehow?

> Fixes: 055ef10ccdd4 ("arm64: dts: mt8183: Add jacuzzi pico/pico6 board")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> Changes since v1:
> - Collected reviewed-by
> 
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
> index a2e74b829320..6a7ae616512d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
> @@ -82,7 +82,8 @@ pins-clk {
>   };
>   
>   &mmc1 {
> -	bt_reset: bt-reset {
> +	bluetooth@2 {
> +		reg = <2>;

To avoid confusion, would it be possible to use sdio as a “name”.

>   		compatible = "mediatek,mt7921s-bluetooth";
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&bt_pins_reset>;


Kind regards,

Paul

