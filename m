Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB2A81387C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444040AbjLNR1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNR07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:26:59 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1E799;
        Thu, 14 Dec 2023 09:27:05 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5906e03a7a4so4937482eaf.1;
        Thu, 14 Dec 2023 09:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702574825; x=1703179625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvlPaOvWZi6YT4dBhvJqrCk9Wves4WI6vEv3aL4+FYg=;
        b=MJagL2MPO5d/r2tleyWyiCfgpeB2PaTJgSyPLHgyEwEPEU6HM/IU+5gNVsOVaKyC2b
         BGWMoeQzwALreJwaxFLxHSDqi7nL6wEGW8yDPG3//dwxC+1LzfCtfFNLd18ZUuiSRrfY
         TuEQuM4OgdxxsD3DCtee1/zFyAPrbbIuIh26VCMStTPGXyuFzVdFf5HSc0sAqdCALZh9
         /bbhhru+ZJwp3+EohG9l5Sz3GsMkHO34TVj6gBMA/+j8Q4mF+EvnnGgAuH/vpi/zZExv
         3bbl/u5gXMfwXIU57NGKi0/MZ0p2oFy6RthBLHOm7OsBYz8eev5lzi74p6upewv7TKR2
         G7vA==
X-Gm-Message-State: AOJu0YxY1MWBpeW+OvCCKXqKEf0vd5UTxGMv8gwnCRcECQh0kuNNoH9A
        DP4mHSzWCA7hGjdx8g59ag==
X-Google-Smtp-Source: AGHT+IHE3yB7iPFgi1CEIf18XQ6wLVZQxOJa4peKJpfxlxe4KfiUfxamVgaQaN9eMO+YHnRGmAJgUg==
X-Received: by 2002:a05:6820:162c:b0:590:6f86:f3c6 with SMTP id bb44-20020a056820162c00b005906f86f3c6mr8302579oob.12.1702574825070;
        Thu, 14 Dec 2023 09:27:05 -0800 (PST)
Received: from herring.priv ([2607:fb91:e6c7:a40:1c2d:b875:912d:c28])
        by smtp.gmail.com with ESMTPSA id q12-20020a056820028c00b0058d52d0ef2dsm3456842ood.38.2023.12.14.09.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:27:04 -0800 (PST)
Received: (nullmailer pid 622570 invoked by uid 1000);
        Thu, 14 Dec 2023 17:27:02 -0000
Date:   Thu, 14 Dec 2023 11:27:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Simon Glass <sjg@chromium.org>
Cc:     devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>,
        Michael Walle <mwalle@kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pratyush Yadav <ptyadav@amazon.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: partitions: Add binman
 compatible
Message-ID: <20231214172702.GA617226-robh@kernel.org>
References: <20231116172859.393744-1-sjg@chromium.org>
 <20231208150042.GA1278773-robh@kernel.org>
 <CAPnjgZ2i4gvgiUeHPOfHuOdBooV4e=QQEq6iMo0JbDwOS6dCwA@mail.gmail.com>
 <CAL_Jsq+xMZ8yz4H9D59uCSyX4h5W+4ruGF++=wVA=msXz+Y01A@mail.gmail.com>
 <CAPnjgZ1uW8T6woXSqFUNm301=W3zBYOrADREkrz=DuwSW87qZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPnjgZ1uW8T6woXSqFUNm301=W3zBYOrADREkrz=DuwSW87qZg@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 03:58:10PM -0700, Simon Glass wrote:
> Hi Rob,
> 
> On Fri, 8 Dec 2023 at 14:56, Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Dec 8, 2023 at 11:47 AM Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Rob,
> > >
> > > On Fri, 8 Dec 2023 at 08:00, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Thu, Nov 16, 2023 at 10:28:50AM -0700, Simon Glass wrote:
> > > > > Add a compatible string for binman, so we can extend fixed-partitions
> > > > > in various ways.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v5)
> > > > >
> > > > > Changes in v5:
> > > > > - Add #address/size-cells and parternProperties
> > > > > - Drop $ref to fixed-partitions.yaml
> > > > > - Drop 'select: false'
> > > > >
> > > > > Changes in v4:
> > > > > - Change subject line
> > > > >
> > > > > Changes in v3:
> > > > > - Drop fixed-partition additional compatible string
> > > > > - Drop fixed-partitions from the example
> > > > > - Mention use of compatible instead of label
> > > > >
> > > > > Changes in v2:
> > > > > - Drop mention of 'enhanced features' in fixed-partitions.yaml
> > > > > - Mention Binman input and output properties
> > > > > - Use plain partition@xxx for the node name
> > > > >
> > > > >  .../bindings/mtd/partitions/binman.yaml       | 68 +++++++++++++++++++
> > > > >  .../bindings/mtd/partitions/partitions.yaml   |  1 +
> > > > >  MAINTAINERS                                   |  5 ++
> > > > >  3 files changed, 74 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..329217550a98
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> > > > > @@ -0,0 +1,68 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > +# Copyright 2023 Google LLC
> > > > > +
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/mtd/partitions/binman.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Binman firmware layout
> > > > > +
> > > > > +maintainers:
> > > > > +  - Simon Glass <sjg@chromium.org>
> > > > > +
> > > > > +description: |
> > > > > +  The binman node provides a layout for firmware, used when packaging firmware
> > > > > +  from multiple projects. It is based on fixed-partitions, with some
> > > > > +  extensions, but uses 'compatible' to indicate the contents of the node, to
> > > > > +  avoid perturbing or confusing existing installations which use 'label' for a
> > > > > +  particular purpose.
> > > > > +
> > > > > +  Binman supports properties used as inputs to the firmware-packaging process,
> > > > > +  such as those which control alignment of partitions. This binding addresses
> > > > > +  these 'input' properties. For example, it is common for the 'reg' property
> > > > > +  (an 'output' property) to be set by Binman, based on the alignment requested
> > > > > +  in the input.
> > > > > +
> > > > > +  Once processing is complete, input properties have mostly served their
> > > > > +  purpose, at least until the firmware is repacked later, e.g. due to a
> > > > > +  firmware update. The 'fixed-partitions' binding should provide enough
> > > > > +  information to read the firmware at runtime, including decompression if
> > > > > +  needed.
> > > >
> > > > How is this going to work exactly? binman reads these nodes and then
> > > > writes out 'fixed-partitions' nodes. But then you've lost the binman
> > > > specifc parts needed for repacking.
> > >
> > > No, they are the same node. I do want the extra information to stick
> > > around. So long as it is compatible with fixed-partition as well, this
> > > should work OK.
> >
> > How can it be both? The partitions node compatible can be either
> > 'fixed-partitions' or 'binman'.
> 
> Can we not allow it to be both? I have tried to adjust things in
> response to feedback but perhaps the feedback was leading me down the
> wrong path?

Sure, but then the schema has to and that means extending 
fixed-partitions.

Rob
