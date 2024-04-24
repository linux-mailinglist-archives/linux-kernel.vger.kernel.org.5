Return-Path: <linux-kernel+bounces-156869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEF38B0977
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA582858BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04D315B0E1;
	Wed, 24 Apr 2024 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NctkCl2M"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDFD15A4AA;
	Wed, 24 Apr 2024 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961682; cv=none; b=FQCzaQOI8b9H5Lsyt+0LUcogu82h/JR7hJLJ02MD520+PUZhRq3eIVUmnT+GHWmBFnm06se8YAFNxHnp3jE/1+xreaoyvG9WuGtS/7vzoyFzKgPZD3DRiVv7uuVEQIlqSlZHTW94/HEyUxDgPlxbvSEyeXUUhqc5BqbN4ZozzBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961682; c=relaxed/simple;
	bh=w4VdKh92taEZz0P4u6tU+LOMeXSAN2PLBXQv+XsAJws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLw8URsQ1tYDexScLgETwKOBjLMpOKifCRHrkTrXQExDkpAUvCsW9442h1/O7Dvi3Xw5/4T6nRLYtiyvrHI3GzQkiuqFvbS0mM2GA6DXvaYASShl0YPe4uxKzjRs7Gac/gJKEMFetZ6BB8JMD1SWS6OL7oxeSq0KO0qOCKcwA0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NctkCl2M; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OCL7KI020285;
	Wed, 24 Apr 2024 12:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=fSO/w2DgMqPwJW0Ypnq+JEtZMGKCHDgQQWqDTr9kF4A=;
 b=NctkCl2MYLK+UM66+GlUEw/Wd6gzv1iE6HWDFWdYwWfmsBIdF0vA9h/wRScktwk3xAS9
 KIbTZRzoGO822/ULhFN2t8b9DorjZqtmkhuAeaULOIlAHHwmqjNurik4T2ogBLfBFmgf
 DNL2C/kOUxib65yUP2AZnX2EPqoHI9DusKFU7FyC146U7vHhmMrNcmlBmSXvgcXiBjO5
 kI49fuvPvTIUbMCi4mYhy+wO27w7AxlY94HGIzy196cRX9+u+fz47vbQTc0MSAXGZdA6
 7Q5YRKy2orIkNt+FthiZPBaQuh0oUyh/Lj25zUEAOjVNnYL2/a+MuLAo+glvq48o5LzR Rg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xpyry88w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 12:27:56 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43O9fW4Y005328;
	Wed, 24 Apr 2024 12:27:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmx3cjac7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 12:27:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43OCRo9950528724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 12:27:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A6F320043;
	Wed, 24 Apr 2024 12:27:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56AB720040;
	Wed, 24 Apr 2024 12:27:50 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 24 Apr 2024 12:27:50 +0000 (GMT)
Date: Wed, 24 Apr 2024 14:27:49 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Jean Delvare <jdelvare@suse.de>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH RFC] s390/pci: Drop unneeded reference to CONFIG_DMI
Message-ID: <Zij6xYsx5OMj6yNl@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240423162724.3966265a@endymion.delvare>
 <b5ee24107efbc943cfc8ea59bf0653d2dd6325ad.camel@linux.ibm.com>
 <Zij1fJw+Ksrq5iAm@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <20240424140823.55475951@endymion.delvare>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424140823.55475951@endymion.delvare>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pZOBvf2vZEuuDm9M-6It9HW0LhZBvOar
X-Proofpoint-ORIG-GUID: pZOBvf2vZEuuDm9M-6It9HW0LhZBvOar
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_10,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=573 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404240046

On Wed, Apr 24, 2024 at 02:08:23PM +0200, Jean Delvare wrote:
> It's good to go through the s390 tree, it's a simple clean-up which
> doesn't depend on anything else.

Applied, thanks!

Thanks!

> Thanks to both of you!
> 
> -- 
> Jean Delvare
> SUSE L3 Support

