Return-Path: <linux-kernel+bounces-106780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D2F87F36A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1612281D41
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4702B5A7A7;
	Mon, 18 Mar 2024 22:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bE6l2bqz"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239C15A786;
	Mon, 18 Mar 2024 22:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710802499; cv=none; b=fHjRTU4ten63sKywpvoBWam6yxu7iirNLYOrAO37Y2wS30TEZWtNcA3jR71zEeHY5mwMo8KryWagpW+eD6SCdVIJ6bZFez0tU0bkCYpk/KjF2C5FPmTlodXXXPVNXfXHcgxcG/7Z3GW34mK2yB4CUph6PncQvhVRk/ufmOTV2Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710802499; c=relaxed/simple;
	bh=NNxUzknMUx6JvNgGo1q+hdGtgoR/iRzhtpKz2FKCeCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMwwkydgxQocJrQiYM4ol9CxlNYIAnZZSYYwdv59JwDMWhTSUrj0nj6Qi4fBlNchVZrDb0/w5kVkTGpwro2+rH2iMelIGODJgYKv+9V0d7zMB7mArE30R9jsUo8lvuJAlALisF48FrWEFnFAqMC43xFFohRCcKi7HMlGf+5WARQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bE6l2bqz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42IMWZO3022155;
	Mon, 18 Mar 2024 22:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=no0ND6ofS1ljLX84cue1h9RXKCUPZ3al3cKsA5mJDw0=;
 b=bE6l2bqzKqqrgWGuKJosXW7gbIKTu5W0EV89aKiCqbyKQ19tg4PlhTod4PfBgvgtERx0
 MGr6FAx3De78heBz8ByQP4UgCU9vGUawHUtOGiwVDXxSu8SKx9TXJaokzg0Lz+M/hGig
 tFBLYAdvwGeOdrwphTstWAoXFS20RReBXwf7jJZeW1a47Zwj4MXPwz8x59lENdsvlKjh
 mtNZ2s+GhlyyNIgiDvjiznlXF6MEBt2POH0tNZA/qbhzn8Ab+nXVG+HXHLHuIL+Q46tf
 JFYDEwW9q3HJl94nz0x+7KzVcUkL463JnYTMkflz5f4jL0+Ukx80XdslNtp4iM01jaIK 8w== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wxxgbr24g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 22:54:45 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42IKuZW5017231;
	Mon, 18 Mar 2024 22:54:44 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwnrt3ym2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 22:54:44 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42IMsfgT50463148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 22:54:43 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE39258059;
	Mon, 18 Mar 2024 22:54:41 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF29D58055;
	Mon, 18 Mar 2024 22:54:40 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 Mar 2024 22:54:40 +0000 (GMT)
Message-ID: <d462e493-c719-4372-8991-cdd860f433d9@linux.ibm.com>
Date: Mon, 18 Mar 2024 18:54:40 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/13] crypto: ecc - Add NIST P521 curve parameters
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-9-stefanb@linux.vnet.ibm.com>
 <CZX6JM30P6FG.138133OLNGMS2@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CZX6JM30P6FG.138133OLNGMS2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AVgnEwh_6dFHKv5oxjldq-1355trb3_B
X-Proofpoint-ORIG-GUID: AVgnEwh_6dFHKv5oxjldq-1355trb3_B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180173



On 3/18/24 17:05, Jarkko Sakkinen wrote:
> On Tue Mar 12, 2024 at 8:36 PM EET, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Add the parameters for the NIST P521 curve and define a new curve ID
>> for it. Make the curve available in ecc_get_curve.
> 
> This is rare example of "complete story" in this series despite being
> short, so no complains :-)

Wew :-) Thanks for the reviews.

> 
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Tested-by: Lukas Wunner <lukas@wunner.de>
>> ---
>>   crypto/ecc.c            |  2 ++
>>   crypto/ecc_curve_defs.h | 45 +++++++++++++++++++++++++++++++++++++++++
>>   include/crypto/ecdh.h   |  1 +
>>   3 files changed, 48 insertions(+)
>>
>> diff --git a/crypto/ecc.c b/crypto/ecc.c
>> index ead40b5ebb46..4f6fa8617308 100644
>> --- a/crypto/ecc.c
>> +++ b/crypto/ecc.c
>> @@ -60,6 +60,8 @@ const struct ecc_curve *ecc_get_curve(unsigned int curve_id)
>>   		return &nist_p256;
>>   	case ECC_CURVE_NIST_P384:
>>   		return &nist_p384;
>> +	case ECC_CURVE_NIST_P521:
>> +		return &nist_p521;
>>   	default:
>>   		return NULL;
>>   	}
>> diff --git a/crypto/ecc_curve_defs.h b/crypto/ecc_curve_defs.h
>> index ab1ef3d94be5..0ecade7d02f5 100644
>> --- a/crypto/ecc_curve_defs.h
>> +++ b/crypto/ecc_curve_defs.h
>> @@ -89,6 +89,51 @@ static struct ecc_curve nist_p384 = {
>>   	.b = nist_p384_b
>>   };
>>   
>> +/* NIST P-521 */
>> +static u64 nist_p521_g_x[] = { 0xf97e7e31c2e5bd66ull, 0x3348b3c1856a429bull,
>> +				0xfe1dc127a2ffa8deull, 0xa14b5e77efe75928ull,
>> +				0xf828af606b4d3dbaull, 0x9c648139053fb521ull,
>> +				0x9e3ecb662395b442ull, 0x858e06b70404e9cdull,
>> +				0xc6ull };
>> +static u64 nist_p521_g_y[] = { 0x88be94769fd16650ull, 0x353c7086a272c240ull,
>> +				0xc550b9013fad0761ull, 0x97ee72995ef42640ull,
>> +				0x17afbd17273e662cull, 0x98f54449579b4468ull,
>> +				0x5c8a5fb42c7d1bd9ull, 0x39296a789a3bc004ull,
>> +				0x118ull };
>> +static u64 nist_p521_p[] = { 0xffffffffffffffffull, 0xffffffffffffffffull,
>> +				0xffffffffffffffffull, 0xffffffffffffffffull,
>> +				0xffffffffffffffffull, 0xffffffffffffffffull,
>> +				0xffffffffffffffffull, 0xffffffffffffffffull,
>> +				0x1ffull };
>> +static u64 nist_p521_n[] = { 0xbb6fb71e91386409ull, 0x3bb5c9b8899c47aeull,
>> +				0x7fcc0148f709a5d0ull, 0x51868783bf2f966bull,
>> +				0xfffffffffffffffaull, 0xffffffffffffffffull,
>> +				0xffffffffffffffffull, 0xffffffffffffffffull,
>> +				0x1ffull };
>> +static u64 nist_p521_a[] = { 0xfffffffffffffffcull, 0xffffffffffffffffull,
>> +				0xffffffffffffffffull, 0xffffffffffffffffull,
>> +				0xffffffffffffffffull, 0xffffffffffffffffull,
>> +				0xffffffffffffffffull, 0xffffffffffffffffull,
>> +				0x1ffull };
>> +static u64 nist_p521_b[] = { 0xef451fd46b503f00ull, 0x3573df883d2c34f1ull,
>> +				0x1652c0bd3bb1bf07ull, 0x56193951ec7e937bull,
>> +				0xb8b489918ef109e1ull, 0xa2da725b99b315f3ull,
>> +				0x929a21a0b68540eeull, 0x953eb9618e1c9a1full,
>> +				0x051ull };
>> +static struct ecc_curve nist_p521 = {
>> +	.name = "nist_521",
>> +	.nbits = 521,
>> +	.g = {
>> +		.x = nist_p521_g_x,
>> +		.y = nist_p521_g_y,
>> +		.ndigits = 9,
>> +	},
>> +	.p = nist_p521_p,
>> +	.n = nist_p521_n,
>> +	.a = nist_p521_a,
>> +	.b = nist_p521_b
>> +};
>> +
>>   /* curve25519 */
>>   static u64 curve25519_g_x[] = { 0x0000000000000009, 0x0000000000000000,
>>   				0x0000000000000000, 0x0000000000000000 };
>> diff --git a/include/crypto/ecdh.h b/include/crypto/ecdh.h
>> index a9f98078d29c..9784ecdd2fb4 100644
>> --- a/include/crypto/ecdh.h
>> +++ b/include/crypto/ecdh.h
>> @@ -26,6 +26,7 @@
>>   #define ECC_CURVE_NIST_P192	0x0001
>>   #define ECC_CURVE_NIST_P256	0x0002
>>   #define ECC_CURVE_NIST_P384	0x0003
>> +#define ECC_CURVE_NIST_P521	0x0004
>>   
>>   /**
>>    * struct ecdh - define an ECDH private key
> 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> BR, Jarkko
> 

