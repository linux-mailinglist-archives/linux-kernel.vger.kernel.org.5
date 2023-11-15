Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101A17EC512
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344197AbjKOOXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344191AbjKOOXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:23:40 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AECE109;
        Wed, 15 Nov 2023 06:23:37 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFEB1j9017888;
        Wed, 15 Nov 2023 14:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=eTDY6KXlXr2hiadyHyz3mXgboWDGVlfhNlPxNwFUfNE=;
 b=mCGZ9e2hFOFICgQyZRXHemtGWxiWpWT/RpyjJZGvf/AGwjMxIehhhozZL1GZeBweAUrO
 pTpijGXY7ZVgR9N26IczRZScsiXGUtz2C7/LJMM7zwa8sFfsNw6KXAc5ttu9iqZIxzyB
 O86p/YG+BXfK7i1lsN/yqlOCmnnc4GmBF1idtD+ayQQW7PJV4TyyA9YXl/wKkJtWTzBa
 J48o4hMRLauJQhHyEKsenLO3DE+p+/gtxBMO4Vd7AwFOYKbf545g23rIKYP/OCyPT0Ye
 C9Oj+ZChUX++xJYyz7eruvQ4BwNZABS16IQaEm0o8Xto3xJYFi1J3YXKfWd1wOLrnoH7 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucyd6rnxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 14:23:25 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFEFtD6028859;
        Wed, 15 Nov 2023 14:23:25 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucyd6rnx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 14:23:24 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDn7ks028120;
        Wed, 15 Nov 2023 14:23:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uap5k78ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 14:23:23 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AFENKlB39846474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 14:23:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B15E22004D;
        Wed, 15 Nov 2023 14:23:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A22F20040;
        Wed, 15 Nov 2023 14:23:20 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.171.69.220])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 15 Nov 2023 14:23:20 +0000 (GMT)
Date:   Wed, 15 Nov 2023 15:23:18 +0100
From:   Sumanth Korikkar <sumanthk@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] mm/memory_hotplug: introduce MEM_PHYS_ONLINE/OFFLINE
 memory notifiers
Message-ID: <ZVTUVuZzSJmQqEvk@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
 <20231114180238.1522782-5-sumanthk@linux.ibm.com>
 <7c85bd39-8b34-4b09-b503-b0a2f2e58b88@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c85bd39-8b34-4b09-b503-b0a2f2e58b88@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ST_UVJkxcN1fi4LUEAUh2L93plw6oxrs
X-Proofpoint-ORIG-GUID: ZqaapDjjgDBpfEcGoHT3CKUTOP-x8wy9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 phishscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=1 spamscore=1
 mlxlogscore=229 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 07:27:35PM +0100, David Hildenbrand wrote:
> On 14.11.23 19:02, Sumanth Korikkar wrote:
> > Add new memory notifiers to mimic the dynamic ACPI event triggered logic
> > for memory hotplug on platforms that do not generate such events. This
> > will be used to implement "memmap on memory" feature for s390 in a later
> > patch.
> > 
> > Platforms such as x86 can support physical memory hotplug via ACPI. When
> > there is physical memory hotplug, ACPI event leads to the memory
> > addition with the following callchain:
> > acpi_memory_device_add()
> >    -> acpi_memory_enable_device()
> >       -> __add_memory()
> > 
> > After this, the hotplugged memory is physically accessible, and altmap
> > support prepared, before the "memmap on memory" initialization in
> > memory_block_online() is called.
> > 
> > On s390, memory hotplug works in a different way. The available hotplug
> > memory has to be defined upfront in the hypervisor, but it is made
> > physically accessible only when the user sets it online via sysfs,
> > currently in the MEM_GOING_ONLINE notifier. This requires calling
> > add_memory() during early memory detection, in order to get the sysfs
> > representation, but we cannot use "memmap on memory" altmap support at
> > this stage, w/o having it physically accessible.
> > 
> > Since no ACPI or similar events are generated, there is no way to set up
> > altmap support, or even make the memory physically accessible at all,
> > before the "memmap on memory" initialization in memory_block_online().
> > 
> > The new MEM_PHYS_ONLINE notifier allows to work around this, by
> > providing a hook to make the memory physically accessible, and also call
> > __add_pages() with altmap support, early in memory_block_online().
> > Similarly, the MEM_PHYS_OFFLINE notifier allows to make the memory
> > inaccessible and call __remove_pages(), at the end of
> > memory_block_offline().
> > 
> > Calling __add/remove_pages() requires mem_hotplug_lock, so move
> > mem_hotplug_begin/done() to include the new notifiers.
> > 
> > All architectures ignore unknown memory notifiers, so this patch should
> > not introduce any functional changes.
> 
> Sorry to say, no. No hacks please, and this is a hack for memory that has
> already been added to the system.
> 
> If you want memory without an altmap to suddenly not have an altmap anymore,
> then look into removing and readding that memory, or some way to convert
> offline memory.

Sorry, I couldnt get the context. Could you please give me more details?

Thanks
