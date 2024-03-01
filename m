Return-Path: <linux-kernel+bounces-89112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F2D86EA9C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711291F2235E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C4A535DF;
	Fri,  1 Mar 2024 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f8GfjmKk"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13925337B;
	Fri,  1 Mar 2024 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326084; cv=none; b=mPwe+06YGa7Sm61jBm53LH0zID6DvIuAKqtYV0Sssat4sPW53xsYZtxaCBfuutJZ7TFDFmHumJe6/YKYt0OaKGi9QCnqrDjHgFPTdSZR3CUoP48gUPx5I0Lx5xnIznDOrx7CUMbGUfLftCzwE5CyQEYN45ZrMGJWFGyNx2YgiZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326084; c=relaxed/simple;
	bh=0zFVcEjk+27xkc5GBVoirXHgXxsrBhjDjU1abj7QdQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmNyNSPQPXQjhgxWKL5KuJSR4XSvF9gUosj4T5bdu8u+ZwGB9VGuf88+qp2Kg2vOZ4+cm0+9roiVvtl+VJh2WxVIY1ppfLQHdrIBX6AOVwpYXf3Z+8heTAGLeEdZLVCPlxIpl7PAuAGtdnWS2xVizhi3WkIQEtjnRMYKLq00Kc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f8GfjmKk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 421KlgJX020547;
	Fri, 1 Mar 2024 20:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JPvfuBq/HES7muDrxOUTmHJeUceWOeG0wuRzK2EHDkA=;
 b=f8GfjmKkC4+wwpOBNhrXgCgRy+LW5quhsJngJb+e0E6uX4r20qv0h93LxYAqmDZMytpo
 qnM3DsrWPC9FtpQkCJxK2j3ntJwSfhO8Q9oPLWuduoGXGwsor/K820XFhPmFyV/kyNm2
 h4zX1palcWbrbFOyRF/AI3mgT2j+mtSJj58FDRz34roaogzBNjH0JNdeduAH6MmUlQgJ
 tr9cd6mHx0NCbAiUSG7TALPFzOnjlKqKTBqK4DvE0qddUGSV8ZgAPKKGDz0p9I8C8Urh
 b1WBKspDQjhRz+sNcHQ8OOvNix35aajQb2otLpPAtjPe33Dg6KVUWS5LvWGi7GpJ9K7A 4A== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkpcag011-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 20:47:51 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 421Jwit1021291;
	Fri, 1 Mar 2024 20:47:50 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfusppx5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 20:47:50 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 421Kll2g27263264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 20:47:49 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C939158067;
	Fri,  1 Mar 2024 20:47:45 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D69F158066;
	Fri,  1 Mar 2024 20:47:44 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Mar 2024 20:47:44 +0000 (GMT)
Message-ID: <90606a3c-1384-407b-8270-dd76dccc700b@linux.ibm.com>
Date: Fri, 1 Mar 2024 15:47:44 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/12] crypto: ecdsa - Rename keylen to bufsize where
 necessary
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de
References: <20240301022007.344948-1-stefanb@linux.ibm.com>
 <20240301022007.344948-10-stefanb@linux.ibm.com>
 <CZIPDP0W9TOP.3CCT8QUB0R4L3@suppilovahvero>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CZIPDP0W9TOP.3CCT8QUB0R4L3@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nKpA8_xvRTAPcycJWnB3CnFJM8VR0dRm
X-Proofpoint-ORIG-GUID: nKpA8_xvRTAPcycJWnB3CnFJM8VR0dRm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_21,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010173



On 3/1/24 15:41, Jarkko Sakkinen wrote:
> On Fri Mar 1, 2024 at 4:20 AM EET, Stefan Berger wrote:
>> In some cases the name keylen does not reflect the purpose of the variable
>> anymore once NIST P521 is used but it is the size of the buffer. There-
>> for, rename keylen to bufsize where appropriate.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   crypto/ecdsa.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
>> index 4daefb40c37a..4e847b59622a 100644
>> --- a/crypto/ecdsa.c
>> +++ b/crypto/ecdsa.c
>> @@ -35,8 +35,8 @@ struct ecdsa_signature_ctx {
>>   static int ecdsa_get_signature_rs(u64 *dest, size_t hdrlen, unsigned char tag,
>>   				  const void *value, size_t vlen, unsigned int ndigits)
>>   {
>> -	size_t keylen = ndigits * sizeof(u64);
>> -	ssize_t diff = vlen - keylen;
>> +	size_t bufsize = ndigits * sizeof(u64);
> 
> why not just "* 8"? using sizeof here makes this function only unreadable.

'unreadable' is a 'strong' word ...

# grep -r -E "ndigits \*" crypto/ | grep sizeof
crypto/ecrdsa.c:            req->dst_len != ctx->curve->g.ndigits * 
sizeof(u64) ||
crypto/ecrdsa.c:        vli_from_be64(r, sig + ndigits * sizeof(u64), 
ndigits);
crypto/ecrdsa.c:            ctx->curve->g.ndigits * sizeof(u64) != 
ctx->digest_len)
crypto/ecrdsa.c:            ctx->key_len != ctx->curve->g.ndigits * 
sizeof(u64) * 2)
crypto/ecrdsa.c:        vli_from_le64(ctx->pub_key.y, ctx->key + ndigits 
* sizeof(u64),
crypto/ecrdsa.c:        return ctx->pub_key.ndigits * sizeof(u64);
crypto/ecc.c:   size_t len = ndigits * sizeof(u64);
crypto/ecc.c:   num_bits = sizeof(u64) * ndigits * 8 + 1;
crypto/ecdsa.c: size_t keylen = ndigits * sizeof(u64);
crypto/ecdsa.c: size_t keylen = ctx->curve->g.ndigits * sizeof(u64);

    Stefan

