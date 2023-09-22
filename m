Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E3C7AB1F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 14:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjIVMRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 08:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbjIVMRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:17:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1855AC2;
        Fri, 22 Sep 2023 05:17:11 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MC8fsg011142;
        Fri, 22 Sep 2023 12:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=R97ubYvMjJdYafM+f4An/yAk8mfklYJ4OeEpu37l+vA=;
 b=QbFRTcpkgHTEBElS16imzxNmOU15okiKRWAV1bM3FgREwjvRJQQOzd/WUe6PRVjcIy9g
 ltQj5jQGl3s2VKKcEwbnwuGFpAQR/MPdaVtD42gw8arsvif841DK7prY7Zo9g5hWJSDI
 dXeN2Cbb0DX5hiSgqrnzMB1NkeVwE0wrsv5YZHlREprTvKum4xiyWHYUDT4v6uY0yIIk
 9jk2p/qePtBa+dAh4gsfhcP7QNJU8ie0OqWqaLRKZ/cq6bg4BCmXGAXLxT0PuDreabgL
 a9Yec+GFfEgDJTSh7eksnx0SO6xVrGH8gAuLa46ITrnrIOPE2VNDvgWUYoYJ2Q9+U3UB OQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t990s2uvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 12:17:10 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38MBklTG025947;
        Fri, 22 Sep 2023 12:17:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t8tsq1bj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 12:17:09 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38MCH7Op24642162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 12:17:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E54092004D;
        Fri, 22 Sep 2023 12:17:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F74A20065;
        Fri, 22 Sep 2023 12:17:06 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.56.45])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
        Fri, 22 Sep 2023 12:17:05 +0000 (GMT)
Date:   Fri, 22 Sep 2023 14:17:00 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] s390/cio: Fix a memleak in css_alloc_subchannel
Message-ID: <20230922141700.10895474.pasic@linux.ibm.com>
In-Reply-To: <20230921071412.13806-1-dinghao.liu@zju.edu.cn>
References: <20230921071412.13806-1-dinghao.liu@zju.edu.cn>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c1uDwzBsyAvg7nWjwGBskB-Duz3EBIrk
X-Proofpoint-GUID: c1uDwzBsyAvg7nWjwGBskB-Duz3EBIrk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_10,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 mlxscore=0 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=989 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023 15:14:12 +0800
Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:

> When dma_set_coherent_mask() fails, sch->lock has not been
> freed, which is allocated in css_sch_create_locks(), leading
> to a memleak.
> 
> Fixes: 4520a91a976e ("s390/cio: use dma helpers for setting masks")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

@Vineeth: Do you know why is the spinlock "*sch->lock" allocated
dynamically and referenced via a pointer instead of making the
spinlock simply a member of struct subchannel and getting rid
of the extra allocation?

I did some archaeology together with Peter. The
lock used to be a member but then commit 2ec2298412e1 ("[S390]
subchannel lock conversion.") switched to (mostly) allocating
the lock separately. Mostly because of this hunk:

@@ -520,9 +530,15 @@ cio_validate_subchannel (struct subchannel *sch, struct subchannel_id schid)
        /* Nuke all fields. */
        memset(sch, 0, sizeof(struct subchannel));
 
-       spin_lock_init(&sch->lock);
+       sch->schid = schid;
+       if (cio_is_console(schid)) {
+               sch->lock = cio_get_console_lock();
+       } else {
+               err = cio_create_sch_lock(sch);
+               if (err)
+                       goto out;
+       }

I did not spend a huge amount of time looking at this but this
is the only reason I found for sch->lock being made a pointer. There may
be others, I'm just saying that is all I've found.

Since 863fc8492734 ("s390/cio: get rid of static console subchannel")
that reason with the console_lock is no more. And that brings me back to
the question: "Why?"

Regards,
Halil

[..]
