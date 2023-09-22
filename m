Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7198F7AB298
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbjIVNVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjIVNVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:21:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A72CE;
        Fri, 22 Sep 2023 06:21:25 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MD8ErB019058;
        Fri, 22 Sep 2023 13:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=041NcSK2xg9vELUbnnz/VC6KKr0Lk8fdF4ubzdiGFFM=;
 b=digRi2aGOht/6sTZvhvY6fQ4TSvd+tu7V7AemBoP3DQJyIwuzWxcTF9RK5fQaJ+JxyPh
 imem18SfVJKZqtq/LVAQi7B+BvSWKkWjX5EchiqSfyOiP4/9Vpm6Jix8xjPJcfQ1GEc+
 tP6QxzKVOMK4xRszxRVi0NAygQSc7PeB/6e37Y8ITZljpiN/Pd3kPt7YkMwm+cWth8FW
 c/uNaY7vLVKnVbzIQ4DhFdmgl9KjhzYhNstd4oF26eBLQu6jTRmAgUfiEVIOLvvxF/58
 VB8Wsk2KnFFZLh9t64HVnI+KN7JTXP2uLY4YQI/sA6bt8mOp+9jz88GMztbN9X1lEHAf +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t9bap0v1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 13:21:24 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38MDAmK8028390;
        Fri, 22 Sep 2023 13:21:23 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t9bap0v0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 13:21:23 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38MDIx10026005;
        Fri, 22 Sep 2023 13:21:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t8tsq2ghx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 13:21:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38MDKcFk9044266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 13:20:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5484D20071;
        Fri, 22 Sep 2023 13:20:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CF662006A;
        Fri, 22 Sep 2023 13:20:37 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.56.45])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
        Fri, 22 Sep 2023 13:20:37 +0000 (GMT)
Date:   Fri, 22 Sep 2023 15:20:35 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
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
Message-ID: <20230922152035.3ef1cb7e.pasic@linux.ibm.com>
In-Reply-To: <87sf76z961.fsf@redhat.com>
References: <20230921071412.13806-1-dinghao.liu@zju.edu.cn>
        <20230922141700.10895474.pasic@linux.ibm.com>
        <87sf76z961.fsf@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zApFOfvF3wOAuMO5TvD1YZs04XXQLaB5
X-Proofpoint-ORIG-GUID: 2aKb4tSnqQWCEUmT5N7wkdDRawNhfUI2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_11,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxlogscore=727 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 suspectscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309220111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 14:25:58 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> > -       spin_lock_init(&sch->lock);
> > +       sch->schid = schid;
> > +       if (cio_is_console(schid)) {
> > +               sch->lock = cio_get_console_lock();
> > +       } else {
> > +               err = cio_create_sch_lock(sch);
> > +               if (err)
> > +                       goto out;
> > +       }
> >
> > I did not spend a huge amount of time looking at this but this
> > is the only reason I found for sch->lock being made a pointer. There may
> > be others, I'm just saying that is all I've found.  
> 
> Author of 2ec2298412e1 here. If I don't completely misremember things,
> this was for the orphanage stuff (i.e. ccw devices that were still kept
> as disconnected, like dasd still in use, that had to be moved from their
> old subchannel object because a different device appeared on that
> subchannel.) That orphanage used a single dummy subchannel for all ccw
> devices moved there.
> 
> I have no idea how the current common I/O layer works, but that might
> give you a hint about what to look for :)

Yes, that is what the commit states and what the series is about. I hope
Vineeth can give us some answers :) maybe even out of the top of his
head... If not, I would trust his judgment on whether figuring things
out is worthwhile or not.


Regards,
Halil
