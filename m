Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468767F4510
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343771AbjKVLpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343553AbjKVLpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:45:11 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014DA1A8;
        Wed, 22 Nov 2023 03:45:07 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMBgjF1013336;
        Wed, 22 Nov 2023 11:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ILScWUFBohu5TA6QkuZBitynfNjUVrM4NkTm8HcUzIY=;
 b=K270VxXhggxrNwe1Xlj+i61gca1bo3B7g6L6LM9KDJMgB0hCRb9ABQHf8hnD8jgZ+jUe
 rCSwKsAqE8xyTzNbOjHGW2idCOP5ZKepvUHb8L8c8Dx+RTugImWA+c5+EjXCSM+pdvlN
 G6cpZ1OSpcHMTGMO4W210ecWeoOPKNR2D+WwZ58PyX6S8o5RY3EcGFjtxLa/EeFGt9L/
 Y5hDs1hEauzmPGLWrymsQxKs3+K+8DaO3LqyPU0HIfmSQ5s36RaQMxwkSKw3mXKGPgtL
 e09MYFPdUsO0L65b4hqCrO5a2JEIbiQxidRtZi1rC7+DouXO4UQeKsRoMHprAzYjNgUy 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhh0jr1y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 11:44:55 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AMBhWRX016509;
        Wed, 22 Nov 2023 11:44:54 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhh0jr1xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 11:44:54 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMAJsSf028656;
        Wed, 22 Nov 2023 11:44:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ufaa27171-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 11:44:53 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AMBioDL22938334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Nov 2023 11:44:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8E5F20043;
        Wed, 22 Nov 2023 11:44:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15A1E20040;
        Wed, 22 Nov 2023 11:44:50 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.171.80.61])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 22 Nov 2023 11:44:50 +0000 (GMT)
Date:   Wed, 22 Nov 2023 12:44:48 +0100
From:   Sumanth Korikkar <sumanthk@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
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
Message-ID: <ZV3psGGI5Bn9dbFD@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
 <ec3fcd7d-17a0-4901-9261-a204c2c50c52@redhat.com>
 <20231117140009.5d8a509c@thinkpad-T15>
 <ee492da8-74b4-4a97-8b24-73e07257f01d@redhat.com>
 <ZVys8HF1lgbA8u0c@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <c7b92ff8-44db-4e48-b0af-eb1b6818b16b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7b92ff8-44db-4e48-b0af-eb1b6818b16b@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X1AqukaWBFoaIPtex_EZKGfcXk12FrMp
X-Proofpoint-ORIG-GUID: C3uaEhlB_rODV9dILGnop85wr3xgbxtc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_07,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=654 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 08:24:48PM +0100, David Hildenbrand wrote:
> > diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> > index 7d2076583494..5c70707e706f 100644
> > --- a/include/linux/memory_hotplug.h
> > +++ b/include/linux/memory_hotplug.h
> > @@ -106,6 +106,11 @@ typedef int __bitwise mhp_t;
> >    * implies the node id (nid).
> >    */
> >   #define MHP_NID_IS_MGID		((__force mhp_t)BIT(2))
> > +/*
> > + * Mark memmap on memory (struct pages array) as inaccessible during memory
> > + * hotplug addition phase.
> > + */
> > +#define MHP_ALTMAP_INACCESSIBLE	((__force mhp_t)BIT(3))
> 
> If we go that path, maybe rather MHP_OFFLINE_INACCESSIBLE and document how
> this relates to/interacts with the memory notifier callbacks and the altmap.
> 
> Then, we can logically abstract this from altmap handling. Simply, the
> memory should not be read/written before the memory notifier was called.
> 
> In the core, you can do the poisioning for the altmap in that case after
> calling the notifier, probably in mhp_init_memmap_on_memory() as you do
> below.
ok, sure. Thanks.
> 
> >   /*
> >    * Extended parameters for memory hotplug:
> > diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> > index 744c830f4b13..9837f3e6fb95 100644
> > --- a/include/linux/memremap.h
> > +++ b/include/linux/memremap.h
> > @@ -25,6 +25,7 @@ struct vmem_altmap {
> >   	unsigned long free;
> >   	unsigned long align;
> >   	unsigned long alloc;
> > +	bool inaccessible;
> 
> We should then likely remember that information for the memory block, not
> the altmap.

Tried using inaccessible field in memory_block and observed that the
memory block is created following the success of arch_add_memory().
Hence, when conducting checks for inaccessible memory in
sparse_add_section() (regarding page poisoning), there is still a
reliance on mhp_flags conveyed through add_memory(). Subsequently, then
memory_block inaccessible state is set in create_memory_block_devices(). 

I hope this approach is fine.

On the other hand, relying on inaccessible flag in vmem_altmap could
make checks in arch_add_memory() and other functions easier I suppose.

> 
> [...]
> 
> > 
> > 
> > Approach 2:
> > ===========
> > Shouldnt kasan zero shadow mapping performed first before
> > accessing/initializing memmap via page_init_poisining()?  If that is
> 
> Likely the existing way. The first access to the poisoned memmap should be a
> write, not a read. But I didn't look into the details.
> 
> Can you try reproducing?
>

Executing page_init_poison() right before kasan_add_zero_shadow() in the
context of altmap usage did not result in a crash when I attempted to
reproduce it.

However, altmap + page_init_poisoning() within sparse_add_section(), a
crash occurs on our arch, as previously discussed in this thread.

Thank you
