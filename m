Return-Path: <linux-kernel+bounces-106525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5931687EFDD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83781F2181E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40639535B2;
	Mon, 18 Mar 2024 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MYpmvMOU"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E126638DD6;
	Mon, 18 Mar 2024 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710787133; cv=none; b=Iq7LhxG5aOK6amgZYZb7OxptWa3UMU/vq4pHiYh3txa9R7Vmtl88Q4s/SLaC+qnoPc5p9HG7N+qqF2L6P24LDwELYpzscFxEUnOoGvhe3NQdzftBJ0e/cChZlzaiVqcCJShvyNIwscbv5V/annJsiPv6nzi8gCdfyCGXLnruHes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710787133; c=relaxed/simple;
	bh=lNojrL3UxXWw3wWblZQzw2mMNG0wfpdAKKG4HmbwfwM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=NKw4W7l0I36iMnhZgGbbDI6I99jdzDi5HwlJFtGG8R5XhiqMlxvQY9edvfy3HzywnLEk1FlMfeZerUc65Zb8EV++BxjsFqSLvOd3xapiF8XYaTe4L+dbyLDvkP01ZtamRab3+y5R2j6TTJ/O4KnVcA1r8V22iggArMJfT02NDzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MYpmvMOU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42IHfZmQ012582;
	Mon, 18 Mar 2024 18:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : subject; s=pp1;
 bh=EGAUIEI6SbQpYfub6BCl42LM7sTqQsBWk3dKyRUTVVg=;
 b=MYpmvMOUvlqTEsxfsilQx0IzaVbCpFRdHGBe2dr6Su7EZH7laM45FPFi9CaGZ7b9K3tM
 8Vt7qUbMNzwuyVKbfozucYyPMtRb68C0CTd/moOGvG5UnMMOZ/yWovcVD8zLM3gyIwmA
 ysVI3xRx8c6IzxHq2gxLM1wkq6BdyReP7R4BzatvLsA4Gqws/NJz7xu3lSDgSmcCzOLx
 3HTk9OqX8XIe58vRHMhxG6rcEJ+lqi4886f0aUQvj/A/soQ2ASfXBIfYDoy7iciS0paz
 eWRBQX/ZtHbbrsZMcuttYIQ1vQ/F22mnvRKoXspQJFhABIDwWQiQCwqPAQ58TBwbhgox 8A== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wxt3r0b70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 18:38:37 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42IH0uOU002780;
	Mon, 18 Mar 2024 18:38:36 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwrf2a55y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 18:38:36 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42IIcY0G45351360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 18:38:36 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F83358055;
	Mon, 18 Mar 2024 18:38:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F20D85805B;
	Mon, 18 Mar 2024 18:38:32 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 Mar 2024 18:38:32 +0000 (GMT)
Message-ID: <4151f2f0-aa92-480d-aad5-2bf4333b4265@linux.ibm.com>
Date: Mon, 18 Mar 2024 14:38:32 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Bharat Bhushan <bbhushan2@marvell.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "saulo.alessandre@tse.jus.br" <saulo.alessandre@tse.jus.br>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-7-stefanb@linux.vnet.ibm.com>
 <SN7PR18MB5314CB6B4CF9678BDDF0D012E32D2@SN7PR18MB5314.namprd18.prod.outlook.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <SN7PR18MB5314CB6B4CF9678BDDF0D012E32D2@SN7PR18MB5314.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wSNjPDBhFanHNTjf9WxtXUObvZZKBVbJ
X-Proofpoint-ORIG-GUID: wSNjPDBhFanHNTjf9WxtXUObvZZKBVbJ
Subject: Re:  [PATCH v6 06/13] crypto: ecc - Implement vli_mmod_fast_521 for NIST
 p521
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180141



On 3/18/24 01:47, Bharat Bhushan wrote:
> 
> 
>> -----Original Message-----
>> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> Sent: Wednesday, March 13, 2024 12:06 AM
>> To: keyrings@vger.kernel.org; linux-crypto@vger.kernel.org;
>> herbert@gondor.apana.org.au; davem@davemloft.net
>> Cc: linux-kernel@vger.kernel.org; saulo.alessandre@tse.jus.br;
>> lukas@wunner.de; Bharat Bhushan <bbhushan2@marvell.com>;
>> jarkko@kernel.org; Stefan Berger <stefanb@linux.ibm.com>
>> Subject: [EXTERNAL] [PATCH v6 06/13] crypto: ecc - Implement
>> vli_mmod_fast_521 for NIST p521
>>
>> Prioritize security for external emails: Confirm sender and content safety
>> before clicking links or opening attachments
>>
>> ----------------------------------------------------------------------
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Implement vli_mmod_fast_521 following the description for how to calculate
>> the modulus for NIST P521 in the NIST publication "Recommendations for
>> Discrete Logarithm-Based Cryptography: Elliptic Curve Domain Parameters"
>> section G.1.4.
>>
>> NIST p521 requires 9 64bit digits, so increase the ECC_MAX_DIGITS so that
>> arrays fit the larger numbers.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   crypto/ecc.c                  | 25 +++++++++++++++++++++++++
>>   include/crypto/internal/ecc.h |  3 ++-
>>   2 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/crypto/ecc.c b/crypto/ecc.c index 415a2f4e7291..99d41887c005
>> 100644
>> --- a/crypto/ecc.c
>> +++ b/crypto/ecc.c
>> @@ -902,6 +902,28 @@ static void vli_mmod_fast_384(u64 *result, const
>> u64 *product,  #undef AND64H  #undef AND64L
>>
>> +/*
>> + * Computes result = product % curve_prime
>> + * from "Recommendations for Discrete Logarithm-Based Cryptography:
>> + *       Elliptic Curve Domain Parameters" section G.1.4
>> + */
>> +static void vli_mmod_fast_521(u64 *result, const u64 *product,
>> +			      const u64 *curve_prime, u64 *tmp) {
>> +	const unsigned int ndigits = ECC_CURVE_NIST_P521_DIGITS;
>> +	size_t i;
>> +
>> +	/* Initialize result with lowest 521 bits from product */
>> +	vli_set(result, product, ndigits);
>> +	result[8] &= 0x1ff;
>> +
>> +	for (i = 0; i < ndigits; i++)
>> +		tmp[i] = (product[8 + i] >> 9) | (product[9 + i] << 55);
>> +	tmp[8] &= 0x1ff;
> 
> Can we get away from this hardcoding, like 9, 55, 0x1ff etc.
> Or at least add comment about these.
> 
>> +
>> +	vli_mod_add(result, result, tmp, curve_prime, ndigits); }
>> +
>>   /* Computes result = product % curve_prime for different curve_primes.
>>    *
>>    * Note that curve_primes are distinguished just by heuristic check and @@ -
>> 941,6 +963,9 @@ static bool vli_mmod_fast(u64 *result, u64 *product,
>>   	case ECC_CURVE_NIST_P384_DIGITS:
>>   		vli_mmod_fast_384(result, product, curve_prime, tmp);
>>   		break;
>> +	case ECC_CURVE_NIST_P521_DIGITS:
>> +		vli_mmod_fast_521(result, product, curve_prime, tmp);
>> +		break;
>>   	default:
>>   		pr_err_ratelimited("ecc: unsupported digits size!\n");
>>   		return false;
>> diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h index
>> ab722a8986b7..4e2f5f938e91 100644
>> --- a/include/crypto/internal/ecc.h
>> +++ b/include/crypto/internal/ecc.h
>> @@ -33,7 +33,8 @@
>>   #define ECC_CURVE_NIST_P192_DIGITS  3
>>   #define ECC_CURVE_NIST_P256_DIGITS  4
>>   #define ECC_CURVE_NIST_P384_DIGITS  6
>> -#define ECC_MAX_DIGITS              (512 / 64) /* due to ecrdsa */
>> +#define ECC_CURVE_NIST_P521_DIGITS  9
> 
> Maybe these can be defined as:
> #define ECC_CURVE_NIST_P521_DIGITS  (DIV_ROUND_UP(521, 64) /* NIST P521 */)

I think for NIST P521 9 can be pre-calculated. It will not change 
anymore in the future.

> 
>> +#define ECC_MAX_DIGITS              DIV_ROUND_UP(521, 64) /* NIST P521 */
> 
> /* NIST_P521 is max digits */
> #define ECC_MAX_DIGITS              ECC_CURVE_ _DIGITS

In this case I think the DIV_ROUND_UP() along with the comment shows 
that it needs to be updated if ever a larger curve comes along.

> 
> Thanks
> -Bharat
> 
>>
>>   #define ECC_DIGITS_TO_BYTES_SHIFT 3
>>
>> --
>> 2.43.0
> 

