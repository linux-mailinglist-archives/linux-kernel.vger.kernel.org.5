Return-Path: <linux-kernel+bounces-17078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D51A8824807
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66296B23F7A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B7F28DDA;
	Thu,  4 Jan 2024 18:15:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C406E28DBF;
	Thu,  4 Jan 2024 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rLSEx-0003UN-12;
	Thu, 04 Jan 2024 18:14:48 +0000
Date: Thu, 4 Jan 2024 19:12:10 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: linux-mediatek@lists.infradead.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sam Shih <sam.shih@mediatek.com>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: reset: mediatek: add MT7988 LVTS reset
 ID
Message-ID: <ZZb0-pFWxuQlEm7q@pidgin.makrotopia.org>
References: <20240104173930.13907-1-linux@fw-web.de>
 <20240104173930.13907-2-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104173930.13907-2-linux@fw-web.de>

Hi Frank,

On Thu, Jan 04, 2024 at 06:39:29PM +0100, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> ---
>  include/dt-bindings/reset/mediatek,mt7988-resets.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/mediatek,mt7988-resets.h b/include/dt-bindings/reset/mediatek,mt7988-resets.h
> index 493301971367..3f1e4ec07ad5 100644
> --- a/include/dt-bindings/reset/mediatek,mt7988-resets.h
> +++ b/include/dt-bindings/reset/mediatek,mt7988-resets.h
> @@ -10,4 +10,8 @@
>  /* ETHWARP resets */
>  #define MT7988_ETHWARP_RST_SWITCH		0
>  
> +/* INFRA resets */
> +#define MT7988_INFRA_RST0_THERM_CTRL_SWRST	9

I suppose this argument applies here as well:

"IDs should start from 0 or 1 and increment by 1. If these are not IDs,
then you do not need them in the bindings."

https://lore.kernel.org/all/59629ec1-cc0c-4c5a-87cc-ea30d64ec191@linaro.org/

As a consequence, as what you are describing there are hardware bits
rather than IDs used by the driver, you can just use a numeric constant
in device tree instead of adding dt-bindings header.
Or change the driver so RST0_THERM_CTRL_SWRST could be defined as 0.


