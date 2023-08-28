Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE33B78A7CA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjH1Igy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjH1Igl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:36:41 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15429A9;
        Mon, 28 Aug 2023 01:36:39 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37S8aPIq004941;
        Mon, 28 Aug 2023 08:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=GH389tuXJXMHITxrnWot8HBmYjnZNXwE9NB7kpVqDoA=;
 b=UBwEDe21RcWAV7MLfFpLwXlA8kyPnXfN39kbXC6EKxuDZ4z123+jmVFHmgYilOcA7yD8
 oT66ggEEwYMwORdb96lnH2p85AeglWPiWIsQLjLLd8CJNHu206KDlVjMTS+j/UKnWV1l
 SZbOIwC7V+16qcdNa8qaae5RD/AnG6YPu5FQJbIqtXTxOn4847et/cuSpdyPh06xeI2V
 VMsdi/JUrs9/ZbS3xARlGQqK9qThkimgEhezun/IW7rg90Wyc/iaEADYEgksO8sxq4cN
 IoQqA6+G/MErnbo29gZ/XJR+NL4/NhjiBOzGgRsILIk4Tij700HuwxFiCekULCNL2MBI Ew== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr9j26mhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 08:36:24 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37S6RdVx020225;
        Mon, 28 Aug 2023 08:32:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqv3y1f9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 08:32:00 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37S8Vqet24445534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 08:31:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 197002004D;
        Mon, 28 Aug 2023 08:31:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E24D20043;
        Mon, 28 Aug 2023 08:31:51 +0000 (GMT)
Received: from osiris (unknown [9.171.94.10])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 28 Aug 2023 08:31:51 +0000 (GMT)
Date:   Mon, 28 Aug 2023 10:31:50 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] s390 updates for 6.6 merge window
Message-ID: <20230828083150.19928-A-hca@linux.ibm.com>
References: <20230827203058.5559-A-hca@linux.ibm.com>
 <20230827203401.5559-B-hca@linux.ibm.com>
 <20230828094228.2381967f@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828094228.2381967f@canb.auug.org.au>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TkSOpgrQMgnzK9QrPnTjP-m5ZO-9bPm9
X-Proofpoint-ORIG-GUID: TkSOpgrQMgnzK9QrPnTjP-m5ZO-9bPm9
X-Proofpoint-UnRewURL: 5 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_06,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=614
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 09:42:28AM +1000, Stephen Rothwell wrote:
> Hi Heiko,
> 
> On Sun, 27 Aug 2023 22:34:01 +0200 Heiko Carstens <hca@linux.ibm.com> wrote:
> >
> > On Sun, Aug 27, 2023 at 10:31:00PM +0200, Heiko Carstens wrote:
> > 
> > Maybe I'm doing something wrong, but below is the rather large diff
> > of the merge commit, using "git diff HEAD HEAD^@", where HEAD is the
> > merge commit.
> 
> Something weird there.  I just see the arch/s390/Kconfig part (I use
> git diff-tree <merge commit>).  What did you merge?
> 
> I can't see any commits affecting kernel/Kconfig.kexec in the s390
> branch in linux-next.

There is logical conflict between

commit 37002bc6b603 ("docs: move s390 under arch")

from the s390 tree:
git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux tags/s390-6.6-1
and

commit 89cde455915f ("kexec: consolidate kexec and crash options into kernel/Kconfig.kexec")

from Andrew's tree:
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm mm-nonmm-stable

The commit in Andrew's tree introduces kernel/Kconfic.kexec and uses the
old location for Documentation (which is correct for Andrew's tree). So
when merging the s390 tree and Andrew's tree into Linus' tree that should
be fixed as well (btw.: this is not "fixed" in linux-next).

So I guess the size of the merge commit diff is simply a result of
kernel/Kconfig.exec not being present in both trees and being modified with
the merge, and therefore the complete file is part of the diff.
