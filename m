Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CB67D3BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjJWQJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjJWQJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:09:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB2A103;
        Mon, 23 Oct 2023 09:09:12 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NFuXgM013400;
        Mon, 23 Oct 2023 16:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=6ObqH4e4bV+JHId4K2De8BGViudSJ57UfgnPV6M4KeI=;
 b=H/YDsuQOPuJw+VgelXjsrDoFXUVg9Dy6tO7tubwkdhelBMWqLBNt85zaPuqhB2XFF4Gz
 YLVhkNdbvRr0S4T7lxerN2c4oY1k2O5QxrZJy3k1rf0HOkQ49lMAVrRfGjFt9iQXTSkR
 hMOHdvEK7eFSscmyqaQtcb3tspdSs+PeOivEsVVI6Mh/iD6GY0q1u5ZuFWbNLowT1j51
 sROdCj0dFmZ/GeJW+ms34TA4bt2OjmBj2KWV/gAXg0nGYE6NLP7pWt92mwRD8VQFuHkW
 xQqnM8K9O8XMDew3WB6okIGoJ6naYEw/x57lRIW+obLZFWa5yp1CV/4fUtjTvdv3Rki+ tw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3twuq3s2s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 16:09:11 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39NFWIT4010250;
        Mon, 23 Oct 2023 16:09:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsby9tv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 16:09:10 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39NG96Fa30409436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 16:09:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E41D22004B;
        Mon, 23 Oct 2023 16:09:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 687E920040;
        Mon, 23 Oct 2023 16:09:06 +0000 (GMT)
Received: from localhost (unknown [9.171.43.41])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 23 Oct 2023 16:09:06 +0000 (GMT)
Date:   Mon, 23 Oct 2023 18:09:04 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [GIT PULL] s390 fixes for 6.6-rc7
Message-ID: <your-ad-here.call-01698077344-ext-9104@work.hours>
References: <your-ad-here.call-01697881440-ext-2458@work.hours>
 <CAHk-=wgTUz1bdY6zvsN4ED0arCLE8Sb==1GH8d0sjm5bu7zesQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgTUz1bdY6zvsN4ED0arCLE8Sb==1GH8d0sjm5bu7zesQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QXT1zwmDyRmUpZHFiyf6-MWXsig0RILD
X-Proofpoint-ORIG-GUID: QXT1zwmDyRmUpZHFiyf6-MWXsig0RILD
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_15,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=522 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230140
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 10:56:29AM -0700, Linus Torvalds wrote:
> On Sat, 21 Oct 2023 at 02:44, Vasily Gorbik <gor@linux.ibm.com> wrote:
> > - Fix IOMMU bitmap allocation in s390 PCI to avoid out of bounds access
> >   when IOMMU pages aren't a multiple of 64.

> But that code is wrong, because the overflow is simply not an issue.
> Adding overflow handling code is literally only actively misleading,
> making the code harder to read, for no reason, and making people
> *think* it's being careful when it is anything *but* careful.

Right, I should have done a better job reviewing this patch when picking
it up.

Please consider a follow-up patch (in reply) that cleans up unnecessary
and misleading overflow handling. There is no real benefit in getting
it into linux-next because the upcoming conversion to use the common
code DMA API on s390
Link: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20231020&id=c76c067e488c
eliminates arch/s390/pci/pci_dma.c entirely and, therefore, addresses the
original problem in another way. That's why this fix is only relevant for
the current v6.6 and stable backports and is kept as simple as possible.

Let me know if you prefer the regular way, and I should include this
follow-up patch in my pull request later this week.

> If you *do* want to add proper overflow handling, you'd need to either
> fix BITS_TO_LONGS() some way (which is actually non-trivial since it
> needs to be able to stay a constant and only use the argument once),

Looking into that. Let's see if handling overflow in __KERNEL_DIV_ROUND_UP
turns out to be doable.
