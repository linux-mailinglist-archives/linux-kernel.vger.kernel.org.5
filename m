Return-Path: <linux-kernel+bounces-63375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3226D852E60
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578A61C22786
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034792BB03;
	Tue, 13 Feb 2024 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="r0VICPfK"
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE3C225A6;
	Tue, 13 Feb 2024 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821472; cv=none; b=rkPGE6Ei4VY6vw/dBL1o58wa7gvou+CwtE6wr9mTdbj1syuEzdwRoFe/VPz0fS7USCRehipUG9Hy6SqquehB4/g/F/MsLXI1/0+fOLLpJYU455TXXLvp6YE0VIUykckdbh7D79BzvhtSLurRkL+NGVqKMFo+VRYS39AsHBLWzRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821472; c=relaxed/simple;
	bh=nGMX4aenpuZDTdzfZczuy4H823bXbSVyEL7qzNy2prE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlCXp2qdujWwCck5SMxQXehB/adBccRZu77VJ/vSDNLiDaZYRtpX5X4ZEZuSd/CeIxgIfj2o25i4bmvP0Tsm6NFlcS+IU0NwaVjTziyGqWJa3MsmGhuAKySrC14rjAu7NbUNuDYoxpPQOLImiEWnHHM4NCvU3MWdH4rvfCZb10E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=r0VICPfK; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from localhost (unknown [IPv6:2a02:8012:909b:0:eaae:9bde:cb7b:6924])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id D67337D5C1;
	Tue, 13 Feb 2024 10:51:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1707821468; bh=nGMX4aenpuZDTdzfZczuy4H823bXbSVyEL7qzNy2prE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Disposition:In-Reply-To:From;
	z=Date:=20Tue,=2013=20Feb=202024=2010:51:08=20+0000|From:=20Tom=20P
	 arkin=20<tparkin@katalix.com>|To:=20Samuel=20Thibault=20<samuel.th
	 ibault@ens-lyon.org>,=0D=0A=09James=20Chapman=20<jchapman@katalix.
	 com>,=20edumazet@google.com,=0D=0A=09gnault@redhat.com,=20davem@da
	 vemloft.net,=20kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=20corbe
	 t@lwn.net,=20netdev@vger.kernel.org,=0D=0A=09linux-doc@vger.kernel
	 .org,=20linux-kernel@vger.kernel.org|Subject:=20Re:=20[PATCHv4]=20
	 PPPoL2TP:=20Add=20more=20code=20snippets|Message-ID:=20<ZctJnCeUCA
	 NJvxGj@katalix.com>|References:=20<20240212222344.xtv233r5sixme32h
	 @begin>|MIME-Version:=201.0|Content-Disposition:=20inline|In-Reply
	 -To:=20<20240212222344.xtv233r5sixme32h@begin>;
	b=r0VICPfK0yPvrDK7aLblGMV1OQuUUPUojSyrFkabhJ7zUyGQtdwfU7oFpFnWcJNtn
	 pNmZRSOEhapvomSQ+tsn+c/wgsjM4cTOI7WeXgDZB8Tlri3FL8p2YSAsk+7Pl5Qz9U
	 0T/N4JxrE3QROPmFGyCKQvDauqrGRKBKR8drNUfl2Q1N0z2wg4VSv9BedH1jMQOUdX
	 /9+9H3Wb3TquT3/Y6RKUTuFWOReUQ0p5GWrYOyDm3XkZB/dNfvR/rLtoazVuG+cqPt
	 +XpmwR1d3wP01mYWVPhS2BwZRKjRNF/QVSHrxyX9JQG9ny8VJhctwMYrR/UHSXZnQ2
	 35hQUqGr6WcZg==
Date: Tue, 13 Feb 2024 10:51:08 +0000
From: Tom Parkin <tparkin@katalix.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	James Chapman <jchapman@katalix.com>, edumazet@google.com,
	gnault@redhat.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4] PPPoL2TP: Add more code snippets
Message-ID: <ZctJnCeUCANJvxGj@katalix.com>
References: <20240212222344.xtv233r5sixme32h@begin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k2N5Gjlw2xDByqqX"
Content-Disposition: inline
In-Reply-To: <20240212222344.xtv233r5sixme32h@begin>


--k2N5Gjlw2xDByqqX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On  Mon, Feb 12, 2024 at 23:23:44 +0100, Samuel Thibault wrote:
> --- a/Documentation/networking/l2tp.rst
> +++ b/Documentation/networking/l2tp.rst
> @@ -386,12 +386,17 @@ Sample userspace code:
> =20
>    - Create session PPPoX data socket::
> =20
> +        /* Input: the L2TP tunnel UDP socket `tunnel_fd`, which needs to=
 be
> +         * bound already, otherwise it will not be ready. */
> +

Sorry for the nit :-| but we should adhere to the kernel coding style
I think -- so the comment block should look like this:

    /* Input: the L2TP tunnel UDP socket `tunnel_fd`, which needs to be
     * bound already, otherwise it will not be ready.
     */

>          struct sockaddr_pppol2tp sax;
> -        int fd;
> +        int session_fd;
> +        int ret;
> +
> +        session_fd =3D socket(AF_PPPOX, SOCK_DGRAM, PX_PROTO_OL2TP);
> +        if (session_fd < 0)
> +                return -errno;
> =20
> -        /* Note, the tunnel socket must be bound already, else it
> -         * will not be ready
> -         */
>          sax.sa_family =3D AF_PPPOX;
>          sax.sa_protocol =3D PX_PROTO_OL2TP;
>          sax.pppol2tp.fd =3D tunnel_fd;
> @@ -406,11 +411,117 @@ Sample userspace code:
>          /* session_fd is the fd of the session's PPPoL2TP socket.
>           * tunnel_fd is the fd of the tunnel UDP / L2TPIP socket.
>           */
> -        fd =3D connect(session_fd, (struct sockaddr *)&sax, sizeof(sax));
> -        if (fd < 0 ) {
> +        ret =3D connect(session_fd, (struct sockaddr *)&sax, sizeof(sax)=
);
> +        if (ret < 0 ) {
> +                close(session_fd);
> +                return -errno;
> +        }
> +
> +        return session_fd;
> +
> +L2TP control packets will still be available for read on `tunnel_fd`.
> +
> +  - Create PPP channel::
> +
> +        /* Input: the session PPPoX data socket session_fd which was cre=
ated as
> +         * described above. */

Again, I think this comment should adhere to the kernel coding style.

Do we need backticks for `session_fd` for consistency?

> +
> +        int chindx;
> +        int ppp_chan_fd;

=2E..and we should follow netdev-style Christmas-tree declaration
ordering, i.e:

    int ppp_chan_fd;
    int chindx;

> +
> +        ret =3D ioctl(session_fd, PPPIOCGCHAN, &chindx);
> +        if (ret < 0)
> +                return -errno;
> +
> +        ppp_chan_fd =3D open("/dev/ppp", O_RDWR);
> +        if (ppp_chan_fd < 0)
> +                return -errno;
> +
> +        ret =3D ioctl(ppp_chan_fd, PPPIOCATTCHAN, &chindx);
> +        if (ret < 0) {
> +                close(ppp_chan_fd);
> +                return -errno;
> +        }
> +
> +        return ppp_chan_fd;
> +
> +LCP PPP frames will be available for read on `ppp_chan_fd`.
> +
> +  - Create PPP interface::
> +
> +        /* Input: the PPP channel ppp_chan_fd which was created as descr=
ibed
> +         * above */

Again, I think this comment should adhere to the kernel coding style.

Do we need backticks for `ppp_chan_fd` for consistency?

> +
> +        int ppp_if_fd;
> +        int ifunit =3D -1;

netdev-style Christmas-tree declaration ordering here too please.

> +
> +        ppp_if_fd =3D open("/dev/ppp", O_RDWR);
> +        if (ppp_if_fd < 0)
> +                return -errno;
> +
> +        ret =3D ioctl(ppp_if_fd, PPPIOCNEWUNIT, &ifunit);
> +        if (ret < 0) {
> +                close(ppp_if_fd);
> +                return -errno;
> +        }
> +
> +        ret =3D ioctl(ppp_chan_fd, PPPIOCCONNECT, ifunit);

I think this should be:

    ret =3D ioctl(ppp_chan_fd, PPPIOCCONNECT, &ifunit);

(note the missing '&' in the patch).

> +        if (ret < 0) {
> +                close(ppp_if_fd);
>                  return -errno;
>          }
> -        return 0;
> +
> +        return ppp_if_fd;
> +
> +IPCP/IPv6CP PPP frames will be available for read on `ppp_if_fd`.
> +
> +The ppp<ifunit> interface can then be configured as usual with netlink's
> +RTM_NEWLINK, RTM_NEWADDR, RTM_NEWROUTE, or ioctl's SIOCSIFMTU, SIOCSIFAD=
DR,
> +SIOCSIFDSTADDR, SIOCSIFNETMASK, SIOCSIFFLAGS, or with the `ip` command.
> +
> +  - Bridging L2TP sessions which have PPP pseudowire types (this is also=
 called
> +    L2TP tunnel switching or L2TP multihop) is supported by bridging the=
 ppp
> +    channels of the two L2TP sessions to be bridged::

s/ppp/PPP/ for the indented block here.

The device name `ppp<ifunit>` should be lowercase still since that's
what the actual device name will be.

> +
> +        /* Input: the session PPPoX data sockets session_fd1 and session=
_fd2
> +         * which were created as described further above. */
> +

Again, I think this comment should adhere to the kernel coding style.

Do we need backticks for `session_fd1` and `session_fd2` for consistency?

> +        int chindx1;
> +        int chindx2;
> +        int ppp_chan_fd;
> +

netdev-style Christmas-tree declaration ordering here too please.

> +        ret =3D ioctl(session_fd1, PPPIOCGCHAN, &chindx1);
> +        if (ret < 0)
> +                return -errno;
> +
> +        ret =3D ioctl(session_fd2, PPPIOCGCHAN, &chindx2);
> +        if (ret < 0)
> +                return -errno;
> +
> +        ppp_chan_fd =3D open("/dev/ppp", O_RDWR);
> +        if (ppp_chan_fd < 0) {
> +                return -errno;
> +        }
> +
> +        ret =3D ioctl(ppp_chan_fd, PPPIOCATTCHAN, &chindx1);
> +        if (ret < 0) {
> +                close(ppp_chan_fd);
> +                return -errno;
> +        }

I think we should drop the PPPIOCATTCHAN ioctl call here.

The input file descriptors are called out as being PPPoX sockets
created as described earlier, in which case they should both
already be attached to a channel.

It would make more sense IMO to call out the two ppp_chan_fd file
descriptors as being input parameters alongside the PPPoX session file
descriptors.

> +
> +        ret =3D ioctl(ppp_chan_fd, PPPIOCBRIDGECHAN, &chindx2);
> +        close(ppp_chan_fd);
> +        if (ret < 0)
> +                return -errno;
> +
> +It can be noted that in this case no PPP interface is needed, and the PPP
> +channel does not need to be kept open.  Only the session PPPoX data sock=
ets need
> +to be kept open.

Is it true to say that the PPP channel file descriptors can be closed
by userspace?  I'd need to re-review the ppp_generic.c refcounting to
be sure -- maybe you have some code which proves this assertion?

The user of PPPIOCBRIDGECHAN that I'm familiar with (go-l2tp) keeps
the PPP channel fds for the PPPoE and PPPoL2TP channels around for the
duration of the connection.  Possibly it's not necessary, but I'd
prefer we're totally sure before we call it out in the docs.

Maybe we could say something like this:

    "When bridging PPP channels, the PPP session is not locally terminated,
     and no local PPP device is created.  PPP frames arriving on one channel
     are directly passed to the other channel, and vice versa."

?

> +
> +More generally, it is also possible in the same way to e.g. bridge a PPP=
ol2tp
> +ppp channel with other types of ppp channels, such as PPPoE.

s/PPPol2tp/PPPoL2TP/

s/ppp/PPP/

> +
> +See more details for the PPP side in ppp_generic.rst.
> =20
>  Old L2TPv2-only API
>  -------------------

Thanks again for your work.  I know the above is all quite nit-picky
on the whole, so apologies -- but that's probably a sign we're getting
close :-)

Tom
--=20
Tom Parkin
Katalix Systems Ltd
https://katalix.com
Catalysts for your Embedded Linux software development

--k2N5Gjlw2xDByqqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEsUkgyDzMwrj81nq0lIwGZQq6i9AFAmXLSZkACgkQlIwGZQq6
i9AMnwf+PR66R/OCMFb4CJwd4IBnu6T8qa6iz9ZsuPS9U6c/53dUGZfIF5FzuxB+
5Mxy+ztKzfChrmk2sRZUPMDaVl7Pmqo5s9d2wLoGwtaT3/cEXHRFffFxITMPc+Hy
rsFf+LgTDgtt/2j/TUmC3Cou8+T1VoS94o83eFlNGfEEPw+3eoBW/8R88HOKAw9n
9N9ei/cspa3zFhZLcoE9Vwiz7xqrWU27Lzl/gXXVlaFSFJESXOOZaZkmsbYwa2T7
wuov4km7N5BYbHkIj2xpbkxWsa1huXoeucMD003BmA6NT0K/7U4bZ/xF8kvD9rxe
Px5FMyzIOnbNj80O82+bBVpbbXzqqw==
=8cg1
-----END PGP SIGNATURE-----

--k2N5Gjlw2xDByqqX--

