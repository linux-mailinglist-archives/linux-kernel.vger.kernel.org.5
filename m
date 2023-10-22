Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7517D24BA
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjJVRF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVRF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:05:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373BEEE
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 10:05:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485F2C433C8;
        Sun, 22 Oct 2023 17:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697994325;
        bh=n6+2qhKHkcF16jIIGulJ4qm/v1qhD92ap6nhGNR3DlM=;
        h=Date:From:To:Cc:Subject:From;
        b=IWhylvSUmR8e5r3tkYbKKxDrD3HMW6bqSSVhYLaISvcwKMMZ3/d07KjInvoPQuX1F
         ZsA7v36YsjhNIW7GwxUkAf3/ZfpAIVQ+yz5DQuF48v7vo0MsGIXPEAw18FeIFMGVNy
         YHm3Pa5IGoqZCLK+HEX0KremTKvTolbUPcQcjD79dMxWvWWVBP1AkHpkMKLBoAqH5R
         zRRa3Sc3Fx1aCFEUG99uBJtUip8kr1ED7qo3vEcF0j9y1trBei2qI1b6MSIrRhJ9LZ
         JWZv/o44Kb53ZE2UheNtsrFuCdVh3COvqQKzY/EvQx8a3iH3f47QD6uEkDw+lVZV+g
         DXtB8GYj4WSqw==
Date:   Sun, 22 Oct 2023 22:35:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy fixes for v6.6
Message-ID: <ZTVWUesRwVaLKW+O@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5dfVqJ3Kr/1jlWi7"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5dfVqJ3Kr/1jlWi7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Kindly pull to receive phy driver fixes for v6.6. This is spread over
couple of drivers like mapphone, qualcomm and realtek ones.

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes-6.6

for you to fetch changes up to 089667aaaa6aa33715d22b21a72216b43af3e896:

  phy: realtek: Realtek PHYs should depend on ARCH_REALTEK (2023-09-29 21:4=
7:37 +0530)

----------------------------------------------------------------
phy fixes for 6.6

 - Driver fixes for
   - mapphone-mdm6600 runtime pm & pinctrl handling fixes
   - Qualcomm qmp usb pcs register fixes, qmp pcie register size warning
     fix, m31 fixes for wrong pointer in PTR_ERR and dropping wrong vreg
     check, qmp combo fix for 8550 power config register
   - realtek usb fix for debugfs_create_dir() and kconfig dependency

----------------------------------------------------------------
Adrien Thierry (2):
      phy: qcom-qmp-usb: initialize PCS_USB registers
      phy: qcom-qmp-usb: split PCS_USB init table for sc8280xp and sa8775p

Bo Liu (1):
      phy: qualcomm: Fix typos in comments

Dmitry Baryshkov (1):
      dt-bindings: phy: qcom,ipq8074-qmp-pcie: fix warning regarding reg si=
ze

Geert Uytterhoeven (1):
      phy: realtek: Realtek PHYs should depend on ARCH_REALTEK

Jinjie Ruan (1):
      phy: realtek: usb: Drop unnecessary error check for debugfs_create_di=
r()

Konrad Dybcio (2):
      phy: qcom-qmp-combo: Square out 8550 POWER_STATE_CONFIG1
      phy: qcom-qmp-combo: initialize PCS_USB registers

Tony Lindgren (3):
      phy: mapphone-mdm6600: Fix runtime disable on probe
      phy: mapphone-mdm6600: Fix runtime PM for remove
      phy: mapphone-mdm6600: Fix pinctrl_pm handling for sleep pins

Varadarajan Narayanan (1):
      phy: qcom: m31: Remove unwanted qphy->vreg is NULL check

Yang Yingliang (2):
      phy: qcom: phy-qcom-m31: fix wrong pointer pass to PTR_ERR()
      phy: qcom: phy-qcom-m31: change m31_ipq5332_regs to static

 .../bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml    |  2 +-
 drivers/phy/motorola/phy-mapphone-mdm6600.c        | 38 ++++++++++--------=
----
 drivers/phy/qualcomm/phy-qcom-apq8064-sata.c       |  2 +-
 drivers/phy/qualcomm/phy-qcom-m31.c                |  7 ++--
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          |  6 +++-
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h     |  3 +-
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c            | 24 +++++++++++---
 drivers/phy/realtek/Kconfig                        |  5 +++
 drivers/phy/realtek/phy-rtk-usb2.c                 | 10 ++----
 drivers/phy/realtek/phy-rtk-usb3.c                 | 10 ++----
 10 files changed, 58 insertions(+), 49 deletions(-)
--=20
~Vinod

--5dfVqJ3Kr/1jlWi7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmU1VlEACgkQfBQHDyUj
g0f6hw/+Mwo0o/uY37fU6vQvNoqprUK8/FOOPAlg+zqd6+SgGcrodVhmMqk3eYAu
D/awdu2kHEIOjm5KiTDW2IDYjd13TH7ib6nXyaj0dSsi5eIh2BxgWUZ0qgBq9nnV
LuEZvxo4Cqf+9Mn2GAefx8w2+uxvwEXfwglbOsU10GVezh2NCNBsgWpaAuE/c/RV
GyrPFnOZX6bakIRxAfEyWjGPsvgZjZc5+iImoI3BsEllFeWRne2nmSzxxp7WwFcz
AMUYqoWAThTmTCVN0Pfc97yIGgcMC2wY/SM1puZUU+Mtjj6S8wFxRB+3yb+Zf08y
4ZcO6cvYq7LKn+STdfIoxPooBBlH9FiHVxBsHhHEEYRSRGsh6YEsUOOxcvas2tmg
vvjMvT6/RG1WCGeWsMFYjSy1w/3ajQ2t7V3vXGd01YDN3vxjZsD9TlFf2olYCQQ1
tqJJ8ooC+1iKewM1puVpi4g5FLBGnqD4r0CE2xglqcJDz8ghsdkNkC5l0i/piB1r
1pe6a1ok0qUMlNSfqvq4YHXVq7lEVWsqPG2qtZ3CruM1E/rb1HCZsT6Mmzy5IL/e
OoWMkgzA9QGFqLu1FKFFp3MBaXr5ov5vKZobn0rRGnf1mH1X78yf+O3oSTtUssTt
gO4cTpt+3cQVxFyNeaCe7aY35l0BApoY12ar8eqFJ/oTpogoB4U=
=dHum
-----END PGP SIGNATURE-----

--5dfVqJ3Kr/1jlWi7--
