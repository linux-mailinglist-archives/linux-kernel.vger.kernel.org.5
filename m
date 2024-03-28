Return-Path: <linux-kernel+bounces-123396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7DA8907E7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17B728A84D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DA91327F0;
	Thu, 28 Mar 2024 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="duUSY/66";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="yCFKQE9T"
Received: from fallback3.i.mail.ru (fallback3.i.mail.ru [79.137.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC4446549;
	Thu, 28 Mar 2024 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649018; cv=none; b=Kac2oLEoqMyftcGJAWghtReb+jophx/GEVpPzWQ4TR3bHtogB2LtToGAWkK67nkNILnk3km9YcrgXKKikTG6EjceFXybOE5XLA5ZVqU0JhJ+9UQlLOeQw+jtSeqw8nCtKEwiHRPH+Jf3H2QO8SWOYkOCJ2JPa97fo/7HROoSIsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649018; c=relaxed/simple;
	bh=Qgan/28lSQDJHPGSlYrNVGDa1iWDJaJKkuMe0tkMSbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Si1HsksVvRVKiOR1jlMlZyGYCtobyy7jQnZIdDlMeKB6qW90kSQTGrACDgqlJHkUwTexoU3WUMQuDAIGm6hbjNFwr37lpUkNShBQUVEeo7jteG/fA2TLA+LxwwQ2a661ANmrIt7B6pABoEmmyFLE6FSqtiLcvUJJge91oYOFdzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=duUSY/66; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=yCFKQE9T; arc=none smtp.client-ip=79.137.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=FYql+39635pPARFqzsyAcc+goLlZAruHhr7XISd7EkI=;
	t=1711649015;x=1711739015; 
	b=duUSY/66guJxRr16B3aG9RgsJhOqVpuW0YcLDXje+/ZLwxbO8RTMXfHBVptnXZTlLXT6TX4PVc2QVtiIm1xbCUpnGY/0fR6ukQS4PKg4jFF2WaNmwYpRxUGl0HKmVu6ChkCyjD75cleqGHV40V6N4eR24yHVF2KtFEmdHSqslwI=;
Received: from [10.12.4.5] (port=53232 helo=smtp31.i.mail.ru)
	by fallback3.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rpu63-00Fktt-3M; Thu, 28 Mar 2024 21:03:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To
	:Cc:Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=FYql+39635pPARFqzsyAcc+goLlZAruHhr7XISd7EkI=; t=1711649007; x=1711739007; 
	b=yCFKQE9TUZp2zvfMgE7vRA3neDhhmtkWdjB+XyR/GT67P0fNXnnZtKP1E9JVKMW615kD6w/4VcP
	jSh+e43VCs50zUaQI2IPRKbEKceEv8rGD2zZWllkVTV14xU+FnOsJd5fhXyLIv3L20MTE/2yNHzd4
	9ZriowiwtL6oXz0v/H4=;
Received: by smtp31.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rpu5m-000000004xW-365E; Thu, 28 Mar 2024 21:03:11 +0300
Message-ID: <d09c9486-d2ac-48d7-b5d3-49b9e1a8cc0a@jiaxyga.com>
Date: Thu, 28 Mar 2024 21:02:39 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add QMP UFS PHY comptible for
 SM8475
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, vkoul@kernel.org, kishon@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, danila@jiaxyga.com
References: <20240327180642.20146-1-danila@jiaxyga.com>
 <20240327180642.20146-2-danila@jiaxyga.com>
 <b73034c3-a512-46b6-a9e8-4d43fd3b39e6@linaro.org>
Content-Language: en-US
From: Danila Tikhonov <danila@jiaxyga.com>
In-Reply-To: <b73034c3-a512-46b6-a9e8-4d43fd3b39e6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9D135BF24EC7C3B84E409907A6D735ECBA16617DF397FAF7E182A05F538085040B1B33BF6701735563DE06ABAFEAF6705B366187E7E3861AF07D04E831C9623BE8DBD743D6B298C11
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7D8156D3FCB551F18EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637367CCE42412B8BE38638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D84C5534149A20A4B7446EA6E450E85CBC755BFB8BE591E624CC7F00164DA146DAFE8445B8C89999728AA50765F79006374F09588CB15B21E6389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC821E93C0F2A571C7BF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C2A336C651863509103F1AB874ED890284AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3D22EEC73CD09A32ABA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF4964A708C60C975A1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3517C622C16A6DF10089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A54473C4F97DF469BD5002B1117B3ED6964977B22DC1AF9A35E772F934B9BCD185823CB91A9FED034534781492E4B8EEADF7ED4D6813B5CA04BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFD31074B2C43677369B79855EFF73DB34C16B764B336C4F303F3A723C889166802219C82DFA2AC3F2F212F37558E7246644842C3A0C1AF31872A5BA0A6CCFD3F3BB2CC9B78C32E292E4FDFA4A036B0C3902C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojc7pp9Ls8Ei4jbyEctUVI/w==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498132BB97676BEE5F834825860F061DF214C1251D50B147D3F0C27B3BED2743912F2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B469FED0CC4E03BFC3F7F23553880BB0CDAF27EEA17067111C049FFFDB7839CE9E088A9832E852848531682E95005CF72BFEC8875F8934368A4CDA5DD225F706A4
X-7FA49CB5: 0D63561A33F958A56FFAEF5AD01A34C072ED808061251F343FFAF0CA4A1BE9158941B15DA834481FA18204E546F3947C629BAC65E8BCEBC0F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637EDB6B411A17B440E389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C30F754AD15E8417F235872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojc7pp9Ls8Ei5+jSFG3MhYXQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On 3/28/24 11:42, Krzysztof Kozlowski wrote:
> On 27/03/2024 19:06, Danila Tikhonov wrote:
>> Document the QMP UFS PHY compatible for SM8475.
>>
>> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
>> ---
>>   .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml      | 2 ++
>>   1 file changed, 2 insertions(+)
>>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> (not reviewed, please provide link to DTS)
>
> Best regards,
> Krzysztof
>
Yes, sure.
SM8475 and Nothing Phone 2 (nothing-pong) on which I tested:
https://github.com/mainlining/linux/blob/danila/sm8475-test/arch/arm64/boot/dts/qcom/sm8475.dtsi
https://github.com/mainlining/linux/blob/danila/sm8475-test/arch/arm64/boot/dts/qcom/sm8475-nothing-pong.dts

---
Best wishes
Danila

