Return-Path: <linux-kernel+bounces-79762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 254E2862661
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821761F21B3D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD87F481B9;
	Sat, 24 Feb 2024 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="NN2e8PY1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="rrFmY8PC"
Received: from fallback18.i.mail.ru (fallback18.i.mail.ru [79.137.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C31B2907;
	Sat, 24 Feb 2024 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708796437; cv=none; b=JKxoohMmnXfanQ40X+VxoLNcFKbOATR18H1Wd2n8gaE4OJub6md4++rNedw2lkXxkoLCJlNF5ONL6XO/nkgDmTorUlNtUuVwIXhVUe0PcVqq9Sh3v8X5XUfIV+ybRPxshIOQ+qmWZCU4fWvmhdCnXQkN2sULnaR8TTWk8rBbQes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708796437; c=relaxed/simple;
	bh=fDMEk8Y8BUSddpB0CL0sJuy0R7wSWTVb3OGo1T3NpwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgT/7nKD5aYX/6enfuojDCn0v8MD6cAuqF/ldiQOwNNP2z05eK7JXCQ80jojIxi/gp17YvFKYqZpAue3LqwbP/Cvb4Nz7yzygSos9xXBQe/JYxFlNNCr5Dltmapz4Pi2Krtq2iyxZcxsOdKM1C45czmsPKM2FqHVgymo7PjhCP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=NN2e8PY1; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=rrFmY8PC; arc=none smtp.client-ip=79.137.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=NZlZ41PWoY10NTwPBwi3u8tkeC3b7GE4N5B8Qh4FhKg=;
	t=1708796434;x=1708886434; 
	b=NN2e8PY1Oo30JK2NMhWAx5LEUAQYWPLj0BqS8jwXQKbuvCVzVj//ZbFKWOmi/7PO9MyTF5LvoqTLbYMrJfKTrr8Y2XW33Gh9JOji3RoNWZ/8CoRZcsQrsDX15o3MuQcBCZVrhWgX157VrnA/J/lEdNt+WUUYq8uiLTknD2kNtok=;
Received: from [10.12.4.4] (port=55914 helo=smtp16.i.mail.ru)
	by fallback18.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rdw0f-00D4sm-SK; Sat, 24 Feb 2024 20:40:26 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To
	:Cc:Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=NZlZ41PWoY10NTwPBwi3u8tkeC3b7GE4N5B8Qh4FhKg=; t=1708796425; x=1708886425; 
	b=rrFmY8PC+ZcXKCUmYvfpKfsvtFKXCwriDVuz2Iajt0QEhe+EYVBAsDykiWnLPGnbYq4C7Mh8X0q
	T+k1fEeJ/BG3MO/qTMf9mJlw6SreoK40j1BfNJABEs/WF3UpfsoakNvAnzB23jaiq1pKdKUoogwUT
	SmglTM+VVKzuonsMAfM=;
Received: by smtp16.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rdw0O-0000000FrSl-42LU; Sat, 24 Feb 2024 20:40:09 +0300
Message-ID: <b6b1ca6c-a035-48e0-a00e-5dc8602fbc2c@jiaxyga.com>
Date: Sat, 24 Feb 2024 20:39:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] dt-bindings: clock: qcom,sm7150-gcc: Add missing CX
 power domain
To: Rob Herring <robh@kernel.org>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com,
 sboyd@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 david@mainlining.org, adrian@travitia.xyz, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, danila@jiaxyga.com
References: <20240220165240.154716-1-danila@jiaxyga.com>
 <20240220165240.154716-2-danila@jiaxyga.com>
 <20240223134326.GA1754133-robh@kernel.org>
Content-Language: en-US
From: Danila Tikhonov <danila@jiaxyga.com>
In-Reply-To: <20240223134326.GA1754133-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD90B4B6FE9E606E496001A0598D795A9C6213CDC86F011827800894C459B0CD1B9E780AA6270C90A000BC106B1BA2A903A79C46FDF478BC8AFB84BF0AFE90D153D08E1323863CD3BC3
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7FBB2043146276655EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637352A1F9739ED04D38638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D818C2464CF3196D541439CBB6E4E571BF2336D2463C584508CC7F00164DA146DAFE8445B8C89999728AA50765F790063706586D6E6283AEAE389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC80A9EC8C3488E7643F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C65B78C30F681404DAD7EC71F1DB884274AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3AB0F6CBF05E7489EBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFE478A468B35FE7671DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3599D44434B8B609035872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A526A3B2091198FECE5002B1117B3ED6969DF2DB6257C06E1492212597CCBD6D77823CB91A9FED034534781492E4B8EEADE0C144949FACE77EBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFCEED2BF02269DD0E3D5F71C81901E817AB490117DD87735BC7236528F9A318D80070534DE2CB11AA0C89D780EEF94DBEB9A5EB713C7DBAED7E378A2EF2DA948D85E260128EE50220146D90F64BF3396102C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojwdILGyOHXysraY2qjWq5Gw==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949810169F23919D57D8795D4C5B18C328FC06C3504F3D618BD3DB953E569AED4F6AC2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4034D5F20A9B85C2AB6229DD1E4B911208906FDE8ED063C9768F3CF0E9FE49B699BF400D6A2E293305FF1814030CDAA46FFDC3180A5F77F4E4BAE3D0DDDF504F8
X-7FA49CB5: 0D63561A33F958A593C1A6E8A4F10E98EE1BEA082E0E2CC26773F59CFDEEDA398941B15DA834481FA18204E546F3947CB6FBD635917D924DF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006370A32D918A17158F1389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3CFFA1D17DE4BDB9A35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojwdILGyOHXyv33ho+fqcn7A==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On 2/23/24 16:43, Rob Herring wrote:
> On Tue, Feb 20, 2024 at 07:52:33PM +0300, Danila Tikhonov wrote:
>> SM7150 GCC expected two power domains - CX and CX_AO. Currently only
>> one is supported, so add the missing CX.
> This makes no sense. You had 0 and now you have 1 power domain, not 2.
> Where is CX_AO.
>
Konrad Dybcio and Dmitry Baryshkov informed me on IRC that currently
only one power-domain is supported. Otherwise both will be ignored. If
we add both, it will cause confusion.
>> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
>> ---
>>   .../devicetree/bindings/clock/qcom,sm7150-gcc.yaml        | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
>> index 0eb76d9d51c4..1360e9d1d6ee 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
>> @@ -27,9 +27,15 @@ properties:
>>         - description: Board XO Active-Only source
>>         - description: Sleep clock source
>>   
>> +  power-domains:
>> +    maxItems: 1
>> +    description:
>> +      CX power domain.
>> +
>>   required:
>>     - compatible
>>     - clocks
>> +  - power-domains
> Adding new required properties is an ABI break. If that is fine, you
> must say why in the commit message.
I think everything is fine. The DTs for the SM7150 are not yet upstream.
We have been using this parameter for a very long time in our community
fork. So there should be no problems.
I am not sure what else could be added to the commit message. The loss
of power domains was simply my fault.
I think waiting for the support of two power domains is a good solution.
However, for now, I can simply drop this patch for next version.

---
Best wishes
Danila

