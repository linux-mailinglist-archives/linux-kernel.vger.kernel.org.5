Return-Path: <linux-kernel+bounces-135487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5992C89C691
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF471C21C8E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC238565D;
	Mon,  8 Apr 2024 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DNK1tnJ0"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CA785631;
	Mon,  8 Apr 2024 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585622; cv=none; b=EiP5dCPoqxDVXRKiRrcPxTFJFMySxNhNCZXdRQ0rVMnyHU3l0VxrplYmQwhAKbfLQvmpDW8y9F6KotRstMR0Qjj1up02AYmQzDkJOgSzeKpVUpzFSthmFVL2dZ1YNjTdJhH/3YxW5nGdG4ngOemyHhKoaCPjBg1gpJ7QjeS+E2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585622; c=relaxed/simple;
	bh=I5zsylDEGkWc/qvFoHytXDSVWzal++WyZbd86A1gdyY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ot4SlQ318hc1I/01ZDLaUJsVM2chzWA6TPFuLH8pgofZ3OBUJe6BlABxZDWUnyQzgf/zmdvvvQh6oBknDIOajAiOI5bpRe7FtyfxmmiPenk65uYXFQcFc6kMP78bZ+zBHe4si6zuqJ3zp0YmAdUq64qzA28UWk5pGCZ+4C+KVls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=DNK1tnJ0; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712585611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHS6uqBrOTBI5KsbzQzo9xNfjnvV1fyVq/BSuRh+mhA=;
	b=DNK1tnJ0vcDT/7vE5fbelUYIRr4NcVehjQRk/vhVFQEQ4nKScZVebfGcGI2xLWf9NyV8JE
	2g+j1dFx7ldSSQNViXIxjoLKQ/INonNVN47sl16mrZ6khJx33KOrFhGCWR9p1cIci6b14N
	hy2tX6ZSF1qisr7kgPFfsUzh/Ajpyp1mW4z6qi0mnEkPFo/AiULzrP6pKGN9a1bWn9DfH3
	bvr/hgHZQHnNROuFRQoziq1XGVCRWCibMMICzsz5GzMWEygsFf7XSOp9/4pdmsNs+kBPW3
	1Cffz6DUFmyQ8CjdTS/AXHQY4YN0jv2LDpJV78V5LRhDHFX6OadH2Pp1GgDVfQ==
Date: Mon, 08 Apr 2024 16:13:29 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, David Wu <david.wu@rock-chips.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] dt-bindings: net: rockchip-dwmac: use rgmii-id in example
In-Reply-To: <20240408-rockchip-dwmac-rgmii-id-binding-v1-1-3886d1a8bd54@pengutronix.de>
References: <20240408-rockchip-dwmac-rgmii-id-binding-v1-1-3886d1a8bd54@pengutronix.de>
Message-ID: <6d06c3e3f59f26e16fe1f02dc3225d9e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Sascha,

On 2024-04-08 08:44, Sascha Hauer wrote:
> The dwmac supports specifying the RGMII clock delays, but it is
> recommended to use rgmii-id and to specify the delays in the phy node
> instead [1].
> 
> Change the example accordingly to no longer promote this undesired
> setting.
> 
> [1] 
> https://lore.kernel.org/all/1a0de7b4-f0f7-4080-ae48-f5ffa9e76be3@lunn.ch/
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

I'd suggest that the following link is also added to the patch
description as a reference, because it contains rather useful
information:

https://lore.kernel.org/linux-rockchip/2973a2cb1f478031ae6d478c853c33ae@manjaro.org/

Otherwise,

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
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

