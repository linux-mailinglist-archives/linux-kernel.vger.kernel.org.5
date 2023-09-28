Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DBC7B1117
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 05:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjI1DMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 23:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1DMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 23:12:07 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5613D114
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 20:12:05 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c012232792so212175231fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 20:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695870723; x=1696475523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bgXgmlh1GQN4CTcdXTwNhD1V43Sfr+5et+8avDcRvU=;
        b=gH74imOQ4FHW9Jqs8EQiMbaAR3yrBwjBKIZZlrMPpMwDWPJRcp5xUsaMEcN0RNsAgl
         /BD8IEMrJMlf1le3Rj78eEf7/i8sJkbtMrvnQRaz2LNAOG0lHgIKPVrRQCWSL52XVZRs
         AXbPrtjwc9UtppqZD6QKmC2ZmC7YyqCGyGqZaZa1vcAfUUuHRhVjrZ+B7t0v90//gCCt
         VnCVd3sJ1Y/4CMIFce/+Gh/Cbt2ixS2qnoog4w1GcU/dCWIDnfQ9qqokekbi2Ri17iG9
         eognQ09Jy4yTF3ktO9FfPHm/+40PfQ9SpZ9I7cn9Yc8KeeKVw1nBiSJc38TxEZbkRfRj
         7MoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695870723; x=1696475523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bgXgmlh1GQN4CTcdXTwNhD1V43Sfr+5et+8avDcRvU=;
        b=c3lDVrX+NoYY0dtGih6493P0s+4D/jKipKQ3wf8FDg7j9AhsqGcPD1A5JYFKx/eZs6
         4ySAOZbTF6yOTQVV239h2YkfY1smtd3rY0LmvdIeXcWLk5WmLZ/LEOW2Cw0ly8DiCBaw
         tbA6edfOJXutQt+hp0CXKbjIJzK9LtG50ZeDR1ha57H9sjlV8Cfwr7Cl15I1yZcVE6rP
         rv8VxArpZlQWAqNQ5PBWpJQu7s/u8pDqlXyKhUqlAD8Ve/qUfMvDN1BrSZp0JucUm5SC
         oWkPr46wUpTztFjKWoY95ectl7Cd1nA5xZ1TzR4PrUiiHfXxApIq+Sl9JFfAdDKYKU29
         QPRA==
X-Gm-Message-State: AOJu0Yxj66cujaNz20VVwaXFdh8eF767BIMHZAN+mKm41TX0AObNc1SV
        nwUk7cASrZe44kFfGZmZHlqlp0sIdpLUwnIFm2exdQ==
X-Google-Smtp-Source: AGHT+IFTkZJ4/q7vliYQ72XDcISPvWIwkniBbFNC/u0b2JMniQDgzT1TKU1pudIlDb/h5AgGmk2WIfS+SYeITjrwU+w=
X-Received: by 2002:a2e:b002:0:b0:2c0:17bc:124e with SMTP id
 y2-20020a2eb002000000b002c017bc124emr3443023ljk.38.1695870723542; Wed, 27 Sep
 2023 20:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230925023546.9964-1-huangjie.albert@bytedance.com>
 <20230927034209.GE92403@linux.alibaba.com> <20230927055528.GP1642130@unreal>
In-Reply-To: <20230927055528.GP1642130@unreal>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Thu, 28 Sep 2023 11:11:51 +0800
Message-ID: <CABKxMyOzCnJuWJskLT2rm64r8tLH7VU8jHL308oZs6--XOcLnQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH net-next] net/smc: add support for
 netdevice in containers.
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Dust Li <dust.li@linux.alibaba.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leon Romanovsky <leon@kernel.org> =E4=BA=8E2023=E5=B9=B49=E6=9C=8827=E6=97=
=A5=E5=91=A8=E4=B8=89 13:55=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Sep 27, 2023 at 11:42:09AM +0800, Dust Li wrote:
> > On Mon, Sep 25, 2023 at 10:35:45AM +0800, Albert Huang wrote:
> > >If the netdevice is within a container and communicates externally
> > >through network technologies like VXLAN, we won't be able to find
> > >routing information in the init_net namespace. To address this issue,
> >
> > Thanks for your founding !
> >
> > I think this is a more generic problem, but not just related to VXLAN ?
> > If we use SMC-R v2 and the netdevice is in a net namespace which is not
> > init_net, we should always fail, right ? If so, I'd prefer this to be a=
 bugfix.
>
> BTW, does this patch take into account net namespace of ib_device?
>
> Thanks
>

As dust said, the ib_device works well.

bool rdma_dev_access_netns(const struct ib_device *dev, const struct net *n=
et)
{
return (ib_devices_shared_netns ||
net_eq(read_pnet(&dev->coredev.rdma_net), net));
}
EXPORT_SYMBOL(rdma_dev_access_netns);

thanks!

BR
Albert.


> >
> > Best regards,
> > Dust
> >
> > >we need to add a struct net parameter to the smc_ib_find_route functio=
n.
> > >This allow us to locate the routing information within the correspondi=
ng
> > >net namespace, ensuring the correct completion of the SMC CLC interact=
ion.
> > >
> > >Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > >---
> > > net/smc/af_smc.c | 3 ++-
> > > net/smc/smc_ib.c | 7 ++++---
> > > net/smc/smc_ib.h | 2 +-
> > > 3 files changed, 7 insertions(+), 5 deletions(-)
> > >
> > >diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> > >index bacdd971615e..7a874da90c7f 100644
> > >--- a/net/smc/af_smc.c
> > >+++ b/net/smc/af_smc.c
> > >@@ -1201,6 +1201,7 @@ static int smc_connect_rdma_v2_prepare(struct sm=
c_sock *smc,
> > >             (struct smc_clc_msg_accept_confirm_v2 *)aclc;
> > >     struct smc_clc_first_contact_ext *fce =3D
> > >             smc_get_clc_first_contact_ext(clc_v2, false);
> > >+    struct net *net =3D sock_net(&smc->sk);
> > >     int rc;
> > >
> > >     if (!ini->first_contact_peer || aclc->hdr.version =3D=3D SMC_V1)
> > >@@ -1210,7 +1211,7 @@ static int smc_connect_rdma_v2_prepare(struct sm=
c_sock *smc,
> > >             memcpy(ini->smcrv2.nexthop_mac, &aclc->r0.lcl.mac, ETH_AL=
EN);
> > >             ini->smcrv2.uses_gateway =3D false;
> > >     } else {
> > >-            if (smc_ib_find_route(smc->clcsock->sk->sk_rcv_saddr,
> > >+            if (smc_ib_find_route(net, smc->clcsock->sk->sk_rcv_saddr=
,
> > >                                   smc_ib_gid_to_ipv4(aclc->r0.lcl.gid=
),
> > >                                   ini->smcrv2.nexthop_mac,
> > >                                   &ini->smcrv2.uses_gateway))
> > >diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> > >index 9b66d6aeeb1a..89981dbe46c9 100644
> > >--- a/net/smc/smc_ib.c
> > >+++ b/net/smc/smc_ib.c
> > >@@ -193,7 +193,7 @@ bool smc_ib_port_active(struct smc_ib_device *smci=
bdev, u8 ibport)
> > >     return smcibdev->pattr[ibport - 1].state =3D=3D IB_PORT_ACTIVE;
> > > }
> > >
> > >-int smc_ib_find_route(__be32 saddr, __be32 daddr,
> > >+int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
> > >                   u8 nexthop_mac[], u8 *uses_gateway)
> > > {
> > >     struct neighbour *neigh =3D NULL;
> > >@@ -205,7 +205,7 @@ int smc_ib_find_route(__be32 saddr, __be32 daddr,
> > >
> > >     if (daddr =3D=3D cpu_to_be32(INADDR_NONE))
> > >             goto out;
> > >-    rt =3D ip_route_output_flow(&init_net, &fl4, NULL);
> > >+    rt =3D ip_route_output_flow(net, &fl4, NULL);
> > >     if (IS_ERR(rt))
> > >             goto out;
> > >     if (rt->rt_uses_gateway && rt->rt_gw_family !=3D AF_INET)
> > >@@ -235,6 +235,7 @@ static int smc_ib_determine_gid_rcu(const struct n=
et_device *ndev,
> > >     if (smcrv2 && attr->gid_type =3D=3D IB_GID_TYPE_ROCE_UDP_ENCAP &&
> > >         smc_ib_gid_to_ipv4((u8 *)&attr->gid) !=3D cpu_to_be32(INADDR_=
NONE)) {
> > >             struct in_device *in_dev =3D __in_dev_get_rcu(ndev);
> > >+            struct net *net =3D dev_net(ndev);
> > >             const struct in_ifaddr *ifa;
> > >             bool subnet_match =3D false;
> > >
> > >@@ -248,7 +249,7 @@ static int smc_ib_determine_gid_rcu(const struct n=
et_device *ndev,
> > >             }
> > >             if (!subnet_match)
> > >                     goto out;
> > >-            if (smcrv2->daddr && smc_ib_find_route(smcrv2->saddr,
> > >+            if (smcrv2->daddr && smc_ib_find_route(net, smcrv2->saddr=
,
> > >                                                    smcrv2->daddr,
> > >                                                    smcrv2->nexthop_ma=
c,
> > >                                                    &smcrv2->uses_gate=
way))
> > >diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
> > >index 4df5f8c8a0a1..ef8ac2b7546d 100644
> > >--- a/net/smc/smc_ib.h
> > >+++ b/net/smc/smc_ib.h
> > >@@ -112,7 +112,7 @@ void smc_ib_sync_sg_for_device(struct smc_link *ln=
k,
> > > int smc_ib_determine_gid(struct smc_ib_device *smcibdev, u8 ibport,
> > >                      unsigned short vlan_id, u8 gid[], u8 *sgid_index=
,
> > >                      struct smc_init_info_smcrv2 *smcrv2);
> > >-int smc_ib_find_route(__be32 saddr, __be32 daddr,
> > >+int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
> > >                   u8 nexthop_mac[], u8 *uses_gateway);
> > > bool smc_ib_is_valid_local_systemid(void);
> > > int smcr_nl_get_device(struct sk_buff *skb, struct netlink_callback *=
cb);
> > >--
> > >2.37.1 (Apple Git-137.1)
> >
