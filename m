Return-Path: <linux-kernel+bounces-29071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC818307DB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A61328225E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB64208C2;
	Wed, 17 Jan 2024 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FRdm0ayC"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5300C208B8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705501178; cv=none; b=poGQb4FI+oB9eNSvPjMMNCDP+8mnwqZdquKjN2hL1Sem5r7lyJ7+04CPhtWH9Bn1L3kV7uYGSH/u4TyXRmRquOcgRwq/eEEkAD8BzzYhUWijewTle98HrMVUb/4rls7cIwnuYxi8gz8SXYO9AT+CTEMYXixIve9xrg9eT0Xi3bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705501178; c=relaxed/simple;
	bh=xvGRwofJ9FLhkICF1UisUVH5nuawerQt5n/rNkyxhGs=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=ORqP61YXR2YTGLkwsHzxqXZaV+DDQpgusdAF47WfJsK0t+hRwpSulH5+B91YG4ZdbshbI6tXrrA+3D1kw9PcyhkSAy918XABi7pIIqqBE4E1ByJA9Kw1dcoD3w+w48xMmMksedtH2G+VbbP5jIeaxpEZRG+Cjt/Kuz2HzfllipQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FRdm0ayC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HE7C57019056;
	Wed, 17 Jan 2024 14:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cNbvoiqS8w0scbvnLRDQpG0cov+XbTeBinloJliNiC8=;
 b=FRdm0ayClvb2PYWCnt4uaTJq0Ux2UDKPGhDrkt5g6Ni4K0Pu/nl2QUkXNJZmN9iRhseT
 k2s1wZt3ta3z/XwWQL/KzmEzZ8clYbwXuflqx5XI/psy+/vlFuA1kKta/mFwsD5E3i7S
 8XQpmDMfuis1rhRQyoQUDSLY565vgpzrjlSB9g59SNxPsd7vPZ4LH1uquMKRf3TihHPR
 no5vr6e7rxj9HND3/FB2kb3e9TQpQygoo/genNaZ0gNR8j7ZnB9OLqGZ6Jem9p37CD8k
 FGDho2PmsDgakHbpC5VDpo/sYd0SW0CZJ0YVjxEvY7kfxOcqoajqbdIszgHhZxlf1myh TA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpgcj0ef3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 14:19:22 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40HBJmeZ005408;
	Wed, 17 Jan 2024 14:19:22 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm7j1w8xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 14:19:22 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40HEJLbO35586686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 14:19:21 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 868F458065;
	Wed, 17 Jan 2024 14:19:21 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D51658056;
	Wed, 17 Jan 2024 14:19:21 +0000 (GMT)
Received: from [9.61.121.203] (unknown [9.61.121.203])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jan 2024 14:19:21 +0000 (GMT)
Message-ID: <9f10bb00-170f-4647-9c7d-8033dae2a4c7@linux.ibm.com>
Date: Wed, 17 Jan 2024 08:19:21 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/42] drivers/fsi: Convert snprintf to sysfs_emit
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kernel@vger.kernel.org
Cc: Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>, linux-fsi@lists.ozlabs.org
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-6-lizhijian@fujitsu.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20240116045151.3940401-6-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: otbBxARvRJoP1cBTjyu5dwjJAZLGdtwr
X-Proofpoint-GUID: otbBxARvRJoP1cBTjyu5dwjJAZLGdtwr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 impostorscore=0 mlxlogscore=813 adultscore=0
 mlxscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401170103


On 1/15/24 22:51, Li Zhijian wrote:
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
>
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
>
>> ./drivers/fsi/fsi-master-ast-cf.c:1086:8-16: WARNING: please use sysfs_emit
>> ./drivers/fsi/fsi-master-gpio.c:721:8-16: WARNING: please use sysfs_emit
> No functional change intended


Thanks!


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> CC: Jeremy Kerr <jk@ozlabs.org>
> CC: Joel Stanley <joel@jms.id.au>
> CC: Alistar Popple <alistair@popple.id.au>
> CC: Eddie James <eajames@linux.ibm.com>
> CC: linux-fsi@lists.ozlabs.org
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   drivers/fsi/fsi-master-ast-cf.c | 3 +--
>   drivers/fsi/fsi-master-gpio.c   | 3 +--
>   2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
> index 812dfa9a9140..5740b2d9dace 100644
> --- a/drivers/fsi/fsi-master-ast-cf.c
> +++ b/drivers/fsi/fsi-master-ast-cf.c
> @@ -1083,8 +1083,7 @@ static ssize_t external_mode_show(struct device *dev,
>   {
>   	struct fsi_master_acf *master = dev_get_drvdata(dev);
>   
> -	return snprintf(buf, PAGE_SIZE - 1, "%u\n",
> -			master->external_mode ? 1 : 0);
> +	return sysfs_emit(buf, "%u\n", master->external_mode ? 1 : 0);
>   }
>   
>   static ssize_t external_mode_store(struct device *dev,
> diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
> index ed03da4f2447..286fe1cddf99 100644
> --- a/drivers/fsi/fsi-master-gpio.c
> +++ b/drivers/fsi/fsi-master-gpio.c
> @@ -718,8 +718,7 @@ static ssize_t external_mode_show(struct device *dev,
>   {
>   	struct fsi_master_gpio *master = dev_get_drvdata(dev);
>   
> -	return snprintf(buf, PAGE_SIZE - 1, "%u\n",
> -			master->external_mode ? 1 : 0);
> +	return sysfs_emit(buf, "%u\n", master->external_mode ? 1 : 0);
>   }
>   
>   static ssize_t external_mode_store(struct device *dev,

