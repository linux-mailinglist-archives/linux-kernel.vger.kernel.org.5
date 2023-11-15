Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7117EC404
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344008AbjKONpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343698AbjKONpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:45:46 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDAF9B;
        Wed, 15 Nov 2023 05:45:43 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDWMmc008780;
        Wed, 15 Nov 2023 13:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=RSS3oeqeS/CiWB6NMhIbg0WsBhrLrZytHWzGCO6Y3wo=;
 b=sW+hooDwL5v5ywyUDjZdEht0MNktRiimGTSk7FVlhyxYg4QDGYw5Sw03xbKgsyWGtg6i
 +zIvE3DY4xAnX5RDJQTzztTKK4x6c/vT0pOXC/DmP2NbnO/UrrJqw4xMN5Pj0jzj4VFt
 y1fgL28AfFamJXbEvqMO5ZBOQo1G+4nuPQYuVKaR5wq1F9iFKsBAog81UZvhpOnxpP84
 nqPgMkus6KNnLHfFwcjWCHb+cXEJ415cFz8U9iKSMMPSwBijnN+8QQUciZ+VsSbm4q7a
 mfkUq/wj7+koMnCw3qE65IstBe0Nim10XBVi0zlZ9mk0gsYOn+e6HdLe3fmDznMI+o4I gA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucxy3racv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 13:45:30 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFDixir019140;
        Wed, 15 Nov 2023 13:45:29 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucxy3rabt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 13:45:29 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDY4jD032564;
        Wed, 15 Nov 2023 13:45:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uakxsyuj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 13:45:28 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AFDjQiW18612744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 13:45:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3F422004B;
        Wed, 15 Nov 2023 13:45:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1357920040;
        Wed, 15 Nov 2023 13:45:25 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.171.69.220])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 15 Nov 2023 13:45:24 +0000 (GMT)
Date:   Wed, 15 Nov 2023 14:45:23 +0100
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
        LKML <linux-kernel@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 2/8] mm/memory_hotplug: fix error handling in
 add_memory_resource()
Message-ID: <ZVTLc+rcMVt17AKL@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
 <20231114180238.1522782-3-sumanthk@linux.ibm.com>
 <6c545504-e1a7-435b-aad9-b045247d6945@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c545504-e1a7-435b-aad9-b045247d6945@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dJVnrod4qTpVw3t4wCNh1TAkyvCTIqzK
X-Proofpoint-GUID: rGx_9bQQcJXlDzFlXlD6dgQwQdzf0Nwy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 clxscore=1011 bulkscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 mlxlogscore=421
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 07:36:20PM +0100, David Hildenbrand wrote:
> On 14.11.23 19:02, Sumanth Korikkar wrote:
> > In add_memory_resource(), creation of memory block devices occurs after
> > successful call to arch_add_memory(). However, creation of memory block
> > devices could fail.  In that case, arch_remove_memory() is called to
> > perform necessary cleanup.
> > 
> > Currently with or without altmap support, arch_remove_memory() is always
> > passed with altmap set to NULL during error handling. This leads to
> > freeing of struct pages using free_pages(), eventhough the allocation
> > might have been performed with altmap support via
> > altmap_alloc_block_buf().
> > 
> > Fix the error handling by passing altmap in arch_remove_memory(). This
> > ensures the following:
> > * When altmap is disabled, deallocation of the struct pages array occurs
> >    via free_pages().
> > * When altmap is enabled, deallocation occurs via vmem_altmap_free().
> > 
> > Fixes: db051a0dac13 ("mm/memory_hotplug: create memory block devices after arch_add_memory()")
> 
> That's the wrong commit. We didn't support memmap-on-memory back then.
> 
> Likely it should be:
> 
> Fixes: a08a2ae34613 ("mm,memory_hotplug: allocate memmap from the added
> memory range")
>
Ok, I will change it accordingly

Thanks
...
> 
> Indeed; this will conflict with Vishals patches, ccing him.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 
