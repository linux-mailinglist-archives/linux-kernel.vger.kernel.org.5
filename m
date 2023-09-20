Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1B17A8CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjITT2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjITT22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:28:28 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE381D9;
        Wed, 20 Sep 2023 12:28:19 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50308217223so364437e87.3;
        Wed, 20 Sep 2023 12:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695238098; x=1695842898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MLaSQY0QnZ/ukJSWJ+Kvy6hVpCuZzcRmlORhC3MCfR0=;
        b=aIKLohhzJLfoJLwYF6tCeMNDS/IXmxnaOBr5CNqMBhUi9wGVE5NvFEBfGGpd46IyTo
         DankXsGvVqabYFc4/YHy2utENzwSvdllYWQTf0QaFsdWnOkzU2L+kxXkznXHfe08wzbg
         iKSgMA1KdiLtv/OtW3DVTB9TbS+aGeu4GbgxrB9QCcE1ICoj2w08mu1l0t6BApeC2z5E
         Z7M7QgbDCE/ryrCnybMsJCEv9kzgofWdaOxc8Bz/rpwvJ7LS3MB8wcWguyEcwcpvViEK
         5P6jkjl+8qYzRvSOoyxtR+lzWF8AU0azSa7AgsB0UN7ajRZXDhixdzGEOseswL4/PmAG
         Er8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695238098; x=1695842898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLaSQY0QnZ/ukJSWJ+Kvy6hVpCuZzcRmlORhC3MCfR0=;
        b=UUbY1NBxRmD8J62rS/XFic15Q3s2DxSSNHExCIXzRGqs6bBspRsVbVIiNFI2sEUW1X
         cQTokiby1orEAEsI4zv20CMvdJZED2ktPsWi5RAlTBCYc9vnndaIgdqSn4y+OM7J4dNa
         w+g7DEqfW3rZWdIgZntg7sPOP9ZqOCa+zgv4IANQ8dRA+FOu2gvsmaCl+rzD31Ol9+FJ
         odDo/vOvSIBxZQIcoS3WWhOiNty5vNoOup/3KxvaVOvFx3xSKAlnIsst1/ZqK46moJ86
         4tr0ol4dKaGKKFMWhdY9Ep7s0Rdry1oAR162JIFAnz4iLK40+V71gdBknAbOR0sxk9gV
         8u1g==
X-Gm-Message-State: AOJu0YyskrqwWHLwKSVG1tMshu7q7dyer1wzb3vrplnb/P/aQ4afL3VE
        xdFwoM5NDgCAA0kXKZeDY1c=
X-Google-Smtp-Source: AGHT+IEaWIiVATO1+Zc4H+znUEy7d3TkUxnL+wJ1ZMk+wbjCbYWyfRUG8/94NoQ34PZcdKItisCiCg==
X-Received: by 2002:a05:6512:702:b0:4fb:7559:aea3 with SMTP id b2-20020a056512070200b004fb7559aea3mr2902394lfs.39.1695238097654;
        Wed, 20 Sep 2023 12:28:17 -0700 (PDT)
Received: from localhost ([85.140.6.205])
        by smtp.gmail.com with ESMTPSA id t26-20020ac2549a000000b004fe09e6d1e7sm2785403lfk.110.2023.09.20.12.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:28:16 -0700 (PDT)
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
Subject: [PATCH v4 00/18] EDAC/synopsys: Add generic DDRC info and address mapping
Date:   Wed, 20 Sep 2023 22:26:45 +0300
Message-ID: <20230920192806.29960-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is a second one in the series created in the framework of
my Synopsys DW uMCTL2 DDRC-related work:

[1: In-progress v4] EDAC/mc/synopsys: Various fixes and cleanups
Link: https://lore.kernel.org/linux-edac/20230920191059.28395-1-fancer.lancer@gmail.com
[2: In-progress v4] EDAC/synopsys: Add generic DDRC info and address mapping
Link: ---you are looking at it---
[3: In-progress v4] EDAC/synopsys: Add generic resources and Scrub support
Link: ---to be submitted---

Note the patchsets above must be merged in the same order as they are
placed in the list in order to prevent conflicts. Nothing prevents them
from being reviewed synchronously though. Any tests are very welcome.
Thanks in advance.

The second patchset mainly concerns converting the DW uMCTL2 DDRC driver
to being more generic, supporting wider range of the DW uMCTL2 DDRC IP-core
compilations and thus being utilized with more versions of the Synopsys
DDR controllers.

The series starts with the Error-injection functionality movement to
DebugFS. Indeed the Debug-parts should be in the dedicated DebugFS. SysFS
is not a place for it. Moreover a bit later here some more debug nodes
will be added.

Afterwards even though it isn't advertised but even at this stage the DW
uMCTL2 DDRC driver supports a bit more DDR protocols than it is actually
specified in the mem_ctrl_info.mtype_cap field. So first the EDAC MCI core
memory types enumeration is extended with LPDDR (mDDR) and LPDDR2, which
support can be enabled in the DW uMCTL2 DDR controller. Second the driver
is fixed to properly detected the new and older DDR protocol types during
the DW uMCTL DDRC probe procedure.

Then a bit painful patch goes. Alas we have to deviate the driver from the
EDAC standard private data allocation/initialization pattern. Since we are
going to add the DW uMCTL2 IP-core specific parameters detection procedure
and later on implement additional platform resources requests, there is no
other choice but to allocate the driver private data at the early stage of
the device probe procedure, even before it's possible to allocate the MCI
descriptor. The DW uMCTL2 DDRC platform resources and configuration info
will be then utilized to properly allocate and initialize the
mem_ctrl_info structure instance.

Fifth patch in the series is very important. It provides the DW uMCTL2
DDRC parameters detection procedure. The DDRC and ECC parameters detected
at this stage will be then utilized to make the driver working with much
wider set of the DW uMCTL2 revisions and configurations. In particular
from now the driver will retrieve the next DDRC info at the probe stage:
ECC type, SDRAM protocol (DDR type), Full and actual DQ-bus width, SDRAM
and HIF burst length, Core/SDRAM frequency ration, number of SDRAM ranks.
The DDRC parameters structure will be extended with some more fields later
in this and the next patchset. The provided private DDRC parameters
infrastructure can be utilized to implement the platform-specific
capabilities so the platform data and its quirks are replaced with it.

The detected at the probe stage DW uMCTL2 DDRC parameters can be now used
to implement the configuration specific functionality. In particular first
we introduce the conditional ADDRMAP* CSRs parsing since some of these
CSRs and their fields are left unused by the controller in some cases.
Secondly actual DIMM ECC errors grain, ECC corrected bit, syndrome and
full data+ecc pattern are determined based on the DDRC parameters.

Afterwards goes a series of the patches which introduce an interface to
generically determine the system address based on the SDRAM address and
vice-versa. Thus we'll be able to report actual PFN and offset in case of
the corrected and uncorrected errors. So first we get to convert the
currently available HIF/SDRAM mapping table utilized for the
errors-injection functionality into a more generic Sys<->SDRAM address
translation interface. Secondly we suggest to conform the SDRAM column
address mapping detection algorithm with what is defined in the DW uMCTL2
DDRC hw reference manual thus simplifying the ADDRMAP* CSRs parsing
procedure. After adding a handy DebugFS node to read the HIF/SDRAM mapping
and the system address regions support, we finally introduce the erroneous
page-frame/offset reporting to the MCI core. Since the full SDRAM address
mapping is now always available we suggest to use it for the attached
memory size calculation, which is a more correct approach rather than the
si_meminfo()-based one.

Changelog v2:
- Rebase onto the latest version of the patchset:
[PATCH v2 00/19] EDAC/mc/synopsys: Various fixes and cleanups
- Just resend.

Changelog v3:
- Just resend.

Changelog v4:
- Get syndrome from the ECCSTAT.ecc_corrected_bit_num field rather than
  from ECCCSYN2. The later CSR in fact contains ECC.
- On correctable and uncorrectable errors retrieve ECC aside with the
  erroneous data.
- Rebase onto the kernel v6.6-rcX.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Cc: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (18):
  EDAC/synopsys: Convert sysfs nodes to debugfs ones
  EDAC/mc: Extend memtypes with LPDDR(mDDR) and LPDDR2
  EDAC/synopsys: Extend memtypes supported by controller
  EDAC/synopsys: Detach private data from mci instance
  EDAC/synopsys: Add DDRC basic parameters infrastructure
  EDAC/synopsys: Convert plat-data to plat-init function
  EDAC/synopsys: Parse ADDRMAP[7-8] CSRs for (LP)DDR4 only
  EDAC/synopsys: Parse ADDRMAP[0] CSR for multi-ranks case only
  EDAC/synopsys: Set actual DIMM ECC errors grain
  EDAC/synopsys: Get corrected bit position
  EDAC/synopsys: Pass syndrome to EDAC error handler
  EDAC/synopsys: Read full data+ecc pattern on errors
  EDAC/synopsys: Introduce System/SDRAM address translation interface
  EDAC/synopsys: Simplify HIF/SDRAM column mapping get procedure
  EDAC/synopsys: Add HIF/SDRAM mapping debugfs node
  EDAC/synopsys: Add erroneous page-frame/offset reporting
  EDAC/synopsys: Add system address regions support
  EDAC/synopsys: Add mapping-based memory size calculation

 drivers/edac/edac_mc.c       |    2 +
 drivers/edac/synopsys_edac.c | 1828 ++++++++++++++++++++++++----------
 include/linux/edac.h         |    6 +
 3 files changed, 1321 insertions(+), 515 deletions(-)

-- 
2.41.0

