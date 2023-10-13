Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A7F7C7F63
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjJMIFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjJMIFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:05:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC097D7;
        Fri, 13 Oct 2023 01:05:04 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D7vKuu032262;
        Fri, 13 Oct 2023 08:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Jo2kbatEc8e17LpJGwnshQZMW5QQTjZ8AbyJriWjS7Y=;
 b=cLnT3ZVyHxhFtwMyHy7DxD6CmqCO9vhl1uMlDZlyG65DN2FbKHMtErMzNCQ4hkaZfLLT
 BsBg1FS92H8IHkMB6TcZKpOjj/s6PBDGLFxvXA/f8VJWr8zcsSZhCRSHtfFJV8dQxTeo
 CNL09YOa1uGyR+Y2VhzWdy9hHRjOyjbA7ZwVPfJiwUPvgRsmFYesSxIPXjfqTgmFq28G
 5umX/f0CtjKCs/0sdsmk6mLcNl+WhczPtp/F26Jb8+TjLSHT5cs5Ugp01KbR5dSaQe+I
 4YSZDYd9Qr7YVpfgkHhp9NGzuHD1t8YcnMR9nfAW2OkgJShIPUK8w6KuDRWUc376nrFO bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq1y2g7yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 08:04:44 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39D7vH0w032208;
        Fri, 13 Oct 2023 08:04:43 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq1y2g7xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 08:04:43 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39D5KxqN007546;
        Fri, 13 Oct 2023 08:04:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tpt5aagr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 08:04:42 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39D84dHi21299776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 08:04:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B477A2008C;
        Fri, 13 Oct 2023 08:04:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A47542008A;
        Fri, 13 Oct 2023 08:04:38 +0000 (GMT)
Received: from [9.171.68.183] (unknown [9.171.68.183])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 13 Oct 2023 08:04:38 +0000 (GMT)
Message-ID: <afea5e9952a8a23a28748539cc65b508d1a0f68b.camel@linux.ibm.com>
Subject: Re: [PATCH net-next] net/smc: add support for netdevice in
 containers.
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     dust.li@linux.alibaba.com,
        Albert Huang <huangjie.albert@bytedance.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>
Cc:     "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 13 Oct 2023 10:04:38 +0200
In-Reply-To: <20231012121740.GR92403@linux.alibaba.com>
References: <20230925023546.9964-1-huangjie.albert@bytedance.com>
         <00bbbf48440c1889ecd16a590ebb746b820a4f48.camel@linux.ibm.com>
         <20231011144816.GO92403@linux.alibaba.com>
         <20231012121740.GR92403@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B_bOycrT2FIOG-exXqbQRxoowDCJxqfS
X-Proofpoint-ORIG-GUID: 5kdMwzotgXDwC0JEd7MlNEPX-acneogf
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-12 at 20:17 +0800, Dust Li wrote:
> On Wed, Oct 11, 2023 at 10:48:16PM +0800, Dust Li wrote:
> > On Thu, Sep 28, 2023 at 05:04:21PM +0200, Niklas Schnelle wrote:
> > > On Mon, 2023-09-25 at 10:35 +0800, Albert Huang wrote:
> > > > If the netdevice is within a container and communicates externally
> > > > through network technologies like VXLAN, we won't be able to find
> > > > routing information in the init_net namespace. To address this issu=
e,
> > > > we need to add a struct net parameter to the smc_ib_find_route func=
tion.
> > > > This allow us to locate the routing information within the correspo=
nding
> > > > net namespace, ensuring the correct completion of the SMC CLC inter=
action.
> > > >=20
> > > > Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > > > ---
> > > >  net/smc/af_smc.c | 3 ++-
> > > >  net/smc/smc_ib.c | 7 ++++---
> > > >  net/smc/smc_ib.h | 2 +-
> > > >  3 files changed, 7 insertions(+), 5 deletions(-)
> > > >=20
> > >=20
> > > I'm trying to test this patch on s390x but I'm running into the same
> > > issue I ran into with the original SMC namespace
> > > support:https://lore.kernel.org/netdev/8701fa4557026983a9ec687cfdd7ac=
5b3b85fd39.camel@linux.ibm.com/
> > >=20
> > > Just like back then I'm using a server and a client network namespace
> > > on the same system with two ConnectX-4 VFs from the same card and por=
t.
> > > Both TCP/IP traffic as well as user-space RDMA via "qperf =E2=80=A6 r=
c_bw" and
> > > `qperf =E2=80=A6 rc_lat` work between namespaces and definitely go vi=
a the
> > > card.
> > >=20
> > > I did use "rdma system set netns exclusive" then moved the RDMA devic=
es
> > > into the namespaces with "rdma dev set <rdma_dev> netns <namespace>".=
 I
> > > also verified with "ip netns exec <namespace> rdma dev"
> > > that the RDMA devices are in the network namespace and as seen by the
> > > qperf runs normal RDMA does work.
> > >=20
> > > For reference the smc_chck tool gives me the following output:
> > >=20
> > > Server started on port 37373
> > > [DEBUG] Interfaces to check: eno4378
> > > Test with target IP 10.10.93.12 and port 37373
> > >  Live test (SMC-D and SMC-R)
> > > [DEBUG] Running client: smc_run /tmp/echo-clt.x0q8iO 10.10.93.12 -p
> > > 37373
> > > [DEBUG] Client result: TCP 0x05000000/0x03030000
> > >     Failed  (TCP fallback), reasons:
> > >          Client:        0x05000000   Peer declined during handshake
> > >          Server:        0x03030000   No SMC devices found (R and D)
> > >=20
> > > I also checked that SMC is generally working, once I add an ISM device
> > > I do get SMC-D between the namespaces. Any ideas what could break SMC=
-R
> > > here?
> >=20
> > I missed the email :(
> >=20
> > Are you running SMC-Rv2 or v1 ?
>=20
> Hi Niklas,
>=20
> I tried your test today, and I encounter the same issue.
> But I found it's because my 2 VFs are in difference subnets,
> SMC-Rv2 work fine, SMC-Rv1 won't work, which is expected.
> When I set the 2 VFs in the same subnet, SMC-Rv1 also works.
>=20
> So I'm not sure it's the same for you. Can you check it out ?
>=20
> BTW, the fallback reason(SMC_CLC_DECL_NOSMCDEV) in this case
> is really not friendly, it's better to return SMC_CLC_DECL_DIFFPREFIX.
>=20
> Best regards,
> Dust

I think you are right. I did use two consecutive private IPs but I had
set the subnet mask to /32. Setting that to /16 the SMC-R connection is
established. I'll work with Wenjia and Jan on why my system is
defaulting to SMC-Rv1 I would have hoped to get SMC-Rv2.

Thanks for your insights!
Niklas
