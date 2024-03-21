Return-Path: <linux-kernel+bounces-110065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C26D885984
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A572822A9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CD974E05;
	Thu, 21 Mar 2024 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VWV9re48"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95E783CCE;
	Thu, 21 Mar 2024 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026100; cv=none; b=f2Jg7gjGwoStCQOYXdh5chfBLa2Pvapv6vFwVsTihvihGq0X6/CvwlBL7aF+bapAqm+X4WBiRLY/UdaUPeQj5mylfpz4NTU7vE74iyr2kLwmjcWPSP6NFIMQCewe/dUvwRs2MCpT/KktX06MGj0xovuESAHSJEqzTBvm/DbwCug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026100; c=relaxed/simple;
	bh=1tjUQe6eS6hPTgoewZ3zPpyZkfJqprwJqK2fvHDOGjA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T/7DU1oAfMnEqPBlGhVrjo7iypAuw9Us21ktzBA/Qmo2p7H2gK5IsNoRVDUUcWtEaHTGTgfWFZBZgef/AP1emCBWWalmThzgkTBrcYSD4BoO4lieOfnIi8vkNC9nUO9azxG1fmF7uWnpCct7BszgGjpqajAwBtESHwE2/K+6qqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VWV9re48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2689C433C7;
	Thu, 21 Mar 2024 13:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711026099;
	bh=1tjUQe6eS6hPTgoewZ3zPpyZkfJqprwJqK2fvHDOGjA=;
	h=Date:From:To:Cc:Subject:From;
	b=VWV9re48aS2VA+wkv62dmu1FLhrBZsug1efTVLOC2H5XIisl1Qb6ALfyHQ/Nd2Hrk
	 Vam9tQ81+6/Ou1QDldZQHK6g21wQIWgI08P5VGXms89y07UODv8Oi8Fy8N7jQR1TIb
	 EZXoVqSOE5WbDLHTH0KbjlZhuUuPjTAlRyUlSxhs=
Date: Thu, 21 Mar 2024 14:01:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver updates for 6.9-rc1
Message-ID: <ZfwvsKB20azzCoYR@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.9-rc1

for you to fetch changes up to 68bb540b1aefded1d58a9f956568d5316643d291:

  staging: greybus: Replaces directive __attribute__((packed)) by __packed as suggested by checkpatch (2024-03-07 21:40:52 +0000)

----------------------------------------------------------------
Staging driver cleanups for 6.9-rc1

Here is the big set of Staging driver cleanups for 6.9-rc1.  Nothing
major in here, lots of small coding style cleanups for most drivers, and
the removal of some obsolete hardare (the emxx_udc and some
drivers/staging/board/ files).

All of these have been in linux-next for a long time with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Christophe JAILLET (3):
      staging: greybus: Remove usage of the deprecated ida_simple_xx() API
      staging: fieldbus: Remove usage of the deprecated ida_simple_xx() API
      staging: axis-fifo: Use sysfs_emit()

Colin Ian King (3):
      staging: greybus: Remove redundant variable 'mask'
      staging: rtl8723bs: remove redundant variable hoffset
      staging: fbtft: remove unused variable 'count'

Dan Carpenter (1):
      staging: greybus: fix get_channel_from_mode() failure path

Dorine Tipo (1):
      Staging: octeon: Match parenthesis alignment

Erick Archer (2):
      staging: rtl8723bs: Use kcalloc() instead of kzalloc()
      greybus: audio: apbridgea: Remove flexible array from struct audio_apbridgea_hdr

Geert Uytterhoeven (4):
      staging: emxx_udc: Remove EMMA Mobile USB Gadget driver
      staging: board: Remove KZM9D board staging code
      staging: board: Remove Armadillo-800-EVA board staging code
      staging: Remove board staging code

Greg Kroah-Hartman (1):
      staging: greybus: gbphy: make gbphy_bus_type const

Hoorad Farrokh (1):
      staging: rtl8712: remove unnecessary braces in while loop

John Garry (1):
      staging: octeon: Don't bother filling in ethtool driver version

Jonathan Bergh (3):
      staging: vme_user: Fix misaligned closing comment */
      staging: greybus: Replace __attribute__((packed)) by __packed in various instances
      staging: greybus: Replaces directive __attribute__((packed)) by __packed as suggested by checkpatch

Kees Cook (1):
      greybus: Avoid fake flexible array for response data

Marc Dietrich (2):
      staging/nvec: update comment regarding udelay in the isr
      staging/nvec: update TODO

Matthias Yee (1):
      staging: vt6655: fix open parentheses alignment

Meir Elisha (3):
      Staging: rtl8723bs: rtw_ieee80211: Remove extra space
      Staging: rtl8723bs: Remove unnecessary braces in rtw_update_ht_cap
      Staging: rtl8723bs: Remove dead code from _rtw_free_network()

Michael Straube (7):
      staging: rtl8192e: remove return statement from void function
      staging: rtl8192e: remove braces from single statement blocks
      staging: rtl8192e: remove return from void function rtl92e_set_channel
      staging: rtl8192e: initialize variables at declaration
      staging: rtl8192e: rename rateIndex to rate_index
      staging: rtl8192e: remove empty cases from switch statements
      staging: rtl8192e: rename enum members to upper case

Moritz C. Weber (2):
      Staging: vc04_services: bcm2835-camera: fix blank line style check
      Staging: vc04_services: bcm2835-camera: fix brace code style check

Philipp Hortmann (8):
      staging: rtl8192e: Remove variables tsf, beacon_time and Antenna
      staging: rtl8192e: Remove variables Wakeup, Reserved0 and AGC
      staging: rtl8192e: Remove unused variable bShift
      staging: rtl8192e: Remove variables bIsQosData and RxIs40MHzPacket
      staging: rtl8192e: Remove variables fraglength and packetlength
      staging: rtl8192e: Remove unused variables nic_type and RxPower
      staging: rtl8192e: Remove unused variables bShortPreamble and fragoffset
      staging: rtl8192e: Remove unused variables ntotalfrag and Seq_Num

Pranav Athreya (1):
      staging: vt6655: Remove extra blank lines between code blocks

Ricardo B. Marliere (5):
      staging: fieldbus: make anybus_bus const
      staging: vc04_services: vchiq_arm: make vchiq_bus_type const
      staging: vme: make vme_bus_type const
      staging: gdm724x: constantify the struct device_type usage
      staging: fieldbus: make fieldbus_class constant

Shahar Avidar (5):
      staging: pi433: Remove a duplicated FIFO_SIZE define
      staging: pi433: Remove a duplicated F_OSC define
      staging: pi433: Redefine F_OSC using units.h macro
      staging: pi433: Remove the unused FREQUENCY define
      staging: pi433: Move FIFO_THRESHOLD define to source file

Tree Davies (67):
      Staging: rtl8192e: Remove unnecessary parenthesis in rtllib_softmac_new_net()
      Staging: rtl8192e: Rename variable SlotIndex
      Staging: rtl8192e: Rename function rtllib_MgntDisconnectAP()
      Staging: rtl8192e: Rename variable bMulticast
      Staging: rtl8192e: Rename variable MaxPeriod
      Staging: rtl8192e: Rename variable bAwakePktSent
      Staging: rtl8192e: Rename variable bSupportNmode
      Staging: rtl8192e: Rename variable bBusyTraffic
      Staging: rtl8192e: Rename function rtllib_MgntDisconnect()
      Staging: rtl8192e: Rename variable bFilterOutNonAssociatedBSSID
      Staging: rtl8192e: Rename variable array Bssid
      Staging: rtl8192e: Rename variable NumRxUnicastOkInPeriod
      Staging: rtl8192e: Rename variable SlotNum
      Staging: rtl8192e: Rename variable RemoveAllTS
      Staging: rtl8192e: Rename function RemovePeerTS()
      Staging: rtl8192e: Rename function rtllib_MlmeDisassociateRequest()
      Staging: rtl8192e: Rename function SendDisassociation()
      Staging: rtl8192e: Rename variable bHalfSupportNmode
      Staging: rtl8192e: Rename variable PMKCacheIdx
      Staging: rtl8192e: Rename function GetNmodeSupportBySecCfg()
      Staging: rtl8192e: Rename variable AsocRetryCount
      Staging: rtl8192e: Rename variable FirstIe_InScan
      Staging: rtl8192e: Rename function rtllib_rx_ADDBARsp()
      Staging: rtl8192e: Rename variable LPSAwakeIntvl_tmp
      Staging: rtl8192e: Rename variable LPSDelayCnt
      Staging: rtl8192e: Rename function pointer SetHwRegHandler()
      Staging: rtl8192e: Rename function MgntQuery_TxRateExcludeCCKRates()
      Staging: rtl8192e: Rename variable PeerHTCapBuf
      Staging: rtl8192e: Rename variable PeerHTInfoBuf
      Staging: rtl8192e: Rename variable LPSAwakeIntvl
      Staging: rtl8192e: Rename variable SelfHTCap
      Staging: rtl8192e: Fix paren alignment for rtllib_disable_net_monitor_mode()
      Staging: rtl8192e: Fixup if statement broken across multiple lines.
      Staging: rtl8192e: Remove unnecessary blank line
      Staging: rtl8192e: Fix if statement alignment with open parenthesis
      Staging: rtl8192e: Rename variable Octet
      Staging: rtl8192e: Rename variable LpsIdleCount
      Staging: rtl8192e: Rename variable NumRecvBcnInPeriod
      Staging: rtl8192e: Rename variable bForcedBgMode
      Staging: rtl8192e: Rename function rtllib_rx_ADDBAReq()
      Staging: rtl8192e: Rename variable NumRecvDataInPeriod
      Staging: rtl8192e: Rename function SecIsInPMKIDList()
      Staging: rtl8192e: Rename variable PMKIDList
      Staging: rtl8192e: Rename variable Turbo_Enable
      Staging: rtl8192e: Rename variable osCcxRmCap
      Staging: rtl8192e: Rename variable bCkipSupported
      Staging: rtl8192e: Rename variable bCcxRmEnable
      Staging: rtl8192e: Rename variable CcxRmCapBuf
      Staging: rtl8192e: Rename variable BssCcxVerNumber
      Staging: rtl8192e: Rename variable CcxVerNumBuf
      Staging: rtl8192e: Rename variable asRsn
      Staging: rtl8192e: Rename variable AironetIeOui
      Staging: rtl8192e: Rename variable osCcxAironetIE
      Staging: rtl8192e: Rename variable CcxAironetBuf
      Staging: rtl8192e: Rename varoable osCcxVerNum
      Staging: rtl8192e: Rename varoable asSta
      Staging: rtl8192e: Rename reference AllowAllDestAddrHandler
      Staging: rtl8192e: Rename boolean variable bHalfWirelessN24GMode
      Staging: rtl8192e: Rename function MgntQuery_MgntFrameTxRate
      Staging: rtl8192e: Fix 5 chckpatch alignment warnings in rtl819x_BAProc.c
      Staging: rtl8192e: Rename variable TxRxSelect
      Staging: rtl8192e: Rename function rtllib_send_ADDBAReq()
      Staging: rtl8192e: Rename function rtllib_send_ADDBARsp()
      Staging: rtl8192e: Rename goto OnADDBAReq_Fail
      Staging: rtl8192e: Rename goto OnADDBARsp_Reject
      Staging: rtl8192e: Rename function rtllib_FlushRxTsPendingPkts()
      Staging: rtl8192e: Rename function GetHalfNmodeSupportByAPsHandler()

 drivers/staging/Kconfig                            |    4 -
 drivers/staging/Makefile                           |    2 -
 drivers/staging/axis-fifo/axis-fifo.c              |    7 +-
 drivers/staging/board/Kconfig                      |   12 -
 drivers/staging/board/Makefile                     |    4 -
 drivers/staging/board/TODO                         |    2 -
 drivers/staging/board/armadillo800eva.c            |   88 -
 drivers/staging/board/board.c                      |  204 --
 drivers/staging/board/board.h                      |   46 -
 drivers/staging/board/kzm9d.c                      |   26 -
 drivers/staging/emxx_udc/Kconfig                   |   11 -
 drivers/staging/emxx_udc/Makefile                  |    2 -
 drivers/staging/emxx_udc/TODO                      |    6 -
 drivers/staging/emxx_udc/emxx_udc.c                | 3223 --------------------
 drivers/staging/emxx_udc/emxx_udc.h                |  554 ----
 drivers/staging/fbtft/fbtft-core.c                 |    2 -
 drivers/staging/fieldbus/anybuss/arcx-anybus.c     |    6 +-
 drivers/staging/fieldbus/anybuss/host.c            |    2 +-
 drivers/staging/fieldbus/dev_core.c                |    8 +-
 drivers/staging/gdm724x/gdm_lte.c                  |    2 +-
 drivers/staging/greybus/audio_apbridgea.h          |    1 -
 drivers/staging/greybus/audio_manager.c            |    8 +-
 drivers/staging/greybus/audio_topology.c           |    3 -
 drivers/staging/greybus/authentication.c           |    6 +-
 drivers/staging/greybus/bootrom.c                  |    8 +-
 drivers/staging/greybus/fw-download.c              |   15 +-
 drivers/staging/greybus/fw-management.c            |   20 +-
 drivers/staging/greybus/gbphy.c                    |    8 +-
 drivers/staging/greybus/greybus_authentication.h   |    6 +-
 drivers/staging/greybus/greybus_firmware.h         |    8 +-
 drivers/staging/greybus/light.c                    |    8 +-
 drivers/staging/greybus/loopback.c                 |    6 +-
 drivers/staging/greybus/raw.c                      |    6 +-
 drivers/staging/greybus/vibrator.c                 |    6 +-
 drivers/staging/nvec/TODO                          |    7 +-
 drivers/staging/nvec/nvec.c                        |    7 +-
 drivers/staging/octeon/ethernet-mdio.c             |    2 -
 drivers/staging/octeon/octeon-stubs.h              |    2 +-
 drivers/staging/pi433/pi433_if.c                   |    1 +
 drivers/staging/pi433/rf69.c                       |    4 +-
 drivers/staging/pi433/rf69.h                       |    4 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     |  103 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c     |    1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |   64 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c         |   37 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c         |    4 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c         |    4 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c          |   70 +-
 drivers/staging/rtl8192e/rtl819x_HT.h              |    6 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c          |   44 +-
 drivers/staging/rtl8192e/rtl819x_Qos.h             |    2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c          |   30 +-
 drivers/staging/rtl8192e/rtllib.h                  |   98 +-
 drivers/staging/rtl8192e/rtllib_rx.c               |   50 +-
 drivers/staging/rtl8192e/rtllib_softmac.c          |  278 +-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c       |    8 +-
 drivers/staging/rtl8192e/rtllib_tx.c               |   18 +-
 drivers/staging/rtl8192e/rtllib_wx.c               |    2 +-
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c     |    4 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c          |    9 +-
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c       |    3 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c  |   14 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |    3 +-
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  |   61 +-
 .../vc04_services/interface/vchiq_arm/vchiq_bus.c  |    2 +-
 .../vc04_services/interface/vchiq_arm/vchiq_bus.h  |    2 +-
 drivers/staging/vme_user/vme.c                     |    2 +-
 drivers/staging/vme_user/vme.h                     |    2 +-
 drivers/staging/vme_user/vme_tsi148.h              |    6 +-
 drivers/staging/vt6655/card.c                      |   74 +-
 drivers/staging/vt6655/rxtx.h                      |    1 -
 include/linux/greybus/greybus_protocols.h          |    8 +-
 72 files changed, 537 insertions(+), 4820 deletions(-)
 delete mode 100644 drivers/staging/board/Kconfig
 delete mode 100644 drivers/staging/board/Makefile
 delete mode 100644 drivers/staging/board/TODO
 delete mode 100644 drivers/staging/board/armadillo800eva.c
 delete mode 100644 drivers/staging/board/board.c
 delete mode 100644 drivers/staging/board/board.h
 delete mode 100644 drivers/staging/board/kzm9d.c
 delete mode 100644 drivers/staging/emxx_udc/Kconfig
 delete mode 100644 drivers/staging/emxx_udc/Makefile
 delete mode 100644 drivers/staging/emxx_udc/TODO
 delete mode 100644 drivers/staging/emxx_udc/emxx_udc.c
 delete mode 100644 drivers/staging/emxx_udc/emxx_udc.h

