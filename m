Return-Path: <linux-kernel+bounces-146050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AE78A5F79
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43F21F2225E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29E44C98;
	Tue, 16 Apr 2024 00:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XtwmSwLX"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47531849;
	Tue, 16 Apr 2024 00:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713228870; cv=none; b=f6aJO03PppdIsV/kvoSiK7OjvdfD1MwIFpzHZxauUT+XUqy4Py5LHhrwa1+4S8pAthxCkI6ISA2vtgO3hmzKdFyP4AIyLvIYiAfiLC8tH5HMa8mgh96Pf3FpVPbY8IsTzl87vNegdZvqQOdb3Xj0+s8Y6GzHrpkuGj04n+iW7DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713228870; c=relaxed/simple;
	bh=VNpMltkGybMDEtzsonkuvLdoNGOIcPPiObueOXkYm1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqEkgQpcFXQ9YnyaxXrbYzc+SvvqR+cgVrWBo2mCZN08lFpG5StjWL9yl44WTHLjJszCSez8+U6Hc1OjcOutgD0SklC7+EsVtSZ/2Z0dxRsusBxXK1GRA1UrCMgOpMBNI6ny7E8El04l1MRj8Bw8JdIWjn1TmafAeetKRs3kBTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XtwmSwLX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43G0Z1AI024971;
	Tue, 16 Apr 2024 00:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=j0sZP/q8mi1WF1Ov9jUFp9LHWq75qUSInJQ3SCIhzEE=;
 b=XtwmSwLXVhHwDxxtDwIRcYyydBYwCPFA+amYybror/WyLu5q/1lx1cyGuxQLXHPxWbHj
 tid8LbvcGbVCiN4zuO4k6yuXevOn84hu2cX7LWRXwIpiW1m/8qM7WljPWU+b63JPQAwI
 uEHjwyijRb+UD/ifzxvHWRwqi0BwrSliW2CWBHruPngQH5Y8J0AMI2RXkNGdIhmoytw6
 OnO3r/j6QWqIzrDLOxnITh7DxRUTu4fSCbHxVvJG9WjXk0d/xOSpOWj2kHuV40vvW8N3
 ZtmfibguQ1wssJPa1ocHQ7TDquCe8egSGYprq6Fpc0JaPoec0CC97IPULYaF+M3nfmxG JQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhewmr0jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 00:54:18 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43FMesKr015835;
	Tue, 16 Apr 2024 00:51:06 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5vm30hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 00:51:06 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43G0p3a345613358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 00:51:06 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E0095804B;
	Tue, 16 Apr 2024 00:51:03 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBEFB58055;
	Tue, 16 Apr 2024 00:51:02 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Apr 2024 00:51:02 +0000 (GMT)
Message-ID: <6442f387-e45e-4019-8af0-6ca309e4ce4f@linux.ibm.com>
Date: Mon, 15 Apr 2024 20:51:02 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] crypto: ecdh - Pass private key in proper byte order
 to check valid key
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, ardb@kernel.org,
        salvatore.benedetto@intel.com
References: <20240415003026.2661270-1-stefanb@linux.ibm.com>
 <20240415003026.2661270-2-stefanb@linux.ibm.com>
 <D0KX9NQPXKO1.2RXZU000DD1BB@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <D0KX9NQPXKO1.2RXZU000DD1BB@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pRLxEoG8gw_ZUmTtBWBSWuusgn_O5wJ0
X-Proofpoint-GUID: pRLxEoG8gw_ZUmTtBWBSWuusgn_O5wJ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_20,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160004



On 4/15/24 14:53, Jarkko Sakkinen wrote:
> On Mon Apr 15, 2024 at 3:30 AM EEST, Stefan Berger wrote:
>> ecc_is_key_valid expects a key with the most significant digit in the last
>> entry of the digit array. Currently ecdh_set_secret passes a reversed key
>> to ecc_is_key_valid that then passes the rather simple test checking
>> whether the private key is in range [2, n-3]. For all current ecdh-
>> supported curves (NIST P192/256/384) the 'n' parameter is a rather large
>> number, therefore easily passing this test.
>>
>> Throughout the ecdh and ecc codebase the variable 'priv' is used for a
>> private_key holding the bytes in proper byte order. Therefore, introduce
>> priv in ecdh_set_secret and copy the bytes from ctx->private_key into
>> priv in proper byte order by using ecc_swap_digits. Pass priv to
>> ecc_is_valid_key.
>>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Salvatore Benedetto <salvatore.benedetto@intel.com>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   crypto/ecdh.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/crypto/ecdh.c b/crypto/ecdh.c
>> index 3049f147e011..a73853bd44de 100644
>> --- a/crypto/ecdh.c
>> +++ b/crypto/ecdh.c
>> @@ -27,6 +27,7 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
>>   			   unsigned int len)
>>   {
>>   	struct ecdh_ctx *ctx = ecdh_get_ctx(tfm);
>> +	u64 priv[ECC_MAX_DIGITS];
>>   	struct ecdh params;
>>   
>>   	if (crypto_ecdh_decode_key(buf, len, &params) < 0 ||
>> @@ -40,9 +41,10 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
>>   				       ctx->private_key);
>>   
>>   	memcpy(ctx->private_key, params.key, params.key_size);
>> +	ecc_swap_digits(ctx->private_key, priv, ctx->ndigits);
> 
> Does swapping speed up the test that follows are what effect does it
> have to the ecc_is_key_valid() call?
The goal of this particular patch is to fix an issue with the byte order 
(as description says) and, as you can see in the 2nd patch, private key 
is always copied into priv using ecc_swap_digits before priv is being 
used instead of ctx->private_key (or whatever it is called in the 
function it was passed to). This patch here has nothing to do with speed 
up but a) fixing an issue and b) using priv here as well, so fixing this 
'outlier' here. The speed-up comes in the 2nd patch when the bytes in 
ctx->private_key are put into proper order right away and we can get rid 
if priv, taking the swapped bytes of ctx->private_key, everywhere and we 
can use ctx->private_key directly.

The test harness (testmgr.c) runs through part of this code here 
providing the private key that is copied into ctx->private_key, so it's 
being used and when you make a mistake (making the changes I did) the 
ecdh test cases will fail.



> 
> Just a question to understand what is going on, not actual review
> feedback.
> 
>>   
>>   	if (ecc_is_key_valid(ctx->curve_id, ctx->ndigits,
>> -			     ctx->private_key, params.key_size) < 0) {
>> +			     priv, params.key_size) < 0) {
>>   		memzero_explicit(ctx->private_key, params.key_size);
>>   		return -EINVAL;
>>   	}
> 
> BR, Jarkko

