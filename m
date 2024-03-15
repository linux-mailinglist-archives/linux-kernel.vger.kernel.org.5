Return-Path: <linux-kernel+bounces-104697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0525987D27D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0BF1F24BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C484DA19;
	Fri, 15 Mar 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZlstryYO"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356504CB28;
	Fri, 15 Mar 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522630; cv=none; b=uxONIhqevhPUK0yaqLIjYHCY2MVJId/JBxYZiafFEEhK3yykYTosaEpb3xla8eQmDoewkN3QbZhFQUIuMzSoHGFKRI7bzg2gP3dhRIUo5/BY0yNsVSAFr39lHwq5cL0BWdTACvRSGl0W+30RIiaAPj17Eq5km8Ckp+JowOJY+Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522630; c=relaxed/simple;
	bh=9vT0dxA/QCtE89aPDLW6ejKWHtzyW1+uBD9Gs5tXIwY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yrc1Euuit+Z553D5aTHGSFZMhCqSCmO/JQz7vniWdJA8sy3QY0Ts24FRUXdD2UBnBXRXXCCcWhZQkwttlVsthPoKhSTbzIoA+YbtrhmWxOrSoScBjTrLKfkegjyObeUzQ7jRxITKrFnnLcK5/HIuwtq93lFuEHH50RL7TEvS3iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZlstryYO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FGrx2x015515;
	Fri, 15 Mar 2024 17:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=EKUrZ491a9NQV1pm7p5DZbddde0yplqdXNiaos99Owg=;
 b=ZlstryYOW742pVdSoNxfncjvjNowvPnxbg1EEWcKhN+u1yKOJQzKI+HgYsGLg/JVTPM2
 Fm/yfupYOkp9YsBgGNkJwGTrSNxdLSH/wPoihyHcaVXKUY/h6Y6NlFZLpIPLfN8QXQnZ
 iCcjK3nvCN2buwO4X6waXyJKaKzVuBQOJM3WJk5PYzAOLE2Gc3Rmtsuf5exVXDUrRBPU
 t9QB5es5OXjb7zNJuzz1kmVx9/uau0RrnUgJ10MPZpzVMnE8TbS4r1PfhgRyopVesT51
 c2x8SJjsT2nkrq8fBp7cG8kHrV7kv7mjxRzljeJ0GQH1pbJfqQCcj0p2du1KiOx3nif1 6A== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvsvm0g3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 17:10:16 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42FGXmbo032187;
	Fri, 15 Mar 2024 17:10:15 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wvsyar6h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 17:10:15 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42FHADl447251886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 17:10:15 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34CA458066;
	Fri, 15 Mar 2024 17:10:13 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FFEC58055;
	Fri, 15 Mar 2024 17:10:12 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Mar 2024 17:10:12 +0000 (GMT)
Message-ID: <e2369a9e-cd65-4375-8178-52fae3b8122e@linux.ibm.com>
Date: Fri, 15 Mar 2024 13:10:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/13] Add support for NIST P521 to ecdsa
Content-Language: en-US
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C3lnf4-jvqvaoawTaxE_mxWIE4lGPBTl
X-Proofpoint-ORIG-GUID: C3lnf4-jvqvaoawTaxE_mxWIE4lGPBTl
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
 definitions=2024-03-15_04,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403150139



On 3/12/24 14:36, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> This series adds support for the NIST P521 curve to the ecdsa module
> to enable signature verification with it.
> 
> An issue with the current code in ecdsa is that it assumes that input
> arrays providing key coordinates for example, are arrays of digits
> (a 'digit' is a 'u64'). This works well for all currently supported
> curves, such as NIST P192/256/384, but does not work for NIST P521 where
> coordinates are 8 digits + 2 bytes long. So some of the changes deal with
> converting byte arrays to digits and adjusting tests on input byte
> array lengths to tolerate arrays not providing multiples of 8 bytes.
> 

FYI: A test suite for the NIST ECC algorithms is here: 
https://github.com/stefanberger/eckey-testing

Script to test valid and invalid certs and signatures: 
test-ecc-kernel-keys.sh

> Regards,
>     Stefan
> 
> v6:
>   - Use existing #defines for number of digits rather than plain numbers
>     (1/13, 6/13) following Bharat's suggestion
>   - Initialize result from lowest 521 bits of product rather than going
>     through tmp variable (6/13)
> 
> v5:
>   - Simplified ecc_digits_from_bytes as suggested by Lukas (1/12)
>   - Using nbits == 521 to detect NIST P521 curve rather than strcmp()
>     (5,6/12)
>   - Nits in patch description and comments (11/12)
> 
> v4:
>   - Followed suggestions by Lukas Wummer (1,5,8/12)
>   - Use nbits rather than ndigits where needed (8/12)
>   - Renaming 'keylen' variablest to bufsize where necessary (9/12)
>   - Adjust signature size calculation for NIST P521 (11/12)
> 
> v3:
>   - Dropped ecdh support
>   - Use ecc_get_curve_nbits for getting number of bits in NIST P521 curve
>     in ecc_point_mult (7/10)
> 
> v2:
>   - Reformulated some patch descriptions
>   - Fixed issue detected by krobot
>   - Some other small changes to the code
> 
> 
> 
> Stefan Berger (13):
>    crypto: ecc - Use ECC_CURVE_NIST_P192/256/384_DIGITS where possible
>    crypto: ecdsa - Convert byte arrays with key coordinates to digits
>    crypto: ecdsa - Adjust tests on length of key parameters
>    crypto: ecdsa - Extend res.x mod n calculation for NIST P521
>    crypto: ecc - Add nbits field to ecc_curve structure
>    crypto: ecc - Implement vli_mmod_fast_521 for NIST p521
>    crypto: ecc - Add special case for NIST P521 in ecc_point_mult
>    crypto: ecc - Add NIST P521 curve parameters
>    crypto: ecdsa - Replace ndigits with nbits where precision is needed
>    crypto: ecdsa - Rename keylen to bufsize where necessary
>    crypto: ecdsa - Register NIST P521 and extend test suite
>    crypto: asymmetric_keys - Adjust signature size calculation for NIST
>      P521
>    crypto: x509 - Add OID for NIST P521 and extend parser for it
> 
>   crypto/asymmetric_keys/public_key.c       |  14 ++-
>   crypto/asymmetric_keys/x509_cert_parser.c |   3 +
>   crypto/ecc.c                              |  44 +++++--
>   crypto/ecc_curve_defs.h                   |  49 ++++++++
>   crypto/ecdsa.c                            |  62 ++++++---
>   crypto/ecrdsa_defs.h                      |   5 +
>   crypto/testmgr.c                          |   7 ++
>   crypto/testmgr.h                          | 146 ++++++++++++++++++++++
>   include/crypto/ecc_curve.h                |   2 +
>   include/crypto/ecdh.h                     |   1 +
>   include/crypto/internal/ecc.h             |  24 +++-
>   include/linux/oid_registry.h              |   1 +
>   12 files changed, 335 insertions(+), 23 deletions(-)
> 

