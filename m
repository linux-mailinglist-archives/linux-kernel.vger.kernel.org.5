Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796B67B0554
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjI0N0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjI0N0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:26:08 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48080139;
        Wed, 27 Sep 2023 06:26:07 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RDH2Yu022849;
        Wed, 27 Sep 2023 13:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=GsIAyhpIf4NBRlkmaRy0sPks/FrsbwmkORMLxbn84u0=;
 b=bvuKdv4JklxGKBk8YHkjwkerHUGgfvpcDmMTNXlh1xC+ZEW89+XWV/AskEjpRUnbB4Dy
 P/SoaIdd2EMcZ82g8QgmDaS0IUDnkuO9z6drfsRo768ViTxN9cEdGnJujLmo+ao2dkUl
 X1gD3LIwfdcj4pDj7T1VRc+4/UiJfGkTuLkDqqR3ThM586hv0Ej65IV7chSDfE6acsPE
 5uzDopAYgc8lRqic6X8eOZMm5j/2BYw8q6VE3e7uk9W47hILDneYNlahpj4wIB6TGR8v
 jMUj4GNzJLcv9DQdY1yoX5n1CNfMuhqh5JWriNrMQK2rxdM+J+CNRMP+hwwpWwqAaYv7 Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcmvdgqtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 13:25:39 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38RDI1EC026637;
        Wed, 27 Sep 2023 13:25:39 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcmvdgqsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 13:25:39 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38RCeBKd008456;
        Wed, 27 Sep 2023 13:25:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3taabsv4q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 13:25:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38RDPYAG17433166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 13:25:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0508B2004B;
        Wed, 27 Sep 2023 13:25:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D11A820040;
        Wed, 27 Sep 2023 13:25:33 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.152.224.212])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 27 Sep 2023 13:25:33 +0000 (GMT)
Date:   Wed, 27 Sep 2023 15:25:31 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Message-ID: <20230927152531.061600f0.pasic@linux.ibm.com>
In-Reply-To: <9564c220c8344939880bb805c5b3cac9@huawei.com>
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
        <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
        <20230926130521-mutt-send-email-mst@kernel.org>
        <9564c220c8344939880bb805c5b3cac9@huawei.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wmazh0HwbLN5HnkRF-bBsPH94u5eoxv7
X-Proofpoint-GUID: oZUuEdATvYo_-Yz_WpSoKhEgtnWF29Cp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_07,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 mlxlogscore=732 spamscore=0 adultscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2023 09:24:09 +0000
"Gonglei (Arei)" <arei.gonglei@huawei.com> wrote:

> > On a related note, config change callback is also handled incorrectly in this
> > driver, it takes a mutex from interrupt context.  
> 
> Good catch. Will fix it.

Thanks Gonglei! Sorry I first misunderstood this as a problem within the
virtio-ccw driver, but it is actually about virtio-crypto. Thanks for
fixing this!

Regards,
Halil
