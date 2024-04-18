Return-Path: <linux-kernel+bounces-150531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D918AA09D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C55C280D82
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8898817556C;
	Thu, 18 Apr 2024 16:59:57 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1A8171E75;
	Thu, 18 Apr 2024 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459597; cv=none; b=SQO/GN+0crN5JmnsHCOS7Xf8s+6iFU6CS85qOqRSVhp6Kafeg0kLWuYnlF7Yn45FNgGMLLC7MjOO/1l8qxfW4T8hk0CKix1S9GDkx4V2tW2rouBXUj1Mr0V//5c+81v9KwmMPeToJJS1Rx7fvzZHKI1Bsd4ZnTJVArEEo0pvWYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459597; c=relaxed/simple;
	bh=NBVOz/kFsz91jcvQ9HTa1sBebQJOO2yZ//O+RPGVYSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pvY1FwLLGs/hdaMcFZFtSggK2RSitJQaMItyEHPs+b10jGJ0mo6wN86rYL4Z4obsesvIIdvDYn9mJpU4LvN7qFmrmJXPkg/u01cbpHHEk+PTmrDqosREqH124RxfcPtheaesJSrwcSPkXFW4Z/TQv9l1ctuqfHpEaqWFC8zOu9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861917.versanet.de ([94.134.25.23] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rxV6t-0000pc-I2; Thu, 18 Apr 2024 18:59:43 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org, Dragan Simic <dsimic@manjaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, amadeus@jmu.edu.cn,
 FUKAUMI Naoki <naoki@radxa.com>
Subject:
 Re: [PATCH 1/2] dt-bindings: arm: rockchip: Correct the descriptions for
 Radxa boards
Date: Thu, 18 Apr 2024 18:59:42 +0200
Message-ID: <1888572.CQOukoFCf9@diego>
In-Reply-To:
 <1e148d6cd4486b31b5e7f3824cf6bccf536b74c0.1713457260.git.dsimic@manjaro.org>
References:
 <1e148d6cd4486b31b5e7f3824cf6bccf536b74c0.1713457260.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Dragan,

Am Donnerstag, 18. April 2024, 18:26:19 CEST schrieb Dragan Simic:
> Correct the descriptions of a few Radxa boards, according to the up-to-date
> documentation from Radxa and the detailed explanation from Naoki. [1]  To sum
> it up, the short naming, as specified by Radxa, is preferred.
> 
> [1] https://lore.kernel.org/linux-rockchip/B26C732A4DCEA9B3+282b8775-601b-4d4a-a513-4924b7940076@radxa.com/
> 
> Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index fcf7316ecd74..ae58e25c29ec 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -767,22 +767,22 @@ properties:
>            - const: radxa,rockpis
>            - const: rockchip,rk3308
>  
> -      - description: Radxa Rock2 Square
> +      - description: Radxa Rock 2 Square

I may be just blind, but what changed here?


Heiko



