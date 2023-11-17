Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C74E7EF4A8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjKQOjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKQOjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:39:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A984B8;
        Fri, 17 Nov 2023 06:38:58 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHEbLvY016889;
        Fri, 17 Nov 2023 14:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=WM0V+hyIL7XQpkQLI7/vp+KVsKdSoxJq5T+sk4kaJp8=;
 b=byYTbKI2+ALS/X8OP5GE4Oeq4ZDkPwQYCFsPI9xCo1O/TbpHwHgpQBGoqYAceddmZb2Z
 BA2Op40jyAI8w0v4bEyTTihpiUrT2+Hu9Bd+lmq/EecLLymPs+RbOLb/jX81kuDXar+h
 FbdmlEzqY7gPuUVrE0EEQKfI456K5hvzp3/xd27YFE6ayg20wZk/Wbkcj+FwoML/covo
 81FU0kQRCtvbfaq5H9kI7l1/2At5ttb5O28FN/ac4PdBvdVMc8gDfS1FEFQn61r969mU
 TJF8UzyLtqeTC6rQ/sq4I48KgSoQAMiss2v3T4ceCF9oYCCXRWpooUUeJMZQ1u84nMWR Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uea3h82e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 14:38:45 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AHEbqoK019193;
        Fri, 17 Nov 2023 14:38:42 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uea3h8249-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 14:38:42 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHD41sa023047;
        Fri, 17 Nov 2023 14:38:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uapn264wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 14:38:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AHEcVai22413826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 14:38:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6462F2004D;
        Fri, 17 Nov 2023 14:38:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 860F720040;
        Fri, 17 Nov 2023 14:38:30 +0000 (GMT)
Received: from osiris (unknown [9.179.8.115])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 17 Nov 2023 14:38:30 +0000 (GMT)
Date:   Fri, 17 Nov 2023 15:38:29 +0100
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
Message-ID: <20231117143829.9674-B-hca@linux.ibm.com>
References: <20231004165007.43d79161@gandalf.local.home>
 <20231117142335.9674-A-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117142335.9674-A-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NvQfGLlneGpQnZcDGAkndaGx_UifV0TY
X-Proofpoint-ORIG-GUID: 1hU4o4hwC7tmD3FWJvrLhd2SjgCKapbg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_13,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=555 clxscore=1015 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 03:23:35PM +0100, Heiko Carstens wrote:
> I think this patch causes from time to time crashes when running ftrace
> selftests. In particular I guess there is a bug wrt error handling in this
> function (see below for call trace):
> 
> > +static struct dentry *
> > +create_file_dentry(struct eventfs_inode *ei, struct dentry **e_dentry,
> > +		   struct dentry *parent, const char *name, umode_t mode, void *data,
> > +		   const struct file_operations *fops, bool lookup)
> > +{
...
> Note that the compare and swap instruction within d_invalidate() generates
> a specification exception because it operates on an invalid address
> (0xffffffffffffffef), which happens to be -EEXIST. So my assumption is that
> create_dir_dentry() has incorrect error handling and passes -EEXIST instead
> of a valid dentry pointer to d_invalidate().
> 
> But I leave it up to you to figure this out :)

Ok, wrong function quoted of course. But the rest of my statement
should be correct.
