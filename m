Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280077F5DC7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345046AbjKWL0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344916AbjKWL0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:26:43 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9BDA3;
        Thu, 23 Nov 2023 03:26:49 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANBMd8S031207;
        Thu, 23 Nov 2023 11:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=VH0Ci/rpAYdo+WALL8EYHchRqOJ7RDwJtyX1w6itlbs=;
 b=bgnkW2uNv2Bnbsmij7D3hdFGvmE3w6euoawqH7CGnWDAJtSOwlzEbp1T/LsGv4cywblj
 2J6R2PDTQ3Hx7Ar5+oIC8zwvpfj8W7O+EU3ib3wcQnvhuc2Aj75bWT1ELzBX8kcbN4pz
 HSUOzkhquG/YYTI3L3P92a4RDzPAeFjRGF2U/hwOaoUEeuxly+MzHzh/wTZM0Gwg3YxD
 fGyqWo3WtMGlG77aq0rVHceMXSA2uUfKiyqd5W8K4xix3jjJGhJpAXDS4gvruCyfeYwj
 9alJKtqoqP4tORRsTc+5dBUEstVQ0s/1LzZnzI65ujRLalSEIJYWlkSE+X5YT8LZwtyD Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj5t582a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 11:26:20 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ANBMiTD031481;
        Thu, 23 Nov 2023 11:26:19 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj5t5823t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 11:26:19 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANBImaf024649;
        Thu, 23 Nov 2023 11:25:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8kp6sb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 11:25:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ANBPox718809382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Nov 2023 11:25:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5D4020040;
        Thu, 23 Nov 2023 11:25:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A027020043;
        Thu, 23 Nov 2023 11:25:49 +0000 (GMT)
Received: from osiris (unknown [9.171.55.214])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 23 Nov 2023 11:25:49 +0000 (GMT)
Date:   Thu, 23 Nov 2023 12:25:48 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <20231123112548.9603-A-hca@linux.ibm.com>
References: <20231004165007.43d79161@gandalf.local.home>
 <20231117142335.9674-A-hca@linux.ibm.com>
 <20231117143829.9674-B-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117143829.9674-B-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OELboezIwoX6pg5cZfvYSWvsLSwUT344
X-Proofpoint-GUID: PoEQiENG78qGH0Z1x7RK-ZFXEssIUlsg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311230082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 03:38:29PM +0100, Heiko Carstens wrote:
> On Fri, Nov 17, 2023 at 03:23:35PM +0100, Heiko Carstens wrote:
> > I think this patch causes from time to time crashes when running ftrace
> > selftests. In particular I guess there is a bug wrt error handling in this
> > function (see below for call trace):
> > 
> > > +static struct dentry *
> > > +create_file_dentry(struct eventfs_inode *ei, struct dentry **e_dentry,
> > > +		   struct dentry *parent, const char *name, umode_t mode, void *data,
> > > +		   const struct file_operations *fops, bool lookup)
> > > +{
> ...
> > Note that the compare and swap instruction within d_invalidate() generates
> > a specification exception because it operates on an invalid address
> > (0xffffffffffffffef), which happens to be -EEXIST. So my assumption is that
> > create_dir_dentry() has incorrect error handling and passes -EEXIST instead
> > of a valid dentry pointer to d_invalidate().
> > 
> > But I leave it up to you to figure this out :)
> 
> Ok, wrong function quoted of course. But the rest of my statement
> should be correct.

So, if it helps (this still happens with Linus' master branch):

create_dir_dentry() is called with a "struct eventfs_inode *ei" (second
parameter), which points to a data structure where "is_freed" is 1. Then it
looks like create_dir() returned "-EEXIST". And looking at the code this
combination then must lead to d_invalidate() incorrectly being called with
"-EEXIST" as dentry pointer.

Now, I have no idea how the code should work, but it is quite obvious that
something is broken :)

Here the dump of the struct eventfs_inode that was passed to
create_file_dentry() when the crash happened:

crash> struct eventfs_inode 00000000eada7680
struct eventfs_inode {
  list = {
    next = 0x10f802da0,
    prev = 0x122
  },
  entries = 0x12c031328 <event_entries>,
  name = 0x12b90bbac <__tpstrtab_xfs_alloc_vextent_exact_bno> "xfs_alloc_vextent_exact_bno",
  children = {
    next = 0xeada76a0,
    prev = 0xeada76a0
  },
  dentry = 0x0,
  d_parent = 0x107c75d40,
  d_children = 0xeada5700,
  entry_attrs = 0x0,
  attr = {
    mode = 0,
    uid = {
      val = 0
    },
    gid = {
      val = 0
    }
  },
  data = 0xeada6660,
  {
    llist = {
      next = 0xeada7668
    },
    rcu = {
      next = 0xeada7668,
      func = 0x12ad2a5b8 <free_rcu_ei>
    }
  },
  is_freed = 1,
  nr_entries = 6
}
