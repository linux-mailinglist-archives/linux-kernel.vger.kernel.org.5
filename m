Return-Path: <linux-kernel+bounces-144347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F298A44C9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 480B1B21960
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DB5135A5F;
	Sun, 14 Apr 2024 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="k6n+Otjk"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3512740BED
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120851; cv=none; b=oiOUoU0Rk7ISjIyw66mXz6eG787ivcLcGs6r2eOFN3uOn5iOHYXPMlfMisJ49la7+0e6mNYWqlPcDv0gzddqE40tQyaSK6zFxzRPuNXZCAg37osgAVqx4D/+i7DwTLL/PUjtOvBLpEtGGNzKdf3cGp7SqLnx5LObz3tJzU11m+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120851; c=relaxed/simple;
	bh=H42rfY9BXsoD/M4Qn+Bwcc4SFKN/9L44LjCJs4Rpf9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/lr9ToMzaiM+PhHcnOu7inWALgt4UtTwG19I0Rq/DD2/p8wG5A+Iy8QKtK6Mi+8vLkUH88yg2rer3rkWCwV0VOxB1HVCREZvwSJgpEsPOEjr8Ul5CQyVpO9er7JMtdrz7K04rzSN24agkDMHQRIcNcMZNafId5URlJ4/8GAZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=k6n+Otjk; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1713120836;
 bh=o6KhYcJny4LUz13HWMoNmuFaXLpJ75r6XYs3Wyyjsn0=;
 b=k6n+OtjkbA7wlZ5stF4QXTbWppmX0pwXK219sGso8n2onXpdB3cQJbvSShQ5oyGG63TayHL1N
 tE9NSnWjtrQtnYhgc0i5v4jATmbjwcE8cSsPA2eVMpVggaZqsDrxFQyV/4aPQtovwi3LiEs4liy
 HQNUbG1x4bXk5wkvWOiz1TlftYUsun+jrfeCnHJkQmVMw53KC5+rx1y3D/OURJrzpBzTiiAUb4k
 rZR7AgHnSJS5IicjnZheu5BK12jW+Asuu3za5oxRFXfCg5gxuMznUEbgUK2znsbV/2bcejLB7YR
 kg9+J8Cy+/5wYZeIl4jhxmFp6N1z1QXTiZUgH1x9yXsQ==
Message-ID: <ef4b9abc-6796-40bf-98f9-a12f007ed846@kwiboo.se>
Date: Sun, 14 Apr 2024 20:53:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dt-bindings: display: rockchip,dw-hdmi: Fix
 sound-dai-cells warning
To: Johan Jonker <jbx6244@yandex.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Sandy Huang <hjc@rock-chips.com>, Andy Yan
 <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Mark Yao <markyao0591@gmail.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20240414151135.1774981-1-jonas@kwiboo.se>
 <20240414151135.1774981-4-jonas@kwiboo.se>
 <0facfa2a-bff7-4cf1-b43a-349bba2f2342@yandex.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <0facfa2a-bff7-4cf1-b43a-349bba2f2342@yandex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 661c2644309b3fe15baf7834

On 2024-04-14 20:41, Johan Jonker wrote:
> On 4/14/24 17:11, Jonas Karlman wrote:
>> The rockchip,dw-hdmi node can be used as a sound dai codec, however,
>> dtbs_check may report the following issue:
>>
>>   hdmi@fe0a0000: Unevaluated properties are not allowed ('#sound-dai-cells' was unexpected)
>>   from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
>>
>> Add a reference to dai-common.yaml and add the #sound-dai-cells prop to
>> resolve this warning.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
> 
>> v2: New patch to fix #sound-dai-cells warning
> 
> Hi,
> 
> You are #4 that does an attempt on this subject.
> Coincidence with my patches??
> If other notifications could be fixed with the same amount of interest?
> Please be welcome to pick some other random Rockchip related ones.

Hehe, I should have looked deeper at what existing patches was out there.

Will send a v3 without this patch and instead reference your patch.

Regards,
Jonas

> 
> Johan
> 
> ===
> 
> [PATCH v1 1/3] dt-bindings: display: add #sound-dai-cells property to rockchip dw hdmi
> https://lore.kernel.org/linux-rockchip/3a035c16-75b5-471d-aa9d-e91c2bb9f8d0@gmail.com/
> 
> [PATCH] dt-bindings: display: rockchip: add missing #sound-dai-cells to dw-hdmi
> https://lore.kernel.org/linux-rockchip/20240326172801.1163200-1-heiko@sntech.de/
> 
> [PATCH 6/6] dt-bindings: display: rockchip: dw-hdmi: Add missing sound-dai-cells property
> https://lore.kernel.org/linux-rockchip/20231222-pinetab2-v1-6-e148a7f61bd1@mecka.net/
> 
>> ---
>>  .../bindings/display/rockchip/rockchip,dw-hdmi.yaml           | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
>> index af638b6c0d21..3285fff54416 100644
>> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
>> @@ -15,6 +15,7 @@ description: |
>>  
>>  allOf:
>>    - $ref: ../bridge/synopsys,dw-hdmi.yaml#
>> +  - $ref: /schemas/sound/dai-common.yaml#
>>  
>>  properties:
>>    compatible:
>> @@ -124,6 +125,9 @@ properties:
>>      description:
>>        phandle to the GRF to mux vopl/vopb.
>>  
>> +  "#sound-dai-cells":
>> +    const: 0
>> +
>>  required:
>>    - compatible
>>    - reg


