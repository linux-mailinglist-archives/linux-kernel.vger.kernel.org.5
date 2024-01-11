Return-Path: <linux-kernel+bounces-23407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D0182AC64
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C421C2160A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690B714F68;
	Thu, 11 Jan 2024 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udT+Qc9B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B276314AB9;
	Thu, 11 Jan 2024 10:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A142C43390;
	Thu, 11 Jan 2024 10:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704969933;
	bh=1zlWT5FLY0Fih5H5xoaVcmBtvGj8QW2FkGsabbTm2LY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=udT+Qc9BRX4yCSJRvEFLb9REPtzq7Vdr4/YrTD97vO4oGx9xPBN0il0CPPc7VheiY
	 kx4YHTNSL3Kio0PMiJ+K6a5SV3O+Dn6JtFbxae/mFaiGqnZv2DjCOv+6XILtmuCXZ4
	 CyOtaDy4tXa6zjMeLsxsh5iNKz5WQ8WQXEM9xqdC9sp5VMSvurLFYNAFP2FXsQGQP3
	 8gbqeANHNclNu2iU+eADO3ceQFb5UB1mGDX397VidJLj7hM7BFY+x3ypij/hCqWWkl
	 8dV9XOSNvXQllz5yxc+yQvUrMW8FwCwhEZDLirIVf0u1lrPCIZvy6SlVOoC0XUWyZ3
	 zQHVqgrbpgjCQ==
Date: Thu, 11 Jan 2024 10:45:28 +0000
From: Lee Jones <lee@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 1/8] dt-bindings: mfd: stm32f7: Add binding definition
 for DSI
Message-ID: <20240111104528.GC1665043@google.com>
References: <20240101161601.2232247-1-dario.binacchi@amarulasolutions.com>
 <20240101161601.2232247-2-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240101161601.2232247-2-dario.binacchi@amarulasolutions.com>

On Mon, 01 Jan 2024, Dario Binacchi wrote:

> Add binding definition for MIPI DSI Host controller.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> ---
> 
> Changes in v2:
> - Add Acked-by tag of Conor Dooley
> 
>  include/dt-bindings/mfd/stm32f7-rcc.h | 1 +
>  1 file changed, 1 insertion(+)

You haven't send me the rest of the set, so I have no idea what's going
on with respect to expected merge strategy.  In future please send the
whole patch to all of the relevant maintainers.

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

