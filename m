Return-Path: <linux-kernel+bounces-40001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7D783D92E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5DF3B42B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DE712B6F;
	Fri, 26 Jan 2024 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HQgP8YHN"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A522904;
	Fri, 26 Jan 2024 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706265784; cv=none; b=OtCIvqoQBe9KnN0Fs3n2gaS+EQOGhFJCIoAFFwv+WyU+/3vl0md6BiX5M/CXhwJF9xcdz/PdSY4anu61xaCXpHtIpJMR+EfaQZrKKCP8fmi2mhBDT01VFpXaWtrgNo1WxRK0CDrcFklH8aHG2/wB02NlTtbKHQboBExciUngFMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706265784; c=relaxed/simple;
	bh=YsN7lX/2kWLdzWYdeaCjEqzhqohbfutniFYIhZ9G9dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GtO8a+zSt7GirpNXAVrYrJLzuQmlsJjgRYd6nd26cmxbkrftJgHRWBC2byotZuxvQc/ME/5hvYZ5EHsWElM8uaFWdzv8mACy6nsU7vQ/xvUESTErC6woBjs3OhbN3bNjfHkC430r2wShDgXF5zyheW/NpXR+w+JA/cNiNjFOw4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HQgP8YHN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QA2Eih002662;
	Fri, 26 Jan 2024 10:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2IMEERAUR7WgGpN5eMUxTy1J+tHxs7yz/GZ4foVta4s=;
 b=HQgP8YHN79Z/Xd0sxe8xQr/TmQICezlxF2sBTzg/p/TKOGogvlVIIoYvzcnbVPP1FLgL
 cgOIGh0BviOvSeh2kzYPSza4U8R1WtCPcGoxngZ41yjVyavCtJuLb26e88cHVfhS6aAw
 suZuwz/MdDHZBTJP11EyqL/74TDMEH8a/t4w1LgDzq16aEHefJ4pUFz8T0wlBf2oxi+c
 fC2Uc29B4CEirjN9xrhY+pdaQuz3lmqzL5IYwoT6uHJG2BqEBexfg9/GeHg8mfK42mZG
 tK4DhfieXlEIrCCJFFf+77IbMLL3oHxa4Tz/suB8qkhqpqLndHvDPXFKMs83XvIifD6j HQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vvamjgvak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 10:42:44 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40QAavab026508;
	Fri, 26 Jan 2024 10:42:43 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrrgtthf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 10:42:43 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40QAgfga44434050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 10:42:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A12C15805E;
	Fri, 26 Jan 2024 10:42:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 948D65805D;
	Fri, 26 Jan 2024 10:42:38 +0000 (GMT)
Received: from [9.67.128.71] (unknown [9.67.128.71])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jan 2024 10:42:38 +0000 (GMT)
Message-ID: <46ca196c-b7d3-4f3c-9ef0-5d66fb24c9e6@linux.ibm.com>
Date: Fri, 26 Jan 2024 18:42:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto:vmx: Move ppc vmx diirectory to
 arch/powerpc/crypto.
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, leitao@debian.org, nayna@linux.ibm.com,
        appro@cryptogams.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com
References: <20240102205856.370103-1-dtsen@linux.ibm.com>
 <ZbN0LufXZ6YZmn3E@gondor.apana.org.au>
Content-Language: en-US
From: Danny Tsen <dtsen@linux.ibm.com>
In-Reply-To: <ZbN0LufXZ6YZmn3E@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DPUyM4vhsiTM7ytNws9YY-5eg4mmlmv2
X-Proofpoint-ORIG-GUID: DPUyM4vhsiTM7ytNws9YY-5eg4mmlmv2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 mlxlogscore=692 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260078

Thanks Herbert.

-Danny

On 1/26/24 4:58 PM, Herbert Xu wrote:
> On Tue, Jan 02, 2024 at 03:58:56PM -0500, Danny Tsen wrote:
>> Relocate all crypto files in vmx driver to arch/powerpc/crypto directory
>> and remove vmx directory.
>>
>> drivers/crypto/vmx/aes.c rename to arch/powerpc/crypto/aes.c
>> drivers/crypto/vmx/aes_cbc.c rename to arch/powerpc/crypto/aes_cbc.c
>> drivers/crypto/vmx/aes_ctr.c rename to arch/powerpc/crypto/aes_ctr.c
>> drivers/crypto/vmx/aes_xts.c rename to arch/powerpc/crypto/aes_xts.c
>> drivers/crypto/vmx/aesp8-ppc.h rename to arch/powerpc/crypto/aesp8-ppc.h
>> drivers/crypto/vmx/aesp8-ppc.pl rename to arch/powerpc/crypto/aesp8-ppc.pl
>> drivers/crypto/vmx/ghash.c rename to arch/powerpc/crypto/ghash.c
>> drivers/crypto/vmx/ghashp8-ppc.pl rename to arch/powerpc/crypto/ghashp8-ppc.pl
>> drivers/crypto/vmx/vmx.c rename to arch/powerpc/crypto/vmx.c
>>
>> deleted files:
>> drivers/crypto/vmx/Makefile
>> drivers/crypto/vmx/Kconfig
>> drivers/crypto/vmx/ppc-xlate.pl
>>
>> This patch has been tested has passed the selftest.  The patch is also tested with
>> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS enabled.
>>
>> Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
>> ---
>>   arch/powerpc/crypto/Kconfig                   |  20 ++
>>   arch/powerpc/crypto/Makefile                  |  20 +-
>>   .../crypto/vmx => arch/powerpc/crypto}/aes.c  |   0
>>   .../vmx => arch/powerpc/crypto}/aes_cbc.c     |   0
>>   .../vmx => arch/powerpc/crypto}/aes_ctr.c     |   0
>>   .../vmx => arch/powerpc/crypto}/aes_xts.c     |   0
>>   .../vmx => arch/powerpc/crypto}/aesp8-ppc.h   |   0
>>   .../vmx => arch/powerpc/crypto}/aesp8-ppc.pl  |   0
>>   .../vmx => arch/powerpc/crypto}/ghash.c       |   0
>>   .../powerpc/crypto}/ghashp8-ppc.pl            |   0
>>   .../crypto/vmx => arch/powerpc/crypto}/vmx.c  |   0
>>   drivers/crypto/Kconfig                        |  14 +-
>>   drivers/crypto/Makefile                       |   2 +-
>>   drivers/crypto/vmx/.gitignore                 |   3 -
>>   drivers/crypto/vmx/Kconfig                    |  14 --
>>   drivers/crypto/vmx/Makefile                   |  23 --
>>   drivers/crypto/vmx/ppc-xlate.pl               | 231 ------------------
>>   17 files changed, 46 insertions(+), 281 deletions(-)
>>   rename {drivers/crypto/vmx => arch/powerpc/crypto}/aes.c (100%)
>>   rename {drivers/crypto/vmx => arch/powerpc/crypto}/aes_cbc.c (100%)
>>   rename {drivers/crypto/vmx => arch/powerpc/crypto}/aes_ctr.c (100%)
>>   rename {drivers/crypto/vmx => arch/powerpc/crypto}/aes_xts.c (100%)
>>   rename {drivers/crypto/vmx => arch/powerpc/crypto}/aesp8-ppc.h (100%)
>>   rename {drivers/crypto/vmx => arch/powerpc/crypto}/aesp8-ppc.pl (100%)
>>   rename {drivers/crypto/vmx => arch/powerpc/crypto}/ghash.c (100%)
>>   rename {drivers/crypto/vmx => arch/powerpc/crypto}/ghashp8-ppc.pl (100%)
>>   rename {drivers/crypto/vmx => arch/powerpc/crypto}/vmx.c (100%)
>>   delete mode 100644 drivers/crypto/vmx/.gitignore
>>   delete mode 100644 drivers/crypto/vmx/Kconfig
>>   delete mode 100644 drivers/crypto/vmx/Makefile
>>   delete mode 100644 drivers/crypto/vmx/ppc-xlate.pl
> Patch applied.  Thanks.

