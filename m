Return-Path: <linux-kernel+bounces-161580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A198B4DF5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A161C20A59
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 21:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9693FB654;
	Sun, 28 Apr 2024 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="EJb4KSIn"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706AEC2C6;
	Sun, 28 Apr 2024 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714340496; cv=none; b=LU65gYvIk5HfIAVcIfI0IMTOygE6LgADPrnoVFHK5h+gMMwKXw54Jwb2gdcBub6c+FJBFup5RC/KTNTewD1lzIxsVzx1lceCs5PrDSnflTDuGiP5xuDIhxs8ggProaQXcyWG/fiwrXzOeVCUizs6iseodaIDNtzirRI3xa7vYGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714340496; c=relaxed/simple;
	bh=g/6yt8bN2SG8nYFAhg2VDbUzvzglw6s3LVMo5oELXxg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=P6DVDTNE+ISVgpl92FuOWUHC39e6UM2GtTSh/xR8vo3H0/1QjDdANl7oyTlud+ypyp21iIxxV30qGDez+0B5BxTE03JEUDWUnkPc/Ni+Uh4tn32KCL+IYq2rcmIjwHi7iEmsPj3aIaZFhWbrkcYDOoUAozoKthDFJrsuRovUyAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=EJb4KSIn; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714340486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Br6/mlh4IbIGBLsAZO56LX/rMiHfPwJFLzbYvHw/Wok=;
	b=EJb4KSIna+pZFFr9jVzc9Zn9UN+jlLP1PmhpYlNwIBLNiZY1mVmQ74OmJq7+UEeAUbTG19
	ieRRrKZoVYqmky00vauNVsx8lpUkgTsAFp6CaBOdUM/J+K8ocoLgcCUN/tFjHyc5D2MF3A
	CZ6DXqXSJ3J5qdFXxKVOtL4E7E+RkL9ZWMdRj1Pv0cpGvPDMycPNSXm5ZtZDPr9C71BooX
	qbYCNMad6VSKTOV5H/UntEjVrZqte+u76aYt1GVvxM6BaV+uSQhaKn5j7+YWTKeq8JHGDd
	PKjzA2X9fP+eQtoy+aW5iomTjTuhHt15bx6CGMCRH8gxW87YnyT3nQ7mK0kwCw==
Date: Sun, 28 Apr 2024 23:41:24 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>, Conor
 Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob
 Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: rockchip: add Radxa ROCK 3C
In-Reply-To: <d6004beb-2e7d-4f26-a202-0c5baabd4023@kernel.org>
References: <20240428123618.72170-1-amadeus@jmu.edu.cn>
 <20240428123618.72170-2-amadeus@jmu.edu.cn>
 <d6004beb-2e7d-4f26-a202-0c5baabd4023@kernel.org>
Message-ID: <f4baaff6fe20bba48cddb356df6e531a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Krzysztof,

On 2024-04-28 18:37, Krzysztof Kozlowski wrote:
> On 28/04/2024 14:36, Chukun Pan wrote:
>> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml 
>> b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> index 1bbbaf81134b..e04c213a0dee 100644
>> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
>> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> @@ -799,6 +799,11 @@ properties:
>>            - const: radxa,rock3a
>>            - const: rockchip,rk3568
>> 
>> +      - description: Radxa ROCK 3C
> 
> There was some big renaming of these boards. I assume you are using
> correct naming?

I can confirm that the naming above is fine.

