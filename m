Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EB075D53B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 21:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjGUTv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 15:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGUTv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 15:51:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C542D7C;
        Fri, 21 Jul 2023 12:51:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDAB261D93;
        Fri, 21 Jul 2023 19:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60CBC433C9;
        Fri, 21 Jul 2023 19:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689969113;
        bh=QJvFmbHYewMmDFozFPxoNw5eL7D2REK03Yv5EE6y7Gk=;
        h=Date:From:To:Cc:Subject:From;
        b=AdTlaEABLspo8Ze9J25WyGSX12Fd1QQCwKg9EdxcEOam1mGQTch8JZgaOpeqEHTu9
         3DkE1mw+vxWlxgVYBDIBvVf5xIU0tTO0f91R2RrxYNeJH3+OzVfqRIZl7YlkTJlqZ0
         3drJgQlDdD8ZCZuJkWAPN29dK8gXKYZSlenKeAw1ld0/OicDlMaur/UUN3DdpgO+DL
         dSYtHPVqXArLFiSBu+JT/IhWOqLmfZZ0sFrdYHKsHWj9om2G7QPvhKj2R8jkx6LDos
         UPzSrEkfB2au4DDzejkUyOWGPntDZ1yk0cZNxPGWvBX2K8uuG6eC26t32mDw4lXw7B
         TaPPKH9ikiGwQ==
Received: (nullmailer pid 1703202 invoked by uid 1000);
        Fri, 21 Jul 2023 19:51:51 -0000
Date:   Fri, 21 Jul 2023 13:51:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.5, part 1
Message-ID: <20230721195151.GA1691988-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull.

Rob


The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.5-1

for you to fetch changes up to ffc59c6414f9ffd52591786efe3e62e145563deb:

  dt-bindings: serial: Remove obsolete nxp,lpc1850-uart.txt (2023-07-21 13:39:12 -0600)

----------------------------------------------------------------
Devicetree fixes for v6.5:

- Fix moortec,mr75203 schema usage of 'multipleOf' keyword

- Fix regression in systems depending on "of-display" device name

- Build fix for s390 with CONFIG_PCI=n and OF_EARLY_FLATTREE=y

- Drop 2 obsolete serial .txt bindings

----------------------------------------------------------------
Baoquan He (1):
      of: make OF_EARLY_FLATTREE depend on HAS_IOMEM

Krzysztof Kozlowski (1):
      dt-bindings: hwmon: moortec,mr75203: fix multipleOf for coefficients

Rob Herring (3):
      of: Preserve "of-display" device name for compatibility
      dt-bindings: serial: Remove obsolete cavium-uart.txt
      dt-bindings: serial: Remove obsolete nxp,lpc1850-uart.txt

 .../devicetree/bindings/hwmon/moortec,mr75203.yaml |  6 ++---
 .../devicetree/bindings/serial/cavium-uart.txt     | 19 ---------------
 .../bindings/serial/nxp,lpc1850-uart.txt           | 28 ----------------------
 drivers/of/Kconfig                                 |  2 +-
 drivers/of/platform.c                              |  2 +-
 5 files changed, 5 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/cavium-uart.txt
 delete mode 100644 Documentation/devicetree/bindings/serial/nxp,lpc1850-uart.txt
