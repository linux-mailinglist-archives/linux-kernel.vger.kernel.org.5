Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9617DB778
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjJ3KJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjJ3KJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:09:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBED8A66
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:09:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5F8C433C7;
        Mon, 30 Oct 2023 10:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698660591;
        bh=aOJp9arIxD4+2YX6aYp5G3/SWUPCISOGcJx1Qe5e+v0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d/nkwbnLMin+Ck6JDhMLdWvCOEmz5fHFmUGdWQQzpaCzOk3AtQYKPu11dRCmfq9Ut
         URpUxunxChHiIFCASjkzoVf22E5SVFhr9y7SBFC+5hckJUXHUP+QuciiRDt5M+PSzP
         a5QmY89Q5SwI1/StswwibDTL/qTdPqRrK8nTOBIwPpEahf/qoB21Q6XxV/eFfjhzQz
         TF5pX5GwT1fQaO4gqfiyLC1ghT7R8FM0XTutJy2jbsw3afqu1UypmGk4mktDbPxxPQ
         zCJjnbLkCVhTz64hpYx1JJVIE9rKCpM6xjPe20KG9SdtlweLI50X83CQepJKv8JRDc
         XMVv4eN4t7kAg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qxPDt-0003JV-07;
        Mon, 30 Oct 2023 11:10:17 +0100
Date:   Mon, 30 Oct 2023 11:10:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] gnss: tell what GNSS means
Message-ID: <ZT-BCS_tGfbeYQyL@hovoldconsulting.com>
References: <20230925054346.18065-1-rdunlap@infradead.org>
 <ZS1K5AoZnS-3H-c3@hovoldconsulting.com>
 <ZT4GnZUUVy0Ri5rS@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OLAOSNH9XiTcuhY8"
Content-Disposition: inline
In-Reply-To: <ZT4GnZUUVy0Ri5rS@duo.ucw.cz>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OLAOSNH9XiTcuhY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2023 at 08:15:41AM +0100, Pavel Machek wrote:
> On Mon 2023-10-16 16:38:28, Johan Hovold wrote:
> > On Sun, Sep 24, 2023 at 10:43:46PM -0700, Randy Dunlap wrote:
> > > Tell users what GNSS means in the Kconfig prompt.
> > =20
> > >  menuconfig GNSS
> > > -	tristate "GNSS receiver support"
> > > +	tristate "GNSS (Global Navigation Satellite System) receiver suppor=
t"
> >=20
> > No, I don't like the way this clutters menuconfig. The above would make
> > this one of the longest entries and for very little gain.
>=20
> Yeah, because everyone knows what GNSS means.

It's an established term (e.g. see [1]), and as I mentioned in the
context you dropped we don't spell out what NVMe or SPI stands for
either.

> Except that most people know GNSS as GPS. You misnamed the subsystem,
> so it now needs explanation :-(.

No, naming it GPS would have been too specific as these receivers are
not just for GPS.

Either way, this is about not cluttering up menuconfig and making that
harder to navigate for no good reason.

Johan

[1] https://www.u-blox.com/en/positioning-chips-and-modules

--OLAOSNH9XiTcuhY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZT+BBAAKCRALxc3C7H1l
CEhAAQC8qvbul2rPKjcpRr/oS+nheStEZv7fq+btKU0oSnMzfAD9FjfiIpfJFKxg
UMKtDSngKZawnNkejEct5PAe3W+1dA0=
=OsY+
-----END PGP SIGNATURE-----

--OLAOSNH9XiTcuhY8--
