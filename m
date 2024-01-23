Return-Path: <linux-kernel+bounces-34704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437D4838658
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CC91C2681E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE141878;
	Tue, 23 Jan 2024 04:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="rU9DX3UA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wuRjf3WX"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F541848;
	Tue, 23 Jan 2024 04:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705983945; cv=none; b=i1i+RhMNkEPlKcILdGSLl/b3xHbkfAIrxKN17moRI8h1PptvCBfWwJTguAkKBICECNbEXay3EikVC7Sae2JsC/VfrdRMSq/mqPsEs4k4Gl9s7Z4hO4R2L06rWk5Re9BEWtBthKXYKFsGAbu8yeUoau65OX7EXu5G4XQtqK7ZOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705983945; c=relaxed/simple;
	bh=v3oy5NdlG5MHxk2w2nXjXNbvl7QH5t23LPLqkF6IHL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLYkKHT0bf3kKIfkSC9pApap4PbwiyPIOqmYcjdNdk1ZYmdWOuBUKoUPxCgxfGdIT1zIvsuNXLFFx+um9TPQ9pH9rKbeOe0v/YpJY95HxQQj7BeOWo5m1XRcNDbfAe1ijSUA/gcdZAsAVNSFhXRV5AnyH/MWcMWSgf6XyXB5avA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=rU9DX3UA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wuRjf3WX; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 960D15C0318;
	Mon, 22 Jan 2024 23:25:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 22 Jan 2024 23:25:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705983942; x=1706070342; bh=45+1oXceGikZvQxwJfaaf8EGXsa5wr/Q
	8SOh/sMefXo=; b=rU9DX3UA6Ldi7CBk/PlLyV0Txp9+MdMKn9eR2Qs+X+tvvqWd
	dk9/lOw9dCssfusMnld5S/+LfhwDNakIintK71RDpHfp/pgUrC6MQgBCTsqwwOGv
	1AOIuwPa4tgl2EvRAOmzRSVT6GgI/PlYsDAYQl//aSliNumw6i6x8xyaYnqa/FKV
	pY1YleSkBO4FwXIbxv2syLFJBWHjBovXcPhmKCO8gEaVXKi5Zih3g6qDF1UyURjb
	KeC85MHvHmABa/PON7OykZpKPg4eGcx4ra7keOi4ILjh078uIZRmYAtibvgKsb3+
	7AqZrnYy2QYrCTYOSrSqz/pix2pViUPToSm8Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705983942; x=
	1706070342; bh=45+1oXceGikZvQxwJfaaf8EGXsa5wr/Q8SOh/sMefXo=; b=w
	uRjf3WX+KkUa1Yhniz0KKiJ6n2X83yveTNlB6o6OofO3BlN3fr71wJLSd56qXZm0
	gT3HdgL9W9eYbOE6SPzZtf6GUuEamYPBOmpX9eJ9ej6YmH8EhF9TB9dhvFz7Vy/x
	WE0wO1LN+r317f1H+QFgeebuJIUFeZhedRZyzpqld6O21CsiHheswzkssqnS8wuH
	FcykcBJVKNpi5zZnOE0NSd6XMKJz3J4zBhGs7p+W23W3rmvZlI9ySYOV4VDdlszj
	u+BmYaoOVLPDXQI3jJmaQrHdVSF+VS0ABO6gC+EvppZwmqo+MClcZxIOvY+x3nQO
	wJqul1S1gpdKzZbClEt4g==
X-ME-Sender: <xms:xj-vZez8bhCJTDZK5KxpbJqvM64DwozZ5xZPzkeYhe7KBPk8tzyQ7g>
    <xme:xj-vZaTUA9DpUOj23hcmKqLVEvAdrP4Jw609l7veT7cGGvO0a1T-QgbA9_3FTN7Yy
    4Cmjp2aJw>
X-ME-Received: <xmr:xj-vZQU6PTnnUof_aVallJWT2Udea7q5cOgr4oN1EKXAVBuCLDkHLzim2FFLSOCxtYZNpTu1mIL6g-unhopgDb3LXHFGqyAvkSLUZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekjedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhm
    ucfnuhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvg
    hrnhepheejjeeuueejfeektdfhteelffdvjedviefhhfefieelleeiueeitdfhheektdeh
    necuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepthhimhesfhgvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:xj-vZUiesXhZuOQAS1bu9jVn6lLI6Hw9_iJBMaHJbbZXhGn9Ciiz1g>
    <xmx:xj-vZQDZeI7b224Zv0_dZR68SQuqxxsN2pes7yCjLuykcPMDCsooNA>
    <xmx:xj-vZVIBUcn_y9SS8UiliUPvpkqQ8_7zfE47Qg8iU5g6t9dD0PFrfg>
    <xmx:xj-vZZIMUlcXooeuUvt8pGWecGuASUYxKnCm_Dkp2ANQaiFxmtN_Sw>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 23:25:37 -0500 (EST)
Message-ID: <9e5cace9-8725-45a4-a55f-f996a561c9a4@feathertop.org>
Date: Tue, 23 Jan 2024 15:25:35 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] dt-bindings: rockchip: rk809: Document audio codec
 clock
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-rockchip@lists.infradead.org, conor.dooley@microchip.com,
 robh+dt@kernel.org, devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Chris Zhong <zyw@rock-chips.com>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, Zhang Qing <zhangqing@rock-chips.com>,
 linux-kernel@vger.kernel.org
References: <20240120135529.899403-1-tim@feathertop.org>
 <20240120135529.899403-4-tim@feathertop.org>
 <2e9ae099-18a3-4e22-8868-931d41c81f3f@linaro.org>
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <2e9ae099-18a3-4e22-8868-931d41c81f3f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/22/24 19:16, Krzysztof Kozlowski wrote:
> On 20/01/2024 14:55, Tim Lunn wrote:
>> Rockchip RK809 shares the same audio codec block as the rk817 mfd, and
> What rk817 has anything to do with this?

The existing codec driver in linux already is from the rk817 and thus 
called rk817, however
that driver is also compatible with the codec in rk809.

>
>> is compatible with the existing rk817_codec driver. This patch
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
I will check this as well.
>
>> introduces the clock required for the audio codec.
>>
>> This clock provides the I2S master clock for the audio data. The codec
>> driver finds the clock by the name "mclk" and will fail to register if
>> this is missing. Clock-names is kept here to keep  compatibility with the
>> exisitng driver ABI and also to be consistent with the rk817 binding.
> Typo.
>
> Also, what consistency with rk817 driver?
The rk817 codec driver that  already exists in mainline linux tree.
>
> I really do not understand which problem you are solving here.
I will fix the typo and try to clarify commit message further.
>
>
>
> Best regards,
> Krzysztof
>

