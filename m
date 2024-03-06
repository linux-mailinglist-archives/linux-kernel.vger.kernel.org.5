Return-Path: <linux-kernel+bounces-94629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E57B874260
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F76DB21EE9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22F31B952;
	Wed,  6 Mar 2024 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aewsjAK6"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A801B941;
	Wed,  6 Mar 2024 22:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762773; cv=none; b=MXqQxUGssCPgGx4V6XYjfwfBlKwI+SPAHvglSaqbKjXDKMrWPUR+Y7oHFzI+GO8uEz0MKy8DvZkRe1SK29RF9L8oSfU5ygJRPGr1F1CSjAvwrCDxZZ97Fvyq0eLQPF8iUDJ40HybMM04zumdRBITuPWibpXUmyq4rCQ8YGicWRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762773; c=relaxed/simple;
	bh=Q6nI/N7wvS+IJoI8zvSoef/iw9QQBEP/19WRjTvAfQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JzPAiBThDInxIEAO8ZrUgiqfl32w7eQOy+FfZ8hoFXOr/m2jyieEN2d5d5JBPhnCDOvqHM8bEicW1HLpb4rK8YMjkAsj6zbyyj5/f3L+sNLoEZyhhXIR7wabOgutsunftn2VNkwiohZJPg4dVkuVbaVdVpB7iFClcizRJhmkzLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aewsjAK6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426LvMYv000406;
	Wed, 6 Mar 2024 22:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NrYxsIOwkjk9D5Paw8HS8ZbIfu/sTVLwflepMjYx1PU=;
 b=aewsjAK6KhC43FSuWfhlosY068aT54XcXZIH8VgEu4uOCzOEcnUG9E7vxYXih5ZvnEz4
 4SS7BnbgPhjNnny5vPgrwd8w8L3ZmmNn6jFj+5kmmUTp4cDfL+Uqn3q5asowbkWteKQy
 rumb9NYYfhuX7PSjFIXwxImz35SnETNOnn5lMb9QJv44yujZGXsrSkEwg3CiMv7yaqIX
 mYb+GqzFWIbbAW9O3hO7IX3f6U94qCp91e+XdKN8jx9lVXDr/SB5KdYTfzCKtL9+hg9h
 gV7yl3C+CwIQ+q2SpPehih09Tqvm34F4l2gQ34TZWtJ9pIcMEYQ8ZD2PJ+m9JabINHWt SA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wq0utr47n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:06:07 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426K3e1J031560;
	Wed, 6 Mar 2024 22:02:41 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmgnk97kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:02:41 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426M2cjx28508568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 22:02:40 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 637C35806B;
	Wed,  6 Mar 2024 22:02:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B78435805D;
	Wed,  6 Mar 2024 22:02:37 +0000 (GMT)
Received: from [9.61.98.245] (unknown [9.61.98.245])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 22:02:37 +0000 (GMT)
Message-ID: <6d8656b0-91ab-49e7-9321-30367052f083@linux.ibm.com>
Date: Wed, 6 Mar 2024 17:02:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] s390/vfio-ap: queue_configuration sysfs attribute
 for mdevctl automation
Content-Language: en-US
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
References: <20240306140843.10782-1-jjherne@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20240306140843.10782-1-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zbCD7jB1_OXe1Qi7FOjOOWHz-3DEIC-o
X-Proofpoint-ORIG-GUID: zbCD7jB1_OXe1Qi7FOjOOWHz-3DEIC-o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403060178

On 3/6/24 9:08 AM, Jason J. Herne wrote:
> Mdevctl requires a way to atomically query and atomically update a vfio-ap
> mdev's current state. This patch set creates the queue_configuration sysfs
> attribute.  This new attribute allows reading and writing an mdev's entire
> state in one go. If a newly written state is invalid for any reason the entire
> state is rejected and the target mdev remains unchanged.
> 
> Changelog
> ==========
> v2
>   - Rebased patched on top of latest master
>   - Reworked code to fit changes introduced by f848cba767e59
>       s390/vfio-ap: reset queues filtered from the guest's AP config
>   - Moved docs changes to separate patch

Tested exploitation of the new sysfs interface using proposed s390-tools code + mdevctl.  Besides the other minor changes mentioned separately, feel free to include

Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>

for the code patches.


