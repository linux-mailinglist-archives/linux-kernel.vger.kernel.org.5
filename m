Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AB77AB8E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjIVSNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjIVSN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:13:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C009F;
        Fri, 22 Sep 2023 11:13:24 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MI7TrA018275;
        Fri, 22 Sep 2023 18:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=tXL9ZfYTERR3en1PBqoFEJXsooQVxAx94EFww22n28M=;
 b=YB1Yic+Ha629EOugPehYhBqa0hKg3NAiiD3Z+q3pT8w44sY1n4aNhIWRAGUjp4X0VBCt
 XLdZq3hI2nA8KMVbAf1IFuhGL22xqTND6yxJUgt6oJ3FIqZALGxJNEKaCZbpHxQlfDmc
 AecUUEeZcBe2Koaewtlacrm/LZsVPZjBU3ARH2Nl3pVlcz9D2uBaiq+YAvitYFnjM3g1
 lys6jAY072m9wZ9SfDTO9NlRrD597kJEzHSLLb1SPz+yEIF1P+EFiXIsCT7/L/YLYai3
 /6S4NMsslbZV6XtLoqbD0um1LLiPYFRVHo/HQzJIHjCYBVt//5qvikZ/cyx7V878ICi1 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t9f8y8wrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 18:13:19 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38MI7iui020475;
        Fri, 22 Sep 2023 18:13:19 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t9f8y8wr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 18:13:19 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38MHKkdS015474;
        Fri, 22 Sep 2023 18:13:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t8tspphbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 18:13:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38MIDEfP22938114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 18:13:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B08752004B;
        Fri, 22 Sep 2023 18:13:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1BE420043;
        Fri, 22 Sep 2023 18:13:13 +0000 (GMT)
Received: from [9.171.80.27] (unknown [9.171.80.27])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 22 Sep 2023 18:13:13 +0000 (GMT)
Message-ID: <b7dad8b72ec94d27378eca87fea4cb0c86b8c361.camel@linux.ibm.com>
Subject: Re: [PATCH net-next 01/18] net/smc: decouple ism_dev from SMC-D
 device dump
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>
Cc:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Sep 2023 20:13:13 +0200
In-Reply-To: <2c9d570c-f780-0484-a26c-78b115e1a6a3@linux.alibaba.com>
References: <1695134522-126655-1-git-send-email-guwen@linux.alibaba.com>
         <1695134522-126655-2-git-send-email-guwen@linux.alibaba.com>
         <20230921204153.GQ224399@kernel.org>
         <2c9d570c-f780-0484-a26c-78b115e1a6a3@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3D4AtFu0GrkfgE5YJ6-yJxHczBLp0Bq3
X-Proofpoint-GUID: gVtzBIBRzLHhqbexIMkocvwnOQ7UsNQr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_16,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=779 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309220156
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-09-22 at 16:05 +0800, Wen Gu wrote:
> On 2023/9/22 04:41, Simon Horman wrote:
> > On Tue, Sep 19, 2023 at 10:41:45PM +0800, Wen Gu wrote:
> >=20
> > priv_dev is uninitialised here.
> >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0smc_set_pci_values(to_pci_=
dev(ism->dev.parent),
> > > &smc_pci_dev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (smcd->ops->get_dev)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0priv_dev =3D smcd->ops->get_dev(smcd);
> >=20
> > It is conditionally initialised here.
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (priv_dev->parent)
> >=20
> > But unconditionally dereferenced here.
> >=20
> > As flagged by clang-16 W=3D1, and Smatch
> >=20
>=20
> Hi Simon. Yes, I fixed it in v3. Thank you!

Hi Wen Gu,

seems like there is some email filter at work. Neither v2 nor v3 made
it to the netdev mailing list - nor to patchwork.kernel.org.
There's traces of Wenjia's replies and your replies to her - but not
the original mail.

Could you please check? Thanks!
Gerd
