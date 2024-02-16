Return-Path: <linux-kernel+bounces-69247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F16F858633
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1BE1F23E69
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2F71369B4;
	Fri, 16 Feb 2024 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rdpZfcco"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC11A1353EB;
	Fri, 16 Feb 2024 19:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708111970; cv=none; b=Sk3dBnIkMHntFofPuNCxMu6cnLylZ/Y/3fGMSts/Lr5CHw+yfnBTy/UjmcpwwIU0KeDZIWoCS40AaHooEc7Okom5rV/EHg5UXVbc3Xeq0ljx04p4iZovcw3DBUZGoSGaQ8ue273J0MCdxpBZSpxpXARRaFxEoTsiFPUr99YfYjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708111970; c=relaxed/simple;
	bh=Br02N1XoCkr35dKNdGtPJTZ7TXEI3Rna5beVLbPlfTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXDD+NNeWbWo4Vot9SOzhWFEDnrWU2FUyiJBwdUZGlQcajhWclX5BoLtxbyVCLiEsjF2PAc7GD/2fLmj7J3CMJ5a66gU/wYAMm7uQjPN4PQQnBrTbFwNLmFokWm6kHcbDuTaWh5/0ZCAt98/bnN2lVAE9pwYpyB+OGDvATaAtuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rdpZfcco; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GJ0mtg024491;
	Fri, 16 Feb 2024 19:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GNnialPGx1cOc1nstc7U6OHGMq+fB1ZRhbwq/aKiOsw=;
 b=rdpZfccoTLBN/QnyH3DaL2sqWr0OARN+AQOs1ehHm7tbdJzUmCFHoXGfIlXWYLHIyxTH
 HVR/+Hng0SsRN17sevuU9IKhrjKgNXJhrNC0KvlOM5s7xo1lqLwCj4RrhkZ+Lo8WZEBn
 J/p4bADJ01RHEP7HZX/seCzih2LE6PMp4UsawY7hU+LdyNW1JZSSS/0twacsOPXcSMaC
 Zm4uvP1uUuzsiecUrCzkz7y4NmVI1dIOPsgBm4ZP4oflt/SMT+XHGT8xmdjgTDGTHeVq
 lG1sOxAiC4wiKV3uaq+/rYRdZ1GlPBWSNPlVYyayx5Ccc2O9Ivbp6c5RfTfpvZpfLY9N 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wacst9es5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 19:32:41 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41GJDZ3a002450;
	Fri, 16 Feb 2024 19:32:41 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wacst9erx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 19:32:41 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41GHhcrQ032553;
	Fri, 16 Feb 2024 19:32:40 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6kfu5k2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 19:32:40 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41GJWcDV50135462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 19:32:40 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 752605805E;
	Fri, 16 Feb 2024 19:32:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09EEE58076;
	Fri, 16 Feb 2024 19:32:36 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Feb 2024 19:32:35 +0000 (GMT)
Message-ID: <b507fd52-a807-4325-981b-3852f4f6190b@linux.ibm.com>
Date: Fri, 16 Feb 2024 14:32:35 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] Add support for NIST P521 to ecdsa and ecdh
Content-Language: en-US
To: Simo Sorce <simo@redhat.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
References: <20240215231414.3857320-1-stefanb@linux.ibm.com>
 <3bdb1c9e0ac35c7dc3fbba1233bc7df80ac466a2.camel@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <3bdb1c9e0ac35c7dc3fbba1233bc7df80ac466a2.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UtfbeBo_NFHup-ff0OY5lYpm3l4efxxa
X-Proofpoint-GUID: VL9ERooELf1h3y-lG5YL4YyeG4xTkqwU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_18,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160151



On 2/16/24 14:27, Simo Sorce wrote:
> On Thu, 2024-02-15 at 18:13 -0500, Stefan Berger wrote:
>> This series of patches adds support for the NIST P521 curve to ecdsa and
>> ecdh. Test cases for NIST P521 are added to both modules.
>>
>> An issue with the current code in ecdsa and ecdh is that it assumes that
>> input arrays providing key coordinates for example, are arrays of digits
>> (a 'digit' is a 'u64'). This works well for all currently supported
>> curves, such as NIST P192/256/384, but does not work for NIST P521 where
>> coordinates are 8 digits + 2 bytes long. So some of the changes deal with
>> converting byte arrays to digits and digits to byte arrays.
>>
>>
>> Regards,
>>     Stefan
>>
>> v2:
>>   - Reformulated some patch descriptions
>>   - Fixed issue detected by krobot
>>   - Some other small changes to the code
>>
>> Stefan Berger (14):
>>    crypto: ecdsa - Convert byte arrays with key coordinates to digits
>>    crypto: ecdsa - Adjust tests on length of key parameters
>>    crypto: ecdsa - Extend res.x mod n calculation for NIST P521
>>    crypto: ecc - Implement vli_mmod_fast_521 for NIST p521
>>    crypto: ecc - For NIST P521 use vli_num_bits to get number of bits
>>    crypto: ecc - Add NIST P521 curve parameters
>>    crypto: ecdsa - Register NIST P521 and extend test suite
>>    x509: Add OID for NIST P521 and extend parser for it
>>    crypto: ecdh - Use properly formatted digits to check for valid key
>>    crypto: ecc - Implement ecc_digits_to_bytes to convert digits to byte
>>      array
>>    crypto: Add nbits field to ecc_curve structure
>>    crypto: ecc - Implement and use ecc_curve_get_nbytes to get curve's
>>      nbytes
>>    crypto: ecdh - Use functions to copy digits from and to byte array
>>    crypto: ecdh - Add support for NIST P521 and add test case
>>
>>   crypto/asymmetric_keys/x509_cert_parser.c |   3 +
>>   crypto/ecc.c                              |  71 +++++--
>>   crypto/ecc_curve_defs.h                   |  45 +++++
>>   crypto/ecdh.c                             |  59 +++++-
>>   crypto/ecdsa.c                            |  48 ++++-
>>   crypto/testmgr.c                          |  14 ++
>>   crypto/testmgr.h                          | 225 ++++++++++++++++++++++
>>   include/crypto/ecc_curve.h                |   3 +
>>   include/crypto/ecdh.h                     |   1 +
>>   include/crypto/internal/ecc.h             |  61 +++++-
>>   include/linux/oid_registry.h              |   1 +
>>   11 files changed, 495 insertions(+), 36 deletions(-)
> 
> Hi Stefan,
> what kind of side-channel testing was performed on this code?
> And what is the use case you are adding it for?

We're using public keys for signature verification. I am not aware that
public key usage is critical to side channels.

The use case for adding it is primarily driven by closing a gap to 
complete the support for the common ECDSA NIST curves.

     Stefan

> 
> Thanks,
> Simo.
> 

