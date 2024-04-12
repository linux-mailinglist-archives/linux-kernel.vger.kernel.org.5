Return-Path: <linux-kernel+bounces-142888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAD18A31AD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234211C225BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC70C1474C0;
	Fri, 12 Apr 2024 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LIDvt4fj"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E95713DDAC;
	Fri, 12 Apr 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933912; cv=none; b=W1xNGflScyd1aecYhE3MV4endm2nxAlk8LqqKfpciI+GpJ9gBZyurCr7UyzfVU3GO0J97SXy800IbyUX8g9IbO3NUmyW5jDhyZ9R7kLabb8or+xehyAbOq7VZHoWIsQt49TbCO/pBEOOyIOt8RyeNmHq/Dsr3jFk2WvZXQoCtyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933912; c=relaxed/simple;
	bh=GA0o7gpzd3wvUKxE11Lah5edZT9uClo0B+uRd5xaCeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFGtIFcDTXhS2rfqf3KlIxJ0dfp2lhwQ6tLFkWdUCgdyfm7aoE8oeAbSlGdi34VtRkLzz5wFEHl0Jgnn21h0fNVYqQ/08eEvbsxrDID7/KkocT1hj5UwJMaN/Jy3CXJBRxaNWaIxwZmPBtjDyF4rQDJYjYvtcqYmE/1JZ7/Hobc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LIDvt4fj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CEn4NX002717;
	Fri, 12 Apr 2024 14:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bi/bnV2Os8SIK1YMsjbl5v/VwVcUXqoVx0h3+nzBfZc=;
 b=LIDvt4fjsiHCbgCdaYypJ4UzonMDaJ+QkSlRfYyKOCdj/nU/3bqVRryfGKppRx9WojcH
 5WcvqXiw3ga7OtZ/iT6nzvELqKrjkE3YGKrU5Y0XNFHriMDPftUMX/jm+fhcmLO1kJJQ
 VxASbSuQkrUcfpixdcMXHE8W9Q9tLPBz927RxcJ444M//a9n5f/PMoWmHkM9UMKb4Wou
 /30NTfQ1Yifw68Qr+EX925UIROmLkpXzS4oprHjWv6678Ac5f3DNJdFinD3UmcTVaZ3r
 b6/dQ6aOlg5+4rf+GlqYLRhDRTGyoDPigsnF06ldrtzj+7HkDPaJQMtE/X0URWhUD573 Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xf5gug7mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:58:25 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43CEwPxM015202;
	Fri, 12 Apr 2024 14:58:25 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xf5gug7mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:58:25 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43CE6RWZ022560;
	Fri, 12 Apr 2024 14:58:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbhqpjf47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:58:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43CEwIZx50200924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 14:58:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B650D20043;
	Fri, 12 Apr 2024 14:58:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C82CF20040;
	Fri, 12 Apr 2024 14:58:17 +0000 (GMT)
Received: from [9.171.46.42] (unknown [9.171.46.42])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Apr 2024 14:58:17 +0000 (GMT)
Message-ID: <04ef8c91-0bbd-47e6-a248-7e37d7e314c5@linux.ibm.com>
Date: Fri, 12 Apr 2024 16:58:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v5 04/11] net/smc: implement some unsupported
 operations of loopback-ism
To: Wen Gu <guwen@linux.alibaba.com>,
        Niklas Schnelle
 <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, twinkler@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240324135522.108564-1-guwen@linux.alibaba.com>
 <20240324135522.108564-5-guwen@linux.alibaba.com>
 <3122eece5b484abcf8d23f85d6c18c36f0b939ff.camel@linux.ibm.com>
 <1db6ccab-b49f-45d2-a93c-05b0f79371a3@linux.alibaba.com>
 <3b3ff37643e9030ec1246e67720683a2cf5660e5.camel@linux.ibm.com>
 <7a0fc481-658e-4c99-add7-ccbd5f9dce1e@linux.alibaba.com>
 <7291dd1b2d16fd9bbd90988ac5bcc3a46d17e3f4.camel@linux.ibm.com>
 <46e8e227-8058-4062-a9db-6b9c774f63cc@linux.alibaba.com>
 <12ae995f-4af4-4c6b-9130-04672d157293@linux.ibm.com>
 <44ea7d83-4fa7-427b-9d54-678f05fd09e9@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <44ea7d83-4fa7-427b-9d54-678f05fd09e9@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Awmtnr0ZrpAS94KMe3T7N5WSb1zk4VgV
X-Proofpoint-ORIG-GUID: mF-7PiCVUnf7kBYQUpaUfbi5rPNRYOKh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_11,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=864 bulkscore=0 phishscore=0 adultscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120108



On 12.04.24 04:02, Wen Gu wrote:
> Hi Sandy, just to confirm if I understand you correctly.
> 
> You are proposing that don't draw a conclusion about the classification now,
> but supplementally mark which one become a optional operation in struct smcd_ops
> during the introduction of new devices for SMC-D.

Yes.

