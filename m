Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21490797BAC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbjIGS0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbjIGS0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:26:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA31121;
        Thu,  7 Sep 2023 11:26:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AD6C433C8;
        Thu,  7 Sep 2023 18:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694111185;
        bh=eywdKgsN2Rnh78DdkWhf1HSrTzraQpsNaEQDF5/a48Q=;
        h=Date:From:To:Cc:Subject:From;
        b=e0TA0XoUZedn2aNokK6GCs//9lS4S26E4pSOb4ef11rlST6a07tINRGZgfAQmxLaO
         xDj8W675aZqFeKAn6wU5VT3To9brHvW0ClfpXtWO9qCcYhqa+KB3GqDACYWy5yZeL5
         Tj9BwbyhFhzhlDMyIDB6KHXWvo9QlBrNH91ybYCEtITyqJVZ00zq4Hqw21NZyD6B7i
         yPl3vr0xqbPI5O5wBXo8Zip9/h9crT7G9zbYnMMulhQFeSl7X8o5l9cklXHQRyYcUH
         xMZVzhE36QVH5hGp0/AMbhruAyz5Ke85VsXYTj+v8geQWLbrcPLegDRsfao83hLT+x
         MoBCnFTCRGwWA==
Received: (nullmailer pid 1982726 invoked by uid 1000);
        Thu, 07 Sep 2023 18:26:24 -0000
Date:   Thu, 7 Sep 2023 13:26:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.6, take 1
Message-ID: <20230907182624.GA1977731-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull. A couple of conversions which didn't get picked up by the  
subsystems and 1 fix.

Rob


The following changes since commit 75cc186739805a5e8abe133be04692b36e7a5257:

  dt-bindings: usb: Add V3s compatible string for OHCI (2023-08-28 16:36:52 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.6-1

for you to fetch changes up to 591b00cc4fcfcb4532e4b85b5b2e67bbcf4973a0:

  dt-bindings: irqchip: convert st,stih407-irq-syscfg to DT schema (2023-09-05 16:15:09 -0500)

----------------------------------------------------------------
Devicetree fixes for v6.6, part 1:

- Convert st,stih407-irq-syscfg and Omnivision OV7251 bindings to DT
  schema

- Merge Omnivision OV5695 into OV5693 binding

- Fix of_overlay_fdt_apply prototype when !CONFIG_OF_OVERLAY

----------------------------------------------------------------
Pavel Pisa (1):
      of: overlay: Fix of_overlay_fdt_apply prototype when !CONFIG_OF_OVERLAY

Raphael Gallais-Pou (1):
      dt-bindings: irqchip: convert st,stih407-irq-syscfg to DT schema

Rob Herring (2):
      media: dt-bindings: Merge OV5695 into OV5693 binding
      media: dt-bindings: Convert Omnivision OV7251 to DT schema

 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml      |   1 +
 .../interrupt-controller/st,sti-irq-syscfg.txt     |  30 ------
 .../st,stih407-irq-syscfg.yaml                     |  65 ++++++++++++
 .../devicetree/bindings/media/i2c/ov5695.txt       |  41 --------
 .../devicetree/bindings/media/i2c/ov7251.txt       |  52 ----------
 .../devicetree/bindings/media/i2c/ovti,ov5693.yaml |  31 ++++--
 .../devicetree/bindings/media/i2c/ovti,ov7251.yaml | 109 +++++++++++++++++++++
 .../devicetree/bindings/media/rockchip-isp1.yaml   |   1 +
 include/linux/of.h                                 |   4 +-
 9 files changed, 202 insertions(+), 132 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov5695.txt
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov7251.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov7251.yaml
