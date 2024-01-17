Return-Path: <linux-kernel+bounces-28816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF3C830358
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36ED8288FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC851429E;
	Wed, 17 Jan 2024 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rzaUGLT+"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F50614270;
	Wed, 17 Jan 2024 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705486469; cv=none; b=kOToYQ0Jprw8LHODLe5DaGXhEwEIV6XHmOXHJn19f+EoqLDwYK9JHLLqJt4ypRuwXsQtz98EMCCHrfD3toqpMk2fVWBSer8fQjw/YiJMNDZImI08jb17y9AFEIF374+3eh0xcINIG+yVv1N7zjgDWPhL/e9xvZZURRwQZnezpvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705486469; c=relaxed/simple;
	bh=syRL93p3m7lOCFY42/TgG/irGtWwZk2a6EBIxB3AtG8=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=XKRn91bxOdKcCqXU5p/2uyrxYh1IcZj2+ZRKOMvx0SQXO6iyufByJUeN85FJGAuM3TCBbKmZgXH8d3yLqsm7xPiosMP76V2wlk83CkVLcvuN/69etibuDt2WkursgsdTyo8eCZtX1Dxy3x1UaT7Uvxht7S1ELTyfKeRbFgNroy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rzaUGLT+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705486456;
	bh=syRL93p3m7lOCFY42/TgG/irGtWwZk2a6EBIxB3AtG8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rzaUGLT+FS5la69XrXwkC7+wXBJfGG2Zc+GHh7DoNXgLDFHIWOBbw3+8xKfqHK5uR
	 nE80DdCGwRM73OQERoaRk9LHu17/6Xwu8qXbnYKnjjAoh2w5WiGVxrD001I79BLaBt
	 5Ybnl523C/VQFOnsd7o3YG7AtDy7Uyh73Rq8YqvzHFcQvX2BT/o/v9hw+XhWJm4AXz
	 0+DYra7WjOGDL/QKOT3p8mCaeEOtOXWA9Rxo43jAEQ+GEfUvCyq81GUgRAP/AA4QSO
	 m9C9axzdOmjHD8fzZOmFDGlY15LhocM5KNtHRRTR7o5w9f+3Of262HfKzPeRIXEoDX
	 k/MiMIrqjALDA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4E6F737811F1;
	Wed, 17 Jan 2024 10:14:15 +0000 (UTC)
Message-ID: <720dc418-16f7-473c-b33c-f0c9786c02e2@collabora.com>
Date: Wed, 17 Jan 2024 11:14:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: mt8183: Move CrosEC base detection node to
 kukui-based DTs
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Ikjoon Jang <ikjn@chromium.org>, Stephen Boyd <swboyd@chromium.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20240116-mt8183-kukui-cbas-remove-v3-1-055e21406e86@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240116-mt8183-kukui-cbas-remove-v3-1-055e21406e86@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 16/01/24 22:38, Nícolas F. R. A. Prado ha scritto:
> The cbas node is used to describe base detection functionality in the
> ChromeOS EC, which is used for units that have a detachable keyboard and
> thus rely on this functionality to switch between tablet and laptop
> mode.
> 
> Despite the original commit having added the cbas node to the
> mt8183-kukui.dtsi, not all machines that include it are detachables. In
> fact all machines that include from mt8183-kukui-jacuzzi.dtsi are either
> clamshells (ie normal laptops) or convertibles, meaning the keyboard can
> be flipped but not detached. The detection for the keyboard getting
> flipped is handled by the driver bound to the keyboard-controller node
> in the EC.
> 
> Move the base detection node from the base kukui dtsi to the dtsis where
> all machines are detachables, and thus actually make use of the node.
> 
> Fixes: 4fa8492d1e5b ("arm64: dts: mt8183: add cbas node under cros_ec")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> Changes in v3:
> - Instead of deleting the node in jacuzzi, moved the node from kukui to
>    the dtsis including kukui that are detachables
> 
> Changes in v2:
> - Moved cbas node removal to jacuzzi dtsi
> ---
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi | 4 ++++
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi | 4 ++++
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi  | 4 ++++
>   arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi        | 4 ----
>   4 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
> index b6a9830af269..bfb9e42c8aca 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
> @@ -360,6 +360,10 @@ pen_eject {
>   };
>   
>   &cros_ec {
> +	cbas {
> +		compatible = "google,cros-cbas";
> +	};
> +
>   	keyboard-controller {
>   		compatible = "google,cros-ec-keyb-switches";
>   	};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
> index 306c95166f3f..5c1bf6a1e475 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
> @@ -339,6 +339,10 @@ touch_pin_reset: pin_reset {
>   };
>   
>   &cros_ec {
> +	cbas {
> +		compatible = "google,cros-cbas";
> +	};
> +
>   	keyboard-controller {
>   		compatible = "google,cros-ec-keyb-switches";
>   	};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
> index 382e4c6d7191..0f5fa893a774 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
> @@ -343,6 +343,10 @@ rst_pin {
>   };
>   
>   &cros_ec {
> +	cbas {
> +		compatible = "google,cros-cbas";
> +	};
> +
>   	keyboard-controller {
>   		compatible = "google,cros-ec-keyb-switches";
>   	};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index 5506de83f61d..66eb099e15f0 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -937,10 +937,6 @@ usbc_extcon: extcon0 {
>   			google,usb-port-id = <0>;
>   		};
>   
> -		cbas {
> -			compatible = "google,cros-cbas";
> -		};
> -
>   		typec {
>   			compatible = "google,cros-ec-typec";
>   			#address-cells = <1>;
> 
> ---
> base-commit: 0f067394dd3b2af3263339cf7183bdb6ee0ac1f8
> change-id: 20240116-mt8183-kukui-cbas-remove-657b62aeced6
> 
> Best regards,


