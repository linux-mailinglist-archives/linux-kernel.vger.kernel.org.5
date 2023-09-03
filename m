Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0405F790D37
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345554AbjICRR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 13:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjICRR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 13:17:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F4CFB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 10:17:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAC4D60989
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 17:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF8BC433C7;
        Sun,  3 Sep 2023 17:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693761473;
        bh=VBSfdiRHoSO0F1VwB1O3vVYOED5PWjI4h+cp2wlC9BM=;
        h=Date:From:To:Cc:Subject:From;
        b=onvG+UcOIMc1QSyUa6Awtj+DJHTfJwABcaf5TF95fG1fLpdN8zzUs04mLZo0UF7e1
         vD7nWZlV6itYVixOz5syf4o5cE43ZrzD4d1RFy887Iq8ElKWcwCH8SvNxuqpb/BvsJ
         taQBfk4p9rvFs5AKDjH27Un1Xt4G9O7YzZeMxGPGscbMMnVQRk+SYbAQIgE+JMY6XE
         DrRg7Sx2Omck344lQQ474eNe75qiUK+rhbSU4tEcf34qDyVqFA3qbkFB5tJcOnPUif
         fkswLWPiTYVYW2XqIl2ccnzBnpmb8VyCbO31iJ2fcWS7wfpGsE82aWMmQbEYwHolu+
         8aBdCmReJySow==
Date:   Sun, 3 Sep 2023 22:47:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Soundwire subsystem updates
Message-ID: <ZPS/vF/gX+sohJis@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ybz3F5zAVwq2k5D1"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ybz3F5zAVwq2k5D1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive updates for soundwire subsystem. One core device
numbering and intel driver changes are main features of this request.

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.6-rc1

for you to fetch changes up to 8c4c9a9ae5aff2125ea44f0b26f9e3701d56d6db:

  soundwire: intel_ace2x: add DAI hw_params/prepare/hw_free callbacks (2023=
-08-22 20:08:30 +0530)

----------------------------------------------------------------
soundwire updates for 6.6

 - Core support for soundwire device number allocation
 - intel driver updates for adding hw_params for DAI ops, hybrid number
   allocation and power managemnt callback updates
 - DT header include changes for subsystem

----------------------------------------------------------------
Pierre-Louis Bossart (6):
      soundwire: intel_auxdevice: enable pm_runtime earlier on startup
      soundWire: intel_auxdevice: resume 'sdw-master' on startup and system=
 resume
      soundwire: extend parameters of new_peripheral_assigned() callback
      soundwire: bus: add callbacks for device_number allocation
      soundwire: intel_auxdevice: add hybrid IDA-based device_number alloca=
tion
      soundwire: intel_ace2x: add DAI hw_params/prepare/hw_free callbacks

Rob Herring (1):
      soundwire: Explicitly include correct DT includes

 drivers/soundwire/bus.c             |  18 +--
 drivers/soundwire/intel_ace2x.c     | 283 ++++++++++++++++++++++++++++++++=
++++
 drivers/soundwire/intel_auxdevice.c | 112 ++++++++++++--
 drivers/soundwire/qcom.c            |   1 -
 include/linux/soundwire/sdw.h       |  12 +-
 include/linux/soundwire/sdw_intel.h |   7 +
 6 files changed, 401 insertions(+), 32 deletions(-)

--=20
~Vinod

--Ybz3F5zAVwq2k5D1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmT0v7wACgkQfBQHDyUj
g0cm5RAArifC+kQl99yp/oBdxrChpmwtfDedBLuY3D/Hd2sgLoICRCzUhvp9zPlj
K+a2Kr31VTZTuOxa+/DITVOjLzfQAjOtBQ68H3uaUd/GDyaL/nmMK9Vz5jm9njRm
v5xwgVSiZSIDCKC/eZroT0AMJT1NX7iycqmaamTAdD0+vpcLorHIz3LEJsqrhwk+
6G7hb6OBdipY5LX+3pxrNg2z/GXiRR6qu98sLI04UGdFEC26rTpHj2S7W1O8ak8d
x++D5M9gEpDBqST/dx5JAjUlzTiRwudNHW/58nI7A+2BKjIlsWY4kQhXphk3gaD0
7/4ZOR61xequS2y4ieA4KXtjb8uhvn+n0AR4ahGWoWRP1cO5MVcoykW9flutmrWH
CyRCCG09lKO/iiPiaT1qfsXOdHtFTDfv595egw+dDuYl2A0CJzzJiQYAyWl1kKw0
RTDVdPSQ2+PJB5HkdaXl6ruuhEcG8CygSjv8wbdOLoimX7h64T86wsIMbEG5ieUi
DYrYBoHZhPWIzORwdWHMeGF4jteZR5gm73Z0e+fYQBbnEOsFBbsyBcN1AQen8sSd
U+EyR1FvITkG9Nn6U374slk4Du0Y/l1m4F6kbDswJfo4J0YBuMRwTyXVGhwwmtlF
eiq0KPmkcy/2OkZys8kSu+zvEsx+A4jkWH3egxzPizBSXeJnyjY=
=OQKY
-----END PGP SIGNATURE-----

--Ybz3F5zAVwq2k5D1--
