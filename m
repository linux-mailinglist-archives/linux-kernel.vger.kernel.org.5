Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4F478DB98
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbjH3SkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244623AbjH3NdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:33:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F13A1B0;
        Wed, 30 Aug 2023 06:32:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 184646239C;
        Wed, 30 Aug 2023 13:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D5CC433C8;
        Wed, 30 Aug 2023 13:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693402376;
        bh=bQhUUIZpx6QwTEhjZlfwsBCnaPFOUKTf69cRORtGYYk=;
        h=Date:From:To:Cc:Subject:From;
        b=oRF1w04uEtjeGHIeTQFcALFdnuYKRsY0cug/nrVM5Gtq7Iu+JvcqHwAH8jdExuLns
         NngfwIWm7cnLEBo1nucvpD3E2oNV+b5i/hC2jaavBjdHZ8Hx/OpRo+F/tN1H4RBROZ
         097DeXMBJZPxOYngC569L+5Mhx8ocqOR5WTgGGOXr1MrLX68mpdLuzPxRyaHLckK6o
         MjhxJjDfc58TVBgd2kGOw2JfL1+zhfWe0s9H72aPUWuRggYAln7N+lmFNtC46YtX40
         kpxOoVvYrtpMz5VWcwvO5NUnPLSiyuLNSv3txLduuUyTPmXHUA9Gu46UAtm4UPtHMt
         AB9eBCqOQzSSg==
Received: (nullmailer pid 117351 invoked by uid 1000);
        Wed, 30 Aug 2023 13:32:53 -0000
Date:   Wed, 30 Aug 2023 08:32:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Corey Minyard <minyard@acm.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Dipen Patel <dipenp@nvidia.com>, Peter Rosin <peda@axentia.se>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [GIT PULL] Devicetree include cleanups for v6.6
Message-ID: <20230830133253.GA112890-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull. Most of these changes are queued up in the subsystems. 
These are what's left which I didn't get a response on (well, hte was 
acked but not applied).

Rob

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-header-cleanups-for-6.6

for you to fetch changes up to 86cdae14a58a877ee1ec79d39b1331bc98dace58:

  ipmi: Explicitly include correct DT includes (2023-08-28 13:36:24 -0500)

----------------------------------------------------------------
Devicetree include cleanups for v6.6:

These are the remaining few clean-ups of DT related includes which
didn't get applied to subsystem trees.

----------------------------------------------------------------
Rob Herring (12):
      riscv: Explicitly include correct DT includes
      sparc: Explicitly include correct DT includes
      clocksource: Explicitly include correct DT includes
      EDAC: Explicitly include correct DT includes
      hte: Explicitly include correct DT includes
      macintosh: Explicitly include correct DT includes
      mux: Explicitly include correct DT includes
      sbus: Explicitly include correct DT includes
      parport: Explicitly include correct DT includes
      lib/genalloc: Explicitly include correct DT includes
      tpm: Explicitly include correct DT includes
      ipmi: Explicitly include correct DT includes

 arch/riscv/kernel/cpufeature.c            | 1 -
 arch/sparc/crypto/crop_devid.c            | 2 +-
 arch/sparc/include/asm/floppy_32.h        | 2 +-
 arch/sparc/include/asm/floppy_64.h        | 2 +-
 arch/sparc/include/asm/parport.h          | 3 ++-
 arch/sparc/kernel/apc.c                   | 2 +-
 arch/sparc/kernel/auxio_32.c              | 1 -
 arch/sparc/kernel/auxio_64.c              | 3 ++-
 arch/sparc/kernel/central.c               | 2 +-
 arch/sparc/kernel/chmc.c                  | 3 ++-
 arch/sparc/kernel/ioport.c                | 2 +-
 arch/sparc/kernel/leon_kernel.c           | 2 --
 arch/sparc/kernel/leon_pci.c              | 3 ++-
 arch/sparc/kernel/leon_pci_grpci1.c       | 3 ++-
 arch/sparc/kernel/leon_pci_grpci2.c       | 4 +++-
 arch/sparc/kernel/of_device_32.c          | 2 +-
 arch/sparc/kernel/of_device_64.c          | 4 ++--
 arch/sparc/kernel/of_device_common.c      | 4 ++--
 arch/sparc/kernel/pci.c                   | 3 ++-
 arch/sparc/kernel/pci_common.c            | 3 ++-
 arch/sparc/kernel/pci_fire.c              | 3 ++-
 arch/sparc/kernel/pci_impl.h              | 1 -
 arch/sparc/kernel/pci_msi.c               | 2 ++
 arch/sparc/kernel/pci_psycho.c            | 4 +++-
 arch/sparc/kernel/pci_sun4v.c             | 3 ++-
 arch/sparc/kernel/pmc.c                   | 2 +-
 arch/sparc/kernel/power.c                 | 3 ++-
 arch/sparc/kernel/prom_irqtrans.c         | 1 +
 arch/sparc/kernel/psycho_common.c         | 1 +
 arch/sparc/kernel/sbus.c                  | 3 ++-
 arch/sparc/kernel/time_32.c               | 1 -
 arch/sparc/mm/io-unit.c                   | 3 ++-
 arch/sparc/mm/iommu.c                     | 5 +++--
 drivers/char/ipmi/kcs_bmc_aspeed.c        | 1 -
 drivers/char/tpm/tpm_ftpm_tee.c           | 1 -
 drivers/char/tpm/tpm_tis.c                | 1 -
 drivers/char/tpm/tpm_tis_spi_main.c       | 2 +-
 drivers/char/tpm/tpm_tis_synquacer.c      | 1 -
 drivers/clocksource/bcm2835_timer.c       | 2 +-
 drivers/clocksource/nomadik-mtu.c         | 2 +-
 drivers/clocksource/sh_cmt.c              | 1 -
 drivers/clocksource/timer-cadence-ttc.c   | 1 +
 drivers/clocksource/timer-gxp.c           | 1 +
 drivers/clocksource/timer-integrator-ap.c | 2 +-
 drivers/clocksource/timer-tegra186.c      | 1 -
 drivers/clocksource/timer-ti-dm.c         | 1 -
 drivers/edac/fsl_ddr_edac.c               | 3 +--
 drivers/edac/highbank_l2_edac.c           | 3 ++-
 drivers/edac/highbank_mc_edac.c           | 3 ++-
 drivers/edac/mpc85xx_edac.c               | 3 +--
 drivers/edac/npcm_edac.c                  | 3 ++-
 drivers/edac/synopsys_edac.c              | 1 -
 drivers/hte/hte-tegra194.c                | 1 -
 drivers/hte/hte.c                         | 2 +-
 drivers/macintosh/ams/ams.h               | 1 -
 drivers/macintosh/macio_asic.c            | 1 +
 drivers/macintosh/smu.c                   | 1 +
 drivers/macintosh/therm_adt746x.c         | 2 ++
 drivers/macintosh/therm_windtunnel.c      | 2 ++
 drivers/macintosh/windfarm_lm75_sensor.c  | 2 +-
 drivers/mux/core.c                        | 1 -
 drivers/mux/mmio.c                        | 2 +-
 drivers/parport/parport_sunbpp.c          | 2 +-
 drivers/sbus/char/bbc_envctrl.c           | 2 +-
 drivers/sbus/char/bbc_i2c.c               | 3 ++-
 drivers/sbus/char/bbc_i2c.h               | 1 -
 drivers/sbus/char/display7seg.c           | 2 +-
 drivers/sbus/char/envctrl.c               | 2 +-
 drivers/sbus/char/flash.c                 | 2 +-
 drivers/sbus/char/uctrl.c                 | 2 +-
 lib/genalloc.c                            | 4 +++-
 71 files changed, 83 insertions(+), 68 deletions(-)
