Return-Path: <linux-kernel+bounces-28717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F6E830234
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358811F266B9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4DB14277;
	Wed, 17 Jan 2024 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="JNsKkO6/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gMpuu517"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2101DA28;
	Wed, 17 Jan 2024 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483330; cv=none; b=pL04SI91rDxCv5zFG7uBsgBxy6QbZ3NcZ/lr4umIi9ziSihLo1toqlP16kI+ai1jdiDa5Be6LijCjqVUJIWEJhfmzeoCXc4BeVKC+FLUz9aVnm+mOtu6de2QikD/b4I3WHdGLy0205hy5Y8Zn6eD3wR9yfbqX0yFuvOUL2oH74o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483330; c=relaxed/simple;
	bh=AnA7meFiqkNnf7c945+34XOtWzGS/MXpTqWynpJ5Y/s=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=PuhQbTYbNR3KXEQFgPpP7t+URHmTZM5VZB6YRJlHxhzi7eJkKjrVcGPiZ2XnV+XpyJhdnwDgtHJCRwCNJ0k8sWKbtXbWDZrMaNuF6csh6rHV4irt7Rq3dOXfrUw1+ZKxgutSNvu5ImPR+cs1zt4mUE5br7iL9uu9oZecXzIrTAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=JNsKkO6/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gMpuu517; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 69B5F5C0109;
	Wed, 17 Jan 2024 04:22:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 17 Jan 2024 04:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705483327; x=1705569727; bh=34kRshMtwfRWCMvFwLf5ruJ2ndgyWSRN
	sCfd2ePL1mo=; b=JNsKkO6/xD1mYY+UihaiB05QQvmj0GSJ3OKmFZj8HHCrwhgZ
	eshr/Ha/DCtIuLoTBXVOEznRYE4xwcOnI+IUzdrACkakZMesJubMPP+IVzfhKF02
	clOEQ02Be5HKpFGUboI6hl8f0iX8k96MyP178+BDwq106dtE9DM3vFfiMObJ41d8
	dJy4CcZq4RbMRUKDhlYveNS68Y9Y/9zr7NlUO90jv1fWsBvPVF6qMrH5+dXufrJe
	v8hQYqr8VOF89R4PaqPdmLcuOt0GNHJcnVHvHs2SfB+lOIIrxJcyv9IRJJtJgtay
	ldIGPGJ3BxVEueDLIuUhvC2Ow8bvWV6NE6tjqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705483327; x=
	1705569727; bh=34kRshMtwfRWCMvFwLf5ruJ2ndgyWSRNsCfd2ePL1mo=; b=g
	Mpuu517COxDBA8ACicdUB7mt3oDFK5U5kLHtMVqtwC+ujMo5k4xi0hE4YPek/7lG
	zcWRVb/x+rH8pN3T4MOWp0vJZIZJABJ5KR+jhofiEb2654LHIjdj2jRYr7feClLg
	4NLfPUupBE3NeoFlUd1oHFml+MB6Wh/+EvxhFeBeur3ZeEvfS4YiG348pv6WL7GP
	9psEae6Gvwi7NsUTOrpVWld2cAJ+7qJJSHayYHpbclW7u4k4pjC2WNcYdCHZRpdq
	USRqCvL5CDqx7eHpfMdSp9haDnnn/xF+FKCd5a1EqJRLzWU8H9lWeFFXbKcsUKXT
	msyx/jGhvusPa7BpMeplg==
X-ME-Sender: <xms:P5ynZbdoRIMSiCSDzAxC2MOY_kOt5D0XEMx4j6pm71JIbBen_WLYKw>
    <xme:P5ynZRMc39yyDdbYAEABTFXguthkcngaelco_PymNsAzwSzY1LwadUkh3ffBfObtg
    jnWp-yyFQ>
X-ME-Received: <xmr:P5ynZUheHNHrLt4-LXqq4w6MqfI-T7H7iCqtHU0fVfqkOSd4cg65_2ju5qnENekv7kKtyfVj7Z54A2_oSA17sflG9CfD9g8t7-5kYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejhedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfhffuvfevfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhm
    ucfnuhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvg
    hrnhepffeludetffejgfevjeduffejveevueekieegudfhueduieduteekteefvedvheff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimh
    esfhgvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:P5ynZc9ADCUOo0fm5dafTWzpHw9aasKcC3JuataLpWdPZQThrAB0CQ>
    <xmx:P5ynZXtWiUWSFHyyhUEuYsSFAUqKg1JZBDEnkkOndVrL1lu5I_huuw>
    <xmx:P5ynZbHwduMQM4uKF5y3K6DqiijEKpMv_h2G0DRZPMZuDGFHbI_gkA>
    <xmx:P5ynZYl9rpqcfMbdgJaSpl1RWKqUwGXo8IwvVUSML8mL9QC90mxgRQ>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jan 2024 04:22:02 -0500 (EST)
Message-ID: <f441aebd-dd4d-47a7-a269-e4869f5eb88d@feathertop.org>
Date: Wed, 17 Jan 2024 20:22:00 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tim Lunn <tim@feathertop.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: rockchip: Document rk809 support for
 rk817 audio codec
To: Conor Dooley <conor@kernel.org>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Chris Zhong <zyw@rock-chips.com>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Zhang Qing <zhangqing@rock-chips.com>, linux-kernel@vger.kernel.org
References: <20240116132102.3272682-1-tim@feathertop.org>
 <20240116132102.3272682-2-tim@feathertop.org>
 <20240116-mangle-parish-93b5cd672d17@spud>
Content-Language: en-US
In-Reply-To: <20240116-mangle-parish-93b5cd672d17@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/17/24 04:06, Conor Dooley wrote:
> On Wed, Jan 17, 2024 at 12:21:00AM +1100, Tim Lunn wrote:
>> Rockchip RK809 shares the same audio codec as the rk817 mfd, it is also
>> using the same rk817_codec driver. However it is missing from the
>> bindings.
>>
>> Update dt-binding documentation for rk809 to include the audio codec
>> properties. This fixes the following warning from dtb check:
>>
>> pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks',
>>     'clock-names', 'clocks', 'codec' do not match any of the regexes:
>>     'pinctrl-[0-9]+'
>>
>> Signed-off-by: Tim Lunn<tim@feathertop.org>
>> ---
>>
>> (no changes since v1)
>>
>>   .../bindings/mfd/rockchip,rk809.yaml          | 30 ++++++++++++++++++-
>>   1 file changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
>> index 839c0521f1e5..bac2e751e2f2 100644
>> --- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
>> @@ -12,7 +12,7 @@ maintainers:
>>   
>>   description: |
>>     Rockchip RK809 series PMIC. This device consists of an i2c controlled MFD
>> -  that includes regulators, an RTC, and power button.
>> +  that includes regulators, an RTC, a power button, and an audio codec.
>>   
>>   properties:
>>     compatible:
>> @@ -93,6 +93,34 @@ properties:
>>           unevaluatedProperties: false
>>       unevaluatedProperties: false
>>   
>> +  clocks:
>> +    description:
>> +      The input clock for the audio codec.
>> +
>> +  clock-names:
>> +    description:
>> +      The clock name for the codec clock.
>> +    items:
>> +      - const: mclk
> You have one clock only, why do you need to have clock-names?
This is just documenting the existing rk817 codec driver, which is using 
the name to get the clock:

devm_clk_get(pdev->dev.parent, "mclk");

Thus i dont think clock-names can  be removed in this case? atleast not 
without patching the driver as well?
> Otherwise,
> Acked-by: Conor Dooley<conor.dooley@microchip.com>
>
> Cheers,
> Conor.
>
>> +
>> +  '#sound-dai-cells':
>> +    description:
>> +      Needed for the interpretation of sound dais.
>> +    const: 0
>> +
>> +  codec:
>> +    description: |
>> +      The child node for the codec to hold additional properties. If no
>> +      additional properties are required for the codec, this node can be
>> +      omitted.
>> +    type: object
>> +    additionalProperties: false
>> +    properties:
>> +      rockchip,mic-in-differential:
>> +        type: boolean
>> +        description:
>> +          Describes if the microphone uses differential mode.
>> +
>>   allOf:
>>     - if:
>>         properties:
>> -- 
>> 2.40.1
>>

