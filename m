Return-Path: <linux-kernel+bounces-89823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D28786F621
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFE3283FEE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260E467E66;
	Sun,  3 Mar 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V72ISdt/"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD9D67A15;
	Sun,  3 Mar 2024 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709483549; cv=none; b=azWhxMkekpCVH1k49m+6X738FUtwcYWL0Lie2sf8b5v3nOvkQZ+nTFbrDNmaDvOJmNkE4eAltt/BwlBdd8CGnnGlYC0bob8Mu2hbdIwifDKWh5VcL12rGkwG0AIjxKhwwGSU+ZsmSoDGOxyQH4wXA3Uizjz+v+0yHKkTN28S4WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709483549; c=relaxed/simple;
	bh=SKj+VnHOUfyEr19GbAiqSGhuJ8zLHTnLNigbNj40on8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAhylLfrmhCzyKjhbYBzCZdBoeTV8UZkT1k9X2ICervBQOurtEGBVn0C2w3kjy1m7pjlywUhHRqxXHegrLSnjJ0HgHhPWEVMkuUoFDnToug1d55YljAJuUbxSwtR47Yk5AwrZ4M4uzhz4VjuOt+IbX608QSDPRCwDXrqrQARkak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V72ISdt/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 423GRNwH000409;
	Sun, 3 Mar 2024 16:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=opxkQnDDAmub1KG6kyMupLiC97U3WYNkEGs85W0ALvg=;
 b=V72ISdt/h4iCAUcKEeo0xYMJZqGfq4OUSKexZHoxwSKVq0gapnfG/CDkuBPZV2a5iAwF
 EKl4+jIFa1jZUBbUu1nc2Z7w8PzSdypNZhiM1y4xBhDSEOcDKvkfz2dhyC09bY5ZWQGH
 n7CN4jTDwxPHJvEnPQzLxBE43oNFbCcsl3sOFnZU9P05ZJ2eXIeJp5E+Vpm64pCi5CiC
 Wnyvuz8hKo3Q7volS0IP/YzBNAEHt1SrJ8G+hJxXZGnda0shNIAgxuAvCDe+iqDdp8hP
 HlUGu6c9znxXmOS4/7fzc0gUowpitKz/DbD1IDLQMTH4CnzCU0gK0Mpg4gXnDdyNO6H+ gg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wmvr0r32w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Mar 2024 16:32:22 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 423GQK45026296;
	Sun, 3 Mar 2024 16:32:21 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfenbgm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Mar 2024 16:32:21 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 423GWIFo8389338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 3 Mar 2024 16:32:20 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CBF058066;
	Sun,  3 Mar 2024 16:32:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C2615805B;
	Sun,  3 Mar 2024 16:32:17 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  3 Mar 2024 16:32:17 +0000 (GMT)
Message-ID: <8ef01d48-2f42-4764-b256-e5cfd922022c@linux.ibm.com>
Date: Sun, 3 Mar 2024 11:32:17 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/12] crypto: ecc - Add nbits field to ecc_curve
 structure
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
References: <20240301022007.344948-1-stefanb@linux.ibm.com>
 <20240301022007.344948-6-stefanb@linux.ibm.com>
 <20240303110705.GB394@wunner.de>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240303110705.GB394@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PiAJCathCHs0XnT_4GCHsRpq9FyUAxoK
X-Proofpoint-ORIG-GUID: PiAJCathCHs0XnT_4GCHsRpq9FyUAxoK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-03_07,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=866 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403030139



On 3/3/24 06:07, Lukas Wunner wrote:
> On Thu, Feb 29, 2024 at 09:20:00PM -0500, Stefan Berger wrote:
>> Add the number of bits a curve has to the ecc_curve definition and set it
>> on all cruve definitions.
> 
> Nit: s/cruve/curve/
> 
> 
>> --- a/include/crypto/ecc_curve.h
>> +++ b/include/crypto/ecc_curve.h
>> @@ -23,6 +23,8 @@ struct ecc_point {
>>    * struct ecc_curve - definition of elliptic curve
>>    *
>>    * @name:	Short name of the curve.
>> + * @nbits:      Curves that do not use all bits in their ndigits must specify
>> + *              their number of bits here, otherwise can leave at 0.
>>    * @g:		Generator point of the curve.
>>    * @p:		Prime number, if Barrett's reduction is used for this curve
>>    *		pre-calculated value 'mu' is appended to the @p after ndigits.
> 
> Nit: Looks like this kernel-doc uses 1 tab instead of blanks.
> 
Fixed.

