Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AF37B02DB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjI0L0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjI0L00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:26:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B881A8;
        Wed, 27 Sep 2023 04:26:06 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RBCJXj019581;
        Wed, 27 Sep 2023 11:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=zaDKg/sOthAqsAeV4KNI4nrJjy4oAfJBx/xwQotlLbM=;
 b=Yct5r7glFMPtIALEPCD0KFgfcmvNIS92ZihPDC1qRBk7r6dht1B2n7CkAuUI3ekZnKIh
 tTChVqM70tPe5rCNi35gVaqlEp4hMNxJv4JeXAB4mU03EJEsczcBjwwgnn1AzMhzVXAr
 bDeNRHSKgUs6fn+ebf5s4HN2SnDzhCJfdYKY/Pi8p2miqF8CAuZ7Tc3XY7Kz9hlIdvOS
 dofxDvqaX9OaTyJS5YbjuSyOWkYE6mbH2xpYdnr98LpEb3PVoeQg4qFE1R9X/ymlmiBS
 0zexhca3cirbSgPDsLqHWm/YvwWUNg5Jf/Smjrvnj/rbbaTSGDqxHQK68X9vdIZ0Uda2 ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tckag89rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 11:25:43 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38RBD8Jm022055;
        Wed, 27 Sep 2023 11:25:42 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tckag89r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 11:25:42 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38R9qQ1j030746;
        Wed, 27 Sep 2023 11:25:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tacjk2nd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 11:25:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38RBPcsx22610616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 11:25:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DC1520040;
        Wed, 27 Sep 2023 11:25:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2027920049;
        Wed, 27 Sep 2023 11:25:38 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.152.224.212])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 27 Sep 2023 11:25:38 +0000 (GMT)
Date:   Wed, 27 Sep 2023 13:25:36 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Message-ID: <20230927132536.4b19ab2f.pasic@linux.ibm.com>
In-Reply-To: <877coc2aj8.fsf@redhat.com>
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
        <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
        <877coc2aj8.fsf@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p8YYw4faLgXLXLhjv7-7jONu4hPNxosP
X-Proofpoint-GUID: yb10tZ8FN2SVPf-XJEXl-ThNzyYU-cf2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_06,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0
 mlxlogscore=625 clxscore=1015 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2023 12:08:43 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> > On the other hand virtio_airq_handler() calls vring_interrupt() with
> > interrupts enabled. (While vring_interrupt() is called in a (read)
> > critical section in virtio_airq_handler() we use read_lock() and
> > not read_lock_irqsave() to grab the lock. Whether that is correct in
> > it self (i.e. disregarding the crypto problem) or not I'm not sure right
> > now. Will think some more about it tomorrow.) If the way to go forward
> > is disabling interrupts in virtio-ccw before vring_interrupt() is
> > called, I would be glad to spin a patch for that.  
> 
> virtio_airq_handler() is supposed to be an interrupt handler for an
> adapter interrupt -- as such I would expect it to always run with
> interrupts disabled (and I'd expect vring_interrupt() to be called
> with interrupts disabled as well; if that's not the case, I think it
> would need to run asynchronously.) At least that was my understanding at
> the time I wrote the code.

Thanks Connie! I don't quite understand what do you mean by "run with
interrupts disabled" in this context.

Do you mean that if I were to add the following warning:

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index ac67576301bf..2a9c73f5964f 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -211,6 +211,8 @@ static void virtio_airq_handler(struct airq_struct *airq,
        struct airq_info *info = container_of(airq, struct airq_info, airq);
        unsigned long ai;
 
+       WARN_ONCE(in_irq(), "irqs are ought to be disabled but are not\n");
+
        inc_irq_stat(IRQIO_VAI);

it would/should never trigger, or do you mean something different?

If yes, does that mean that you would expect the common airq code (i.e. something
like do_airq_interrupt()) to disable interrupts, or call virtio_airq_handler()?
asynchronously sort of as a bottom half (my understanding of bottom halves is currently
not complete).

If no what do you actually mean?

Regards,
Halil

Regards,
Halil

