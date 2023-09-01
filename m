Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6697C78FFD3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242656AbjIAPUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjIAPUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:20:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9733810CF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:19:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 92716CE23ED
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 15:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A114C433C7;
        Fri,  1 Sep 2023 15:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693581596;
        bh=Vr39c6ybHrlNAtzikh0fL2MNkVG4l2JUPS1/0OKzqFA=;
        h=Date:From:To:Cc:Subject:From;
        b=iPyjsele9zShCizyzTRNQgCt4YO/OiYNkuvkSdETC39F61gfEO94owGFkj6lnAnog
         Fek+nbEQIlpMOTi06dxReK6uF+n7wCRSkDil1w64lXh4JkxXRg6NybPw7PaABwejdS
         vxqEm9PVcnu8MrtuC5i95QrMZrwZdCSAiauQZBwM=
Date:   Fri, 1 Sep 2023 17:19:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver updates for 6.6-rc1
Message-ID: <ZPIBGeHW4W8GQgui@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
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

The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.6-rc1

for you to fetch changes up to aee17df05ea3771cb74662430dc98e69b72ab9f3:

  staging: rtl8192e: Annotate struct rtllib_txb with __counted_by (2023-08-22 15:48:05 +0200)

----------------------------------------------------------------
Staging driver changes for 6.6-rc1

Here are a set of staging driver cleanups for 6.6-rc1.  Nothing huge in
here at all, overall we dropped a few hundred lines of code, it's been a
quiet development cycle for this subsystem.

Nothing stands out, everything can be categorized as "minor coding style
cleanups for staging drivers" and there was one race condition fixed.

Full details in the shortlog.

All have been in linux-next for a while with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abdel Alkuor (1):
      staging: sm750fb: fix sii164InitChip function name

Alexon Oliveira (4):
      staging: vme_user: fix check alignment should match open parenthesis
      staging: vme_user: fix alignment of open parenthesis
      staging: vme_user: fix check blank lines not necessary
      staging: vme_user: fix check lines should not end with a '('

Cyrus Ramavarapu (1):
      staging: rts5208: Correct line ending with '('

Franziska Naepelt (12):
      staging: rtl8723bs: Fix space issues
      staging: rtl8723bs: Fix alignment open parenthesis
      staging: rtl8723bs: Fix remaining blank line issue
      staging: rtl8723bs: ioctl_linux: Fix else on next line
      staging: rtl8723bs: ioctl_linux: Fix code indent
      staging: rtl8723bs: ioctl_linux: Fix block comment alignment
      staging: rtl8723bs: ioctl_linux: Remove multiple blank lines
      staging: rtl8723bs: ioctl_linux: Remove unnecessary blank lines
      staging: rtl8723bs: ioctl_linux: Remove unnecessary parentheses
      staging: rtl8723bs: ioctl_linux: Fix alignment on open parenthesis
      staging: rtl8723bs: ioctl_linux: Add preferred spaces
      staging: rtl8723bs: ioctl_linux: Fix comparison to false

Greg Kroah-Hartman (1):
      Merge 6.5-rc4 into staging-next

Kees Cook (1):
      staging: rtl8192e: Annotate struct rtllib_txb with __counted_by

Mingzai Sun (1):
      staging: vt6655: Change camel case variables to snake case

Nam Cao (1):
      staging: rtl8712: fix race condition

Pavan Bobba (1):
      staging: vt6655: replace camel case by snake case

Philipp Hortmann (25):
      staging: rtl8192e: Remove unused timer SetupTimer
      staging: rtl8192e: Remove equation of local variable InactTime of AdmitTS
      staging: rtl8192e: Remove unused timer InactTimer
      staging: rtl8192e: Remove empty function AdmitTS
      staging: rtl8192e: Remove variable modulation as it is constant
      staging: rtl8192e: Remove variable host_encrypt as it is constant
      staging: rtl8192e: Remove variable host_decrypt as it is constant
      staging: rtl8192e: Remove variable card_type
      staging: rtl8192e: Remove variable bdisable_nic
      staging: rtl8192e: Remove variable priv->reg_chnl_plan
      staging: rtl8192e: Remove variable ieee->short_slot
      staging: rtl8192e: Remove unused variable p_intb
      staging: rtl8192e: Remove unused variable intb in _rtl92e_irq()
      staging: rtl8192e: Remove empty function rtllib_rx_Master()
      staging: rtl8192e: Remove empty function rtllib_rx_Mesh()
      staging: rtl8192e: Remove unused variable is_mesh from rtllib_send_probe
      staging: rtl8192e: Remove is_mesh from rtllib_send_probe_requests
      staging: rtl8192e: Remove is_mesh from rtllib_start_scan_syncro
      staging: rtl8192e: Remove is_mesh from rtllib_softmac_scan_syncro
      staging: rtl8192e: Remove is_mesh from rtl92e_set_swcam
      staging: rtl8192e: Remove DefaultKey from rtl92e_set_swcam
      staging: rtl8192e: Remove unsupported mode IW_MODE_MASTER
      staging: rtl8192e: Remove unused function rtllib_start_master_bss()
      staging: rtl8192e: Remove unsupported mode IW_MODE_REPEAT
      staging: rtl8192e: Remove unsupported mode IW_MODE_MESH

Rob Herring (1):
      staging: Explicitly include correct DT includes

Rohit Chavan (1):
      staging: greybus: fix alignment of open parenthesis

Ruan Jinjie (2):
      staging: fieldbus: arcx-anybus: Remove redundant of_match_ptr()
      staging: rtl8723bs: Use helpers to check broadcast and multicast Ether addresses

Tree Davies (10):
      Staging: rtl8192e: Rename function ActivateBAEntry
      Staging: rtl8192e: Rename function DeActivateBAEntry
      Staging: rtl8192e: Rename function TxTsDeleteBA
      Staging: rtl8192e: Rename function RxTsDeleteBA
      Staging: rtl8192e: Rename function ResetBaEntry
      Staging: rtl8192e: Rename function TsInitAddBA
      Staging: rtl8192e: Rename function TsInitDelBA
      Staging: rtl8192e: Rename function BaSetupTimeOut
      Staging: rtl8192e: Rename function TxBaInactTimeout
      Staging: rtl8192e: Rename function RxBaInactTimeout

Uwe Kleine-König (1):
      staging: greybus: pwm: Drop unused member from driver struct

Wang Jinchao (1):
      staging: rtl8192u: Fix keyidx assignment within if condition

Yang Yingliang (2):
      staging: rtl8723bs: use is_zero_ether_addr() instead of memcmp()
      staging: rtl8723bs: use is_broadcast_ether_addr() instead of memcmp()

Yangtao Li (1):
      staging: axis-fifo: Use devm_platform_get_and_ioremap_resource()

Yogesh Hegde (4):
      staging: rtl8192e: Rename variable currentRATR
      staging: rtl8192e: Rename variable targetRATR
      staging: rtl8192e: Rename variable LowRSSIThreshForRA
      staging: rtl8192e: Rename variable HighRSSIThreshForRA

Zhu Wang (1):
      staging: fieldbus: arcx-anybus: Do not check 0 for platform_get_irq()

 drivers/staging/axis-fifo/axis-fifo.c             |  18 +-
 drivers/staging/fieldbus/anybuss/arcx-anybus.c    |   6 +-
 drivers/staging/greybus/arche-platform.c          |   1 +
 drivers/staging/greybus/fw-core.c                 |   4 +-
 drivers/staging/greybus/pwm.c                     |   1 -
 drivers/staging/media/imx/imx-media-capture.c     |   1 -
 drivers/staging/media/imx/imx-media-dev-common.c  |   2 -
 drivers/staging/media/imx/imx8mq-mipi-csi2.c      |   1 -
 drivers/staging/media/meson/vdec/esparser.c       |   1 -
 drivers/staging/media/meson/vdec/vdec.c           |   2 +-
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c    |   2 +-
 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c |   1 -
 drivers/staging/media/tegra-video/csi.c           |   1 -
 drivers/staging/media/tegra-video/vi.c            |   2 +-
 drivers/staging/media/tegra-video/vip.c           |   1 -
 drivers/staging/most/dim2/dim2.c                  |   2 +-
 drivers/staging/pi433/pi433_if.c                  |   1 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c    |  11 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h    |   2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c       |  17 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.h       |   3 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c      |  25 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h      |   8 -
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c        |  38 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c        |   6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c        |  12 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c         |  60 ++--
 drivers/staging/rtl8192e/rtl819x_HTProc.c         |   3 +-
 drivers/staging/rtl8192e/rtl819x_TS.h             |   2 -
 drivers/staging/rtl8192e/rtl819x_TSProc.c         |  65 +---
 drivers/staging/rtl8192e/rtllib.h                 |  32 +-
 drivers/staging/rtl8192e/rtllib_module.c          |   3 -
 drivers/staging/rtl8192e/rtllib_rx.c              |  84 ++----
 drivers/staging/rtl8192e/rtllib_softmac.c         | 346 ++++------------------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c      |  17 +-
 drivers/staging/rtl8192e/rtllib_tx.c              |   5 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c |  10 +-
 drivers/staging/rtl8712/os_intfs.c                |   1 +
 drivers/staging/rtl8712/usb_intf.c                |   1 -
 drivers/staging/rtl8723bs/core/rtw_ap.c           |   3 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c         |   5 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c     |   6 +-
 drivers/staging/rtl8723bs/core/rtw_recv.c         |  36 +--
 drivers/staging/rtl8723bs/core/rtw_security.c     |   8 +-
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c      |   2 +-
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c    |   6 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c         |  12 +-
 drivers/staging/rtl8723bs/hal/hal_intf.c          |   2 +-
 drivers/staging/rtl8723bs/hal/odm.c               |   4 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c |   2 +-
 drivers/staging/rtl8723bs/include/wifi.h          |  15 -
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 167 ++++++-----
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c    | 161 ++++------
 drivers/staging/rtl8723bs/os_dep/recv_linux.c     |   2 +-
 drivers/staging/rts5208/sd.c                      |   3 +-
 drivers/staging/sm750fb/ddk750_dvi.c              |   2 +-
 drivers/staging/sm750fb/ddk750_sii164.c           |  22 +-
 drivers/staging/sm750fb/ddk750_sii164.h           |  20 +-
 drivers/staging/vme_user/vme.c                    |  92 +++---
 drivers/staging/vme_user/vme_bridge.h             |  46 ++-
 drivers/staging/vt6655/baseband.c                 |   6 +-
 drivers/staging/vt6655/srom.c                     |   6 +-
 62 files changed, 486 insertions(+), 940 deletions(-)
