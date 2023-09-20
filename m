Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3899E7A8C4A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjITTLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjITTLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:11:24 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE668F;
        Wed, 20 Sep 2023 12:11:17 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c00b37ad84so2579871fa.0;
        Wed, 20 Sep 2023 12:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237076; x=1695841876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0XSP0EPbm9YvKR6mPo23h+dPn77vhjtSt75IDiGzGvk=;
        b=JWEfbkeNxxHXrxpkBOEFIT+U6OEGkLLSIM7wf+g5qYuP1nZ/iRMJmdIvtZ/bdEP4YC
         18ZYee+9tlhWp1tXBUzbadknMBeSe5/S8N01104d3v+NwomWDdWk3wHFd1PYl0fGf2iI
         4vPQ76LRORAinhzUjUZB4V7GMsSQacAih6YovFmQ0ct+HZBaw1bJEBrbCLFnjvR19+eq
         OJDrm7Atu2S9NgQLIUSonLipWETTO/3saNOxp/yoYJHrfuA55Yb9bLXViAnSgO/Cpxz+
         52Oxu1U6XwzXwao2Jt8gAWGSYes51VIeWh7fMCcx9ejBajUlhO/JU0nJ299TxBHp3HZr
         rWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237076; x=1695841876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XSP0EPbm9YvKR6mPo23h+dPn77vhjtSt75IDiGzGvk=;
        b=MFPI18jo2298j98DJTnw2HCrI+PPCj0DteB1j1ydBmMzLnYB5QxMTOFgzFVTrA2/Yj
         UkmBW5oHtxftHaXMIT5qzW+TXrDCAcyZCbiVMBiwy63CCzeIPZnAPIakFSeslCT2eZJL
         jb1vtOyRqvhD5EEF2gqZ18HiWw/nJcTukeimx2EoxiFh4pWkMR2+A6udH4UjYw5Fg4sH
         l3p3KYTLSLZ3g14XltNFOQUfyXpz7m5ZTsFF+XJvswyQSy7GA4pwMIIT0dD4+TYNva6O
         5N9+lh9l6y2QUpAMHoy9hC29CO4gX7HSJ5Rt0cRCTM8ZEeR8G8iSW1wwuylX42o1B/BJ
         JqyQ==
X-Gm-Message-State: AOJu0YwhdF0iZkmB8k52cMx2e7Ww0RIj7NY2eat+jg0dAyUrkfIf7jXS
        LDUY8pZo3jtiaq4xbZLkU0UJ/w63Hag=
X-Google-Smtp-Source: AGHT+IF/ZcMhoEpv4WOnm45w2MfZcJM/lpOWwlu3Qmbv76cWC/Oh09WqjdpyRUc6f4APUSu64lxJug==
X-Received: by 2002:a2e:9cd4:0:b0:2c0:32a1:71dd with SMTP id g20-20020a2e9cd4000000b002c032a171ddmr3055632ljj.28.1695237075493;
        Wed, 20 Sep 2023 12:11:15 -0700 (PDT)
Received: from localhost ([85.26.234.178])
        by smtp.gmail.com with ESMTPSA id by33-20020a05651c1a2100b002bfec05a693sm2376201ljb.22.2023.09.20.12.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:11:14 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/20] EDAC/mc/synopsys: Various fixes and cleanups
Date:   Wed, 20 Sep 2023 22:10:24 +0300
Message-ID: <20230920191059.28395-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is a first one in the series created in the framework of
my Synopsys DW uMCTL2 DDRC-related work:

[1: In-progress v4] EDAC/mc/synopsys: Various fixes and cleanups
Link: ---you are looking at it---
[2: In-progress v4] EDAC/synopsys: Add generic DDRC info and address mapping
Link: ---to be submitted---
[3: In-progress v4] EDAC/synopsys: Add generic resources and Scrub support
Link: ---to be submitted---

Note the patchsets above must be merged in the same order as they are
placed in the list in order to prevent conflicts. Nothing prevents them
from being reviewed synchronously though. Any tests are very welcome.
Thanks in advance.

The main goal of the entire set of the changes provided in the mentioned
patchsets is to as much as possible specialise the synopsys_edac.c driver
to be working with the Synopsys DW uMCTL2 DDR controllers of various
versions and synthesized parameters, and add useful error-detection
features.

Regarding this series content. It's an initial patchset which
traditionally provides various fixes, cleanups and modifications required
for the more comfortable further features development. The main goal of it
though is to detach the Xilinx Zynq A05 DDRC related code into the
dedicated driver since first it has nothing to do with the Synopsys DW
uMCTL2 DDR controller and second it will be a great deal obstacle on the
way of extending the Synopsys-part functionality.

The series starts with the fixes patches, which in short concern the next
aspects: touching the ZynqMP-specific CSRs on the Xilinx ZinqMP platform
only, serializing an access to the ECCCLR/ECCCTL register, adding correct memory
devices type detection, setting a correct value to the
mem_ctl_info.scrub_cap field, dropping an erroneous ADDRMAP[4] parsing and
getting back a correct order of the ECC errors info detection procedure.

Afterwards the patchset provides several cleanup patches required for the
more coherent code splitting up (Xilinx Zynq A05 and Synopsys DW uMCTL2
DDRCs) so the provided modifications would be useful in both drivers.
First the platform resource open-coded IO-space remapping is replaced with
the devm_platform_ioremap_resource() method call for the sake of the code
simplification. Secondly the next redundant entities are dropped: internal
CE/UE errors counters, local to_mci() macros definition, some redundant
ecc_error_info structure fields and redundant info from the error message,
duplicated dimm->nr_pages debug printout and spaces from the MEM_TYPE
flags declarations. (The later two updates concern the MCI core part.)
Thirdly before detaching the Zynq A05-related code an unique MC index
allocation infrastructure is added to the MCI core. It's required since
after splitting the driver up both supported types of memory devices could
be correctly probed on the same platform. Note even though it's currently
unsupported by the synsopsys_edac.c driver it's claimed to be possible by
the original driver author (it was a reason of having two unrelated
devices supported in a single driver). Finally the Xilinx Zynq A05 part of
the driver is moved out to a dedicated driver. After that the
platform-specific setups API is removed from the Synopsys DW uMCTL2 DDRC
driver since it's no longer required.

Finally as the cherry on the cake a set of the local coding style
cleanups are provided: unify the DW uMCTL2 DDRC driver entities naming and
replace the open-coded "shift/mask" pattern with the kernel helpers like
BIT/GENMASK/FIELD_x in there. It shall significantly improve the code
readability.

Changelog v2:
- Move Synopsys DW uMCTL2 DDRC bindings file renaming to a separate patch.
  (@Krzysztof)
- Introduce a new compatible string "snps,dw-umctl2-ddrc" matching the new
  DT-schema name.
- Forgot to fix some of the prefix of the SYNPS_ZYNQMP_IRQ_REGS macro
  in several places. (@tbot)
- Drop the no longer used "priv" pointer from the mc_init() function.
  (@tbot)
- Include "linux/bitfield.h" header file to get the FIELD_GET macro
  definition. (@tbot)
- Drop the already merged in patches:
[PATCH 12/20] EDAC/mc: Replace spaces with tabs in memtype flags definition
[PATCH 13/20] EDAC/mc: Drop duplicated dimm->nr_pages debug printout

Changelog v3:
- Drop the no longer used "priv" pointer from the mc_init() function.
  (@tbot)
- Drop the merged in patches:
[PATCH v2 14/19] dt-bindings: memory: snps: Detach Zynq DDRC controller support
[PATCH v2 15/19] dt-bindings: memory: snps: Use more descriptive device name
  (@Krzysztof)

Changelog v4:
- Remove Rob, Krzysztof and DT-mailing list from Cc since the respective
  patches have already been merged in.
- Add a new patch
  [PATCH v4 6/20] EDAC/synopsys: Fix misleading IRQ self-cleared quirk flag
  detached from the very first patch of the series.
- Add a new patch
  [PATCH v4 15/20] EDAC/mc: Re-use generic unique MC index allocation procedure
- Add a new patch
  [PATCH v4 18/20] EDAC/synopsys: Unify CSRs macro declarations
  collecting the changes from various patches of the series.
- Drop redundant empty lines left by mistake.
- Drop private counters access from the check_errors() method too.
- Rebase onto the kernel v6.6-rcX.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Cc: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (20):
  EDAC/synopsys: Fix ECC status data and IRQ disable race condition
  EDAC/synopsys: Fix generic device type detection procedure
  EDAC/synopsys: Fix mci->scrub_cap field setting
  EDAC/synopsys: Drop erroneous ADDRMAP4.addrmap_col_b10 parse
  EDAC/synopsys: Fix reading errors count before ECC status
  EDAC/synopsys: Fix misleading IRQ self-cleared quirk flag
  EDAC/synopsys: Use platform device devm ioremap method
  EDAC/synopsys: Drop internal CE and UE counters
  EDAC/synopsys: Drop local to_mci() macro definition
  EDAC/synopsys: Drop struct ecc_error_info.blknr field
  EDAC/synopsys: Shorten out struct ecc_error_info.bankgrpnr field name
  EDAC/synopsys: Drop redundant info from the error messages
  EDAC/mc: Init DIMM labels in MC registration method
  EDAC/mc: Add generic unique MC index allocation procedure
  EDAC/mc: Re-use generic unique MC index allocation procedure
  EDAC/synopsys: Detach Zynq A05 DDRC support to separate driver
  EDAC/synopsys: Drop unused platform-specific setup API
  EDAC/synopsys: Unify CSRs macro declarations
  EDAC/synopsys: Unify struct/macro/function prefixes
  EDAC/synopsys: Convert to using BIT/GENMASK/FIELD_x macros

 MAINTAINERS                  |   1 +
 drivers/edac/Kconfig         |   9 +-
 drivers/edac/Makefile        |   1 +
 drivers/edac/dmc520_edac.c   |   4 +-
 drivers/edac/edac_mc.c       | 135 ++++-
 drivers/edac/edac_mc.h       |   4 +
 drivers/edac/pasemi_edac.c   |   5 +-
 drivers/edac/ppc4xx_edac.c   |   5 +-
 drivers/edac/synopsys_edac.c | 966 ++++++++++++-----------------------
 drivers/edac/zynq_edac.c     | 501 ++++++++++++++++++
 10 files changed, 962 insertions(+), 669 deletions(-)
 create mode 100644 drivers/edac/zynq_edac.c

-- 
2.41.0

