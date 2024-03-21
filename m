Return-Path: <linux-kernel+bounces-110512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DB8885FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454BE1C214E7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D43131720;
	Thu, 21 Mar 2024 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dTsJzx+B"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91F58592D;
	Thu, 21 Mar 2024 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711042940; cv=none; b=A0UUVWJw+at5txe8SZjmR2QdToFPKC8IA93xn7kPnTOAyqWgGlpDhHa1sxkbBIOJOMzjVVZKM61lT0nMlRe76Xpv9k0n/7qluPfAH+L5fw0CCsZJtxMzOs7idQtthrRGhjLKeJVASbZS/W3xRB4oHbFpfTX0Qp3k2phsSILi7ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711042940; c=relaxed/simple;
	bh=zUsdN2xY7WFI0ldGIoaj3nYw5KiJOwah2BFh8jfJbWA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TCbl2hUeMaz7d/flJ+cWnKTtZgqRxv/q7iGoMizdMg6R3KQh+HWkaI/5FAEhYFt/n7I8ppuPL3ZsbD+MfyyKOXVt1IFB1ZwtEjBbyrxLs6oEpwChIyBcZxxn27ne6ng5GzhDfRhSydzsijW1z/ty316zTbldsgVKdPJN17rOPpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dTsJzx+B; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42LFLR9b002621;
	Thu, 21 Mar 2024 17:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1z65S9k0Db8C2HtC5YlaiiEHPGe/DFIEq6HAdOFQG3Q=;
 b=dTsJzx+BYtt4GaboqvCB+doGtR1W4wJxWeXXiX4zXyGS/xPm5rKG9F5oGtrv1WfPRKBs
 SV9ZhHD7OW846oecVL09XzuRL1X4zSaNOJL18vV4jk4jlN+s+GWF1eRDjnfFG+RN9WKh
 sBPIOGF7djJxBAbYEm9s62zOtMnccxeiSTcAJP4QR45ITTu5LgfiF2VKhmns47HI5Bdg
 KpaxiXMyUbSSp0EmN05/ASXHB96xRPRScYqZr4SNqFil3Saro4HrWRpNAl/FuqRYuXaZ
 EzBvUZbYdWGO0UC6oTFP0or08BRPEOarR+Hl1gv1/7M448rgT4EBPNe1p4UkY0fcS11a Gg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0pfe8g0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 17:42:07 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42LGGBxC002779;
	Thu, 21 Mar 2024 17:42:06 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwrf2xb1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 17:42:06 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42LHg3nG23986910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 17:42:05 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9648058063;
	Thu, 21 Mar 2024 17:42:03 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0C005804B;
	Thu, 21 Mar 2024 17:42:02 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Mar 2024 17:42:02 +0000 (GMT)
Message-ID: <58166047-b339-4234-832b-a1aad6bf49de@linux.ibm.com>
Date: Thu, 21 Mar 2024 13:42:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/13] crypto: ecc - Add nbits field to ecc_curve
 structure
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com
References: <20240320114725.1644921-1-stefanb@linux.ibm.com>
 <20240320114725.1644921-6-stefanb@linux.ibm.com>
 <CZZLKGMM0B9E.7J1CGE8EIGQX@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CZZLKGMM0B9E.7J1CGE8EIGQX@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o0rOtGRc9n4rerL2c0bm26eVtOn7SsIA
X-Proofpoint-GUID: o0rOtGRc9n4rerL2c0bm26eVtOn7SsIA
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210129



On 3/21/24 13:17, Jarkko Sakkinen wrote:
> On Wed Mar 20, 2024 at 1:47 PM EET, Stefan Berger wrote:
>> Add the number of bits a curve has to the ecc_curve definition to be able
>> to derive the number of bytes a curve requires for its coordinates from it.
>> It also allows one to identify a curve by its particular size. Set the
>> number of bits on all curve definitions.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Tested-by: Lukas Wunner <lukas@wunner.de>
>> ---

>>   		.y = tc512b_g_y,
>> diff --git a/include/crypto/ecc_curve.h b/include/crypto/ecc_curve.h
>> index 70964781eb68..63d5754e7614 100644
>> --- a/include/crypto/ecc_curve.h
>> +++ b/include/crypto/ecc_curve.h
>> @@ -23,6 +23,7 @@ struct ecc_point {
>>    * struct ecc_curve - definition of elliptic curve
>>    *
>>    * @name:	Short name of the curve.
>> + * @nbits:	The number of bits of a curve.
>>    * @g:		Generator point of the curve.
>>    * @p:		Prime number, if Barrett's reduction is used for this curve
>>    *		pre-calculated value 'mu' is appended to the @p after ndigits.
>> @@ -34,6 +35,7 @@ struct ecc_point {
>>    */
>>   struct ecc_curve {
>>   	char *name;
>> +	unsigned int nbits;
> 
> Nit:
> 
> Hmm not strongly opionated here but wouldn't it be more consistent to
> use u32 here as the types below are also exact bitsize types?

I will change this for v8. I will probably delay v8 until this patch 
here has been queued for upstreaming because 11/13 will need a similar 
module alias.

https://lore.kernel.org/linux-crypto/20240321144433.1671394-1-stefanb@linux.ibm.com/T/#u


> 
>>   	struct ecc_point g;
>>   	u64 *p;
>>   	u64 *n;
> 
> BR, Jarkko
> 

