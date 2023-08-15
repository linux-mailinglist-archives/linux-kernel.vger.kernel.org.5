Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001B277C926
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbjHOIJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbjHOIJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:09:21 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464EE1703;
        Tue, 15 Aug 2023 01:09:20 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37F82HdU031171;
        Tue, 15 Aug 2023 08:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=t2RXLILrIgG0Fj0L0CI1FeSJt/iaLrmiUFqdyN2/nmA=;
 b=VUhtqSmAxIDmu6m3jX4K9CuiYptgn2zpDDwqRQnCO3HSI74dUJG78tgHaNl2/QaveQoh
 3g/vAmzkOtmfOH/dJZdKy9RQH3UAkI4tNVcwdDb7/MOyULYgSVZsROcT8saywgAHcR3t
 L2F8MPFcvTigGtKqWPXGYsISRh22871KZ6v1O7acLh+Xa4HgqMddtWB6MdhfTfx+u27Q
 95bzw8AtZ11fOb3C7ib8+kUhUIFmuqbu+Mtccn6xqru0h/HvxsNjZeteAr9Mpuh6HvUJ
 N3H0tA6zDtl4y0F3bwQ0fRi6mCwlvZLS0VZbFWx9rpZQaqqabzj3NkT9tfseBzYxCzL+ fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sg5gc0505-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 08:09:17 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37F82M8O031371;
        Tue, 15 Aug 2023 08:09:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sg5gc04yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 08:09:17 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37F7xSt8007861;
        Tue, 15 Aug 2023 08:09:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3senwk3cuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 08:09:16 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37F89DGI36110940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 08:09:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DB4220040;
        Tue, 15 Aug 2023 08:09:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A5EC2004B;
        Tue, 15 Aug 2023 08:09:13 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 15 Aug 2023 08:09:13 +0000 (GMT)
Date:   Tue, 15 Aug 2023 10:09:11 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] s390/mm: Make virt_to_pfn() a static inline
Message-ID: <20230815080911.6414-E-hca@linux.ibm.com>
References: <20230812-virt-to-phys-s390-v2-1-6c40f31fe36f@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812-virt-to-phys-s390-v2-1-6c40f31fe36f@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pt5R4EGEyNLFkycSwcQ0sMhAJlCPFw5k
X-Proofpoint-ORIG-GUID: yOz2XuEJqGjO8UUmcDV85oqI_O8okZvU
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_07,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 impostorscore=0 mlxlogscore=851 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150072
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 05:12:54PM +0200, Linus Walleij wrote:
> Making virt_to_pfn() a static inline taking a strongly typed
> (const void *) makes the contract of a passing a pointer of that
> type to the function explicit and exposes any misuse of the
> macro virt_to_pfn() acting polymorphic and accepting many types
> such as (void *), (unitptr_t) or (unsigned long) as arguments
> without warnings.
> 
> For symmetry do the same with pfn_to_virt() reflecting the
> current layout in asm-generic/page.h.
> 
> Doing this reveals a number of offenders in the arch code and
> the S390-specific drivers, so just bite the bullet and fix up
> all of those as well.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v2:
> - Just drop the cast to (unsigned long) in drivers/s390/char/vmcp.c,
>   we do not need to cast to (void *) from (char *), a pointer is
>   a pointer.
> - Link to v1: https://lore.kernel.org/r/20230811-virt-to-phys-s390-v1-1-b661426ca9cd@linaro.org
> ---
>  arch/s390/include/asm/kfence.h |  2 +-
>  arch/s390/include/asm/page.h   | 12 ++++++++++--
>  arch/s390/mm/cmm.c             |  2 +-
>  arch/s390/mm/vmem.c            |  2 +-
>  drivers/s390/block/scm_blk.c   |  2 +-
>  drivers/s390/char/vmcp.c       |  2 +-
>  6 files changed, 15 insertions(+), 7 deletions(-)

Applied, thanks!
