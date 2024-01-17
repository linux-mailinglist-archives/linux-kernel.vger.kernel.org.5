Return-Path: <linux-kernel+bounces-28896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8F8830450
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E69287270
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D961DFCB;
	Wed, 17 Jan 2024 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WbLLT37o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E321DFC5;
	Wed, 17 Jan 2024 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705490001; cv=none; b=Y/o841nOPdkfP/ghoAJYXfI9FcOyiXiM1uj0yG6ZjY5DKf90EkDN5r4GOl1bqtSX0KbNq8JBiq04wzOx4grnvIELe9Ch68+qbPA/r/tIkJxMqrUvsTG7UJm7n/2GzW65tVs0DQQzBn0UVSztM1FJ6D5L7P8I+9V4/HmjseHS3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705490001; c=relaxed/simple;
	bh=yNmbS2rm1gVQ6BoLKI8WLxSJclqu+BjfpDsyvlIRZdA=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition; b=qzq2f/MaxunHaw27cQGTAkUohnWWW6YHrbKdGqrS3wIR4jt4SVGwLoqE9MJAvnDzwhA36J26ca098FhVqHVm9L5b8pKhChIbrWBXJBTDVrEL/5ZCwCTdI0T320+e8wMkIV+2iFtPfKlFXSHE4uVq/kLNhKHCBMmfJf8ym9iOTr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WbLLT37o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72516C433F1;
	Wed, 17 Jan 2024 11:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705490000;
	bh=yNmbS2rm1gVQ6BoLKI8WLxSJclqu+BjfpDsyvlIRZdA=;
	h=Date:From:To:Cc:Subject:From;
	b=WbLLT37okwBFN+GKdxdHw7lARjGUAvVSdnsdN7uOZBcuo4XrrVGWRJ66pIIG1hPey
	 6Hyjtvc6iFPVDFs+TEyskFGtIKW9PvAks10DQ7X3HVBnNYvnkabRTrPMk0QYfUaWez
	 t11wpNJaDvlcX/WFItcdGbTMzhOwYcrvhpvotaQI=
Date: Wed, 17 Jan 2024 12:13:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver updates for 6.8-rc1
Message-ID: <Zae2Tg065gd6rQUV@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.8-rc1

for you to fetch changes up to 0a46c21c21c1f1c9a65e29eaae243d0f240bbd6b:

  Staging: rtl8192e: Rename variable OpMode (2024-01-04 14:34:51 +0100)

----------------------------------------------------------------
Staging driver changes for 6.8-rc1

Here is the "big" set of staging driver changes for 6.8-rc1.  It's not
really that big this release cycle, not much happened except for 186
patches of coding style cleanups.  The majority was in the rtl8192e
driver, but there are other smaller changes in a few other staging
drivers, full details in the shortlog.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Bagas Sanjaya (2):
      MAINTAINERS: Mark VME subsystem as orphan
      drivers: staging: vme_user: Describe VME_BUS and VME_TSI148

Dan Carpenter (1):
      staging: vc04_services: remove unnecessary NULL check

Dipendra Khadka (1):
      drivers: staging: rtl8712: Fixes spelling mistake in rtl871x_mp_phy_regdef.h

Gary Rookard (43):
      staging: rtl8192e: renamed variable HTMcsToDataRate
      staging: rtl8192e: renamed variable TXCountToDataRate
      staging: rtl8192e: renamed variable IsHTHalfNmodeAPs
      staging: rtl8192e: renamed variable HTIOTPeerDetermine
      staging: rtl8192e: renamed variable HTIOTActIsMgntUseCCK6M
      staging: rtl8192e: renamed variable nMcsRate
      staging: rtl8192e: renamed variable bCurBW40MHz
      staging: rtl8192e: renamed variable nDataRate
      staging: rtl8192e: renamed variable bRegShortGI20MHz
      staging: rtl8192e: renamed variable bRegShortGI40MHz
      staging: rtl8192e: renamed variable bRegBW40MHz
      staging: rtl8192e: renamed variable bRegSuppCCK
      staging: rtl8192e: renamed variable nAMSDU_MaxSize
      staging: rtl8192e: renamed variable bAMSDU_Support
      staging: rtl8192e: renamed variable bAMPDUEnable
      staging: rtl8192e: renamed variable AMPDU_Factor
      staging: rtl8192e: renamed variable MPDU_Density
      staging: rtl8192e: renamed variable bTxEnableFwCalcDur
      staging: rtl8192e: renamed variable bCurShortGI40MHz
      staging: rtl8192e: renamed variable bCurShortGI20MHz
      staging: rtl8192e: renamed variable CCKOFDMRate
      staging: rtl8192e: renamed variable HTIOTActIsCCDFsync
      staging: rtl8192e: renamed variable IOTPeer
      staging: rtl8192e: rename variable HTIOTActDetermineRaFunc
      staging: rtl8192e: rename variable HTResetIOTSetting
      staging: rtl8192e: rename variable HTConstructCapabilityElement
      staging: rtl8192e: rename variable HTConstructRT2RTAggElement
      staging: rtl8192e: rename variable HT_PickMCSRate
      staging: rtl8192e: rename variable posHTCap
      staging: rtl8192e: rename variable IsEncrypt
      staging: rtl8192e: rename variable bAssoc
      staging: rtl8192e: rename variable HTSetConnectBwMode
      staging: rtl8192e: rename variable HTOnAssocRsp
      staging: rtl8192e: rename variable HTInitializeHTInfo
      staging: rtl8192e: rename variable pHT
      staging: rtl8192e: rename variable pCapELE
      staging: rtl8192e: rename variable HTGetHighestMCSRate
      staging: rtl8192e: renamed variable HTFilterMCSRate
      staging: rtl8192e: rename variable HTInitializeBssDesc
      staging: rtl8192e: rename variable HTResetSelfAndSavePeerSetting
      staging: rtl8192e: rename variable HTCCheck
      staging: rtl8192e: rename variable HTSetConnectBwModeCallback
      staging: rtl8192e: rename variable ePeerHTSpecVer

Pavan Bobba (11):
      staging: vt6655: Type encoding info dropped from variable name "qwBSSTimestamp"
      staging: vt6655: Type encoding info dropped from variable name "qwTSFOffset"
      staging: vt6655: Type encoding info dropped from function name "CARDqGetTSFOffset"
      staging: vt6655: Type encoding info dropped from function name "CARDbSetBeaconPeriod"
      staging: vt6655: Type encoding info dropped from variable name "wBeaconInterval"
      staging: vt6655: Type encoding info dropped from variable name "qwNextTBTT"
      staging: vt6655: Type encoding info dropped from function name "CARDqGetNextTBTT"
      staging: vt6655: Type encoding info dropped from function name "CARDbRadioPowerOff"
      staging: vt6655: Type encoding info dropped from function name "CARDvSafeResetTx"
      staging: vt6655: Type encoding info dropped from variable name "pCurrTD"
      staging: vt6655: Type encoding info dropped from variable name "apTailTD"

Philipp Hortmann (57):
      staging: rtl8192e: Remove unused return value of rtl92e_set_channel()
      staging: rtl8192e: Change parameter "ch" of set_chan() to u8
      staging: rtl8192e: Unwind pointer to pointer to rtl92e_set_channel()
      staging: rtl8192e: Remove equation that results in constant for chnl_plan
      staging: rtl8192e: Remove constant variable chnl_plan
      staging: rtl8192e: Remove unused variable eeprom_chnl_plan
      staging: rtl8192e: Remove equation to check limits of channel
      staging: rtl8192e: Remove check if channel_array[channel_plan].len != 0
      staging: rtl8192e: Remove switch for a constant in dot11d_channel_map()
      staging: rtl8192e: Remove constant index from channel_array[]
      staging: rtl8192e: Remove unexecuted rtllib_extract_country_ie()
      staging: rtl8192e: Remove unused function dot11d_update_country()
      staging: rtl8192e: Remove IS_DOT11D_ENABLE(ieee)
      staging: rtl8192e: Remove unused function dot11d_scan_complete()
      staging: rtl8192e: Remove unused function dot11d_reset()
      staging: rtl8192e: Remove unused macros IS_EQUAL_CIE_SRC and friends
      staging: rtl8192e: Remove unused function copy_mac_addr()
      staging: rtl8192e: Remove unused variable dot11d_info->state
      staging: rtl8192e: Remove unused variables from struct rt_dot11d_info
      staging: rtl8192e: Remove unused variable country_watchdog
      staging: rtl8192e: Remove unused variable global_domain
      staging: rtl8192e: Remove unused function dot11d_init()
      staging: rtl8192e: Remove unused struct chnl_txpow_triple
      staging: rtl8192e: Remove unused variable bss_start_channel
      staging: rtl8192e: Remove unused interrupt for IMR_BcnInt
      staging: rtl8192e: Remove unused function rtllib_get_beacon()
      staging: rtl8192e: Remove unused timer beacon_timer
      staging: rtl8192e: Remove unused function rtllib_send_beacon()
      staging: rtl8192e: Remove unused function rtllib_get_beacon_()
      staging: rtl8192e: Remove unused function rtllib_probe_resp()
      staging: rtl8192e: Remove unused function HTConstructInfoElement()
      staging: rtl8192e: Remove function rtl92e_update_rx_pkt_timestamp()
      staging: rtl8192e: Remove function rtllib_update_active_chan_map()
      staging: rtl8192e: Remove variable channel_map
      staging: rtl8192e: Remove variable dot11d_info
      staging: rtl8192e: Remove function dot11d_channel_map()
      staging: rtl8192e: Remove files dot11d.c and dot11d.h
      staging: rtl8192e: Remove unused struct iw_range_with_scan_capa
      staging: rtl8192e: Remove variable ht_info->reg_bw_40mhz
      staging: rtl8192e: Remove variable ht_info->reg_supp_cck
      staging: rtl8192e: Remove variable ht_info->reg_short_gi_20mhz
      staging: rtl8192e: Remove variable ht_info->reg_short_gi_40mhz
      staging: rtl8192e: Remove variable ForcedAMPDUMode
      staging: rtl8192e: Remove variable ForcedAMSDUMode
      staging: rtl8192e: Remove equation with pPeerHTCap->DssCCk
      staging: rtl8192e: Remove variable ht_info->bCurSuppCCK
      staging: rtl8192e: Remove struct ht_info_ele SelfHTInfo
      staging: rtl8192e: Remove variable bCurrent_AMSDU_Support
      staging: rtl8192e: Remove unused variable nMaxAMSDUSize
      staging: rtl8192e: Remove constant variable self_mimo_ps
      staging: rtl8192e: Remove constant variable peer_mimo_ps
      staging: rtl8192e: Remove constant variable forced_short_gi
      staging: rtl8192e: Remove unused variable ht_info->amsdu_support
      staging: rtl8192e: Remove variable ht_info->mpdu_density
      staging: rtl8192e: Remove variable ht_info->RT2RT_HT_Mode
      staging: rtl8192e: Remove constant variable reg_rt2rt_aggregation
      staging: rtl8192e: Remove constant variable reg_rx_reorder_enable

Piro Yang (2):
      staging: vme_user: Fix the issue of return the wrong error code
      staging: vme_user: print more detailed infomation when an error occurs

Ryan England (1):
      staging: rtl8712: fix open parentheses alignment

Stefan Wahren (3):
      staging: vchiq_core: Make vchiq_dump_service_state static
      staging: vchiq_core: Shorten bulk TX/RX pending dump
      staging: vchiq_arm: move state dump to debugfs

Tree Davies (57):
      Staging: rtl8192e: Rename variable bSendDELBA
      Staging: rtl8192e: Rename variable bCurrentAMPDUEnable
      Staging: rtl8192e: Rename variable bAddBaReqInProgress
      Staging: rtl8192e: Rename variable bAddBaReqDelayed
      Staging: rtl8192e: Rename variable bUsingBa
      Staging: rtl8192e: Rename variable bOverwritePending
      Staging: rtl8192e: Rename variable bDisable_AddBa
      Staging: rtl8192e: Rename variable pTxTs
      Staging: rtl8192e: Rename variable BAReq
      Staging: rtl8192e: Rename variable Delba
      Staging: rtl8192e: Rename variable TSpec
      Staging: rtl8192e: Rename variable TxAdmittedBARecord
      Staging: rtl8192e: Rename variable TxPendingBARecord
      Staging: rtl8192e: Rename variable pDialogToken
      Staging: rtl8192e: Rename variable pTsCommonInfo
      Staging: rtl8192e: Rename variable TxCurSeq
      Staging: rtl8192e: Rename variable TsAddBaTimer
      Staging: rtl8192e: Rename variable DelbaParamSet
      Staging: rtl8192e: Rename variable pBaParamSet
      Staging: rtl8192e: Rename variable pBaTimeoutVal
      Staging: rtl8192e: Rename variable pAdmittedBA
      Staging: rtl8192e: Rename variable TsCommonInfo
      Staging: rtl8192e: Remove variable bFirstSeg
      Staging: rtl8192e: Remove variable bLastSeg
      Staging: rtl8192e: Remove variable bEncrypt
      Staging: rtl8192e: Remove variable macId
      Staging: rtl8192e: rename linked list reference: List
      Staging: rtl8192e: Rename array variable RxTsRecord
      Staging: rtl8192e: Rename array variable TxTsRecord
      Staging: rtl8192e: Rename variable ucTSID
      Staging: rtl8192e: Rename variable pDelBaParamSet
      Staging: rtl8192e: Rename variable pBaStartSeqCtrl
      Staging: rtl8192e: Remove unnecessary braces from MgntQuery_MgntFrameTxRate()
      Staging: rtl8192e: Remove unnecessary parenthesis in rtllib_association_req()
      Staging: rtl8192e: Remove unnecessary parenthesis in rtllib_rx_assoc_resp()
      Staging: rtl8192e: Remove unnecessary parenthesis in rtllib_ap_sec_type()
      Staging: rtl8192e: Remove unnecessary parenthesis in rtllib_association_req()
      Staging: rtl8192e: Fixup multiple assinment in init_mgmt_queue()
      Staging: rtl8192e: Fix statement broken across 2 lines in rtllib_rx_assoc_resp()
      Staging: rtl8192e: Fix function definition broken across multiple lines
      Staging: rtl8192e: Fixup statement broken across 2 lines in rtllib_softmac_xmit()
      Staging: rtl8192e: Fixup statement broken across 2 lines in rtllib_softmac_new_net()
      Staging: rtl8192e: Rename function rtllib_MFIE_Brate()
      Staging: rtl8192e: Rename function rtllib_MFIE_Grate()
      Staging: rtl8192e: Rename function rtllib_WMM_Info()
      Staging: rtl8192e: Rename function rtllib_TURBO_Info()
      Staging: rtl8192e: Rename variable QueryRate
      Staging: rtl8192e: Rename variable BasicRate
      Staging: rtl8192e: Rename variable skb_waitQ
      Staging: rtl8192e: Rename variable bInitState
      Staging: rtl8192e: Rename function rtllib_DisableNetMonitorMode()
      Staging: rtl8192e: Rename variable bUsed
      Staging: rtl8192e: Rename variable NumTxOkInPeriod
      Staging: rtl8192e: Rename variable NumRxOkInPeriod
      Staging: rtl8192e: Rename function rtllib_EnableNetMonitorMode()
      Staging: rtl8192e: Rename variable bIsAggregateFrame
      Staging: rtl8192e: Rename variable OpMode

Umang Jain (8):
      staging: vc04_services: vchiq_core: Log through struct vchiq_instance
      staging: vc04_services: Do not pass NULL to vchiq_log_error()
      staging: vc04_services: Drop vchiq_log_error() in favour of dev_err
      staging: vc04_services: Drop vchiq_log_warning() in favour of dev_warn
      staging: vc04_services: Drop vchiq_log_trace() in favour of dev_dbg
      staging: vc04_services: Drop vchiq_log_debug() in favour of dev_dbg
      staging: vc04_services: vchiq_arm: Use %p to log pointer address
      staging: vc04_services: vchiq_dev: Use %p to log pointer address

 CREDITS                                            |   8 +
 MAINTAINERS                                        |   5 +-
 drivers/staging/rtl8192e/Makefile                  |   1 -
 drivers/staging/rtl8192e/dot11d.c                  | 165 -----
 drivers/staging/rtl8192e/dot11d.h                  |  84 ---
 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c  |   4 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     |  41 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c     |  12 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h     |   2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       | 101 +---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h       |  11 -
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c         |  22 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c         |  22 -
 drivers/staging/rtl8192e/rtl819x_BAProc.c          | 226 +++----
 drivers/staging/rtl8192e/rtl819x_HT.h              |  35 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c          | 371 +++++-------
 drivers/staging/rtl8192e/rtl819x_Qos.h             |   2 +-
 drivers/staging/rtl8192e/rtl819x_TS.h              |  22 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c          | 156 ++---
 drivers/staging/rtl8192e/rtllib.h                  |  71 +--
 drivers/staging/rtl8192e/rtllib_module.c           |   2 +-
 drivers/staging/rtl8192e/rtllib_rx.c               |  82 +--
 drivers/staging/rtl8192e/rtllib_softmac.c          | 387 ++----------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c       |  11 +-
 drivers/staging/rtl8192e/rtllib_tx.c               |  66 +-
 drivers/staging/rtl8192e/rtllib_wx.c               |   2 +-
 drivers/staging/rtl8712/os_intfs.c                 |   3 +-
 drivers/staging/rtl8712/rtl8712_efuse.c            |   9 +-
 drivers/staging/rtl8712/rtl8712_recv.c             |   3 +-
 drivers/staging/rtl8712/rtl8712_xmit.c             |  60 +-
 drivers/staging/rtl8712/rtl871x_cmd.c              | 159 ++---
 drivers/staging/rtl8712/rtl871x_cmd.h              |  37 +-
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c      | 203 +++----
 drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h    |   2 +-
 drivers/staging/vc04_services/interface/TODO       |   5 -
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 271 +++------
 .../vc04_services/interface/vchiq_arm/vchiq_arm.h  |   7 -
 .../interface/vchiq_arm/vchiq_connected.c          |   8 +-
 .../interface/vchiq_arm/vchiq_connected.h          |   4 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.c | 664 +++++++++------------
 .../vc04_services/interface/vchiq_arm/vchiq_core.h |  54 +-
 .../interface/vchiq_arm/vchiq_debugfs.c            |  10 +
 .../vc04_services/interface/vchiq_arm/vchiq_dev.c  | 113 ++--
 drivers/staging/vme_user/Kconfig                   |  22 +-
 drivers/staging/vme_user/vme.c                     |   4 +-
 drivers/staging/vt6655/card.c                      |  90 +--
 drivers/staging/vt6655/card.h                      |  18 +-
 drivers/staging/vt6655/device.h                    |   4 +-
 drivers/staging/vt6655/device_main.c               |  18 +-
 drivers/staging/vt6655/rxtx.c                      |   2 +-
 50 files changed, 1261 insertions(+), 2420 deletions(-)
 delete mode 100644 drivers/staging/rtl8192e/dot11d.c
 delete mode 100644 drivers/staging/rtl8192e/dot11d.h

