Return-Path: <linux-kernel+bounces-54494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408E584AFF6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE9D286741
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B1E12B17F;
	Tue,  6 Feb 2024 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jivJTLAr"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAC51DFCD;
	Tue,  6 Feb 2024 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208289; cv=none; b=ZWU+qm8zZ87tiRmN9EbMYZDWNmMw/+MnJM7bgL/013QjQe+xwHnAi6huvHLeDMvCDAOtKWtcHbF/Zaeq+Qedicaw2bxDHRiRMiL4fBzxKItelpeFqGbVxpF8mbLVPe1l4jy/48ynjvNc84l+RA/P6IddPFLDcKAb7dEGci6sOoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208289; c=relaxed/simple;
	bh=dr8RrGDXQu1/tYwAnm0bmS8ZL6DXs2Uzrvt5wOAJfow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZECSLb2IY/0LVF1QJ0ud3DEoIF6HrcOow4cPsdOz0XEGaalAVuNKoHP1btPyBI1ESS1UWE7Ya+qAsBFhoRl1biyuqCtgecBR5c5J2ef+pARuPq5Eyh3uKiEHAX+8x7BIs0sRxJ8tOFFzkzAcAnClyOMdxiy4yqzVY5Vv1HptvjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jivJTLAr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4168RCQu004316;
	Tue, 6 Feb 2024 08:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=xLbMIDcBPmzt9dXauAUeRynhgm5hAhJ1s0Uakh6iudM=;
 b=jivJTLAr4mxDnWVfO4LHDGyMr8p33PABhxWRe1HhKFch1CH+w29Ne9yjkV+x9e8+RR6U
 H8BJcutCnVGqTIrtKR2NSD4UKajTGtk0n0j3KJUoj2qTwRC7BIl6Xv+k5xSui5nemmmW
 VAOMZtKOdBUamtn8N/XqQzkz1om7q9SAEMATRgP8RcyrE7BHNdUF4c7KIpBgpopPmF6K
 cK7TQG5rOn6BfeQs9AqUNnHu4eCUVZkAfuF6EJe+jNFP7TkLwa4PgHISsGKOWsFKmdAi
 5u7rvcyRUFJN2j/P4CaDwkGDRvDDjNxMw4lZSPbkT3Pzxao6S/5Ri2sBu5vpWfSv9QtP 9w== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w3h9206rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 08:31:25 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 416853bD016148;
	Tue, 6 Feb 2024 08:31:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w22h1wb28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 08:31:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4168VLYv11928072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Feb 2024 08:31:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB92E20043;
	Tue,  6 Feb 2024 08:31:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37B4C20040;
	Tue,  6 Feb 2024 08:31:21 +0000 (GMT)
Received: from osiris (unknown [9.171.32.22])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 Feb 2024 08:31:21 +0000 (GMT)
Date: Tue, 6 Feb 2024 09:31:19 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] s390: time: make stp_subsys const
Message-ID: <20240206083119.11958-B-hca@linux.ibm.com>
References: <20240204-bus_cleanup-s390_time-v1-1-d2120156982a@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-s390_time-v1-1-d2120156982a@marliere.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qy4i27OvSSbxv4Q4DgUwuIx4nylsk_ok
X-Proofpoint-ORIG-GUID: Qy4i27OvSSbxv4Q4DgUwuIx4nylsk_ok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=454 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060059

On Sun, Feb 04, 2024 at 11:25:45AM -0300, Ricardo B. Marliere wrote:
1;115;0c> Now that the driver core can properly handle constant struct bus_type,
> move the stp_subsys variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  arch/s390/kernel/time.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks!

