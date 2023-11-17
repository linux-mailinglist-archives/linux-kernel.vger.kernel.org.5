Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBA57EF460
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjKQOYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjKQOYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:24:13 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F67C5;
        Fri, 17 Nov 2023 06:24:09 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHEEaiv018715;
        Fri, 17 Nov 2023 14:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=MhUOt72uk00RT1b6Mj8j+IquiTQ5izi+LKW9TU0E3KM=;
 b=Eiy7/q7i5u614AoddSVpdp6huNzmF7zHaZZ1EipUx++3MuIo2EoK0BHmAaGb5VWg2uk9
 UoSF5YD89wRWs4wxSSJ6OUHxz8HduLFGsTi7DpMDAZU+Fm4XabeY4smotfy0OKJzPzOY
 WimWCVhAuCyuivNJIhYMK8kRfZZiox0sVEoGuTO3TAb9AlG3MmvMvtZfyP6vwDg8or2A
 Pn0XUK9d6I+TcH4CNHdkhKdaaIasCRbYGAYXy2SCQ4QiYOvwoQrIzHBAQvNTi19IVHef
 3KAtVKjIdPsRf6EHqoOWGo9+5hZmzk8kNz9m9e1IYZDymlYegFzl+384CB+DdHCAvEcC uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ue9nf0etf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 14:23:42 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AHEHAop032167;
        Fri, 17 Nov 2023 14:23:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ue9nf0ese-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 14:23:41 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHD3w6A018344;
        Fri, 17 Nov 2023 14:23:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamayxqkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 14:23:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AHENbJV4195070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 14:23:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E40F20049;
        Fri, 17 Nov 2023 14:23:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FD5120040;
        Fri, 17 Nov 2023 14:23:36 +0000 (GMT)
Received: from osiris (unknown [9.179.8.115])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 17 Nov 2023 14:23:36 +0000 (GMT)
Date:   Fri, 17 Nov 2023 15:23:35 +0100
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
Message-ID: <20231117142335.9674-A-hca@linux.ibm.com>
References: <20231004165007.43d79161@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004165007.43d79161@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LZqlSigGndFjOuzS76QxP3gIvkz-736v
X-Proofpoint-GUID: 6_3GzpCZum1kc-4Y49sZYGy_G_63swlH
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_12,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=707 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Wed, Oct 04, 2023 at 04:50:07PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Instead of having a descriptor for every file represented in the eventfs
> directory, only have the directory itself represented. Change the API to
> send in a list of entries that represent all the files in the directory
> (but not other directories). The entry list contains a name and a callback
> function that will be used to create the files when they are accessed.
...
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ajay Kaher <akaher@vmware.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v4: https://lore.kernel.org/linux-trace-kernel/20231003184059.4924468e@gandalf.local.home/
> 
>  - Get the ei->dentry within the eventfs_mutex to keep consistency during the lookup.
> 
>  fs/tracefs/event_inode.c     | 847 ++++++++++++++++++-----------------
>  fs/tracefs/inode.c           |   2 +-
>  fs/tracefs/internal.h        |  37 +-
>  include/linux/trace_events.h |   2 +-
>  include/linux/tracefs.h      |  29 +-
>  kernel/trace/trace.c         |   7 +-
>  kernel/trace/trace.h         |   4 +-
>  kernel/trace/trace_events.c  | 313 +++++++++----
>  8 files changed, 705 insertions(+), 536 deletions(-)

I think this patch causes from time to time crashes when running ftrace
selftests. In particular I guess there is a bug wrt error handling in this
function (see below for call trace):

> +static struct dentry *
> +create_file_dentry(struct eventfs_inode *ei, struct dentry **e_dentry,
> +		   struct dentry *parent, const char *name, umode_t mode, void *data,
> +		   const struct file_operations *fops, bool lookup)
> +{
> +	struct dentry *dentry;
> +	bool invalidate = false;
> +
> +	mutex_lock(&eventfs_mutex);
> +	/* If the e_dentry already has a dentry, use it */
> +	if (*e_dentry) {
> +		/* lookup does not need to up the ref count */
> +		if (!lookup)
> +			dget(*e_dentry);
> +		mutex_unlock(&eventfs_mutex);
> +		return *e_dentry;
> +	}
> +	mutex_unlock(&eventfs_mutex);
> +
> +	/* The lookup already has the parent->d_inode locked */
> +	if (!lookup)
> +		inode_lock(parent->d_inode);
> +
> +	dentry = create_file(name, mode, parent, data, fops);
> +
> +	if (!lookup)
> +		inode_unlock(parent->d_inode);
> +
> +	mutex_lock(&eventfs_mutex);
> +
> +	if (IS_ERR_OR_NULL(dentry)) {
> +		/*
> +		 * When the mutex was released, something else could have
> +		 * created the dentry for this e_dentry. In which case
> +		 * use that one.
> +		 *
> +		 * Note, with the mutex held, the e_dentry cannot have content
> +		 * and the ei->is_freed be true at the same time.
> +		 */
> +		WARN_ON_ONCE(ei->is_freed);
> +		dentry = *e_dentry;
> +		/* The lookup does not need to up the dentry refcount */
> +		if (dentry && !lookup)
> +			dget(dentry);
> +		mutex_unlock(&eventfs_mutex);
> +		return dentry;
> +	}
> +
> +	if (!*e_dentry && !ei->is_freed) {
> +		*e_dentry = dentry;
> +		dentry->d_fsdata = ei;
> +	} else {
> +		/*
> +		 * Should never happen unless we get here due to being freed.
> +		 * Otherwise it means two dentries exist with the same name.
> +		 */
> +		WARN_ON_ONCE(!ei->is_freed);
> +		invalidate = true;
> +	}
> +	mutex_unlock(&eventfs_mutex);
> +
> +	if (invalidate)
> +		d_invalidate(dentry);
> +
> +	if (lookup || invalidate)
> +		dput(dentry);
> +
> +	return invalidate ? NULL : dentry;
> +}

We sometimes see crashes like this:

specification exception: 0006 ilc:2 [#1] SMP 
CPU: 6 PID: 38815 Comm: ls Not tainted 6.7.0-20231116.rc1.git1.a7e756a5bb26.300.vr.fc38.s390x #1
Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
Krnl PSW : 0704c00180000000 000001682304bb00 (d_invalidate+0x30/0x110)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
Krnl GPRS: ffffffffffffffff 000000e200000000 0000000000000047 000000e200000007
           0000000000000000 ffffff7c197bf000 000000e2f13b0b20 000000e25bfae180
           000000e2f2536000 ffffffffffffffef 0000000000000000 ffffffffffffffef
           000003ff95cacf98 000000e2f29323f0 000000e827c1fa18 000000e827c1f9d0
Krnl Code: 000001682304baf4: a7180000            lhi     %r1,0
           000001682304baf8: 583003ac            l       %r3,940
          #000001682304bafc: ba13b058            cs      %r1,%r3,88(%r11)
          >000001682304bb00: ec16006b007e        cij     %r1,0,6,000001682304bbd6
           000001682304bb06: e310b0100002        ltg     %r1,16(%r11)
           000001682304bb0c: a784004e            brc     8,000001682304bba8
           000001682304bb10: b904002b            lgr     %r2,%r11
           000001682304bb14: c0e5ffffe67e        brasl   %r14,0000016823048810
Call Trace:
 [<000001682304bb00>] d_invalidate+0x30/0x110 
 [<000001682329147a>] create_dir_dentry+0xe2/0x200 
 [<000001682329190a>] dcache_dir_open_wrapper+0x102/0x3e8 
 [<000001682301fb8a>] do_dentry_open+0x24a/0x568 
 [<0000016823038836>] do_open+0x2de/0x448 
 [<000001682303cb58>] path_openat+0x110/0x2b0 
 [<000001682303d688>] do_filp_open+0x90/0x130 
 [<0000016823022960>] do_sys_openat2+0xa8/0xd8 
 [<0000016823022b50>] do_sys_open+0x58/0x90 
 [<00000168239c9edc>] __do_syscall+0x1d4/0x200 
 [<00000168239db1f8>] system_call+0x70/0x98 
Last Breaking-Event-Address:
 [<0000016823291474>] create_dir_dentry+0xdc/0x200
Kernel panic - not syncing: Fatal exception: panic_on_oops

Note that the compare and swap instruction within d_invalidate() generates
a specification exception because it operates on an invalid address
(0xffffffffffffffef), which happens to be -EEXIST. So my assumption is that
create_dir_dentry() has incorrect error handling and passes -EEXIST instead
of a valid dentry pointer to d_invalidate().

But I leave it up to you to figure this out :)
