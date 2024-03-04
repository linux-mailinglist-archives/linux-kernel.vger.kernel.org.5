Return-Path: <linux-kernel+bounces-91145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82622870A12
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B470D1C21703
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D7578B6C;
	Mon,  4 Mar 2024 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pxqBZ2Qy"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76DC78B50;
	Mon,  4 Mar 2024 19:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579220; cv=none; b=CDJ8uiVYfeEdPslJ8Y+sTBQKaqTDg3ge7HU8IPZPWPeiafgKCnNzF5+NUoXVq4xJhsyvXg+kwr8vh/+nGBvKI23EU2SZN04JIN7eydzANs4WXJxhKl+LFx1eaEdF/WJvEhfWVLgqwBV/XgkqMxmMklIjHJiqpdaqHQSPOZH0Agc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579220; c=relaxed/simple;
	bh=z/+FJbtOYKoJjdt5JqfxQAUYtcZcb/bgxSsuxmnc7MQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CbfZsDO2OaxLjq3rHPDoaOEeeWGkpbEDpNp3IKL53hdGKvGlZf8IhSqyxV/0xpNa8RE14nUuALNW4oIW91HUgAMYBbKf4gy8s6xqVjIhbutlF68we2XdxvGIHdoq9OBVzwmYYNY+Nfd5dwVGQ3Tf+zErNjA+p19sGLALzs7Wm8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pxqBZ2Qy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424Ir4HG032625;
	Mon, 4 Mar 2024 19:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wG+AkWFsLk0LGbkTfh6JMlER9PxzsT9H1kUw5NpdIwI=;
 b=pxqBZ2QywGfs5OfpEbTrv8t12fuzJ4gWxu09DJHBzcb2a2lH8lya5rLyqgfzH9l7s4oi
 pQWqkVpDVbkMCggiMzUzlQM/PhH1SLvMgHr9FlRyzznHeN7Y8erSDxNUGxsh9studt+a
 l2o5Qj8N6FB3h+Rn6l+wdst4LkP0XbZPxttOL0qgTn7zp6goZCPnV7+z/UIsvsP4OJEj
 sdlyfE8XmTdlVSvx1PMe33UJd7geY3xpPrMJxRYB4AX0DDSCtSDRvNhBMmudeD4RYKZo
 ZvxU5YpEE3Atp8c4UjBgmDcdPMF3uloqiyTUh7BdOL8DfsMKBrbkyO0p8vXV7hFe21zz FQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wnkyg0ct0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 19:06:50 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 424H2lht031533;
	Mon, 4 Mar 2024 19:01:42 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmgnjt9tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 19:01:42 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 424J1dKb27394678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Mar 2024 19:01:41 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57E4758068;
	Mon,  4 Mar 2024 19:01:39 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E191158056;
	Mon,  4 Mar 2024 19:01:38 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Mar 2024 19:01:38 +0000 (GMT)
Message-ID: <3740c569-9dd2-448d-bcac-16ca5203b206@linux.ibm.com>
Date: Mon, 4 Mar 2024 14:01:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] Add support for NIST P521 to ecdsa
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
References: <20240301022007.344948-1-stefanb@linux.ibm.com>
 <20240304181004.GA14180@wunner.de>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240304181004.GA14180@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e0MzAC8-aT97XANG7sA5IsTleu0lLLob
X-Proofpoint-GUID: e0MzAC8-aT97XANG7sA5IsTleu0lLLob
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
 definitions=2024-03-04_14,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040145



On 3/4/24 13:10, Lukas Wunner wrote:
> On Thu, Feb 29, 2024 at 09:19:55PM -0500, Stefan Berger wrote:
>> This series adds support for the NIST P521 curve to the ecdsa module
>> to enable signature verification with it.
>>
>> An issue with the current code in ecdsa is that it assumes that input
>> arrays providing key coordinates for example, are arrays of digits
>> (a 'digit' is a 'u64'). This works well for all currently supported
>> curves, such as NIST P192/256/384, but does not work for NIST P521 where
>> coordinates are 8 digits + 2 bytes long. So some of the changes deal with
>> converting byte arrays to digits and adjusting tests on input byte
>> array lengths to tolerate arrays not providing multiples of 8 bytes.
> 
> When respinning this series as v5, feel free to add my
> 
> Tested-by: Lukas Wunner <lukas@wunner.de>

Thanks.
> 
> 
> I cherry-picked the commits from your nist_p521.v5 branch...
> 
> https://github.com/stefanberger/linux-ima-namespaces/commits/nist_p521.v5/
> 
> ...onto my development branch for PCI device authentication...
> 
> https://github.com/l1k/linux/commits/doe
> 
> ...and tested against qemu+libspdm that an emulated NVMe drive
> is able to present a valid signature using NIST P521 + SHA384
> which can be verified correctly by the kernel.

FYI: I have a PR for a test suite here as well:

https://github.com/stefanberger/eckey-testing/pull/1

> 
> I needed to fix up two of my patches, one which adds P1363
> signature format support to the kernel and another fixup to
> add NIST P521 support to the in-kernel SPDM library
> (two top-most commits on my above-linked development branch).
> 
> I performed this test against your f81547267725 head and notice
> that you pushed a new version today (with "curve->nbits == 521"
> instead of strcmp), but I'm confident those two small changes
> wouldn't alter the outcone, hence my Tested-by stands.
> 
> Thanks,
> 
> Lukas
> 

