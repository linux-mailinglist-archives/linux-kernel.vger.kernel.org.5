Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D957C8737
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjJMNws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjJMNwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:52:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A77BE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:52:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60835C433C7;
        Fri, 13 Oct 2023 13:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697205162;
        bh=KjJQ3wiK1ajYj/DRYJtyOpsyAFJd2c7okKUZzJjUDgE=;
        h=Date:From:To:Cc:Subject:From;
        b=X5VcHeJCnJV6Cw38QXPBb9GZpPN2P5VGsllbYYzZraUFj6NJPGePskkSUhWaDdi2Q
         /GWa+K98tYsrMeEGBQJsptXE7GEZVSjb6Z81C/D/l5TB7NRuGDwKmPn+jyIenZT8cQ
         /tl6HTGBteDFwmnHUqI8LV7dfs6xtLt5ZGMG+cWEkg0sihfTf66hGyuwljg33fX9eJ
         NvJmZhKXqmYMsl8cIRRNI959+AxPFoqI6mcs39fiEqFkHbKWBcUpB4Q/EWKeE9/bgt
         HmaMUC8dSbOC4HRtF90x4XaWWafvbrsGCGVt1E6VB7McfsHBZQOW66am/DPdMhYtdM
         8PT+zmCN+juIw==
Date:   Fri, 13 Oct 2023 19:22:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire subsystem fixes for v6.6
Message-ID: <ZSlLpvkzvDUEzR1M@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7r3Mkf9Id9TZ9hMU"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7r3Mkf9Id9TZ9hMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull a single fix for soundwire subsystem for making sdw bus irq
conditionally built

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.6-fixes

for you to fetch changes up to 3b6c4a11bf2b810f772f5c2c1ef6eef3fc268246:

  soundwire: bus: Make IRQ handling conditionally built (2023-09-21 11:31:3=
3 +0200)

----------------------------------------------------------------
soundwire fixes for v6.6

 - single fix for making sdw bus irq conditionally built

----------------------------------------------------------------
Charles Keepax (1):
      soundwire: bus: Make IRQ handling conditionally built

 drivers/soundwire/Makefile   |  4 +++
 drivers/soundwire/bus.c      | 31 ++++-------------------
 drivers/soundwire/bus_type.c | 11 +++------
 drivers/soundwire/irq.c      | 59 ++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/soundwire/irq.h      | 43 ++++++++++++++++++++++++++++++++
 5 files changed, 115 insertions(+), 33 deletions(-)
 create mode 100644 drivers/soundwire/irq.c
 create mode 100644 drivers/soundwire/irq.h

--=20
~Vinod

--7r3Mkf9Id9TZ9hMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmUpS6YACgkQfBQHDyUj
g0dyxBAAoWGMRPXkEzBWKxubdEFzxTOWSzeJREfDb2vKyaXLC6KHmdOdX3gal57K
etpEmVKY7xtALob1LwKVfCRWh2Bf8kodsExt34ifEz9B73CqYYLZDEOJZuQZ3W5W
9kUgBG2JJ1wuyCPupJ02xCGJ+Ts6fB7huieR+Cy2+e4aOytGTK5Xt3Zh1yNWH1Gx
qz4aAya5F/mOw7w9e7k/0X7xgfZYj7/F3WLeJjqgQUI4gVCqe277AIyLP7ap5Xfw
o+PxCWuYTwDxdSdQZmwQXSI7q3Jvhh1pXb1BL1YgDVOKtcixmc9XApHWHE7mvMXz
SWC+0zhb+5pgq+G6ETQ32rJrq46Z8/xz+Z8m5npO/VyT9pm6uIJrYngba6XYZpq0
3ky+47xcW05SyYTx/+OZP8+Efb1YBsql+ImcRHBFgT4Z31ade4G9xcHP39Hq8j0m
0nsUAYlld9tErW7meJfTDOf0ezZc+PbmjRlgi44tRVjQEnSx8KWj3tOQi/VM38Cw
K2g3csR/9OJKKohdoKaFHp+XRRP07yvYh44VMFcI0W5coeJTqJ+E+dKEPlsuRgtI
dhEFtgNZJYxstGgn3qsl5JpGOVYWbQtGHenR+MrChhVMYI9T3woM4ZdfAwO/bnaJ
5CG0DykBTZ7efKP9MWVFMyiHT1pC8EbRJN0F+EGIMjDcMkB5yOc=
=e888
-----END PGP SIGNATURE-----

--7r3Mkf9Id9TZ9hMU--
