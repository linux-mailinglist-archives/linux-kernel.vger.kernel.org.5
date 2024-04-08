Return-Path: <linux-kernel+bounces-135573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A492289C7C5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A661F232BD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB3513F449;
	Mon,  8 Apr 2024 15:05:57 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDED13F425;
	Mon,  8 Apr 2024 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588756; cv=none; b=iHLFyq6Gz3952Q8fKRq+p/N10DYwYLP2N3i7zRa+wbi86zIBNi+fhadQlzfzuuDiNHz1X8cPHQAUKQYqwcPduDRYg4Q4+sUAamTmwKKwl2Z4fBUZ+AHo6zGFaNKbxrt2UjH5ao/ApMLaKWnY142zLWjoCzJD8/wb8rkitnKJHys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588756; c=relaxed/simple;
	bh=HXlXlUaU5gJk9Jo0EgoeNiaW9q8PnjSIIvypty0dO2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BS+r6qEP7cLrLOFqzkgsZbhR1mbAY2wTythQnLdKtfc1JaajdSmB1y36/miWS01EKVAesZgKlt4s5OTZTG5kORUWNIuqeC7ix/UHoZL0iUC9Okvj0A0iJskeGMrNeD5n5wgMPTJtKpNP1CNUGk4wxfqt+yer8w+jwiIMROfqRTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616c3.versanet.de ([94.134.22.195] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rtqZ4-0007Yf-1a; Mon, 08 Apr 2024 17:05:42 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Wu <david.wu@rock-chips.com>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] dt-bindings: net: rockchip-dwmac: use rgmii-id in example
Date: Mon, 08 Apr 2024 17:05:40 +0200
Message-ID: <12148577.zAa99ISigo@diego>
In-Reply-To:
 <20240408-rockchip-dwmac-rgmii-id-binding-v1-1-3886d1a8bd54@pengutronix.de>
References:
 <20240408-rockchip-dwmac-rgmii-id-binding-v1-1-3886d1a8bd54@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 8. April 2024, 08:44:10 CEST schrieb Sascha Hauer:
> The dwmac supports specifying the RGMII clock delays, but it is
> recommended to use rgmii-id and to specify the delays in the phy node
> instead [1].
> 
> Change the example accordingly to no longer promote this undesired
> setting.
> 
> [1] https://lore.kernel.org/all/1a0de7b4-f0f7-4080-ae48-f5ffa9e76be3@lunn.ch/
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> index 70bbc4220e2ac..6bbe96e352509 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> @@ -137,8 +137,6 @@ examples:
>          assigned-clock-parents = <&ext_gmac>;
>  
>          rockchip,grf = <&grf>;
> -        phy-mode = "rgmii";
> +        phy-mode = "rgmii-id";
>          clock_in_out = "input";
> -        tx_delay = <0x30>;
> -        rx_delay = <0x10>;
>      };
> 
> ---
> base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
> change-id: 20240408-rockchip-dwmac-rgmii-id-binding-6166af659845
> 
> Best regards,
> 





