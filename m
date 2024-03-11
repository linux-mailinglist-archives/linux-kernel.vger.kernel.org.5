Return-Path: <linux-kernel+bounces-99354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D8087872A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29976B21090
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC6A53E12;
	Mon, 11 Mar 2024 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lOkZkdr3"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF3F51C44;
	Mon, 11 Mar 2024 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710181260; cv=none; b=Gv6z9kLq5703iEaeog2j6hBs3a7YjG8oqwnORIyyadHmUhteqXFDq2vku8fP/BpBKC3JC5t9hZZ/UvOv2+S2QDHeSNIM3TgyM3D7CrvLgeZRur57CqnsttCaLL6ocrHdHa0Gd+NETkG5F6BZD6Jux3+7y8BHVqtt4O9kd+v9PLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710181260; c=relaxed/simple;
	bh=NQQvqKzPU8v8dTdFW/yg3BWpbucbVKrL6/83G+86T+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBioEsrPBrNLwL8x1ykLfhKt+tDT1IlN84yYp0sWA0SxtbmXTIR2srUZUGvwt6429zOK81/q7VEfksyDhGMbfpUWRpJ/aYyeE16uEVTqT96K4u39Z4BOu0L8mlrgEGKe8con0C0dRhTx0mRTjf6SuoClgZQdUL+C1KruXXW/3Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lOkZkdr3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BGhPP4023998;
	Mon, 11 Mar 2024 18:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bqtNjjrY09WFPvm4l2cpnXrSAK6us97T3iOoYmqP4TI=;
 b=lOkZkdr3BbaMZGMpTCBgLIERLJFYOv6wZFKz82MvFirXxNXVRsYYpQCxjWEHWRlaDJlb
 6drWekd3XSXu5Bm3HrR/VEPS4UrJsSmN3PfMkhHlo2dmWh/85vO4lr2X4Y7euvypLLpN
 au1AMVo+rfAM6SZwX1RlppJ9frEz6WXruCyWstsFv8iEe4qMOHi7T//rtyKYGItBxuSh
 B9OSjzbkiufVPjGwr4Pet4wKjDraVfr2w8tfaLc5xxWMSzXG2PZH/4VZgfRBWZZ3LkW3
 8nhrFP2jeT6tHE6VLVypeQ6zKn2POM9sEQVmnjzYuiN8knDSZT0jBGkZ8y+0fUX/Yg9u pg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt5qp2001-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 18:20:55 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42BI6G7g018119;
	Mon, 11 Mar 2024 18:20:55 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws23t2g0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 18:20:55 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42BIKqns24183120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 18:20:54 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B2775806B;
	Mon, 11 Mar 2024 18:20:52 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7076858052;
	Mon, 11 Mar 2024 18:20:51 +0000 (GMT)
Received: from [9.61.27.161] (unknown [9.61.27.161])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Mar 2024 18:20:51 +0000 (GMT)
Message-ID: <502b97e4-8ed4-402b-a025-3d023cae5a71@linux.ibm.com>
Date: Mon, 11 Mar 2024 14:20:50 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] s390: doc: Update doc
Content-Language: en-US
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com
References: <20240306140843.10782-1-jjherne@linux.ibm.com>
 <20240306140843.10782-6-jjherne@linux.ibm.com>
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20240306140843.10782-6-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b4FuQatNi3XvB8e1qKUdCS59FCMyL7hI
X-Proofpoint-ORIG-GUID: b4FuQatNi3XvB8e1qKUdCS59FCMyL7hI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110139


On 3/6/24 9:08 AM, Jason J. Herne wrote:
> fix me
>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>   Documentation/arch/s390/vfio-ap.rst | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s390/vfio-ap.rst
> index 929ee1c1c940..af5ef60355a2 100644
> --- a/Documentation/arch/s390/vfio-ap.rst
> +++ b/Documentation/arch/s390/vfio-ap.rst
> @@ -380,6 +380,33 @@ matrix device.
>       control_domains:
>         A read-only file for displaying the control domain numbers assigned to the
>         vfio_ap mediated device.
> +    ap_config:
> +        A read/write file that, when written to, allows the entire vfio_ap mediated
> +        device's ap configuration to be replaced in one shot. Three masks are given,
> +        one for adapters, one for domains, and one for control domains. If the
> +        given state cannot be set, then no changes are made to the vfio-ap
> +        mediated device.
> +
> +        The format of the data written to ap_config is as follows:
> +        {amask},{dmask},{cmask}\n
> +
> +        \n is a newline character.
> +
> +        amask, dmask, and cmask are masks identifying which adapters, domains,
> +        and control domains should be assigned to the mediated device.
> +
> +        The format of a mask is as follows:
> +        0xNN..NN
> +
> +        Where NN..NN is 64 hexadecimal characters representing a 256-bit value.
> +        The leftmost (highest order) bit represents adapter/domain 0.


Same comment I made in patch 4/5:

I won't reject giving an r-b for the above, but could be more 
informative; maybe more along the lines of how this is described in all 
documentation:


Where NN..NN is 64 hexadecimal characters comprising a bitmap containing 
256 bits. Each bit, from left

to right, corresponds to a number from 0 to 255. If a bit is set, the

corresponding adapter, domain or control domain is assigned to the 
vfio_ap mdev.

You could also mention that setting an adapter or domain number greater 
than the maximum allowed for

for the system will result in an error.


> +
> +        For an example set of masks that represent your mdev's current
> +        configuration, simply cat ap_config.
> +
> +        This attribute is intended to be used by automation. End users would be
> +        better served using the respective assign/unassign attributes for
> +        adapters, domains, and control domains.
>   
>   * functions:
>   

