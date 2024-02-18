Return-Path: <linux-kernel+bounces-70554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7B885991D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F991C2105C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8051B383A3;
	Sun, 18 Feb 2024 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="nuN2t6YX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="NSAsfQ3W"
Received: from fallback22.i.mail.ru (fallback22.i.mail.ru [79.137.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8888D6F507;
	Sun, 18 Feb 2024 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708285002; cv=none; b=ozbTwLpDLRdnRdbk5Fzwv1XSJWTOMECSKyDs4CHQW8RJvUIg1jbFMjVPnFUcaunmoAWwPgsVrIx4jMV6NR86M8jjA5wZPPE1hkTiepwM87l3Bog05Jwp4KJsJgGZnD/R8wxH/LmDsNiZB7UuaEoZcpL+3M4PT3DVhP9AhsQgBJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708285002; c=relaxed/simple;
	bh=cBTLLd4fPeaUvWkODfGyD3++ZlviOPyT7dSZACmAIOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibUby+qDoCC1AKOjI0S8doAX0ADUbZydtkuTBX4vNpSQlNHHj8E6kVBIXN4Kd5p1yIYn4V8AMOu5nBSCPwnUgjjtoDcNL4WZkqgPqhV/93q989YgGYm7oXlZk3mA6Jh6xNVpO3qsrVCkodqTAslVFHkpgATFpLAxD8jbELi/vEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=nuN2t6YX; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=NSAsfQ3W; arc=none smtp.client-ip=79.137.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=o/hxFDSgXayAN8I0Y2EKcBJU46DJQsaZjaDQYg69Zrk=;
	t=1708284998;x=1708374998; 
	b=nuN2t6YXOZJPDSq6nNIGqcR9BxMq3YdPBhWXpMka5GXytPo4nVSB6zenx83nU69ad5TmFmmztMPX5oLyh9552MC+rsXkKU7oTOSN1EbnHvkUtf2hMHRhPqtUW4jWmbW69vFaHXaUAQjYYJxtUuysexKai6ponh+NsQQjDuBAyOo=;
Received: from [10.12.4.29] (port=48678 helo=smtp51.i.mail.ru)
	by fallback22.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rbmHu-00BQ6z-F3; Sun, 18 Feb 2024 21:53:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To
	:Cc:Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=o/hxFDSgXayAN8I0Y2EKcBJU46DJQsaZjaDQYg69Zrk=; t=1708282398; x=1708372398; 
	b=NSAsfQ3WT+evT9o2P3VRybQHhAFAxDoN+cYtqNS2LeBkdLiRkL8ADbhfwjTB9r4YHGYRDqbhg1J
	MG6K1yp8o62Mz3Iq3oizUS/vGcdSg3I6wEtv133tj38xf+8ETxGDaDDNswsJlBn7f2Gjeg/qIYM1A
	NhtqUO7743tgYY9P7JE=;
Received: by smtp51.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rbmHe-00000005vMT-21OP; Sun, 18 Feb 2024 21:53:03 +0300
Message-ID: <60728953-bdf0-4a06-a90a-d1191d41962b@jiaxyga.com>
Date: Sun, 18 Feb 2024 21:52:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: pm6150: define USB-C related blocks
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, andersson@kernel.org,
 konrad.dybcio@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 gregkh@linuxfoundation.org, quic_wcheng@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240217163201.32989-1-danila@jiaxyga.com>
 <20240217163201.32989-4-danila@jiaxyga.com>
 <6bf11ccd-ff08-369b-913f-277c189afb76@linaro.org>
 <b0b732b8-456a-4021-8277-cd51f01ead17@jiaxyga.com>
 <44c669a0-3722-4a58-be78-0c91f0573ca1@linaro.org>
From: Danila Tikhonov <danila@jiaxyga.com>
In-Reply-To: <44c669a0-3722-4a58-be78-0c91f0573ca1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9001F8F2F6BAD2021721DFC1638C0DE020CB518295F388C0600894C459B0CD1B9A01AAA9C53E1FC432F2A137662B0CE962297CA7220B8368C71C683C9A4AAF24583DAA694144A5695
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE746D93DAA4671895CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063767500BC4578134A08638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8FBF1F58988AA117F27B5378C4569AF915A99C2240F7500D3CC7F00164DA146DAFE8445B8C89999728AA50765F79006374F09588CB15B21E6389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8ED96AA85C75E140D117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CFACA9F7D16C0C9468BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B6AFA7A56FB51D02A176E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249D082881546D93491E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B603913CCF128142C9089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5B96BF9A7E50CFEC45002B1117B3ED696BFF207C5EA5A8D5922DFD5397F446790823CB91A9FED034534781492E4B8EEAD9DB614F8F96CFA30BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742424CF958EAFF5D571004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34411AA3F52B5778B68AFB7C41CED23D24D319A1D15F84B4677068687820F8DA58194B66EDDAE282011D7E09C32AA3244C8304EF706C60CF3B2887F5EA2DDCF344BE1C58D71CDCC731EA455F16B58544A26EF364EE5276B8775DA084F8E80FEBD322CFFF16B4474ECB4573B60270F1EB7C214C2BC1176D5C25
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj3ZJ49a6yxuuwKMqqiM4moA==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498149590CA6AC7771EACDECE012BE5914E03C454A2D891CD7F55FD86E11417434552C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4A77971E4CF73965D9E271BDE2CCB4C0C9224595B18E9D805049FFFDB7839CE9E8F5A60B08382AFE3C7D0837E42D462A30016A7864CFEE5E5F33A3D857371F1ED
X-7FA49CB5: 0D63561A33F958A5C4A1241F65A9DF449011F685861E5E6B1A890AC55145D5408941B15DA834481FA18204E546F3947C4B6F6234D9065C97F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637CBDA538BD653CEDD389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C36623C589A9CCD53435872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj3ZJ49a6yxuuW3WXFcmWZoQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

You are referring to Dmitry Baryshkov, as I see. But Dmitry has already 
reviewed my patch (message above).
So it would be rude to change anything without his knowledge. Let's wait 
for his answer.

---
Best wishes
Danila

On 2/18/24 20:14, Bryan O'Donoghue wrote:
> On 18/02/2024 8:05 a.m., Danila Tikhonov wrote:
>> I know that some interrupts have both for PM8150B, but for PM6150 all 
>> interrupts are rising.
>> Please look at the downstream kernel:
>> https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/187022f2721d584ac4ec92c0ac1af77da487521d/arch/arm64/boot/dts/qcom/pm6150.dtsi#L319 
>>
>> https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/187022f2721d584ac4ec92c0ac1af77da487521d/arch/arm64/boot/dts/qcom/pm8150b.dtsi#L292 
>>
>>
>
>
> Please take a look here, I think the same logic should apply to your 
> patchset.
>
> https://www.spinics.net/lists/devicetree/msg665558.html
>
> ---
> bod


