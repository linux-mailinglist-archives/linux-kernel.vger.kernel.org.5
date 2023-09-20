Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A6D7A8D40
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjITT5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjITT5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:57:35 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F843D6;
        Wed, 20 Sep 2023 12:57:29 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-502a4f33440so464244e87.1;
        Wed, 20 Sep 2023 12:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695239847; x=1695844647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bKDIR6G5AYRbAL3MwUKTNni8G8jkvUYyxekLscAaADg=;
        b=PFRKCMag+c6+mQBOmiBwWFWXBTX5Yy2aNnqGVNddTybqD8NEXBkQVigSgSeLGWY4LQ
         oGJ7ueC5dT8SkbrGI85bMFp9EyFOFpRdlLGm44IM5nI2FjOpyOdpdS3w9OFrCr91oZjl
         u8aZwReeWA5phG8+7qB1F81LCCpzmXF76GT0j3uwNY2sK/y3u1HteicXooMh2naw2696
         JjbioCdMHxGgrebd0KvXYbtV7fhaJG8bd5pZ2Tl1ajFM7DcwvveVX3YH3s14Zk1lpc/P
         9Iv03GisqjJQgzvtHi0KKpAwDMGYgsNXExRllL40iSmJl5TeSmew8FsR6iCO297ZmD8T
         hnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239847; x=1695844647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKDIR6G5AYRbAL3MwUKTNni8G8jkvUYyxekLscAaADg=;
        b=JK1uCpGwYZKZFwg07/5nP1OfDn2ZYcuG1lClkLjjK/v3uyx3fNcR00qhZZQVnX4Ym7
         IY6EC+bOP71rs+M/HlQwm3rmkB9cgXhlajgxH2ptdm1Pk/WhdnBA8mCI8689AX4i2eRh
         Y+ZDOphyOIdjv+c2MDFxWYI7WxOu9ZzLx3Ao2P0FQMyAd9LqNtbeZqCPOGvWPnh7R03N
         sD/zqVgNF+WlP6Yme7jzqvGzoaF0hb6iIvClagrXUYjkmaBomkxz6EAhq4RmM2EPLaE7
         rteb3uD0ATgMEz/M3U6U/hTonOBlt5QFlgKlh85w49XJzkrfLIr84f/T4T4eTayS7xYJ
         TiEQ==
X-Gm-Message-State: AOJu0Yz4M8pAcj5vaL6+s9LZA66TcTvxXtJEBGckAh3WjKC9f+4GGMAl
        9hjtTb3/OVgialZ2+f5MHRM=
X-Google-Smtp-Source: AGHT+IGhI+lDUY/uLLOp6V/114v+B9NN5IhbHDxcNJIb0D1yso3plt/Tt5Lcg0nfkuulD9FWd9fk6w==
X-Received: by 2002:a05:6512:104f:b0:503:2924:f8dd with SMTP id c15-20020a056512104f00b005032924f8ddmr4186642lfb.47.1695239847098;
        Wed, 20 Sep 2023 12:57:27 -0700 (PDT)
Received: from localhost ([85.26.234.143])
        by smtp.gmail.com with ESMTPSA id l18-20020ac24312000000b004fa52552c7csm2788079lfh.151.2023.09.20.12.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:57:26 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/13] EDAC/synopsys: Add generic resources and Scrub support
Date:   Wed, 20 Sep 2023 22:56:31 +0300
Message-ID: <20230920195720.32047-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is a third one in the series created in the framework of
my Synopsys DW uMCTL2 DDRC-related work:

[1: In-progress v4] EDAC/mc/synopsys: Various fixes and cleanups
Link: https://lore.kernel.org/linux-edac/20230920191059.28395-1-fancer.lancer@gmail.com
[2: In-progress v4] EDAC/synopsys: Add generic DDRC info and address mapping
Link: https://lore.kernel.org/linux-edac/20230920192806.29960-1-fancer.lancer@gmail.com
[3: In-progress v4] EDAC/synopsys: Add generic resources and Scrub support
Link: ---you are looking at it---

Note the patchsets above must be merged in the same order as they are
placed in the list in order to prevent conflicts. Nothing prevents them
from being reviewed synchronously though. Any tests are very welcome.
Thanks in advance.

This is a final patchset in the framework of my Synopsys DW uMCTL2 DDRC
work, which completes the driver updates with the new functionality.

The series starts from extending the Synopsys DW uMCTL2 DDRC DT-schema
with the controller specific IRQs, clocks and resets properties. In
addition the Baikal-T1 DDRC is added to the DT-bindings since it's
based on the DW uMCTL2 DDRC v2.61a.

After that the driver is finally altered to informing the MCI core with
the detected SDRAM ranks and making sure the detected errors are reported
to the corresponding rank. Then the DDRC capabilities are extended with
optional Scrub functionality. It's indeed possible to have the DW uMCTL2
controller with no HW-accelerated Scrub support (no RMW engine). In that
case the MCI core is supposed to perform the erroneous location ECC update
by means of the platform-specific scrub method.

Then the error-injection functionality is fixed a bit. First since the
driver now has the Sys<->SDRAM address translation infrastructure it can
be utilized to convert the supplied poisonous system address to the SDRAM
one. Thus there is no longer need in preserving the address in the device
private data. Second a DebuFS node-based command to disable the
error-injection feature is added (no idea why it hasn't been done in the
first place).

Afterwards a series of the IRQ-related patches goes. First introduce the
individual DDRC event IRQs support in accordance with what has been added
to the DT-bindings and what the native DW uMCTL2 DDR controller actually
provides. Then aside to the ECC CE/UE errors detection, the DFI/SDRAM
CRC/Parity errors report is added. It specifically useful for the DDR4
memory which has dedicated ALARM_n signal, but can be still utilized in
the framework of the older protocols if the device DFI-PHY calculates the
HIF-interface signals parity. Third after adding the platform clock/resets
request procedure introduce the HW-accelerated Scrubber support. Its
performance can be tuned by means of the sdram_scrub_rate SysFS node and
the Core clock rate. Note it is possible to one-time-run the Scrubber in
the back-to-back mode so to perform a burst-like scan of the entire SDRAM
memory.

At the patchset closure he DW uMCTL2 DDRC kernel config is finally fixed
to be available not only on the Xilinx, Intel and MXC platforms, but on
anyone including the Baikal-T1 SoC which has the DW uMCTL2 DDRC v2.61a on
board.

Changelog v2:
- Replace "snps,ddrc-3.80a" compatible string with "snps,dw-umctl2-ddrc"
  in the example.
- Move unrelated changes in to the dedicated patches. (@Krzysztof)
- Use the IRQ macros in the example. (@Krzysztof)
- Add a new patch:
[PATCH v2 01/15] dt-bindings: memory: snps: Replace opencoded numbers with macros
  (@Krzysztof)
- Add a new patch:
[PATCH v2 03/15] dt-bindings: memory: snps: Convert the schema to being generic
  (@Krzysztof)
- Drop the PHY CSR region. (@Rob)
- Move the Baikal-T1 DDRC bindings to the separate DT-schema.

Changelog v3:
- Create common DT-schema instead of using the generic device DT-bindings.
  (@Rob)
- Drop the merged in patches:
[PATCH v2 01/15] dt-bindings: memory: snps: Replace opencoded numbers with macros
[PATCH v2 02/15] dt-bindings: memory: snps: Extend schema with IRQs/resets/clocks props
  (@Krzysztof)

Changelog v4:
- Explicitly set snps_ddrc_info.dq_width for Baikal-T1 DDRC for better
  maintainability.
- Explicitly set sys_app_map.minsize to SZ_256M instead of using a helper
  macro DDR_MIN_SARSIZE for Baikal-T1 DDRC.
- Use div_u64() instead of do_div().
- Use FIELD_MAX() instead of open-coding the bitwise shift to find
  the max field value.
- Fix inject_data_error string printing "Rank" word where "Col" is
  supposed to be.
- Rebase onto the kernel v6.6-rcX.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Cc: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (13):
  dt-bindings: memory: snps: Convert the schema to being generic
  dt-bindings: memory: Add BT1 DDRC DT-schema
  EDAC/synopsys: Add multi-ranked memory support
  EDAC/synopsys: Add optional ECC Scrub support
  EDAC/synopsys: Drop ECC poison address from private data
  EDAC/synopsys: Add data poisoning disable support
  EDAC/synopsys: Split up ECC UE/CE IRQs handler
  EDAC/synopsys: Add individual named ECC IRQs support
  EDAC/synopsys: Add DFI alert_n IRQ support
  EDAC/synopsys: Add reference clocks support
  EDAC/synopsys: Add ECC Scrubber support
  EDAC/synopsys: Drop vendor-specific arch dependency
  EDAC/synopsys: Add BT1 DDRC support

 .../memory-controllers/baikal,bt1-ddrc.yaml   |  91 ++
 .../snps,dw-umctl2-common.yaml                |  75 ++
 .../snps,dw-umctl2-ddrc.yaml                  |  57 +-
 drivers/edac/Kconfig                          |   1 -
 drivers/edac/synopsys_edac.c                  | 950 ++++++++++++++----
 5 files changed, 933 insertions(+), 241 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-common.yaml

-- 
2.41.0

