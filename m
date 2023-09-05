Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CB1792B7C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241753AbjIEQyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352360AbjIEFmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:42:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC3EDD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 22:42:14 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3855b1Ge029127;
        Tue, 5 Sep 2023 05:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=Hl6+ZTATI+6q3yMcVGGHJFj2PkpzwsWpa1T7EiqvydI=;
 b=aZcPor0NIbB11sJlTRgpxelrhNEj5voLhCHHIfNUArW/ywDd138l0ilFoaBw3y4FPoTb
 GTvFDEWDy2Kvbwo9kKQQtCEIBdRvwdVfmLnZ0fsYcnb9kthVgiziNwZVXNwSzXsBAQcW
 BMx7ShZATrA8ZhXg5cBvg+NWTyH9ZZ7wrBM/kLvEZeqv4C8PbVPtHfm1G8cPJJpnTRvP
 l7lbDFotumNmsi8qS63U+cQjKT1cec0O2G8bERiDT3rGADoWisko9EIvCha2uptS9O83
 dBLffIOpwofcYeA4hpOmgV4b3f8frh5XFohgmtSnBZtT1q7FGNfq6QVMlLOREv21AJkj Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3swvb4ta8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 05:41:48 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3855bsv9031415;
        Tue, 5 Sep 2023 05:41:12 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3swvb4t509-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 05:41:12 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385395DX012257;
        Tue, 5 Sep 2023 05:38:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svhkjqq0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 05:37:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3855bwcx43188820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 05:37:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 340B120043;
        Tue,  5 Sep 2023 05:37:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4933120040;
        Tue,  5 Sep 2023 05:37:56 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
        Tue,  5 Sep 2023 05:37:56 +0000 (GMT)
Date:   Tue, 5 Sep 2023 11:07:55 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        ndesaulniers@google.com, Nathan Lynch <nathanl@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/smp: Dynamically build powerpc topology
Message-ID: <20230905053755.GM1694454@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20230830122614.73067-1-srikar@linux.vnet.ibm.com>
 <20230904221004.GB2568@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230904221004.GB2568@noisy.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: flRABTS0mqzGxma6Wcjjxr0YL2jHdRcT
X-Proofpoint-ORIG-GUID: RE0ZdzZWJ2HvY3CgDRnJmmclmQxmlZO3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_04,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=502
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2023-09-05 00:10:04]:

> On Wed, Aug 30, 2023 at 05:56:14PM +0530, Srikar Dronamraju wrote:
> > Currently there are four powerpc specific sched topologies.  These are
> > all statically defined.  However not all these topologies are used by
> > all powerpc systems.
> > 
> > To avoid unnecessary degenerations by the scheduler , masks and flags
> > are compared. However if the sched topologies are build dynamically then
> > the code is simpler and there are greater chances of avoiding
> > degenerations.
> > 
> > Even x86 builds its sched topologies dynamically and new changes are
> > very similar to the way x86 is building its topologies.
> 

Thanks Peter for taking a look.

> You're not stating it explicitly, but you're doing this as a performance
> optimization, right? The x86 thing didn't particularly care about
> avoiding degenerate topologies -- it's just that the fixed tables method
> grew unwieldy due to combinatorics.
> 

Yes, its an optimization. On Powerpc, there is an utility ppc64, which users
would use to set their SMT mode, and whenever they do we end up recreating
the topology. Hence avoiding degenerates esp on large systems, should help.

Also dynamic add of CPUs is more common on Powerpc. Hence there also we
would avoid degenerating unnecessary domains.

> And how does this patch relate to the other series touching this?
> 
>   powerpc/smp: Shared processor sched optimizations
> 

This patch will work independent of that patchset.
However Shared processor sched optimization patchset makes MC domain
avoid degeneration. Hence this patch will benefit from that patchset.

i.e without the Shared processor sched patchset, has_coregroup_support()
will return true on Power10 for even shared processor. And hence the
scheduler will create and destroy MC domains. If the patchset is already
present, on Power10 for shared processors, we will avoid MC domains.
Other that this there wont be any change.

-- 
Thanks and Regards
Srikar Dronamraju
