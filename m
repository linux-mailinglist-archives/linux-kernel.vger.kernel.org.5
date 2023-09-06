Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5637944AC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244554AbjIFUiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244528AbjIFUi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:38:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8671BFE;
        Wed,  6 Sep 2023 13:38:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFE8C433C7;
        Wed,  6 Sep 2023 20:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694032687;
        bh=n2CVMsYvahBga4Qf/ilIlwZNypiJhCVDeNZJ6gNwcmU=;
        h=From:To:Cc:Subject:Date:From;
        b=lSUTkliDTvebekvZtUaLHh4zl3iEi1rKz7RN14M+Ic/UCEcsl+BjjupTmGVfzfnmP
         57EHFgzEwMFEwc5clemohfvm3EZQXsFYge7J1/CdypU+LKEEqJgHKqITeMBW/zcTA/
         EttDk2sJHcYPtiqB4gDu3j8Vc7V0mBZHQLMDTE9k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.52
Date:   Wed,  6 Sep 2023 21:37:59 +0100
Message-ID: <2023090600-arena-unvented-8658@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.1.52 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt |   46 +++++++++++++
 Makefile                                                   |    2 
 arch/arm/mach-pxa/sharpsl_pm.c                             |    2 
 arch/arm/mach-pxa/spitz.c                                  |   14 ---
 arch/mips/alchemy/devboards/db1000.c                       |    8 --
 arch/mips/alchemy/devboards/db1200.c                       |   19 -----
 arch/mips/alchemy/devboards/db1300.c                       |   10 --
 drivers/bluetooth/btsdio.c                                 |    1 
 drivers/firmware/stratix10-svc.c                           |    2 
 drivers/fsi/fsi-master-ast-cf.c                            |    1 
 drivers/hid/wacom.h                                        |    1 
 drivers/hid/wacom_sys.c                                    |   25 +++++--
 drivers/hid/wacom_wac.c                                    |    1 
 drivers/hid/wacom_wac.h                                    |    1 
 drivers/mmc/host/Kconfig                                   |    5 -
 drivers/net/ethernet/freescale/enetc/enetc_ptp.c           |    2 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c       |    7 +
 drivers/net/wireless/mediatek/mt76/mt7921/main.c           |    2 
 drivers/pinctrl/pinctrl-amd.c                              |    4 -
 drivers/rtc/rtc-ds1685.c                                   |    2 
 drivers/staging/rtl8712/os_intfs.c                         |    1 
 drivers/staging/rtl8712/usb_intf.c                         |    1 
 drivers/tty/serial/qcom_geni_serial.c                      |    5 +
 drivers/tty/serial/sc16is7xx.c                             |   17 ++++
 drivers/usb/chipidea/ci_hdrc_imx.c                         |   10 +-
 drivers/usb/chipidea/usbmisc_imx.c                         |    6 +
 drivers/usb/dwc3/dwc3-meson-g12a.c                         |    6 +
 drivers/usb/serial/option.c                                |    7 +
 drivers/usb/typec/tcpm/tcpci.c                             |    4 +
 drivers/usb/typec/tcpm/tcpm.c                              |    7 +
 fs/erofs/zdata.c                                           |    2 
 fs/nilfs2/alloc.c                                          |    3 
 fs/nilfs2/inode.c                                          |    7 +
 fs/nilfs2/segment.c                                        |    5 +
 fs/smb/server/auth.c                                       |    3 
 fs/smb/server/oplock.c                                     |    2 
 fs/smb/server/smb2pdu.c                                    |    2 
 fs/smb/server/smb2pdu.h                                    |    2 
 fs/smb/server/transport_rdma.c                             |   25 +++++--
 include/linux/usb/tcpci.h                                  |    1 
 kernel/module/main.c                                       |   14 +++
 sound/usb/stream.c                                         |   11 ++-
 42 files changed, 208 insertions(+), 88 deletions(-)

Aaron Armstrong Skomra (1):
      HID: wacom: remove the battery when the EKR is off

Arnd Bergmann (1):
      ARM: pxa: remove use of symbol_get()

Badhri Jagan Sridharan (1):
      tcpm: Avoid soft reset when partner does not support get_status

Christoph Hellwig (4):
      mmc: au1xmmc: force non-modular build and remove symbol_get usage
      net: enetc: use EXPORT_SYMBOL_GPL for enetc_phc_index
      rtc: ds1685: use EXPORT_SYMBOL_GPL for ds1685_rtc_poweroff
      modules: only allow symbol_get of EXPORT_SYMBOL_GPL modules

Deren Wu (2):
      wifi: mt76: mt7921: do not support one stream on secondary antenna only
      wifi: mt76: mt7921: fix skb leak by txs missing in AMSDU

Gao Xiang (1):
      erofs: ensure that the post-EOF tails are all zeroed

Greg Kroah-Hartman (1):
      Linux 6.1.52

Hugo Villeneuve (3):
      serial: sc16is7xx: fix broken port 0 uart init
      serial: sc16is7xx: fix bug when first setting GPIO direction
      dt-bindings: sc16is7xx: Add property to change GPIO function

Johan Hovold (1):
      serial: qcom-geni: fix opp vote on shutdown

Juerg Haefliger (1):
      fsi: master-ast-cf: Add MODULE_FIRMWARE macro

Luke Lu (1):
      usb: dwc3: meson-g12a: do post init to fix broken usb after resumption

Marco Felsch (1):
      usb: typec: tcpci: clear the fault status bit

Mario Limonciello (1):
      pinctrl: amd: Don't show `Invalid config param` errors

Martin Kohn (1):
      USB: serial: option: add Quectel EM05G variant (0x030e)

Nam Cao (1):
      staging: rtl8712: fix race condition

Namjae Jeon (4):
      ksmbd: fix wrong DataOffset validation of create context
      ksmbd: fix slub overflow in ksmbd_decode_ntlmssp_auth_blob()
      ksmbd: replace one-element array with flex-array member in struct smb2_ea_info
      ksmbd: reduce descriptor size if remaining bytes is less than request size

Ryusuke Konishi (2):
      nilfs2: fix general protection fault in nilfs_lookup_dirty_data_buffers()
      nilfs2: fix WARNING in mark_buffer_dirty due to discarded buffer reuse

Slark Xiao (1):
      USB: serial: option: add FOXCONN T99W368/T99W373 product

Takashi Iwai (1):
      ALSA: usb-audio: Fix init call orders for UAC1

Wang Ming (1):
      firmware: stratix10-svc: Fix an NULL vs IS_ERR() bug in probe

Xu Yang (1):
      usb: chipidea: imx: improve logic if samsung,picophy-* parameter is 0

Zheng Wang (1):
      Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition

