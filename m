Return-Path: <linux-kernel+bounces-30941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B9F832659
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 175A9B23B6D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A6124B47;
	Fri, 19 Jan 2024 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VFkGWdVU"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D954E1E897;
	Fri, 19 Jan 2024 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705655616; cv=none; b=G2N70+hfjvRx7i5uR5JOeN/esUr54bFlKfpYZyKwdWUAkpwQvgs787E3e9/yDItKWjMEZnPhnIwEcV7lPK8omaAOWsP3rmlRfMGmJQxCFU5rHTenuKVbRkdfM+Y1/0LU+18QTXB9VYP7akVAIKqbcufOk1SbuWj+9DtEd5O6wGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705655616; c=relaxed/simple;
	bh=f8DISqCvdcOoye/zl+qWQ2jDLY06UuVEhG+Srk2JALU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBf1H5FeuO0dzEtbRzI7oVRWKYCS+u/pTGyXtGayLRLr58E8c145jQt041CC3Jkq/mgJcdHR+BIkj9gQLsQ+you+/w7PFMWpajWjrH5/v1AjxahB9hgLs7NOkFNkC8U8wMbJAraSYid+g1QoBbSv+pIXDJrh25zcdgI0wkbvkCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VFkGWdVU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705655613;
	bh=f8DISqCvdcOoye/zl+qWQ2jDLY06UuVEhG+Srk2JALU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VFkGWdVUFbjtsR450pVSXB6ORnFBiKY/gwb8EQUwm6wIu8ATjqBD883oLkyxOmxwD
	 2Qqt8w7AoX8CwMMMYYmUh7NCnefo3tw7APDsGmjYjTLoDi72m1tIO4MnJqmNpxXTcJ
	 uxCY7C3MWrXeMoHUAofuGQtnI1ZZh5wt3VI2MVpLWlT7rf0BqjycQijWMa6pcXzOZK
	 pDpWKEYrYkuAVG+BWafQEDHLz1SlAUzkofOoo2uTmjpifUBD5z2/IqDwUlqfafgf6K
	 EURO/jp7F62TBa5SQSjRqxd6ao3vIuGnzOvsLKEJZWYx/6X41RzK3x9S4tCquM9Gim
	 JRuLRkjaEYaZw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 22FFC3781182;
	Fri, 19 Jan 2024 09:13:32 +0000 (UTC)
Message-ID: <7e3e3c7a-26ae-48ff-8884-d4f703995546@collabora.com>
Date: Fri, 19 Jan 2024 10:13:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: usb: mt6360-tcpc: Rename IRQ to PD-IRQB
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, linux@roeck-us.net, heikki.krogerus@linux.intel.com,
 cy_huang@richtek.com, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20240112094538.65639-1-angelogioacchino.delregno@collabora.com>
 <20240112142018.GA3127117-robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240112142018.GA3127117-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/01/24 15:20, Rob Herring ha scritto:
> On Fri, Jan 12, 2024 at 10:45:37AM +0100, AngeloGioacchino Del Regno wrote:
>> Since there is no user yet, rename the only interrupt of this device
>> to "PD-IRQB", avoiding underscores.
> 
> It is primarily node and property names that have this recommendation,
> not so much -names values.
> 
> If there is only 1 interrupt, I'd just drop the name.
> 

Yeah, you're totally right. I'll just drop it.

Thanks!
Angelo

>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml         | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
>> index 053264e60583..0bea23ce2f09 100644
>> --- a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
>> +++ b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
>> @@ -24,7 +24,7 @@ properties:
>>   
>>     interrupt-names:
>>       items:
>> -      - const: PD_IRQB
>> +      - const: PD-IRQB
>>   
>>     connector:
>>       type: object
>> @@ -58,7 +58,7 @@ examples:
>>           tcpc {
>>             compatible = "mediatek,mt6360-tcpc";
>>             interrupts-extended = <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
>> -          interrupt-names = "PD_IRQB";
>> +          interrupt-names = "PD-IRQB";
>>   
>>             connector {
>>               compatible = "usb-c-connector";
>> -- 
>> 2.43.0
>>


