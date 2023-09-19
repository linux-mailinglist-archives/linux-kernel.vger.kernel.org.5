Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4448B7A6641
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjISOOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjISOOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:14:42 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDA41998
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:14:35 -0700 (PDT)
Received: from spock.localnet (unknown [94.142.239.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id EB91D1505CD8;
        Tue, 19 Sep 2023 16:14:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1695132873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IdvszLJqDb9chviIGv2JahG+XK2N5WpvCdqRZN6V1vs=;
        b=bTLN2a9myURzPaJ6GKtqPFr6h3Qa8BPmjnUMuloG+KyGz6duaouw0mrOb86sdeeG3no0Fc
        WY+pdAWKvCRaLy0jVMU3+XdVl20KMcO2X7vuYEChqaFQ08lmNq6p+CgBbo4q5TsHKqBnGc
        PceUAcBNWH6O5LxCC7wZ+ZeQ2Yv2CEw=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>, linux-mm@kvack.org,
        David Airlie <airlied@gmail.com>,
        Linux Regressions <regressions@lists.linux.dev>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Auld <matthew.auld@intel.com>,
        Thomas =?ISO-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Linux Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Intel-gfx] [REGRESSION] [BISECTED] Panic in gen8_ggtt_insert_entries()
 with v6.5
Date:   Tue, 19 Sep 2023 16:14:21 +0200
Message-ID: <3565884.aeNJFYEL58@natalenko.name>
In-Reply-To: <ZQmqF7oyrZ32Qdhb@debian.me>
References: <4857570.31r3eYUQgx@natalenko.name> <2612319.ElGaqSPkdT@natalenko.name>
 <ZQmqF7oyrZ32Qdhb@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3572117.44csPzL39Z";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3572117.44csPzL39Z
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Tue, 19 Sep 2023 16:14:21 +0200
Message-ID: <3565884.aeNJFYEL58@natalenko.name>
In-Reply-To: <ZQmqF7oyrZ32Qdhb@debian.me>
MIME-Version: 1.0

On =C3=BAter=C3=BD 19. z=C3=A1=C5=99=C3=AD 2023 16:03:03 CEST Bagas Sanjaya=
 wrote:
> =E2=80=A6
> > > [1] https://gitlab.freedesktop.org/drm/intel/-/issues/9256
> >=20
> > Bagas,
> >=20
> > would you mind adding this to the regression tracker please?
> >=20
>=20
> Will add shortly, thanks!

Thank you.

Please consider correcting the title though. Lenovo T14s (Tiger Lake) is no=
t affected.  Affected are: Lenovo T460s (Skylake) and Lenovo T490s (Whiskey=
Lake)

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart3572117.44csPzL39Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmUJrL0ACgkQil/iNcg8
M0vMshAAmTYLH8DFD+m7rWIIQquwNlbxqUD0Q/6YwgXkLSbySgxN2twgg4FXTPjd
sw7ru11rdJIH7kxqiigqdVX0/TDO9ErGVNJSdo3u2jQepWZRbhXy051iioi0s2Nc
ASstkQl3xirIhPsTeZXpQHkZtufN1ERg4RiATs15MCWzJJC7+igQedWiHJLjYJjy
V8zWCWR6NbE9Eik5A1ZXHsOE7qbpM0pEofyeaNVSdduLrwULILreEu9hbPIHG8/O
CHKju3zU+k+LHN9xAldQLL2eDA7BrAkIfMj514dkXtrAbLDVVUXvEHTAEFRx+76e
RMokVQcTo/4dNb3uGfezA8wl537qOu/tAsuie9a7zL9LH6gYq4AbsiAUt0+iq3yY
MZoNdMYTnUAN6ghK2wwQfIDjOD1kjYynKCkQ+YFT/DmUbNb72nUBXUywkDSshs0L
bKeOuawoH7uWhViWHTmKFOguFI23vKBd+uj1/d5UPU3QAp000ek168MDrkZSE8w2
S4b+RJ5YTcp7Bx1ELCBUzHw75PEmiAhRnUE5xkdhZeH1Q2nyQuW++GIR5RmYQGtf
Jh9s77DlzdbqZ8rYy0f7AZjsQZYhB+Z6ZUGrcDc1qxkNUzV9jGlAuCzN28LH5LOD
hVTRD08dz0XX6xw/BTLcyHfGNY0paKRCJUP4rXuQq3YL7DCfwLE=
=YpdN
-----END PGP SIGNATURE-----

--nextPart3572117.44csPzL39Z--



