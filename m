Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A9D777658
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjHJK5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjHJK44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:56:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486881718
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:56:55 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AAr2lB009634;
        Thu, 10 Aug 2023 10:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=sCo/0B+O+ZmocbTkE102LHXYRaQ09GRJfhNtAKCGfhk=;
 b=Fp0Nvsby06OT14N+oyxH7izOpimO8ElI23AnQVPdZJEU5QponNzG1FOxbWbc/UwEhF5n
 aw4zPFoyHesYVwFOFJ3EAcBb+x99cY64+Zx8zTrjRaMA72euGdwuYZnPDlOca0YVEb07
 C0VoArDhM3rD5UyVWAxnUsNChQGY25WClQVO60iwsZxzPxsjK6l0fFw6aWTWYw5tRG16
 1AdKaaiVbDWGI19/V7XUyEzviIlMVs70pjUF9slQG+MA0ycKwwEGImDfJhRNaGCqNV1d
 Yz+4gvWEKRnDPYINc48jSq6L4+NzMs4Gqh+Isug0oX86C43QFvZH/XSJqkvGpoPpjmUn ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scxhjr1cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 10:56:04 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37AArReQ011316;
        Thu, 10 Aug 2023 10:56:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scxhjr1cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 10:56:03 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37A90kre007543;
        Thu, 10 Aug 2023 10:56:02 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa14ys6em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 10:56:02 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37AAu1hE26214986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 10:56:01 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0431258064;
        Thu, 10 Aug 2023 10:56:01 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BC2A58058;
        Thu, 10 Aug 2023 10:55:53 +0000 (GMT)
Received: from patel (unknown [9.61.51.89])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 10 Aug 2023 10:55:52 +0000 (GMT)
Message-ID: <30b5d85348d84891bf61d7c57370d8b46df8e1a0.camel@linux.ibm.com>
Subject: Re: [RFC 0/2] An attempt to improve SLUB on NUMA / under memory
 pressure
From:   Jay Patel <jaypatel@linux.ibm.com>
Reply-To: jaypatel@linux.ibm.com
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Feng Tang <feng.tang@intel.com>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        Binder Makin <merimus@google.com>, aneesh.kumar@linux.ibm.com,
        tsahu@linux.ibm.com, piyushs@linux.ibm.com, fengwei.yin@intel.com,
        ying.huang@intel.com, lkp <lkp@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Thu, 10 Aug 2023 16:25:49 +0530
In-Reply-To: <20230723190906.4082646-1-42.hyeyoo@gmail.com>
References: <20230723190906.4082646-1-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C2_DwTprtdZ13HTh7Mw2WHuIpD7MVksi
X-Proofpoint-ORIG-GUID: b_01eBTH3zvPbMPmp70Ks8WJJhQVlQcZ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=716
 adultscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-24 at 04:09 +0900, Hyeonggon Yoo wrote:
> Hello folks,
> 
> This series is motivated by kernel test bot report [1] on Jay's patch
> that modifies slab order. While the patch was not merged and not in
> the
> final form, I think it was a good lesson that changing slab order has
> more
> impacts on performance than we expected.
> 
> While inspecting the report, I found some potential points to improve
> SLUB. [2] It's _potential_ because it shows no improvements on
> hackbench.
> but I believe more realistic workloads would benefit from this. Due
> to
> lack of resources and lack of my understanding of *realistic*
> workloads,
> I am asking you to help evaluating this together.

Hi Hyeonggon,
I tried hackbench test on Powerpc machine with 16 cpus but
got ~32% of Regression with patch.

Results as 

+-------+----+---------+------------+------------+
|       |    | Normal  | With Patch |            |
+-------+----+---------+------------+------------+
| Amean | 1  | 1.3700  | 2.0353     | ( -32.69%) |
| Amean | 4  | 5.1663  | 7.6563     | (- 32.52%) |
| Amean | 7  | 8.9180  | 13.3353    | ( -33.13%) |
| Amean | 12 | 15.4290 | 23.0757    | ( -33.14%) |
| Amean | 21 | 27.3333 | 40.7823    | ( -32.98%) |
| Amean | 30 | 38.7677 | 58.5300    | ( -33.76%) |
| Amean | 48 | 62.2987 | 92.9850    | ( -33.00%) |
| Amean | 64 | 82.8993 | 123.4717   | ( -32.86%) |
+-------+----+---------+------------+------------+

Thanks
Jay Patel
> 
> It only consists of two patches. Patch #1 addresses inaccuracy in
> SLUB's heuristic, which can negatively affect workloads' performance
> when large folios are not available from buddy.
> 
> Patch #2 changes SLUB's behavior when there are no slabs available on
> the
> local node's partial slab list, increasing NUMA locality when there
> are
> available memory (without reclamation) on the local node from buddy.
> 
> This is early state, but I think it's a good enough to start
> discussion.
> Any feedbacks and ideas are welcome. Thank you in advance!
> 
> Hyeonggon
> 
> https://lore.kernel.org/linux-mm/202307172140.3b34825a-oliver.sang@intel.com
> [1]
> https://lore.kernel.org/linux-mm/CAB=+i9S6Ykp90+4N1kCE=hiTJTE4wzJDi8k5pBjjO_3sf0aeqg@mail.gmail.com
> [2]
> 
> Hyeonggon Yoo (2):
>   Revert "mm, slub: change percpu partial accounting from objects to
>     pages"
>   mm/slub: prefer NUMA locality over slight memory saving on NUMA
>     machines
> 
>  include/linux/slub_def.h |  2 --
>  mm/slab.h                |  6 ++++
>  mm/slub.c                | 76 ++++++++++++++++++++++++++----------
> ----
>  3 files changed, 55 insertions(+), 29 deletions(-)
> 

