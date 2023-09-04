Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB73E791D29
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347039AbjIDSfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346213AbjIDSfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:35:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF289CCB;
        Mon,  4 Sep 2023 11:35:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 15337CE0F94;
        Mon,  4 Sep 2023 18:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6D2C433C7;
        Mon,  4 Sep 2023 18:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852536;
        bh=SyuDroYlUjmqAN+iaXoz0BggnRh4MyWDYfMjfzmQwHQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ClGLrqu9WFE+f2UoJPVzQMwIaw6kJfKn7YmtrP8/jmicVgeXRFvjBYGSGSy0SYhZK
         9LXChZ1zwzJuQnjO+8CidrfhHGm6gc2el670KiW6K48SuomnGrTo0iRjpJPTNm5N92
         FrQAbet4iby2abQXpi1Rei/0vmFgJuXO71KrTq4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.1 00/31] 6.1.52-rc1 review
Date:   Mon,  4 Sep 2023 19:30:08 +0100
Message-ID: <20230904182946.999390199@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.52-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.52-rc1
X-KernelTest-Deadline: 2023-09-06T18:29+00:00
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.1.52 release.
There are 31 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.52-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.52-rc1

Mario Limonciello <mario.limonciello@amd.com>
    pinctrl: amd: Don't show `Invalid config param` errors

Marco Felsch <m.felsch@pengutronix.de>
    usb: typec: tcpci: clear the fault status bit

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix WARNING in mark_buffer_dirty due to discarded buffer reuse

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix general protection fault in nilfs_lookup_dirty_data_buffers()

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    dt-bindings: sc16is7xx: Add property to change GPIO function

Badhri Jagan Sridharan <badhri@google.com>
    tcpm: Avoid soft reset when partner does not support get_status

Juerg Haefliger <juerg.haefliger@canonical.com>
    fsi: master-ast-cf: Add MODULE_FIRMWARE macro

Wang Ming <machel@vivo.com>
    firmware: stratix10-svc: Fix an NULL vs IS_ERR() bug in probe

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: fix bug when first setting GPIO direction

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: fix broken port 0 uart init

Johan Hovold <johan+linaro@kernel.org>
    serial: qcom-geni: fix opp vote on shutdown

Deren Wu <deren.wu@mediatek.com>
    wifi: mt76: mt7921: fix skb leak by txs missing in AMSDU

Deren Wu <deren.wu@mediatek.com>
    wifi: mt76: mt7921: do not support one stream on secondary antenna only

Zheng Wang <zyytlz.wz@163.com>
    Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition

Nam Cao <namcaov@gmail.com>
    staging: rtl8712: fix race condition

Aaron Armstrong Skomra <aaron.skomra@wacom.com>
    HID: wacom: remove the battery when the EKR is off

Xu Yang <xu.yang_2@nxp.com>
    usb: chipidea: imx: improve logic if samsung,picophy-* parameter is 0

Luke Lu <luke.lu@libre.computer>
    usb: dwc3: meson-g12a: do post init to fix broken usb after resumption

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Fix init call orders for UAC1

Slark Xiao <slark_xiao@163.com>
    USB: serial: option: add FOXCONN T99W368/T99W373 product

Martin Kohn <m.kohn@welotec.com>
    USB: serial: option: add Quectel EM05G variant (0x030e)

Christoph Hellwig <hch@lst.de>
    modules: only allow symbol_get of EXPORT_SYMBOL_GPL modules

Christoph Hellwig <hch@lst.de>
    rtc: ds1685: use EXPORT_SYMBOL_GPL for ds1685_rtc_poweroff

Christoph Hellwig <hch@lst.de>
    net: enetc: use EXPORT_SYMBOL_GPL for enetc_phc_index

Christoph Hellwig <hch@lst.de>
    mmc: au1xmmc: force non-modular build and remove symbol_get usage

Arnd Bergmann <arnd@arndb.de>
    ARM: pxa: remove use of symbol_get()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: reduce descriptor size if remaining bytes is less than request size

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: replace one-element array with flex-array member in struct smb2_ea_info

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix slub overflow in ksmbd_decode_ntlmssp_auth_blob()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix wrong DataOffset validation of create context

Gao Xiang <xiang@kernel.org>
    erofs: ensure that the post-EOF tails are all zeroed


-------------

Diffstat:

 .../devicetree/bindings/serial/nxp,sc16is7xx.txt   | 46 ++++++++++++++++++++++
 Makefile                                           |  4 +-
 arch/arm/mach-pxa/sharpsl_pm.c                     |  2 -
 arch/arm/mach-pxa/spitz.c                          | 14 +------
 arch/mips/alchemy/devboards/db1000.c               |  8 +---
 arch/mips/alchemy/devboards/db1200.c               | 19 +--------
 arch/mips/alchemy/devboards/db1300.c               | 10 +----
 drivers/bluetooth/btsdio.c                         |  1 +
 drivers/firmware/stratix10-svc.c                   |  2 +-
 drivers/fsi/fsi-master-ast-cf.c                    |  1 +
 drivers/hid/wacom.h                                |  1 +
 drivers/hid/wacom_sys.c                            | 25 ++++++++++--
 drivers/hid/wacom_wac.c                            |  1 +
 drivers/hid/wacom_wac.h                            |  1 +
 drivers/mmc/host/Kconfig                           |  5 ++-
 drivers/net/ethernet/freescale/enetc/enetc_ptp.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |  7 +++-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |  2 +-
 drivers/pinctrl/pinctrl-amd.c                      |  4 +-
 drivers/rtc/rtc-ds1685.c                           |  2 +-
 drivers/staging/rtl8712/os_intfs.c                 |  1 +
 drivers/staging/rtl8712/usb_intf.c                 |  1 -
 drivers/tty/serial/qcom_geni_serial.c              |  5 +++
 drivers/tty/serial/sc16is7xx.c                     | 17 +++++++-
 drivers/usb/chipidea/ci_hdrc_imx.c                 | 10 +++--
 drivers/usb/chipidea/usbmisc_imx.c                 |  6 ++-
 drivers/usb/dwc3/dwc3-meson-g12a.c                 |  6 +++
 drivers/usb/serial/option.c                        |  7 ++++
 drivers/usb/typec/tcpm/tcpci.c                     |  4 ++
 drivers/usb/typec/tcpm/tcpm.c                      |  7 ++++
 fs/erofs/zdata.c                                   |  2 +
 fs/nilfs2/alloc.c                                  |  3 +-
 fs/nilfs2/inode.c                                  |  7 +++-
 fs/nilfs2/segment.c                                |  5 +++
 fs/smb/server/auth.c                               |  3 ++
 fs/smb/server/oplock.c                             |  2 +-
 fs/smb/server/smb2pdu.c                            |  2 +-
 fs/smb/server/smb2pdu.h                            |  2 +-
 fs/smb/server/transport_rdma.c                     | 25 ++++++++----
 include/linux/usb/tcpci.h                          |  1 +
 kernel/module/main.c                               | 14 +++++--
 sound/usb/stream.c                                 | 11 +++++-
 42 files changed, 209 insertions(+), 89 deletions(-)


