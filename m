Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02127E8A78
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 12:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjKKLEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 06:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjKKLED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 06:04:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3338D3C05
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 03:04:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82F2C43395;
        Sat, 11 Nov 2023 11:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699700639;
        bh=/mCsRpoHNfIXUNMQCkSkO7WIeDaCJXswf/0MS4Qqxww=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sf58H/MaoBZZ/xOFYMzMRrDPETrlRGADgg4vjWHg/ITAxvutAcyCvu+JGVVVkGyaS
         ti58qyVGv+BAsyknYmxe/7jI039fP1ZpI/suSu3zL6wVmkNVwes2jeUAEGrHWFx1ib
         rgjLH/72RIDg9yUuqjZI93NbJhYZi6c6iTCHHDirFY19X1+5tTYARa8LYttRNTrsk7
         8dOhRd4KqOluueV3UKwtSMFAeQBKai+bfZXRwCZqlQY3QKUChI9QrK9DcweFKDbpOs
         cfSO7BOs3SZIHFrgYDZ3icrpZEkJiMS/lqyiFwCVaepza6GKFG1jmsYUfa20kSCEbC
         0ieyYH2g6iKYA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2c834c52b5aso15975091fa.1;
        Sat, 11 Nov 2023 03:03:59 -0800 (PST)
X-Gm-Message-State: AOJu0YwitsRY0mQXvs3fkbeqBXnbJ1ZX6M3rhxpuKi0/XumRgcCwDfnH
        8cDtH0pBGJyNcbF9VLQKMsot5x5+pCxt9lwml9s=
X-Google-Smtp-Source: AGHT+IHwnbe1LHcOvdw6D1LpdnWzFdtyWX7I2RFO0IU/Kq2EYq5LOp7rs1R+FvsDd3/9FmKKqRkcUXf0D53RTQwLbzE=
X-Received: by 2002:a2e:9898:0:b0:2c5:19f2:4fde with SMTP id
 b24-20020a2e9898000000b002c519f24fdemr1156839ljj.23.1699700637978; Sat, 11
 Nov 2023 03:03:57 -0800 (PST)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org> <20230926194242.2732127-2-sjg@chromium.org>
 <BN9PR11MB5483FF3039913334C7EA83E1E6AEA@BN9PR11MB5483.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5483FF3039913334C7EA83E1E6AEA@BN9PR11MB5483.namprd11.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 11 Nov 2023 21:03:46 +1000
X-Gmail-Original-Message-ID: <CAMj1kXFG92NpL7T7YocOup0xLKyopt3MnSCp0RL8cLzozzJz7A@mail.gmail.com>
Message-ID: <CAMj1kXFG92NpL7T7YocOup0xLKyopt3MnSCp0RL8cLzozzJz7A@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To:     "Chiu, Chasel" <chasel.chiu@intel.com>
Cc:     Simon Glass <sjg@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        "Tan, Lean Sheng" <sheng.tan@9elements.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dhaval Sharma <dhaval@rivosinc.com>,
        "Brune, Maximilian" <maximilian.brune@9elements.com>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        "Dong, Guo" <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>,
        ron minnich <rminnich@gmail.com>,
        "Guo, Gua" <gua.guo@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2023 at 04:20, Chiu, Chasel <chasel.chiu@intel.com> wrote:
>
>
> Just sharing some usage examples from UEFI/EDK2 scenario.
> To support ACPI S4/Hibernation, memory map must be consistent before ente=
ring and after resuming from S4, in this case payload may need to know prev=
ious memory map from bootloader (currently generic payload cannot access pl=
atform/bootloader specific non-volatile data, thus could not save/restore m=
emory map information)

So how would EDK2 reconstruct the entire EFI memory map from just
these unannotated /reserved-memory nodes? The EFI memory map contains
much more information than that, and all of it has to match the
pre-hibernate situation, right? Can you given an example?

> Another usage is to support binary model which generic payload is a prebu=
ilt binary compatible for all platforms/configurations, however the payload=
 default memory map might not always work for all the configurations and we=
 want to allow bootloader to override payload default memory map without re=
compiling.
>

Agreed. But can you explain how a EDK2 payload might make meaningful
use of 'runtime-code' regions provided via DT  by the non-EDK2
platform init? Can you give an example?

> Under below assumption:
>         FDT OS impact has been evaluated and taken care by relevant exper=
ts/stakeholders.
> Reviewed-by: Chasel Chiu <chasel.chiu@intel.com>
>

I am sorry but I don't know what 'FDT OS impact' means. We are talking
about a firmware-to-firmware abstraction that has the potential to
leak into the OS visible interface.

I am a maintainer in the Tianocore project myself, so it would help if
you could explain who these relevant experts and stakeholders are. Was
this discussed on the edk2-devel mailing list? If so, apologies for
missing it but I may not have been cc'ed perhaps?


>
> > -----Original Message-----
> > From: Simon Glass <sjg@chromium.org>
> > Sent: Tuesday, September 26, 2023 12:43 PM
> > To: devicetree@vger.kernel.org
> > Cc: Mark Rutland <mark.rutland@arm.com>; Rob Herring <robh@kernel.org>;
> > Tan, Lean Sheng <sheng.tan@9elements.com>; lkml <linux-
> > kernel@vger.kernel.org>; Dhaval Sharma <dhaval@rivosinc.com>; Brune,
> > Maximilian <maximilian.brune@9elements.com>; Yunhui Cui
> > <cuiyunhui@bytedance.com>; Dong, Guo <guo.dong@intel.com>; Tom Rini
> > <trini@konsulko.com>; ron minnich <rminnich@gmail.com>; Guo, Gua
> > <gua.guo@intel.com>; Chiu, Chasel <chasel.chiu@intel.com>; linux-
> > acpi@vger.kernel.org; U-Boot Mailing List <u-boot@lists.denx.de>; Ard
> > Biesheuvel <ardb@kernel.org>; Simon Glass <sjg@chromium.org>
> > Subject: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
> >
> > It is common to split firmware into 'Platform Init', which does the ini=
tial hardware
> > setup and a "Payload" which selects the OS to be booted.
> > Thus an handover interface is required between these two pieces.
> >
> > Where UEFI boot-time services are not available, but UEFI firmware is p=
resent on
> > either side of this interface, information about memory usage and attri=
butes must
> > be presented to the "Payload" in some form.
> >
> > This aims to provide an small schema addition for the memory mapping ne=
eded
> > to keep these two pieces working together well.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v7:
> > - Rename acpi-reclaim to acpi
> > - Drop individual mention of when memory can be reclaimed
> > - Rewrite the item descriptions
> > - Add back the UEFI text (with trepidation)
> >
> > Changes in v6:
> > - Drop mention of UEFI
> > - Use compatible strings instead of node names
> >
> > Changes in v5:
> > - Drop the memory-map node (should have done that in v4)
> > - Tidy up schema a bit
> >
> > Changes in v4:
> > - Make use of the reserved-memory node instead of creating a new one
> >
> > Changes in v3:
> > - Reword commit message again
> > - cc a lot more people, from the FFI patch
> > - Split out the attributes into the /memory nodes
> >
> > Changes in v2:
> > - Reword commit message
> >
> >  .../reserved-memory/common-reserved.yaml      | 71 +++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >  create mode 100644 dtschema/schemas/reserved-memory/common-
> > reserved.yaml
> >
> > diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml
> > b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > new file mode 100644
> > index 0000000..f7fbdfd
> > --- /dev/null
> > +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > @@ -0,0 +1,71 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
> > +---
> > +$id:
> > +http://devicetree.org/schemas/reserved-memory/common-reserved.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Common memory reservations
> > +
> > +description: |
> > +  Specifies that the reserved memory region can be used for the purpos=
e
> > +  indicated by its compatible string.
> > +
> > +  Clients may reuse this reserved memory if they understand what it is
> > + for,  subject to the notes below.
> > +
> > +maintainers:
> > +  - Simon Glass <sjg@chromium.org>
> > +
> > +allOf:
> > +  - $ref: reserved-memory.yaml
> > +
> > +properties:
> > +  compatible:
> > +    description: |
> > +      This describes some common memory reservations, with the compati=
ble
> > +      string indicating what it is used for:
> > +
> > +         acpi: Advanced Configuration and Power Interface (ACPI) table=
s
> > +         acpi-nvs: ACPI Non-Volatile-Sleeping Memory (NVS). This is re=
served by
> > +           the firmware for its use and is required to be saved and re=
stored
> > +           across an NVS sleep
> > +         boot-code: Contains code used for booting which is not needed=
 by the OS
> > +         boot-code: Contains data used for booting which is not needed=
 by the OS
> > +         runtime-code: Contains code used for interacting with the sys=
tem when
> > +           running the OS
> > +         runtime-data: Contains data used for interacting with the sys=
tem when
> > +           running the OS
> > +
> > +    enum:
> > +      - acpi
> > +      - acpi-nvs
> > +      - boot-code
> > +      - boot-data
> > +      - runtime-code
> > +      - runtime-data
> > +
> > +  reg:
> > +    description: region of memory that is reserved for the purpose ind=
icated
> > +      by the compatible string.
> > +
> > +required:
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    reserved-memory {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <1>;
> > +
> > +        reserved@12340000 {
> > +            compatible =3D "boot-code";
> > +            reg =3D <0x12340000 0x00800000>;
> > +        };
> > +
> > +        reserved@43210000 {
> > +            compatible =3D "boot-data";
> > +            reg =3D <0x43210000 0x00800000>;
> > +        };
> > +    };
> > --
> > 2.42.0.515.g380fc7ccd1-goog
>
