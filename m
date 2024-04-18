Return-Path: <linux-kernel+bounces-150377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAA28A9E31
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01D29B23A77
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E7116C691;
	Thu, 18 Apr 2024 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="AqtQxprh"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DB015FA73;
	Thu, 18 Apr 2024 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453686; cv=none; b=krLIeVflU/Bmi9Cpwav3OVz6/TqhDZlQYcd7zX9uLxJTKOPDa4+VNH1gpS+OgxddurO7jN0n5ypbdd6TLM087iSUDR3JAvtB5oqqxGHTAmJSqZBau4urjIOiWTtjCKpegaHrjaUp01KAV+r7iIe5yWSiGeige8Vl0A1/yyPol2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453686; c=relaxed/simple;
	bh=xIdCwlOhtU2CLSyz6WT/cwG7jpS5kkfbpyk3hcleqLA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BSbfTpGCM9upjAl8tx7yw/p8lpDVmlXoQYkYfWpmSIkmVrrIqwu5Rnn+oWrLE4z3Vqyeq+w94sdLoecCfvboAfeawOdZ3rePsn+7QEypySE6CqGWkqrTNloebHc1FJmZVWmaxoU45Y8FssRtmmMuEMl346/xDuBEd1ZO/fDp5eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=AqtQxprh; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713453680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7pDzprEULb6CX6lMCrdxJvnLBOtCYuc57B+5gNsxmg=;
	b=AqtQxprhMc32q9g8MXCW5LY11LtyaPhs3Orfxlig93+Yp6qilPMh3Yu1G8WvwKR6tOkI6E
	KwsfhKMfvjIvvX9ujuyIU2Eb1z8NnzGLJFSoXlvGecAjLNCGHIJ2FMJS6sb875NF78Zgqh
	ZI14BtUe3koLWe1qXcCn2rZ55g3IiEeIVob0Va5JOJmFd+3tv/dXUbqd4Fal7CpUmaTXqk
	l06Cka29b9MyU1MRfcwnhxtZ8TNGdth61r63jrXZnxBrm4Y5o5Q5jul8a1zf4TO1CjsW6B
	TD0n6okY0jPdOwz2eq61VJieBJPCkF4Nfp8BsPcZeSj0BlTqqr4umUxs6Rkarg==
Date: Thu, 18 Apr 2024 17:21:18 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring
 <robh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: correct the model name
 for Radxa ROCK 3A
In-Reply-To: <20240418130120.67663-1-amadeus@jmu.edu.cn>
References: <20240418130120.67663-1-amadeus@jmu.edu.cn>
Message-ID: <d00953aab0f1c978e3720885a6844caa@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-18 15:01, Chukun Pan wrote:
> According to https://radxa.com/products/rock3/3a,
> the name of this board should be "Radxa ROCK 3A".
> Also update compatible to match the model name.
> 
> Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>

Looking good to me.  I'll send the remaining naming cleanup patches
a bit later.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>


> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml
> b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 99bd5e2c76a0..88e9e0011953 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -772,9 +772,9 @@ properties:
>            - const: radxa,rock2-square
>            - const: rockchip,rk3288
> 
> -      - description: Radxa ROCK3 Model A
> +      - description: Radxa ROCK 3A
>          items:
> -          - const: radxa,rock3a
> +          - const: radxa,rock-3a
>            - const: rockchip,rk3568
> 
>        - description: Radxa ROCK 5 Model A

