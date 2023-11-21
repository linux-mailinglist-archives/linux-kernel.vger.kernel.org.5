Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C7E7F3182
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbjKUOrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbjKUOrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:47:32 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D53610C;
        Tue, 21 Nov 2023 06:47:28 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALEk3tm014458;
        Tue, 21 Nov 2023 14:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Il+3Zk9hp5HPXXvA6SgYAW5XlRe/3nnrw4Xtqs9gj+s=;
 b=WcLAhtgRSqWuIUjUe6hNEbSxxML1cgZRGZ9SlhP9+p1EpwIP2wvAgJm9DDUTEuragW2o
 /8hm2vq9iEqx77qFYqA+A1HVdog+2V2Kg8761iLqayTfzz5DtpxM/gX+oixh76thfewy
 kloOCZ5InDfPvKgdlaE5vbT/R7Ok6lrzV6mgX69KbvwU1uqMj0g6g9RJ1qOfQIq4TYqZ
 8lFBJciMhFv/t3X8pNBaMUNJnDZbL2iflj6C3SA6oRKdTf2fp6QalFrinVTYKGVIaXLj
 NJpD/HJryPYqGsi2oJ9bFshLF9RaPX9QZ6sheFx0FFFUsedGeQwnYd932PvqQWdHYN9M Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ugxkn013y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 14:47:23 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALEl31K017203;
        Tue, 21 Nov 2023 14:47:22 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ugxkn013g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 14:47:22 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALDnIUM024887;
        Tue, 21 Nov 2023 14:47:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf9tk8vw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 14:47:21 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ALElIiG29032798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 14:47:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D677E2004D;
        Tue, 21 Nov 2023 14:47:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4D9A2004F;
        Tue, 21 Nov 2023 14:47:18 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Nov 2023 14:47:18 +0000 (GMT)
Date:   Tue, 21 Nov 2023 15:47:17 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Vishal Moola <vishal.moola@gmail.com>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [PATCH] pgtable: do not expose _refcount field via ptdesc
Message-ID: <20231121144717.6318-A-hca@linux.ibm.com>
References: <20231121120310.696335-1-agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121120310.696335-1-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RTfch-c1H22NI79LYQCs1Wnt6Z8SobN_
X-Proofpoint-GUID: fiBSlMlH0We5yBP55yGtCmvKv_vNJ-za
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_07,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=811 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 01:03:10PM +0100, Alexander Gordeev wrote:
> Since commit d08d4e7cd6bf ("s390/mm: use full 4KB page for 2KB PTE")
> _refcount field is not used for fragmented page tracking on s390 and
> there is no other code left that accesses this field explicitly.
> 
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  include/linux/mm_types.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 957ce38768b2..0330e0ddca11 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -401,11 +401,10 @@ FOLIO_MATCH(compound_head, _head_2a);
>   * @pmd_huge_pte:     Protected by ptdesc->ptl, used for THPs.
>   * @__page_mapping:   Aliases with page->mapping. Unused for page tables.
>   * @pt_mm:            Used for x86 pgds.
> - * @pt_frag_refcount: For fragmented page table tracking. Powerpc and s390 only.
> + * @pt_frag_refcount: For fragmented page table tracking. Powerpc only.
>   * @_pt_pad_2:        Padding to ensure proper alignment.
>   * @ptl:              Lock for the page table.
>   * @__page_type:      Same as page->page_type. Unused for page tables.
> - * @_refcount:        Same as page refcount. Used for s390 page tables.

I would guess that you need to describe _pt_pad_3 instead here, just
like it is done for the other two pad members.

And most likely you need to add Andrew to "To:" so he doesn't miss
this :)
