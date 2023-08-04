Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4314A770509
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjHDPld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjHDPlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:41:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9628149D4;
        Fri,  4 Aug 2023 08:41:30 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374Fb7Rj012525;
        Fri, 4 Aug 2023 15:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=hg5vWj/L9yQlhLXAx6slUTmOqegnMigK9ZEoBQ88Ev4=;
 b=N2eaiLU1LGR426Yp7fq9ey0g96ufpmAS9Vp3DVzZOpolLie1DXaEQBioeGQN/rKZ6hF8
 oyKYqCxAJnnRMwcJB62rivuA2Bqgzds0mGbZ5P1zBPpVr2MMQBUnS4Rjjx6TsOj9MLzn
 EbN8DgLbXhJc09jI7UF8W2ap7JfSflSmldiV5FING/xV8ywANi4vUHZRsfLFzUcZ3YPY
 NZ4o3oLTM0s+e2LcT/yt7GNUVFEusCylkJu7wGLjtj4aAHhpxtjplvu8crCwvOhiKj6q
 VmJcZSAS5jFfn2laQEjSP1BQvAgbCdGjjCBXeEWilrW6COMQl34/9NcDNt00jUngY4a1 Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s93rs1780-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 15:41:20 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 374Fb8eW012709;
        Fri, 4 Aug 2023 15:41:20 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s93rs1772-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 15:41:20 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 374E6iOl023488;
        Fri, 4 Aug 2023 15:41:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s8km9pxec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 15:41:18 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 374FfFTt57934112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Aug 2023 15:41:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 332FB20043;
        Fri,  4 Aug 2023 15:41:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F6D020040;
        Fri,  4 Aug 2023 15:41:14 +0000 (GMT)
Received: from [9.155.208.153] (unknown [9.155.208.153])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  4 Aug 2023 15:41:14 +0000 (GMT)
Message-ID: <129c1c96eaafd7d3e57b05ca96354ffc129fd4e3.camel@linux.ibm.com>
Subject: Re: [PATCH net v2 0/2] net/smc: Fix effective buffer size
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     Simon Horman <horms@kernel.org>
Cc:     Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        "D . Wythe" <alibuda@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 04 Aug 2023 17:41:13 +0200
In-Reply-To: <ZM0IX/YnaawWT9sm@kernel.org>
References: <20230803144605.477903-1-gbayer@linux.ibm.com>
         <ZM0IX/YnaawWT9sm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 93xwT36h812AQdB-danA66Y7QZep2xAe
X-Proofpoint-ORIG-GUID: vpLe3iivhdMOlReEyY1GrrG-76cL_6jA
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_15,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 mlxscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=478 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308040139
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-04 at 16:17 +0200, Simon Horman wrote:
> On Thu, Aug 03, 2023 at 04:46:03PM +0200, Gerd Bayer wrote:
> > Hi all,
> >=20
[...]
> > v1 - v2:
> > =C2=A0- In second patch, use sock_net() helper as suggested by Tony and
> > demanded
> > =C2=A0=C2=A0 by kernel test robot.
> >=20
> > [1]
> > https://lore.kernel.org/netdev/20221123104907.14624-1-jaka@linux.ibm.com
>=20
> Hi Gerd,
>=20
> unfortunately this patchset does not appear to apply to current
> 'net'.
>=20
> Could you rebase and send a v3?
>=20
Hi Simon,

sure, working on it.

Thanks,
Gerd
