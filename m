Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5567976D402
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjHBQsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjHBQsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:48:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AA0173A;
        Wed,  2 Aug 2023 09:48:07 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372Gfuw1023825;
        Wed, 2 Aug 2023 16:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=RYhl9o7SKKJztH3JmqXCvUi0CyeUsByFRM8iTudrnzA=;
 b=pOqNeVHqJ7Yp8Y0f9lVTtpwuFisK64YFdNtSp9S56CT0A7jqXCcXA88nvRzhET3kLacw
 +1gxiTT/6IcNScbX9Z7OXdhBFNFujjNW83brkY0cxkLHqdGK2mBBDEe+7u+nOOf2oN5c
 e9vRxEnx6DikaXBUJf0NZL2CvlA9cwiPoCvbC/QncCenVAWxWsZXPFgf9Ggu2u91PxKq
 L7nPtx4kDCptOZ8YXBq0nz0f8hIrBx0LBZ1QSq4uYtbVgIjXVRpPh0FybPyeoQPOBBZt
 opqelYv62ZQacajRUMp3M6PxhbvMi2+jn0NjmcfXYiCm+V6LHsIv5SkrzQMw6jYxAfE2 gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s7tvvr7gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 16:48:04 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 372GhqkD031958;
        Wed, 2 Aug 2023 16:48:04 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s7tvvr7fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 16:48:03 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 372F1GkG017116;
        Wed, 2 Aug 2023 16:48:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s5fajwprq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 16:48:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 372Gm0BC20185814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Aug 2023 16:48:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2EDC20043;
        Wed,  2 Aug 2023 16:47:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E81020040;
        Wed,  2 Aug 2023 16:47:59 +0000 (GMT)
Received: from [9.179.11.37] (unknown [9.179.11.37])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  2 Aug 2023 16:47:59 +0000 (GMT)
Message-ID: <603d2672855d74e9bfc2619156f4ffe7976de4f5.camel@linux.ibm.com>
Subject: Re: [PATCH net 2/2] net/smc: Use correct buffer sizes when
 switching between TCP and SMC
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     Tony Lu <tonylu@linux.alibaba.com>
Cc:     Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        "D . Wythe" <alibuda@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Aug 2023 18:47:58 +0200
In-Reply-To: <ZMpPjAaRzSRy-Vo_@TONYMAC-ALIBABA.local>
References: <20230802093313.1501605-1-gbayer@linux.ibm.com>
         <20230802093313.1501605-3-gbayer@linux.ibm.com>
         <ZMpPjAaRzSRy-Vo_@TONYMAC-ALIBABA.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zSPmUnJ3NkZEgtca34jLWGXJ_34EBbIf
X-Proofpoint-ORIG-GUID: mUWuCCm1BoLhEp0umEXsTl4Akz6lPj6U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_12,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020146
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-02 at 20:43 +0800, Tony Lu wrote:
> On Wed, Aug 02, 2023 at 11:33:13AM +0200, Gerd Bayer wrote:
> > Tuning of the effective buffer size through setsockopts was working
> > for
> > SMC traffic only but not for TCP fall-back connections even before
> > commit 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock
> > and
> > make them tunable"). That change made it apparent that TCP fall-
> > back
> > connections would use net.smc.[rw]mem as buffer size instead of
> > net.ipv4_tcp_[rw]mem.
> >=20
> > Amend the code that copies attributes between the (TCP) clcsock and
> > the
> > SMC socket and adjust buffer sizes appropriately:
> > - Copy over sk_userlocks so that both sockets agree on whether
> > tuning
> > =C2=A0 via setsockopt is active.
> > - When falling back to TCP use sk_sndbuf or sk_rcvbuf as specified
> > with
> > =C2=A0 setsockopt. Otherwise, use the sysctl value for TCP/IPv4.
> > - Likewise, use either values from setsockopt or from sysctl for
> > SMC
> > =C2=A0 (duplicated) on successful SMC connect.
> >=20
> > In smc_tcp_listen_work() drop the explicit copy of buffer sizes as
> > that
> > is taken care of by the attribute copy.
> >=20
> > Fixes: 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock
> > and make them tunable")
> > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> > Reviewed-by: Jan Karcher <jaka@linux.ibm.com>
>=20
> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
>=20
> >=20
> ^^^^ nit: a extra new line here.
I'll clean that up.

> > ---
> > =C2=A0net/smc/af_smc.c | 76 ++++++++++++++++++++++++++++++++++---------=
-
> > ----
> > =C2=A01 file changed, 54 insertions(+), 22 deletions(-)
> >=20
> >=20
[...]

> > +/* if set, use value set by setsockopt() - else use IPv4 or SMC
> > sysctl value */
> > +static void smc_adjust_sock_bufsizes(struct sock *nsk, struct sock
> > *osk,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned=
 long mask)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct net *nnet;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0nnet =3D nsk->sk_net.net;
>=20
> Better to combine these two lines with existed helper.
>=20
> struct net *net =3D sock_net(nsk);
Yes, looks much cleaner.

[...]
>=20

Thank you Tony for your review and comments.
I'll be sending out a v2 with your recommendations - but give people a
little more time to look at this version.

Thanks,
Gerd
