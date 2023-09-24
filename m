Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7B97ACB1B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 19:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjIXRkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 13:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjIXRkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 13:40:10 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635BAFC;
        Sun, 24 Sep 2023 10:40:01 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38OGehq2006698;
        Sun, 24 Sep 2023 17:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=a2ctV+9L4kKCcLREiZQedto4qlgkJw8bUeFgjqbh5As=;
 b=Rhz+Gc8BTaoyzxlAeAH0FGE9+e9Kqa3pXNo6DwyLFoHRHTNKdM2ZTrhbapgsVuIlHzk7
 dgGnP2WqFB6N7bIkIrF9WiSHOKmtQbvpKZsBK1L+c+npfC3vunTw89c8KMlc6DrWLTt2
 IFbDpsChFjf8CIGpkY5P3U1oQpmny0h/xu4MNyfqo9/7h1NejWsW+/Gzt0x0nyUVPJLE
 WdPEmPUdXCP474I50K8kg2NWxoOKuWsz1Vx2QMJ+CWz/lHsjkRw2qc/rTDyrq5g/qR50
 uCICtyTff+gVgp+UOesRNcg7Mvx0ukKIs0dBWYiIwucg5j6eNAFeFsJ820is37qC4cLu aA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ta5hb0bmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Sep 2023 17:39:47 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38OHdlkB003823;
        Sun, 24 Sep 2023 17:39:47 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ta5hb0bmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Sep 2023 17:39:47 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38OFaLvj030753;
        Sun, 24 Sep 2023 17:39:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tacjjc3n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Sep 2023 17:39:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38OHdhVc27394696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 24 Sep 2023 17:39:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE5C92004B;
        Sun, 24 Sep 2023 17:39:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C618B20040;
        Sun, 24 Sep 2023 17:39:42 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.29.239])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
        Sun, 24 Sep 2023 17:39:42 +0000 (GMT)
Date:   Sun, 24 Sep 2023 19:39:41 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: virtcrypto_dataq_callback calls crypto_finalize_request() from
 irq context
Message-ID: <20230924193941.6a02237f.pasic@linux.ibm.com>
In-Reply-To: <ed47fb73ad634ca395bd6c8e979dda8e@huawei.com>
References: <20230922154546.4f7447ce.pasic@linux.ibm.com>
        <ed47fb73ad634ca395bd6c8e979dda8e@huawei.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OAd7c8O-FiD8N90yvnR-OhbKEtCwd40N
X-Proofpoint-ORIG-GUID: D7Y4RHuy_ajhhRgET4pDTmKzK3fghQZR
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-24_15,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=951 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309240154
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2023 11:56:25 +0000
"Gonglei (Arei)" <arei.gonglei@huawei.com> wrote:

> Hi Halil,
> 
> Commit 4058cf08945 introduced a check for detecting crypto completion function 
> called with enable BH, and indeed the virtio-crypto driver didn't disable BH, which needs
> a patch to fix it.
> 
> P.S.: https://lore.kernel.org/lkml/20220221120833.2618733-5-clabbe@baylibre.com/T/
> 
> Regards,
> -Gonglei

Thanks Gonglei!

Thanks! I would be glad to test that fix on s390x. Are you about to send
one?

Regards,
Halil
