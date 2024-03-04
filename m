Return-Path: <linux-kernel+bounces-90275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCF786FCC4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1658284184
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6141B802;
	Mon,  4 Mar 2024 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="m41JRwtT"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7309917748;
	Mon,  4 Mar 2024 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543369; cv=none; b=Fher7wAfTyCtnwSRtfZHZvmIGw5rxOF3/TlXyaE5oVciwrKhL1mfR9iJJM2BOOPZP7vH2M+MdkPrRRYyz0Cq+CO23uGr1FP5/xCbBU5FUO+P02QQ+WJt0ZpK4wsUsua7Emtmkp0SFrcqemxDbiYR/0e1pSBeRK82SKKz2tFiMcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543369; c=relaxed/simple;
	bh=NTeM1KJ3g7QyFyVSvupqryocHsXHyWEGZB+Y/y8Wfzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OZouDm+aHI/Hps+vLjQ32jwSlzc7fFdpx36k+NkNGO+nLz0JelmmGsq8W/YbJUU+Rt/8zVUkOpJum+ic2CIEt/3dJoZZxm9pCalUvAcYCz264iolie7taCKsb2bNQ2Q1FrvnIOnlQywpMnaviPv6bWCtOFVrrC47LHVdn1H4ngY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=m41JRwtT; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4247gAFC026675;
	Mon, 4 Mar 2024 09:41:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=bJnRc0D0H74QihxsMJduhmW8GQyOwkO9RFjU12y0p4M=; b=m4
	1JRwtTlXG3PcefLldIGEl77X0tUzuX+IDQXBAmHPBC+tOYP8w+XPQ9oqzVVDSJ8p
	dG9F5BbzPgdp6eHuOSyBrgE3B9oIFZA8U5rdki+EXke2aT4mQyO0sXWsUVt5bXFA
	3+dO8XJm8hfWyt1RSiRnQHT1angHmSEvKMivYax6ZkCoeHnWxSFAFjjtvH/a3WM4
	/RFWp74L8NlLfmaFny43+2JvSpVzbB2HVogeui34sDQhYfT95ZMLKZ1MC4KqyuYO
	EB++E08T+M3PlmY8fjXumYfQd0qtjfj/Du80U34MqRTLapNdflV0p6DblR6KSDWa
	smqORLvSC+TfwCrRRMnA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wktdkxss1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 09:41:56 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7E2584002D;
	Mon,  4 Mar 2024 09:41:51 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C3E60255E46;
	Mon,  4 Mar 2024 09:41:16 +0100 (CET)
Received: from [10.252.5.201] (10.252.5.201) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Mar
 2024 09:41:15 +0100
Message-ID: <562cdbfe-9353-4f5d-a804-34e158a190a7@foss.st.com>
Date: Mon, 4 Mar 2024 09:41:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] counter: Introduce the COUNTER_COMP_FREQUENCY() macro
To: William Breathitt Gray <william.gray@linaro.org>
CC: <syednwaris@gmail.com>, <vigneshr@ti.com>, <jpanis@baylibre.com>,
        <alexandre.torgue@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240301102505.591918-1-fabrice.gasnier@foss.st.com>
 <ZeH6e02zzfAjw-sd@ishi>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <ZeH6e02zzfAjw-sd@ishi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_04,2024-03-01_03,2023-05-22_02

On 3/1/24 16:55, William Breathitt Gray wrote:
> On Fri, Mar 01, 2024 at 11:25:05AM +0100, Fabrice Gasnier wrote:
>> Now that there are two users for the "frequency" extension, introduce a
>> new COUNTER_COMP_FREQUENCY() macro.
>> This extension is intended to be a read-only signal attribute.
>>
>> Suggested-by: William Breathitt Gray <william.gray@linaro.org>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>> ---
>> Changes in v5
>> - "frequency" extension is read-only, so there's no need to provide
>>   a write parameter.
>> - patch sent separately from "counter: Add stm32 timer events support" [1]
>> [1] https://lore.kernel.org/lkml/20240227173803.53906-2-fabrice.gasnier@foss.st.com/
>> ---
>>  include/linux/counter.h | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/include/linux/counter.h b/include/linux/counter.h
>> index 702e9108bbb4..0ac36f815b7d 100644
>> --- a/include/linux/counter.h
>> +++ b/include/linux/counter.h
>> @@ -602,6 +602,13 @@ struct counter_array {
>>  #define COUNTER_COMP_FLOOR(_read, _write) \
>>  	COUNTER_COMP_COUNT_U64("floor", _read, _write)
>>  
>> +#define COUNTER_COMP_FREQUENCY(_read) \
>> +{ \
>> +	.type = COUNTER_COMP_U64, \
>> +	.name = "frequency", \
>> +	.signal_u64_read = (_read), \
>> +}
>> +
>>  #define COUNTER_COMP_POLARITY(_read, _write, _available) \
>>  { \
>>  	.type = COUNTER_COMP_SIGNAL_POLARITY, \
>> -- 
>> 2.25.1
> 
> Hi Fabrice,
> 
> Setting the structure members directly works, but why not use
> COUNTER_COMP_SIGNAL_U64("frequency", _read, NULL) instead to keep the
> code more succinct?

Hi William,

I originally wrote it this way, but I had a doubt since some macros use
the structure members directly.

I can update to use COUNTER_COMP_SIGNAL_U64() instead, that will spare
few lines.

Please let me know what you prefer (I guess your proposal above ?).

Best Regards,
Thanks,
Fabrice

> 
> William Breathitt Gray

