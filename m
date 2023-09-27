Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6237B021C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjI0Koe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI0Kob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:44:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74F613A;
        Wed, 27 Sep 2023 03:44:30 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RAcnIL004125;
        Wed, 27 Sep 2023 10:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=4hh9pQFoSQtWQmXHc6fkRjVQoy1/XTcQP3OWu3H0GiQ=;
 b=r2Gt5D4IcbtQRXa3vjUo3j3t8gnpmvczDrfLNmp/3WUaUlb6qtlcVi+4kJa6z9Fc/4r+
 eVeAaqissBiWYi14yqXZSzzqiN+R4j1ov/Gvr4dpW7arfuxRbpcNvfY9mSsu7CfZoV4v
 NJSwOSoi3glYLyRYfvTjeUVRehGXxtoV7q7OIUhOvQiB3EgNX/y5VG4wOhwhOnCkbmCZ
 2r6ehgQ0I455+ltowlypHPIHbc6yplWHS0qztKGBd7CY+m/gzUD8a/Cy9VUksDwbBS/f
 cMqX6uWh32/LiYiRfs3B7O3n0sdLDqVyb6tVCrNyRUAeUcxIgHqbjgAHO4hIidy4FuxI vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcjewrphn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 10:44:26 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38RAdNWU006762;
        Wed, 27 Sep 2023 10:44:26 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcjewrphc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 10:44:26 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38R9bnru010996;
        Wed, 27 Sep 2023 10:44:25 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabukjky0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 10:44:25 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38RAiOOd40108488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 10:44:24 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9591758058;
        Wed, 27 Sep 2023 10:44:24 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CC4B58057;
        Wed, 27 Sep 2023 10:44:24 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.13.22])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 27 Sep 2023 10:44:23 +0000 (GMT)
Message-ID: <0d71b67e129b095ea698b39d0b1d05119bd0b464.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Oleksandr Tymoshenko <ovt@google.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nayna Jain <nayna@linux.ibm.com>
Cc:     rnv@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 27 Sep 2023 06:44:23 -0400
In-Reply-To: <CACGj0Cgh7Vjf5EcY7F+pf9bCjXhhJYN-xf3NeC8WWjT4+j9RrA@mail.gmail.com>
References: <20230921064506.3420402-1-ovt@google.com>
         <CACGj0Cgh7Vjf5EcY7F+pf9bCjXhhJYN-xf3NeC8WWjT4+j9RrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yPVR1wZ2GPRfNAZc7aHrDbG4F0Oo93fA
X-Proofpoint-ORIG-GUID: lQms7bM5daC611CdLTZVr0jymAgkAz6G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_05,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=433
 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-25 at 21:20 -0700, Oleksandr Tymoshenko wrote:
> On Wed, Sep 20, 2023 at 11:45 PM Oleksandr Tymoshenko <ovt@google.com> wrote:
> >
> > The removal of IMA_TRUSTED_KEYRING made IMA_LOAD_X509
> > and IMA_BLACKLIST_KEYRING unavailable because the latter
> > two depend on the former. Since IMA_TRUSTED_KEYRING was
> > deprecated in favor of INTEGRITY_TRUSTED_KEYRING use it
> > as a dependency for the two Kconfigs affected by the
> > deprecation.
> >
> > Fixes: 5087fd9e80e5 ("ima: Remove deprecated IMA_TRUSTED_KEYRING Kconfig")
> > Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
> 
> Gentle ping, IMA_LOAD_X509 and IMA_BLACKLIST_KEYRING options are
> currently broken on all branches.

Sorry for the delay.  It's now in linux-next.

-- 
thanks,

Mimi

