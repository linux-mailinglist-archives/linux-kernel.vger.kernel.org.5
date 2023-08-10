Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACA97771D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjHJHqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjHJHq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:46:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044281BCF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:46:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F69F65170
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9780C433C8;
        Thu, 10 Aug 2023 07:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691653586;
        bh=u+ktUX6SCznDROdNjvf43D6PyXzTTlksjhFR08ZVIYE=;
        h=Date:From:To:Cc:Subject:From;
        b=WdTDP35xS1xxp5KjyVPkF0WaZdXD4bMRv4egu4P4Gv6Wg/XPhgKsm2rroJclsAz2G
         xFQa+w/jeoJKOKVeaHNjzxf71VjXg3h9CFnElxghU0oSAsAJda6HRn+KwlJ5x+iWR7
         S58DjTX5c8LPlU1axy5HM6hXX1lXOBF85CEVK3Q4nXlcfaCLYMwGc3v9HaSEbrHCf3
         AwCfAfTJ97PkRiMmn3wJUqd8R+tKFGZYRk/cjNDe9hI38I520Aw3XUkHSDDC/6WNVE
         0T4X2DKrp7JFtT/TI+lNv65odl6EYnHHpSlUlCUbR5iOFossXj5wGeHqZvdiQ+6BIw
         9R7F3exvqRrTg==
Date:   Thu, 10 Aug 2023 08:46:23 +0100
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v6.5
Message-ID: <ZNSVz2T48G7Xe1SJ@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0kWU9uEcCt4dEXZa"
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


--0kWU9uEcCt4dEXZa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive bunch of odd dmaengine fixes for the drivers.

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-6.5

for you to fetch changes up to 422dbc66b7702ae797326d5480c3c9b6467053da:

  dmaengine: xilinx: xdma: Fix typo (2023-08-07 00:01:41 +0530)

----------------------------------------------------------------
dmaengine fixes for v6.5

- HAS_IOMEM fixes for fsl edma and intel idma
- Return value fix, interrupt vector setting and typo fix for xilinx xdma
- Email updates for codeaurora email domain move
- correct pause status for pl330 driver
- idxd clear flag on disable fix
- function documentation fix for owl dma
- potential un-allocated memory fix for mcf driver

----------------------------------------------------------------
Baoquan He (1):
      idmaengine: make FSL_EDMA and INTEL_IDMA64 depends on HAS_IOMEM

Christophe JAILLET (1):
      dmaengine: mcf-edma: Fix a potential un-allocated memory access

Fenghua Yu (1):
      dmaengine: idxd: Clear PRS disable flag when disabling IDXD device

Ilpo J=E4rvinen (1):
      dmaengine: pl330: Return DMA_PAUSED when transaction is paused

Jeffrey Hugo (1):
      dmaengine: qcom_hidma: Update codeaurora email domain

Minjie Du (1):
      dmaengine: xilinx: xdma: Fix Judgment of the return value

Miquel Raynal (2):
      dmaengine: xilinx: xdma: Fix interrupt vector setting
      dmaengine: xilinx: xdma: Fix typo

Zhang Jianhua (1):
      dmaengine: owl-dma: Modify mismatched function name

 Documentation/ABI/testing/sysfs-platform-hidma      |  2 +-
 Documentation/ABI/testing/sysfs-platform-hidma-mgmt | 20 ++++++++++-------=
---
 drivers/dma/Kconfig                                 |  2 ++
 drivers/dma/idxd/device.c                           |  4 +---
 drivers/dma/mcf-edma.c                              | 13 +++++++------
 drivers/dma/owl-dma.c                               |  2 +-
 drivers/dma/pl330.c                                 | 18 ++++++++++++++++--
 drivers/dma/xilinx/xdma.c                           |  6 ++++--
 8 files changed, 42 insertions(+), 25 deletions(-)

--=20
~Vinod

--0kWU9uEcCt4dEXZa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmTUlc8ACgkQfBQHDyUj
g0ebRQ//XikEYaqwhcgfFwpXYLsM+lwY+8A3ykmBZA3GjAu1rEBtLsScYsB+URvT
kJajtLeciJjCMSIQwNnfW58YXiV8jYGBe31wBFhGALTMmdPF4V+QWbFlZcim+BPB
HJRBjUu0cQk7HNhZ76jSpoDRzanW8XSQfDHNkDz7Gp7NctpPAM69txTgHAOptJ6k
OSqEJYoX0k3wPn4lxM3hWwY2z9a+IemlWBFvLjBsYYmTa+kgFHgeyKh+KPYXrvLi
JHel2b/Tr6XHiKUDDJphCTYndt2EKJd8LZb1SA2oC5fHdh0885MqxqLS7kxqYhYj
dXDcNUBo+ULeBiyNDEFP/UGAUWdpdnFuON3Wl6MacGhLY5aC1KaTIDXVva9IO9ny
aCsNbo/WuK5X/pFUgdYqUVmjH40Deo8A2hjslpMw3rc4jJIBYkLBIMsRiu3y//k8
EcxzLMmUPf/0MD9GVEGvq+fvJgnpTyb577trrUXw8ldhxCpHwuYczpdCtINRDuDb
3e4w/A7+uGQEmRNsitCdeg8T4sTpqOlQYTjiW7EqvtM0itIo1Z8nnhgEfox04ful
ZgLGiciEjXMBBhdfex/v7sEe6nY+1yIQtkf7PFsQq1pIE9pSLL5hzTBQP63SymqA
PSlQHnJKboBhwUCfP9i1KiLbCHr6dB4j9lHYs47ngLPN9TjNZ10=
=5UN2
-----END PGP SIGNATURE-----

--0kWU9uEcCt4dEXZa--
