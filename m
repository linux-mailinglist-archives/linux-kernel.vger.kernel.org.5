Return-Path: <linux-kernel+bounces-89818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5457B86F612
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F84428581D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F0C6BFCF;
	Sun,  3 Mar 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QoEOphom"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E440E6BB54;
	Sun,  3 Mar 2024 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709483374; cv=none; b=okx7sVsGQNaewODf80B3zRXCrLm1Y6Y9v8W64MtiegG9iF5SAMBxyZFloudb45q0JaXkZ4tAidHkVyuOPOuniIDbtfGhh6n1/jIOM9SYuaVwsA7rFUf6bFpuUJMnLkRi25qPZ3V+4Shy0pHu4mjcfG9itvuquL3zUbBUhLbV168=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709483374; c=relaxed/simple;
	bh=nbHPpTb3GQKNcQWO0cM8aQ3+g8DNJ7t8r0CI63vv1S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfZ9z5PaB0CO08kw3u4GotkuYk4KlRLY8rh4P0+Y6dbQ4uMeP4PRFBdtUeNA5CBIeNeugRBrorZHp2PEZoX8ZNGpc7UwubcQdlcvtTx6RuPY6rJMfK2poyIDJ2g886Pz7/5pDjshhIqyjwfB8UJHl/vAEaaXMpODk0HnxrK7Ydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QoEOphom; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 423FvPqN031577;
	Sun, 3 Mar 2024 16:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=nD8h3h1clP6zp7keCyh967DVxpyNyWD1f76i9MCLW9Q=;
 b=QoEOphomgSpSZxyDk7PIOqHZ5K6kDx5wZOAlrzncwm3x3z3Wbto7i9o7xFibyxmIcWV3
 mF4xDeFmhvDmT19rsejZBreivzWTJj8XcOzMsTSuw9IwpSlu0+7XghDXbiz6+kLsGRSC
 iJg+cuT7laehJ9fRTYXU6dfptgE7Vod0cNeDdd/gq9oKDELFHmk1hV4JiwKXPlAnfNtl
 /bhxvbS3npMauvSYYe5YMgXEnF+1yh67zBQrnYSon1upKMZ0Og22zeGID1LkFzFyuFFz
 QD2RcYjhH8KY0Xve+Hrb8EFcb4yeil1MW7QGqJ2pSvJSGtduDnE+5M/3eY+ahTTFM9Fs cg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wmva20btu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Mar 2024 16:29:25 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 423DAXlW020667;
	Sun, 3 Mar 2024 16:29:23 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfxkbbdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Mar 2024 16:29:23 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 423GTLTT49349096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 3 Mar 2024 16:29:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B86558055;
	Sun,  3 Mar 2024 16:29:21 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 964455804B;
	Sun,  3 Mar 2024 16:29:20 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  3 Mar 2024 16:29:20 +0000 (GMT)
Message-ID: <06a094f0-658e-4fb8-9177-3624b8aa760b@linux.ibm.com>
Date: Sun, 3 Mar 2024 11:29:20 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/12] crypto: ecc - Implement vli_mmod_fast_521 for
 NIST p521
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
References: <20240301022007.344948-1-stefanb@linux.ibm.com>
 <20240301022007.344948-5-stefanb@linux.ibm.com>
 <20240303110511.GA394@wunner.de>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240303110511.GA394@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OI6_Nf9C9sDZnPu6tuyLRIHCL7jge32j
X-Proofpoint-GUID: OI6_Nf9C9sDZnPu6tuyLRIHCL7jge32j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-03_06,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=984 mlxscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403030138



On 3/3/24 06:05, Lukas Wunner wrote:
> On Thu, Feb 29, 2024 at 09:19:59PM -0500, Stefan Berger wrote:
>> +static void vli_mmod_fast_521(u64 *result, const u64 *product,
>> +				const u64 *curve_prime, u64 *tmp)
>> +{
>> +	const unsigned int ndigits = 9;
>> +	size_t i;
>> +
>> +	for (i = 0; i < ndigits; i++)
>> +		tmp[i] = product[i];
>> +	tmp[8] &= 0x1ff;
> 
> Hm, the other vli_mmod_fast_*() functions manually unroll those loops.
> Wondering if that would make sense here as well?  It's also possible

Why would we do this? One could also argue why not use vli_set() instead 
of the loop...

> to tell gcc to unroll a loop with a per-function...
> 
>      __attribute__((optimize("unroll-loops")))
> 
> ...but I'm not sure about clang portability. >
> 
>> @@ -941,6 +966,12 @@ static bool vli_mmod_fast(u64 *result, u64 *product,
>> +	case 9:
>> +		if (!strcmp(curve->name, "nist_521")) {
>> +			vli_mmod_fast_521(result, product, curve_prime, tmp);
>> +			break;
>> +		}
>> +		fallthrough;
> 
> If you reorder patch 4 and 5, you could check for curve->nbits == 521 here,
> which might be cheaper than the string comparison.

Sure. I thought it's a nist spec for this particular curve, so compare 
against 'nist' in the string. Though comparing against nbits also works, 
of course.

> 
> 
>> -#define ECC_MAX_DIGITS              (512 / 64) /* due to ecrdsa */
>> +#define ECC_MAX_DIGITS              (576 / 64) /* due to NIST P521 */
> 
> Maybe DIV_ROUND_UP(521, 64) for clarity?

Ok, will adjust.

Regards,
    Stefan

> 
> Thanks,
> 
> Lukas
> 

