Return-Path: <linux-kernel+bounces-105297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B2E87DB8C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 22:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF251C20A44
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 21:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FA01C69C;
	Sat, 16 Mar 2024 21:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="so2f+zJZ";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="so2f+zJZ"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED0B1C29C;
	Sat, 16 Mar 2024 21:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710626325; cv=none; b=es4w+gpbZXj+zE4lfgMtAJZNxl8KT23mGzSo3++Ui5pXSIHxuu14lIx1BM1qeFORSClzqZxAQmilpN8Mx2IEsyfF4jQ57HASBUTyvYLYzKUltZBO2NaXRpvaqf4c16kAFnXBkuqNOOcjLim9VM1Kp0xY2yAbTUobojO6VNQcxig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710626325; c=relaxed/simple;
	bh=cw68FEZBASFCGc4Hswk93WlwkBYSFPOZ4SG4alg6skc=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=k609yWWHgC961esKnQYJ8ldAv97BzCzEvLWk6tmpoUTuWah5EIySnQafgOKMXLVJVljMr2f1hpSyVphNTaMw73k6hyGWLvtmjN8++LRBcHCk4sFPeyNkk6fpAaadwKZG/QNYHZlGcJ1oRLKlGhWYYut59lPJiktawmP/ETxKyvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=so2f+zJZ; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=so2f+zJZ; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1710626321;
	bh=cw68FEZBASFCGc4Hswk93WlwkBYSFPOZ4SG4alg6skc=;
	h=Message-ID:Subject:From:To:Date:From;
	b=so2f+zJZvH6ZmmMC8Jq7qKDazuOXEuyN+5HwaM3PDgYHMfkEICKOEPSiUuptjbbcf
	 iWNPIRVwMgxDKB3SIe3Qtv/lYwVYpIXxJNSVZif1iUFtBxtpZvL39XgzS3VTHmdRbJ
	 rNsHo9eMy8tDrGHn4l+vRmTRCwRtxjHOZc2IHYVQ=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id CC3FC1287AC6;
	Sat, 16 Mar 2024 17:58:41 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Lih0zaUHzPSA; Sat, 16 Mar 2024 17:58:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1710626321;
	bh=cw68FEZBASFCGc4Hswk93WlwkBYSFPOZ4SG4alg6skc=;
	h=Message-ID:Subject:From:To:Date:From;
	b=so2f+zJZvH6ZmmMC8Jq7qKDazuOXEuyN+5HwaM3PDgYHMfkEICKOEPSiUuptjbbcf
	 iWNPIRVwMgxDKB3SIe3Qtv/lYwVYpIXxJNSVZif1iUFtBxtpZvL39XgzS3VTHmdRbJ
	 rNsHo9eMy8tDrGHn4l+vRmTRCwRtxjHOZc2IHYVQ=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 296E91287A73;
	Sat, 16 Mar 2024 17:58:41 -0400 (EDT)
Message-ID: <623833d89c32803eb47f763dc89decb85f53395e.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI updates for the 6.8+ merge window
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel
	 <linux-kernel@vger.kernel.org>
Date: Sat, 16 Mar 2024 17:58:39 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only a couple of driver updates this time (lpfc and mpt3sas)
plus the usual assorted minor fixes and updates.  The major core update
is a set of patches moving retries out of the drivers and into the
core.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Andrew Halaney (1):
      scsi: ufs: qcom: Clarify comments about the initial phy_gear

Arnd Bergmann (3):
      scsi: bfa: Fix function pointer type mismatch for state machines
      scsi: bfa: Fix function pointer type mismatch for hcb_qe->cbfn
      scsi: csiostor: Avoid function pointer casts

ChanWoo Lee (3):
      scsi: ufs: mcq: Remove unused parameters
      scsi: ufs: mcq: Use ufshcd_mcq_req_to_hwq() to simplify updating hwq
      scsi: ufs: mcq: Add definition for REG_UFS_MEM_CFG register

Colin Ian King (3):
      scsi: qla1280: Remove redundant assignment to variable 'mr'
      scsi: message: fusion: Remove redundant pointer 'hd'
      scsi: megaraid: Remove redundant assignment to variable 'retval'

Eric Chanudet (1):
      scsi: ufs: qcom: Avoid re-init quirk when gears match

Guixin Liu (1):
      scsi: mpi3mr: Use ida to manage mrioc ID

Jiapeng Chong (1):
      scsi: fnic: Clean up some inconsistent indenting

Justin Stitt (3):
      scsi: libfc: replace deprecated strncpy() with memcpy()
      scsi: lpfc: Replace deprecated strncpy() with strscpy()
      scsi: ibmvscsi_tgt: Replace deprecated strncpy() with strscpy()

Justin Tee (17):
      scsi: lpfc: Copyright updates for 14.4.0.0 patches
      scsi: lpfc: Update lpfc version to 14.4.0.0
      scsi: lpfc: Change lpfc_vport load_flag member into a bitmask
      scsi: lpfc: Change lpfc_vport fc_flag member into a bitmask
      scsi: lpfc: Protect vport fc_nodes list with an explicit spin lock
      scsi: lpfc: Change nlp state statistic counters into atomic_t
      scsi: lpfc: Remove shost_lock protection for fc_host_port shost APIs
      scsi: lpfc: Move handling of reset congestion statistics events
      scsi: lpfc: Save FPIN frequency statistics upon receipt of peer cgn notifications
      scsi: lpfc: Add condition to delete ndlp object after sending BLS_RJT to an ABTS
      scsi: lpfc: Fix failure to delete vports when discovery is in progress
      scsi: lpfc: Remove NLP_RCV_PLOGI early return during RSCN processing for ndlps
      scsi: lpfc: Allow lpfc_plogi_confirm_nport() logic to execute for Fabric nodes
      scsi: lpfc: Remove D_ID swap log message from trace event logger
      scsi: lpfc: Use sg_dma_len() API to get struct scatterlist's length
      scsi: lpfc: Fix possible memory leak in lpfc_rcv_padisc()
      scsi: lpfc: Initialize status local variable in lpfc_sli4_repost_sgl_list()

Lee Jones (5):
      scsi: aacraid: aachba: Replace snprintf() with the safer scnprintf() variant
      scsi: 53c700: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
      scsi: 3w-xxxx: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
      scsi: 3w-sas: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
      scsi: 3w-9xxx: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()

Li Zhijian (5):
      scsi: pm8001: Convert snprintf() to sysfs_emit()
      scsi: isci: Convert snprintf() to sysfs_emit()
      scsi: ibmvscsi_tgt: Convert snprintf() to sysfs_emit()
      scsi: ibmvscsi: Convert snprintf() to sysfs_emit()
      scsi: fnic: Convert snprintf() to sysfs_emit()

Lukas Bulwahn (1):
      scsi: core: Really include kunit tests with SCSI_LIB_KUNIT_TEST

Maramaina Naresh (2):
      scsi: ufs: ufs-mediatek: Migrate to UFSHCD generic CPU latency PM QoS support
      scsi: ufs: core: Add CPU latency QoS support for UFS driver

Mike Christie (19):
      scsi: core: Add kunit tests for scsi_check_passthrough()
      scsi: ufs: Have midlayer retry start stop errors
      scsi: sr: Have midlayer retry get_sectorsize() errors
      scsi: ses: Have midlayer retry scsi_execute_cmd() errors
      scsi: sd: Have midlayer retry read_capacity_10() errors
      scsi: sd: Have pr commands retry UAs
      scsi: core: Have SCSI midlayer retry scsi_report_lun_scan() errors
      scsi: core: Have midlayer retry scsi_mode_sense() UAs
      scsi: ch: Have midlayer retry ch_do_scsi() UAs
      scsi: ch: Remove unit_attention
      scsi: sd: Have midlayer retry sd_sync_cache() errors
      scsi: spi: Have midlayer retry spi_execute() UAs
      scsi: device_handler: rdac: Have midlayer retry send_mode_select() errors
      scsi: device_handler: hp_sw: Have midlayer retry scsi_execute_cmd() errors
      scsi: sd: Have midlayer retry sd_spinup_disk() errors
      scsi: sd: Use separate buf for START_STOP in sd_spinup_disk()
      scsi: core: Retry INQUIRY after timeout
      scsi: core: Have midlayer retry scsi_probe_lun() errors
      scsi: core: Allow passthrough to request midlayer retries

Peter Wang (5):
      scsi: ufs: ufs-mediatek: Change default autosuspend timer
      scsi: core: Move autosuspend timer delay to Scsi_Host
      scsi: ufs: ufs-mediatek: Disable MCQ IRQ when clock off
      scsi: ufs: ufs-mediatek: Fix MCQ mode TM cmd timeout
      scsi: ufs: ufs-mediatek: Check link status after exiting hibern8

Petr Mladek (1):
      scsi: core: Safe warning about bad dev info string

Ranjan Kumar (2):
      scsi: mpt3sas: Update driver version to 48.100.00.00
      scsi: mpt3sas: Reload SBR without rebooting HBA

Ricardo B. Marliere (6):
      scsi: core: Constify the struct device_type usage
      scsi: core: Make scsi_bus_type const
      scsi: target: tcm_loop: Make tcm_loop_lld_bus const
      scsi: scsi_debug: Make pseudo_lld_bus const
      scsi: iscsi: Make iscsi_flashnode_bus const
      scsi: fcoe: Make fcoe_bus_type const

Simone Weiß (1):
      scsi: bfa: Remove additional unnecessary struct declarations

Xiang Chen (1):
      scsi: hisi_sas: Remove hisi_hba->timer for v3 hw

Yihang Li (3):
      scsi: hisi_sas: Check whether debugfs is enabled before removing or releasing it
      scsi: hisi_sas: Remove redundant checks for automatic debugfs dump
      scsi: hisi_sas: Fix a deadlock issue related to automatic dump

And the diffstat:

 drivers/message/fusion/mptfc.c              |   4 +-
 drivers/scsi/3w-9xxx.c                      |  44 +--
 drivers/scsi/3w-sas.c                       |  36 +--
 drivers/scsi/3w-xxxx.c                      |  44 +--
 drivers/scsi/53c700.c                       |   2 +-
 drivers/scsi/Kconfig                        |   9 +
 drivers/scsi/aacraid/aachba.c               |   6 +-
 drivers/scsi/bfa/bfa.h                      |  30 +-
 drivers/scsi/bfa/bfa_core.c                 |   4 +-
 drivers/scsi/bfa/bfa_cs.h                   |  21 +-
 drivers/scsi/bfa/bfa_fcpim.c                |  51 ----
 drivers/scsi/bfa/bfa_fcpim.h                |  66 +++-
 drivers/scsi/bfa/bfa_fcs.h                  | 312 ++++++++++++-------
 drivers/scsi/bfa/bfa_fcs_fcpim.c            |  23 +-
 drivers/scsi/bfa/bfa_fcs_lport.c            | 112 ++-----
 drivers/scsi/bfa/bfa_fcs_rport.c            |  34 ++-
 drivers/scsi/bfa/bfa_ioc.c                  |  85 +++---
 drivers/scsi/bfa/bfa_ioc.h                  |  84 ++++--
 drivers/scsi/bfa/bfa_svc.c                  |  72 ++---
 drivers/scsi/bfa/bfa_svc.h                  | 115 +++++--
 drivers/scsi/bfa/bfad_bsg.c                 |  11 +-
 drivers/scsi/bfa/bfad_drv.h                 |  31 +-
 drivers/scsi/ch.c                           |  27 +-
 drivers/scsi/csiostor/csio_defs.h           |  18 +-
 drivers/scsi/csiostor/csio_lnode.c          |   8 +-
 drivers/scsi/csiostor/csio_lnode.h          |  13 -
 drivers/scsi/device_handler/scsi_dh_hp_sw.c |  49 ++-
 drivers/scsi/device_handler/scsi_dh_rdac.c  |  84 +++---
 drivers/scsi/fcoe/fcoe_sysfs.c              |   4 +-
 drivers/scsi/fnic/fnic_attrs.c              |   7 +-
 drivers/scsi/fnic/fnic_scsi.c               |   4 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c       |  26 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c      |   8 +-
 drivers/scsi/hosts.c                        |   2 +-
 drivers/scsi/ibmvscsi/ibmvfc.c              |  22 +-
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c    |  24 +-
 drivers/scsi/isci/init.c                    |   2 +-
 drivers/scsi/libfc/fc_encode.h              |  14 +-
 drivers/scsi/lpfc/lpfc.h                    |  94 +++---
 drivers/scsi/lpfc/lpfc_attr.c               | 107 +++----
 drivers/scsi/lpfc/lpfc_bsg.c                |   8 +-
 drivers/scsi/lpfc/lpfc_ct.c                 | 158 +++++-----
 drivers/scsi/lpfc/lpfc_debugfs.c            |  14 +-
 drivers/scsi/lpfc/lpfc_els.c                | 446 ++++++++++++----------------
 drivers/scsi/lpfc/lpfc_hbadisc.c            | 350 +++++++++-------------
 drivers/scsi/lpfc/lpfc_hw4.h                |   4 +-
 drivers/scsi/lpfc/lpfc_init.c               | 137 +++++----
 drivers/scsi/lpfc/lpfc_mbox.c               |  10 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c          |  91 +++---
 drivers/scsi/lpfc/lpfc_nvme.c               |  20 +-
 drivers/scsi/lpfc/lpfc_nvmet.c              |  14 +-
 drivers/scsi/lpfc/lpfc_scsi.c               |  10 +-
 drivers/scsi/lpfc/lpfc_sli.c                |  56 ++--
 drivers/scsi/lpfc/lpfc_version.h            |   6 +-
 drivers/scsi/lpfc/lpfc_vport.c              |  69 ++---
 drivers/scsi/megaraid.c                     |   2 +-
 drivers/scsi/mpi3mr/mpi3mr_os.c             |  12 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c         |  99 ++++--
 drivers/scsi/mpt3sas/mpt3sas_base.h         |   8 +-
 drivers/scsi/mpt3sas/mpt3sas_ctl.c          |  54 ++++
 drivers/scsi/mpt3sas/mpt3sas_ctl.h          |  10 +
 drivers/scsi/mpt3sas/mpt3sas_scsih.c        |   1 +
 drivers/scsi/pm8001/pm8001_ctl.c            |   6 +-
 drivers/scsi/qla1280.c                      |   1 -
 drivers/scsi/scsi_debug.c                   |   4 +-
 drivers/scsi/scsi_devinfo.c                 |   6 +-
 drivers/scsi/scsi_lib.c                     | 124 +++++++-
 drivers/scsi/scsi_lib_test.c                | 330 ++++++++++++++++++++
 drivers/scsi/scsi_priv.h                    |   2 +-
 drivers/scsi/scsi_scan.c                    | 109 ++++---
 drivers/scsi/scsi_sysfs.c                   |   6 +-
 drivers/scsi/scsi_transport_iscsi.c         |   4 +-
 drivers/scsi/scsi_transport_spi.c           |  35 +--
 drivers/scsi/sd.c                           | 220 +++++++++-----
 drivers/scsi/ses.c                          |  66 ++--
 drivers/scsi/sr.c                           |  38 +--
 drivers/target/loopback/tcm_loop.c          |   2 +-
 drivers/ufs/core/ufs-mcq.c                  |  12 +-
 drivers/ufs/core/ufs-sysfs.c                |  49 +++
 drivers/ufs/core/ufshcd.c                   |  90 ++++--
 drivers/ufs/host/ufs-mediatek.c             |  90 ++++--
 drivers/ufs/host/ufs-mediatek.h             |   7 +-
 drivers/ufs/host/ufs-qcom.c                 |  28 +-
 include/scsi/scsi_device.h                  |  48 +++
 include/scsi/scsi_host.h                    |   6 +-
 include/ufs/ufshcd.h                        |   7 +
 include/ufs/ufshci.h                        |   3 +
 87 files changed, 2746 insertions(+), 1835 deletions(-)
 create mode 100644 drivers/scsi/scsi_lib_test.c

James


