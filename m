Return-Path: <linux-kernel+bounces-148126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAFB8A7E11
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAB21C21C21
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F0C7E763;
	Wed, 17 Apr 2024 08:21:35 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554037D405;
	Wed, 17 Apr 2024 08:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342095; cv=none; b=W7qW/qr5USHWyh+7I3e1AvjrJ4kLP7COvHPk+5DkRgo5cd3q+M9HgcSX6+Dl4snDFIaZ9Ybyx+uOljGm72dC5gHFMSl+bfXU+13qV8D8LxdNytL5VMBcaN18mpYmIR5zYV3mkajF4MIjvDx6WUT7Yil7jPluleIa4J5HsUlXUbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342095; c=relaxed/simple;
	bh=BmCTEuG8ZEge7mabY0zal3eEGZqniJng7t8IJ6Tqt+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YqJ/jo7nx0cekXkEngVUK7q4aqoqpRgdpR5WqYyFj6ZT71cEQFvAoG6ldAnuQ6QhD+fnd6TF7/SsVTf7RzxcDWlwCWbADt0E14UJsCMO1WkMp+EqzxgepFnoQJ5WaWI0db580Y5iAZ2dl28GZLfcUiXQVCtRzHLPlr2xVS7btNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616c3.versanet.de ([94.134.22.195] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rx0Xe-0001bO-En; Wed, 17 Apr 2024 10:21:18 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Jianfeng Liu <liujianfeng1994@gmail.com>, conor+dt@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, liujianfeng1994@gmail.com,
 sfr@canb.auug.org.au, weizhao.ouyang@arm.com
Subject: Re: [PATCH v4 1/3] dt-bindings: vendor-prefixes: add ArmSoM
Date: Wed, 17 Apr 2024 10:21:17 +0200
Message-ID: <13494460.uLZWGnKmhe@diego>
In-Reply-To: <20240416034626.317823-2-liujianfeng1994@gmail.com>
References:
 <20240416034626.317823-1-liujianfeng1994@gmail.com>
 <20240416034626.317823-2-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 16. April 2024, 05:46:24 CEST schrieb Jianfeng Liu:
> Add vendor prefix for ArmSoM (https://www.armsom.org)
> 
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>

[PATCH v3 1/3] dt-bindings: vendor-prefixes: add ArmSoM
yesterday got a

Acked-by: Conor Dooley <conor.dooley@microchip.com>

in
https://lore.kernel.org/r/20240416-choosing-boney-33cf206d0f38@spud

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index e4aeeb5fe..e47405535 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -151,6 +151,8 @@ patternProperties:
>      description: ARM Ltd.
>    "^armadeus,.*":
>      description: ARMadeus Systems SARL
> +  "^armsom,.*":
> +    description: ArmSoM Technology Co., Ltd.
>    "^arrow,.*":
>      description: Arrow Electronics
>    "^artesyn,.*":
> 





