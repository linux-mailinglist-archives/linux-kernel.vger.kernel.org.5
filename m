Return-Path: <linux-kernel+bounces-89825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE3886F627
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C3328254A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B466CDCD;
	Sun,  3 Mar 2024 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dhfEA0Co"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D062266B5F;
	Sun,  3 Mar 2024 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709483701; cv=none; b=NW/rBQXD8eiQtcGuB2W3WykqY6b2eY/fkFqtcgBXPlc0n7Vumpqoxw5plz88Z5lpeOI9LKRNXpxv6ElTZofxsOAGh0Q+uTBQT3abhl3NwiCDAtGVE2T/alWsBU92bP9Mr9zBmJ0l7fgebqAxTxEhwQe/6lFB8Eytj7PdFtVMUDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709483701; c=relaxed/simple;
	bh=2825eaZss1IHkN+3rVm4G15pyNS+UryEWrk3AiEzljI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8w7LxMJccNZ5jTtzlNxj7s2gbjQq9XL3RW4qdppK6xYC9UqunsM9vK5g0QTdP6xpEC12+6cpY85UOj/u1sbj5r2EZHfXeAXT469cLtFpfN6S1K9mle+K4aSxnqzkNEUuRIfHzWeav55jggP7VnvaCly9Wdfzki/An6j2EJrMnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dhfEA0Co; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 423GWJWL012301;
	Sun, 3 Mar 2024 16:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=41iZvq4eVdevoNfTtBHjCCDQIdJbG0eX+7Gd0Vpc0BM=;
 b=dhfEA0Co6RO/7yi53GXTWDpZl57n2JE+PshldFOrv1ezgl2XZ8r6q3U/bZyoKE+FNIo1
 xJz1ZTtt6dTcx0/ce+3reetZ0PhnwTfvCT1quFefHhVw8LiCkM4+1xqiby5a3fIRjOdJ
 JWDAMw9/AMjIoxB1cqYRSsii1qtq4xNdVtfJGy2ulPBOaOLgeXBO6Bs3c1VpQ17pKalE
 0HwKTreWuYKToPOMWqbWeRLeDFAXclWOZ4ZoeQCuf9Tpe+W1pMEjV7LA6X9Tp47Q7kDJ
 5NcI3LkSlT7CwHjDZGuP19sn4ZNgRJUC+zWYLbmzBEQozITgSPSexAakuohhnxpo7vVT 3w== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wmvth80tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Mar 2024 16:34:54 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 423D9thD020596;
	Sun, 3 Mar 2024 16:34:53 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfxkbc8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Mar 2024 16:34:53 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 423GYo8s8651282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 3 Mar 2024 16:34:52 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0D6858066;
	Sun,  3 Mar 2024 16:34:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A1F05804B;
	Sun,  3 Mar 2024 16:34:50 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  3 Mar 2024 16:34:49 +0000 (GMT)
Message-ID: <66333389-1d5e-4d86-bfc6-119bfa6b393d@linux.ibm.com>
Date: Sun, 3 Mar 2024 11:34:49 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/12] crypto: ecdsa - Convert byte arrays with key
 coordinates to digits
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
References: <20240301022007.344948-1-stefanb@linux.ibm.com>
 <20240301022007.344948-2-stefanb@linux.ibm.com>
 <20240302213427.GA30938@wunner.de>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240302213427.GA30938@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ssrt6So7zSWUQifCxZX0VWQEYuo_nNM4
X-Proofpoint-ORIG-GUID: ssrt6So7zSWUQifCxZX0VWQEYuo_nNM4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-03_07,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403030139



On 3/2/24 16:34, Lukas Wunner wrote:
> On Thu, Feb 29, 2024 at 09:19:56PM -0500, Stefan Berger wrote:
>> --- a/crypto/ecdsa.c
>> +++ b/crypto/ecdsa.c
>> @@ -222,9 +222,8 @@ static int ecdsa_ecc_ctx_reset(struct ecc_ctx *ctx)
>>   static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsigned int keylen)
>>   {
>>   	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
>> +	unsigned int digitlen, ndigits;
>>   	const unsigned char *d = key;
>> -	const u64 *digits = (const u64 *)&d[1];
>> -	unsigned int ndigits;
>>   	int ret;
>>   
>>   	ret = ecdsa_ecc_ctx_reset(ctx);
> 
> Hm, the removal of digits isn't strictly necessary.  If you would keep it,
> the patch would become simpler (fewer lines changes).
> 
> 
>> @@ -238,12 +237,17 @@ static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsig
>>   		return -EINVAL;
>>   
>>   	keylen--;
>> -	ndigits = (keylen >> 1) / sizeof(u64);
>> +	digitlen = keylen >> 1;
>> +
>> +	ndigits = DIV_ROUND_UP(digitlen, sizeof(u64));
> 
> Instead of introducing an additional digitlen variable, you could just
> use keylen.  It seems it's not used in the remainder of the function,
> so modifying it is harmless:
> 
>   	keylen--;
> + 	keylen >>= 1;
> -	ndigits = (keylen >> 1) / sizeof(u64);
> +	ndigits = DIV_ROUND_UP(digitlen, sizeof(u64));
> 
> Just a suggestion.

I would prefer 'digitlen' rather than repurposing keylen and giving it a 
different meaning...

    Stefan
> 
> Thanks,
> 
> Lukas

