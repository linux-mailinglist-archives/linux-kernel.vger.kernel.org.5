Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57515750EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjGLQun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbjGLQul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:50:41 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C0310CB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:50:38 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b890e2b9b7so37909955ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1689180638; x=1691772638;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CLMJN6SQopTIwnwmNS9impJEqYpU9dNFLx7FPHnABU=;
        b=bOcj+LHGhLyyUjEQGsegCMcc4y7a3vOuavoOpSsV1ipFW54sopcCNkNbeOqzsUqaCB
         NvStfWPha3Bk4NdmVpTk/uRYKDGndKWXIt5c/lsfM6B/CAn1s1W1r8kQRMV79pJtW5kt
         fosTbocS/O+ZNYBWfTo5QRU8dsbVTGRDC+ddu2jgSt82HPCHGv+8jJJY/mxjwlmhJDmb
         VBwq7QMAdGCnHYqm3JQP4xxez8vCGhcvD0TCWuHZEmsPqUU5+IBCA6mh09WoNrBPYpdF
         O16DF0Iceyj1U1LiwM8N2IO8dKGlk31MUJdvDkjvC8kq+hiiPaGcRIh3i/KJE2N5GoLq
         L49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689180638; x=1691772638;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CLMJN6SQopTIwnwmNS9impJEqYpU9dNFLx7FPHnABU=;
        b=WtwCixqfP21wtWyIDB67WTSCQo6TRPSeKoW4e64icYoZBumEAAO491VbwqXBj7q5uo
         /D5rLOXKsDYlJrXlQKDA1c6VSNa0c1lzRrx2cVAkyIKcGz6xA70swoI5zg0a60Rf4k6S
         iLAzGADebADAntcLlXPLJren6elqGWXLov7XxhdWdccKmAwyUzmro4IKM4oaE25aYkav
         Lr5L/M7Zqme8j9vAE1mtZiBSifq4zzAJOeP2K1sw7LxTsuIasJOi11ZxtGp6Z0cXPNZi
         22XgSF9M7mmODwmDEJ9UCS+VO1ya22TuC1zCnH+GZl+zJ5WeeO+x0AOoU1YHh/QIK8er
         Ghww==
X-Gm-Message-State: ABy/qLY9vm7DvxJpY85IA9iovHYNUPBB0P3s3LhZULqiG5c8vmkB4Yxg
        /fs1JDhadr15+vde0xsvYO+DBQ==
X-Google-Smtp-Source: APBJJlHzshkB9/uo3WnGkgqVS9hVIpmiLA+SHbio5fXcwwotBH3KMQX2SI5UvVzgmJo4v+1Mv7LVWQ==
X-Received: by 2002:a17:902:ce8b:b0:1b9:e591:db38 with SMTP id f11-20020a170902ce8b00b001b9e591db38mr7319689plg.8.1689180637681;
        Wed, 12 Jul 2023 09:50:37 -0700 (PDT)
Received: from localhost ([50.38.6.230])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902728200b001b7e63cfa19sm1795849pll.234.2023.07.12.09.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 09:50:37 -0700 (PDT)
Date:   Wed, 12 Jul 2023 09:50:37 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jul 2023 09:49:48 PDT (-0700)
Subject:     Re: [PATCH v7 0/9] Add STG/ISP/VOUT clock and reset drivers for StarFive JH7110
In-Reply-To: <20230712092007.31013-1-xingyu.wu@starfivetech.com>
CC:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        Conor Dooley <conor@kernel.org>, kernel@esmil.dk,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, hal.feng@starfivetech.com,
        xingyu.wu@starfivetech.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     xingyu.wu@starfivetech.com
Message-ID: <mhng-d3795910-5414-4555-bf3d-75ebe769ed2b@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 02:19:58 PDT (-0700), xingyu.wu@starfivetech.com wrote:
> This patch serises are base on the basic JH7110 SYSCRG/AONCRG
> drivers and add new partial clock drivers and reset supports
> about System-Top-Group(STG), Image-Signal-Process(ISP)
> and Video-Output(VOUT) for the StarFive JH7110 RISC-V SoC. These
> clocks and resets could be used by DMA, VIN and Display modules.
>
> Patches 1 and 2 are about the System-Top-Group clock and reset
> generator(STGCRG) part. The first patch adds docunmentation to
> describe STG bindings, and the second patch adds clock driver to
> support STG clocks and resets as auxiliary device for JH7110.
>
> Patches 3 and 4 are about the Image-Signal-Process clock and reset
> gennerator(ISPCRG) part. The first patch adds docunmentation to
> describe ISP bindings, and the second patch adds clock driver to
> support ISP clocks and resets as auxiliary device for JH7110.
> And ISP clocks should power on and enable the SYSCRG clocks first
> before registering.
>
> Patches 5 and 6 are about the Video-Output clock and reset
> generator(VOUTCRG) part. The first patch adds docunmentation to
> describe VOUT bindings, and the second patch adds clock driver to
> support VOUT clocks and resets as auxiliary device for JH7110.
> And VOUT clocks also should power on and enable the SYSCRG clocks
> first before registering.
>
> Patch 7 adds struct members to support STG/ISP/VOUT resets.
> Patch 8 adds external clocks which ISP and VOUT clock driver need.
> Patch 9 adds device node about STGCRG, ISPCRG and VOUTCRG to JH7110 dts.
>
> Changes since v6:
> - Rebased on the Linux 6.5-rc1.
> - Dropped the unnecessary selections in the Kconfig.
> - Dropped the patches about the PMU node and MAINTIANERS.
> - Add the reviews.
>
> v6: https://lore.kernel.org/all/20230518101234.143748-1-xingyu.wu@starfivetech.com/
>
> Changes since v5:
> - Rebased on the Linux 6.4-rc2.
> - Modified the reset name about VOUTCRG to fix the error with
>   CONFIG_FORTIFY_SOURCE=y
> - Added the patch about pmu node.
>
> v5: https://lore.kernel.org/all/20230424135409.6648-1-xingyu.wu@starfivetech.com/
>
> Changes since v4:
> - Rebased on the lastest patches about fixing the basic clock and reset drivers.
> - Dropped the 'dev_set_drvdata()' in STG clock driver.
> - Modified the data with 'dev_set_drvdata()' in ISP/VOUT clock driver
>   and move the struct about the data to JH7110 header file, which both
>   ISP and VOUT clock drivers will use.
>
> v4: https://lore.kernel.org/all/20230411135558.44282-1-xingyu.wu@starfivetech.com/
>
> Changes since v3:
> - Rebased on the lastest JH71X0 clock and reset driver of patchset[1]
>   and modified the parameters of the register reset functions.
> - The patch 1 combined three commits on STG/ISP/VOUT resets into one.
>   And Changed the auxiliary_device_id name from
>   "clk_starfive_jh71x0.reset-*" to "clk_starfive_jh7110_sys.rst-*".
> - Added a maintainer in STARFIVE JH71X0 CLOCK DRIVERS.
>
> v3: https://lore.kernel.org/all/20230314124404.117592-1-xingyu.wu@starfivetech.com/
>
> Changes since v2:
> Patch 1:
> - Dropped the modification of maintainers.
> - Modified clock and reset names in the dt-bindings header files.
> Patch 3:
> - Added 'Emil Renner Berthing' as the author.
> - Used 'default m' in Kconfig file.
> - Changed the flags of 'CLK_IGNORE_UNUSED' to 0 or 'CLK_IS_CRITICAL'.
> Patch 4:
> - Dropped the 'reset-names' property.
> - Shortened the clock and reset names in the dt-bindings header files.
> Pacth 6:
> - Used 'default m' in Kconfig file.
> - Changed the flags of 'CLK_IGNORE_UNUSED' to 0.
> - Set reset_control struct to a local variable because it just is used
>   one time in probe.
> Pacth 7:
> - Dropped the 'reset-names' property.
> Patch 9:
> - Used 'default m' in Kconfig file.
> - Set reset_control struct to a local variable because it just is used
>   one time in probe.
> Patch 10:
> - Changed the order of externel clock in alphanumerical order.
> Patch 11:
> - Dropped the 'reset-names' property in ispcrg and voutcrg node.
>
> v2: https://lore.kernel.org/all/20230221083323.302471-1-xingyu.wu@starfivetech.com/
>
> Changes since v1:
> - Modified the binding and dropped the indentation.
> - Removed the useless header files in the drivers.
> - Used an array lookup instead of a pile of conditions about parent
>   clocks' name.
> - Added clocks operation on driver remove.
>
> v1: https://lore.kernel.org/all/20230120024445.244345-1-xingyu.wu@starfivetech.com/
>
> Emil Renner Berthing (1):
>   clk: starfive: Add StarFive JH7110 System-Top-Group clock driver
>
> Xingyu Wu (8):
>   dt-bindings: clock: Add StarFive JH7110 System-Top-Group clock and
>     reset generator
>   dt-bindings: clock: Add StarFive JH7110 Image-Signal-Process clock and
>     reset generator
>   clk: starfive: Add StarFive JH7110 Image-Signal-Process clock driver
>   dt-bindings: clock: Add StarFive JH7110 Video-Output clock and reset
>     generator
>   clk: starfive: Add StarFive JH7110 Video-Output clock driver
>   reset: starfive: jh7110: Add StarFive STG/ISP/VOUT resets support
>   riscv: dts: starfive: jh7110: Add DVP and HDMI TX pixel external
>     clocks
>   riscv: dts: starfive: jh7110: Add STGCRG/ISPCRG/VOUTCRG nodes
>
>  .../clock/starfive,jh7110-ispcrg.yaml         |  87 +++++++
>  .../clock/starfive,jh7110-stgcrg.yaml         |  82 ++++++
>  .../clock/starfive,jh7110-voutcrg.yaml        |  90 +++++++
>  .../jh7110-starfive-visionfive-2.dtsi         |   8 +
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  67 +++++
>  drivers/clk/starfive/Kconfig                  |  24 ++
>  drivers/clk/starfive/Makefile                 |   3 +
>  .../clk/starfive/clk-starfive-jh7110-isp.c    | 232 +++++++++++++++++
>  .../clk/starfive/clk-starfive-jh7110-stg.c    | 173 +++++++++++++
>  .../clk/starfive/clk-starfive-jh7110-vout.c   | 239 ++++++++++++++++++
>  drivers/clk/starfive/clk-starfive-jh7110.h    |   6 +
>  .../reset/starfive/reset-starfive-jh7110.c    |  30 +++
>  .../dt-bindings/clock/starfive,jh7110-crg.h   |  74 ++++++
>  .../dt-bindings/reset/starfive,jh7110-crg.h   |  60 +++++
>  14 files changed, 1175 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-ispcrg.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml
>  create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-isp.c
>  create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-stg.c
>  create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-vout.c

Happy to take it through the RISC-V tree if folks want, but IMO it's 
probably better aimed at the clock/reset folks.  Either way I'd want to 
give them a chance to ack/review it, so I'm going to drop it from my 
list.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

in case anyone's looking for it, though.

Thanks!
