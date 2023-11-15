Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C093A7EC6A3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344328AbjKOPEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344370AbjKOPEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:04:02 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F25F9;
        Wed, 15 Nov 2023 07:03:59 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFEHnmd005518;
        Wed, 15 Nov 2023 15:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=1gH8NxWaFA5qUwko7wv2HPPf2iK/9pfu5WuYzwkOPxc=;
 b=AD+2zcTSriP5ABn8HDzqL1OYdZyNUdUyEX/yY+dZ2SaikLbeWnJQC+APJbi5nZidaVvm
 BYuvU+jCqeRKRnaAVbcoqFZReordXetrMkgQVH+7T5ZFFH6cemfoeQ8ugqCgZkPyBB/d
 Gs+Bq0eU+QcsDNfIfQP3R26+2J9tb1mZuVvZfQUTyT2+Q84fP1RxanNaPA8oqu0wfrKm
 rf75YeViDbsAt1oIIV+qyvsA52YwPRuHqzE4hHPVzdt/S7ALr7YjZIDjU34phpXo9usW
 boSAZwVuM+82lEayokLa7PhZx5AtIkG1C79vLNP16/SwNTsyroafY/1+xywucc+5cjcL WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucymd9j64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 15:03:46 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFEmVP8011477;
        Wed, 15 Nov 2023 15:03:45 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucymd9j5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 15:03:45 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDn8NX020588;
        Wed, 15 Nov 2023 15:03:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamxnfx5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 15:03:44 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AFF3ekw18612824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 15:03:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D722920049;
        Wed, 15 Nov 2023 15:03:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD1612004B;
        Wed, 15 Nov 2023 15:03:39 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.171.22.68])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
        Wed, 15 Nov 2023 15:03:39 +0000 (GMT)
Date:   Wed, 15 Nov 2023 16:03:37 +0100
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
Subject: Re: [PATCH 4/8] mm/memory_hotplug: introduce
 MEM_PHYS_ONLINE/OFFLINE memory notifiers
Message-ID: <20231115160337.5c60f50a@thinkpad-T15>
In-Reply-To: <7c85bd39-8b34-4b09-b503-b0a2f2e58b88@redhat.com>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
        <20231114180238.1522782-5-sumanthk@linux.ibm.com>
        <7c85bd39-8b34-4b09-b503-b0a2f2e58b88@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m7jmxsNML88q9YPmXCrcMDekD6mrNjzW
X-Proofpoint-ORIG-GUID: 9jx1kiZVVxArXGKk8vvsa0ANgA_WuipZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=421
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 19:27:35 +0100
David Hildenbrand <david@redhat.com> wrote:

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
> Sorry to say, no. No hacks please, and this is a hack for memory that 
> has already been added to the system.

IIUC, when we enter memory_block_online(), memory has always already
been added to the system, on all architectures. E.g. via ACPI events
on x86, or with the existing s390 hack, where we add it at boot time,
including memmap allocated from system memory. Without a preceding
add_memory() you cannot reach memory_block_online() via sysfs online.

The difference is that for s390, the memory is not yet physically
accessible, and therefore we cannot use the existing altmap support
in memory_block_online(), which requires that the memory is accessible
before it calls mhp_init_memmap_on_memory().

Currently, on s390 we make the memory accessible in the GOING_ONLINE
notifier, by sclp call to the hypervisor. That is too late for altmap
setup code in memory_block_online(), therefore we'd like to introduce
the new notifier, to have a hook where we can make it accessible
earlier, and after that there is no difference to how it works for
other architectures, and we can make use of the existing altmap support.

> 
> If you want memory without an altmap to suddenly not have an altmap 
> anymore, then look into removing and readding that memory, or some way 
> to convert offline memory.

We do not want to have memory suddenly not have an altmap support
any more, but simply get a hook so that we can prepare the memory
to have altmap support. This means making it physically accessible,
and calling __add_pages() for altmap support, which for other
architecture has already happened before.

Of course, it is a hack for s390, that we must skip __add_pages()
in the initial (arch_)add_memory() during boot time, when we want
altmap support, because the memory simply is not accessible at that
time. But s390 memory hotplug support has always been a hack, and
had to be, because of how it is implemented by the architecture.

So we replace one hack with another one, that has the huge advantage
that we do not need to allocate struct pages upfront from system
memory any more, for the whole possible online memory range.

And the current approach comes without any change to existing
interfaces, and minimal change to common code, i.e. these new
notifiers, that should not have any impact on other architectures.

What exactly is your concern regarding the new notifiers? Is it
useless no-op notifier calls on other archs (not sure if they
would get optimized out by compiler)?
