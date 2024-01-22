Return-Path: <linux-kernel+bounces-33068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4675D8363F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340F51C22595
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA013CF48;
	Mon, 22 Jan 2024 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8mp3vq0"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F773C491;
	Mon, 22 Jan 2024 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705928730; cv=none; b=dZEeabuDk/xW/tgJ5eOpweT6uwifHby9FAgyzLe72RuGG5N3lxa+xoi7JJW0tIkulwDMpqwnZFRcDJCIF6t4j5SurQCVBPGxuq+UhsrLJFrDa2QdynDNUHm898t6IqJMvPX+U5xvzUdy4Ev+xIzFb6DDIzaZ511oyk27an+5oys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705928730; c=relaxed/simple;
	bh=VgnrLml8x1cZ0tdRYHJcn8PShS/TzWF0nWfJtsW9134=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBB3NH+XCaiWWFKP1kfc4eootp4C6LOp4ORMT0dbZGSvMTjQd4XTJ2kIChhF58R/sNwdqOBUigCPBSq+teQJ2owgCiOaUIdEgFc9joAgYV2R0yrDCqQ2mGj2TDnkKhuSHJFWd3scOfFrj0Vldhp+hISyU+jLcHuszRHEiVrkohY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8mp3vq0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e9ef9853bso16575415e9.1;
        Mon, 22 Jan 2024 05:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705928727; x=1706533527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mp/8xDRCZjv5y4KcPViCiBMqajiVKRc1465woAo3Ngo=;
        b=K8mp3vq0rnf0f1tfD1EtP5RBOWgL3uTpxnh22BG3IU/0kqe0GWa1XbMLmwW2SfDeaM
         1swUvHI12866DloEfY5WsEoc1OVY0N62/xtD7niKBZbenT6HwqvMu8cgf6fEeVROsJ6P
         gKDkqHzHphI6Pnv+DXm/N/G1B7B/Xb+T3iHcgRcoh2YB9nZEvA/0EJE/7pKmnAgFrcF+
         Bp4aEXX/Xpt/k/XtjrEx1W76cxxvgfsanJxEXRBIlthtuF3BW4ASXEArHzFY4LR1OYAG
         sZ55lkngMsVr2Paw+rrqCyAIC47DY2S6zjux0fNOHwrCRFD99aMI/4pEWbt9IEyURzve
         3Yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705928727; x=1706533527;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mp/8xDRCZjv5y4KcPViCiBMqajiVKRc1465woAo3Ngo=;
        b=Se2C6QEsK+jrbNdhZr/Om7H/6p70aDvHwSF4OlczqiXtiL7Ic7cuu/dI9U+Aog25zs
         iCQsLuLZVIn3+/4gNz81zvFO0IHu+N4Xn6dhQupnA1gPW0dY1Sh51zLlhz9i2ZITHQWK
         pYV9V2cGzehEGN8mmmDagsyJH4vsczqpY3lIYvAhKBWaq/yr76gJsDvf2LDr25TeAr06
         D+b0pBQuXN2fzAF5q8PLRddOCVRFJAjKbojrkUi2OdbyhcaKcsZWdApll3f5sZTMJlhF
         fsosqcsej+363WWo/+bzpvXOrEUCSfWkzY78WyNOg6cF9+psYeNdp+OjaQwM86JBdd+6
         BRxA==
X-Gm-Message-State: AOJu0Yw2kcVqtZzvqzTkeUO+U7OuM7Ik7GZeI8dn9hviPQJyEsaiErmr
	oMst1z4KV+Dx5tzPi35oG+3yURrTIU1qot2LW+ZAtQRsy3EL4guj
X-Google-Smtp-Source: AGHT+IFHmjEmeu7pWua+wi7iLe6qjSDVPRL27NITeBmGF9vpz49mzsF7SGDLAVjMhHv73ZtGi6vZHg==
X-Received: by 2002:a05:600c:3509:b0:40d:8881:4d1e with SMTP id h9-20020a05600c350900b0040d88814d1emr2236549wmq.66.1705928726767;
        Mon, 22 Jan 2024 05:05:26 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.188])
        by smtp.gmail.com with ESMTPSA id h10-20020adff4ca000000b0033925aa222dsm6846512wrp.57.2024.01.22.05.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 05:05:25 -0800 (PST)
Message-ID: <5339e8b2-8fcd-498a-b9d8-2dc2e3ddb272@gmail.com>
Date: Mon, 22 Jan 2024 14:05:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] usb: mtu3: Add MT8195 MTU3 ip-sleep wakeup support
Content-Language: en-US, ca-ES, es-ES
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 chunfeng.yun@mediatek.com
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <20240122111809.148546-1-angelogioacchino.delregno@collabora.com>
 <20240122111809.148546-2-angelogioacchino.delregno@collabora.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240122111809.148546-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/01/2024 12:18, AngeloGioacchino Del Regno wrote:
> Add support for the ip-sleep wakeup functionality on the three MTU3
> controllers found on the MT8195 SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> 
> Changes in v2:
>   - Dropped unused definition for WC0_IS_EN_P1_95
> 
>   drivers/usb/mtu3/mtu3_host.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
> index 9f2be22af844..7c657ea2dabd 100644
> --- a/drivers/usb/mtu3/mtu3_host.c
> +++ b/drivers/usb/mtu3/mtu3_host.c
> @@ -34,6 +34,18 @@
>   #define WC0_SSUSB0_CDEN		BIT(6)
>   #define WC0_IS_SPM_EN		BIT(1)
>   
> +/* mt8195 */
> +#define PERI_WK_CTRL0_8195	0x04
> +#define WC0_IS_P_95		BIT(30)	/* polarity */
> +#define WC0_IS_C_95(x)		((u32)(((x) & 0x7) << 27))
> +#define WC0_IS_EN_P3_95		BIT(26)
> +#define WC0_IS_EN_P2_95		BIT(25)
> +
> +#define PERI_WK_CTRL1_8195	0x20
> +#define WC1_IS_C_95(x)		((u32)(((x) & 0xf) << 28))
> +#define WC1_IS_P_95		BIT(12)
> +#define WC1_IS_EN_P0_95		BIT(6)
> +
>   /* mt2712 etc */
>   #define PERI_SSUSB_SPM_CTRL	0x0
>   #define SSC_IP_SLEEP_EN	BIT(4)
> @@ -44,6 +56,9 @@ enum ssusb_uwk_vers {
>   	SSUSB_UWK_V2,
>   	SSUSB_UWK_V1_1 = 101,	/* specific revision 1.01 */
>   	SSUSB_UWK_V1_2,		/* specific revision 1.02 */
> +	SSUSB_UWK_V1_3,		/* mt8195 IP0 */
> +	SSUSB_UWK_V1_5 = 105,	/* mt8195 IP2 */
> +	SSUSB_UWK_V1_6,		/* mt8195 IP3 */
>   };
>   
>   /*
> @@ -70,6 +85,21 @@ static void ssusb_wakeup_ip_sleep_set(struct ssusb_mtk *ssusb, bool enable)
>   		msk = WC0_SSUSB0_CDEN | WC0_IS_SPM_EN;
>   		val = enable ? msk : 0;
>   		break;
> +	case SSUSB_UWK_V1_3:
> +		reg = ssusb->uwk_reg_base + PERI_WK_CTRL1_8195;
> +		msk = WC1_IS_EN_P0_95 | WC1_IS_C_95(0xf) | WC1_IS_P_95;
> +		val = enable ? (WC1_IS_EN_P0_95 | WC1_IS_C_95(0x1)) : 0;
> +		break;
> +	case SSUSB_UWK_V1_5:
> +		reg = ssusb->uwk_reg_base + PERI_WK_CTRL0_8195;
> +		msk = WC0_IS_EN_P2_95 | WC0_IS_C_95(0x7) | WC0_IS_P_95;
> +		val = enable ? (WC0_IS_EN_P2_95 | WC0_IS_C_95(0x1)) : 0;
> +		break;
> +	case SSUSB_UWK_V1_6:
> +		reg = ssusb->uwk_reg_base + PERI_WK_CTRL0_8195;
> +		msk = WC0_IS_EN_P3_95 | WC0_IS_C_95(0x7) | WC0_IS_P_95;
> +		val = enable ? (WC0_IS_EN_P3_95 | WC0_IS_C_95(0x1)) : 0;
> +		break;
>   	case SSUSB_UWK_V2:
>   		reg = ssusb->uwk_reg_base + PERI_SSUSB_SPM_CTRL;
>   		msk = SSC_IP_SLEEP_EN | SSC_SPM_INT_EN;

