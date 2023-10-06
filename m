Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C77C7BBF71
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjJFTBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjJFTBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:01:10 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7D495;
        Fri,  6 Oct 2023 12:01:08 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6c4cbab83aaso1550344a34.1;
        Fri, 06 Oct 2023 12:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618868; x=1697223668;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQPfNCUG/HzQo9Fb1PaZQ4iG1oWkBwwHEdqzoS77ZME=;
        b=cPLrd0GrWzFXiIGfkvQxG54OPcXOXLvbsRgPKyTlmm93pfQRMh97sONqx/MgCpFJrX
         1c0T18r8JCQ7XV88WOO309QZDa9s0sYcrnPzc/VUfnGCqmcCUNiOdOP2GosujPBOaudg
         jjmW3YNKCTXDNqHOjb1VlBol2TNr4FLaN2VR8cjJ42WKENfgFYcx74kjJ8LHpNEZM+Ey
         n+fdBSNAVN/k0z9TzlVLhSAPVuqs/WjeT48qTcP4hD4LRPoIUhA7fDp3mX/dlEY+2CUx
         31GneYUmsgHwcTZcVn5zIxx8QIeILeAdqeVo7R09pAm5WcBR7r6flUVALcZf/MfD9bM9
         yZhQ==
X-Gm-Message-State: AOJu0Yyar9tysrV53JJ1rTHaibuB+23TG5ne8oBSxQ9TCBteSMhDcfhf
        EtGBgTCv6gNdSf19+mtL1A==
X-Google-Smtp-Source: AGHT+IHhTuC+dn/OXrN95UVzcrVXD+InpPJ6j31I7cOc6glAgIzqtbSBJmzcdjlHwUJIp6HIW8+P7g==
X-Received: by 2002:a05:6830:d6:b0:6be:fc8b:40fc with SMTP id x22-20020a05683000d600b006befc8b40fcmr8906952oto.36.1696618867997;
        Fri, 06 Oct 2023 12:01:07 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h19-20020a9d61d3000000b006b9e872c0a0sm653765otk.68.2023.10.06.12.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 12:01:07 -0700 (PDT)
Received: (nullmailer pid 145696 invoked by uid 1000);
        Fri, 06 Oct 2023 19:01:06 -0000
Date:   Fri, 6 Oct 2023 14:01:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.6, take 2
Message-ID: <20231006190106.GA143694-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull some DT fixes for 6.6.

Rob


The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.6-2

for you to fetch changes up to 19007c629c63c76ae0f8adee9dc076bda4788b46:

  dt-bindings: trivial-devices: Fix MEMSIC MXC4005 compatible string (2023-10-06 13:54:14 -0500)

----------------------------------------------------------------
Devicetree fixes for v6.6, part 2:

- Fix potential memory leak in of_changeset_action()

- Fix some i.MX binding warnings

- Fix typo in renesas,vin binding field-even-active property

- Fix andestech,ax45mp-cache example unit-address

- Add missing additionalProperties on RiscV CPU interrupt-controller
  node

- Add missing unevaluatedProperties on media bindings

- Fix brcm,iproc-pcie binding 'msi' child node schema

- Fix MEMSIC MXC4005 compatible string

----------------------------------------------------------------
Dan Carpenter (1):
      of: dynamic: Fix potential memory leak in of_changeset_action()

Fabio Estevam (2):
      dt-bindings: display: fsl,imx6-hdmi: Change to 'unevaluatedProperties: false'
      media: dt-bindings: imx7-csi: Make power-domains not required for imx8mq

Geert Uytterhoeven (3):
      of: overlay: Reorder struct fragment fields kerneldoc
      dt-bindings: cache: andestech,ax45mp-cache: Fix unit address in example
      dt-bindings: media: renesas,vin: Fix field-even-active spelling

Luca Ceresoli (1):
      dt-bindings: trivial-devices: Fix MEMSIC MXC4005 compatible string

Rob Herring (6):
      dt-bindings: riscv: cpus: Add missing additionalProperties on interrupt-controller node
      dt-bindings: bus: fsl,imx8qxp-pixel-link-msi-bus: Drop child 'reg' property
      media: dt-bindings: Add missing unevaluatedProperties on child node schemas
      dt-bindings: PCI: brcm,iproc-pcie: Fix example indentation
      dt-bindings: PCI: brcm,iproc-pcie: Drop common pci-bus properties
      dt-bindings: PCI: brcm,iproc-pcie: Fix 'msi' child node schema

 .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml        |   3 -
 .../bindings/cache/andestech,ax45mp-cache.yaml     |   2 +-
 .../bindings/display/imx/fsl,imx6-hdmi.yaml        |   2 +-
 .../devicetree/bindings/media/i2c/sony,imx415.yaml |   1 +
 .../bindings/media/i2c/toshiba,tc358746.yaml       |   2 +
 .../devicetree/bindings/media/nxp,imx7-csi.yaml    |   1 -
 .../devicetree/bindings/media/renesas,vin.yaml     |   4 +-
 .../devicetree/bindings/media/samsung,fimc.yaml    |   1 +
 .../devicetree/bindings/pci/brcm,iproc-pcie.yaml   | 163 ++++++++++-----------
 Documentation/devicetree/bindings/riscv/cpus.yaml  |   1 +
 .../devicetree/bindings/trivial-devices.yaml       |   2 +-
 drivers/of/dynamic.c                               |   6 +-
 drivers/of/overlay.c                               |   2 +-
 13 files changed, 90 insertions(+), 100 deletions(-)
