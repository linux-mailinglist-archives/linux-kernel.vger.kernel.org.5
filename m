Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0363F791D33
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348880AbjIDSgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347179AbjIDSgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:36:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC97CFE;
        Mon,  4 Sep 2023 11:36:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B606613F9;
        Mon,  4 Sep 2023 18:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52731C433C7;
        Mon,  4 Sep 2023 18:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852563;
        bh=l/KPecKtauHEtBB6qvvKiBE03LXGlPDHRMq4eTWol3M=;
        h=From:To:Cc:Subject:Date:From;
        b=hNY916sdcJqNXNLz1iDSXZwPTirnLVyOA8qZUf1R5Ou3KorgXmrvhxasoLKaVe6zQ
         YEMLkWFka/8xJg7tvQnvbfhagpr2pOlKPDGYBv76ih0cfHXjVFCc6i1JbFyTg0wx6U
         7q1E7UyRh23CdpyLlyaT74hbaFVLeBuKSj8bknHE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.15 00/28] 5.15.131-rc1 review
Date:   Mon,  4 Sep 2023 19:30:31 +0100
Message-ID: <20230904182945.178705038@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.131-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.131-rc1
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

This is the start of the stable review cycle for the 5.15.131 release.
There are 28 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.131-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.131-rc1

Marco Felsch <m.felsch@pengutronix.de>
    usb: typec: tcpci: clear the fault status bit

Xin Ji <xji@analogixsemi.com>
    usb: typec: tcpci: move tcpci.h to include/linux/usb/

Mario Limonciello <mario.limonciello@amd.com>
    pinctrl: amd: Don't show `Invalid config param` errors

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix WARNING in mark_buffer_dirty due to discarded buffer reuse

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix general protection fault in nilfs_lookup_dirty_data_buffers()

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
    ksmbd: replace one-element array with flex-array member in struct smb2_ea_info

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix wrong DataOffset validation of create context

Gao Xiang <hsiangkao@linux.alibaba.com>
    erofs: ensure that the post-EOF tails are all zeroed


-------------

Diffstat:

 Makefile                                           |  4 ++--
 arch/arm/mach-pxa/sharpsl_pm.c                     |  2 --
 arch/arm/mach-pxa/spitz.c                          | 14 +-----------
 arch/mips/alchemy/devboards/db1000.c               |  8 +------
 arch/mips/alchemy/devboards/db1200.c               | 19 ++--------------
 arch/mips/alchemy/devboards/db1300.c               | 10 +--------
 drivers/bluetooth/btsdio.c                         |  1 +
 drivers/firmware/stratix10-svc.c                   |  2 +-
 drivers/fsi/fsi-master-ast-cf.c                    |  1 +
 drivers/hid/wacom.h                                |  1 +
 drivers/hid/wacom_sys.c                            | 25 ++++++++++++++++++----
 drivers/hid/wacom_wac.c                            |  1 +
 drivers/hid/wacom_wac.h                            |  1 +
 drivers/mmc/host/Kconfig                           |  5 +++--
 drivers/net/ethernet/freescale/enetc/enetc_ptp.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |  2 +-
 drivers/pinctrl/pinctrl-amd.c                      |  4 ++--
 drivers/rtc/rtc-ds1685.c                           |  2 +-
 drivers/staging/rtl8712/os_intfs.c                 |  1 +
 drivers/staging/rtl8712/usb_intf.c                 |  1 -
 drivers/tty/serial/qcom_geni_serial.c              |  5 +++++
 drivers/tty/serial/sc16is7xx.c                     | 17 ++++++++++++++-
 drivers/usb/chipidea/ci_hdrc_imx.c                 | 10 +++++----
 drivers/usb/chipidea/usbmisc_imx.c                 |  6 ++++--
 drivers/usb/dwc3/dwc3-meson-g12a.c                 |  6 ++++++
 drivers/usb/serial/option.c                        |  7 ++++++
 drivers/usb/typec/tcpm/tcpci.c                     |  7 ++++--
 drivers/usb/typec/tcpm/tcpci_maxim.c               |  3 +--
 drivers/usb/typec/tcpm/tcpci_mt6360.c              |  3 +--
 drivers/usb/typec/tcpm/tcpci_rt1711h.c             |  2 +-
 drivers/usb/typec/tcpm/tcpm.c                      |  7 ++++++
 fs/erofs/zdata.c                                   |  2 ++
 fs/ksmbd/oplock.c                                  |  2 +-
 fs/ksmbd/smb2pdu.c                                 |  2 +-
 fs/ksmbd/smb2pdu.h                                 |  2 +-
 fs/nilfs2/alloc.c                                  |  3 ++-
 fs/nilfs2/inode.c                                  |  7 ++++--
 fs/nilfs2/segment.c                                |  5 +++++
 .../usb/typec/tcpm => include/linux/usb}/tcpci.h   |  2 ++
 kernel/module.c                                    | 14 +++++++++---
 sound/usb/stream.c                                 | 11 +++++++++-
 41 files changed, 142 insertions(+), 87 deletions(-)


