Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1846789AEA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 04:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjH0CIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 22:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjH0CIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 22:08:39 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36DAB5;
        Sat, 26 Aug 2023 19:08:37 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68bee12e842so1462855b3a.3;
        Sat, 26 Aug 2023 19:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693102117; x=1693706917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Unbp2ZpICOQWNOmfXdVYXDQBbfyTCMGLqrJomuDfh5E=;
        b=gN/B2xI4/WC5EUpt5UlHyrA197k+K2qhXo6r4Apf9ki3seJnESPEF4OA9hf5EiqpUL
         FYY99GPQYFhGhgrBWOt5UfD6fsZTcNHeGnWaebJgCm3mQvj/6iRjC2YOwIqETCI/BZG3
         4NBJIK5/ngfy5rXOnamC4q7uqO/GMckMweWdfc3t0CMutNX0260OyFM/TwRkrXLt3lp7
         R9PrN9YTKfdiWxNLwfBe3AklhkvPHQayQP0Gsq1AWQYWS3dBeYkh07UHzhuE7yR/jLMc
         TQx+WjqgTRU7LF4R4hg012vpUiSq7BwKXOvTbWVMzh4p9hHX+FEH4mzHVDtq3VqveavU
         GRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693102117; x=1693706917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Unbp2ZpICOQWNOmfXdVYXDQBbfyTCMGLqrJomuDfh5E=;
        b=LvfSCuxc+BI1bSJZKwYoUYHHZxYEv/sHDlEgO258p4b+tfZFRvt38EtzqgKBBY6jZz
         HhmLKdeA3OhVLQ1mDU0gwQh5pGafkVFFBn/ovu4njGt3KVxZ8ekVX908JnmPCIq3RrOc
         9V0tndBWCnUi2dCdN2p8Qfhyusah2DoLgclwFNhXjGev0ILmwOGDjQBI29K9jdzUiiOg
         NpSC3A1ftqucmJsQ/mf2FhURGvRKtgxH/T7CiRezffPmh8VHyCsOMOxa/nuOROyeTOrA
         DowECwHOcllOGi20wCA3g7nnZFykcV59i15pVJbVIbpMsHryyCuOf2zCEbNCPepRKt/P
         L3Og==
X-Gm-Message-State: AOJu0YwnzGKaNWxtWRUx9kzwWSQfIpuGhWBSlY9aMTu2Cr2eNEWQA96J
        LHZha1a8kwHGUV1AtszAojY=
X-Google-Smtp-Source: AGHT+IHGwfm+OQdiQjXg1Ze6oIspHb+/+uoN5f9AxRbgbtzV4zhDbC4Zk03ykux422uqNCmPlu2OxA==
X-Received: by 2002:a17:902:e842:b0:1b8:63c6:84ab with SMTP id t2-20020a170902e84200b001b863c684abmr19703767plg.61.1693102116945;
        Sat, 26 Aug 2023 19:08:36 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001b8943b37a5sm4395320plb.24.2023.08.26.19.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 19:08:36 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 860808A73D6D; Sun, 27 Aug 2023 09:07:58 +0700 (WIB)
Date:   Sun, 27 Aug 2023 09:07:40 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Volodymyr Litovka <doka@funlab.cc>, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Netfilter <netfilter-devel@vger.kernel.org>
Subject: Re: [Networking] ERSPAN decapsulation drops DHCP unicast packets
Message-ID: <ZOqv7E9/Qn2T1GwD@debian.me>
References: <eaf3d0d8-fca2-029e-9c57-ddae31f17726@funlab.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aNOZKJJDPt95AMQg"
Content-Disposition: inline
In-Reply-To: <eaf3d0d8-fca2-029e-9c57-ddae31f17726@funlab.cc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aNOZKJJDPt95AMQg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 26, 2023 at 09:55:30PM +0200, Volodymyr Litovka wrote:
> Hi colleagues,
>=20
> I'm trying to catch and process (in 3rd party analytics app) DHCP packets
> from ERSPAN session, but cannot do this due to absence of DHCP unicast
> packets after decapsulation.
>=20
> The model is pretty simple: there is PHY interface (enp2s0) which receive
> ERSPAN traffic and erspan-type interface to get decapsulated packets
> (inspan, created using command "ip link add inspan type erspan seq key 10
> local 10.171.165.65 erspan_ver 1", where 10.171.165.65 is ERSPAN target).
> Then I'm going to rewrite headers in the proper ways (nftable's netdev
> family) and forward packets to the pool of workers.
>=20
> Having this, I'm expecting everything, which is encapsulated inside ERSPA=
N,
> on 'inspan' interface. And there is _almost_ everything except DHCP unica=
st
> packets - tcpdump shows about 1kps on this interface of decapsulated
> packets, but no DHCP unicast (see below traces).
>=20
> To avoid any interactions, I removed and disabled everything that can cat=
ch
> DHCP in userspace - systemd-networkd, netplan, dhcp-client. There is no D=
HCP
> server and ifupdown - for test purposes, I'm bringing networking manually.
> Apparmor disabled as well. Kernel (Linux 5.19.0-42-generic
> #43~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC) compiled without CONFIG_IP_PNP
> (according to /boot/config-5.19.0-42-generic). Nothing in userspace liste=
ns
> on UDP/68 and UDP/67:

Can you reproduce this on latest mainline?

>=20
> # netstat -tunlpa
> Active Internet connections (servers and established)
> Proto Recv-Q Send-Q Local Address=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Foreign Address=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
> State=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PID/Program name
> tcp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0 0.0.0.0:22 0.0.0.0:*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LISTEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 544/sshd:
> /usr/sbin
> tcp6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
0 :::22 :::*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LISTEN=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 544/sshd:
> /usr/sbin
>=20
> I have no ideas, why this is happening. Decapsulation itself works, but
> particular kind of packets get lost.
>=20
> I will appreciate if anyone can help me understand where is the bug - in =
my
> configuration or somewhere inside the kernel?
>=20
> Evidence of traffic presence/absence is below.
>=20
> Thank you.
>=20
> Encapsulated ERSPAN session (udp and port 67/68) contains lot of different
> kinds of DHCP packets:
>=20
> # tcpdump -s0 -w- -i enp2s0 'proto gre and ether[73:1]=3D17 and
> (ether[84:2]=3D67 or ether[84:2]=3D68)' | tshark -r- -l
> =C2=A0[ ... ]
> =C2=A0=C2=A0=C2=A0 7=C2=A0=C2=A0 0.001942=C2=A0 0.0.0.0 =E2=86=92 255.255=
=2E255.255 DHCP 392 DHCP Discover -
> Transaction ID 0x25c096fc
> =C2=A0=C2=A0=C2=A0 8=C2=A0=C2=A0 0.003432=C2=A0 z.z.z.z =E2=86=92 a.a.a.a=
 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DHCP 418 DHCP ACK=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -
> Transaction ID 0x5515126a
> =C2=A0=C2=A0=C2=A0 9=C2=A0=C2=A0 0.005170=C2=A0 m.m.m.m =E2=86=92 z.z.z.z=
 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DHCP 435 DHCP Discover -
> Transaction ID 0xa7b7
> =C2=A0=C2=A0 10=C2=A0=C2=A0 0.005171=C2=A0 m.m.m.m =E2=86=92 z.z.z.z=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DHCP 435 DHCP Discover -
> Transaction ID 0xa7b7
> =C2=A0=C2=A0 11=C2=A0=C2=A0 0.015399=C2=A0 n.n.n.n =E2=86=92 z.z.z.z=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DHCP 690 DHCP Request=C2=A0 -
> Transaction ID 0x54955233
> =C2=A0=C2=A0 12=C2=A0=C2=A0 0.025537=C2=A0 z.z.z.z =E2=86=92 n.n.n.n=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DHCP 420 DHCP ACK=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -
> Transaction ID 0x54955233
> =C2=A0=C2=A0 13=C2=A0=C2=A0 0.030313=C2=A0 z.z.z.z =E2=86=92 m.m.m.m =C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DHCP 413 DHCP Offer=C2=A0=C2=A0=C2=
=A0 -
> Transaction ID 0xa7b7
>=20
> but decapsulated traffic (which I'm seeing on inspan interface) contains
> just the following:
>=20
> # tcpdump -i inspan 'port 67 or port 68'
> listening on inspan, link-type EN10MB (Ethernet), snapshot length 262144
> bytes
> 17:23:36.540721 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP,
> Request from 00:1a:64:33:8d:fa (oui Unknown), length 300
> 17:23:39.760036 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP,
> Request from 00:1a:64:33:8d:fa (oui Unknown), length 300
> 17:23:44.135711 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP,
> Request from 00:1a:64:33:8d:fa (oui Unknown), length 300
> 17:23:52.008504 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP,
> Request from 00:1a:64:33:8d:fa (oui Unknown), length 300
>=20

What hardware?

--=20
An old man doll... just what I always wanted! - Clara

--aNOZKJJDPt95AMQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZOqvxQAKCRD2uYlJVVFO
o4J2AQCm9hvlqgudCT9i+WZ01S3ukWoQ0YIHzd117pIJDwJ4EgD7BKcyeDH4f2Q3
9Pw7aOq5rF+GtOTZk1yHl6hb5dM7kQA=
=+iUI
-----END PGP SIGNATURE-----

--aNOZKJJDPt95AMQg--
