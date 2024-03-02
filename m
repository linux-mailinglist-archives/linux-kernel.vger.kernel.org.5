Return-Path: <linux-kernel+bounces-89601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B4D86F288
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 22:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A93284663
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32C741236;
	Sat,  2 Mar 2024 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C9mkonvd"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAFE40866;
	Sat,  2 Mar 2024 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709414407; cv=none; b=c0qMis390Cmccu+0X7Xz1A7pwYJjJv9a5HAGVhvx2NRBCVZ+J6PMO8BtidngOUa6UlSn20Wm8HKU+Ack9shCTT/mjUNWaC6GLGpGEJbFnXHy1MHFPn1ukI3SZ3Iaql0FHE1oKZlUbQipMVPLx6FSmj0AP8hCO2UY7vmPavX/j4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709414407; c=relaxed/simple;
	bh=1rw8pwG8J01ci0U1vGTUv1z12PHx6CJpLJeKBu0tUR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=anK4wEQnwtaNEQml8c+ipUWIkVYa1vR1sl2onyKcp3fJRG20xaiuMjOH9UfPZjsJm8ZlZEZPmQ+bfgTJaln4/eTztNQwo0T3NqairAe2bDfUrhhnN7kG3eYzPAij64bS87ynRnVODfWR4fafCWxpK5Zs7OhwuImpi6peMQjE3yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C9mkonvd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 422L2UDm032058;
	Sat, 2 Mar 2024 21:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yp/9FIVu0rBtrMkwC7oZO7VcLXI86dRylM7N/4bvgJM=;
 b=C9mkonvdHywvyxNZ/kH+lF+PRuY3z+iHBkP5NGfEmVGotnMACl8Tkqk0Z+LBLXpeq2QU
 ysZL0ac+soAZVm4ZzNvTvCtIiqW+9mNsMR6cJCG6H+CSdeX3E84JtuhXFhD3iBZuXiYd
 7z52eHQ6EBwanPwGjjb+WQ4QuTrG8alZFa5HZfYuoMMqtcqU40Dl4lTXYt2sJ6WFNZuy
 tY2ay97VdQRGevE5S99V2mx4Y+4jwwvaRFodJ4d1NCbC1TMB1bbFuF4/NvXVEhHGffGY
 4Q9sB06yfErUWZL5Zcq5Tl6hNJQNaL0R2OZquQvKCMD7DYssIA7pu8Q/itdaT8emQo03 2A== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wmbp706nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Mar 2024 21:19:54 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 422I8R88008170;
	Sat, 2 Mar 2024 21:19:54 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9n4pnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Mar 2024 21:19:53 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 422LJpoL32834060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 Mar 2024 21:19:53 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB09758063;
	Sat,  2 Mar 2024 21:19:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04F7458059;
	Sat,  2 Mar 2024 21:19:50 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  2 Mar 2024 21:19:49 +0000 (GMT)
Message-ID: <f5dacc38-bf53-4dc7-95cf-54b8b13dd1d7@linux.ibm.com>
Date: Sat, 2 Mar 2024 16:19:49 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] crypto: ecdsa - Convert byte arrays with key
 coordinates to digits
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
References: <20240223204149.4055630-1-stefanb@linux.ibm.com>
 <20240223204149.4055630-2-stefanb@linux.ibm.com>
 <20240229091105.GA29363@wunner.de>
 <aabeec7b-618c-4d15-b033-4162b6e54f6a@linux.ibm.com>
 <CZIOY02QS2QC.LV0A0HNT7VKM@suppilovahvero> <20240302140001.GA3095@wunner.de>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240302140001.GA3095@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Nj4tcUlmaDVw0gktlE9RUjRJgOI3alrZ
X-Proofpoint-ORIG-GUID: Nj4tcUlmaDVw0gktlE9RUjRJgOI3alrZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-02_06,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403020183



On 3/2/24 09:00, Lukas Wunner wrote:
> On Fri, Mar 01, 2024 at 10:26:29PM +0200, Jarkko Sakkinen wrote:
>> On Thu Feb 29, 2024 at 4:57 PM EET, Stefan Berger wrote:
>>>
>>>
>>> On 2/29/24 04:11, Lukas Wunner wrote:
>>>> On Fri, Feb 23, 2024 at 03:41:40PM -0500, Stefan Berger wrote:
>>>>> +static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
>>>>> +					 u64 *out, unsigned int ndigits)
>>>>> +{
>>>>> +	unsigned int sz = ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
>>>>> +	u8 tmp[ECC_MAX_DIGITS << ECC_DIGITS_TO_BYTES_SHIFT];
>>>>> +	unsigned int o = sz - nbytes;
>>>>> +
>>>>> +	memset(tmp, 0, o);
>>>>> +	memcpy(&tmp[o], in, nbytes);
>>>>> +	ecc_swap_digits(tmp, out, ndigits);
>>>>> +}
>>>>
>>>> Copying the whole key into tmp seems inefficient.  You only need
>>>> special handling for the first few bytes of "in" (6 bytes in the
>>>> P521 case) and could use ecc_swap_digits() to convert the rest
>>>> of "in" directly to "out" without using tmp.
>>>>
>>>> So it would be sufficient to allocate the first digit on the stack,
>>>> memset + memcpy, then convert that to native byte order into "in[0]"
>>>> and use ecc_swap_digits() for the rest.
>>>>
>>>> And the special handling would be conditional on "!o", so is skipped
>>>> for existing curves.
>>>
>>> Thanks. It looks like this now:
>>>
>>> static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
>>>                                            u64 *out, unsigned int ndigits)
>>> {
>>>           unsigned int o = nbytes & 7;
>>>           u64 msd = 0;
>>>           size_t i;
>>>
>>>           if (o == 0) {
>>>                   ecc_swap_digits(in, out, ndigits);
>>>           } else {
>>>                   for (i = 0; i < o; i++)
>>>                           msd = (msd << 8) | in[i];
>>>                   out[ndigits - 1] = msd;
>>>                   ecc_swap_digits(&in[o], out, ndigits - 1);
>>
>> This would be more stream-lined IMHO:
>>
>>          unsigned int o = nbytes & 7;
>>          unsigned int n = ndigits;
>>          u64 msd = 0;
>>          size_t i;
>>
>>          if (o != 0) {
>>                  for (i = 0; i < o; i++)
>>                          msd = (msd << 8) | in[i];
>>
>>                  out[--n] = msd;
>>          }
>>
>>          ecc_swap_digits(in, out, n);
> 
> Maybe eliminate the for-loop as well?
> 
> 	unsigned int o = nbytes & 7;
> 	u64 msd = 0;
> 
> 	if (o != 0) {
> 		/* if key length is not a multiple of 64 bits (NIST P521) */
> 		memcpy((u8 *)&msd + sizeof(msd) - o, in, o);
> 		out[--ndigits] = be64_to_cpu(msd);
> 		in += o;
> 	}
> 
> 	ecc_swap_digits(in, out, ndigits);
> 
Will take this for v5 with your Suggested-by:, ok?

    Stefan

