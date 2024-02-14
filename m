Return-Path: <linux-kernel+bounces-64729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2538854205
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4690A1F29F82
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A3ABE66;
	Wed, 14 Feb 2024 04:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="qs2P9hef";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SFcASVsS"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E586DBA38;
	Wed, 14 Feb 2024 04:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707884838; cv=none; b=aOz4RxGOsU8U2rxuIky07p7x2VS17PVupTdz/i5RqFTEcSy7mqQJHBJ1fbB7zvbgmp0IZ/P4y4zK7siSchWsDWTITlPu72vS5KEisKdLRQQjLOGVW6Bdwzvk33C3HOdD2jHUk0k3931G0DIQSse42r5DrlaKNpJSdEveqfHNx/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707884838; c=relaxed/simple;
	bh=Ol/PurIm4wxjhSRQmPC3WQpP/BfIk21zoo875dvLBGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CaKyg9yvYFrs9NXd6+YWDXxdudzYIUiFT1ZRcw0jYCxCMWSpLl41affIOq2Dj/kAmsFKJNGtrxBFQm+iCHr2ZATr6b2OyZNUqxyHtku69RA20UNPZsVVKVhwwIZn9W2ueccatgqrzINbZWshEBG08tURR6mvhjRBNyDdN3HYMvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=qs2P9hef; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SFcASVsS; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E7A2911400CC;
	Tue, 13 Feb 2024 23:27:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 13 Feb 2024 23:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707884835; x=1707971235; bh=NcDqWldwOd38d78Sab57ZcHkd6M15Epg
	BXZmppi5guU=; b=qs2P9hefaHjj53jCs7xvzmkhxzNirHB7fBfeMubnx6bLkn2g
	3JUlEcaYrDAltnTY1mR3QsbC/utMAA5vmyzFYlA3o1en3kI4we4AqjfDqVZmaz92
	49KxIEvBoNfSiUBeP+scY78x0ss+ZJkY0SDyCIq6B1RDRU97NHBf9qxCgcEFyhvq
	F+ARvySi1pgRXCReTrDAqReMRd9EzMfB03MADKvrNwDl6w+Fq2WO4aLD/WyRzga6
	no6ZBDHwCXwGxAzZwBHUQs94U1iEStRNgl0SaO5z68qhYUx3WttTlvKcmgd9TgAf
	NtWZcLYgQ0TCNl8aV/dnZwMQKU6Xl9VTigLsDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707884835; x=
	1707971235; bh=NcDqWldwOd38d78Sab57ZcHkd6M15EpgBXZmppi5guU=; b=S
	FcASVsSdhyYXhlJIsm3VKqlIO43D0QQYLCFUnLLjzecomk004GoE+RenTKqFeI7L
	GHUu/Ppa8qCoeydRaPGE4Vd6QRzCJiiZo9R51+e7w2alUPxv4nCzgkCUt8vkcfxt
	5s6dTCJk5uZhSnoon0QY0elbqVmNktzjHYMrJfWAD777TMfZmNSjOsmmiZICG2/m
	Nj8oNO3sihET6DrH5SmWGs71tonmfaDgrqmoybkf1pmmHea6VBKCJxSW69Cjsh6M
	vJ0t7y8ZWTtYDYitmSYIeuNshxAvMD7VI+HVK2R1rnrkvKS7LeDYRmlfjYd3MyEq
	AJL/fWaDmQ72iBtCd6m/w==
X-ME-Sender: <xms:I0HMZZ8vJqWoj4L05vDQe5BlBq-t1u9EGb1_51UyReDFgz5XQzorEA>
    <xme:I0HMZds8lbD8fjZcEy2mXENdQMT46386GB3u71ywQV3Yh9sfn7ugcSOcBSirSxiPg
    g9R0p05EQ>
X-ME-Received: <xmr:I0HMZXADfD9LLKtsGayRai3RVZGZHNU495y-AkUcLFwxl038JAJqsaQ0S2rQLT59DJ5MJrZX-EhucdpfNwP1_x-L43_AFqYLwOqVcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhimhcu
    nfhunhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrh
    hnpeeugeefgfevueeitdehfffgfeevjeekteeihffhvdejveelhfeukeduueelgefhkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmse
    hfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:I0HMZdeCBwPfnT1ZIH0n26LFgfadXuZOPl7VDgxPfzBSVH8fgggPIw>
    <xmx:I0HMZeOjN1bErTEzCVtjYu5gSM8IwUNZ8RV1o61DZ1MfKNusRKN_bA>
    <xmx:I0HMZflVGSMJgYnWtvsO8jBnCK0mBavjdmsEpkcTK9CACqrWUeX2xg>
    <xmx:I0HMZTw09S9uGhOiQQufUIfKJKEaVAAEBk89p69zQ16q7RmP_tMsQg>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 23:27:10 -0500 (EST)
Message-ID: <e952d127-b12d-4b5a-838b-807a876db707@feathertop.org>
Date: Wed, 14 Feb 2024 15:27:08 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Fix vendor strings on Rockchip boards
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, Andy Yan <andyshrk@163.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chris Morgan <macromorgan@hotmail.com>, Conor Dooley <conor+dt@kernel.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 David Heidelberg <david@ixit.cz>, Heiko Stuebner <heiko@sntech.de>,
 Jagan Teki <jagan@edgeble.ai>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Ondrej Jirman <megi@xff.cz>, Rob Herring <robh+dt@kernel.org>,
 Tianling Shen <cnsztl@gmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240214040731.3069111-1-tim@feathertop.org>
 <c03220db663279c9e83bab81f3d829e7@manjaro.org>
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <c03220db663279c9e83bab81f3d829e7@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dragan,

On 2/14/24 15:14, Dragan Simic wrote:
> Hello Tim,
>
> On 2024-02-14 05:07, Tim Lunn wrote:
>> A couple of rockchip boards incorrectly list their vendor as Rockchip
>> when they are in fact not manufactured by Rockchip.
>>
>> Fix the vendor strings to correctly list the manufacturer
>
> Just checking, have you verified that the old, incorrect "compatible"
> strings from the board dts files aren't used anywhere in the kernel code,
> such as in some drivers?
>
Yes I checked that, there are no remaining references to the 
old/incorrect compatible strings in kernel code

Regards
    Tim
> Otherwise, for the entire series:
>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
>
>> Tim Lunn (4):
>>   dt-bindings: arm: rockchip: Correct vendor for Orange Pi RK3399 board
>>   dt-bindings: arm: rockchip: Correct vendor for Banana Pi R2 Pro
>>   arm64: dts: rockchip: adjust vendor on Banana Pi R2 Pro board
>>   arm64: dts: rockchip: adjust vendor on orangepi rk3399 board
>>
>>  Documentation/devicetree/bindings/arm/rockchip.yaml | 8 ++++----
>>  arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts    | 2 +-
>>  arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts  | 2 +-
>>  3 files changed, 6 insertions(+), 6 deletions(-)

