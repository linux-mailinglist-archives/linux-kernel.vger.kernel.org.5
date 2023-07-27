Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C897765290
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjG0LgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjG0LgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:36:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADC510DB;
        Thu, 27 Jul 2023 04:36:17 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RBXTlA013624;
        Thu, 27 Jul 2023 11:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=n77xLrBjesMnqc8Ua0RijNJREe5KgIP06dXhf+Po4jI=;
 b=Jzp7tHA2fE4y3z4d8hBRWxWU4QkgvSPT7PvaRbfANllP6nf0im0JqzIbO0wIFigN5dsD
 MG6LJsmqFEJBufS2T2tIXLUQKeP14g1BT/vrHyZNCkly0H2L7PcHZOrpbpfVc9Vgfxp3
 r9nC3/CK8CdRANGyiEv1NLBcz+tqz7LxYtskFFE8LTbd7a0x8/KRPF0445abYFZoLhp5
 y5Qh7ZRhyL3qmk2jm+tiFmds3COfdea5rtVwRVNSSAkAMW4VyWDZ0gXnWmYHiE8gcNYc
 ezWaKRR1IrXMTmm80YyU4dsznbjeVvl1UdOBxJWKykmRM/2HlIinvPgXk7EiwqYtLqqf Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3qn609mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 11:35:55 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36RBOhwA021459;
        Thu, 27 Jul 2023 11:35:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3qn609k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 11:35:55 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36RBWAGp003634;
        Thu, 27 Jul 2023 11:35:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0txkcyg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 11:35:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36RBZpYP50659618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jul 2023 11:35:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9496020043;
        Thu, 27 Jul 2023 11:35:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C49620040;
        Thu, 27 Jul 2023 11:35:51 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 27 Jul 2023 11:35:51 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v1] mm: Fix use-after-free for MMU_GATHER_NO_GATHER
References: <20230727110224.3333682-1-ryan.roberts@arm.com>
        <b3e305e9-26c3-d4f4-d0ce-79d79d98afe2@redhat.com>
Date:   Thu, 27 Jul 2023 13:35:50 +0200
In-Reply-To: <b3e305e9-26c3-d4f4-d0ce-79d79d98afe2@redhat.com> (David
        Hildenbrand's message of "Thu, 27 Jul 2023 13:15:27 +0200")
Message-ID: <yt9dcz0dbn8p.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1fMRO_cBvEkR_-lCWMaUkQPrL7-Znlwz
X-Proofpoint-GUID: MMyYcl_1-ZH4XEtHsy1_2Tnl6VRhg6oA
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 suspectscore=0 bulkscore=0 mlxlogscore=418 impostorscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan,

David Hildenbrand <david@redhat.com> writes:

> On 27.07.23 13:02, Ryan Roberts wrote:
>> The recent change to batch-zap anonymous ptes did not take into account
>> that for platforms where MMU_GATHER_NO_GATHER is enabled (e.g. s390),
>> __tlb_remove_page() drops a reference to the page. This means that the
>> folio reference count can drop to zero while still in use (i.e. before
>> folio_remove_rmap_range() is called). This does not happen on other
>> platforms because the actual page freeing is deferred.
>> Solve this by appropriately getting/putting the folio to guarrantee
>> it
>> does not get freed early.
>> Given the new need to get/put the folio in the batch path, let's
>> stick
>> to the non-batched path if the folio is not large. In this case batching
>> is not helpful since the batch size is 1.
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> Fixes: 904d9713b3b0 ("mm: batch-zap large anonymous folio PTE mappings")
>> Reported-by: Nathan Chancellor <nathan@kernel.org>
>> Link: https://lore.kernel.org/linux-mm/20230726161942.GA1123863@dev-arch.thelio-3990X/
>> ---
>> Hi Andrew,
>> This fixes patch 3 in the series at [1], which is currently in
>> mm-unstable. I'm
>> not sure whether you want to take the fix or whether I should re-post the entire
>> series?
>> 
>
> Please repost the complete thing, you're touching some sensible places
> that really need decent review.

Please also add:

Alexander Gordeev <agordeev@linux.ibm.com>
Gerald Schaefer <gerald.schaefer@linux.ibm.com>

when reposting. Thanks!
