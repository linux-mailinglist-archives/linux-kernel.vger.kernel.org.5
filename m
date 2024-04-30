Return-Path: <linux-kernel+bounces-163866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 679C98B74CA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D6A280F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6903133422;
	Tue, 30 Apr 2024 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pARSUFY2"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB1712CD90;
	Tue, 30 Apr 2024 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477581; cv=none; b=mjjhq82kq7lmt/f6TEwKqEsHakX/EqZJYxoUnFGnBkSL4xYwYtcdQjBy8DUDpEFaXxFPmepym1U89os9YsEtS4nPyCzfWgqLEd37OUAglyb6taaHP9G62b+IbcH5pZ8vpKUHp6PIB4JF79C30OTf2LHIiDR+UmDhanqUDoviDIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477581; c=relaxed/simple;
	bh=fNYJN9v/aw6h3Dg5grO4fn4gIASAmBjbnxWMvirxUaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKuhOmP3gm5lFSlZvG+EczLRdeaA/aHmfTdvifc+/TB3nlqP/I7I3TrU8YKoQO3b/wLz/vHe0FjLZJ0KO7dhJy/pU2xXKnj5lMIQlmcXa6seaUMqZPVNs6RyFQ3o1kUfL8XoEaHgm5lJNrLuF6ALJ7GvHj63j2YExVP7P4l9rUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pARSUFY2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43UBbERo014914;
	Tue, 30 Apr 2024 11:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=nOAEiljfgjz9j9RXSmVo3QnxjiAkMgDefh4MrN+YCBA=;
 b=pARSUFY2r1HnHlXC1h4FwLp41lGEW2tolpgDyCW7/AxnmSlvq0sm8J9pwj/uEAsheal8
 IYwNd+fOQUMi+tmcD4hkSKFSkRkVDmQJAknkjmzZRjnIN7fPRz284BCLzEjDZC0yNUjB
 8UN1z1ICZJSAltMFGQx4T8nf6LDy5PqEhvMjUqE6wZtqfMDg/deosL3EltF1HezZ4lwZ
 5/5nidjJDnwyB7R7LcpSeAoDynCryDRUM2x/o2EhXyfyhX4gQ1J9hxyX4awXmVgKBfNk
 Xv0QsULP+YI4BtQrTIzd2C6Wg7bIPMYRJBG18Hx3LJkZpG4t++inOHweFh7F4akHFHA+ EQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xtyqkg1sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 11:46:18 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43U94IZA027556;
	Tue, 30 Apr 2024 11:46:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xsc30cy1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 11:46:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43UBkBcA50725184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 11:46:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5C8320040;
	Tue, 30 Apr 2024 11:46:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D1C62004B;
	Tue, 30 Apr 2024 11:46:11 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 30 Apr 2024 11:46:11 +0000 (GMT)
Date: Tue, 30 Apr 2024 13:46:10 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, svens@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, borntraeger@de.ibm.com
Subject: Re: [PATCH v4 0/2] s390/pgtable: misc small improvements
Message-ID: <ZjDaAgfmPFPuHnaF@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240429143409.49892-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429143409.49892-1-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aaJHfBlvIXgbh988kWOX7GsN7BsUvKFv
X-Proofpoint-ORIG-GUID: aaJHfBlvIXgbh988kWOX7GsN7BsUvKFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_04,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 phishscore=0 mlxlogscore=612
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404300084

On Mon, Apr 29, 2024 at 04:34:07PM +0200, Claudio Imbrenda wrote:
> Claudio Imbrenda (2):
>   s390/pgtable: switch read and write softbits for puds
>   s390/pgtable: add missing hardware bits for puds, pmds
> 
>  arch/s390/include/asm/pgtable.h | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Applied, thanks!

