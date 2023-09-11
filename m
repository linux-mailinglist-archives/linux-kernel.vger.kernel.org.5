Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F270879B747
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241776AbjIKWKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbjIKJ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:57:53 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072A1E67;
        Mon, 11 Sep 2023 02:57:49 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CE4371C0004; Mon, 11 Sep 2023 11:57:47 +0200 (CEST)
Date:   Mon, 11 Sep 2023 11:57:47 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL 4.19 12/14] workqueue: Call
 wq_update_unbound_numa() on all CPUs in NUMA node on CPU hotplug
Message-ID: <ZP7kmzEAizx8MU/Z@duo.ucw.cz>
References: <20230909004045.3581014-1-sashal@kernel.org>
 <20230909004045.3581014-12-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8J4fcvWLIF2OKCkg"
Content-Disposition: inline
In-Reply-To: <20230909004045.3581014-12-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8J4fcvWLIF2OKCkg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> When a CPU went online or offline, wq_update_unbound_numa() was called on=
ly
> on the CPU which was going up or down. This works fine because all CPUs on
> the same NUMA node share the same pool_workqueue slot - one CPU updating =
it
> updates it for everyone in the node.
>=20
> However, future changes will make each CPU use a separate pool_workqueue
> even when they're sharing the same worker_pool, which requires updating
> pool_workqueue's for all CPUs which may be sharing the same pool_workqueue
> on hotplug.

Yes, but we are not porting those future changes to stable, right?
Please drop.

BR,
									Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--8J4fcvWLIF2OKCkg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZP7kmwAKCRAw5/Bqldv6
8kQaAKCveu4EhlskbQXvPfbu0S7DAWgihQCfbXge4GJr46GZ+Q5jsPQOv1RldeE=
=8awX
-----END PGP SIGNATURE-----

--8J4fcvWLIF2OKCkg--
