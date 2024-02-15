Return-Path: <linux-kernel+bounces-66427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D62855CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2D21B2FFD6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26129134CA;
	Thu, 15 Feb 2024 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ImEJ3zz0"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950B312B7C;
	Thu, 15 Feb 2024 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986149; cv=none; b=Pe34JytdlXjYAa59i5m+SzjiQMjAMpVH5FqG0/w1L+d6IfAkKTQDe3UWxqDSvS3ujYPCzbEehvw/ED16EfwUrc17MF82A/c0qfoc1l8z6XxQJKVDAqfdAcjZL8uVg9f72i1LrkPTb/ih1l+lrj/9cd8Dj9fj2fQAWX9kEMfQ9LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986149; c=relaxed/simple;
	bh=FhFRsdnjiIq6sjb+TJlazH/LxV6WTSCnRl8GCpI2gTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OKnqgLA5un6rBtTaRIkAM4pRxDgrRereLOdTNYOlOgCSGmBT0qB9292bfznFuS4jyTPre/wFBm9+kPMhooL+PZpA5xLtU7VezPv4nsfFo/x64UJOddX72ySxbiAi4j4Z+2FQOnMlG4wfa8EsNEWF+QH1Sjtm3lITDB5xHcqaZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ImEJ3zz0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41F7X8ES008393;
	Thu, 15 Feb 2024 08:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8vUYrjsku4Wxx92le0TgU8L8Gm2U7l/97SGNJHzGThY=;
 b=ImEJ3zz0udDpnz/XprPjZctP5Ik0OSGdAE1JxQK58tfXcKv4hTvbM6KMZmRCM/6Dduv2
 jDjz+oPvnrZBDkNOQnSpctDTV1FkTlZt/A1O6i0bdrCsQ/2pTu5eUNDf0j/7G4xdLpJr
 2w3cCeDwMk3jB8RM9dx2sBI0QZX8WAzkTu0MQflui19FpedGZi+Y8kepB2echMMZsDSz
 BKLZ676ddhpcJmFz7Zs4bsRn11WTe6NQkx5OiExXX9vbvhmCi24ZdrWzVsl0XuMD0q9P
 JpA1E2kffSp5/j15GoJI93sqbYyaw5Fj3yfubQfRg+Ibvco38Dp7m7YN+bYoeUteg3er Lw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9eapsj4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 08:35:46 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41F6NdPK009896;
	Thu, 15 Feb 2024 08:30:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npm34wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 08:30:45 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41F8Udrw36700636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 08:30:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5C5C2004E;
	Thu, 15 Feb 2024 08:30:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 987DB20063;
	Thu, 15 Feb 2024 08:30:39 +0000 (GMT)
Received: from [9.155.206.240] (unknown [9.155.206.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Feb 2024 08:30:39 +0000 (GMT)
Message-ID: <9b93b9c0-4b0f-4654-b9e6-4fc045cb6817@linux.ibm.com>
Date: Thu, 15 Feb 2024 09:30:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/iucv: fix the allocation size of iucv_path_table
 array
Content-Language: en-US
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240214163240.2537189-1-agordeev@linux.ibm.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20240214163240.2537189-1-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CNnHr_4rpEWXkhzxgecqzKTJh15Axrt7
X-Proofpoint-ORIG-GUID: CNnHr_4rpEWXkhzxgecqzKTJh15Axrt7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_08,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=925 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150066



On 14.02.24 17:32, Alexander Gordeev wrote:
> iucv_path_table is a dynamically allocated array of pointers to
> struct iucv_path items. Yet, its size is calculated as if it was
> an array of struct iucv_path items.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  net/iucv/iucv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
> index 9e62783e6acb..5b56ae6612dd 100644
> --- a/net/iucv/iucv.c
> +++ b/net/iucv/iucv.c
> @@ -156,7 +156,7 @@ static char iucv_error_pathid[16] = "INVALID PATHID";
>  static LIST_HEAD(iucv_handler_list);
>  
>  /*
> - * iucv_path_table: an array of iucv_path structures.
> + * iucv_path_table: array of pointers to iucv_path structures.
>   */
>  static struct iucv_path **iucv_path_table;
>  static unsigned long iucv_max_pathid;
> @@ -545,7 +545,7 @@ static int iucv_enable(void)
>  
>  	cpus_read_lock();
>  	rc = -ENOMEM;
> -	alloc_size = iucv_max_pathid * sizeof(struct iucv_path);
> +	alloc_size = iucv_max_pathid * sizeof(*iucv_path_table);
>  	iucv_path_table = kzalloc(alloc_size, GFP_KERNEL);
>  	if (!iucv_path_table)
>  		goto out;


Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>

Good catch, thank you.
As we allocate a more than we need, I don't this
needs to be backported to stable. Do you agree?

