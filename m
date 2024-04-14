Return-Path: <linux-kernel+bounces-144003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D818A40A0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB40F1F2155C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93831CD23;
	Sun, 14 Apr 2024 06:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WyelgGnF"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE701C69D
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 06:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713076003; cv=none; b=UaCP41oIctAXw+pXaLkswl85ZALCZF05uFBAbk2DDnlORGt/nBh2OWyXHwGHmcjxjuxXKEue5DDglRbWMI9Vjof9WgqBdye459cxsVkNMeISGEryxVPGGaW6SC9SxoLmK8F2Bv9VjVTj9/7M0MqT3j8Vwgvo/Zh70XV4F/b/oUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713076003; c=relaxed/simple;
	bh=smn24fMwp0ky4DqZfNJQZXfdoNYmUPOFboRBMiP+Dq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6uKOM97104sKDCMBafaGLxyzkwhOuxKDQpV1yyqfcbWXOY0vn+vlNjMVqT450KlalT7DvkryyUDs0ciyHW8iqsF+yme+dA7KdF1tnKidnYRGOvbnVzSKwiJVUFSRASlSvDQbzl2FPYY5xi+Gv9JX2pqxcQxvnArnqFT9/MqQyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WyelgGnF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51a7dc45easo227657266b.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 23:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713076000; x=1713680800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fb4XT4BpF1keQD/cYuSzqTHELReynHN/QxYtqoQK4B4=;
        b=WyelgGnFTf71E6+lYZOxiLqtpItMsA3uhmHMrj9a3kUuHbjAwQnhZddMarBFLsAQ/R
         9uig3UdHtdVVb12dCvn9aUusQZ7W0ABjQRT7T4+/Q/saNpMSdvOJHj9Mr8OyJ+t16FAf
         pSuYuaWG4ziJixkMRm1PnWclENVEeHU46b76FKYWH5VBH1epgk/AgC3DGfTgcy3EpRA8
         JnKZYbZLZnDv/ZUMfGIAqAzAJVei0WUznB+X5BUsFn4sln+vCtQZkp0BUMKeVX68QPCf
         RUZha4Q7ocbJvxSsDjCWiRS5NEPKmIGFqOP5m8jJqAdf58+qQJ+hJEmRPItNcOZbMXTx
         Zmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713076000; x=1713680800;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fb4XT4BpF1keQD/cYuSzqTHELReynHN/QxYtqoQK4B4=;
        b=th79OSvtv3bwgy2HeXUEDxS7ycNi2cjoRpoFLvBcdGWKMsnwH0nZZuE/l5SgkXTZJF
         bLwMCDq1TBIe23MNd2yIUML2GknMtTLFI3QhId6wgoooaWV6ouyfBRh6v8SgEKXyAh4W
         mgSIZCkp5m+3eW1AC62ZBTzWJp/NJ+R7FaT85Mo0ujR8SqePSN9BhWFwCbg5fUEnSwa5
         GViK3rcChq7JxHsEQnSFMQd0iM0kdMS9Or6IhtDhlle18BHR7PrGrPJ5jtDM5z9fBfXp
         2og39nzodArTtEcTTwX8UT5jFpyCSZlUvTPRxtZM1CKc1kF/wcaLA/oP3vy0dmtOza0q
         wRcg==
X-Forwarded-Encrypted: i=1; AJvYcCUJGwzWj2a3WIZ8cAywp0lhjpllDSMeDds9rDELJds5y5e2TcviH9DZrAOODbSlq8tnpCvW2naqnG0Ox301cHWeDY7/mKNvbiyhU69t
X-Gm-Message-State: AOJu0YwwvfOxbyuAuVQan+kB/LFrLW0Ey5IEyvTg7OPpvgNzpspKGvfv
	EJR2P+eLZHZVg3RN09ADH2hA6GjEyjH7JAv0pxwKUCyRyBRwy53W8wEXmU6m/ug=
X-Google-Smtp-Source: AGHT+IFj+22/+7UEp646asI5/i1SIA8IDxe7zCUsAbVg7XNefNbM7Zd0Alf6RdgkHgPJ+y0JOTx0AA==
X-Received: by 2002:a17:907:724b:b0:a52:5795:226a with SMTP id ds11-20020a170907724b00b00a525795226amr1288123ejc.5.1713075999829;
        Sat, 13 Apr 2024 23:26:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id g4-20020a1709063b0400b00a51bbee7e55sm3807492ejf.53.2024.04.13.23.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 23:26:39 -0700 (PDT)
Message-ID: <4a63aa94-e8b4-4282-9622-7c3a7eed1c99@linaro.org>
Date: Sun, 14 Apr 2024 08:26:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] ARM: dts: bcm2711: add bcm2711-dma node
To: Andrea della Porta <andrea.porta@suse.com>, Vinod Koul
 <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Saenz Julienne <nsaenz@kernel.org>,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dave.stevenson@raspberrypi.com
Cc: Stefan Wahren <stefan.wahren@i2se.com>
References: <cover.1710226514.git.andrea.porta@suse.com>
 <c1ef1ba7cd9153d607e6130277e560b139056fd9.1710226514.git.andrea.porta@suse.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <c1ef1ba7cd9153d607e6130277e560b139056fd9.1710226514.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/03/2024 10:12, Andrea della Porta wrote:
> BCM2711 has 4 DMA channels with a 40-bit address range, allowing them
> to access the full 4GB of memory on a Pi 4. Adding a new node to make
> use of the DMA channels capable of 40 bit addressing.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  arch/arm/boot/dts/broadcom/bcm2711.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/broadcom/bcm2711.dtsi b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
> index 22c7f1561344..d98e3cf0c569 100644
> --- a/arch/arm/boot/dts/broadcom/bcm2711.dtsi
> +++ b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
> @@ -552,6 +552,22 @@ scb {
>  		ranges = <0x0 0x7c000000  0x0 0xfc000000  0x03800000>,
>  			 <0x6 0x00000000  0x6 0x00000000  0x40000000>;
>  
> +		dma40: dma-controller@7e007b00 {
> +			compatible = "brcm,bcm2711-dma";
> +			reg = <0x0 0x7e007b00 0x400>;
> +			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>, /* dma4 11 */
> +				     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>, /* dma4 12 */
> +				     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>, /* dma4 13 */
> +				     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>; /* dma4 14 */
> +			interrupt-names = "dma11",
> +					  "dma12",
> +					  "dma13",
> +					  "dma14";
> +			#dma-cells = <1>;
> +			/* The VPU firmware uses DMA channel 11 for VCHIQ */
> +			brcm,dma-channel-mask = <0x7000>;

Isn't one of your commits saying - this property is replaced?

Best regards,
Krzysztof


