Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4127652D0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjG0Lqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjG0Lqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:46:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246E5F0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:46:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EE7761E2D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516AEC433C8;
        Thu, 27 Jul 2023 11:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690458410;
        bh=FUFnOQpMbfu+C4qaXXLH3B2Dt8n+w/SVWMITNRaxOeY=;
        h=Date:From:To:Cc:Subject:From;
        b=UENYVAdfP61wCMj+yQCgvdJr+j2eMYfOm/3zgtAem7iHHfp9Wqh6cgWBS96/GmNFS
         9gFsoxirbuF11ic6eUm0gTEgXoVL3+LU24wT4EKB/awnVL1wkKfcW+LEIntR1r8zm5
         8vYa+1C4JXbbamgNFhPPV7A/dJfqTSK1Adw3GnqlidKE34n2H7VjP9TtC2HFXdUJ2g
         ev/o/9MNQJ/dslZZ8+5Yy1HPtImKyPpyl7prDeHYEv0Kg+2CyP44zs9zclnYvwDvS2
         zZHgbPw/o3VoTZJ6h16jcOSzyTqaI7EuxbAor7jZQtm/hlhEnoBXPcZGVN0y2qhpPI
         TGcLK4n3iJuBg==
Date:   Thu, 27 Jul 2023 17:16:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire fixes for v6.5
Message-ID: <ZMJZJq02ERXGscVn@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1hWYeeDboAWQY3sg"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1hWYeeDboAWQY3sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive couple of fixes for soundwire subsystem. One core
fix and couple of driver (amd & qcom) fixes

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.5-fixes

for you to fetch changes up to 7891d0a5ce6f627132d3068ba925cf86f29008b1:

  soundwire: amd: Fix a check for errors in probe() (2023-07-13 11:09:07 +0=
530)

----------------------------------------------------------------
soundwire fixes for 6.4

 - Core fix for enumeration completion
 - Qualcomm driver fix to update status
 - AMD driver fix for probe error check

----------------------------------------------------------------
Dan Carpenter (1):
      soundwire: amd: Fix a check for errors in probe()

Johan Hovold (1):
      soundwire: fix enumeration completion

Srinivas Kandagatla (1):
      soundwire: qcom: update status correctly with mask

 drivers/soundwire/amd_manager.c | 4 ++--
 drivers/soundwire/bus.c         | 8 ++++----
 drivers/soundwire/qcom.c        | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

--=20
~Vinod

--1hWYeeDboAWQY3sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmTCWSYACgkQfBQHDyUj
g0eJyBAAq2HPbPsQRrs6D/mrnT+EXfHu77LsqJmIbBKQtEIh2xHpf8wB+igMnC+t
EDesNVmTX5bcc3psHAFvHvc0DFUaH0yRz0r8Vx8JIa6hxOB0cQrtAi3BpsyXJF36
bneb5rfZjIwIHbjwNvC3G1tY+ON8wn4XUQmfGbpZcFAoCsCVWk9GwJ2q/unQxoHb
xxRsVDxlhYoSw8HwBILzqARSlnTjI/yoohY244eNy01mHMXxiFp3FtkOQ2eIuIPP
JKZ40BARSkquBJ2DwNGnCMsvH31cwgByhqzEv6E8I9RQveqYV78bZ5sbFGGBkTRr
he7YSTdvX1HT7WNeOiLB6yRyfDP/ETb+rD1JsZbnWgjq7Zqjd3N/TECFBfvSP9Qt
/tqmTVycxu9Jj6eLwz3TOhnwa9wrZ5IgoWfaALRrpB6BSqDDmEhrC30+U871MCQP
ABO28zbFINKePitjhJHc9NFuyw5sl71g2SdVRVzYZYZyhNSrwk86d9zgQP54RCOu
FXB48HJDAapF5dkFwBmhxwNwlubsgm5MjP+G81KmITR8qXse2pkc/nwZivBtpKkL
i4/vE2R1ujEzUeaVNO5ZYlWlmyazvb7imckxysf0kxSwQmvoPyoSTyzzsx59GNfl
3ByPGDYZygUoMmL6Y81Ek9ja4gw8jMi9JpGIMSBKzboa0DpwerM=
=sYR+
-----END PGP SIGNATURE-----

--1hWYeeDboAWQY3sg--
