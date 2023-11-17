Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD047EF33D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346044AbjKQNA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbjKQNAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:00:47 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BBE19A2;
        Fri, 17 Nov 2023 05:00:31 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHCkEoG016411;
        Fri, 17 Nov 2023 13:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=EpvSzij4IZzTP17DO04zM9nABo0pm+CaKulGeqPxxN0=;
 b=kJJCUDZO9RDM3R4qNFVDulDl8JZJjIXKWgEiljzpUrUCNcab7dAC/rOH6V23pzxyQjGG
 awv2Jtz7VCCB67aeuT8vzmxygmM42x/BDfyBfbTxHKr3Mq/JKeNJjCiEYbVNbtZ3O7nH
 duI7eEe9lUWrzxGukG1c0gwPM8fpRVJofcLHLCMIBAztHVFIQPPIF3jAyPDi76j0ynIS
 2HMWw6SABBP2DNcXRCDYfyWNjHPO5UqfaWCtpMYkzRWvDLGfpvZYY2SFWqVgc7i+dFQ9
 urrElO1Tu7fsPPACYHjZy1VCL3fUnChkMussq+qETyquyxlBfOXmGwKWufEiQs5n0Rlb VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ue84f133h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 13:00:17 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AHCl0qS023197;
        Fri, 17 Nov 2023 13:00:17 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ue84f131p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 13:00:17 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHCnC36018248;
        Fri, 17 Nov 2023 13:00:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uakxteaxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 13:00:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AHD0DVQ34800068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 13:00:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C04020040;
        Fri, 17 Nov 2023 13:00:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F35A520043;
        Fri, 17 Nov 2023 13:00:11 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.171.21.29])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
        Fri, 17 Nov 2023 13:00:11 +0000 (GMT)
Date:   Fri, 17 Nov 2023 14:00:09 +0100
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] implement "memmap on memory" feature on s390
Message-ID: <20231117140009.5d8a509c@thinkpad-T15>
In-Reply-To: <ec3fcd7d-17a0-4901-9261-a204c2c50c52@redhat.com>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
        <ec3fcd7d-17a0-4901-9261-a204c2c50c52@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _8IgcNhl1Q3EjoPKWdhOS6W_f4Yeuo_X
X-Proofpoint-GUID: wzc4NKEfP-r6KnWa28LVOQQokw-7Hbrr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_11,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=51 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 malwarescore=0 spamscore=51 mlxlogscore=-1 clxscore=1015
 mlxscore=51 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 00:08:31 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 14.11.23 19:02, Sumanth Korikkar wrote:
> > Hi All,
> > 
> > The patch series implements "memmap on memory" feature on s390 and
> > provides the necessary fixes for it.  
> 
> Thinking about this, one thing that makes s390x different from all the 
> other architectures in this series is the altmap handling.
> 
> I'm curious, why is that even required?
> 
> A memmep that is not marked as online in the section should not be 
> touched by anybody (except memory onlining code :) ). And if we do, it's 
> usually a BUG because that memmap might contain garbage/be poisoned or 
> completely stale, so we might want to track that down and fix it in any 
> case.
> 
> So what speaks against just leaving add_memory() populate the memmap 
> from the altmap? Then, also the page tables for the memmap are already 
> in place when onlining memory.

Good question, I am not 100% sure if we ran into bugs, or simply assumed
that it is not OK to call __add_pages() when the memory for the altmap
is not accessible.

Maybe there is also already a common code bug with that, s390 might be
special but that is often also good for finding bugs in common code ...

> Then, adding two new notifier calls on start of memory_block_online() 
> called something like MEM_PREPARE_ONLINE and end the end of 
> memory_block_offline() called something like MEM_FINISH_OFFLINE is still 
> suboptimal, but that's where standby memory could be 
> activated/deactivated, without messing with the altmap.
> 
> That way, the only s390x specific thing is that the memmap that should 
> not be touched by anybody is actually inaccessible, and you'd 
> activate/deactivate simply from the new notifier calls just the way we 
> used to do.
> 
> It's still all worse than just adding/removing memory properly, using a 
> proper interface -- where you could alloc/free an actual memmap when the 
> altmap is not desired. But I know that people don't want to spend time 
> just doing it cleanly from scratch.

Yes, sometimes they need to be forced to do that :-)

So, we'll look into defining a "proper interface", and treat patches 1-3
separately as bug fixes? Especially patch 3 might be interesting for arm,
if they do not have ZONE_DEVICE, but still use the functions, they might
end up with the no-op version, not really freeing any memory.
