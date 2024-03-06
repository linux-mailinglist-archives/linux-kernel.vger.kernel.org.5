Return-Path: <linux-kernel+bounces-94071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C60B873965
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD9BB24355
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621DC132C0C;
	Wed,  6 Mar 2024 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sl0U1iK5"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C1D7FBBD;
	Wed,  6 Mar 2024 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735949; cv=none; b=m9/MXVVOCoyG1kgTzmKYC42DzuooUqwPaEJOvWGqzghs+tfTJGjjitRL8v8EtoF/zIyRrxYaCGPsNcehomexQ/0X4L5NK/Mxnz3XD1bzZ98uEvlMY3+S/Jeod3MPhDPZY17cXeRF0Z5Ih+iTTCR0qOGveSxev4DOX8mnSEnO6AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735949; c=relaxed/simple;
	bh=TPXOQUmUeHxl7oQDhtktwNd3Ve4obevUj/1Tcxd18cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgihwNg8MREo/NITdTCy40vQrizHce/owZ1S9DW4o1TlwEbpB3KPrqlYwWuULiRM6oSGNoMtLvH9ru1k3tRf7mqmyvZLASoS5I7GsbODaGi0Z/nJFv1BdJy4KGCDT85S33JuPUf2svRVqXOH8VGr7RJN3nEqp/oadWXGeFnz7Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sl0U1iK5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426EVCXG027065;
	Wed, 6 Mar 2024 14:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TPXOQUmUeHxl7oQDhtktwNd3Ve4obevUj/1Tcxd18cw=;
 b=Sl0U1iK5DchM+L0sQBsXETPRrmwwyblRNxykvHSuBIhLu3QM5gKUhN3sp+Vm93wBYWv/
 vTsaSy0WJSF4rCKk9rZfHrBlVsYf7fClsWYjINlnUy0/qrup8hhlpjv3JL2BZOClN/Mn
 pm7EIm0kj63u7kxr4Uor08kqFxltDSaiEwW+7/qBhVxlm5JeHxXgqk9BQFjeYDjKzIUS
 3MwWdGrLyOvN/FGDR1wwiKKNHTrxo+ifd+DVc3sOZG/ci05rqZQy8BtJXaS+5j+9cgjL
 pnb5Ou86szXD1p8oCbNq/yyjo/n927WapCtYl2Q7F6FG6zWY2VSM42EoCVb3umbjY0TW yQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpsw293d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:39:07 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426C8Inr025376;
	Wed, 6 Mar 2024 14:39:04 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmetyqd5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:39:04 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426Ed1Bp43843884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 14:39:03 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58ED058058;
	Wed,  6 Mar 2024 14:39:01 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F7FD58062;
	Wed,  6 Mar 2024 14:39:00 +0000 (GMT)
Received: from [9.61.98.245] (unknown [9.61.98.245])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 14:39:00 +0000 (GMT)
Message-ID: <ad53ac0b-196a-4fb7-a8e1-f015d3f7c71c@linux.ibm.com>
Date: Wed, 6 Mar 2024 09:39:00 -0500
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
X-Proofpoint-ORIG-GUID: cZXOijmTEEh3lFeDCKM_P1V_FlIw2b1u
X-Proofpoint-GUID: cZXOijmTEEh3lFeDCKM_P1V_FlIw2b1u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_09,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=844
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403060117

On 3/6/24 9:08 AM, Jason J. Herne wrote:
> Mdevctl requires a way to atomically query and atomically update a vfio-ap
> mdev's current state. This patch set creates the queue_configuration sysfs

Less important than the patches themselves, but s/queue_configuration/ap_config/ here as well as title of cover letter.



