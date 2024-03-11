Return-Path: <linux-kernel+bounces-99153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6959878422
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7BFC1C21877
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C1E44C60;
	Mon, 11 Mar 2024 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nAg2e2qg"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4658047F42;
	Mon, 11 Mar 2024 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172094; cv=none; b=VI/P9MY/CgcQEvHlGChNo58t1McDTA3AjB3+dl4P+BgJKdnwHvNdMJMrqWmAlay2MKgAeOXjo8uatwojINKcuY1Wxd2AcUGEbihGzbBeUyv8V71IsImRiRu8CjbCTlj9MB9zMPJFXXvPxijegUFNvLlEqe51lYQWKtyw4RvU1Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172094; c=relaxed/simple;
	bh=yr71qQXj1xpkj19eRzbaCz5p3dRwUcj2g1qzbV3vFa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkyZPQHSFRkaBxLM96drE+bIaSqFjBhc1oXGmtpTE49jjrkJiikri5FBe2UTkvQj2aMcdNYhpXpDLwq2adQQBVLqpsMWaf/QOKWlUtP7OHB9RJ3bW2FDe8zEGkaDSmySDTTD0XaQexZxIjyKNIAQ6bWQKvYApGEJ9xrie8Rhw+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nAg2e2qg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BFhlEj007572;
	Mon, 11 Mar 2024 15:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GpM9B25vZbrg9rfM6xzk5f114CmAW/JBoG6AuiM4D3U=;
 b=nAg2e2qg+/5tqlQG2b/rXvxUSu26IJ4WAkMlMfA84bhLUJ2rFLRLqL1l7uOgrTUG0nxn
 GQNgBr1xZV9GyoqhqWau2W5K7JjUvux+XIwV+QcALRs5h8lgPnrKa1N2y27SXRjNxYpL
 IPXDEjeDx0J6Yl3jSQ2BAQWV6x+9nBpYDtNxlBQxBEVIxqq1YWjMXY2CRtsNKXCFP1/Q
 wn8CzR6Q54ilUHHj8aXfeWrQXwUM2vnwsP2qScK8IjhHS5w71wjaHeIaLvFIHY4OgTyA
 padjp2hjMraqHb/SXXHYPAPvgEfBjfhgOLXMdtN8QAisN4RXkaN8vkp9GerzBytSCCHN HQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt4us030r-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 15:48:10 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42BDwNPN014931;
	Mon, 11 Mar 2024 15:27:57 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws33nh9k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 15:27:57 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42BFRs5714549520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 15:27:56 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A85D5806A;
	Mon, 11 Mar 2024 15:27:54 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0BA758067;
	Mon, 11 Mar 2024 15:27:53 +0000 (GMT)
Received: from [9.61.27.161] (unknown [9.61.27.161])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Mar 2024 15:27:53 +0000 (GMT)
Message-ID: <78d085ac-3759-46ff-be75-f8c70604ac41@linux.ibm.com>
Date: Mon, 11 Mar 2024 11:27:53 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] s390/vfio-ap: Ignore duplicate link requests in
 vfio_ap_mdev_link_queue
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com
References: <20240306140843.10782-1-jjherne@linux.ibm.com>
 <20240306140843.10782-4-jjherne@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20240306140843.10782-4-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r4pNY4hs7yfW8pfv9QjdT1cuhNoBF8MP
X-Proofpoint-GUID: r4pNY4hs7yfW8pfv9QjdT1cuhNoBF8MP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 clxscore=1011 suspectscore=0 adultscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403110118

While I don't necessarily object to this change, it is not necessary 
because this function is only called in situations where the link will 
not have been made:

* When an adapter or domain is assigned to the vfio_ap mdev, in which 
case no queue with the APID of the adaper or the APQI of the domain will 
have been linked.

* When a queue device is probed, in which case the vfio_ap_queue object 
is created and linked if the its APQN is assigned to the vfio_ap mdev.

In any case, it certainly doesn't hurt and if a future change is made 
such that this could come into play, the code is already there. So I'll 
leave it up to you if you want to keep this; if so, you already have my r-b.

On 3/6/24 9:08 AM, Jason J. Herne wrote:
> vfio_ap_mdev_link_queue is changed to detect if a matrix_mdev has
> already linked the given queue. If so, it bails out.
>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index b1c1dc0233e1..259130347d00 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -781,10 +781,11 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
>   static void vfio_ap_mdev_link_queue(struct ap_matrix_mdev *matrix_mdev,
>   				    struct vfio_ap_queue *q)
>   {
> -	if (q) {
> -		q->matrix_mdev = matrix_mdev;
> -		hash_add(matrix_mdev->qtable.queues, &q->mdev_qnode, q->apqn);
> -	}
> +	if (!q || vfio_ap_mdev_get_queue(matrix_mdev, q->apqn))
> +		return;
> +
> +	q->matrix_mdev = matrix_mdev;
> +	hash_add(matrix_mdev->qtable.queues, &q->mdev_qnode, q->apqn);
>   }
>   
>   static void vfio_ap_mdev_link_apqn(struct ap_matrix_mdev *matrix_mdev, int apqn)

