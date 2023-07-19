Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF05758D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjGSF03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGSF01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:26:27 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E60CD2;
        Tue, 18 Jul 2023 22:26:26 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J57ew4016375;
        Wed, 19 Jul 2023 05:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UY9eRzpsP8GQl+06o8COfYvWwoeEZ3IyVjc0AqBVSDA=;
 b=HqPHMq5DY50UrHwMA+kh0U4vjCK8bPPmNq+5t29OSU0J+O/kuRCku7pVRpZZJdExSlps
 ffpmfu9jbte9HqbRCzUIfGQfLBT+CHTQUGiBHZxoFDyaz/aXd96R+mC0khgtW3cTN5xk
 C21F3/Ls2AUSHxI3vGFC5VsNhoTBLyz80MfNrMNruPWr+f9KJ0H3fX8SYPdPzo/ytBxo
 8OPm0hFW/LqQWnWLcHcwb8v2HSDcaV+uRsprfW7HuuAYbc2n9sAppMNYNkDxlb4bwnnC
 OVaYz4fs93hvfzV/LCZIO4aSKW+R227xl5k1CXmFnQVyIIcjmNeKpxPhFmucoIUB4HDB jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rx8uarxv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 05:25:00 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36J5HWak021174;
        Wed, 19 Jul 2023 05:24:59 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rx8uarxum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 05:24:59 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36J4HvET016875;
        Wed, 19 Jul 2023 05:24:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv5srs1ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 05:24:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36J5Oso923134850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 05:24:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C11012004B;
        Wed, 19 Jul 2023 05:24:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD90F20040;
        Wed, 19 Jul 2023 05:24:43 +0000 (GMT)
Received: from [9.43.21.186] (unknown [9.43.21.186])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jul 2023 05:24:43 +0000 (GMT)
Message-ID: <6762c880-6d2b-233f-6786-7ad5b0472dc7@linux.ibm.com>
Date:   Wed, 19 Jul 2023 10:54:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 04/13] powerpc: assert_pte_locked() use
 pte_offset_map_nolock()
Content-Language: en-US
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
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
 <e8d56c95-c132-a82e-5f5f-7bb1b738b057@google.com>
 <87msztbiy8.fsf@linux.ibm.com>
 <392f311f-83ac-a5a2-d16e-2c7736d1b577@google.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <392f311f-83ac-a5a2-d16e-2c7736d1b577@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7q90oElJg2CmupBk6GumnocMBX9ahL2e
X-Proofpoint-GUID: YantjdaBDNNQUApFPJ6DdS47ZMvQSDAB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_02,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 10:34 AM, Hugh Dickins wrote:
> On Tue, 18 Jul 2023, Aneesh Kumar K.V wrote:
>> Hugh Dickins <hughd@google.com> writes:
>>
>>> Instead of pte_lockptr(), use the recently added pte_offset_map_nolock()
>>> in assert_pte_locked().  BUG if pte_offset_map_nolock() fails: this is
>>> stricter than the previous implementation, which skipped when pmd_none()
>>> (with a comment on khugepaged collapse transitions): but wouldn't we want
>>> to know, if an assert_pte_locked() caller can be racing such transitions?
>>>
>>
>> The reason we had that pmd_none check there was to handle khugpaged. In
>> case of khugepaged we do pmdp_collapse_flush and then do a ptep_clear.
>> ppc64 had the assert_pte_locked check inside that ptep_clear.
>>
>> _pmd = pmdp_collapse_flush(vma, address, pmd);
>> ..
>> ptep_clear()
>> -> asset_ptep_locked()
>> ---> pmd_none
>> -----> BUG
>>
>>
>> The problem is how assert_pte_locked() verify whether we are holding
>> ptl. It does that by walking the page table again and in this specific
>> case by the time we call the function we already had cleared pmd .
> 
> Aneesh, please clarify, I've spent hours on this.
> 
> From all your use of past tense ("had"), I thought you were Acking my
> patch; but now, after looking again at v3.11 source and today's,
> I think you are NAKing my patch in its present form.
> 

Sorry for the confusion my reply created. 

> You are pointing out that anon THP's __collapse_huge_page_copy_succeeded()
> uses ptep_clear() at a point after pmdp_collapse_flush() already cleared
> *pmd, so my patch now leads that one use of assert_pte_locked() to BUG.
> Is that your point?
> 

Yes. I haven't tested this yet to verify that it is indeed hitting that BUG.
But a code inspection tells me we will hit that BUG on powerpc because of
the above details.

> I can easily restore that khugepaged comment (which had appeared to me
> out of date at the time, but now looks still relevant) and pmd_none(*pmd)
> check: but please clarify.
> 

That is correct. if we add that pmd_none check back we should be good here.


-aneesh
