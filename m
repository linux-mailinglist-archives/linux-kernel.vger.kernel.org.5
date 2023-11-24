Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243237F78DA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjKXQYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjKXQYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:24:33 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B97BD41;
        Fri, 24 Nov 2023 08:24:40 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7789a4c01easo113924885a.0;
        Fri, 24 Nov 2023 08:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700843079; x=1701447879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXuq367Ccm4+D5k3pODmrs76JvxYvWomp+aKIM/G+no=;
        b=TI5cWHmXa1riHiMFUQtMFmaskaXkgg9yOv5lslt+upNFa7PSOTpFLLoxjsbQIcfwhf
         4TmQN8suqD75FXESJ5JHD0f/TKnc1aQF3L2LDT5nZetOJEJ7HoBhWieksptHYFwSrGUx
         hmxEAyvXXCjYMlOuz1yyyGr+INBcfUrhjHJpba/RfsuytZWOXvCuJDPaCprQ8+Hgs5t3
         pj9Eds8ESI/xC7i0CT0iEA+jD54O0ogO+cem77iEHH8grEAwoFrGF4FTGaasSeQnc/pb
         X6grry8cO6pVCbMKibCkgwoVSc2j77RYqwxsuSQT41lM0K7l5sXBtFWeycDlANvdy66E
         4xlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700843079; x=1701447879;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OXuq367Ccm4+D5k3pODmrs76JvxYvWomp+aKIM/G+no=;
        b=dwa0TeSa324CRUDOitLD9jT3s5iRMONPcXM1RKmE9aEd25OZs02fiBQt+JEqt7zwsc
         0R91paaoJ+X8H4VQJyWm207EjmoNLfrH8eYwksD01R3E03xkOPAdpkPbK8SKUy0hLOQB
         dh5JwpvU51+aN8asD9tPlWuhxjV1h0zdskxEmteQqp/YyfnLIpn3sQa6TEpnSy6ePwf4
         HpxkEuwCaDa5J/FwM/cr3ssjowhcktnLkupbwcAaq5nizHKs0SP3lb0r3jlgl5G8GFdW
         GArj6RzCrIHirb0iK+VOIO3yYWiDNZOcd3gTgFKEea7CsuazTuYay7HL/sf625tNygPl
         z9GA==
X-Gm-Message-State: AOJu0YwX49t67jjrgjqluBrawscJPB7yiXRbmQZjMrPkyi9itUj1Atdg
        0hTrMCX3Ak6D98PraAKgp28=
X-Google-Smtp-Source: AGHT+IHsuaReeYZvleTgFrMcuERum0qzKPn/IEj+uARWrAyWURq9ZBKxYYjp6xu84X93cTgBTBgUhw==
X-Received: by 2002:a05:620a:55b2:b0:77d:5ca7:a6ce with SMTP id vr18-20020a05620a55b200b0077d5ca7a6cemr3487998qkn.28.1700843079420;
        Fri, 24 Nov 2023 08:24:39 -0800 (PST)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id qs14-20020a05620a394e00b0077d87da84d1sm39091qkn.23.2023.11.24.08.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 08:24:39 -0800 (PST)
Date:   Fri, 24 Nov 2023 11:24:38 -0500
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Mike Pattrick <mkp@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Message-ID: <6560ce46db783_f482f29451@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAHcdBH4aMJwkR7fVP=Brwb-4=gon-pwh0CbjbFxsoEiGj4XjVA@mail.gmail.com>
References: <20231123183835.635210-1-mkp@redhat.com>
 <655fc32bb506e_d14d4294b3@willemb.c.googlers.com.notmuch>
 <CAHcdBH7h-sq=Gzkan1du3uxx44WibK0yzdnUcZCuw-mp=9OxOg@mail.gmail.com>
 <655fe8e5b5cf5_d9fc5294a0@willemb.c.googlers.com.notmuch>
 <CAHcdBH4aMJwkR7fVP=Brwb-4=gon-pwh0CbjbFxsoEiGj4XjVA@mail.gmail.com>
Subject: Re: [PATCH net-next] packet: Account for VLAN_HLEN in csum_start when
 virtio_net_hdr is enabled
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Pattrick wrote:
> On Thu, Nov 23, 2023 at 7:06=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Mike Pattrick wrote:
> > > On Thu, Nov 23, 2023 at 4:25=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Mike Pattrick wrote:
> > > > > Af_packet provides checksum offload offsets to usermode applica=
tions
> > > > > through struct virtio_net_hdr when PACKET_VNET_HDR is enabled o=
n the
> > > > > socket. For skbuffs with a vlan being sent to a SOCK_RAW socket=
,
> > > > > af_packet will include the link level header and so csum_start =
needs
> > > > > to be adjusted accordingly.
> > > >
> > > > Is this patch based on observing an incorrect offset in a workloa=
d,
> > > > or on code inspection?
> > >
> > > Based on an incorrect offset in a workload. The setup involved send=
ing
> > > vxlan traffic though a veth interface configured with a vlan. The
> > > vnet_hdr's csum_start value was off by 4, and this problem went awa=
y
> > > when the vlan was removed.
> > >
> > > I'll take another look at this patch.
> >
> > This is a vlan device on top of a veth device? On which device and at=

> > which point (ingress or egress) are you receiving the packet over the=

> > packet socket?
> =

> Just for maximum clarity I'll include the extracted commands below,
> but roughly there is a vlan device on top of a vxlan device on top of
> a vlan device on top of a veth, in a namespace.
> =

> ip netns add at_ns0
> ip netns exec at_ns0 ip link add dev at_vxlan1 type vxlan remote
> 172.31.1.100 id 0 dstport 4789
> ip netns exec at_ns0 ip addr add dev at_vxlan1 10.2.1.1/24
> ip netns exec at_ns0 ip link set dev at_vxlan1 mtu 1450 up
> ip link add p0 type veth peer name ovs-p0
> ethtool -K p0 sg on
> ethtool -K p0 tso on
> ip link set p0 netns at_ns0
> ip link set dev ovs-p0 up
> ip netns exec at_ns0 ip addr add "172.31.2.1/24" dev p0
> ip netns exec at_ns0 ip link set dev p0 up
> ip netns exec at_ns0 ip link add link at_vxlan1 name at_vxlan1.100
> type vlan proto 802.1q id 100
> ip netns exec at_ns0 ip link set dev at_vxlan1.100 up
> ip netns exec at_ns0 ip addr add dev at_vxlan1.100 "10.1.1.1/24"
> ip netns exec at_ns0 ip link add link p0 name p0.42 type vlan proto 802=
.1q id 42
> ip netns exec at_ns0 ip link set dev p0.42 up
> ip netns exec at_ns0 ip addr add dev p0.42 "172.31.1.1/24"
> ip addr add "172.31.1.100/24" dev p0
> ip link set dev p0 up

Are these two lines intended to be ovs-p0 rather than p0?
As p0 lives inside the netns (and already has an address)

> ip netns exec at_ns0 ping 10.1.1.100
> =

> An AF_PACKET socket on ovs-p0 receives the incorrect csum_start.
> Setting up the same with a geneve tunnel and udpcsum enabled produces
> the same result. Removing vlan 100 also yields an incorrect
> csum_start. Removing only vlan 42 yields a correct csum_start.

I wonder if a simple checksum offloaded UDP packet sent over a vlan
directly on top of veth, like .100 has a correct offset before your
patch, but incorrect offset after.

The issue you are encountering might be that vxlan does not support
vlan offload, so validate_xmit_vlan will pull the vlan into the
header with __vlan_hwaccel_push_inside, but this does not adjust
csum_start. Not sure, but perhaps you can instrument your kernel
and see where the offset goes wrong. It is not inside the pf_packet
socket, in any case.
 =

> >
> > From a quick glance, in all cases that I see the VLAN tag is kept in
> > skb->vlan_tci, so is never part of the packet payload.
> >
> > But checksum offload with VXLAN can be non-trivial on its own. If
> > type & SKB_GSO_UDP_TUNNEL_CSUM | SKB_GSO_TUNNEL_REMCSUM, say. Then
> > csum_start will point to the checksum in vxlanhdr.
> >
> =



