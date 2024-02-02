Return-Path: <linux-kernel+bounces-50137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0638474BC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F80290532
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EFD148300;
	Fri,  2 Feb 2024 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U6EqOU/i"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7453D3BC;
	Fri,  2 Feb 2024 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891444; cv=none; b=NJG0qjFkCs4ujvlzuFNqE1AEURzKoPNau8Y5eJbxDfr8rPRW5UYc68WEhDMujWv8CNmA5OLI94sy4TMY59sHs3C+BSzmfkc1gvncUbjjbBHwnwuZId3LkqAs5JlE044y4thilVcfrtoJ6WbmCtLJ/uo9h6l05EC0zEQezHc1xfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891444; c=relaxed/simple;
	bh=LGIBqBjIQvtTgXrj/p0OJ2yHuL9JY/HDvcoae3CNWa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S07ApW0yi0EMIYdJ8Si7BqgXotHyxLpJKLnF7N/mP5IaBdoZNVC3Qfa9aNP5rXnnHg82/yd2FCN75s3KgwGYd6YtroUQcTthzmb3xP1pEMYewvVzJnwthV1CXIVOMgkhyD3pqKkmqFAuT5TX/QoFvehTUYpMV1EfioYIo0v7TN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U6EqOU/i; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412FoeJi009511;
	Fri, 2 Feb 2024 16:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Bvc08PyuVK+EXrEsLnwYXcm/2Anr57lMlLuuYmfanXQ=;
 b=U6EqOU/iHgA5r0EHZ5RqrmT/NGamw24ZmERHpYRBKAovaDgxaUGgGo6YUqebHokSjv+y
 b5UahIHPeSQKQso5ynhzGtA6yrI1xGTuBpX/TVyjBJ8zN3YOJ/7RjGLyYlBDrOyaSJSz
 xGMc8/R9pryqOlnaFwOTaTUudyvIIVUY9pwA35NsJdcawIeTy0HP8ATSk+M7rj7F1NuM
 ZsN4kbqxoVKjRRHjeRC6sVzq82QTVVFtZ4nGhNc0iIoJeT5S3RubgYHNydraoKors4G1
 7CONMGjyOJJOy0HZeNCp+Y99VAHGJrSa4uG1Bq9QKvb8tPwpg9ySGaHFVWXoevxRcnx/ 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w11egv968-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 16:30:29 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412GR06X030890;
	Fri, 2 Feb 2024 16:30:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w11egv95b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 16:30:28 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 412DwHVf010887;
	Fri, 2 Feb 2024 16:30:27 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwecm43ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 16:30:27 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 412GUQIH23593634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Feb 2024 16:30:26 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4737758058;
	Fri,  2 Feb 2024 16:30:26 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D9875805E;
	Fri,  2 Feb 2024 16:30:25 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Feb 2024 16:30:25 +0000 (GMT)
Message-ID: <d00e0b2f-7cd8-48d9-aac9-2463af3e3c24@linux.ibm.com>
Date: Fri, 2 Feb 2024 11:30:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] evm: Use the real inode's metadata to calculate
 metadata hash
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, roberto.sassu@huawei.com, miklos@szeredi.hu
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
 <38230b4c-54ae-45ed-a6fb-34e63501e5b1@linux.ibm.com>
 <CAOQ4uxiYARZBSgzb4_W-RKvB1XLSF3GUBqeLw2kH+eVeZ_8ARQ@mail.gmail.com>
 <c018b014-9ba8-4395-86dc-b61346ab20a8@linux.ibm.com>
 <CAOQ4uxi6Te8izWpXROthknRaXrVA9jho5nbc+mkuQDrcTLY44Q@mail.gmail.com>
 <CAOQ4uxigdNeE+2nfr4VxS9piQf5hez=ryT0a-jzW+tW0BT-zuw@mail.gmail.com>
 <492ea12a-d79d-47da-9bbe-a7f33051bd3f@linux.ibm.com>
 <CAOQ4uxgiO1RbsmqOu4F4Foy-MBPecnEXO7BvgDGz-Lzb1Eysog@mail.gmail.com>
 <4c584bfb-d282-4584-bb20-18c26b1033c0@linux.ibm.com>
 <CAOQ4uxjftr7GGx6tuW_yB_MTaVB57m6p_d=UHhN3Z23YVXY0QQ@mail.gmail.com>
 <11abffea-15c5-4d13-9d0f-edbc54b09bf3@linux.ibm.com>
 <CAOQ4uxjZ6p9+H54G0LNTUnU56WRaoLtWOUj2nOaKJ4JvBGqLVg@mail.gmail.com>
 <427ce381-73fa-48f9-8e18-77e23813b918@linux.ibm.com>
 <CAOQ4uxggqa7j0NS1MN3KSvF_qG1FMVmFxacEYSTx+LuvuosJ5g@mail.gmail.com>
 <4ce0e20d-ed14-490d-9446-a6cfbd532bca@linux.ibm.com>
 <CAOQ4uxhkyh19rMXnZ+Ou-Z0DgraBJAvL53K_PK9zRUB2O-Lsqw@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAOQ4uxhkyh19rMXnZ+Ou-Z0DgraBJAvL53K_PK9zRUB2O-Lsqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uBSTZiZ5B46Geg70rrd9NYj5YaWuEnt1
X-Proofpoint-ORIG-GUID: Hd-VM9MjN1kJ2smJ9B1wx_2Y2zLY97dE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=528 phishscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402020119



On 2/2/24 11:17, Amir Goldstein wrote:
>> The odd thing is my updated test case '2' seems to indicate that
>> everything already works as expected with CONFIG_OVERLAY_FS_METACOPY=y.
>> After causing copy-up of metadata changes to the file content on the
>> lower layer still cause permission error to file execution on the
>> overlay layer and after restoring the file content on the lower the file
>> on the overlay again runs as expected. The file content change + copy-up
>> of file content also has completely decoupled the lower file from the
>> file on the overlay and changes to the file on the lower cause no more
>> file execution rejections on the overlay.
>>
> 
> Sorry, you lost me.
> The combination of IMA+EVM+OVL must be too complicated to
> explain in plain language without an explicit test spelled out...
> 
> When you write "The file content change + copy-up of file content also
> has completely decoupled the lower file from the file on the overlay",
> what do you mean by "copy up of the file content"?
> Why was the file content copied up?

The file was copied up by appending a byte to the file on the 'overlay'.

> I was asking about use case that only metadata was copied up but
> lower file content, which is still the content of the ovl file was changed
> underneath ovl - this case does not cause data content to be copied up.
> 
> I don't think we understand each other.

One of the test cases I also have is appending a byte to the file on the
'lower'. At this point in the test one can detect whether 
CONFIG_OVERLAY_FS_METACOPY is enabled by checking the sha1 of the files 
on the lower and overlay layers and comparing their hashes. If they are 
equal then CONFIG_OVERLAY_FS_METACOPY is enabled since previously in the 
test file metadata on the overlay layer was already changed, which in 
the CONFIG_OVERLAY_FS_METACOPY=y case only caused a copy-up of metadata.
So, when trying to execute the file on the overlay layer the file cannot 
be executed due to the file content change on the lower layer (IMA 
should be the one detecting this, need to check) still 'shining 
through'. After restoring the file content on the lower layer the file 
again executes on the 'overlay' layer - as expected.

    Stefan


> 
> Thanks,
> Amir.

