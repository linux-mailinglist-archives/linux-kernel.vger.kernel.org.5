Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0F075E022
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 08:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjGWGkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 02:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjGWGkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 02:40:39 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8499B10D3;
        Sat, 22 Jul 2023 23:40:38 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36N6bU1R016333;
        Sun, 23 Jul 2023 06:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=vZPw6+ClErtd32k3gz+P/jOP3JLU9OHuDrJYxqghC40=;
 b=HOyQySZnoAkCLyBgD5Aeu+K13EWcV2sR/q97XPKEut6wNjLH8a3JBheAkTBlQJbdwUOO
 U1ub3R7rnKwSLlm5+ybszdLAavvOoS+tY2LYesUDnmGZ8KXWoPm/6nbtIehr9Vv+yLmw
 xZvZAlJW7vdWpL+Z7jA4FS3eHOLT1mRovvxk7VTyDtZE4PQXB9IG9Wj8uNuDmdJIZz7s
 kxMntbt/wULCvvf1vQh60aa30HzWbGsZXkPE60crxYgmekACutvNRtr0er8ZVWzHUJjR
 rHc8o8peapn0ttt6Vrkw+mZ0SXhAKqYGcUShXXwxv/P9MHRC78d5vHZWx6mEi2Z8pFP1 0A== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s0n7dexh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Jul 2023 06:40:28 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36N6PMfb014403;
        Sun, 23 Jul 2023 06:40:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0stx9u5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Jul 2023 06:40:28 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36N6eOAP23593564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 06:40:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA34820043;
        Sun, 23 Jul 2023 06:40:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D51A20040;
        Sun, 23 Jul 2023 06:40:24 +0000 (GMT)
Received: from osiris (unknown [9.171.79.53])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sun, 23 Jul 2023 06:40:24 +0000 (GMT)
Date:   Sun, 23 Jul 2023 08:40:22 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [GIT PULL] s390 fixes for 6.5-rc3
Message-ID: <20230723064022.11906-A-hca@linux.ibm.com>
References: <20230722160215.7417-A-hca@linux.ibm.com>
 <CAHk-=wj2g7kDTKPawbhOKXFsAF+Zayygmp1f64oerQktc_LCYw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj2g7kDTKPawbhOKXFsAF+Zayygmp1f64oerQktc_LCYw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vQyHWTTe3205rmBPEfxFypQcAKVDWvhm
X-Proofpoint-ORIG-GUID: vQyHWTTe3205rmBPEfxFypQcAKVDWvhm
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_02,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=653 impostorscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307230060
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 11:52:22AM -0700, Linus Torvalds wrote:
> On Sat, 22 Jul 2023 at 09:02, Heiko Carstens <hca@linux.ibm.com> wrote:
> >
> > - Fix per vma lock fault handling: add missing !(fault & VM_FAULT_ERROR)
> >   check to fault handler to prevent error handling for return values that
> >   don't indicate an error
> 
> Hmm. The s390 code / people seems to still be a bit confused about the
> VM_FAULT flags.
> 
> The commit comment says "With per-vma locks, handle_mm_fault() may
> return non-fatal error flags".
> 
> That's actively misleading.
...
> Anyway, I have pulled this, since it clearly fixes a problem. But I do
> think that the *deeper* problem is that s390 treats those bits as
> errors in the first place, when they really aren't. Yes, the error
> bits are *common*, but that field really shouldn't be seen as just
> errors, and I really think that the deeper problem is that
> 
>         if (unlikely(fault))
>                 do_fault_error(regs, fault);
> 
> logic. It's simply wrong.
> 
> Of course, it looks like the reason you found this is that the s390
> do_fault_error() then does a BUG() on any bits it doesn't understand.
> You have that nonsensical "clear flags" in other places too. So it's
> not like this work-around is new. But it's a workaround, and a sign of
> confusion, I feel.
> 
> Maybe the extra s390 fault conditions should be added to the generic
> list and added to the VM_FAULT_ERROR mask. I dunno.

Thanks for looking a bit deeper into the code. Our "special" private
VM_FAULT flags came already to attention a couple of months ago [1]. Most
of the flags are historic - I'll try to get rid of all of them, since for
other architectures it is also possible without having private flags.

Our fault handling code needs some refactoring anyway. Hopefully the result
will be easier to maintain, and makes it a bit more difficult to add bugs
like I recently introduced with this per-vma lock architecture backend.

[1] https://lore.kernel.org/all/Y+CLpdnOGFg28uMJ@casper.infradead.org/
