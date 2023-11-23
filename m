Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A987F638C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjKWQGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjKWQGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:06:21 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F3110C2;
        Thu, 23 Nov 2023 08:06:27 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANFDGa7031479;
        Thu, 23 Nov 2023 16:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=K+Wh+d8J7rh0s3Lq2zXWuaoXUK1T2X89T09eukRww1M=;
 b=MLL3UYjolqNRHyEYsKtnAvSX1s/BwBqQO/wo519WlXa1BoXsEhYHsu9V5wA8qqjnvn3i
 hA4UpfuwrbEGJ3NhbgDwLoDwaybiXe6A+LCfX6/fXcvSCwon10w7rQEasfGSf2f1rUDW
 6dVyoW5zBO4mBnTQPBsTGwB/9MHanyFi2tTmMr6bWXoe3KIu+YMDI/KoMkU0cFvOUixa
 E4ctVMZWIvmRXCscjSxL4RJfHogooXsyZ0aIFplWMtUQiQLd+55A2u0Td/oyHxF57k7E
 DNphXWUd6dy32ZC/lzmaNiraByBLFK/CctChKvNzC8z7JuxFr5aRYY0oVAU+nFLLb4+R 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj969hev3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 16:06:08 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ANFcTCS015116;
        Thu, 23 Nov 2023 16:06:08 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj969heuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 16:06:08 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANFmjWs008996;
        Thu, 23 Nov 2023 16:06:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf7ktgb8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 16:06:07 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ANG65QW66060694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Nov 2023 16:06:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8717F2004D;
        Thu, 23 Nov 2023 16:06:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 971C720040;
        Thu, 23 Nov 2023 16:06:04 +0000 (GMT)
Received: from osiris (unknown [9.171.55.214])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 23 Nov 2023 16:06:04 +0000 (GMT)
Date:   Thu, 23 Nov 2023 17:06:03 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>, chinglinyu@google.com,
        lkp@intel.com, namit@vmware.com, oe-lkp@lists.linux.dev,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v5] eventfs: Remove eventfs_file and just use
 eventfs_inode
Message-ID: <20231123160603.9603-B-hca@linux.ibm.com>
References: <20231004165007.43d79161@gandalf.local.home>
 <20231117142335.9674-A-hca@linux.ibm.com>
 <20231117143829.9674-B-hca@linux.ibm.com>
 <20231123112548.9603-A-hca@linux.ibm.com>
 <20231123102349.110e4525@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123102349.110e4525@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uqkeVX_uUbIjzgxUDUo7AiPsxkAaIws4
X-Proofpoint-ORIG-GUID: jBs3tPUlKG22GKF_qg4qexeGNwefmy1E
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230117
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 10:23:49AM -0500, Steven Rostedt wrote:
> On Thu, 23 Nov 2023 12:25:48 +0100
> Heiko Carstens <hca@linux.ibm.com> wrote:
> 
> > So, if it helps (this still happens with Linus' master branch):
> > 
> > create_dir_dentry() is called with a "struct eventfs_inode *ei" (second
> > parameter), which points to a data structure where "is_freed" is 1. Then it
> > looks like create_dir() returned "-EEXIST". And looking at the code this
> > combination then must lead to d_invalidate() incorrectly being called with
> > "-EEXIST" as dentry pointer.
> 
> I haven't looked too much at the error codes, let me do that on Monday
> (it's currently Turkey weekend here in the US).
> 
> But could you test this branch:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git  trace/core
> 
> I have a bunch of fixes in that branch that may fix your issue. I just
> finished testing it and plan on pushing it to Linus before the next rc
> release.

This is not that easy to reproduce, however you branch contains commit
71cade82f2b5 ("eventfs: Do not invalidate dentry in create_file/dir_dentry()")
which removes the d_invalidate() call.
The crash I reported cannot happen anymore with that commit. I'll consider
this fixed, and report again if this (or something else) still causes
problems.

Thanks!
