Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152EA7E697E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjKILZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjKILZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:25:24 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8E02D63;
        Thu,  9 Nov 2023 03:25:22 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9BD52o001215;
        Thu, 9 Nov 2023 11:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=eaMQhWSWr74b4jVdBAEoDMqw5DsQSen2oaQOTxFTJ6Q=;
 b=gwfLN6Ntn6n/86NFzDi4jc02zLiEf7Ki0b4nHRZeyIc6ywFQpIOxEFFH6paGqsGZFOpd
 e3RcfbCMndg96OxI/H7iUppe/aAdQGSScs3fjo+lx42BxG9CDZAOeFsR58JwNz3SWfEb
 q9RzEAQ0oYJkvcHyPp0f+/xurKQraqNwzELhz5cKtrt6HoiNBgk4o/rOl8hxhlDlhIJG
 fOqJFJUshXFgl24t+MKEC73JTzVg+9qTjgsl2ZGb7sR8i1E7RCndut4W031f2h+umS1T
 BA2xg3QvreM/4wx9I3ov6mEe1lLIb23DGfXqB2/h40wkcVIsjVwtGYwmAcvBehwk3e60 tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8xbr0cey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 11:25:21 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A9BPKt2007573;
        Thu, 9 Nov 2023 11:25:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8xbr0c2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 11:25:19 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9B5Hci014372;
        Thu, 9 Nov 2023 11:22:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w223dpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 11:22:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A9BLvkS29229492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Nov 2023 11:21:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E321220049;
        Thu,  9 Nov 2023 11:21:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D2B520040;
        Thu,  9 Nov 2023 11:21:57 +0000 (GMT)
Received: from osiris (unknown [9.171.80.120])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  9 Nov 2023 11:21:57 +0000 (GMT)
Date:   Thu, 9 Nov 2023 12:21:55 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 2/4] KVM: s390: vsie: Fix length of facility list
 shadowed
Message-ID: <20231109112155.11754-A-hca@linux.ibm.com>
References: <20231108171229.3404476-1-nsg@linux.ibm.com>
 <20231108171229.3404476-3-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108171229.3404476-3-nsg@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QGBsi2CwgtrEZ7Cj0UFpKB2VgMETo9hf
X-Proofpoint-GUID: ngbPnWhIMjSQa3qp08IuszVUWpslFLgI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=518
 mlxscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 06:12:27PM +0100, Nina Schoetterl-Glausch wrote:
> The length of the facility list accessed when interpretively executing
> STFLE is the same as the hosts facility list (in case of format-0)
> When shadowing, copy only those bytes.
> The memory following the facility list need not be accessible, in which
> case we'd wrongly inject a validity intercept.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>  arch/s390/include/asm/facility.h |  6 ++++++
>  arch/s390/kernel/Makefile        |  2 +-
>  arch/s390/kernel/facility.c      | 21 +++++++++++++++++++++
>  arch/s390/kvm/vsie.c             | 12 +++++++++++-
>  4 files changed, 39 insertions(+), 2 deletions(-)
>  create mode 100644 arch/s390/kernel/facility.c

For the non-KVM part:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
