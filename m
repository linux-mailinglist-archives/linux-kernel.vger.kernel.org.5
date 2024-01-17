Return-Path: <linux-kernel+bounces-28801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5A6830328
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B14F0B2182B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8720F1C691;
	Wed, 17 Jan 2024 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="JvpBt54a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cvFTVzur"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306901BF5E;
	Wed, 17 Jan 2024 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485643; cv=none; b=U+6uRCf6nXYbbRiEa2eYZMPpyKJEdph0YsMvxYubw14gXE6rFZOpaBVApxrNt65sEE1Nhg900tgF2jxO5UmyoAR8YHuZx/PQ37VnREgnJpeARzhk1YErasaEhbwGAI4f3pn1Ndm8YYZJ1SMdUx0wOodz1W2lp/OJIccQpyVCZII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485643; c=relaxed/simple;
	bh=KusKkWjyuO1cEco8hpxaoHX9JXHM6jzWbE3XdG32MQA=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=m5aDw3pBkq5hby3rAmE142sPd8Td934nSNKy0BSV6wrv2KUHhPkwxffehSrfOEmo+TdLRDhXF+8xHabKXM6y+w3C1HZ9WdygSHPihel2IyWZJ764xgxJBFHO+QYpWND5ZSre1TcsD+ZnMHKwN9jJDDtuGcW18y80WgCdehvABnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=JvpBt54a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cvFTVzur; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 547D45C01F0;
	Wed, 17 Jan 2024 05:00:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 17 Jan 2024 05:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705485641; x=1705572041; bh=/wyX6Sl7+DhZnU3Q0TqpgZ3lJgja7hsu
	xIwI/YnreAM=; b=JvpBt54aNxPc5eIOC7IKmqJ3Y4pxs9Rlf5XtSozN/z/0N0XV
	kuqOyw6w2rJAatrWdgZLk+ooBcgtJUUyovzEcGZHsgmAM0H0701C3vFy9mTzU50Z
	19WBRw3E8mRPSVPIpj80xlQpsIegCytRR5FtaWq2OMIU39akxyBv4KWlU9Vm2/RW
	xlQyNVfAJE/HxyY21QjSwQIfFCkU6Z/oOg50PxnqsLf3UEyVoMhyO+mRqy4B2sgq
	HuuP1Cf7Z5GgM2QYVRcTG0O9DVyNzzCTl6Xmbw2Vg8Gucp5qq7Mz4irKjqSis96O
	lYHOZqdJf8L4BjV4livP2K6ZpmLdM2UniLjLGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705485641; x=
	1705572041; bh=/wyX6Sl7+DhZnU3Q0TqpgZ3lJgja7hsuxIwI/YnreAM=; b=c
	vFTVzureYHhCJuSVko6WtERLnqRTShzXpzB2EdnaW2Cj/lFRnoP8S5JJ0nvCGTtG
	BHciWEVNMh19U8/lthQMIG/7hDgvXYmx/om5Z/5A6wze2qvoCchx8LDYiWy867f7
	158Vl8ewpW61ripRPI/CA5C8cKo5EgLlfS2lIbyvflcAK83Ge+UKtr5gOO9Sniam
	Wfs12RODG/ECucnjTeHs8DWljWuhzwBFWEZuJeyG15j3rQ4GrXLL0aAv1BZl/RlM
	vzXXzTwMktF/lO18QHPNUqQ8HyIqmrqn8SE122RWhC8+Fp2D1XITQT2XCBpi1+qb
	gZBlcN+5xNI99+UYapNmA==
X-ME-Sender: <xms:SaWnZZ4VGqcYzFGAA4wQ6hkZVFvoHSJFJokORoeLiU3BJzC7hIsD8A>
    <xme:SaWnZW5EJc-FiJ4bXlMsxgewY6jLSNBE2Q7Dp17PGDFPZ3DIJp4727mKaZ9m6a0Q9
    10mpiPNuA>
X-ME-Received: <xmr:SaWnZQdPIR-xv10WFcVshrLLLhEhc6TLr68Z95bpSO3RW4MSKtN85kjPWBMTUhpwUoDaOoC4QI_BDbT9Ynm8s95v60g3ELC74RN2WQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejhedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefvihhm
    ucfnuhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvg
    hrnhepheehgfelhfffgeefkefgjeelkeduleefvefhgfekgfetfeetvdeigeekjedvffeh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimh
    esfhgvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:SaWnZSJchl_9uHWzSN1NMwcq6K9xhadlAIzeLRGfWJ-IrYkjMPlwRQ>
    <xmx:SaWnZdKKlwoTakPSyYUrD1zponkriQ-b0cxjzYdoLe4u9HtgLAqoGg>
    <xmx:SaWnZbxjvT9A0ozhruPW0bwUuPbxgxYeT8ZscIadExV41FvHAV-P6Q>
    <xmx:SaWnZaB1HhecaFQtqLxw-BRxH-UOeqx6igLxfYm9XMsPFlN-aciL4w>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jan 2024 05:00:36 -0500 (EST)
Message-ID: <792fb886-beac-44fd-a8d5-82187baf9c62@feathertop.org>
Date: Wed, 17 Jan 2024 21:00:36 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: rockchip: rk809 fix existing example
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Chris Zhong <zyw@rock-chips.com>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Zhang Qing <zhangqing@rock-chips.com>, linux-kernel@vger.kernel.org
References: <20240116132102.3272682-1-tim@feathertop.org>
 <20240116132102.3272682-3-tim@feathertop.org>
 <3d4d8fc4-2b57-454e-a7f7-637309590cc3@linaro.org>
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <3d4d8fc4-2b57-454e-a7f7-637309590cc3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 1/17/24 18:43, Krzysztof Kozlowski wrote:
> On 16/01/2024 14:21, Tim Lunn wrote:
>> Fix typo in the example specifying wrong compatible string for rk809.
>> Remove additional vccX-supply properties that dont exist on rk809.
>>
>> Signed-off-by: Tim Lunn <tim@feathertop.org>
>>
>> ---
>>
>> Changes in v2:
>> - Fix vcc-supply warning detected by dt_binding bot
>>
>>   Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
>> index bac2e751e2f2..9b9d670708ce 100644
>> --- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
>> @@ -154,8 +154,8 @@ examples:
>>           #address-cells = <1>;
>>           #size-cells = <0>;
>>   
>> -        rk808: pmic@1b {
>> -            compatible = "rockchip,rk808";
>> +        rk809: pmic@1b {
> Drop label.
>
Yep, will fix.
> Best regards,
> Krzysztof
>

