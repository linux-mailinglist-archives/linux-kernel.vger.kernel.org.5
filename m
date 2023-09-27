Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9491B7B0510
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjI0NRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjI0NRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:17:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBAFF4;
        Wed, 27 Sep 2023 06:17:13 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RD8NP1001446;
        Wed, 27 Sep 2023 13:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Jyr/4l519Hb08MsN0HL9kt5kqv7LSkItoalV618mZTM=;
 b=YWxNO3aa32d56taiy1VSF4OZDqDHDL9VMyzhhtPStgt9JftSJp1/TTGuIkSjCbgmmEFs
 fcpvUQfNhLsNiHsMkTtfeA/DDhfzGtfgpJPlq/klebb/S4osaLJaxtkJjt2bwf6n5Gb5
 /WVwPYTIkkpG120loTYAWmvhpf/N9EtFxDqBaLLOUzOaEdc1Kp47+mWR1yIQlC9/tdvY
 JK8Mzp9FLGDaqsZdSnxWY6F4Zit1fCqN5WS6/Zci3mIBM9eYico0imhLIYcu6F6sOSho
 e+LZgwo26c9uUqcTjKNfE8kdXAZWM1lt91AjTuMFHZrfk7Tj279BbN+lSNpis8soNB3T /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tckj1aw6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 13:16:48 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38RD8M0P001413;
        Wed, 27 Sep 2023 13:16:47 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tckj1aw42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 13:16:47 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38RD8KTG008150;
        Wed, 27 Sep 2023 13:11:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3taaqykxt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 13:11:44 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38RDBftk26018400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 13:11:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 687972004B;
        Wed, 27 Sep 2023 13:11:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18E2120040;
        Wed, 27 Sep 2023 13:11:41 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.152.224.212])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 27 Sep 2023 13:11:41 +0000 (GMT)
Date:   Wed, 27 Sep 2023 15:11:38 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>
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
Message-ID: <20230927151138.1ebf82a6.pasic@linux.ibm.com>
In-Reply-To: <874jjf3jdo.fsf@redhat.com>
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
        <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
        <877coc2aj8.fsf@redhat.com>
        <20230927132536.4b19ab2f.pasic@linux.ibm.com>
        <874jjf3jdo.fsf@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1gHewhPRutBXCAztHqXy5XFNU1knVyuQ
X-Proofpoint-ORIG-GUID: Ahn5fNry-NPhtqex0P4cLFesAgZPbnVL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_07,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=666
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2023 14:12:19 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, Sep 27 2023, Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Wed, 27 Sep 2023 12:08:43 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >  
> >> > On the other hand virtio_airq_handler() calls vring_interrupt() with
> >> > interrupts enabled. (While vring_interrupt() is called in a (read)
> >> > critical section in virtio_airq_handler() we use read_lock() and
> >> > not read_lock_irqsave() to grab the lock. Whether that is correct in
> >> > it self (i.e. disregarding the crypto problem) or not I'm not sure right
> >> > now. Will think some more about it tomorrow.) If the way to go forward
> >> > is disabling interrupts in virtio-ccw before vring_interrupt() is
> >> > called, I would be glad to spin a patch for that.    
> >> 
> >> virtio_airq_handler() is supposed to be an interrupt handler for an
> >> adapter interrupt -- as such I would expect it to always run with
> >> interrupts disabled (and I'd expect vring_interrupt() to be called
> >> with interrupts disabled as well; if that's not the case, I think it
> >> would need to run asynchronously.) At least that was my understanding at
> >> the time I wrote the code.  
> >
> > Thanks Connie! I don't quite understand what do you mean by "run with
> > interrupts disabled" in this context.
> >
> > Do you mean that if I were to add the following warning:
> >
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > index ac67576301bf..2a9c73f5964f 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -211,6 +211,8 @@ static void virtio_airq_handler(struct airq_struct *airq,
> >         struct airq_info *info = container_of(airq, struct airq_info, airq);
> >         unsigned long ai;
> >  
> > +       WARN_ONCE(in_irq(), "irqs are ought to be disabled but are not\n");
> > +
> >         inc_irq_stat(IRQIO_VAI);
> >
> > it would/should never trigger, or do you mean something different?
> >
> > If yes, does that mean that you would expect the common airq code (i.e. something
> > like do_airq_interrupt()) to disable interrupts, or call virtio_airq_handler()?
> > asynchronously sort of as a bottom half (my understanding of bottom halves is currently
> > not complete).
> >
> > If no what do you actually mean?  
> 
> My understanding (at the time) was that we're coming from the low-level
> interrupt handler (which disables interrupts via the NEW PSW);
> interrupts will be re-enabled once the basic processing is done. This
> might no longer be the case, but I currently don't have the time to dig
> into the code -- it has been some time.
> 

It disables IO interrupts. I happen to have the PSW :) But AFAIU we may
still get machine check type interrupts.

So I'm leaning towards: the code is actually safe, but I will double
check again. But then what we do on s390x probably does not fit well
with Linux abstractions. AFAIU in Linux we don't have the granularity
"this lock is used in irq context but only IO irq context, so we don't
care that we may get interrupted by a non-IO irq"...

This complication is why I asked what do you mean by "run with
interrupts disabled", because this code does run with "IO interrupts
locally disabled, but not with *all* interrupts disabled".

I fully understand that you are bandwith limited. I'm adding
Peter and Vineeth, since this also concerns CIO. The easy fix for
this warning is to disable interrupts locally I guess.

In any case I will take care of this one way or another.

Thanks Conny! 

Regards,
Halil



