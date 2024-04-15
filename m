Return-Path: <linux-kernel+bounces-145915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF338A5CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F7E1F23CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C2A156995;
	Mon, 15 Apr 2024 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4tLtEj/"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76EC82D93;
	Mon, 15 Apr 2024 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215446; cv=none; b=K/cFEpV+rky2dekzJQxtyZpP6zWbju2f6H4clyUrUG4Ia2/9SPmC+lXsoTa+M33eWYoPyNza/TcIVMuifCzd2zqLvcdoCSgp7fe5qllnkukcVfSET7Jmi6Klzi+ki9VSDG1sGdzmQWFwpIcPRwIpLycLDD8HjQz98fAKaV52KOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215446; c=relaxed/simple;
	bh=xWsOHMwDq20aIhCRQXclo2deHd25wdzzVkxVCdIGEhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BiaOQlr6FEb9iyuWT+VZJkwtIRPVCQbe6jbKMFlQvskslhbE0RO6xT9+1F2S3wwyi2ju4Yyu65UnzZwN2RdZpm52dSuFS41tAbbal22Ez80NbuaabKmQv0M6z/KnX5Nds3/EjNHtBGMcw86z23aTUDdHxQmfREkxJ5MdnbqXkiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4tLtEj/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41879819915so6691595e9.1;
        Mon, 15 Apr 2024 14:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713215443; x=1713820243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POu8ivNdiDybNb2buQjdK1aWft9b5HTgPPEBvxZY5SM=;
        b=P4tLtEj/uLdz7pzzC22tRt7Fg8Kk6kL7Wu/Y4myTGJfJaD0FVdp3Ax7JFBcEENuBlu
         sJCfssws98TQU067kZurJ1/s8nfA5LKXvbhAGWq9SPyaq3hniJPBOdXOoHR8IkUqHD0J
         4vozPGMu0aHOZtnSfSQjwk7Ig5e+3fOIy/td95fvKnwH0h9fb4LIzRvtUGzaImpDPG6W
         5a4P4hrb6fOSzWg9hh6lXXyMrrvtK29RHSHWdHvqha8wcmKTogKBZxvy54YHNfmgfUgU
         NcAihGJMljlJHnIKPeo/el6b67q3wOtPk4i3raggqCit9eUnrZs7b7D1FZoGSNoK7CBh
         WMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713215443; x=1713820243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POu8ivNdiDybNb2buQjdK1aWft9b5HTgPPEBvxZY5SM=;
        b=L/Tg77E69MKxsCCu3oqQZ8h6hWtAjYnop2PIPO/qR/f+ibBWx5+GY1I+zBuK7SLbDu
         Ej1gV3UgmkO19Rp7DZbxbxsIIppogdEP+QREpR6lkxQxHg5DV/UEwFu080qyQ54uNGEF
         0XacR3bNM4NsE0U/h8K0vbXDbN02yg7vWT+HT1FYqIekmzTw7bGvB0X02mK4pCEF+DHn
         iqD3wVrJkJZ3wRygfrzcH201rKGSuH6w3YupDeszYKktH9Osjhqr+SggtQT01Rk29mbb
         x3WNILUqkFBoFy/6+JT7InWbmRpZ8PXZMoXT2IwjqFqSvpe1F2RbqByBtY09jg94A7u1
         K1DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWWZ/xFGPURQ/fmum/VC2Hwy70VJcg/4uxOHrv0mCTFWmyH1/WN4y+rCevQi/DemYN+jVx7+/45cyBo3GBiOBpIE0hN8ZPeEP4Ba8B0pX+QUOZdbxblONvzk5kszod984hoNoz8Nd5vA==
X-Gm-Message-State: AOJu0YwbYcQAFfW1uLXSuOShmsr9J62NsU5OVHgRxIOenJHsz+TxxzaM
	ZBAAs5tOzwy6+37g4WXNxUp0Vss1Bu2Vgtf5PIZkJlEqfRvO9M8r
X-Google-Smtp-Source: AGHT+IG2p9m0jXcUa5+DHZuhGziToQ0Nz6/fB0gCfrIcRX7Kn8dYiFFVLNTE3sOo8pUzHpdfzw4S1w==
X-Received: by 2002:a05:600c:458d:b0:415:6afd:9ba6 with SMTP id r13-20020a05600c458d00b004156afd9ba6mr8104239wmo.1.1713215442970;
        Mon, 15 Apr 2024 14:10:42 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id fc18-20020a05600c525200b0041563096e15sm20910578wmb.5.2024.04.15.14.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 14:10:42 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Corentin Labbe <clabbe@baylibre.com>,
 Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject:
 Re: [PATCH 1/4] arm64: dts: allwinner: Pine H64: correctly remove
 reg_gmac_3v3
Date: Mon, 15 Apr 2024 23:10:41 +0200
Message-ID: <10447698.nUPlyArG6x@jernej-laptop>
In-Reply-To: <20240317184130.157695-1-krzysztof.kozlowski@linaro.org>
References: <20240317184130.157695-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 17. marec 2024 ob 19:41:27 GMT +2 je Krzysztof Kozlowski napisal(a):
> There is no "reg_gmac_3v3" device node in sun50i-h6-pine-h64.dts,
> although there is "gmac-3v3" with "reg_gmac_3v3" label, so let's assume
> author wanted to remove that node.  Delete node via phandle, not via
> full node path, to fix this.
> 
> Fixes: f33a91175029 ("arm64: dts: allwinner: add pineh64 model B")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied all, thanks!

Best regards,
Jernej

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> index b710f1a0f53a..1b6e5595ac6e 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> @@ -5,12 +5,12 @@
>  
>  #include "sun50i-h6-pine-h64.dts"
>  
> +/delete-node/ &reg_gmac_3v3;
> +
>  / {
>  	model = "Pine H64 model B";
>  	compatible = "pine64,pine-h64-model-b", "allwinner,sun50i-h6";
>  
> -	/delete-node/ reg_gmac_3v3;
> -
>  	wifi_pwrseq: wifi_pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
> 





