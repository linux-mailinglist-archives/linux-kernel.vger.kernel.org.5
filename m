Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6434C77B997
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjHNNSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjHNNSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:18:20 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F01912D;
        Mon, 14 Aug 2023 06:18:16 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EDCwNX026797;
        Mon, 14 Aug 2023 13:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=Z2gThLguoQ+HT2qJOdr1jOuqOoSlIbLuQagclRCXl0k=;
 b=JBfIPnCWpZPRFuA2Yn/XXjmxZwha/4kzsxxYFxY8HzcBMIL1KwKeIc4Unqh/LT8jubaC
 UV/P2l2ni7Kh2QAGZLzHdT3UsOHqPrpGVrAXxIEHz1S9QXe2nHpey+Wg/U11NLk+JfLH
 WkZ6ScwMH/vtuM3+/yI4x2pXEaAgqyiQqO6GgWDphRjSvZk7ZgvcB2HxdokY1yicBvtJ
 cmdpw16c3N4YrWuR8uk6FLyUeRo/1LtLNGzD5CGKLtyy+J6ZM3/QsX/FWU9IN1NBmDqg
 y/8mBo9+CN1EJD5+FODFpOMCJZGJsnCzTxe5brh051usKB8ylJjXQKSuic6K+udXPa+N Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfmr80bs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 13:18:14 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37EDEIMt031708;
        Mon, 14 Aug 2023 13:18:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfmr80brn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 13:18:13 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37EBwR2P001119;
        Mon, 14 Aug 2023 13:18:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3semsxvtgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 13:18:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37EDIAmg23266046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 13:18:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 027242004D;
        Mon, 14 Aug 2023 13:18:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A57F2004F;
        Mon, 14 Aug 2023 13:18:09 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.86.49])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 14 Aug 2023 13:18:09 +0000 (GMT)
Date:   Mon, 14 Aug 2023 15:18:07 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/mm: Make virt_to_pfn() a static inline
Message-ID: <ZNopjyWTodocYyVb@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20230811-virt-to-phys-s390-v1-1-b661426ca9cd@linaro.org>
 <ZNY7PvtP0jI1/xF1@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <CACRpkda2H_Ls7FT-GPkM2HLci0rLomwcP+Y5e7CJgXtT2NxJqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkda2H_Ls7FT-GPkM2HLci0rLomwcP+Y5e7CJgXtT2NxJqA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X9JgCslSai8tvP4KXXQVZ3y95aC1RmIS
X-Proofpoint-ORIG-GUID: -wjJXnzDNSjmCIH8y9vuZJtm71vX4PFC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 07:49:01PM +0200, Linus Walleij wrote:
> On Fri, Aug 11, 2023 at 3:44 PM Alexander Gordeev
> <agordeev@linux.ibm.com> wrote:
> 
> > Funnily enough, except drivers/s390/char/vmcp.c none of affected
> > code pieces below is an offender. But anyway, to me it looks like
> > a nice improvement.
> 
> I'm puzzled, vmcp.c is a char * so actually not an offender
> (I am trying to push a version without casting to the compile farm),
> the rest are unsigned long passed to the function which now
> (after my change) has const void * as argument?
> 
> Example:
> 
> > > @@ -90,7 +90,7 @@ static long cmm_alloc_pages(long nr, long *counter,
> 
> unsigned long addr;
> 
> > > +             diag10_range(virt_to_pfn((void *)addr), 1);

I only tried to say that these pieces weren't offenders before
you patch and turned ones after. But that seems like what your
commit message says.

> Yours,
> Linus Walleij

Thanks!
