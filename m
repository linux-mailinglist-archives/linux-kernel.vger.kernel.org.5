Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7427C7FDCD5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjK2QUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbjK2QTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:19:50 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DB31996;
        Wed, 29 Nov 2023 08:18:42 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATG3SlX002432;
        Wed, 29 Nov 2023 16:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=7Al7YW5EcJe38iOapGOTryhpkSoVdc5WNB+0kfMZscs=;
 b=D39fFs1jfE9PV+ZUVYROUdIZNqpcTFHOCkdcthGOaQOgwvPQ8FkyzN4UwwPTIcSv3ktB
 WdR0ck/mo+954QbNd9Z23tOZ+AWk3zSGQBLjXrX47ssgMlI4TkcoDOkAH/dh1o8qzW5B
 E1FLhiu/Or8d6aBoA9BtsoPsEXDppLwqF7Vjs1QTTafkxP8ZAYasMJ6qYRUa5bLJhHE5
 n7w9cP3bM4ZIlhR1qZx7bQqUkx21P4/knMZO8pvd9LOM3BaXd2njEV8T1hasQtLJ+5YN
 r0GfCNV/7i1Xm7bN5GGkEmIZrZxdLznCMl8cuao4hUdkRV2mqyASar+9N1MuK+04VCeY AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up8g28sqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 16:18:32 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ATGHCkB032409;
        Wed, 29 Nov 2023 16:18:31 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up8g28spd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 16:18:31 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATE7cAJ025719;
        Wed, 29 Nov 2023 16:18:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfk7xxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 16:18:30 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ATGIRbt47907102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Nov 2023 16:18:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BB6720043;
        Wed, 29 Nov 2023 16:18:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2F9620040;
        Wed, 29 Nov 2023 16:18:26 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 29 Nov 2023 16:18:26 +0000 (GMT)
Date:   Wed, 29 Nov 2023 17:18:25 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-mm <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] implement "memmap on memory" feature on s390
Message-ID: <ZWdkUURRCu6s11Rf@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20231128155227.1315063-1-sumanthk@linux.ibm.com>
 <20231128155634.9c325682d2cf87d0a6d48728@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128155634.9c325682d2cf87d0a6d48728@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qTrVLAn3wiWvCXazFliWEEALVKCXkl3I
X-Proofpoint-GUID: WN159P1Dg67ethR_7bWb_C68SBNQbkzl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_14,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=480 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311290124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 03:56:34PM -0800, Andrew Morton wrote:

Hi Andrew,

> The cover letter doesn't acutally have a description of what "memmap on
> memory" *is*.  A nice overview to help readers understand what they're
> about to look at.  A description of what value this feature brings to
> our users.  Use-cases.  That sort of thing.
> 
> I guess the [1/N] changelog covers it, but it's hard to tell.  It isn't
> exactly broad-sweep overview.
> 
> Probably something short would suffice.  There are plenty of examples
> on the mailing list, please take a look and send us something?

Sumanth is on vacation, I will try to answer.

This series brings "memmap on memory" support to s390 platform.
That is - allocate 'struct pages' array describing a memory block
being onlined not from available system memory, but from the
memory block itself.

This improves the current situation on s390, where struct pages
for all memory that potentially can be added to the system, is
preallocated, so that memory online will always succeed but at
the cost of significant memory consumption.

Unlike other architectures, the challenge s390 faces is the memory
block being onlined is not accessible at the time of hotplug event.
To make it physically accessible two new MEM_PREPARE_ONLINE and
MEM_FINISH_OFFLINE memory notifiers are added. That allows to succeed
"memmap on memory" initialization.

For the existing architectures the two new notifiers are unknown
and they are not affected in any way.

Thanks!
