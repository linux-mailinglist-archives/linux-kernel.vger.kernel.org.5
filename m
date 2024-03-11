Return-Path: <linux-kernel+bounces-99604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F97A878AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF19CB21216
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E962052F61;
	Mon, 11 Mar 2024 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="vjTT2syL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j5p16aBH"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9CC57330;
	Mon, 11 Mar 2024 22:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710195766; cv=none; b=uCMG69AyPrLKk/MDYRv9TebD6fl6zfEzOFFCCaIi/lymMEeDAmtAAw00ugCtalPTi6CEYqIGiC6WkJbP9dPdhKc2h1YN+34KIkxb5XZkGTFJzs7Y2+/shHGX+VjWfJ0KnxKeAu4Pwo7UfdKOBCKQ9+nZbWxA7E6zns8oamx9MHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710195766; c=relaxed/simple;
	bh=DaLBLIZUZ3x/hORYWzsnIkMLSdKTpPm8OJ2UrzslVGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8gOtUQdcFbVAkZrO0BR3blJDQYGNVlG9j0rlRHsk7u72i0b56bbvF2loWr0Ngs5P6q+d9xsz0UTxhGXkumAKonb284GfFSltNjni6WsK191RDGmkoA0iS+mgjdR2v5pb3wiw3VZP5MMc200SEV/YHgGFOaBYeirUSnE+vTkpyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sholland.org; spf=pass smtp.mailfrom=sholland.org; dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b=vjTT2syL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j5p16aBH; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sholland.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 739EA13800D1;
	Mon, 11 Mar 2024 18:22:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 11 Mar 2024 18:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1710195763;
	 x=1710282163; bh=euLXNMdPmZs+c4REjNWXGAVfOTGgaja0guAdjfE1SFc=; b=
	vjTT2syLSB9u53uMyyRFO4tyg2iLdkxEagkvx6Axthde5mJjYUmvMkZ4mNGmo3Fr
	rC/h4atOdaEMIIgzJcYD7MDoYGQ+/fyCFcXIg2nE4NES2RwriM8lL3yAAB5Xxpf3
	ts5fKmv56+9yplMLes09n76DRY19Dmdjc+qMe3Y0E2YDWJqPJFbutQyZ+uONy6aR
	xvthG9bvNOKyNglIYivmO6yV+kFwhWGzj+TbSAOvg6nvI0Nt7x9kY0SYn7er1LjR
	ovmWluiQ0rBAraECgK6Y/j39g5//OzMsa/ykXvCVc3HIM0icGbEt63WSXXstXh3L
	zUBEi7i3lJE5DcAN/Ex/1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710195763; x=
	1710282163; bh=euLXNMdPmZs+c4REjNWXGAVfOTGgaja0guAdjfE1SFc=; b=j
	5p16aBHn5kEkBmh6scxe3qc1ciWZKmecJdP3LNW834SM1wJm1dZvt02kMW6xMdMo
	hZNF3lK31pvvuKJ/+twUk8ow5BIM4TmA7JD+wt+SnSA7FVU9NJvOfN5KWRbvZoSN
	e5Jm2pgLdKPc03w6TSsi/Mcz4OgDIPNi93otZy8w1s3Tu2BgtANI94TlmZQ86KtI
	gvWGdINXgodKW43SVAF4Az1R7ufACF9N0m3Es17cc59otJHQVql8sTg+pA6NLAeT
	QKYodm/aYFEfjZE2L/p7dDCdc33MhM9pqfOCEZl8+UIioYIfcKTwLVQ1jVeQWClc
	h8oAnU6QbFFWnN/oBc8yw==
X-ME-Sender: <xms:MoTvZSWnaAA9X6dzPLueS_Jjmw3rWrcLAf0-LRWGjZL0BkNZSx1GAw>
    <xme:MoTvZemEzKbuGjhbIAu2aY_YIBu7k4tJEW9wQFdDPZHNfen-QikzsMT2zFWm4O6f2
    NSWvgj9SX2GKre9dA>
X-ME-Received: <xmr:MoTvZWZFqlDwh5oPSAK3HlUTLZbS2juuz-FrnNDO1FQ50_vanmvoBjz_aJ5iQ6gilfM5ScStWBNeqOjvJ3uf8rNdfnGST9NNjv3JUaS7KnBPMfqkLyCeIMoOWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedugdduieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeetieekgeeilefgtdfgteejhfevtdfgieekvdffjedvvedvveei
    veelfeeuhffhfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:MoTvZZWcxAXWxK6RfhnWKMrVLe_8lQp4jGGVJ_w19zrir4AlFgwI3g>
    <xmx:MoTvZclNBOUVW_mOjknd4JENpL5N894y7ePaJCPcNPrqxsL-qpIGOw>
    <xmx:MoTvZedQ6uTtsHOJxYHtG_X_jgy2yV8Np1G7rfYVx2a6n6Zj7BSaXQ>
    <xmx:M4TvZanzQDTnEMmwfZbqI2Q8nAMQo2piGOHodqV_6NacyUZn_rb97g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 18:22:41 -0400 (EDT)
Message-ID: <4ae70e42-d345-4914-af40-5dfc9e2b3ef2@sholland.org>
Date: Mon, 11 Mar 2024 17:22:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] regulator: axp20x: add support for the AXP717
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20240310010211.28653-1-andre.przywara@arm.com>
 <20240310010211.28653-5-andre.przywara@arm.com>
From: Samuel Holland <samuel@sholland.org>
In-Reply-To: <20240310010211.28653-5-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 3/9/24 19:02, Andre Przywara wrote:
> The X-Powers AXP717 is a typical PMIC from X-Powers, featuring four
> DC/DC converters and 15 LDOs, on the regulator side.
> 
> Describe the chip's voltage settings and switch registers, how the
> voltages are encoded, and connect this to the MFD device via its
> regulator ID.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/regulator/axp20x-regulator.c | 84 ++++++++++++++++++++++++++++
>  include/linux/mfd/axp20x.h           | 21 +++++++
>  2 files changed, 105 insertions(+)

This is missing support for the boost regulator.

Regards,
Samuel


