Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20137684EB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 13:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjG3LIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 07:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjG3LIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 07:08:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDF910F9;
        Sun, 30 Jul 2023 04:08:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23A1D60BDB;
        Sun, 30 Jul 2023 11:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3937FC433C8;
        Sun, 30 Jul 2023 11:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690715298;
        bh=zFtr/qSjz1K1/AwbVxZlzBao3UbNyqHarZ6tdCqs6Po=;
        h=Date:From:To:Cc:Subject:From;
        b=H2x6abNzpd6UH/XV6W4dWVZMYnVoQK0P/xPnLJjUmkayboEr8AGteWV7nhIhQ/y0m
         3pwiq/bjc4DlyZtXfzLd1ZlxE9JSFijhGhQXUvqknnWYDho0xyp/yT0BcgUNx3VmLA
         7X8GFxGh9be3lL7OXLF0Md4ctQEGik8Xy7WjjF/w=
Date:   Sun, 30 Jul 2023 13:08:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.5-rc4
Message-ID: <ZMZEoJr2cPzC-Pss@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.5-rc4

for you to fetch changes up to 7f2327666a9080e428166964e37548b0168cd5e9:

  usb: misc: ehset: fix wrong if condition (2023-07-27 10:37:30 +0200)

----------------------------------------------------------------
USB fixes for 6.5-rc4

Here are a set of USB driver fixes for 6.5-rc4.  Include in here are:
  - new USB serial device ids
  - dwc3 driver fixes for reported issues
  - typec driver fixes for reported problems
  - gadget driver fixes
  - reverts of some problematic USB changes that went into -rc1

All of these have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dan Carpenter (2):
      Revert "usb: xhci: tegra: Fix error check"
      Revert "usb: gadget: tegra-xudc: Fix error check in tegra_xudc_powerdomain_init()"

Frank Li (2):
      usb: gadget: call usb_gadget_check_config() to verify UDC capability
      usb: cdns3: fix incorrect calculation of ep_buf_size when more than one config

Gratian Crisan (1):
      usb: dwc3: pci: skip BYT GPIO lookup table for hardwired phy

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-6.5-rc4' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Guiting Shen (1):
      usb: ohci-at91: Fix the unhandle interrupt when resume

Jakub Vanek (1):
      Revert "usb: dwc3: core: Enable AutoRetry feature in the controller"

Jerry Meng (1):
      USB: serial: option: support Quectel EM060K_128

Jisheng Zhang (1):
      usb: dwc3: don't reset device side if dwc3 was configured as host-only

Johan Hovold (1):
      USB: serial: simple: sort driver entries

Kyle Tso (3):
      usb: typec: Set port->pd before adding device for typec_port
      usb: typec: Iterate pds array when showing the pd list
      usb: typec: Use sysfs_emit_at when concatenating the string

Michael Grzeschik (1):
      usb: gadget: core: remove unbalanced mutex_unlock in usb_gadget_activate

Mohsen Tahmasebi (1):
      USB: serial: option: add Quectel EC200A module support

Neil Armstrong (1):
      usb: typec: ucsi: move typec_set_mode(TYPEC_STATE_SAFE) to ucsi_unregister_partner()

Oliver Neukum (2):
      USB: serial: simple: add Kaufmann RKS+CAN VCP
      Revert "xhci: add quirk for host controllers that don't update endpoint DCS"

Ricardo Ribalda (1):
      usb: xhci-mtk: set the dma max_seg_size

Roger Quadros (1):
      MAINTAINERS: drop invalid usb/cdns3 Reviewer e-mail

Xu Yang (1):
      usb: misc: ehset: fix wrong if condition

Yang Yingliang (1):
      usb: typec: qcom: fix return value check in qcom_pmic_typec_probe()

Zqiang (1):
      USB: gadget: Fix the memory leak in raw_gadget driver

Łukasz Bartosik (1):
      USB: quirks: add quirk for Focusrite Scarlett

 MAINTAINERS                                   |  1 -
 drivers/usb/cdns3/cdns3-gadget.c              |  4 +-
 drivers/usb/core/quirks.c                     |  4 ++
 drivers/usb/dwc3/core.c                       | 20 +-------
 drivers/usb/dwc3/core.h                       |  3 --
 drivers/usb/dwc3/dwc3-pci.c                   |  6 ++-
 drivers/usb/gadget/composite.c                |  4 ++
 drivers/usb/gadget/legacy/raw_gadget.c        | 10 ++--
 drivers/usb/gadget/udc/core.c                 |  1 -
 drivers/usb/gadget/udc/tegra-xudc.c           |  8 +--
 drivers/usb/host/ohci-at91.c                  |  8 ++-
 drivers/usb/host/xhci-mtk.c                   |  1 +
 drivers/usb/host/xhci-pci.c                   |  4 +-
 drivers/usb/host/xhci-ring.c                  | 25 +--------
 drivers/usb/host/xhci-tegra.c                 |  8 +--
 drivers/usb/misc/ehset.c                      |  8 +--
 drivers/usb/serial/option.c                   |  6 +++
 drivers/usb/serial/usb-serial-simple.c        | 73 +++++++++++++++------------
 drivers/usb/typec/class.c                     | 15 +++---
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c |  4 +-
 drivers/usb/typec/ucsi/ucsi.c                 |  4 +-
 21 files changed, 103 insertions(+), 114 deletions(-)
