Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DD57AF100
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbjIZQmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbjIZQmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:42:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CD712A;
        Tue, 26 Sep 2023 09:42:29 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QGfhLV026269;
        Tue, 26 Sep 2023 16:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=ltcBCLRpeo5Qm/iG36QikwBKiii+yn5bF1s2VHUvFMM=;
 b=GDx9YKE6/y0+joAQJGAFIuBqJbDBj5rFj6MOsuvtHbVrRlSs+NffCJxdYtEgKs5urx/W
 uCnjLcSWXhPNEYGRS8YymcaggsDs0wU3g5TX60JqCN61aOhg5CdcCz1MzEq96eEkFkdw
 s1LdI5pt/ybe/Tw9Sva6dCJ2gzbuWTl+MfYopvgPGwthaaHOg9C+eyCVYtilQVBaS64s
 CBDtTl0CQx4M/lUei68uxtTKzBWTNlwbZVNyxdjjvGQFIcpJp5tTteBdZvr4dgisBfVT
 4LPumhFr6aXsJ73qF8P+xvyh3feTKYbn/qphQmcriqkjhP0E7FebbRFZjRgomE1ZMPJk Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tc31y00c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 16:42:06 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QGfjFZ026375;
        Tue, 26 Sep 2023 16:42:05 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tc31y00bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 16:42:05 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38QFVYV8008456;
        Tue, 26 Sep 2023 16:42:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3taabsn85h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 16:42:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38QGg1kE15270400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 16:42:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A1EB20043;
        Tue, 26 Sep 2023 16:42:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B52220040;
        Tue, 26 Sep 2023 16:42:01 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.152.224.212])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 26 Sep 2023 16:42:00 +0000 (GMT)
Date:   Tue, 26 Sep 2023 18:41:58 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Message-ID: <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
In-Reply-To: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o5Qnfs9z3yvYmj8Y5r21YF414SvYoNHs
X-Proofpoint-GUID: SE2bF5nwtmg_Bi5BJcw-sW5SVI_T11kO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1011 bulkscore=0 impostorscore=0 mlxlogscore=233
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260145
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[..]
> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> @@ -61,8 +61,9 @@ static void virtio_crypto_akcipher_finalize_req(
>  	vc_akcipher_req->src_buf = NULL;
>  	vc_akcipher_req->dst_buf = NULL;
>  	virtcrypto_clear_request(&vc_akcipher_req->base);
> -
> +	local_bh_disable();
>  	crypto_finalize_akcipher_request(vc_akcipher_req->base.dataq->engine, req, err);
> +	local_bh_enable();

Thanks Gonglei!

I did this a quick spin, and it does not seem to be sufficient on s390x.
Which does not come as a surprise to me, because 

#define lockdep_assert_in_softirq()                                     \
do {                                                                    \
        WARN_ON_ONCE(__lockdep_enabled                  &&              \
                     (!in_softirq() || in_irq() || in_nmi()));          \
} while (0)

will still warn because  in_irq() still evaluates to true (your patch
addresses the !in_softirq() part).

I don't have any results on x86 yet. My current understanding is that the
virtio-pci transport code disables interrupts locally somewhere in the
call chain (actually in vp_vring_interrupt() via spin_lock_irqsave())
and then x86 would be fine. But I will get that verified.

On the other hand virtio_airq_handler() calls vring_interrupt() with
interrupts enabled. (While vring_interrupt() is called in a (read)
critical section in virtio_airq_handler() we use read_lock() and
not read_lock_irqsave() to grab the lock. Whether that is correct in
it self (i.e. disregarding the crypto problem) or not I'm not sure right
now. Will think some more about it tomorrow.) If the way to go forward
is disabling interrupts in virtio-ccw before vring_interrupt() is
called, I would be glad to spin a patch for that.

Copying Conny, as she may have an opinion on this (if I'm not wrong she
authored that code).

Regards,
Halil
