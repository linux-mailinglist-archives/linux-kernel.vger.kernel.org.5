Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140117B2072
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjI1PF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjI1PFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:05:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F961B5;
        Thu, 28 Sep 2023 08:05:51 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SEk0A1016005;
        Thu, 28 Sep 2023 15:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vMb+aAFI53ERmvbLOOTAtUBUQQ2YlNOdAoSkYas6PIs=;
 b=fqxXj/gGnysYI56fZBP5xMx1inty/A4K5R5fY99jdQinjZ5cgH5jpPPimvK6mUC1Vn6r
 ZoKo6oRD1yzduE26+WMRxLKF9pGDAr9VPlnSAnSzN6Wm0ghuFgFv1nq5/XQklxZtbe1J
 TRqXGf4vauENod9ioPWeMoAKBy9+M5np3v4PlqmUBw5j53nI6Baba41OzsI6gwWycYF1
 6HAIClkwOGYUNLmUH6XwlNNeOH6OOIvjirJMa8cpfBNXlUD3bnk+3O5ahU/1iTtseidq
 nDsreta227ePBS3fWAfd5uzzdo60IqnhDgP04EI6Fe0SpVVCkSpvddXIeBxt1ASKSLE+ Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdbath78n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 15:05:29 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38SEWP4Z017327;
        Thu, 28 Sep 2023 15:05:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdbath4rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 15:05:12 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38SDN3Zm008143;
        Thu, 28 Sep 2023 15:04:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3taaqywhhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 15:04:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38SF4Mla40239544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 15:04:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFD662004D;
        Thu, 28 Sep 2023 15:04:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D54B820040;
        Thu, 28 Sep 2023 15:04:21 +0000 (GMT)
Received: from [9.171.80.248] (unknown [9.171.80.248])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 28 Sep 2023 15:04:21 +0000 (GMT)
Message-ID: <00bbbf48440c1889ecd16a590ebb746b820a4f48.camel@linux.ibm.com>
Subject: Re: [PATCH net-next] net/smc: add support for netdevice in
 containers.
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Albert Huang <huangjie.albert@bytedance.com>,
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
Date:   Thu, 28 Sep 2023 17:04:21 +0200
In-Reply-To: <20230925023546.9964-1-huangjie.albert@bytedance.com>
References: <20230925023546.9964-1-huangjie.albert@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _N-fuUIetudV9Wfdz9MzlhKJuUTHPCUW
X-Proofpoint-ORIG-GUID: yxZhCqvuEiIotfJ6ZZcsgkArZ504hZj_
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_14,2023-09-28_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280130
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-25 at 10:35 +0800, Albert Huang wrote:
> If the netdevice is within a container and communicates externally
> through network technologies like VXLAN, we won't be able to find
> routing information in the init_net namespace. To address this issue,
> we need to add a struct net parameter to the smc_ib_find_route function.
> This allow us to locate the routing information within the corresponding
> net namespace, ensuring the correct completion of the SMC CLC interaction.
>=20
> Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> ---
>  net/smc/af_smc.c | 3 ++-
>  net/smc/smc_ib.c | 7 ++++---
>  net/smc/smc_ib.h | 2 +-
>  3 files changed, 7 insertions(+), 5 deletions(-)
>=20

I'm trying to test this patch on s390x but I'm running into the same
issue I ran into with the original SMC namespace
support:https://lore.kernel.org/netdev/8701fa4557026983a9ec687cfdd7ac5b3b85=
fd39.camel@linux.ibm.com/

Just like back then I'm using a server and a client network namespace
on the same system with two ConnectX-4 VFs from the same card and port.
Both TCP/IP traffic as well as user-space RDMA via "qperf =E2=80=A6 rc_bw" =
and
`qperf =E2=80=A6 rc_lat` work between namespaces and definitely go via the
card.

I did use "rdma system set netns exclusive" then moved the RDMA devices
into the namespaces with "rdma dev set <rdma_dev> netns <namespace>". I
also verified with "ip netns exec <namespace> rdma dev"
that the RDMA devices are in the network namespace and as seen by the
qperf runs normal RDMA does work.

For reference the smc_chck tool gives me the following output:

Server started on port 37373
[DEBUG] Interfaces to check: eno4378
Test with target IP 10.10.93.12 and port 37373
  Live test (SMC-D and SMC-R)
[DEBUG] Running client: smc_run /tmp/echo-clt.x0q8iO 10.10.93.12 -p
37373
[DEBUG] Client result: TCP 0x05000000/0x03030000
     Failed  (TCP fallback), reasons:
          Client:        0x05000000   Peer declined during handshake
          Server:        0x03030000   No SMC devices found (R and D)

I also checked that SMC is generally working, once I add an ISM device
I do get SMC-D between the namespaces. Any ideas what could break SMC-R
here?

Thanks,
Niklas
