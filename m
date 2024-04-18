Return-Path: <linux-kernel+bounces-150499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738EA8AA02E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9E31F230C2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB59A176FA3;
	Thu, 18 Apr 2024 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="yYTukEj1"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275AB16FF22;
	Thu, 18 Apr 2024 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458091; cv=none; b=TRSXa9VQtBddDNDzbck32BWx6psKwBhJ8CBgFtQetc+SoX2JN31AoMfxqvCamTEsFeYwMNuV4FwXRwHvLzf/d7VxU/rJKNR8r5g2FPQCJdKLWcEOWX5on9dPDRqw4MAoxBfFoiH2x684LNVvDJO5eF3d8kp7Kb4eXdihR+9U6SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458091; c=relaxed/simple;
	bh=70TIKXqBfBJA9aVehyrQY69BfB1qIMjvDxnIKLyqTh0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ovewJ15Oy4S8LiJ4FnxRRRIIJ5kVvJIeVcFxwblboTicpPWFk2njyiDmqPkXWkPb35ELkFADcoMZ87oK+vWgMz5uJO3TI8Ij1KfExfed8Go9USY5h6HoVPqip2GYFJ7KusOvhtzZTJUPsdgfA4hAITPzWAOsop+duER4Bp+rFGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=yYTukEj1; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713458086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NQH0LQd6vFWye5qS7RbP9u62onapvzjrOLajReDA2M=;
	b=yYTukEj1p6PXvVYuwtjdfzL5hvlLohtpoqT2V8L4bQgD+Xxv0/DXDkdPcL50kgQWQo+0bf
	5QInONQOQzpb5ZzLQUuXiKzkOvn8uSp/ZdizLkJBB597MJTM06OLnRdr6ZlZsc85qFf4OH
	Eh9DGJz0A09esw31lDpmaUlCemn/xmabu/qZ7iNswl0goj/VIGQmm4YoHnug5uIduRfRFk
	qXCkMLzTfsPAdFh5oRQ43TZuj01zblfpqxjNEQ+2iUutPMLTdvbui3y5+1O3m7ZmM6tqZL
	z6aFUGUcAAcARqtx5ZyDp0hrQp+tzCZTmeWI7Xqs42AwCzj95X+dcvpny/7y1g==
Date: Thu, 18 Apr 2024 18:34:45 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring
 <robh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: correct the model name
 for Radxa ROCK 3A
In-Reply-To: <d00953aab0f1c978e3720885a6844caa@manjaro.org>
References: <20240418130120.67663-1-amadeus@jmu.edu.cn>
 <d00953aab0f1c978e3720885a6844caa@manjaro.org>
Message-ID: <896b9fa5a87c5724e1f5b8b517227589@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Chukun,

On 2024-04-18 17:21, Dragan Simic wrote:
> On 2024-04-18 15:01, Chukun Pan wrote:
>> According to https://radxa.com/products/rock3/3a,
>> the name of this board should be "Radxa ROCK 3A".
>> Also update compatible to match the model name.
>> 
>> Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
>> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> 
> Looking good to me.  I'll send the remaining naming cleanup patches
> a bit later.

Please note that I didn't touch the ROCK 3 board(s)
in my patches. [1][2]

[1] 
https://lore.kernel.org/linux-rockchip/1e148d6cd4486b31b5e7f3824cf6bccf536b74c0.1713457260.git.dsimic@manjaro.org/
[2] 
https://lore.kernel.org/linux-rockchip/1e148d6cd4486b31b5e7f3824cf6bccf536b74c0.1713457260.git.dsimic@manjaro.org/

>> ---
>>  Documentation/devicetree/bindings/arm/rockchip.yaml | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml
>> b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> index 99bd5e2c76a0..88e9e0011953 100644
>> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
>> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> @@ -772,9 +772,9 @@ properties:
>>            - const: radxa,rock2-square
>>            - const: rockchip,rk3288
>> 
>> -      - description: Radxa ROCK3 Model A
>> +      - description: Radxa ROCK 3A
>>          items:
>> -          - const: radxa,rock3a
>> +          - const: radxa,rock-3a
>>            - const: rockchip,rk3568
>> 
>>        - description: Radxa ROCK 5 Model A
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

