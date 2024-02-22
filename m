Return-Path: <linux-kernel+bounces-75931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B297385F0D9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187D4284D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D35F9CC;
	Thu, 22 Feb 2024 05:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j2df0zYH"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7636C7482;
	Thu, 22 Feb 2024 05:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708579072; cv=none; b=RF1MlMuM97tIxbhEzqqEDIpWgz6fGRYUfERv82jNHOB4SvHUu1DAGRoNAqM03jWWVvJehQUurC6WKTZcOZs+qwfraAm4bMY93EuR0L9FEnhtxaBB5lJJ92BjeHpycDexcZXhh0cLl4qziLqE9VfTa9FeZ97Opa8M4rnUNVs2lKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708579072; c=relaxed/simple;
	bh=9gNhI/HsDtNamLxlDShpJ4poTz3S2AKFbaAKWidvA28=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=netaBGPsee9Ks3LXZrJ4n3diuY/agpIheWwByHxIYdijAXzzb7JBTH9AgsY+hZjVoWaYmef7RLHcaQ1omU3ME3mKcjIqnj3axQ4cfqU2OHeGmBkm0M6cKMJ++QV1tukJ8F38lvxm3+sNM+sNYB84UbwQNm2Q1kpuKZz74RZlSqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j2df0zYH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41M4R18H006546;
	Thu, 22 Feb 2024 05:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=K/2wCf7f7QyZDGdorAUOAQQO5+gbW6WWu/gqndqtKoo=;
 b=j2df0zYHchuygCjJA8VvcPJMD5NOOimHOizytE+BsJqendgmCw6liiefKOdO4Xk7oI8Q
 gLl8/2EYckkCCycaJE4Szarj0rlNtu6VXE6fglTkfAs+zC42vvveYZ5Apuzi56mjFD6n
 ht6Ro0ysut5PTMuIhaFaVfKZ+JUHSXg9FO3O7gjfj+HLyqSANQMqT/KDC7PpAcclPX+o
 rcrcpXnXQEEFtArWb/OOPEkml2HwlyEwP6j4+5u7Eu91Xrsu8cRJ71wOeNbqtRSl5DLa
 HMao4YJOoPUb06NpNWUX1AmnN0OKe1mGq5EkL7G7K2+NEqVVboq5N1SbaAjZvCo+cb79 VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wdy8g90us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 05:17:39 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41M5El9B013094;
	Thu, 22 Feb 2024 05:17:38 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wdy8g90tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 05:17:38 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41M3Yqmv031143;
	Thu, 22 Feb 2024 05:17:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9bm3my2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 05:17:36 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41M5HXgC65929482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 05:17:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 442CE2004E;
	Thu, 22 Feb 2024 05:17:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CF102004B;
	Thu, 22 Feb 2024 05:17:30 +0000 (GMT)
Received: from [9.203.115.195] (unknown [9.203.115.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Feb 2024 05:17:30 +0000 (GMT)
Message-ID: <3393a42f-d9b3-4031-bdef-78bb2ce758f1@linux.ibm.com>
Date: Thu, 22 Feb 2024 10:47:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] Split crash out from kexec and clean up related
 config items
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-s390@vger.kernel.org, Baoquan He <bhe@redhat.com>, piliu@redhat.com,
        linux-sh@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        ebiederm@xmission.com, loongarch@lists.linux.dev,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, viro@zeniv.linux.org.uk
References: <20240119145241.769622-1-bhe@redhat.com>
 <9101bb07-70f1-476c-bec9-ec67e9899744@linux.ibm.com>
 <Zb8D1ASrgX0qVm9z@MiWiFi-R3L-srv>
 <559f2595-1477-4ef0-80e4-85ae8b426de7@linux.ibm.com>
 <20240221125752.36fbfe9c307496313198b60f@linux-foundation.org>
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20240221125752.36fbfe9c307496313198b60f@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Uw-TiETYrrtmy9xa6nwhBWKWx0V7gLnU
X-Proofpoint-ORIG-GUID: pNdWEEFYaOYyVGnBPerBSEQApCC4_Zph
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
 definitions=2024-02-22_03,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220039



On 22/02/24 2:27 am, Andrew Morton wrote:
> On Wed, 21 Feb 2024 11:15:00 +0530 Hari Bathini <hbathini@linux.ibm.com> wrote:
> 
>> On 04/02/24 8:56 am, Baoquan He wrote:
>>>>> Hope Hari and Pingfan can help have a look, see if
>>>>> it's doable. Now, I make it either have both kexec and crash enabled, or
>>>>> disable both of them altogether.
>>>>
>>>> Sure. I will take a closer look...
>>> Thanks a lot. Please feel free to post patches to make that, or I can do
>>> it with your support or suggestion.
>>
>> Tested your changes and on top of these changes, came up with the below
>> changes to get it working for powerpc:
>>
>>   
>> https://lore.kernel.org/all/20240213113150.1148276-1-hbathini@linux.ibm.com/
> 
> So can we take it that you're OK with Baoquan's series as-is?

Hi Andrew,

If you mean

v3 (https://lore.kernel.org/all/20240124051254.67105-1-bhe@redhat.com/)
+
follow-up from Baoquan 
(https://lore.kernel.org/all/Zb8D1ASrgX0qVm9z@MiWiFi-R3L-srv/)

Yes.

My changes are based on top of the above patches..

Thanks
Hari

