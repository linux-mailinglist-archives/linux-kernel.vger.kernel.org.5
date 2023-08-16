Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD97D77E905
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345630AbjHPSsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345581AbjHPSsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:48:21 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAAA211E;
        Wed, 16 Aug 2023 11:48:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe0eb0ca75so10420226e87.2;
        Wed, 16 Aug 2023 11:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692211697; x=1692816497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6DeFu7jxdrJBpCfs3D07Jh6wVVxwmWCVDhwH/4yTBfE=;
        b=GaDY1/UZMzJNikQoE2VypkIEaHALRv1j12J77CmBCEJ4inVcsXm0gmGOfnLmXVio0N
         lTp6+IbtMou+iwVtwzciljCqtYI/goO064kfswhJhEkNOT+5j91UkEa9DjU0ljPupVSp
         NuxtkpFEs+eTf8+0xIgP1REzDlhfQ5k+OnxyzcPTC7IpOEFHrParZXbA/bWJ64jZzira
         LxIFf+OQRHhKQZn1e3sG2xukhA04xpVla0MgVYsMKtCtj/P5+CffUTDvtnllxmyFV/J/
         x3P6/eZj6RDirzDEYSRXHkyFQlLCcBQTnxIjT3OZtSCEwdrDaKR7Fp7tOlV1XBQ4ahV1
         TZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692211697; x=1692816497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DeFu7jxdrJBpCfs3D07Jh6wVVxwmWCVDhwH/4yTBfE=;
        b=NqC3dgihYfpTjo9NXJHCLVTrSxubetRv8pkKcQELbRWhxy9ki6U6rs9UgrGHAZo6XV
         iUCouNimGkRaFRVccJ5fipTcmBlclUqzEmSQ5vGw1bs557Zyi2DLXZIL85QI5KuMIG4a
         EKspzcb2v2fA9uDRwif0MZF/h1hEdtzIOWpmrgiZtKGznRrVRuRNbaItD2BV21e1Z/Et
         8MCU8w+x48Zml+ZHAT94wrKtGqzkDPrn1MOeJx081lnfWMtBphLUkmAyP4TxYAT5q858
         hKoRTI3czMtZKsaw0qussmDKZeMU/oxiwpY0oxJYFQig+cLGkEV5zQrT4Pe+kqm3LYlL
         zAXw==
X-Gm-Message-State: AOJu0Yyr7BRJD2L05bxt7Kjtc3aPjjcVda0Jj3zftlj+nc+Mnys4R0rK
        6haXwKfLsGqIiTGb9zjykDI=
X-Google-Smtp-Source: AGHT+IFCTmp6wOnPZ7b1Uo7+8NYxdZXi6HJVL0HP8jvZ1TE+OuMhsPEPwnsKQ+vovaoVuocDWqwVFw==
X-Received: by 2002:ac2:4c94:0:b0:4fd:d0bd:2401 with SMTP id d20-20020ac24c94000000b004fdd0bd2401mr1918778lfl.66.1692211696497;
        Wed, 16 Aug 2023 11:48:16 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id x19-20020ac25dd3000000b004f864690901sm3045885lfq.244.2023.08.16.11.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 11:48:15 -0700 (PDT)
Date:   Wed, 16 Aug 2023 21:48:13 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/19] EDAC/mc/synopsys: Various fixes and cleanups
Message-ID: <sk23kwxijfzmelcdn6vjcd6qibmjuwdry46ad26vtl77je7axn@5cf6nmlhyii6>
References: <20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru>
 <4488875.LvFx2qVVIh@steina-w>
 <20230525102434.lqhwtgxqfd2d3356@mobilestation>
 <y6j735uysubwyyzfs7vabz46ewhe7hfmp5aauk3cktduh2r6zt@lxesd43mzfyl>
 <4thyfyadmlmbj4taelvxswxrmqen6vlbmab65hl7lepvec3ava@suy7s5i3n7dl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4thyfyadmlmbj4taelvxswxrmqen6vlbmab65hl7lepvec3ava@suy7s5i3n7dl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander

On Mon, Jul 24, 2023 at 06:24:20PM +0300, Serge Semin wrote:
> Hello Alexander
> 
> On Mon, Jul 03, 2023 at 02:58:06PM +0300, Serge Semin wrote:
> > Hi Alexander
> > 
> > On Thu, May 25, 2023 at 01:24:37PM +0300, Serge Semin wrote:
> > > Hi Alexander,
> > > 
> > > On Thu, May 25, 2023 at 08:35:59AM +0200, Alexander Stein wrote:
> > > > Hi,
> > > > 
> > > > Am Samstag, 10. September 2022, 21:42:18 CEST schrieb Serge Semin:
> > > > > This patchset is a first one in the series created in the framework of
> > > > > my Baikal-T1 DDRC-related work:
> > > > > 
> > > > > [1: In-progress] EDAC/mc/synopsys: Various fixes and cleanups
> > > > > Link: ---you are looking at it---
> > > > > [2: In-progress] EDAC/synopsys: Add generic DDRC info and address mapping
> > > > > Link:
> > > > > https://lore.kernel.org/linux-edac/20220822191427.27969-1-Sergey.Semin@baik
> > > > > alelectronics.ru [3: In-progress] EDAC/synopsys: Add generic resources and
> > > > > Baikal-T1 support Link:
> > > > > https://lore.kernel.org/linux-edac/20220822191957.28546-1-Sergey.Semin@baik
> > > > > alelectronics.ru
> > > > > 
> > > > > Note the patchsets above must be merged in the same order as they are
> > > > > placed in the list in order to prevent conflicts. Nothing prevents them
> > > > > from being reviewed synchronously though. Any tests are very welcome.
> > > > > Thanks in advance.
> > > > 
> > > > What is the state of this/these series? AFAICS only the DT patches got 
> > > > applied.
> > > > The synopsys driver got refactored quite a lot, so adding proper support for 
> > > > imx8mp from current state will conflict quite a lot.
> > > > It's a Synopsys V3.70a (without HW poisoning support!), refer to commit 
> > > > 68b7cf5d91d4c ("arm64: dts: imx8mp: add ddr controller node to support EDAC on 
> > > > imx8mp").
> > > 
> > > I has been quite busy lately in DW PCIe RP/EP/eDMA driver and my own
> > > deeds. But I am going to get back to this series within a month.
> > > Could you meanwhile have a look at it (review and tests are very
> > > welcome) and if possible start adding the imx8mp support based on the
> > > suggested patchsets (see the lore links above)?
> > > 
> > > The main goal of my changes is to generalize the driver code and make
> > > it working for the original Synopsys DW uMCTL2 device only with as much
> > > compatibility as possible with the various IP-core configs. Most
> > > likely adding your imx8mp DW uMCTL2 V3.70a on top of my changes will
> > > be much easier than writing your own changes.
> > > 
> > > Note recently I've rebased my patches on top of the latest kernel
> > > (6.4-rc1). Can't remember any major conflict so most likely it won't
> > > cause much difficulties for you too. The resultant driver works well
> > > for my system: DDR-phys memory space back-and-forth mapping, errors
> > > poisoning scrubbing, etc.
> > > 
> > > -Serge(y)
> > 
> > Just to let you know. I need two more weeks to settle down my current
> > work and then I am getting back to this series. Once again sorry for
> > the delay.
> 
> Terribly sorry for the delay again. But I need two more weeks to
> finish my work. Then I'll finally get back to this patchset.

I am finally partly done with my current tasks and able to get back to
this patchset. I'll add you to the Cc-list of the series so you would
be aware of the progress. This and another my Synopsys EDAC-related
patchsets have been successfully rebased onto the latest kernel source
tree (it's 6.5-rc6). All my smoke tests didn't reveal any problem.

What is next. I'll answer to the latest Borislav comments, then fix the
issues he raised there and resend my patchsets. Hopefully I'll manage to
do that on this week. Then the standard kernel patches review cycle shall
proceed.

Sorry once again for the huge delay and thanks for your patience.

-Serge(y)

> 
> -Serge(y)
> 
> > 
> > -Serge(y)
> > 
> > > 
> > > > 
> > > > Best regards,
> > > > Alexander
> > > > 
> > > > > Regarding this series content. It's an initial patchset which
> > > > > traditionally provides various fixes, cleanups and modifications required
> > > > > for the more comfortable further features development. The main goal of it
> > > > > though is to detach the Xilinx Zynq A05 DDRC related code into the
> > > > > dedicated driver since first it has nothing to do with the Synopsys DW
> > > > > uMCTL2 DDR controller and second it will be a great deal obstacle on the
> > > > > way of extending the Synopsys-part functionality.
> > > > > 
> > > > > The series starts with fixes patches, which in short concern the next
> > > > > aspects: touching the ZynqMP-specific CSRs on the Xilinx ZinqMP platform
> > > > > only, serializing an access to the ECCCLR register, adding correct memory
> > > > > devices type detection, setting a correct value to the
> > > > > mem_ctl_info.scrub_cap field, dropping an erroneous ADDRMAP[4] parsing and
> > > > > getting back a correct order of the ECC errors info detection procedure.
> > > > > 
> > > > > Afterwards the patchset provides several cleanup patches required for the
> > > > > more coherent code splitting up (Xilinx Zynq A05 and Synopsys DW uMCTL2)
> > > > > so the provided modifications would be useful in both drivers. First we
> > > > > get to replace the platform resource manual IO-remapping with the
> > > > > devm_platform_ioremap_resource() method call. Secondly we suggest to drop:
> > > > > internal CE/UE errors counters, local to_mci() macros definition, some
> > > > > redundant ecc_error_info structure fields and redundant info from the
> > > > > error message, duplicated dimm->nr_pages debug printout and spaces from
> > > > > the MEM_TYPE flags declarations. (The later two updates concern the MCI
> > > > > core part.) Thirdly before splitting up the driver we need to add an
> > > > > unique MC index allocation infrastructure to the MCI core.  It's required
> > > > > since after splitting the driver up we'll need to make sure both device
> > > > > types could be correctly probed on the same platform. Finally the Xilinx
> > > > > Zynq A05 part of the driver is moved out to a dedicated driver where it
> > > > > should been originally placed. After that the platform-specific setups API
> > > > > is removed from the Synopsys DW uMCTL2 DDRC driver since it's no longer
> > > > > required.
> > > > > 
> > > > > Finally as the cherry on the cake we suggest to unify the DW uMCTL2 DDRC
> > > > > driver entities naming and replace the open-coded "shift/mask" patter with
> > > > > the kernel helpers like BIT/GENMASK/FIELD_x in there. It shall
> > > > > significantly improve the code readability.
> > > > > 
> > > > > Link:
> > > > > https://lore.kernel.org/linux-edac/20220822190730.27277-1-Sergey.Semin@baik
> > > > > alelectronics.ru/ Changelog 2:
> > > > > - Move Synopsys DW uMCTL2 DDRC bindings file renaming to a separate patch.
> > > > >   (@Krzysztof)
> > > > > - Introduce a new compatible string "snps,dw-umctl2-ddrc" matching the new
> > > > >   DT-schema name.
> > > > > - Forgot to fix some of the prefix of the SYNPS_ZYNQMP_IRQ_REGS macro
> > > > >   in several places. (@tbot)
> > > > > - Drop the no longer used "priv" pointer from the mc_init() function.
> > > > >   (@tbot)
> > > > > - Include "linux/bitfield.h" header file to get the FIELD_GET macro
> > > > >   definition. (@tbot)
> > > > > - Drop the already merged in patches:
> > > > > [PATCH 12/20] EDAC/mc: Replace spaces with tabs in memtype flags definition
> > > > > [PATCH 13/20] EDAC/mc: Drop duplicated dimm->nr_pages debug printout
> > > > > 
> > > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > > > > Cc: Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>
> > > > > Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> > > > > Cc: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>
> > > > > Cc: Manish Narani <manish.narani@xilinx.com>
> > > > > Cc: Dinh Nguyen <dinguyen@kernel.org>
> > > > > Cc: James Morse <james.morse@arm.com>
> > > > > Cc: Robert Richter <rric@kernel.org>
> > > > > Cc: Rob Herring <robh@kernel.org>
> > > > > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > > Cc: devicetree@vger.kernel.org
> > > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > > Cc: linux-edac@vger.kernel.org
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > > 
> > > > > Serge Semin (19):
> > > > >   EDAC/synopsys: Fix native uMCTL2 IRQs handling procedure
> > > > >   EDAC/synopsys: Fix generic device type detection procedure
> > > > >   EDAC/synopsys: Fix mci->scrub_cap field setting
> > > > >   EDAC/synopsys: Drop erroneous ADDRMAP4.addrmap_col_b10 parse
> > > > >   EDAC/synopsys: Fix reading errors count before ECC status
> > > > >   EDAC/synopsys: Use platform device devm ioremap method
> > > > >   EDAC/synopsys: Drop internal CE and UE counters
> > > > >   EDAC/synopsys: Drop local to_mci macro implementation
> > > > >   EDAC/synopsys: Drop struct ecc_error_info.blknr field
> > > > >   EDAC/synopsys: Shorten out struct ecc_error_info.bankgrpnr field name
> > > > >   EDAC/synopsys: Drop redundant info from error message
> > > > >   EDAC/mc: Init DIMM labels in MC registration method
> > > > >   EDAC/mc: Add MC unique index allocation procedure
> > > > >   dt-bindings: memory: snps: Detach Zynq DDRC controller support
> > > > >   dt-bindings: memory: snps: Use more descriptive device name
> > > > >   EDAC/synopsys: Detach Zynq DDRC controller support
> > > > >   EDAC/synopsys: Drop unused platform-specific setup API
> > > > >   EDAC/synopsys: Unify the driver entities naming
> > > > >   EDAC/synopsys: Convert to using BIT/GENMASK/FIELD_x macros
> > > > > 
> > > > >  .../snps,dw-umctl2-ddrc.yaml                  |  56 ++
> > > > >  .../memory-controllers/synopsys,ddrc-ecc.yaml |  76 --
> > > > >  .../xlnx,zynq-ddrc-a05.yaml                   |  38 +
> > > > >  MAINTAINERS                                   |   3 +
> > > > >  drivers/edac/Kconfig                          |   9 +-
> > > > >  drivers/edac/Makefile                         |   1 +
> > > > >  drivers/edac/edac_mc.c                        | 135 ++-
> > > > >  drivers/edac/edac_mc.h                        |   4 +
> > > > >  drivers/edac/synopsys_edac.c                  | 903 ++++++------------
> > > > >  drivers/edac/zynq_edac.c                      | 504 ++++++++++
> > > > >  10 files changed, 1026 insertions(+), 703 deletions(-)
> > > > >  create mode 100644
> > > > > Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.ya
> > > > > ml delete mode 100644
> > > > > Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
> > > > > create mode 100644
> > > > > Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yam
> > > > > l create mode 100644 drivers/edac/zynq_edac.c
> > > > 
> > > > 
> > > > -- 
> > > > TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> > > > Amtsgericht München, HRB 105018
> > > > Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> > > > http://www.tq-group.com/
> > > > 
> > > > 
