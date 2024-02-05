Return-Path: <linux-kernel+bounces-52431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9A1849806
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22CE8B2203D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E4117584;
	Mon,  5 Feb 2024 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YRY6/qA5"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915FC17580;
	Mon,  5 Feb 2024 10:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707130091; cv=none; b=mxFi7OJaZ7Yy6P6PEN9g/CwJiXewKyNnibc9CEtGgwqYTDjl/JIxk3Pr7qp1s+wuVkEO5DwEHubAe4NN3nxiYBzBPS0dXAoilcrdkigaenNdoO2yigedbnDagZJz+gFvHIK/f4ioxeY3LYbfFiCNL6MqYnOpzXTvv69/T24S47E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707130091; c=relaxed/simple;
	bh=zgdRXtCQVgt2Or41jbGbqOJrId8F/mOhYFJZ0vVkfxs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pQxf18H9j7BCMECJDrlcO4FDwhicmeKIhnwiPDgQLXy+NzEs99WEZDb23dOq2dUi08SkH26uywWwyAQomsWo8uAxY4IbahlcNROxIS+Zo7K5kbuHVZONyLIZSqz/HYaIq+Z+JMvD1TvGZttGYVbYXFhuCbaucLZXKeMXZkK+GSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YRY6/qA5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415A07w1029161;
	Mon, 5 Feb 2024 10:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : reply-to : in-reply-to : references :
 message-id : content-type : content-transfer-encoding; s=pp1;
 bh=D7V6wffE7jnUqvHbks/jTIWjjzAJmTZcNtR1eMolikU=;
 b=YRY6/qA52VcknRqJSxY0v7xVkuXi8/9HtsAHDb20iMmhHati7UxxZmA2SbRuMNc0obaB
 fF2RXVi0pg7i9EUuXkh+tFXdkP5FTsHka4qChqU0QSE4l4RQfAYsB80eosJd9666OAxB
 1S6NFNqGZqh3vNj+jEXIjJWYC+ayaHNJYV+RX97qH5DlNxh1gzgaGzNuhGMpGLqTDyH9
 HZOWlFwn88BqnSVxr6V3NHsdvyPlJTGsjSysbdt+U2S8SpbAJ1VmIKXzMcLyrfQLUfvl
 NRwAfdSN+r87l2AxIKVxLDzGxuRXR2V5swBYfyHYtwUPNMH70oSB28rbbaZqnJgPlu7H iw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w2tx84ty8-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 10:47:59 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4159w9HV019996;
	Mon, 5 Feb 2024 10:36:35 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w1ytsr41m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 10:36:35 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415AaXUd1049268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 10:36:34 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA19358061;
	Mon,  5 Feb 2024 10:36:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D047858067;
	Mon,  5 Feb 2024 10:36:32 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Feb 2024 10:36:32 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 05 Feb 2024 11:36:32 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter
 <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic
 <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] s390: AP: make ap_bus_type const
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20240203-bus_cleanup-s390-v1-5-ac891afc7282@marliere.net>
References: <20240203-bus_cleanup-s390-v1-0-ac891afc7282@marliere.net>
 <20240203-bus_cleanup-s390-v1-5-ac891afc7282@marliere.net>
Message-ID: <696c7ded128d46addc16ecafa6128822@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0GLNHfCFchkaM5BLNQwuhdGmU8Ejkfil
X-Proofpoint-GUID: 0GLNHfCFchkaM5BLNQwuhdGmU8Ejkfil
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 mlxlogscore=783 bulkscore=0 spamscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050082

On 2024-02-03 15:58, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the ap_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/s390/crypto/ap_bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/crypto/ap_bus.c 
> b/drivers/s390/crypto/ap_bus.c
> index f46dd6abacd7..2ecf4d36e78b 100644
> --- a/drivers/s390/crypto/ap_bus.c
> +++ b/drivers/s390/crypto/ap_bus.c
> @@ -135,7 +135,7 @@ static int ap_max_domain_id = 15;
>  /* Maximum adapter id, if not given via qci */
>  static int ap_max_adapter_id = 63;
> 
> -static struct bus_type ap_bus_type;
> +static const struct bus_type ap_bus_type;
> 
>  /* Adapter interrupt definitions */
>  static void ap_interrupt_handler(struct airq_struct *airq,
> @@ -1603,7 +1603,7 @@ static struct attribute *ap_bus_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(ap_bus);
> 
> -static struct bus_type ap_bus_type = {
> +static const struct bus_type ap_bus_type = {
>  	.name = "ap",
>  	.bus_groups = ap_bus_groups,
>  	.match = &ap_bus_match,

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>

