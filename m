Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB597C8726
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjJMNrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjJMNrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:47:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D05ABE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:47:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191A9C433C7;
        Fri, 13 Oct 2023 13:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697204822;
        bh=0xsvLhSzmvkXcQf4Skvj20u3rh9QFtaOZ8Aum8HbA3c=;
        h=Date:From:To:Cc:Subject:From;
        b=hEuGVH8VRlWO7PVwk5rk1V8xYjzOIDArrOk6PIX6ld8Dv2TiZawPy5vq9H+B1MeeM
         hiYQjryk2azFn7Owj4sdoMn5a4COwNRsyJDvZBidlB5O6XjYmPzCEp+Kc+6YZQycbU
         UT7YO1YgiP4IOT9jyJKbZhbjr8lU9DOsOmlMAhWGGTPyAwuvIIAn068V97QrC2hWY8
         nC9PkJCHcOuLe5Ql7U/bBNXXbHP0v3Yc/A1OzBJJLyrtqXM/JeI7I0chuuG3t3zRjw
         wEzYxU14k6jvfWBCTgqBfCWYh2NvJrSo+bZ40jBKY7hWoTnD8ED9nWf9r5TEeDk6m2
         Xl3Sd/miZjVPQ==
Date:   Fri, 13 Oct 2023 19:16:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v6.6
Message-ID: <ZSlKUui11Cvq4Y/0@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rykacfSQVbcJ2+Up"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rykacfSQVbcJ2+Up
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive dmaengine subsystem fixes for v6.6. All of them
are driver odd fixes

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-6.6

for you to fetch changes up to 3fa53518ad419bfacceae046a9d8027e4c4c5290:

  dmaengine: fsl-edma: fix all channels requested when call fsl_edma3_xlate=
() (2023-10-09 11:12:19 +0530)

----------------------------------------------------------------
dmaengine fixes for v6.6

Driver fixes for:
 - stm32 dma residue calculation and chaining
 - stm32 mdma for setting inflight bytes, residue calculation
   and resume abort
 - channel request, channel enable and dma error in fsl_edma
 - runtime pm imbalance in ste_dma40 driver
 - deadlock fix in mediatek driver

----------------------------------------------------------------
Amelie Delaunay (5):
      dmaengine: stm32-mdma: abort resume if no ongoing transfer
      dmaengine: stm32-mdma: use Link Address Register to compute residue
      dmaengine: stm32-mdma: set in_flight_bytes in case CRQA flag is set
      dmaengine: stm32-dma: fix stm32_dma_prep_slave_sg in case of MDMA cha=
ining
      dmaengine: stm32-dma: fix residue in case of MDMA chaining

Duoming Zhou (1):
      dmaengine: mediatek: Fix deadlock caused by synchronize_irq()

Frank Li (3):
      dmaengine: fsl-dma: fix DMA error when enabling sg if 'DONE' bit is s=
et
      dmaengine: fsl-edma: fix edma4 channel enable failure on second attem=
pt
      dmaengine: fsl-edma: fix all channels requested when call fsl_edma3_x=
late()

Radhey Shyam Pandey (1):
      dt-bindings: dmaengine: zynqmp_dma: add xlnx,bus-width required prope=
rty

Rex Zhang (1):
      dmaengine: idxd: use spin_lock_irqsave before wait_event_lock_irq

Zhang Shurong (1):
      dmaengine: ste_dma40: Fix PM disable depth imbalance in d40_probe

 .../bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml   |  3 ++
 drivers/dma/fsl-edma-common.c                      | 25 ++++++++++++++--
 drivers/dma/fsl-edma-common.h                      | 14 ++++++++-
 drivers/dma/fsl-edma-main.c                        |  8 ++++--
 drivers/dma/idxd/device.c                          |  5 ++--
 drivers/dma/mediatek/mtk-uart-apdma.c              |  3 +-
 drivers/dma/ste_dma40.c                            |  1 +
 drivers/dma/stm32-dma.c                            | 11 +++++---
 drivers/dma/stm32-mdma.c                           | 33 ++++++++++++++++--=
----
 9 files changed, 79 insertions(+), 24 deletions(-)

--=20
~Vinod

--rykacfSQVbcJ2+Up
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmUpSlIACgkQfBQHDyUj
g0cEGxAAqyVtxm0B9ExGaaEbmmCrdn8YoAN38ynQL0rHMDaZ6fdb4yZmM4YnPohR
7/MsdNvoVxt3NQqG+a9TjL4nKs28yhb0OV0YUtkodNnl5GOJAO9rK1P9coRTs/nq
I/dakjdQNTZXHZx/hr2AWviY5ENPn79ytr8Rg3i1pihxF8a4W0agQlNvyS4Q3Ip8
Ba8bmXJ4zNVAuBmCUxGiQgPL57hhmBm3b0D0Q7pkN70duF0Gxg5++iImDU5aTJWR
6gOPVwR54Wr4MYGaLtugoXe5vTiriJR4yXfVoC7aZEuJLDimZV8Ns0lf+6A86+ac
UOEJTbfFJLwEBFSORf0aOcEicBDgVO5R9uuW4HP7QNcQ81HRP0m/Eo3V2wNNi/UH
GYHyNn4RwEg5a3EY63UOztk+eomMt1jitxRRYk1d9RD7iDxG9n2ew5yAQNXQBsah
jOMehZ+EQSqDbyR8N1+ohYqrf2/F1zAwgeIIA4Vt1GSbEzKvr9SjeOWacxqMttI5
hSqK6QBfR0cSG/hFfPJdSsmCoHDyz/CX7G4q+1SLEFEqMOMHH09HI+eNWcu8hps1
Dmt+T04zd6kgxhYMIU+k6ivpzzpc8/52lfpIRQJFPOVatI75KtzY5MtTIU+oHaRv
Tcsv2vLU8pegwYcRs1feDgJg2fPy3ZIJ8CRuF4q9XF4dzmeLnVk=
=VIiO
-----END PGP SIGNATURE-----

--rykacfSQVbcJ2+Up--
