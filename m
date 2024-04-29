Return-Path: <linux-kernel+bounces-162118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 081F68B562F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05C61F22C20
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60743EA69;
	Mon, 29 Apr 2024 11:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="akqj60KO"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5505382;
	Mon, 29 Apr 2024 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389120; cv=none; b=l31G4xRwSzixve8//PuochP9izrbfEfjtiGchkD0HicNaR+UdBD+NfxcRmvDfqCHtRaS7evWBuaA+vq7UsgFPWH4Yj9lt4YGwP8jevfmjX1sznBUANWpPvRdqZbIUyrKbuIHYW64mFb9Z15vG0eiBM9/U+uYaTpG7WoPSYUxX5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389120; c=relaxed/simple;
	bh=iBNtaL/ylXo/uw7GZofIz0DbgVWmXNRAcjznHiJNXcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tt3B/SKeJUYf3cblZdDi5gW7Dk+X7eSGsI0fFD4gjVSxmbRl08npylrAiMjQtfJL+y4g876W3c8UQDvYdxfQ8mai7x9bqamvuX9l9jS8mKd4UFO8sRbDPFyDNGSMhkG30ekYrCkCQJUcDw7VI2zqjKoWL6XAVbqBDX0HxMRJCXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=akqj60KO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43T9w23R029996;
	Mon, 29 Apr 2024 11:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XKrCQaQC5sjYRsdoIhesFC1fJO8MgZ/BaB9Dn5aJtIk=;
 b=akqj60KO/t0H7lj6F6cKk3GBhu28JL9wX0M3hUbRNrd1uHvhF5BDvEQ1rJoilcJZ9GG+
 bDQNu3Ulnm4rvocMAJeAl1hQNu3qyZXY9XC57lC71jitev0RSkXruQDa6YgfuetWiuhT
 9W4kc2RU+4LStER04LWhIR6/4cnzGsfGGt2gZrnz2gBoPElfvfoFV9za1tXphaXn771m
 g3CISDhEJbm9UJYwF8t9sLX/K8q1J4e210MapSlPF0zQSS4zDxmX6mCzH/7xxXgRp1lh
 tPSEhAH4FWVWdQp+k1/u2Kd0ts8Ho6vQr4UZXTOK6bzCK2NPxNg4UnoOx0b9S7JVRhkn 0Q== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xt9c9g40k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 11:11:50 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43T8uLbH022177;
	Mon, 29 Apr 2024 11:11:48 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xsd6mene0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 11:11:48 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43TBBkWn55575016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 11:11:48 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C78958065;
	Mon, 29 Apr 2024 11:11:46 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F22358057;
	Mon, 29 Apr 2024 11:11:45 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Apr 2024 11:11:45 +0000 (GMT)
Message-ID: <8109c35b-344e-4d98-8245-77f4919624a1@linux.ibm.com>
Date: Mon, 29 Apr 2024 07:11:45 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: ecc - Protect ecc_digits_from_bytes from reading
 too many bytes
To: Jarkko Sakkinen <jarkko@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org
References: <20240426225553.3038070-1-stefanb@linux.ibm.com>
 <D0W3MTR0CY08.Q2UIYE4N274L@kernel.org> <Zi8UXS1MD5V58dnN@wunner.de>
 <D0WIZTMRKHSJ.1Z4ZV54DLVWAB@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <D0WIZTMRKHSJ.1Z4ZV54DLVWAB@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lfcCTfyGJc7C03ikxiBv8Fp4GaOWW_ed
X-Proofpoint-GUID: lfcCTfyGJc7C03ikxiBv8Fp4GaOWW_ed
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_08,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290071



On 4/29/24 06:14, Jarkko Sakkinen wrote:
> On Mon Apr 29, 2024 at 6:30 AM EEST, Lukas Wunner wrote:
>> On Mon, Apr 29, 2024 at 01:12:00AM +0300, Jarkko Sakkinen wrote:
>>> On Sat Apr 27, 2024 at 1:55 AM EEST, Stefan Berger wrote:
>>>> Protect ecc_digits_from_bytes from reading too many bytes from the input
>>>> byte array in case an insufficient number of bytes is provided to fill the
>>>> output digit array of ndigits. Therefore, initialize the most significant
>>>> digits with 0 to avoid trying to read too many bytes later on.
>>>>
>>>> If too many bytes are provided on the input byte array the extra bytes
>>>> are ignored since the input variable 'ndigits' limits the number of digits
>>>> that will be filled.
>>>>
>>>> Fixes: d67c96fb97b5 ("crypto: ecdsa - Convert byte arrays with key coordinates to digits")
>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>> ---
>>>>   include/crypto/internal/ecc.h | 7 +++++++
>>>>   1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
>>>> index 7ca1f463d1ec..56215f14ff96 100644
>>>> --- a/include/crypto/internal/ecc.h
>>>> +++ b/include/crypto/internal/ecc.h
>>>> @@ -67,9 +67,16 @@ static inline void ecc_swap_digits(const void *in, u64 *out, unsigned int ndigit
>>>>   static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
>>>>   					 u64 *out, unsigned int ndigits)
>>>>   {
>>>> +	int diff = ndigits - DIV_ROUND_UP(nbytes, sizeof(u64));
>>>>   	unsigned int o = nbytes & 7;
>>>>   	__be64 msd = 0;
>>>>   
>>>> +	/* diff > 0: not enough input bytes: set most significant digits to 0 */
>>>> +	while (diff > 0) {
>>>> +		out[--ndigits] = 0;
>>>> +		diff--;
>>>> +	}
>>>
>>> Could be just trivial for-loop:
>>>
>>> for (i = 0; i < diff; i++)
>>> 	out[--ndigits] = 0;
>>>
>>> Or also simpler while-loop could work:
>>>
>>> while (diff-- > 0)
>>> 	out[--ndigits] = 0;
>>
>> Or just use memset(), which uses optimized instructions on many arches.
> 
> Yeah, sure, that would be even better, or even memzero_explicit()?

Thanks. The function isn't getting too big for an inline?

> 
> BR, Jarkko

