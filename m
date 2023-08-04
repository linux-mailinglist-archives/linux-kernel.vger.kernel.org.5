Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F226C770669
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjHDQzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjHDQzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:55:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579A91994;
        Fri,  4 Aug 2023 09:55:36 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374GsCXR030477;
        Fri, 4 Aug 2023 16:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=klf/zpAgkamTeULJUvE8a5qaeWINoTqzaeqh5+nOfiQ=;
 b=sjoM4JreZG3QFmIjBAlC+dkssSunLSK0UC+pGdI68GKc4UOGvaoz2vHSIJMPNZ7nEvPw
 1QSBQSTCjna4KynYScdyXwYg00+dLK8wtwqrcXSWMcAjOxghZYoAPfhvrB3fJhbFj5ho
 9FZqUfRv+H85bHiDiX6TBO5FFykU56JQLmbGku6PbOtjNsAcD/ZmriSGLIHU/caqc9jg
 X4svHT89prK1Fb7GwlhExcz8INcx6XEByP/8/lG8p7IdklU+eq79IGqROVd2M2FGsHLv
 0hCjYO8vsbkJFiQwwDSOtDgV1o289RFAmBcNuyYNuhJKJNJ1Cia2+l/2G4FbrDXcE1Ll 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s955405ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 16:55:32 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 374Glr3P005279;
        Fri, 4 Aug 2023 16:55:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s955405e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 16:55:31 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 374G0YVW015848;
        Fri, 4 Aug 2023 16:55:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s8kn77ecm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 16:55:30 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 374GtRVX45810252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Aug 2023 16:55:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E676920049;
        Fri,  4 Aug 2023 16:55:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B04B220040;
        Fri,  4 Aug 2023 16:55:26 +0000 (GMT)
Received: from [9.155.208.153] (unknown [9.155.208.153])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  4 Aug 2023 16:55:26 +0000 (GMT)
Message-ID: <c493ef8fa5b735fe32be0c720be77db18e660dfb.camel@linux.ibm.com>
Subject: Re: [PATCH net-next v3 0/2] net/smc: Fix effective buffer size
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Karsten Graul <kgraul@linux.ibm.com>,
        "D . Wythe" <alibuda@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 04 Aug 2023 18:55:26 +0200
In-Reply-To: <20230804163049.937185-1-gbayer@linux.ibm.com>
References: <20230804163049.937185-1-gbayer@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gDs8TKHLs1rXvMYKtcgSwtmA0biIi9m1
X-Proofpoint-ORIG-GUID: aZkpbM4PmZs9UFOtWdyUelVQ4KL01Peb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_16,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxlogscore=647 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308040149
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,TRACKER_ID autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-04 at 18:30 +0200, Gerd Bayer wrote:
> Hi all,
>=20
> commit 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock
> and make them tunable") started to derive the effective buffer size
> for
> SMC connections inconsistently in case a TCP fallback was used and
> memory consumption of SMC with the default settings was doubled when
> a connection negotiated SMC. That was not what we want.
>=20
> This series consolidates the resulting effective buffer size that is
> used with SMC sockets, which is based on Jan Karcher's effort (see=20
> [1]). For all TCP exchanges (in particular in case of a fall back
> when
> no SMC connection was possible) the values from net.ipv4.tcp_[rw]mem
> are used. If SMC succeeds in establishing a SMC connection, the newly
> introduced values from net.smc.[rw]mem are used.
>=20
> net.smc.[rw]mem is initialized to 64kB, respectively. Internal test=20
> have show this to be a good compromise between throughput/latency=20
> and memory consumption. Also net.smc.[rw]mem is now decoupled
> completely
> from any tuning through net.ipv4.tcp_[rw]mem.
>=20
> If a user chose to tune a socket's receive or send buffer size with
> setsockopt, this tuning is now consistently applied to either fall-
> back
> TCP or proper SMC connections over the socket.
>=20
> Thanks,
> Gerd=20
>=20
> v2 - v3:
> =C2=A0- Rebase to and resolve conflict of second patch with latest
> net/master.
> v1 - v2:
> =C2=A0- In second patch, use sock_net() helper as suggested by Tony and
> demanded
> =C2=A0=C2=A0 by kernel test robot.
>=20
>=20
> Gerd Bayer (2):
> =C2=A0 net/smc: Fix setsockopt and sysctl to specify same buffer size
> again
> =C2=A0 net/smc: Use correct buffer sizes when switching between TCP and
> SMC
>=20
> =C2=A0net/smc/af_smc.c=C2=A0=C2=A0=C2=A0=C2=A0 | 77 +++++++++++++++++++++=
+++++++++------------
> --
> =C2=A0net/smc/smc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +=
-
> =C2=A0net/smc/smc_clc.c=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +--
> =C2=A0net/smc/smc_core.c=C2=A0=C2=A0 | 25 +++++++-------
> =C2=A0net/smc/smc_sysctl.c | 10 ++++--
> =C2=A05 files changed, 76 insertions(+), 42 deletions(-)
>=20
>=20
> base-commit: 1733d0be68ab1b89358a3b0471ef425fd61de7c5

Oh boy,

this should have gone as v3 against "net" instead of "net-next".
Resending ASAP.

Sorry for the noise,
Gerd

