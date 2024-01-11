Return-Path: <linux-kernel+bounces-23504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C5882ADB3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B031F23691
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106F115493;
	Thu, 11 Jan 2024 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uq87kzgy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D96C390;
	Thu, 11 Jan 2024 11:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304CFC433F1;
	Thu, 11 Jan 2024 11:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704973226;
	bh=rGE5aLBgG8rJvHpHzdIZ5UZ/WMT/chk9s1YqtP4odSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uq87kzgyV/Bo+E6Sqqkjo3Vi1g2cOMAEMp+AVTWTFrlgZ+OsW4JJmm8CQ4cEAH4Dt
	 tCw1JPLKu1P0sjntzy9JoNDwfX2a+fAzSIONCete70Mcnfk1ZY1hIkwLTbgkEWetzr
	 sTEPFZtxbzXahrF3Zk0xIOOlOIZvBs9X8t2EGIQJLNU1BrgK05cG/v4bSB7gKeKzty
	 lfgEK9mginYvPfkX6/8/8HMTILVqGgOEBKSjUjna0i1q/cKM2i3fLTsOhgEqUqoe3S
	 gQwe4Zte45/KDRXtESj9PtJ2ugYoUPCdmJ8IBvwjA/db97f6xOJd9Km/cIRCUrWA0s
	 ydDPWUgG2RrVQ==
Date: Thu, 11 Jan 2024 11:40:21 +0000
From: Lee Jones <lee@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-amarula@amarulasolutions.com,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v7 1/5] dt-bindings: mfd: stm32f7: Add binding definition
 for DSI
Message-ID: <20240111114021.GJ1678981@google.com>
References: <20240111113146.16011-1-dario.binacchi@amarulasolutions.com>
 <20240111113146.16011-2-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240111113146.16011-2-dario.binacchi@amarulasolutions.com>

On Thu, 11 Jan 2024, Dario Binacchi wrote:

> Add binding definition for MIPI DSI Host controller.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Add Acked-by tag of Conor Dooley
> 
>  include/dt-bindings/mfd/stm32f7-rcc.h | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Lee Jones <lee@kernel.org>

> diff --git a/include/dt-bindings/mfd/stm32f7-rcc.h b/include/dt-bindings/mfd/stm32f7-rcc.h
> index 8d73a9c51e2b..a4e4f9271395 100644
> --- a/include/dt-bindings/mfd/stm32f7-rcc.h
> +++ b/include/dt-bindings/mfd/stm32f7-rcc.h
> @@ -108,6 +108,7 @@
>  #define STM32F7_RCC_APB2_SAI1		22
>  #define STM32F7_RCC_APB2_SAI2		23
>  #define STM32F7_RCC_APB2_LTDC		26
> +#define STM32F7_RCC_APB2_DSI		27
>  
>  #define STM32F7_APB2_RESET(bit)	(STM32F7_RCC_APB2_##bit + (0x24 * 8))
>  #define STM32F7_APB2_CLOCK(bit)	(STM32F7_RCC_APB2_##bit + 0xA0)
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]

