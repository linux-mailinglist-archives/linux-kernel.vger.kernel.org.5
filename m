Return-Path: <linux-kernel+bounces-129471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4290B896B4A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF53288024
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5320E135A68;
	Wed,  3 Apr 2024 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="N5y6VrLn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bSkj/ls8"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A74A135A4A;
	Wed,  3 Apr 2024 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138498; cv=none; b=IrJ9Fn5jq9nr42Ro5ofDKQ/Co/4IKbySbirfqjLurw3YO0frq2boizno2cyt6ZvRo/DjSdK2H9lwIaaFbOrl6dqbyxbrYeuaS/ZlbhK1lRRQlxa+5BWPjQaT2D9OxOrwFsms20M+uAikZJ3VwLMMI1Y2J6kTZCDTCNq+AJDeHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138498; c=relaxed/simple;
	bh=vMkLetNPB1me++oyqi1Ldwe72CHVBB/yEMO0BA/ymXs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=jNUu1+oLf6IOJBbMY5ln3z3qKkn3z3kqTt4Ul6j/gB+UlI3hLjbtEU7fD8bPm/rnyeonJI2LWjT+h0HQMonoy0Uuhvxz1YjNObwVok3Md0LxMLP32ebi7mlvGP3/nOxpoFgxoI6AFpFlMdkX0kGz5MaUsi6QU+hWnM40LgT3lSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=N5y6VrLn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bSkj/ls8; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7C7D711400B2;
	Wed,  3 Apr 2024 06:01:35 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 03 Apr 2024 06:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1712138495; x=1712224895; bh=FrXkAOSFmk
	UZLsUI2R2jdHHRsabl99OcXBCzPe9Bxt8=; b=N5y6VrLnKCdIckcpZ/Ec5qxf7B
	ApY+CjK+qJhjbT93GXYHcWiIE1EExq3imOAip20w4biUpYPeTnvsqIW4LTW5bydq
	sYwNPt4e+hdpNFDkcipTpvUnWSonMl1J/GlXg1khyZ14ZiZqq6SSAGHULTnPuaft
	S6rvQujKRLUgg1v/TrcQ2DQXOa3SawFA80LzHsg2Q71qor8Q8a+V5dVOw1xrEC9J
	sEgSV2/qkpQ8qfMTJqqnTXXrUihkMn2NuC5Z1SQTKZKIzliPZKjqYq/w+19oCzwF
	AWNsACleQWbUvORVGEruEVDIKG6txECtKPeFq4hWzOFP3vclwZlNOaQMOv2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712138495; x=1712224895; bh=FrXkAOSFmkUZLsUI2R2jdHHRsabl
	99OcXBCzPe9Bxt8=; b=bSkj/ls80nL+C8gvDE9B5ovF6Av7IwSaVvgtyeam1dwb
	X2HpffRxaUiFTpplaXXWb/TsgmYNFsUYia9Hx/FA8ZMjLSpU12H+pBETUJuGzclL
	Pf8jH6Ef8hFBqMkQWxCHDoeFPHykcLqeW9xylb5so6ty49oF4cqXxzJJX5Gf3v2k
	8j8MXaOwtDKE/VjCZ0FUASf38VvfeLy3JeI2itAPNYKwEokLcXzN2wImbVkSv0Vk
	fQccd8e1EfJebl6N0cRI2CXFUMFIAluiSbHwsROsHRZf3nV/Zmw+3TN5N39q9X3X
	ZZfFZw8vLbi6yRlv/GH1Iw8R2QtHs+Z8omZKq5vffw==
X-ME-Sender: <xms:_ygNZnjXxBaoUCLG6TsoBrx_dWGCo8VMn4vXLR_xnm4xweUDSPXeVA>
    <xme:_ygNZkCq-4UYAPvH_Bl8KvoSjidqybn2FeHWoJgX0l6uKdZ9hB8mKmpOMiH9Wgpzq
    fVS-wBd8Vojm6hVCMc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefgedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:_ygNZnFVfZGqPOePNKyrBp8ATlLE0n2wnYPMaMJLxOOWa-cCR5MABw>
    <xmx:_ygNZkRTMJQMwZOGUDsQVDnPjehjjjeixFtVlWkwgdGKXT0-eLa_dA>
    <xmx:_ygNZkxQVnrKijBqp0TXtPifpvZ8MUA2aT9IVXUKZHRvkMmN0hL_PQ>
    <xmx:_ygNZq4U2xFKaHUqWod4h1geN4SSxhKdkV5I6zgucJB8shct0NXXEA>
    <xmx:_ygNZnxEpBPj6xG9uBfWNSmdoHxoHyiu9bBxaXUr1NpH3ePs_n6h81zv>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 21D35B6008D; Wed,  3 Apr 2024 06:01:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <65788cd8-3c2d-48ca-8b58-af741884c729@app.fastmail.com>
In-Reply-To: <e9aefdcd-5ee7-4b19-847e-5fb3d95cf46c@linaro.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-17-arnd@kernel.org>
 <e9aefdcd-5ee7-4b19-847e-5fb3d95cf46c@linaro.org>
Date: Wed, 03 Apr 2024 12:01:13 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 "Arnd Bergmann" <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 "Lars-Peter Clausen" <lars@metafoo.de>,
 "Michael Hennerich" <Michael.Hennerich@analog.com>,
 "Jonathan Cameron" <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 16/34] iio: ad5755: hook up of_device_id lookup to platform driver
Content-Type: text/plain

On Wed, Apr 3, 2024, at 11:55, Krzysztof Kozlowski wrote:
> On 03/04/2024 10:06, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> When the driver is built-in, 'make W=1' warns about an unused
>> ID table:
>> 
>> drivers/iio/dac/ad5755.c:866:34: error: 'ad5755_of_match' defined but not used [-Werror=unused-const-variable=]
>>   866 | static const struct of_device_id ad5755_of_match[] = {
>> 
>> While the data is duplicated in the spi_device_id, it's common
>> to use the actual OF compatible strings in the driver.
>> 
>> Since there are no in-tree users of plain platform devices, the
>> spi_device_id table could actually be dropped entirely with this.
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/iio/dac/ad5755.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
>> index 404865e35460..5c1e7f428c25 100644
>> --- a/drivers/iio/dac/ad5755.c
>> +++ b/drivers/iio/dac/ad5755.c
>> @@ -876,6 +876,7 @@ MODULE_DEVICE_TABLE(of, ad5755_of_match);
>>  static struct spi_driver ad5755_driver = {
>>  	.driver = {
>>  		.name = "ad5755",
>> +		.of_match_table = ad5755_of_match,
>
> I was working on this as well and have a bit bigger solution, following
> Jonathan's preference (I think):
>
> https://lore.kernel.org/all/20240226192555.14aa178e@jic23-huawei/
>
> I need to send v3, somehow I missed his comments.

Yes, that looks good as well, though you might need to drop
spi_device_id table if you convert it to using pointers.

     Arnd

