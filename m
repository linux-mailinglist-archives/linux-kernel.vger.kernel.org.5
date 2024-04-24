Return-Path: <linux-kernel+bounces-157140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 020338B0D56
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24140B278F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1F9161314;
	Wed, 24 Apr 2024 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YcDLjFHr"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD8D15F3F8;
	Wed, 24 Apr 2024 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970474; cv=none; b=VS3IvO32DEjGmhkP9+dk7AXsQrMG/KjwSv8e4svXh969eI7rUC4CXY/qqUoGbhBuq0JEX0HRn3iP1OfxFlU1aVXiiGjyotTyB5HgQ+z7FFpM1YKcW++rOtGKusz8AVUg8BZoyx4+WjsWa9Msrt4AfG8yeOnljb542BjG+43vAdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970474; c=relaxed/simple;
	bh=Vke2PRjMOaaDnifLzd+g5rbY2VteuyFJwC55RRx62rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxm8vi40fIsu7o4RWnF2AJDSl4IS5TEVNHm/pmf7QkFFBxLRkph+mCWZtUOmW2gp6Nza16ALwc3n38z4XgE3rjTtwJYkKcHv7f27ZS68snL3hdf+9JJ1P8S3g9SQz4wkwk3YPRaITJh9ibPT/Gdt8eBpEebJGsy4Qvw8w4aN0hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YcDLjFHr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OEphXU021642;
	Wed, 24 Apr 2024 14:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=faPLB+kw4kVxRvk/awmxuWyqP9LFnkCQP2eMceG1XuI=;
 b=YcDLjFHr2K+Ys/y15mRL/i5XlzBdFtq5rcBbzgelkmuX+/sL3KIqMraFZybJfrfhTwPF
 7u7AHXycbmDG4D34xnfCR2DgOJGnNXA6qXu/y49qQVifXoEmuLv+cB606ogd5otL2rJ9
 CTlExfmUkla6534BoaeqwMQQDsnlvT/bOAD7WgZx+KBlUmYtxke/Fcj80Tr0c2pYkQbG
 0n18GAE8iMvexUAP3WiRGGe+SFc37h3Z8yQYk/jURhsf8SEK9VznS3OvZ6/jfObjQcJL
 sLBr5o0nJ8SLB7BDMIKoDPPsbH33nCyutt1MZIgWr5TXXskwRS7DOVKmLMvhLe1x+8vY nA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xq1mjrcgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 14:54:17 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OEsGYx027087;
	Wed, 24 Apr 2024 14:54:16 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xq1mjrcgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 14:54:16 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43OC0rH5015277;
	Wed, 24 Apr 2024 14:54:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmshmc1tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 14:54:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43OEs9Kw44761424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 14:54:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4449D2004B;
	Wed, 24 Apr 2024 14:54:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23A4B20040;
	Wed, 24 Apr 2024 14:54:07 +0000 (GMT)
Received: from osiris (unknown [9.171.4.217])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 24 Apr 2024 14:54:07 +0000 (GMT)
Date: Wed, 24 Apr 2024 16:54:05 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
        Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Fabian Frederick <fabf@skynet.be>,
        Saurav Kashyap <skashyap@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Nilesh Javali <nilesh.javali@cavium.com>,
        Arun Easi <arun.easi@cavium.com>,
        Manish Rangankar <manish.rangankar@cavium.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Saurav Kashyap <saurav.kashyap@cavium.com>, linux-s390@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 5/6] cio: ensure the copied buf is NUL terminated
Message-ID: <20240424145405.26193-C-hca@linux.ibm.com>
References: <20240424-fix-oob-read-v2-0-f1f1b53a10f4@gmail.com>
 <20240424-fix-oob-read-v2-5-f1f1b53a10f4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424-fix-oob-read-v2-5-f1f1b53a10f4@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: P3jauZ9wnPsNqb9Y8f9APW5dRRKdbn4d
X-Proofpoint-GUID: bdcVi_JhzGQ_L9LlgnK3IM-pAQHck6Ez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_12,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=863 suspectscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240056

On Wed, Apr 24, 2024 at 09:44:22PM +0700, Bui Quang Minh wrote:
> Currently, we allocate a lbuf-sized kernel buffer and copy lbuf from
> userspace to that buffer. Later, we use scanf on this buffer but we don't
> ensure that the string is terminated inside the buffer, this can lead to
> OOB read when using scanf. Fix this issue by using memdup_user_nul instead.
> 
> Fixes: a4f17cc72671 ("s390/cio: add CRW inject functionality")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/s390/cio/cio_inject.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

