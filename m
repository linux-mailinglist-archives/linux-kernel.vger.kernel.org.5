Return-Path: <linux-kernel+bounces-23474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 131A082AD46
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CC8288594
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46CB15499;
	Thu, 11 Jan 2024 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b="dwSlHn7G"
Received: from smtp2-kfki.kfki.hu (smtp2-kfki.kfki.hu [148.6.0.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB57E15492;
	Thu, 11 Jan 2024 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=blackhole.kfki.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blackhole.kfki.hu
Received: from localhost (localhost [127.0.0.1])
	by smtp2.kfki.hu (Postfix) with ESMTP id 835CACC02BC;
	Thu, 11 Jan 2024 12:22:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:references:message-id
	:in-reply-to:from:from:date:date:received:received:received
	:received; s=20151130; t=1704972153; x=1706786554; bh=ItwLxOEzQ4
	5w4lPvLTUHSM4c0y/LFPNe9lzTTBcz9zU=; b=dwSlHn7GZyeW5jcFnxUh8motT+
	j4Z/V/JQRPqrOaZRFsPoKTbtdhOt1cApXYAgwSOAit9Xh4omg1UcqPGGkRXaByB1
	K6yPX4tKIZh8tnSa9QaWkyh21MYRCr56w0qApAPtP9ZfZXtTCvh3B9xf0PNqw9yd
	TJMr843TZwa6tm02g=
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
	by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP; Thu, 11 Jan 2024 12:22:33 +0100 (CET)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
	by smtp2.kfki.hu (Postfix) with ESMTP id 04F3DCC0134;
	Thu, 11 Jan 2024 12:22:33 +0100 (CET)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
	id F24CB343167; Thu, 11 Jan 2024 12:22:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by blackhole.kfki.hu (Postfix) with ESMTP id F09AF343166;
	Thu, 11 Jan 2024 12:22:32 +0100 (CET)
Date: Thu, 11 Jan 2024 12:22:32 +0100 (CET)
From: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To: David Wang <00107082@163.com>
cc: ale.crismani@automattic.com, xiaolinkui@kylinos.cn, 
    Pablo Neira Ayuso <pablo@netfilter.org>, linux-kernel@vger.kernel.org, 
    netfilter-devel@vger.kernel.org
Subject: Re:Re: Performance regression in ip_set_swap on 6.1.69
In-Reply-To: <7c8d2978.8451.18cf8384d73.Coremail.00107082@163.com>
Message-ID: <b333bc85-83ea-8869-ccf7-374c9456d93c@blackhole.kfki.hu>
References: <C0829B10-EAA6-4809-874E-E1E9C05A8D84@automattic.com> <20240110102342.4978-1-00107082@163.com> <a4dfc3d9-f028-7ab4-c3a7-11dcbb12e377@netfilter.org> <661cb613.7974.18cf30c4a42.Coremail.00107082@163.com> <956ec7cd-16ef-7f72-dad8-dfa2ec5f4d77@netfilter.org>
 <0d0b1526-6189-fd0f-747e-cb803936b20a@blackhole.kfki.hu> <7c8d2978.8451.18cf8384d73.Coremail.00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="110363376-155968070-1704972152=:2980"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--110363376-155968070-1704972152=:2980
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 11 Jan 2024, David Wang wrote:

> At 2024-01-11 16:25:46, "Jozsef Kadlecsik" <kadlec@blackhole.kfki.hu> w=
rote:
> >
> >
> >Could you check that the patch below fixes the performance regression?=
=20
> >Instead of waiting for the RCU grace period at swapping, call_rcu() is=
=20
> >used at destroying the set.
>=20
> Got a compiler error:
> net/netfilter/ipset/ip_set_core.c: In function =E2=80=98ip_set_destroy_=
set_rcu=E2=80=99:
> net/netfilter/ipset/ip_set_core.c:1017:9: error: implicit declaration o=
f function =E2=80=98ip_set_destroy_set=E2=80=99; did you mean =E2=80=98ip=
_set_destroy_set_rcu=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>  1017 |         ip_set_destroy_set(set);
>       |         ^~~~~~~~~~~~~~~~~~
>       |         ip_set_destroy_set_rcu
> net/netfilter/ipset/ip_set_core.c: At top level:
> net/netfilter/ipset/ip_set_core.c:1183:1: warning: conflicting types fo=
r =E2=80=98ip_set_destroy_set=E2=80=99; have =E2=80=98void(struct ip_set =
*)=E2=80=99
>  1183 | ip_set_destroy_set(struct ip_set *set)
>       | ^~~~~~~~~~~~~~~~~~
> net/netfilter/ipset/ip_set_core.c:1183:1: error: static declaration of =
=E2=80=98ip_set_destroy_set=E2=80=99 follows non-static declaration
>
>  I move the declaration of ip_set_destroy_set_rcu, make sure it is afte=
r=20
> the declaration of ip_set_destroy_set, With this path, the performance=20
> degradation of ipset_swap is gone,

Thanks! I wrote the patch for the ipset package code and while it applies=
=20
to the vanilla kernel source, function definiton ordering got broken.=20
Sorry, I should have to double check.

> but my test only stress ipset_swap, not a swap/destroy sequence. I will=
=20
> adjust my code to stress a full swap/destroy/create/add sequence, and=20
> update later.

The synchronize_rcu() in ip_set_swap() was added to exclude the parallel=20
swap+destroy and kernel side add/del/test operations, which can be tested=
=20
with the commands

    ipset create hash_ip1 hash:net family inet hashsize 1024 maxelem 1048=
576
    ipset add hash_ip1 172.20.0.0/16
    ipset add hash_ip1 192.168.0.0/16
    iptables -A INPUT -m set --match-set hash_ip1 src -j ACCEPT
    while [ 1 ]
    do
            # ... Ongoing traffic...
            ipset create hash_ip2 hash:net family inet hashsize 1024 maxe=
lem 1048576
            ipset add hash_ip2 172.20.0.0/16
            ipset swap hash_ip1 hash_ip2
            ipset destroy hash_ip2
            sleep 0.05
    done

I have checked it but the virtual machine on my dev laptop might be too=20
slow to trigger the case.

Best regards,
Jozsef
--=20
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary
--110363376-155968070-1704972152=:2980--

