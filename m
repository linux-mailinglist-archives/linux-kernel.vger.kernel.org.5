Return-Path: <linux-kernel+bounces-52903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574ED849E10
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043D01F243A1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6729A2E412;
	Mon,  5 Feb 2024 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T2tYEun/"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFCE32C93;
	Mon,  5 Feb 2024 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146792; cv=none; b=KlgYdwV91soptMMjcKk1EPoGUJN53zjAv1vZAiwy2W6JPBN3EGvsShMY//LumpMG4GjGqq3Ur7qTI3+G2NF/V5KK+b+BE/J2uEVqdvs1jHZ4biWvmKtfHEptdc9WUiNSlTblKN+Ph6Z0Bj36BThITQ3D5zy+++ljO2CaqA2kcn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146792; c=relaxed/simple;
	bh=JTF1omHdVzlrSpJbM8cF1ZTLKPhF3C31MBXg1kBP7zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrLTLTS0a2eKXCrbMUXdZ2ELBHeGBfbIn+2P5+LXgSdpMShsKp6da25QRGYKxfh6vF+6Q5ijW2QJEJp5F0y3GB7Iw9CGLo2tGdC1M7/SvySmACxHmNSru6O1eyCJOjbbUsocS+LMRKbsieLp5EpST6P8LSmYcLC/BifsFcW1aB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T2tYEun/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415E3BgT013710;
	Mon, 5 Feb 2024 15:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hddv5MfQH4jC8cEuMLV7AaQ1Jb3YJMSMkCMdyXjqXRs=;
 b=T2tYEun/9A2vnvKWdPgfdNdHy8Fa7QHj0L7Mg8j4QmZIoqA+nUu2+a34aS2vL0vRoKxq
 lvrJDtu/h2aLMPjh53XPOHEP32qsYJj2dhfX83hmIxRIoatrmsiaLJby+5mI4oZUhGUA
 K/tMGoS526hPc/+4XswRIrlcrWfw79eTY8pvVMFnOv1kdtfwkPhMESgNVdI0Tdjq8UFo
 Vw/XbRsF82rmU3oVl0JB6a4Mv27I6DPzc1KAq7h9gyJ4wQ5YUYoyddSZutSXi/n3fDsm
 rXw/Nrv/czDUdKWLzldE4SpszdwIUTm666R+ufxRj+GbPnukA+rslgczwuztEnyctA9K nw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w313mtnm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 15:26:20 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415DlVni014778;
	Mon, 5 Feb 2024 15:23:09 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20tnh79t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 15:23:09 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415FN7VO62652802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 15:23:08 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D22AF58054;
	Mon,  5 Feb 2024 15:23:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B07C5805C;
	Mon,  5 Feb 2024 15:23:06 +0000 (GMT)
Received: from [9.61.84.204] (unknown [9.61.84.204])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Feb 2024 15:23:06 +0000 (GMT)
Message-ID: <40a56c8d-d519-47a8-b7b6-29339fad1cb4@linux.ibm.com>
Date: Mon, 5 Feb 2024 10:23:00 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] s390: vfio-ap: make matrix_bus const
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240203-bus_cleanup-s390-v1-0-ac891afc7282@marliere.net>
 <20240203-bus_cleanup-s390-v1-6-ac891afc7282@marliere.net>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20240203-bus_cleanup-s390-v1-6-ac891afc7282@marliere.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eIFZQ42wOlOn41CU1060WfzhQOCdfSLK
X-Proofpoint-ORIG-GUID: eIFZQ42wOlOn41CU1060WfzhQOCdfSLK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_09,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050116

Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>

On 2/3/24 9:58 AM, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the matrix_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>   drivers/s390/crypto/vfio_ap_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index a5ab03e42ff1..4aeb3e1213c7 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -60,7 +60,7 @@ static void vfio_ap_matrix_dev_release(struct device *dev)
>   	kfree(matrix_dev);
>   }
>   
> -static struct bus_type matrix_bus = {
> +static const struct bus_type matrix_bus = {
>   	.name = "matrix",
>   };
>   
>

