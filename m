Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E6D7E59A8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjKHPFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjKHPFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:05:18 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFE41BE6;
        Wed,  8 Nov 2023 07:05:16 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8F1BDI025506;
        Wed, 8 Nov 2023 15:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=D9HrLma53iRqkK3HOqQdv79icnX2qKH5fdVBxhdIdUk=;
 b=ma7TByT3hp+XuJTGVyNmwDoFqfoj6HoeiLbMavDWSQ6VyjDxAk0QCLNqUpif35kEtVHZ
 xsQskAYAJVm38HPU6ZOS+qVQbQcXlk7AziromjpyNsrSnFSAfvlKSVDTQYw6sPqQ4eW9
 w6lT+tIwwOFpDn6mCX97jgn5MhTPvi4es7mWt+/hNpIIXUKMd/eIrTKhNEyBFL/NKim6
 nKrb+9wJ4sjyqoIuuFsF+pzzBn/TjqlL3DkbzBjeQgY5sHzwxlzZN75CeCHYE2Y3cxfO
 xlgwN4BQgv7ZwaR1Cf0r4f72yDIB4LaR/nDP5D0/hSkM5EFKOl1WCzwkYy9i+LhfBYiz 4Q== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8cks83s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 15:04:25 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8E5bPd019256;
        Wed, 8 Nov 2023 15:04:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w23wg54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 15:04:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A8F4Li852953462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Nov 2023 15:04:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F1C820043;
        Wed,  8 Nov 2023 15:04:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D725020040;
        Wed,  8 Nov 2023 15:04:20 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.152.224.212])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Nov 2023 15:04:20 +0000 (GMT)
Date:   Wed, 8 Nov 2023 16:04:19 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
        linux-kernel@vger.kernel.org (open list),
        Wangkefeng <wangkefeng.wang@huawei.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        petr@tesarici.cz, Petr Tesarik <petr.tesarik1@huawei-partners.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        stable@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] swiotlb: fix out-of-bounds TLB allocations with
 CONFIG_SWIOTLB_DYNAMIC
Message-ID: <20231108160419.00702fd0.pasic@linux.ibm.com>
In-Reply-To: <20231108111249.261-1-petrtesarik@huaweicloud.com>
References: <20231108111249.261-1-petrtesarik@huaweicloud.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wBz1kXya2ClhWyfdCSLSH2grCElniqZs
X-Proofpoint-ORIG-GUID: wBz1kXya2ClhWyfdCSLSH2grCElniqZs
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_03,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=832
 malwarescore=0 impostorscore=0 priorityscore=1501 clxscore=1011 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Nov 2023 12:12:49 +0100
Petr Tesarik <petrtesarik@huaweicloud.com> wrote:

> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> 
> Limit the free list length to the size of the IO TLB. Transient pool can be
> smaller than IO_TLB_SEGSIZE, but the free list is initialized with the
> assumption that the total number of slots is a multiple of IO_TLB_SEGSIZE.
> As a result, swiotlb_area_find_slots() may allocate slots past the end of
> a transient IO TLB buffer.
> 
> Reported-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Closes: https://lore.kernel.org/linux-iommu/104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com/
> Fixes: 79636caad361 ("swiotlb: if swiotlb is full, fall back to a transient memory pool")
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

I believe there is at least one stale comment in the code that says
"The number of slot in an area should be a multiple of IO_TLB_SEGSIZE"
but that is probably not stable material, so I do agree with keeping this
patch minimal.

Regards,
Halil
