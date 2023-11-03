Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77797E0314
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjKCMnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCMnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:43:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1003E83
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 05:43:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2172BC433C8;
        Fri,  3 Nov 2023 12:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699015417;
        bh=xBf3Q68tw4Zm5EFApg5e4feV5MHAdsLcdioylj0RwgM=;
        h=Date:From:To:Cc:Subject:From;
        b=gyi63y3aKHzkozIn+lRXSfcW9JEjfPDBR+6Isfrl6dPmxTvoOgkyMIllsbrJz8hAg
         2F36LOvWAmmmFV0gPGo+1j9bjXHZ0xAEKEVOROhjEIhq+d0dxrMGcCeA7/Rusiam8p
         gdjlpfoIwWbQ6Rvn1X8yJkCXLA4vQhsoQ8VHP5N3vkP2FgBia3DQTcXjdrANTt5j+p
         jU5cZQuknR1n306tYICSivl8E2kXqTne3lAJxhHSViAHrzGkrIsdbBbbTBQ6Vzrzbl
         +1MYzEZKKNVrs43vdx1V8jnx3h+5ucCtnLEAIoGFwByxFTtaDyLIbkmDAVd4ivBrsv
         bznJ/enPTbPzg==
Date:   Fri, 3 Nov 2023 18:13:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: SoundWire subsystem updates for v6.7
Message-ID: <ZUTq9b8Ik/KpD9F4@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MFZG4ZA1Eh4Zc3dM"
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MFZG4ZA1Eh4Zc3dM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive soundwire subsystem updates for this cycle
consisting of small five patches.

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.7-rc1

for you to fetch changes up to 4ea2b6d3128ea4d502c4015df0dc16b7d1070954:

  soundwire: dmi-quirks: update HP Omen match (2023-10-16 16:48:05 +0530)

----------------------------------------------------------------
soundwire updates for 6.7

 - Core has now improved handling of errors for clock stop
 - Support for qcom v2.0.0 status registers and command ignored interrupt
   and more logging for failures
 - DMI quirk for HP Omen machine

----------------------------------------------------------------
Bjorn Andersson (1):
      soundwire: qcom: Log clk_get("iface") failures

Krzysztof Kozlowski (2):
      soundwire: qcom: use newer link status tregister on v2.0.0
      soundwire: qcom: handle command ignored interrupt

Pierre-Louis Bossart (2):
      soundwire: bus: improve error handling for clock stop prepare/deprepa=
re
      soundwire: dmi-quirks: update HP Omen match

 drivers/soundwire/bus.c        | 12 +++++++-----
 drivers/soundwire/dmi-quirks.c |  2 +-
 drivers/soundwire/qcom.c       | 18 +++++++++++++++---
 3 files changed, 23 insertions(+), 9 deletions(-)



--=20
~Vinod

--MFZG4ZA1Eh4Zc3dM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmVE6vUACgkQfBQHDyUj
g0fIkA/9EFjGjhK4VCA5jQwKuyJO11rin9figFbKzaY/gixCPL4iUsP7pliseu1U
RA+WkY1sR+5czkXKB0EqnDHKqDzuxnnwcrUGdzyJsrke+axTcfYGa0ybXMwPRfIK
60nCZcEBYTJn/yLxF5igh4ND7Ua/w/5OCadfM9DeM7ihywCRmnWVBd5Wvc+9Y23k
GRwqT8HuoBnzVJTrZGU73txOIH0vS9y/ew5QsGCmGHnLDRFFpYy5V+2ZxM3xjy/n
9ED8CluAM3FnDLpPX+a+6BOilWKJw38wdlQRUZppk/ZSoyxpotK2UUMembomWc6S
E5/sZslGfF+b+FiZ0+gdq1BuN5pqvvoGnR/DAgzuFP+qBmQuEsZJYNjpvsh1daDC
ldAGmqA5TSQwMcHFUd1Y7TuFC649RO+3FpDgkri639wVA5hRJpJMXZqm+KwTwLCw
E+8TPtdhB2OY0wgq6EuB/pxwIUbZvKsH6dha9I2+eZfVksd5IU14zE/nQlx0/R1O
A4aeZEEkEr0WAXLjy2aOwLi3Ap6RttsXNHOkgB+tCi/nHvUFhRltbU8k1/+Wwx6J
qydIfcvt60Y4L8690XmvpfAPo0ThCz5m/nSw+cwkXsMzTU5Ht79FRH/XlchZZITn
LOHAt/YRT95zCSg3YXAKFCf7nKxni+K93AWpvLVz7+MJqHoJ4bQ=
=nwz1
-----END PGP SIGNATURE-----

--MFZG4ZA1Eh4Zc3dM--
