Return-Path: <linux-kernel+bounces-70277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADD7859581
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8600A1C20ADF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFBE107AA;
	Sun, 18 Feb 2024 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="zP9sEU4b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="GUExKSB3"
Received: from fallback20.i.mail.ru (fallback20.i.mail.ru [79.137.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0597312E61;
	Sun, 18 Feb 2024 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243577; cv=none; b=IwNcvMkcFkQmAwqW3um+bFnVKbCYUYDxX8NGSDWW/Rpcw1P9P2KKWOl7TdOeI5/YoPSP+MLkzXuUa4FhG2K2IGrhPM+awywPSuRnMUqXqA1zKMkVyUrDtoDh/1Ka2HVaksQ4s9kO37d8XQ7Lv3HsHY5uZA9bSutv3hvSgsfpnhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243577; c=relaxed/simple;
	bh=zbKNbENFN/OnjMU8rFgLiYkxYbjk2LCM2f7LHLfAxj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8sXXu9/am1kaou5HW2LHbDoKcNWbMIItlkjloV4NNucB4/GQ5xk00F+9L/vIKtuuaKrqfgWcfyZq3I0n6NQzQlWVRvS/5KXoLamwNp1nkil/ZkmXRo1YQD32nefFGDkGi4MUnP3uzLQwKIou95p6Jn/MWniO+4Bb8sJcKmy89I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=zP9sEU4b; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=GUExKSB3; arc=none smtp.client-ip=79.137.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=fAe17WryL73RB+0sTl7z/tWEaSPh34cycckfhNlErMg=;
	t=1708243573;x=1708333573; 
	b=zP9sEU4bABQi24Ex0q70FS9F247yq3CC+GTtWrG5/olLcuJW55wJIE4gCnGFFtL5FQaluY4WA4+qbiargoGQvtwD3yvuDOti8aKEdRSLPD6QS0m+mMoI37BMhvaop0VnHKAzHplWFIQaP3qDeNfGgbXYjyVbixqPMwyiDJqAUlA=;
Received: from [10.12.4.8] (port=35750 helo=smtp35.i.mail.ru)
	by fallback20.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rbcBZ-00D7N6-7I; Sun, 18 Feb 2024 11:06:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To
	:Cc:Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=fAe17WryL73RB+0sTl7z/tWEaSPh34cycckfhNlErMg=; t=1708243565; x=1708333565; 
	b=GUExKSB3uWG4gifDWJMCcZzxNsDQyD3pAdGrCsmLiuDnMMMzboWLcIdu746IY4wOjysz/p6IKCN
	ZITSsPe8G37VmYBFo9evmugaLQb5aUfp4tsYtud0PjxjNaJM9d2Y7VunS2XnGBvMXQY1BQcK1rpZR
	bbW7kSn7u283vczHWjA=;
Received: by smtp35.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rbcBH-0000000FcS4-1nT7; Sun, 18 Feb 2024 11:05:48 +0300
Message-ID: <b0b732b8-456a-4021-8277-cd51f01ead17@jiaxyga.com>
Date: Sun, 18 Feb 2024 11:05:21 +0300
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
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org, danila@jiaxyga.com
References: <20240217163201.32989-1-danila@jiaxyga.com>
 <20240217163201.32989-4-danila@jiaxyga.com>
 <6bf11ccd-ff08-369b-913f-277c189afb76@linaro.org>
From: Danila Tikhonov <danila@jiaxyga.com>
In-Reply-To: <6bf11ccd-ff08-369b-913f-277c189afb76@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9001F8F2F6BAD2021F4B2298ADA324AF81BB1825BF5AE0A1600894C459B0CD1B9C5D8C186BDEC901D8E0B8F4C4390A0A6D797543978E9DD59B427ADE3CF5787D5CE06B70447BA4CE8
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F9D3BE5B596754B8C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE77633BACAB33B95088F08D7030A58E5AD1A62830130A00468AEEEE3FBA3A834EE7353EFBB553375664F31EC67F06AD94B38E25929FDAC290C7432EB4E4AC1A54B2A3D379F6A05D0CB389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0DCF4F0DC832992758941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B6BAA8CD687FCDB2EBCC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C22498BFD6B1B042489AC3AA81AA40904B5D9CF19DD082D7633A0C84D3B47A649675F3AA81AA40904B5D98AA50765F79006372D13D82DB4E1BCE9EC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5278DA827A17800CE754F43A495B1ACFC12EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7325B7099C10CC3D7731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5C7C3FE977A4F061B5002B1117B3ED6967ED4914A5D9C2BAFC66B2B37046EC955823CB91A9FED034534781492E4B8EEAD3CCD70CEBBF18A22BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFA4DAB5E10157C3A32689DEF3F2745BF1CFE96C77343EE50FE8DC3B222CB7337F8DB4AB58792EC0EC34E84B500378195F43C5EF13D2DD4106429CF131A738E00D2EA3BB66D8629B7F457F7985AD47CF5C02C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj3ZJ49a6yxutXuoGjqiO27Q==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981E693FEBE5FC77AFAF7A6B01B8567BB20533548DF75F671C6F06B934CBD06DDCB2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 78E4E2B564C1792B
X-77F55803: 6242723A09DB00B4A77971E4CF73965D9E271BDE2CCB4C0C7AB8ED82C1DDBC5A049FFFDB7839CE9E8F5A60B08382AFE35CBC31FB6670A0722AAA73FD5854DA906FB50257FD98370E
X-7FA49CB5: 0D63561A33F958A5A08FF61CF9D8C74F55D7C90D4B06AD703D055AAF7A6EEE438941B15DA834481FA18204E546F3947C4CB6874B0BCFF0B8F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006370D8CD50B7E84063A389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3C16BB147ABCEB83B35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj3ZJ49a6yxusC26qdUNZ9Tg==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

I know that some interrupts have both for PM8150B, but for PM6150 all 
interrupts are rising.
Please look at the downstream kernel:
https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/187022f2721d584ac4ec92c0ac1af77da487521d/arch/arm64/boot/dts/qcom/pm6150.dtsi#L319
https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/187022f2721d584ac4ec92c0ac1af77da487521d/arch/arm64/boot/dts/qcom/pm8150b.dtsi#L292

---
Best wishes
Danila

On 2/18/24 02:19, Bryan O'Donoghue wrote:
> On 17/02/2024 16:32, Danila Tikhonov wrote:
>> Define VBUS regulator and the Type-C handling block as present on the
>> Quacomm PM6150 PMIC.
>>
>> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
>
>> +        pm6150_typec: typec@1500 {
>> +            compatible = "qcom,pm6150-typec,
>> +                      qcom,pm8150b-typec";
>> +            reg = <0x1500>, <0x1700>;
>> +            interrupts = <0x0 0x15 0x00 IRQ_TYPE_EDGE_RISING>,
>> +                     <0x0 0x15 0x01 IRQ_TYPE_EDGE_RISING>,
>> +                     <0x0 0x15 0x02 IRQ_TYPE_EDGE_RISING>,
>> +                     <0x0 0x15 0x03 IRQ_TYPE_EDGE_RISING>,
>> +                     <0x0 0x15 0x04 IRQ_TYPE_EDGE_RISING>,
>> +                     <0x0 0x15 0x05 IRQ_TYPE_EDGE_RISING>,
>> +                     <0x0 0x15 0x06 IRQ_TYPE_EDGE_RISING>,
>> +                     <0x0 0x15 0x07 IRQ_TYPE_EDGE_RISING>,
>> +                     <0x0 0x17 0x00 IRQ_TYPE_EDGE_RISING>,
>> +                     <0x0 0x17 0x01 IRQ_TYPE_EDGE_RISING>,
>> +                     <0x0 0x17 0x02 IRQ_TYPE_EDGE_RISING>,
>> +                     <0x0 0x17 0x03 IRQ_TYPE_EDGE_RISING>,
>> +                     <0x0 0x17 0x04 IRQ_TYPE_EDGE_RISING>,
>> +                     <0x0 0x17 0x05 IRQ_TYPE_EDGE_RISING>,
>> +                     <0x0 0x17 0x06 IRQ_TYPE_EDGE_RISING>,
>> +                     <0x0 0x17 0x07 IRQ_TYPE_EDGE_RISING>;
>> +            interrupt-names = "or-rid-detect-change",
>> +                      "vpd-detect",
>> +                      "cc-state-change",
>> +                      "vconn-oc",
>> +                      "vbus-change",
>> +                      "attach-detach",
>> +                      "legacy-cable-detect",
>> +                      "try-snk-src-detect",
>> +                      "sig-tx",
>> +                      "sig-rx",
>> +                      "msg-tx",
>> +                      "msg-rx",
>> +                      "msg-tx-failed",
>> +                      "msg-tx-discarded",
>> +                      "msg-rx-discarded",
>> +                      "fr-swap";
>> +            status = "disabled";
>> +        };
>
> Should all of these be rising ? Looks incorrect to me.
>
> Please review: arch/arm64/boot/dts/qcom/pm8150b.dtsi
>
> pm8150b_typec: typec@1500 {
>         compatible = "qcom,pm8150b-typec";
>         status = "disabled";
>         reg = <0x1500>,
>               <0x1700>;
>
>     interrupts = <0x2 0x15 0x00 IRQ_TYPE_EDGE_RISING>,
>              <0x2 0x15 0x01 IRQ_TYPE_EDGE_BOTH>,
>              <0x2 0x15 0x02 IRQ_TYPE_EDGE_RISING>,
>              <0x2 0x15 0x03 IRQ_TYPE_EDGE_BOTH>,
>              <0x2 0x15 0x04 IRQ_TYPE_EDGE_RISING>,
>              <0x2 0x15 0x05 IRQ_TYPE_EDGE_RISING>,
>              <0x2 0x15 0x06 IRQ_TYPE_EDGE_BOTH>,
>              <0x2 0x15 0x07 IRQ_TYPE_EDGE_RISING>,
>              <0x2 0x17 0x00 IRQ_TYPE_EDGE_RISING>,
>              <0x2 0x17 0x01 IRQ_TYPE_EDGE_RISING>,
>              <0x2 0x17 0x02 IRQ_TYPE_EDGE_RISING>,
>              <0x2 0x17 0x03 IRQ_TYPE_EDGE_RISING>,
>              <0x2 0x17 0x04 IRQ_TYPE_EDGE_RISING>,
>              <0x2 0x17 0x05 IRQ_TYPE_EDGE_RISING>,
>              <0x2 0x17 0x06 IRQ_TYPE_EDGE_RISING>,
>              <0x2 0x17 0x07 IRQ_TYPE_EDGE_RISING>;
>
>         interrupt-names = "or-rid-detect-change",
>                   "vpd-detect",
>                   "cc-state-change",
>                   "vconn-oc",
>                   "vbus-change",
>                   "attach-detach",
>                   "legacy-cable-detect",
>                   "try-snk-src-detect",
>                   "sig-tx",
>                   "sig-rx",
>                   "msg-tx",
>                   "msg-rx",
>                   "msg-tx-failed",
>                   "msg-tx-discarded",
>                   "msg-rx-discarded",
>                   "fr-swap";
> }
>
> ---
> bod


