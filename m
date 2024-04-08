Return-Path: <linux-kernel+bounces-135287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CBE89BE6E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFEA1F22306
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEE76A029;
	Mon,  8 Apr 2024 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NoIa4xFF"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664E369E07;
	Mon,  8 Apr 2024 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712577076; cv=none; b=DGjyPejB9E1cMbBwepEhPkassYkM/jcrD4XBBVzhzHZREFzJOsrWQ2DYPCkBkySAj94hu2JATw1SmuiNh5yYwMoO+nv7sIHp4Wc4OuspsYKoFycTv/HJaEpoVDD7A1bkKFnQU4/PbKwef6oNkAIaS5q8jXDRUXzQvOJgK+yv5LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712577076; c=relaxed/simple;
	bh=6vLR5Hx1mXcWEJ+fHvoOxg9TPavpf/MeFz1JZwNX7Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQYu8jTXHEIDq1jpdpG3P8WfzWGP8JfwzKHqUtXu/sod7vPhrOZti4mU01r2G+BKPOusMd/93vHlcTz2GVYJl0p+AoEV9yzpzzL3CAxQTyKT+W9QKEVtkBDKYyED91sK5f8EwvH6JYgnMMpoBC8c2Ju+DDqMxnzxGlLVVsUq2YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NoIa4xFF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438BFluO015561;
	Mon, 8 Apr 2024 11:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=3S+qtrGdAsgfQrAe4YZ+mkXIyatuaTRRyUl/D6poeo0=;
 b=NoIa4xFFiWoF3rvQCjHWZ/hb4mu1vpo28KTdAuPIHxiZasW+jh8qTwdmnepFWkmgAvtb
 5U8HtDdq0C0Wo6S6ddXS7TpCctjl+J8iB5mX49AJpoNK6I+BhmPpjLAfpNRaXftEOU+g
 DVJP5ijVUwGOWBMrSVj8LYR3PA96L2NuAarvGRvXJu/+CdDUOhe5hgwoKgKEDOLzhszP
 Rv576q05K46X3r5dohJpNg5QNMf8fCk9xbk5Yu6nB4vV+aXHIm5NmbULNdolVLF3sOsD
 DCU1sDHtqdg2yEiKMRDQyfrpDa5O0mfd7P2eT/xXZpmUDzak/fYx6kTcBHFkq6TYUL6r /A== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xcc9egfej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 11:51:12 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 438AtNHc019110;
	Mon, 8 Apr 2024 11:51:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbh4001ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 11:51:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 438Bp6F430737106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Apr 2024 11:51:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C5ED2004E;
	Mon,  8 Apr 2024 11:51:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B876120043;
	Mon,  8 Apr 2024 11:51:05 +0000 (GMT)
Received: from osiris (unknown [9.171.19.167])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Apr 2024 11:51:05 +0000 (GMT)
Date: Mon, 8 Apr 2024 13:51:04 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/tools: Use ARRAY_SIZE() to fix Coccinelle warnings
Message-ID: <20240408115104.9447-C-hca@linux.ibm.com>
References: <20240408105515.2328-3-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408105515.2328-3-thorsten.blum@toblux.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8atXOrkjt6X5C4EG6klL2l0-ihnj-X-V
X-Proofpoint-GUID: 8atXOrkjt6X5C4EG6klL2l0-ihnj-X-V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_10,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=555
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404080090

On Mon, Apr 08, 2024 at 12:55:17PM +0200, Thorsten Blum wrote:
> Fixes the following two Coccinelle/coccicheck warnings reported by
> array_size.cocci:
> 
> 	WARNING: Use ARRAY_SIZE
> 	WARNING: Use ARRAY_SIZE
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  arch/s390/tools/gen_facilities.c   | 2 +-
>  arch/s390/tools/gen_opcode_table.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
> index 68580cbea4e6..ebd8a947e97c 100644
> --- a/arch/s390/tools/gen_facilities.c
> +++ b/arch/s390/tools/gen_facilities.c
> @@ -149,7 +149,7 @@ static void print_facility_lists(void)
>  {
>  	unsigned int i;
>  
> -	for (i = 0; i < sizeof(facility_defs) / sizeof(facility_defs[0]); i++)
> +	for (i = 0; i < ARRAY_SIZE(facility_defs); i++)
>  		print_facility_list(&facility_defs[i]);
>  }

Let's wait until a compile bot reports compile error. It would be
helpful to at least compile patches, before sending them.

