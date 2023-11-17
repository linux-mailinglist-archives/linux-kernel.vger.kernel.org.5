Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF917EF818
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjKQT5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQT5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:57:23 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA71AD;
        Fri, 17 Nov 2023 11:57:19 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C79BF1C006B; Fri, 17 Nov 2023 20:57:17 +0100 (CET)
Date:   Fri, 17 Nov 2023 20:57:17 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tglozar@redhat.com, tglx@linutronix.de, phil@nwl.cc
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.1 000/379] 6.1.63-rc1 review
Message-ID: <ZVfFnU1FU3V6IHJ5@duo.ucw.cz>
References: <20231115192645.143643130@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6GPu7+NXCR1QNfCW"
Content-Disposition: inline
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6GPu7+NXCR1QNfCW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.63 release.
> There are 379 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.


> Tomas Glozar <tglozar@redhat.com>
>     nd_btt: Make BTT lanes preemptible

This is for preempt-rt only, and we don't really have that in
-stable. This means we don't really need this in 4.19, either:

d9ea9d2ff 666300 o: 4.19| sched/rt: Provide migrate_disable/enable()
inlines

> Phil Sutter <phil@nwl.cc>
>     netfilter: nf_tables: Drop pointless memset when dumping rules

A cleanup, but I don't believe we need it in -stable.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6GPu7+NXCR1QNfCW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZVfFnQAKCRAw5/Bqldv6
8iBhAJ0cwhl170g8auTIHKASrVgXDMznqQCfTW/9XWjNoVVUwSBLE8vU/2nvt9E=
=xxS+
-----END PGP SIGNATURE-----

--6GPu7+NXCR1QNfCW--
