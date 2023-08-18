Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690A97815A7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 01:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242098AbjHRXHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 19:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242052AbjHRXG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 19:06:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079FA421B;
        Fri, 18 Aug 2023 16:06:54 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4ff9121fd29so2096145e87.3;
        Fri, 18 Aug 2023 16:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692400012; x=1693004812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wi1v1waR7elBm9hwQEyjXxrKEyCGT4bzLcQaPHnjWJE=;
        b=I36Tk/y4RBcvvwHnvzu0xlLQYHQkE7MpPAdflv1XeJdKGxMBj3hhLD+/pUDaon6mPv
         dB8zjgCPOWdVbFRn3FM2WxeG4ggC7FMZbX7JYHUy4M3uZwA7QyaWZH6ioge/eDkleX4z
         2H2z5d4BNT7wPfHwZtg7Vz8n2H9HE8w8mn2gsJ3FC8iINXVG5v6IjdbzfEtD4vgC4XwX
         Xg/Mn2p6lHxvRp2HlibVkeTmb4Rq+YzyT++Xtjpp1b3xuIyDwKllW6Ll48D4v3E43RPg
         u5Gli6Hwv35jyfHk+i9h4MHfOxQUzY8fnc1jYfvx25dKP8Gpa81Xk64IXpnECaqC5pbd
         I6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692400012; x=1693004812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wi1v1waR7elBm9hwQEyjXxrKEyCGT4bzLcQaPHnjWJE=;
        b=Va8bTL+YPh5BLbqS9Zv201mLA5soBm7V7Sve2rT1DO/1GAjl0sUPWzOI8i6ul6LdRV
         l3aTpxW7XJslz29oWQyai+i/f/X6LAmCBdjtQcryZA3lggn41HBNs8Gt+K7fiB607qc+
         gNIbnAClOhx6mjwLXtkg7KoMZKhifB3hpEOkM9LV6p+uPCBaz6/MX5sV3jcda9p4tpxH
         +mtm/J4xxgZIqs5NFfuN97bdj6lN3tn8pd9fjKlXjo+oogZ6h0vWWl6pwbcmz6tQjmCv
         esPvIj+edgKA88Jzuzti0reTLgWSC+JCYVJ9WuPEcYD0je2u7BylDL+Spe6ZRUef/qdv
         bUDw==
X-Gm-Message-State: AOJu0YzT+CeJbrLuVVwyI+5wEgJMVaC/1P9UkX7xu0goJW7aacMh+YT0
        DSXPlAT5E0WOlM69uoX+GkU=
X-Google-Smtp-Source: AGHT+IFRRghkgAQG0AHq+6D2jL23ilgWcL8c/ti1/LIZ+VFKc2mmT9b4RNtcxJgb6ugqMiSuLCxj1g==
X-Received: by 2002:a05:6512:15aa:b0:4fb:c885:425 with SMTP id bp42-20020a05651215aa00b004fbc8850425mr427470lfb.9.1692400011892;
        Fri, 18 Aug 2023 16:06:51 -0700 (PDT)
Received: from mobilestation ([95.79.200.178])
        by smtp.gmail.com with ESMTPSA id 14-20020ac2482e000000b004fe1ee6546esm531665lft.168.2023.08.18.16.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 16:06:51 -0700 (PDT)
Date:   Sat, 19 Aug 2023 02:06:49 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Robert Richter <rric@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 00/17] EDAC/mc/synopsys: Various fixes and
 cleanups
Message-ID: <dzgdh2ghcphserxywjrlgusukghgj2t7yg6bo6ychade7b2sbm@7khr6s3df7ui>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav

On Fri, Sep 30, 2022 at 02:26:55AM +0300, Serge Semin wrote:
> This patchset is a first one in the series created in the framework of
> my Baikal-T1 DDRC-related work:
> 
> [1: In-progress] EDAC/mc/synopsys: Various fixes and cleanups
> Link: ---you are looking at it---
> [2: In-progress] EDAC/synopsys: Add generic DDRC info and address mapping
> Link: https://lore.kernel.org/linux-edac/20220910195007.11027-1-Sergey.Semin@baikalelectronics.ru
> [3: In-progress] EDAC/synopsys: Add generic resources and Baikal-T1 support
> Link: https://lore.kernel.org/linux-edac/20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru

I'm terribly sorry for a very long delay with addressing your comments
in this patchset. I have been very busy all that time with another
kernel drivers. Now I am finally able to get back to this series.

This patchset and another two ones have been successfully rebased onto
the latest kernel version - 6.5-rc5. No regression has been spotted in
my environment.

Regarding your comments to this series. I've got a general gist
concerning my patchlog messages. I'll convert all of them to using the
imperative mood and drop "what" description in v4.

Regarding the main issue of detaching the Zynq A05 DDRC part from the
Synopsys uMCTL2 driver. I see there is another ZynqMP mem-ctl driver
has been added recently. It's ZynqMP OCM. During its review you
settled that it's possible to have two different EDAC drivers executed
on the system.
https://lore.kernel.org/linux-edac/BY5PR12MB4258CB67B70D71F107EC1E9DDB3E9@BY5PR12MB4258.namprd12.prod.outlook.com/
So it's no longer issue in this series and the Zynq A05 DDRC part can
be freely moved to a separate driver as I originally intended.

Regarding the MC identifiers patch. I'll revise it one more time
whether it needs to be changed. In anyway I still find it very handy
to have a functionality of dynamic or alias-based MC identifier
allocation.

I'll respond to your comment sent to the patch 1 of this series. Then
I'll fix all the issues described above and resubmit v4. Then we'll be
able to get back to a standard review procedure.

Once again sorry for the huge delay with proceeding in this patchset
review.

Regards
-Serge(y)

> 
> Note the patchsets above must be merged in the same order as they are
> placed in the list in order to prevent conflicts. Nothing prevents them
> from being reviewed synchronously though. Any tests are very welcome.
> Thanks in advance.
> 
> Regarding this series content. It's an initial patchset which
> traditionally provides various fixes, cleanups and modifications required
> for the more comfortable further features development. The main goal of it
> though is to detach the Xilinx Zynq A05 DDRC related code into the
> dedicated driver since first it has nothing to do with the Synopsys DW
> uMCTL2 DDR controller and second it will be a great deal obstacle on the
> way of extending the Synopsys-part functionality.
> 
> The series starts with fixes patches, which in short concern the next
> aspects: touching the ZynqMP-specific CSRs on the Xilinx ZinqMP platform
> only, serializing an access to the ECCCLR register, adding correct memory
> devices type detection, setting a correct value to the
> mem_ctl_info.scrub_cap field, dropping an erroneous ADDRMAP[4] parsing and
> getting back a correct order of the ECC errors info detection procedure.
> 
> Afterwards the patchset provides several cleanup patches required for the
> more coherent code splitting up (Xilinx Zynq A05 and Synopsys DW uMCTL2)
> so the provided modifications would be useful in both drivers. First we
> get to replace the platform resource manual IO-remapping with the
> devm_platform_ioremap_resource() method call. Secondly we suggest to drop:
> internal CE/UE errors counters, local to_mci() macros definition, some
> redundant ecc_error_info structure fields and redundant info from the
> error message, duplicated dimm->nr_pages debug printout and spaces from
> the MEM_TYPE flags declarations. (The later two updates concern the MCI
> core part.) Thirdly before splitting up the driver we need to add an
> unique MC index allocation infrastructure to the MCI core.  It's required
> since after splitting the driver up we'll need to make sure both device
> types could be correctly probed on the same platform. Finally the Xilinx
> Zynq A05 part of the driver is moved out to a dedicated driver where it
> should been originally placed. After that the platform-specific setups API
> is removed from the Synopsys DW uMCTL2 DDRC driver since it's no longer
> required.
> 
> Finally as the cherry on the cake we suggest to unify the DW uMCTL2 DDRC
> driver entities naming and replace the open-coded "shift/mask" patter with
> the kernel helpers like BIT/GENMASK/FIELD_x in there. It shall
> significantly improve the code readability.
> 
> Link: https://lore.kernel.org/linux-edac/20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v2:
> - Move Synopsys DW uMCTL2 DDRC bindings file renaming to a separate patch.
>   (@Krzysztof)
> - Introduce a new compatible string "snps,dw-umctl2-ddrc" matching the new
>   DT-schema name.
> - Forgot to fix some of the prefix of the SYNPS_ZYNQMP_IRQ_REGS macro
>   in several places. (@tbot)
> - Drop the no longer used "priv" pointer from the mc_init() function.
>   (@tbot)
> - Include "linux/bitfield.h" header file to get the FIELD_GET macro
>   definition. (@tbot)
> - Drop the already merged in patches:
> [PATCH 12/20] EDAC/mc: Replace spaces with tabs in memtype flags definition
> [PATCH 13/20] EDAC/mc: Drop duplicated dimm->nr_pages debug printout
> 
> Link: https://lore.kernel.org/linux-edac/20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru
> Changelog v3:
> - Drop the no longer used "priv" pointer from the mc_init() function.
>   (@tbot)
> - Drop the merged in patches:
> [PATCH v2 14/19] dt-bindings: memory: snps: Detach Zynq DDRC controller support
> [PATCH v2 15/19] dt-bindings: memory: snps: Use more descriptive device name
>   (@Krzysztof)
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>
> Cc: Manish Narani <manish.narani@xilinx.com>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Robert Richter <rric@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-edac@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (17):
>   EDAC/synopsys: Fix native uMCTL2 IRQs handling procedure
>   EDAC/synopsys: Fix generic device type detection procedure
>   EDAC/synopsys: Fix mci->scrub_cap field setting
>   EDAC/synopsys: Drop erroneous ADDRMAP4.addrmap_col_b10 parse
>   EDAC/synopsys: Fix reading errors count before ECC status
>   EDAC/synopsys: Use platform device devm ioremap method
>   EDAC/synopsys: Drop internal CE and UE counters
>   EDAC/synopsys: Drop local to_mci macro implementation
>   EDAC/synopsys: Drop struct ecc_error_info.blknr field
>   EDAC/synopsys: Shorten out struct ecc_error_info.bankgrpnr field name
>   EDAC/synopsys: Drop redundant info from error message
>   EDAC/mc: Init DIMM labels in MC registration method
>   EDAC/mc: Add MC unique index allocation procedure
>   EDAC/synopsys: Detach Zynq DDRC controller support
>   EDAC/synopsys: Drop unused platform-specific setup API
>   EDAC/synopsys: Unify the driver entities naming
>   EDAC/synopsys: Convert to using BIT/GENMASK/FIELD_x macros
> 
>  MAINTAINERS                  |   1 +
>  drivers/edac/Kconfig         |   9 +-
>  drivers/edac/Makefile        |   1 +
>  drivers/edac/edac_mc.c       | 135 +++++-
>  drivers/edac/edac_mc.h       |   4 +
>  drivers/edac/synopsys_edac.c | 903 ++++++++++++-----------------------
>  drivers/edac/zynq_edac.c     | 501 +++++++++++++++++++
>  7 files changed, 927 insertions(+), 627 deletions(-)
>  create mode 100644 drivers/edac/zynq_edac.c
> 
> -- 
> 2.37.3
> 
> 
