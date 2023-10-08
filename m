Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117667BCE7B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 15:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344786AbjJHNHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 09:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344778AbjJHNG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 09:06:59 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F6BF2
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 06:06:46 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AE0CB40E0196;
        Sun,  8 Oct 2023 13:06:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j44WDO54ybLv; Sun,  8 Oct 2023 13:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696770403; bh=M3oGBaPgnz4yvzWYVK1KJzO42EFEIxUdcEmJJGFhWwA=;
        h=Date:From:To:Cc:Subject:From;
        b=ReDvh3dY6JQV3/rP4usXK89vi81toW14G+QP+SzkAoBqC65aBtDbJl39EHjTGX6wh
         3tSVeuIvt28qkx3PpoFj+2aMEG3MlXqN+hvrFJh7jKh1IlUiLRfBRpyNE6QQLgsDQW
         GNEHNrNt4URCFZIoM5GrjaQGrgSQTbED5pHZkLI/2TIIJ0dc797DAuWHS/vyf2fkSX
         kxJYVtZTTq7+K9xLAyNbiKSUhMGbxK5xCl/GRk1uI7ad+oxMLp+ZKz27w+Qqq+9HbQ
         4P/duelbGp324/2pAb0+XndI3U7nNVVxavJ+7RpBbeoNIG4Zu2M/7s2Ldyozf+5mzB
         IdZg0BbCM1WTkUTDSpSviDa1RW84Y9s9e1xWXrqqM1MMPLmoICd8hNUL6bM7TzkNEQ
         BZv0a3N/U6OI+rBwVLLvN7BB3/WSXmzq5D02+W0sjFZrQF3KyQSnMkrtx3WXFduqPg
         1RMZhY827n8FKjjBVBZsjCkBRSRvUQAzkIzT5QBPR+GFFHGDFAtp5CbcdC1ObaXrUc
         bnNR1qMJLcXdkXXZziavbvgbcsP0jjYo8ow3pJKx3A7CmbMvOF4EfZEtdQL6shU9/y
         MOFRpZZQD6+loKVy/UNUydkaGuYj8COBqviWo4C6cfpIsh5769NBw2TJGqZpCD82nl
         Fs2Y5W6BMZdIkZrgz/8dIM3o=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E371640E0187;
        Sun,  8 Oct 2023 13:06:39 +0000 (UTC)
Date:   Sun, 8 Oct 2023 15:06:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for 6.6-rc5
Message-ID: <20231008130634.GBZSKpWoTIzUDQMgs/@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple of irqchip fixes for 6.6.

Thx.

---

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.6_rc5

for you to fetch changes up to 9cd847ee4d64c10b52f26f18d19eb6462ba7d2fe:

  Merge tag 'irqchip-fixes-6.6-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent (2023-09-28 23:04:13 +0200)

----------------------------------------------------------------
Irqchip fixes by way of Marc Zyngier <maz@kernel.org>

- Fix QC PDC v3.2 support by working around broken firmware tables

- Fix rzg2l-irqc missing #interrupt-cells description in the DT binding

- Fix rzg2l-irqc interrupt masking

Link: https://lore.kernel.org/lkml/20230924094105.2361754-1-maz@kernel.org

----------------------------------------------------------------
Biju Das (1):
      irqchip: renesas-rzg2l: Fix logic to clear TINT interrupt source

Dmitry Baryshkov (1):
      arm64: dts: qcom: sm8150: extend the size of the PDC resource

Lad Prabhakar (1):
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update description for '#interrupt-cells' property

Neil Armstrong (1):
      irqchip/qcom-pdc: Add support for v3.2 HW

Thomas Gleixner (1):
      Merge tag 'irqchip-fixes-6.6-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

 .../interrupt-controller/renesas,rzg2l-irqc.yaml   |  5 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |  2 +-
 drivers/irqchip/irq-renesas-rzg2l.c                |  2 +-
 drivers/irqchip/qcom-pdc.c                         | 69 ++++++++++++++++------
 4 files changed, 56 insertions(+), 22 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
