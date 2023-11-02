Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3747DF1D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345556AbjKBL4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjKBL4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:56:46 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33EFC2;
        Thu,  2 Nov 2023 04:56:40 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2BqTN3001418;
        Thu, 2 Nov 2023 11:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=U4GW3P2afzSuZeJwablRfH+x7WynkauX03fHhisGn+w=;
 b=jPsJHQXxULwH3Ne2QwN64c88pX3Sozszl6BvMJbSJkLSO3e5R4lddN+ULlQfJDpJ3gOK
 7HCkCmTG9dHNl8yid/qoSTj6OZeKFfAdXgIrV/vJxmEzBPoNrop5hcHwla3dHuVIGo44
 VrNvX5ZfLSBlsn0PLlTR9h9oQiX7ETD8q1n6Gk8c7UNl78o1qCGfK4Os3Mq2qG6wYs2i
 J7NAZCqC20wCsanDtiIHoEmTytc4zsA9535tWiN2EsGrb9avkTKqgMbZHt/E99kIQez9
 EKxWwH79tD8cX13Bnzw2TwzYMHRS8aU1vGlYW+JoUMcsZWQdm/ql5cozcPIcD5XL5WXH gA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u4b97r3cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 11:56:25 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A2Bt2Lv009442;
        Thu, 2 Nov 2023 11:56:24 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u4b97r3c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 11:56:24 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A29Ouuf000614;
        Thu, 2 Nov 2023 11:56:23 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1cmtekhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 11:56:23 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A2BuMCA11010772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Nov 2023 11:56:23 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD98358057;
        Thu,  2 Nov 2023 11:56:22 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92B4758058;
        Thu,  2 Nov 2023 11:56:20 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.114.184])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  2 Nov 2023 11:56:20 +0000 (GMT)
Message-ID: <2061e234534c4d406b92999b9ca5c7f2194e3c9d.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] rootfs: Use tmpfs for rootfs even if root= is given
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Rob Landley <rob@landley.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Milton D. Miller II" <mdmii@outlook.com>,
        Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "H. Peter Anvin" <hpa@zytor.com>,
        initramfs <initramfs@vger.kernel.org>
Date:   Thu, 02 Nov 2023 07:56:19 -0400
In-Reply-To: <6dae6aa6-e6c6-89d6-f9d7-7563708f7662@landley.net>
References: <20231031154417.621742-1-stefanb@linux.ibm.com>
         <2023103159-punctuate-amount-f09d@gregkh>
         <6dae6aa6-e6c6-89d6-f9d7-7563708f7662@landley.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LA3EKHwS9YWl5VU-g0QtntuPlTgb0O_q
X-Proofpoint-ORIG-GUID: XPN1q2d99Pws1JXGdbKDL4dcyZY7apea
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_01,2023-11-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=847 spamscore=0 phishscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2311020095
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-01 at 06:35 -0500, Rob Landley wrote:
> On 10/31/23 11:56, Greg Kroah-Hartman wrote:
> > On Tue, Oct 31, 2023 at 11:44:17AM -0400, Stefan Berger wrote:
> >> rootfs currently does not use tmpfs if the root= boot option is passed
> >> even though the documentation about rootfs (added in 6e19eded3684) in
> >> Documentation/filesystems/ramfs-rootfs-initramfs.rst states:
> >> 
> >>   If CONFIG_TMPFS is enabled, rootfs will use tmpfs instead of ramfs by
> >>   default.  To force ramfs, add "rootfstype=ramfs" to the kernel command
> >>   line.
> > 
> > At this point in time, is there even any difference between ramfs and
> > tmpfs anymore?  Why would you want to choose one over the other here?
> 
> I submitted a patch to fix this to the list multiple times, which got ignored as
> always. Most recently here:
> 
> https://lore.kernel.org/lkml/8244c75f-445e-b15b-9dbf-266e7ca666e2@landley.net/

Rob, the patch set wasn't upstreamed, but it certainly wasn't ignored. 
There were multiple comments.

Can you at least re-post "[PATCH 5/5] fix rootfstype=tmpfs" after
addressing the checkpatch.pl complaints?

-- 
thanks,

Mimi

