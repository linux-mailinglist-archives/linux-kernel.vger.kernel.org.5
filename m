Return-Path: <linux-kernel+bounces-71497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 549ED85A637
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79B0280E75
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4DB37141;
	Mon, 19 Feb 2024 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gTiUYdrp"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00361DDFA;
	Mon, 19 Feb 2024 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353652; cv=none; b=nY4/f1xSZwMNn5mssqfhxE4t4jaoF+tFgdtgDVhV47TST/8S1grHRUwSv7ZZOYbXVx2XmnbQWxwVO1ivqs0SF5GXCcgVH33yEYd0qazPcsucxdYHCEzqkjLR7jwsB7aR/h/jS3GV14wh3of1Zf43fhZYI3Dr4PrZGq+wXhAWY/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353652; c=relaxed/simple;
	bh=lS6tnNIEG62vn9NZlJr0TcmEITMimGmfMmhLb4jK/Wo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PJXdiHxJj4o2jTT3qp1MSrJgQcR4q0W3QI5609lyrWFM/Wp05YeSa5qJIc6VJ0Z6GjPDfprqvG35PzpYFtVEGTAQfdGBQXPdEKQf4YGrCkfKYnPIfUMs15hcfGstjn1bwExfbUCUvfH7D12KHXjWqAsBn/j11Csu0v/8LX+u9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gTiUYdrp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JDX5o6032426;
	Mon, 19 Feb 2024 14:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bJP5HIx5nNqhT4TUNKgIkLEZ2q/UydeD2C4sJY7sccA=;
 b=gTiUYdrpDW5hvTNopJBeamT3UzLhzbjIyQsZ//pGMtN1oNtfSVMJpYVgO91yLBAihj5q
 vtDcliz3hCzKgmWkjFqhvJKmNHejmKk12hcn+udibAOZjR+aXio8lpyNjwgKvsBXXUVM
 gv+nMnCmz4Q181/re1lj+KSSWT3hWg1UDi0QM5Ug1nFJviCGRR6LAt43H0U/Dpgf4Kzj
 Fi0mDqzsYoLxxeHv0d4RQuTMiU2o87TOdfIwgsQjAUiTsE2L9+PnwOABXx01H9Hs4np0
 XyJuCyolK3cdbq+b/ZuHWREfNSZaRs4wkRw+2XoBkLokmqYTeepoOHydw5YKzdChyktZ 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc7ygt1be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 14:40:43 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JEbVpH021477;
	Mon, 19 Feb 2024 14:40:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc7ygt1b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 14:40:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41JEHwIN009583;
	Mon, 19 Feb 2024 14:40:42 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84p1rwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 14:40:42 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41JEeduj3015676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 14:40:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE14A58065;
	Mon, 19 Feb 2024 14:40:39 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1574B58059;
	Mon, 19 Feb 2024 14:40:39 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Feb 2024 14:40:38 +0000 (GMT)
Message-ID: <98005c8e-816f-4b58-9572-f2af538e6728@linux.ibm.com>
Date: Mon, 19 Feb 2024 09:40:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 00/14] Add support for NIST P521 to ecdsa and ecdh
To: Simo Sorce <simo@redhat.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
References: <20240215231414.3857320-1-stefanb@linux.ibm.com>
 <3bdb1c9e0ac35c7dc3fbba1233bc7df80ac466a2.camel@redhat.com>
 <b507fd52-a807-4325-981b-3852f4f6190b@linux.ibm.com>
 <c7feceb3a7816c2f8686a907fbea2028477464a0.camel@redhat.com>
Content-Language: en-US
In-Reply-To: <c7feceb3a7816c2f8686a907fbea2028477464a0.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lj8fOMihFw8P0xDnV9dpv8Bmv_bA0JO7
X-Proofpoint-GUID: mO5g91bceedikjZJxmsczi5AWouqqweR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_10,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190109



On 2/16/24 14:40, Simo Sorce wrote:
> On Fri, 2024-02-16 at 14:32 -0500, Stefan Berger wrote:
>>
>> On 2/16/24 14:27, Simo Sorce wrote:
>>> On Thu, 2024-02-15 at 18:13 -0500, Stefan Berger wrote:
>>>> This series of patches adds support for the NIST P521 curve to ecdsa and
>>>> ecdh. Test cases for NIST P521 are added to both modules.
>>>>
>>>> An issue with the current code in ecdsa and ecdh is that it assumes that
>>>> input arrays providing key coordinates for example, are arrays of digits
>>>> (a 'digit' is a 'u64'). This works well for all currently supported
>>>> curves, such as NIST P192/256/384, but does not work for NIST P521 where
>>>> coordinates are 8 digits + 2 bytes long. So some of the changes deal with
>>>> converting byte arrays to digits and digits to byte arrays.
>>>>
>>>>
>>>> Regards,
>>>>      Stefan
>>>>
>>>> v2:
>>>>    - Reformulated some patch descriptions
>>>>    - Fixed issue detected by krobot
>>>>    - Some other small changes to the code
>>>>
>>>> Stefan Berger (14):
>>>>     crypto: ecdsa - Convert byte arrays with key coordinates to digits
>>>>     crypto: ecdsa - Adjust tests on length of key parameters
>>>>     crypto: ecdsa - Extend res.x mod n calculation for NIST P521
>>>>     crypto: ecc - Implement vli_mmod_fast_521 for NIST p521
>>>>     crypto: ecc - For NIST P521 use vli_num_bits to get number of bits
>>>>     crypto: ecc - Add NIST P521 curve parameters
>>>>     crypto: ecdsa - Register NIST P521 and extend test suite
>>>>     x509: Add OID for NIST P521 and extend parser for it
>>>>     crypto: ecdh - Use properly formatted digits to check for valid key
>>>>     crypto: ecc - Implement ecc_digits_to_bytes to convert digits to byte
>>>>       array
>>>>     crypto: Add nbits field to ecc_curve structure
>>>>     crypto: ecc - Implement and use ecc_curve_get_nbytes to get curve's
>>>>       nbytes
>>>>     crypto: ecdh - Use functions to copy digits from and to byte array
>>>>     crypto: ecdh - Add support for NIST P521 and add test case
>>>>
>>>>    crypto/asymmetric_keys/x509_cert_parser.c |   3 +
>>>>    crypto/ecc.c                              |  71 +++++--
>>>>    crypto/ecc_curve_defs.h                   |  45 +++++
>>>>    crypto/ecdh.c                             |  59 +++++-
>>>>    crypto/ecdsa.c                            |  48 ++++-
>>>>    crypto/testmgr.c                          |  14 ++
>>>>    crypto/testmgr.h                          | 225 ++++++++++++++++++++++
>>>>    include/crypto/ecc_curve.h                |   3 +
>>>>    include/crypto/ecdh.h                     |   1 +
>>>>    include/crypto/internal/ecc.h             |  61 +++++-
>>>>    include/linux/oid_registry.h              |   1 +
>>>>    11 files changed, 495 insertions(+), 36 deletions(-)
>>>
>>> Hi Stefan,
>>> what kind of side-channel testing was performed on this code?
>>> And what is the use case you are adding it for?
>>
>> We're using public keys for signature verification. I am not aware that
>> public key usage is critical to side channels.
>>
>> The use case for adding it is primarily driven by closing a gap to
>> complete the support for the common ECDSA NIST curves.
> 
> Is there an assumption the ECDH code uses exclusively ephemeral keys?
> 
It can use both, provided keys and ephemeral keys. I think at this point 
it's best to drop ecdh support from this series.

    Stefan

> Simo.
> 

