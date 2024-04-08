Return-Path: <linux-kernel+bounces-135511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B7089C6E9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15DB28118E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960FA1272C4;
	Mon,  8 Apr 2024 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C8yRrVg6"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277BD8061F;
	Mon,  8 Apr 2024 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586164; cv=none; b=HdqFjvh3sVU9kmCKQsjFHBZQgiqkLHj+/KKAYNyL0UDbndKqvjiGgVCNmIBA0NUfP23//MuUAUkmRH7tK9cDmYZSMguUP5cEUARNi3cdgWz2Jf/ACXsN7nvvd/scN2p7LIj38TJKQXpl51DfKqmzo2fHeyBuY5mz28MVOr14Ts0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586164; c=relaxed/simple;
	bh=J1/fqstbM5sABZsuP5LWcr7jv6Ko56PfgEUWHAOq6+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ot3JKJVIZvXUB+862JOOnHy4h5vxFU8fXXVWmaP+XgMO9oE+uX4aLqps5/tWISs/YqLA2pehy8vRZWDes5USAYsARDxQf/fq17ghzKZE+82a4Ds47EMWbdljETkZJPXopntVIG+4k7jAEsUc27KxVdIm5MT8Me9/w0NrguVqQBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C8yRrVg6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438Dq4Jx026068;
	Mon, 8 Apr 2024 14:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=lUVGF3u8yqzsf9tOwSFu7MTvf+cbSRWHzIgwMIHLc0c=;
 b=C8yRrVg6AoxzingXHiy/NZdvSvUrHrw/YaHKNn+adwLZAnKNyFecJqBT6Sg8EQFCxbSn
 NWupffX6HRFuK/5nqmKqsB+e5h23r7UFcsPdQPsHOi2FMEOGVVCNbXy98qLF56XwwQQk
 AXhz5D7P8qQ50Fozc6xeLfynbzzSEcXaWMo5FrDbVNK7wXzlSmRueKKh1GaACQ2YwYZk
 BEAxCPMvDlg3+EvnvqfmGMBEFYjLr/SjLRZXr87SyfP5DwUNpIsXEh+fAq3ndZX8NV7N
 915C2RGNidUPVAyVu+gmreXDGyIHuGjtODKLKKEd6U8KvsQd0y5UA3eo50igmfZEPZeA Tw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xchuc03s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 14:22:41 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 438Bmp0Y022627;
	Mon, 8 Apr 2024 14:22:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbhqnrgtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 14:22:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 438EMYA538666574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Apr 2024 14:22:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07DDB2004D;
	Mon,  8 Apr 2024 14:22:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0C7620049;
	Mon,  8 Apr 2024 14:22:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Apr 2024 14:22:33 +0000 (GMT)
Date: Mon, 8 Apr 2024 16:22:32 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        pasic@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com,
        gor@linux.ibm.com, hca@linux.ibm.com,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v4 4/5] s390/vfio-ap: Add write support to sysfs attr
 ap_config
Message-ID: <ZhP9qHs6tjPbh1/J@tuxmaker.boeblingen.de.ibm.com>
References: <20240326164706.29167-1-jjherne@linux.ibm.com>
 <20240326164706.29167-5-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326164706.29167-5-jjherne@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nZCmbvNW4oYQi_YX7IiFYqSRUNTitnZD
X-Proofpoint-GUID: nZCmbvNW4oYQi_YX7IiFYqSRUNTitnZD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_12,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404080111

On Tue, Mar 26, 2024 at 12:47:05PM -0400, Jason J. Herne wrote:

Hi Jason,

This series still has some issues.

> +	newbuf = rest = kstrndup(buf, AP_CONFIG_STRLEN, GFP_KERNEL);

This line triggers a checkpatch warning. Would it make sense
to turn it into below instead?

	newbuf = kstrndup(buf, AP_CONFIG_STRLEN, GFP_KERNEL);
> +	if (!newbuf)
> +		return -ENOMEM;
	rest = newbuf;

Also, please address other checkpatch suggestions.

> +	/* Save old state */
> +	/* The volatile cast here is to work around a gcc false positive
> +	 * Wstringop-overread-warning.
> +	 */
> +	ap_matrix_copy(&m_old, (*(struct ap_matrix * volatile *)(&matrix_mdev->matrix)));

Could you please come up with a different workaround? This issue has already
been resolved in the past in different ways. See commit 34186b48d29b ("ARM:
sharpsl_param: work around -Wstringop-overread warning") for example.

Thanks!

