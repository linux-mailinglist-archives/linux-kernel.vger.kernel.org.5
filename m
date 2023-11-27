Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956D77FA5D3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbjK0QMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbjK0QMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:12:44 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD20CE;
        Mon, 27 Nov 2023 08:12:51 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARGAsdj022874;
        Mon, 27 Nov 2023 16:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=NgfyGpTOtdTXmgIR1rMBGdvKmiMRXmvY4dwrfxHclcc=;
 b=AJOOxDQ/nRk1hfmtJ5zt5aNpSOODAahLCP9p5CKCzXfhqVNUa22qolMyDiObDTiMK+vG
 rtztcKamG43wbzerM5eBYccm2y06BEu6Hnnv1N1gS+ngqGXlw0IrqrxesZwHjpBRXNm9
 RUxoK45Pqkx2rmUiQdfJnOLDtO8amVRfOMM0lZzFXob+2+rlBpdj6WaJm8V5B0zkwff+
 oCtQehGzHFFT+Wk7JU+4h9fIDAcr972X8AcYYlg/Lh6yruMJurAOha7AFu3qTpuVzjyh
 SP0NHKBX167tmu8pbSLEAhI4jZtYRHpLbD10R7jomLG1b5yHPwQ+Pt4c+sAIOWPCD7Bd 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umxd782fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 16:12:36 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARGAliM022636;
        Mon, 27 Nov 2023 16:12:36 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umxd7827t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 16:12:36 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AREJqhY025568;
        Mon, 27 Nov 2023 16:12:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrk9m32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 16:12:27 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ARGCOMj22217220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 16:12:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 073C220043;
        Mon, 27 Nov 2023 16:12:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41B6320040;
        Mon, 27 Nov 2023 16:12:23 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.179.15.167])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 27 Nov 2023 16:12:23 +0000 (GMT)
Date:   Mon, 27 Nov 2023 17:12:21 +0100
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
Subject: Re: [PATCH v3 4/5] s390/mm: implement
 MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers
Message-ID: <ZWS/5ZzhGzt6ykfq@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20231127082023.2079810-1-sumanthk@linux.ibm.com>
 <20231127082023.2079810-5-sumanthk@linux.ibm.com>
 <abbe4d53-e944-46cc-90fc-a0a65e50b2fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abbe4d53-e944-46cc-90fc-a0a65e50b2fe@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PN3NCHQsMzDUckP9r7W1BHaI7o_e-YHN
X-Proofpoint-ORIG-GUID: zOq4w70tYDpTEwcLVE4xumYiWm_-H8vH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_14,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=385 suspectscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311270111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 04:11:05PM +0100, David Hildenbrand wrote:
> > diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
> > index 355e63e44e95..30b829e4c052 100644
> > --- a/drivers/s390/char/sclp_cmd.c
> > +++ b/drivers/s390/char/sclp_cmd.c
> > @@ -18,6 +18,7 @@
> >   #include <linux/mm.h>
> >   #include <linux/mmzone.h>
> >   #include <linux/memory.h>
> > +#include <linux/memory_hotplug.h>
> >   #include <linux/module.h>
> >   #include <asm/ctlreg.h>
> >   #include <asm/chpid.h>
> > @@ -26,6 +27,7 @@
> >   #include <asm/sclp.h>
> >   #include <asm/numa.h>
> >   #include <asm/facility.h>
> > +#include <asm/page-states.h>
> >   #include "sclp.h"
> > @@ -319,6 +321,7 @@ static bool contains_standby_increment(unsigned long start, unsigned long end)
> >   static int sclp_mem_notifier(struct notifier_block *nb,
> >   			     unsigned long action, void *data)
> >   {
> > +	struct memory_block *memory_block;
> >   	unsigned long start, size;
> >   	struct memory_notify *arg;
> >   	unsigned char id;
> > @@ -340,18 +343,29 @@ static int sclp_mem_notifier(struct notifier_block *nb,
> >   		if (contains_standby_increment(start, start + size))
> >   			rc = -EPERM;
> >   		break;
> > -	case MEM_GOING_ONLINE:
> > +	case MEM_PREPARE_ONLINE:
> > +		memory_block = find_memory_block(pfn_to_section_nr(arg->start_pfn));
> > +		if (!memory_block) {
> > +			rc = -EINVAL;
> > +			goto out;
> > +		}
> >   		rc = sclp_mem_change_state(start, size, 1);
> > +		if (rc || !memory_block->altmap)
> > +			goto out;
> > +		/*
> > +		 * Set CMMA state to nodat here, since the struct page memory
> > +		 * at the beginning of the memory block will not go through the
> > +		 * buddy allocator later.
> > +		 */
> > +		__arch_set_page_nodat((void *)__va(start), memory_block->altmap->free);
> 
> Looking up the memory block and grabbing the altmap from there is a bit
> unfortunate.
> 
> Why can't we do that when adding the altmap? Will the hypervisor scream at
> us?
> 
calling __arch_set_page_nodat() before making memory block accessible
will lead to crash. Hence, we think this is the only safe location to
place it.

> ... would we want to communicate any altmap start+size via the memory
> notifier instead?

Passing start, size  of memory range via memory notifier looks correct
approach to me, as we try to make the specified range accessible.

If we want to pass altmap size (nr_vmemmap_pages), then we might need a
new field in struct memory_notify, which would prevent access of
memory_block->altmap->free in the notifier.

Do you want to take this approach instead?

If yes, Then I could add a new field nr_vmemmap_pages in struct
memory_notify and place it in PATCH : introduce
MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers.


Thanks
