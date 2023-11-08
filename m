Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C647E54B8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343731AbjKHLIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjKHLI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:08:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D75186;
        Wed,  8 Nov 2023 03:08:26 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8B2aRo011941;
        Wed, 8 Nov 2023 11:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=wQfsumlE/4KoVpeoY1BBvoVwdlPJMYBZO0PvYuw9GAA=;
 b=ezLT5BtM23jrLTJz86sfNz+L2x30QhN11Nl1s7YeHiaHMh/LZ/XN2QzzmuFgnmNa00M3
 AkVRAzNUL68hRMU/hasm0WmBDaBvpVkuxxvGpvx+boG9QB3ncyJ12/HM7PJz2pRXdH0u
 RiLjcsJkJZu1yJ8cyZF9dS/oyfXpYilc7/ahfkZpIRx9i9Z6YFwuIainUJEkS623kvl3
 buIxe+0THqS00QCl9DE3P8suz341v/AZJPCVYzl8/sPZpZdPRw7cTha9k4481t/dBi/e
 Cx3dk1EOdavToMwOxKZv0JnrCj4ViGMDF7291datqNsUa33IhuxIbu6unz+Y4hsToCA3 HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u893y8ja2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 11:08:25 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A8B3Oqi018887;
        Wed, 8 Nov 2023 11:06:32 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u893y8j7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 11:06:31 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A88V7u7019256;
        Wed, 8 Nov 2023 11:06:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w23v6nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 11:06:28 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A8B6Q4l39518652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Nov 2023 11:06:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E510520049;
        Wed,  8 Nov 2023 11:06:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE25520040;
        Wed,  8 Nov 2023 11:06:25 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  8 Nov 2023 11:06:25 +0000 (GMT)
Date:   Wed, 8 Nov 2023 12:06:24 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v2 2/4] KVM: s390: vsie: Fix length of facility list
 shadowed
Message-ID: <20231108110624.7251-A-hca@linux.ibm.com>
References: <20231107123118.778364-1-nsg@linux.ibm.com>
 <20231107123118.778364-3-nsg@linux.ibm.com>
 <20231107181105.3143f8f7@p-imbrenda>
 <2fb17d9dd20078bc995887a3699dd008403b50ff.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fb17d9dd20078bc995887a3699dd008403b50ff.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: k7cIoA4QfR4280xEaLLFQJ8u5442OXAy
X-Proofpoint-GUID: 2APF8igC4Vy7ixo-aIW0JMT8yNeAXB_2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxlogscore=817
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 11:30:09AM +0100, Nina Schoetterl-Glausch wrote:
> On Tue, 2023-11-07 at 18:11 +0100, Claudio Imbrenda wrote:
> > On Tue,  7 Nov 2023 13:31:16 +0100
> > Nina Schoetterl-Glausch <nsg@linux.ibm.com> wrote:
> > 
> > [...]
> > 
> > > -obj-y	+= smp.o text_amode31.o stacktrace.o abs_lowcore.o
> > > +obj-y	+= smp.o text_amode31.o stacktrace.o abs_lowcore.o facility.o
> > >  
> > >  extra-y				+= vmlinux.lds
> > >  
> > > diff --git a/arch/s390/kernel/facility.c b/arch/s390/kernel/facility.c
> > > new file mode 100644
> > > index 000000000000..5e80a4f65363
> > > --- /dev/null
> > > +++ b/arch/s390/kernel/facility.c
> > 
> > I wonder if this is the right place for this?
> 
> I've wondered the same :D
> > 
> > This function seems to be used only for vsie, maybe you can just move
> > it to vsie.c? or do you think it will be used elsewhere too?
> 
> It's a general STFLE function and if I put it into vsie.c I'm not sure
> that, if the same functionality was required somewhere else, it would be
> found and moved to a common location.
> 
> I was also somewhat resistant to calling a double underscore function from
> vsie.c. Of course I could implement it with my own inline asm...
> 
> The way I did it seemed nicest, but if someone else has a strong opinion
> I'll defer to that.

I think it is ok to have new file for just this. It is better than what
we've done too often in the past: dump new functionality to some more or
less random file instead. The usual victim would have been setup.c.

So I prefer a new file, even if we end up with only one function there.
