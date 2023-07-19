Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C10759851
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGSO1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjGSO1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:27:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610E510F5;
        Wed, 19 Jul 2023 07:27:08 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JECD34007296;
        Wed, 19 Jul 2023 14:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=sqCPepFLBkIjt5JAghDAGMMRAecFvEbEAHTaHv7StA4=;
 b=fWwgAOnqpMRwDj5C8+A/dSuJrT0tROdWB7sMARd8mBo+xRpVTtCp+/1omci+OXee6H5f
 9LrNRV6FIGvZ3kYav4DsCmp5+CAI4Bx1nxNkQahZKOBWai2Wr1RpFDM+6CVubO0Yr8Gh
 upfJAx9vFU40Ge8ufnccL6cx0kOxO21unDp1997QalhyRuu+aOFdBteRRpsPtO0rt6R9
 ba5YyYyjYPRNp/EmsWJX0hz23O8yeYg99ShH8qB/svSFdEOE720ZgW5HJDXP6Ndc8M84
 svWt++Qneu6rmC9XEx27QtNoe9MwOFrkOskKkSkgXCLmhxdjlT0VFTt+ZDMMn23z4AGh /g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxhcxgawu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 14:25:15 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36JEDaw7012182;
        Wed, 19 Jul 2023 14:25:14 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxhcxgavw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 14:25:14 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36JBbHlN007106;
        Wed, 19 Jul 2023 14:25:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv80j7qxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 14:25:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36JEP9wg51773818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 14:25:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9920A2004B;
        Wed, 19 Jul 2023 14:25:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 256CF20043;
        Wed, 19 Jul 2023 14:25:08 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jul 2023 14:25:08 +0000 (GMT)
Date:   Wed, 19 Jul 2023 16:25:06 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 07/13] s390: add pte_free_defer() for pgtables
 sharing page
Message-ID: <20230719162506.235856eb@p-imbrenda>
In-Reply-To: <94eccf5f-264c-8abe-4567-e77f4b4e14a@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
        <94eccf5f-264c-8abe-4567-e77f4b4e14a@google.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vuiOSC4KH_FPIWCJ2t0CCG3oPSC3iQ5O
X-Proofpoint-ORIG-GUID: nsfYgGQiUgK_3ljX9gGN4xkSrT1C83gX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_09,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=974 impostorscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307190126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 21:38:35 -0700 (PDT)
Hugh Dickins <hughd@google.com> wrote:

[...]

> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
> +{
> +	struct page *page;
> +
> +	page = virt_to_page(pgtable);
> +	SetPageActive(page);
> +	page_table_free(mm, (unsigned long *)pgtable);
> +	/*
> +	 * page_table_free() does not do the pgste gmap_unlink() which
> +	 * page_table_free_rcu() does: warn us if pgste ever reaches here.
> +	 */
> +	WARN_ON_ONCE(mm_alloc_pgste(mm));

it seems I have overlooked something when we previously discussed
this...

mm_alloc_pgste() is true for all processes that have PGSTEs, not only
for processes that can run guests.

There are two ways to enable PGSTEs: an ELF header bit, and a sysctl
knob.

The ELF bit is only used by qemu, it enables PGSTE allocation only for
that single process. This is a strong indication that the process wants
to run guests.

The sysctl knob enables PGSTE allocation for every process in the system
from that moment on. In that case, the WARN_ON_ONCE would be triggered
when not necessary.

There is however another way to check if a process is actually
__using__ the PGSTEs, a.k.a. if the process is actually capable of
running guests.

Confusingly, the name of that function is mm_has_pgste(). This confused
me as well, which is why I didn't notice it when we discussed this
previously :)


in short: can you please use mm_has_pgste() instead of mm_alloc_pgste()
in the WARN_ON_ONCE ?

> +}
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
>  /*
>   * Base infrastructure required to generate basic asces, region, segment,
>   * and page tables that do not make use of enhanced features like EDAT1.

