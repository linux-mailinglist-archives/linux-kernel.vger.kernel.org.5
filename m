Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A0F7EF3E9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjKQN5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQN5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:57:13 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8E9D51;
        Fri, 17 Nov 2023 05:57:10 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHDlHDd002417;
        Fri, 17 Nov 2023 13:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Mn8A3ocZ39kGIPi74lcUwSPGGhw2vQQP63Kkhg1QfZU=;
 b=n1ff8loeyDVf+gP3CgMCfC4yU5qnwecXLAQAg9CH+hTnIftwi+jnf3zRtrBlc0QIItd+
 NFDZlHs3JGtN2F8xgek40TBrD0yXKb6Gb9Xn64pCiZaWrjvjNkh212tlBVu6jI+nz8qz
 9TtcAvgp64mq9MmWOaCg1IjByQIp/0KQMEQyAbRZffyxHnx958wUTA2RE8osOuaRw9mA
 CiKO3AyOkLgL44yGum+T0xOUMTWDbpymlzt1X2G9ksq+V7UP1yr0tM/r88dmEZW46uuW
 J/qSoZac7EGxV0vmKZ/Afv+ogoPC0P6gmfpbLAabooNIlOdPL98S8QQdBG/+iGQB1FOG CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ue9c00e6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 13:56:58 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AHDmXnY007631;
        Fri, 17 Nov 2023 13:56:58 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ue9c00e60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 13:56:57 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHD48La015911;
        Fri, 17 Nov 2023 13:56:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uanem6688-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 13:56:56 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AHDurdn28377608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 13:56:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C47E2004B;
        Fri, 17 Nov 2023 13:56:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4222220040;
        Fri, 17 Nov 2023 13:56:52 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.171.27.169])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 17 Nov 2023 13:56:52 +0000 (GMT)
Date:   Fri, 17 Nov 2023 14:56:50 +0100
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
Subject: Re: [PATCH 0/8] implement "memmap on memory" feature on s390
Message-ID: <ZVdxInFyS8YtNOjF@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
 <ec3fcd7d-17a0-4901-9261-a204c2c50c52@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec3fcd7d-17a0-4901-9261-a204c2c50c52@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1GifuvWjsj_2j5Z19rWdfUA7kA8hPsNg
X-Proofpoint-ORIG-GUID: AypSkno244K_SEEdsFNfx71CpUm8yrQU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_12,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=12 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=12 mlxlogscore=87 malwarescore=0
 impostorscore=0 spamscore=12 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311170103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 12:08:31AM +0100, David Hildenbrand wrote:
> On 14.11.23 19:02, Sumanth Korikkar wrote:
> > Hi All,
> > 
> > The patch series implements "memmap on memory" feature on s390 and
> > provides the necessary fixes for it.
> 
> Thinking about this, one thing that makes s390x different from all the other
> architectures in this series is the altmap handling.
> 
> I'm curious, why is that even required?
> 
> A memmep that is not marked as online in the section should not be touched
> by anybody (except memory onlining code :) ). And if we do, it's usually a
> BUG because that memmap might contain garbage/be poisoned or completely
> stale, so we might want to track that down and fix it in any case.
> 
> So what speaks against just leaving add_memory() populate the memmap from
> the altmap? Then, also the page tables for the memmap are already in place
> when onlining memory.
>

we do have page_init_poison() in sparse_add_section() which should be
handled later then. not in add_pages()
> 
> Then, adding two new notifier calls on start of memory_block_online() called
> something like MEM_PREPARE_ONLINE and end the end of memory_block_offline()
> called something like MEM_FINISH_OFFLINE is still suboptimal, but that's
> where standby memory could be activated/deactivated, without messing with
> the altmap.
> 
> That way, the only s390x specific thing is that the memmap that should not
> be touched by anybody is actually inaccessible, and you'd
> activate/deactivate simply from the new notifier calls just the way we used
> to do.
ok. 

Thanks
