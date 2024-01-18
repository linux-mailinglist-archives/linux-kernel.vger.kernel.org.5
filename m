Return-Path: <linux-kernel+bounces-29990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7473831657
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40A251F22504
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80822031B;
	Thu, 18 Jan 2024 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="PVmek7gL"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6EF1F951;
	Thu, 18 Jan 2024 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705572008; cv=none; b=EE9YSQuvjT4fho854EW5g91y9ifnxfaOOGN7hy1XJ9oKq5vJMZlQXxDc7sbmZMwG4Fvf6xQhuQat4A+Lf9nYclXdDmd6KL7Dc23Wgbt7ewqEXzAYxGss+rlUh6bL9kA4r7yTBGaw/5WpxwCdSGPIY6ovNj9c+O3MmeKkZuWZ9eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705572008; c=relaxed/simple;
	bh=RAOiJUGPhFpGAduR+S3IcKXKOBR5tFN824z3zqf00kA=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir; b=fhXcdQJcGQXbG9gaS1qosC3KAy8mxNoQRpmm8DCrRa4b7BgS7G9eIFGWPk/0DtA0dE41rf2H0UIN2ejrQM6lKmdEfY/wNiJwHFqDrfGYRgz7lQ8g80Tl+dwadL7ZEVgUcVI0jLcTOuiAiIVkk1uoe22VkLJxOsK71UQgSP0pb3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=none smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=PVmek7gL; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jC+MlwHYQ98pnxcnOPbY091oyavdMMM1xHsRUFZPUcs=; b=PVmek7gLqOT9tF+4UMuY4x/Txt
	XZsdXeAVRrUln32gEaVRoMn/UOZFnjqqNrMySphkSDOFG+vvXkqq8RaUNsVg/T9kUhu8PvOrFBY3L
	qCqhk/swrIufIvJN/pAfuTvem4HJx2VhcVsPQzJEEfzn458GXRUjDYKIJ5CV9JkheOPdZiVRmbib+
	8aiLUaWPz3H0sZB8Ft1hLA1wKLVk5O47lfeW9mUB8jzJwwqpgAtm/nkhRssbobnD0042tNsLm82Je
	z+qvbf9xa5ygEmEkQXKKEWBIAF2OZILJdAjUgt/xcbMKflJsv0eGL7VG6elgzI5ethQy/fg5F4/zo
	V+kCaF5g==;
Received: from [89.212.21.243] (port=48642 helo=[192.168.69.116])
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1rQOQD-006iK2-1U;
	Thu, 18 Jan 2024 10:10:48 +0100
Message-ID: <3719c46f-4576-41f3-bdfa-2ea4c86f4a4a@norik.com>
Date: Thu, 18 Jan 2024 10:10:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: fsl: Add i.MX93 PHYTEC with
 Segin
Content-Language: en-US
To: Mathieu Othacehe <othacehe@gnu.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Stefan Wahren <wahrenst@gmx.net>,
 Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov <w.egorov@phytec.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240117074911.7425-1-othacehe@gnu.org>
 <20240117074911.7425-2-othacehe@gnu.org>
From: Primoz Fiser <primoz.fiser@norik.com>
Organization: Norik systems d.o.o.
In-Reply-To: <20240117074911.7425-2-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi Mathieu,

On 17. 01. 24 08:49, Mathieu Othacehe wrote:
> Add support for i.MX93 PHYTEC with Segin board.
> 
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 228dcc5c7d6f..196935d3abf0 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1275,6 +1275,12 @@ properties:
>            - const: tq,imx93-tqma9352        # TQ-Systems GmbH i.MX93 TQMa93xxCA/LA SOM
>            - const: fsl,imx93
>  
> +      - description: i.MX93 PHYTEC phyBOARD-Segin
> +        items:
> +          - const: phytec,imx93-phycore-segin
> +          - const: phytec,imx93-phycore-som
> +          - const: fsl,imx93
> +

PHYTEC has the following in their downstream kernel:

>       - description: PHYTEC phyCORE-i.MX93 SoM based boards
>         items:
>           - const: phytec,imx93-phyboard-segin # phyBOARD-Segin with i.MX93
>           - const: phytec,imx93-phycore-som    # phyCORE-i.MX93 SoM
>           - const: fsl,imx93

so there will be additional boards based on phyCORE-i.MX93 SoMs just
like with phyCORE-i.MX8MM.

Please consider fixing this in v3.


>        - description:
>            Freescale Vybrid Platform Device Tree Bindings
>  



