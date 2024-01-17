Return-Path: <linux-kernel+bounces-28730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 040FB830250
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964EF1F28F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3FB13FEB;
	Wed, 17 Jan 2024 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="ilMqJwVO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jPFVY1ox"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB25613FFA;
	Wed, 17 Jan 2024 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483795; cv=none; b=g6SmQzEWNKbELEDntnjXXpsYErxnLXoW3InpVt2D6VAs5AKbKu2huqm+APFgEjjS577veRlg+kDDJDVsdZGG8Tjm8emXXQNVF/Qydq9ThxFGwsVRte3pDMZrDIy36yPUQdXZ0B+dRUaaeRU8e9Mko665n7jeH5uUq5ljYVgbJa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483795; c=relaxed/simple;
	bh=QSUhYk2iu/3Pt17e2A9ZFtKpXoLCRx/INowv2VVp7F0=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=UnLaZgeKzZnfBCH+xcKlQPRT2An8St6Q7Eyh002oGfIlDH/gNiuWFRq9JkmtmVZRl/ptn8DXQAnrH9o1Uvdop16ZtUn4EVDVs+lHQliwmGQtkfmXrAyCmNEs/HeMzNZ00WUf0qOC7z8vpJfB/9Yh2Gz3lNAXUkYZHlKWyyqRq7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=ilMqJwVO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jPFVY1ox; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id C74D15C0035;
	Wed, 17 Jan 2024 04:29:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 17 Jan 2024 04:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705483792; x=1705570192; bh=QSUhYk2iu/3Pt17e2A9ZFtKpXoLCRx/I
	Nowv2VVp7F0=; b=ilMqJwVOTCaUXiOCJCLTERMo7s+WGjY250Srh0NceOwj9wKu
	zXlmbwokL2pJE+MQXwFt4gHYe6K9yeqQJJOP3AHdzqSRxMdEwp7Hpf+rKF8UsKqQ
	C8shGgQg2U76560aT6MEE/p21d7Tqc/MINVsipjhr822A9eAoRH8Dxhnn9MpT9SM
	Np9a+czeQ0AxzR+PCSvXpTpwSby6T/zzcl6iJJ6djJsPmIFs0az0+hYg1tlu8rO7
	4n4IGQhzxgNN920enN0i2sASVW2QrgUwTTlkktINZrlRDuhDHmSQWkFOXg374tVp
	KsuOpAWs2p0qf2djo+lsgKnTQNZLj3/KxBOjJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705483792; x=
	1705570192; bh=QSUhYk2iu/3Pt17e2A9ZFtKpXoLCRx/INowv2VVp7F0=; b=j
	PFVY1oxF9Ykyht36z3Pwgc58JOy1r2FKh5RTCEvd/skZh1koBskJN3p3+aEEymLe
	LTDQp2z+godBWjFDFAdeUEdctbF2UirMbv1LnMO995EAXgRyBXoH7+5s3pQHzSVE
	ONF/klHXYCoqtTjEs+bB9iOhbtPP+A5gDEXGC3J/w65W11cObQwsUyk4GhJ2CIFu
	qu4wghy6zDyGUn7sb4jxChBBSqttSBPMLkLL8K1yI2WhEhBy0lAk/mUEI5HnAim8
	mmSDzUSKMzbaQrm2dQ8Zx1t6+bmwrvhXEKll0edHHiAKpCkxzs9gWAV2W1VOZo2p
	NZhms5jsW5w/9dJhubnIw==
X-ME-Sender: <xms:EJ6nZeAb64Dqgmn7qkJ4K_Mly5keCS0qsE4vFIx6LLQYqWuclFqucA>
    <xme:EJ6nZYg6nFkfdEZyLmFyFQ3PLwm7fmBHoBszH_oAq2b7NScVpi8iwc9YjXnmlFtiU
    8Bscs3ReQ>
X-ME-Received: <xmr:EJ6nZRl022CugEn3Bepz7pK0-JptxR12Jhq45pS53_4JRRT8_B5V5x2e03fjTrZffMo5eT1v-yXmkYU7A54EHXpaf7xi-PFgk4GzUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejhedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefvihhm
    ucfnuhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvg
    hrnhepheehgfelhfffgeefkefgjeelkeduleefvefhgfekgfetfeetvdeigeekjedvffeh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimh
    esfhgvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:EJ6nZcxQrmGzfP-MabbU2yGr6J6uoh3PRXutfAU6We9sr1Y47s5hFQ>
    <xmx:EJ6nZTRzI9TMME48-SZoGrt8dpk842uYP0f9L7o3OoJ5n4rHzvGerg>
    <xmx:EJ6nZXZhb_kabZJR9pETnEVn1SQj0fBFnyoYVqE2e3ytOuVmC3z4oA>
    <xmx:EJ6nZYI63WcsNZzvs5yXne4jOo6peWDk79UDGCs_A1P6lt5SvUClnw>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jan 2024 04:29:48 -0500 (EST)
Message-ID: <5cfba450-eb5c-42d8-b422-52610d34effc@feathertop.org>
Date: Wed, 17 Jan 2024 20:29:46 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: rockchip: rk809 fix existing example
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Chris Zhong <zyw@rock-chips.com>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Zhang Qing <zhangqing@rock-chips.com>, linux-kernel@vger.kernel.org
References: <20240116132102.3272682-1-tim@feathertop.org>
 <20240116132102.3272682-3-tim@feathertop.org>
 <20240116-flick-ungraded-b36f8db15dcc@spud>
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <20240116-flick-ungraded-b36f8db15dcc@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/17/24 04:07, Conor Dooley wrote:
> On Wed, Jan 17, 2024 at 12:21:01AM +1100, Tim Lunn wrote:
>> Fix typo in the example specifying wrong compatible string for rk809.
>> Remove additional vccX-supply properties that dont exist on rk809.
>>
>> Signed-off-by: Tim Lunn <tim@feathertop.org>
Fixes: 6c38ca03406e ("dt-bindings: mfd: rk808: Convert bindings to yaml")
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> A fixes tag would be nice too I suppose. Not worth resending for IMO
> since b4 will pick it up if you reply with one.
>
> Thanks,
> Conor.

