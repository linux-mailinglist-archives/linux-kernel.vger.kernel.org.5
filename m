Return-Path: <linux-kernel+bounces-96982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BCB876412
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845921F22D57
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1223357882;
	Fri,  8 Mar 2024 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NMpBeWb2"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2A657880;
	Fri,  8 Mar 2024 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899896; cv=none; b=L2gLJvqLMhcFnAUNjQ4IagyIJ9BaEIhKjm9TU58ZPaVZKtZkkegPp0v1hQwvHhq1koEHx/5UqgUF1+ZYJbhNbM4HlBf69zCQrHGuD4r/QN1XXdlhu+ONvIamfb0X9XU2Vko1I4IgiKBCaEDxfC6G7egW5Ru/EepiH0a9LsWMOkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899896; c=relaxed/simple;
	bh=ZrmhIau01iblULmsGvpRh7gT6Esf3sYRsWvciH1vB68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICmy6CcnIJsGBD7x8Kc4FcvOqJ0qPUtfsOrGvmKora28mXA8VcRGHnCpJ15msj7iVn3Zgy3hTDmG7S8DFG2PyuKrWsaIniBAgd9TUNECIfOVusfsSv1qReK/RGQVoOte5CRQ+k/B85YtDQbqmsZOeirm93u0ASZ4Q4ubaR8SzyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NMpBeWb2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428BCDmv007270;
	Fri, 8 Mar 2024 12:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UAsfsXYcMiGqRElxJy9HtXhURXs3MYYs7S6xER/cnww=;
 b=NMpBeWb2ZX9F+03Fw90cf9zbENhL0DJKY3xRT2WXKWjGTY2wkXgc73P1Eve9kznmFfW7
 7SkS1SxGo407pmzVdCEkFaRssaCQYIZSgNwDqgutbq3XPZ4HvviZ+0Dk7QDkLHZk6rGV
 Afz+27ASh8JslVABwp7BjBxJl/1EjdMIhyiA8Pn2bWuBXREy3b9LZTF6CobvB30SmbGk
 Pi0l1DxDT0OrisgghUKeX6sDRq/vDHRppPjW/1fI6uPGsvFY3Xybh6aiFZpPmwdr3gjE
 cbeITpg75w8XhmYNaXQBKarQghfjD8DeBWai3YdFzDvX6iKgMH/JqI6B61jsFaofLYBA +g== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr1ke10y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 12:11:27 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 428B5Wvl025371;
	Fri, 8 Mar 2024 12:11:26 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmeu04ete-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 12:11:26 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 428CBNJc23134806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 12:11:25 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EDC958059;
	Fri,  8 Mar 2024 12:11:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E028258043;
	Fri,  8 Mar 2024 12:11:22 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Mar 2024 12:11:22 +0000 (GMT)
Message-ID: <eedf397f-24c6-4ee6-96b4-67f52c0ef8f4@linux.ibm.com>
Date: Fri, 8 Mar 2024 07:11:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/12] crypto: ecdsa - Convert byte arrays with key
 coordinates to digits
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
References: <20240306222257.979304-1-stefanb@linux.ibm.com>
 <20240306222257.979304-2-stefanb@linux.ibm.com> <ZerPU6pJiosjOvDq@wunner.de>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <ZerPU6pJiosjOvDq@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Gnf7ZvAwUzD0dPz9RqlHaUicwpqtBxkM
X-Proofpoint-ORIG-GUID: Gnf7ZvAwUzD0dPz9RqlHaUicwpqtBxkM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403080097



On 3/8/24 03:41, Lukas Wunner wrote:
> On Wed, Mar 06, 2024 at 05:22:46PM -0500, Stefan Berger wrote:
>> +static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
>> +					 u64 *out, unsigned int ndigits)
>> +{
>> +	unsigned int o = nbytes & 7;
>> +	u64 msd = 0;
> 
> My sincere apologies, I made a mistake when I proposed this:
> It needs to be __be64 instead of u64...
> 
>> +
>> +	if (o) {
>> +		memcpy((u8 *)&msd + sizeof(msd) - o, in, o);
>> +		out[--ndigits] = be64_to_cpu(msd);
>> +		in += o;
>> +	}
> 
> ...otherwise sparse complains:
> 
>      crypto/ecdsa.c: note: in included file:
>      >> include/crypto/internal/ecc.h:74:34: sparse: sparse: cast to restricted __be64
>      >> include/crypto/internal/ecc.h:74:34: sparse: sparse: cast to restricted __be64
>      [...]
>      66	static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
>      67						 u64 *out, unsigned int ndigits)
>      68	{
>      69		unsigned int o = nbytes & 7;
>      70		u64 msd = 0;
>      71	
>      72		if (o) {
>      73			memcpy((u8 *)&msd + sizeof(msd) - o, in, o);
>    > 74			out[--ndigits] = be64_to_cpu(msd);
>      75			in += o;
>      76		}
>      77		ecc_swap_digits(in, out, ndigits);
>      78	}
>      79	
> 
> 0-day alerted me about this, it's monitoring my GitHub repo and
> I've got your patches on one of my development branches.

Thanks. Fixed.

> 
> Thanks,
> 
> Lukas
> 

