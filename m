Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B3D7ACB2F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 19:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjIXR6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 13:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXR6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 13:58:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A596FA;
        Sun, 24 Sep 2023 10:58:29 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38OHjTPu009471;
        Sun, 24 Sep 2023 17:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=7BtC9/lrc/fww1dep8gZWJTE7ouTVPIG0IE1y03qkt8=;
 b=jdZy/IajWMtVT9RlLZkKgV0AmwfAP3AOULSYkGu34a03NhmmlaOshXQNTlCQvJM3zeB/
 TUCdAJDQd5Ev0+qshRBEzFyxP0Yu3uLbg4XwpylZNdAOJ18/ZEVK36eAWk9CzoW1cIR9
 KuUpz8yThOUaIksuNZafdZVIVq3woX+R1Xo6ZBVmRxHOyu+UtFitbBpqkGEpWB0TPRf5
 eJx0bLwtQOgK9/LGx5HSGALegZP0ySjhP5SOjDTSTicK1ADOagQEtd8IfxmGKIqcHFVv
 aLp0rIU6xKZr4TN2a/PVI/3Nzj3wUdS4rcjhHAneefnRY5ejEmvi+4Uc5NarQ8rrySB0 BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ta6un7q2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Sep 2023 17:58:27 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38OHsahT026598;
        Sun, 24 Sep 2023 17:58:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ta6un7q2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Sep 2023 17:58:27 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38OHoZH7011010;
        Sun, 24 Sep 2023 17:58:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabujvdqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Sep 2023 17:58:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38OHwMEQ26804918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 24 Sep 2023 17:58:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C533920043;
        Sun, 24 Sep 2023 17:58:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1488A20040;
        Sun, 24 Sep 2023 17:58:22 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.29.239])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
        Sun, 24 Sep 2023 17:58:22 +0000 (GMT)
Date:   Sun, 24 Sep 2023 19:58:20 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Vineeth Vijayan <vneethv@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
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
Message-ID: <20230924195820.1a2865c3.pasic@linux.ibm.com>
In-Reply-To: <b9e9eca9-413c-0301-3839-bb7534ac76d2@linux.ibm.com>
References: <20230921071412.13806-1-dinghao.liu@zju.edu.cn>
        <20230922141700.10895474.pasic@linux.ibm.com>
        <87sf76z961.fsf@redhat.com>
        <20230922152035.3ef1cb7e.pasic@linux.ibm.com>
        <b9e9eca9-413c-0301-3839-bb7534ac76d2@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FxKv3IkqSwxGOiGuiFHnSmhr87GZ3GTv
X-Proofpoint-GUID: M5z6rkkoNYwFVYac1f8IEhuSeaQeflyd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-24_15,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 mlxlogscore=635 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309240154
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 21:15:48 +0200
Vineeth Vijayan <vneethv@linux.ibm.com> wrote:

> On 9/22/23 15:20, Halil Pasic wrote:
> >> Author of 2ec2298412e1 here. If I don't completely misremember things,
> >> this was for the orphanage stuff (i.e. ccw devices that were still kept
> >> as disconnected, like dasd still in use, that had to be moved from their
> >> old subchannel object because a different device appeared on that
> >> subchannel.) That orphanage used a single dummy subchannel for all ccw
> >> devices moved there.
> >>
> >> I have no idea how the current common I/O layer works, but that might
> >> give you a hint about what to look for 😄  
> > Yes, that is what the commit states and what the series is about. I hope
> > Vineeth can give us some answers 😄 maybe even out of the top of his
> > head... If not, I would trust his judgment on whether figuring things
> > out is worthwhile or not.
> >   
> As Corny mentioned, orphanage is the only case i remember where
> this scenario of dynamically allocated sch->lock  being used. I hope
> you remember the cdev->ccwlock, which is nothing but the copy of
> sch->lock pointer. This is rather a tricky design, where we are using 
> the sch->lock and cdev->ccwlock, which are same pointers.
> Because this sch is exclusively for the cdev ops. But at the same time,
> a CC3 code in the stsch can make the attached device an orphanage and
> remove the sch.
> 
> We have already seen an issue with this approach and had couple of
> discussions about avoiding this pointer usage without using an extra
> lock but do not have a right solution for this now.

Based on your response it seem you do understand the problem but are
struggling to find a solution. You are ahead of me. I'm still at the
stage where I don't understand the problem. I had another look at
that orphanage code, especially at ccw_device_move_to_sch(). Looks
to me that the *(sch->lock) ins not required outlive the *sch and
also that there is no move semantic in place.

Based on that let's take this offline, find a quiet hour and have a look 
at the code and the problem. Maybe I can help with the solution once I
understand the problem -- but maybe not.

Regards,
Halil
