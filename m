Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7857CCE0A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjJQU2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbjJQU2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:28:16 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5956DBA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:28:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qsqfI-0007Y4-Un; Tue, 17 Oct 2023 22:27:44 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qsqfG-002Ogt-Nj; Tue, 17 Oct 2023 22:27:42 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4BD7C2385D9;
        Tue, 17 Oct 2023 20:27:42 +0000 (UTC)
Date:   Tue, 17 Oct 2023 22:27:41 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Johannes Zink <j.zink@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Eric Dumazet <edumazet@google.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Simon Horman <horms@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, patchwork-jzi@pengutronix.de
Subject: Re: [PATCH net-next 2/5] net: stmmac: fix PPS capture input index
Message-ID: <20231017-transfer-refurbish-5cfaf12a524c-mkl@pengutronix.de>
References: <20231010-stmmac_fix_auxiliary_event_capture-v1-0-3eeca9e844fa@pengutronix.de>
 <20231010-stmmac_fix_auxiliary_event_capture-v1-2-3eeca9e844fa@pengutronix.de>
 <20231014144428.GA1386676@kernel.org>
 <004d6ce9-7d15-4944-b31c-c9e628e7483a@pengutronix.de>
 <20231017082618.4558ad06@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jxb4irrvefe35xe5"
Content-Disposition: inline
In-Reply-To: <20231017082618.4558ad06@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jxb4irrvefe35xe5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.10.2023 08:26:18, Jakub Kicinski wrote:
> On Tue, 17 Oct 2023 11:12:53 +0200 Johannes Zink wrote:
> > > If it is a bug fix then it should probably be targeted at 'net',
> > > creating a dependency for the remainder of this series.
> > >=20
> > > On the other hand, if it is not a bug fix then perhaps it is best to
> > > update the subject and drop the Fixes tag. =20
> >=20
> > I added the fixes-Tag in order to make code archeology easier, but as i=
t may=20
> > trigger picks to stable branches (which is not required imho), I have n=
o=20
> > objections to dropping it for a v2.
>=20
> Would be good to clarify what impact on device operation the problem
> has. How would end user notice the problem?
> Does it mean snapshots were always or never enabled, previously?

On all dwmac devices not covered by dwmac-intel.c (INTEL 10/100/1000
Ethernet PCI driver), PPS capture can be requested from user-space, but
is not enabled in HW. There is no error message or other feedback to the
user space. The user space will not get any PPS events.

As this change also affects the Intel driver, and we don't have any
hardware to test, I think it's better that this goes via net-next to
give it a bit more time of testing.

> Note that if you submit this fix for net today it will still make it=20
> to -rc7 and net-next by tomorrow, so no major delay. We merge the trees
> on Thursday, usually.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jxb4irrvefe35xe5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUu7jsACgkQvlAcSiqK
BOjTdwf+PU0hEZRTTz3uvV22X9GHPn8ISxXtSbQP8oYST3HfxTdQSC8RkCKnWNy1
Fn2LgnwMCbQPWMobKRPjCU9fRnx1dmYCHUUyouXS+gvoy6AQoguwJgh4kalerA0k
vnA6fEeXt+Vm5ut/t9b0oQnSL6McZZS5vA9QWDQ4ouJfcAnP9dokWLoCoADR5w1p
8+nnnDDpYFE2Z9XUmyHy6SizjEhFgHRWyiP2nEg8RrxO5rhBqoU9HZqjZ9HtBx2B
ZpBOVX2M0v/cF+tVMOXLvdiC5CoZZiSpncPEF9bkwRDMZUmb56MgVQ2+o5cXCrI8
sNXUAlynq/n6yhnGsui4EakF/VXDMw==
=fvJW
-----END PGP SIGNATURE-----

--jxb4irrvefe35xe5--
