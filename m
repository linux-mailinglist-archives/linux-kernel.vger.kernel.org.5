Return-Path: <linux-kernel+bounces-22787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBAD82A2DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6CB28AC29
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF8A52F96;
	Wed, 10 Jan 2024 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="bTNkxOpy";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="drDwM/SZ"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089FF51C44;
	Wed, 10 Jan 2024 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1704919724;
	bh=lXvNdWagBHSoxlEFgb4RjvYjRTQeLMdlBjHuM9+ySyE=;
	h=Message-ID:Subject:From:To:Date:From;
	b=bTNkxOpyNac7/5koTBxVaKtwuEGFeqWJVkiR4QtQ5FPt3V42c8U+XeYQOEUbIBDxv
	 BvN/rjB9cm+XhVxqFLBBoDND7fWkqJxOooaJC/dG2RbpccGdYKe4FUA1nbiYUkyeLG
	 qkkZeczlZ/ngElpv02UZ+Cb013oIkGE1oGG08OSk=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2FECC128121E;
	Wed, 10 Jan 2024 15:48:44 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 2L5k5c3p8MQN; Wed, 10 Jan 2024 15:48:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1704919723;
	bh=lXvNdWagBHSoxlEFgb4RjvYjRTQeLMdlBjHuM9+ySyE=;
	h=Message-ID:Subject:From:To:Date:From;
	b=drDwM/SZo3siShTTogLfC31I0zDM7LdfvXduKTfgjhuym/WQ5ZaCqhJlCMd0hX7C0
	 aBAt2rSuKaM93CToQBsraq/zwTEWCNERnjqCAJ+LR9O7lyQHxpCqxxQEUvagzwwpvQ
	 myfEr3evIf7cB2jPF2p5jJgMtiIc3SpZA0wjZX5o=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 819BF1280FFA;
	Wed, 10 Jan 2024 15:48:43 -0500 (EST)
Message-ID: <c5ac3166f35bac3a618b126dabadaddc11c8512d.camel@HansenPartnership.com>
Subject: [GIT PULL] first round of SCSI updates for the 6.7+ merge window
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel
	 <linux-kernel@vger.kernel.org>
Date: Wed, 10 Jan 2024 15:48:41 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updates to the usual drivers (ufs, mpi3mr, mpt3sas, lpfc, fnic,
hisi_sas, arcmsr, ) plus the usual assorted minor fixes and updates. 
This time around there's only a single line update to the core, so
nothing major and barely anything minor.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Abhinav Singh (1):
      scsi: dc395x: Fix warning using plain integer as NULL

Akinobu Mita (1):
      scsi: ufs: core: Make fault injection dynamically configurable per HBA

Arnd Bergmann (1):
      scsi: mpi3mr: Fix printk() format strings

Artem Chernyshev (2):
      scsi: isci: Remove redundant check in isci_task_request_build()
      scsi: fnic: Return error if vmalloc() failed

Bao D. Nguyen (1):
      scsi: ufs: ufs-qcom: Add support for UFS device version detection

Bart Van Assche (5):
      scsi: ufs: core: Simplify ufshcd_auto_hibern8_update()
      scsi: ufs: core: Rename ufshcd_auto_hibern8_enable() and make it static
      scsi: ufs: core: Warn if the request tag is truncated
      scsi: core: Add a precondition check in scsi_eh_scmd_add()
      scsi: bfa: Use the proper data type for BLIST flags

Bean Huo (3):
      scsi: ufs: core: Add sysfs node for UFS RTC update
      scsi: ufs: core: Add UFS RTC support
      scsi: ufs: core: Add ufshcd_is_ufs_dev_busy()

Benjamin Coddington (1):
      scsi: target: Enable READ CAPACITY for PR EARO

Can Guo (8):
      scsi: ufs: ufs-qcom: Check return value of phy_set_mode_ext()
      scsi: ufs: ufs-qcom: Set initial PHY gear to max HS gear for HW ver 4 and newer
      scsi: ufs: ufs-qcom: Limit HS-G5 Rate-A to hosts with HW version 5
      scsi: ufs: ufs-qcom: Allow the first init start with the maximum supported gear
      scsi: ufs: ufs-qcom: Setup host power mode during init
      scsi: ufs: ufs-qcom: No need to set hs_rate after ufshcd_init_host_param()
      scsi: ufs: host: Rename structure ufs_dev_params to ufs_host_params
      scsi: ufs: ufs-sysfs: Expose UFS power info

Chandrakanth patil (8):
      scsi: mpi3mr: Update driver version to 8.5.1.0.0
      scsi: mpi3mr: Support for preallocation of SGL BSG data buffers part-3
      scsi: mpi3mr: Support for preallocation of SGL BSG data buffers part-2
      scsi: mpi3mr: Support for preallocation of SGL BSG data buffers part-1
      scsi: mpi3mr: Fetch correct device dev handle for status reply descriptor
      scsi: mpi3mr: Block PEL Enable Command on Controller Reset and Unrecoverable State
      scsi: mpi3mr: Clean up block devices post controller reset
      scsi: mpi3mr: Refresh sdev queue depth after controller reset

Hannes Reinecke (3):
      scsi: libfc: Map FC_TIMED_OUT to DID_TIME_OUT
      scsi: libfc: Fix up timeout error in fc_fcp_rec_error()
      scsi: libfc: Don't schedule abort twice

James Seo (12):
      scsi: mpt3sas: Replace dynamic allocations with local variables
      scsi: mpt3sas: Replace a dynamic allocation with a local variable
      scsi: mpt3sas: Fix typo of "TRIGGER"
      scsi: mpt3sas: Fix an outdated comment
      scsi: mpt3sas: Remove the iounit_pg8 member of the per-adapter struct
      scsi: mpt3sas: Use struct_size() for struct size calculations
      scsi: mpt3sas: Make MPI26_CONFIG_PAGE_PIOUNIT_1::PhyData[] a flexible array
      scsi: mpt3sas: Make MPI2_CONFIG_PAGE_SASIOUNIT_1::PhyData[] a flexible array
      scsi: mpt3sas: Make MPI2_CONFIG_PAGE_SASIOUNIT_0::PhyData[] a flexible array
      scsi: mpt3sas: Make MPI2_CONFIG_PAGE_RAID_VOL_0::PhysDisk[] a flexible array
      scsi: mpt3sas: Make MPI2_CONFIG_PAGE_IO_UNIT_8::Sensor[] a flexible array
      scsi: mpt3sas: Use flexible arrays when obviously possible

Justin Stitt (8):
      scsi: fcoe: Use sysfs_match_string() over fcoe_parse_mode()
      scsi: ibmvscsi: Replace deprecated strncpy() with strscpy()
      scsi: ibmvfc: Replace deprecated strncpy() with strscpy()
      scsi: elx: libefc: Replace deprecated strncpy() with strscpy_pad()/memcpy()
      scsi: csiostor: Replace deprecated strncpy() with strscpy()
      scsi: ch: Replace deprecated strncpy() with strscpy()
      scsi: bnx2fc: Replace deprecated strncpy() with strscpy()
      scsi: 3w-sas: Replace deprecated strncpy() with strscpy()

Justin Tee (13):
      scsi: lpfc: Update lpfc version to 14.2.0.17
      scsi: lpfc: Move determination of vmid_flag after VMID reinitialization completes
      scsi: lpfc: Reinitialize an NPIV's VMID data structures after FDISC
      scsi: lpfc: Change VMID driver load time parameters to read only
      scsi: lpfc: Copyright updates for 14.2.0.16 patches
      scsi: lpfc: Update lpfc version to 14.2.0.16
      scsi: lpfc: Enhance driver logging for selected discovery events
      scsi: lpfc: Refactor and clean up mailbox command memory free
      scsi: lpfc: Return early in lpfc_poll_eratt() when the driver is unloading
      scsi: lpfc: Eliminate unnecessary relocking in lpfc_check_nlp_post_devloss()
      scsi: lpfc: Fix list_entry null check warning in lpfc_cmpl_els_plogi()
      scsi: lpfc: Fix possible file string name overflow when updating firmware
      scsi: lpfc: Correct maximum PCI function value for RAS fw logging

Karan Tilak Kumar (13):
      scsi: fnic: Increment driver version
      scsi: fnic: Improve logs and add support for multiqueue (MQ)
      scsi: fnic: Add support for multiqueue (MQ) in fnic driver
      scsi: fnic: Add support for multiqueue (MQ) in fnic_main.c
      scsi: fnic: Remove usage of host_lock
      scsi: fnic: Define stats to track multiqueue (MQ) IOs
      scsi: fnic: Modify ISRs to support multiqueue (MQ)
      scsi: fnic: Refactor and redefine fnic.h for multiqueue
      scsi: fnic: Get copy workqueue count and interrupt mode from config
      scsi: fnic: Rename wq_copy to hw_copy_wq
      scsi: fnic: Add and improve log messages
      scsi: fnic: Add and use fnic number
      scsi: fnic: Modify definitions to sync with VIC firmware

Kees Cook (1):
      scsi: zfcp: Replace strlcpy() with strscpy()

Manivannan Sadhasivam (18):
      scsi: ufs: qcom: Fix ESI vector mask
      scsi: ufs: qcom: Remove unused definitions
      scsi: ufs: qcom: Use ufshcd_rmwl() where applicable
      scsi: ufs: qcom: Remove support for host controllers older than v2.0
      scsi: ufs: qcom: Simplify ufs_qcom_{assert/deassert}_reset
      scsi: ufs: qcom: Initialize cycles_in_1us variable in ufs_qcom_set_core_clk_ctrl()
      scsi: ufs: qcom: Sort includes alphabetically
      scsi: ufs: qcom: Remove unused ufs_qcom_hosts struct array
      scsi: ufs: qcom: Use dev_err_probe() to simplify error handling of devm_gpiod_get_optional()
      scsi: ufs: qcom: Remove redundant error print for devm_kzalloc() failure
      scsi: ufs: qcom: Check the return value of ufs_qcom_power_up_sequence()
      scsi: ufs: qcom: Fail ufs_qcom_power_up_sequence() when core_reset fails
      scsi: ufs: qcom: Export ufshcd_{enable/disable}_irq helpers and make use of them
      scsi: ufs: qcom: Remove the warning message when core_reset is not available
      scsi: ufs: qcom: Remove superfluous variable assignments
      scsi: ufs: qcom: Fix the return value when platform_get_resource_byname() fails
      scsi: ufs: qcom: Fix the return value of ufs_qcom_ice_program_key()
      scsi: ufs: qcom: Use clk_bulk APIs for managing lane clocks

Martin K. Petersen (1):
      scsi: ufs: host: Fix kernel-doc warning

Michael Ellerman (1):
      scsi: ipr: Remove obsolete check for old CPUs

Nitin Rawat (1):
      scsi: ufs: qcom: dt-bindings: Add SC7280 compatible string

Stanley Jhu (1):
      scsi: ufs: mediatek: Change the maintainer for MediaTek UFS hooks

Su Hui (3):
      scsi: aic7xxx: Return negative error codes in aic7770_probe()
      scsi: aic7xxx: Return ahc_linux_register_host()'s value rather than zero
      scsi: aic7xxx: Return negative error codes in ahc_linux_register_host()

Sumit Saxena (5):
      scsi: mpi3mr: driver version upgrade to 8.5.0.0.50
      scsi: mpi3mr: Add support for status reply descriptor
      scsi: mpi3mr: Increase maximum number of PHYs to 64 from 32
      scsi: mpi3mr: Add PCI checks where SAS5116 diverges from SAS4116
      scsi: mpi3mr: Add support for SAS5116 PCI IDs

Tomas Henzl (1):
      scsi: mpt3sas: Suppress a warning in debug kernel

Uwe Kleine-König (14):
      scsi: sun_esp: Convert to platform remove callback returning void
      scsi: sun3x_esp: Convert to platform remove callback returning void
      scsi: sun3: Convert to platform remove callback returning void
      scsi: sni_53c710: Convert to platform remove callback returning void
      scsi: sgiwd93: Convert to platform remove callback returning void
      scsi: qlogicpti: Convert to platform remove callback returning void
      scsi: mvme16x: Convert to platform remove callback returning void
      scsi: mac: Convert to platform remove callback returning void
      scsi: mac_esp: Convert to platform remove callback returning void
      scsi: jazz_esp: Convert to platform remove callback returning void
      scsi: bvme6000: Convert to platform remove callback returning void
      scsi: atari: Convert to platform remove callback returning void
      scsi: a4000t: Convert to platform remove callback returning void
      scsi: a3000: Convert to platform remove callback returning void

Yihang Li (5):
      scsi: hisi_sas: Correct the number of global debugfs registers
      scsi: hisi_sas: Rollback some operations if FLR failed
      scsi: hisi_sas: Check before using pointer variables
      scsi: hisi_sas: Replace with standard error code return value
      scsi: hisi_sas: Set .phy_attached before notifing phyup event HISI_PHYE_PHY_UP_PM

Ziqi Chen (1):
      scsi: ufs: dt-bindings: Add msi-parent for UFS MCQ

ching Huang (3):
      scsi: arcmsr: Update driver version to v1.51.00.14-20230915
      scsi: arcmsr: Support new PCI device IDs 1883 and 1886
      scsi: arcmsr: Support new RAID controller ARC-1688

And the diffstat:

 Documentation/ABI/testing/sysfs-driver-ufs         |  56 ++
 .../devicetree/bindings/ufs/qcom,ufs.yaml          |   2 +
 .../devicetree/bindings/ufs/ufs-common.yaml        |   2 +
 MAINTAINERS                                        |   3 +-
 drivers/s390/scsi/zfcp_fc.c                        |  15 +-
 drivers/scsi/3w-sas.c                              |   3 +-
 drivers/scsi/a3000.c                               |   5 +-
 drivers/scsi/a4000t.c                              |   5 +-
 drivers/scsi/aic7xxx/aic7770_osm.c                 |   6 +-
 drivers/scsi/aic7xxx/aic7xxx_osm.c                 |   2 +-
 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c             |   3 +-
 drivers/scsi/arcmsr/arcmsr.h                       |  29 +-
 drivers/scsi/arcmsr/arcmsr_hba.c                   |  96 ++-
 drivers/scsi/atari_scsi.c                          |   5 +-
 drivers/scsi/bfa/bfad_bsg.c                        |   2 +-
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                  |  14 +-
 drivers/scsi/bvme6000_scsi.c                       |   6 +-
 drivers/scsi/ch.c                                  |  12 +-
 drivers/scsi/csiostor/csio_init.c                  |   3 +-
 drivers/scsi/dc395x.c                              |   2 +-
 drivers/scsi/elx/libefc/efc_node.h                 |  12 +-
 drivers/scsi/fcoe/fcoe_sysfs.c                     |  26 +-
 drivers/scsi/fnic/fnic.h                           |  68 +-
 drivers/scsi/fnic/fnic_debugfs.c                   |   3 +-
 drivers/scsi/fnic/fnic_fcs.c                       |  63 +-
 drivers/scsi/fnic/fnic_isr.c                       | 168 ++--
 drivers/scsi/fnic/fnic_main.c                      | 144 ++--
 drivers/scsi/fnic/fnic_res.c                       |  48 +-
 drivers/scsi/fnic/fnic_scsi.c                      | 868 ++++++++++++---------
 drivers/scsi/fnic/fnic_stats.h                     |   3 +
 drivers/scsi/fnic/fnic_trace.c                     |  11 +
 drivers/scsi/fnic/vnic_dev.c                       |   4 +
 drivers/scsi/fnic/vnic_scsi.h                      |  13 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c              |  11 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |  19 +-
 drivers/scsi/ibmvscsi/ibmvfc.c                     |  12 +-
 drivers/scsi/ibmvscsi/ibmvscsi.c                   |   2 +-
 drivers/scsi/ipr.c                                 |  55 --
 drivers/scsi/isci/request.c                        |   5 +-
 drivers/scsi/isci/request.h                        |   2 +-
 drivers/scsi/isci/task.c                           |   4 +-
 drivers/scsi/jazz_esp.c                            |   6 +-
 drivers/scsi/libfc/fc_fcp.c                        |  22 +-
 drivers/scsi/lpfc/lpfc.h                           |   1 +
 drivers/scsi/lpfc/lpfc_attr.c                      |  12 +-
 drivers/scsi/lpfc/lpfc_els.c                       |  67 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c                   |   2 +-
 drivers/scsi/lpfc/lpfc_init.c                      |   4 +-
 drivers/scsi/lpfc/lpfc_mbox.c                      |   6 +-
 drivers/scsi/lpfc/lpfc_mem.c                       |  47 +-
 drivers/scsi/lpfc/lpfc_sli.c                       |  20 +-
 drivers/scsi/lpfc/lpfc_sli.h                       |  10 +-
 drivers/scsi/lpfc/lpfc_version.h                   |   2 +-
 drivers/scsi/lpfc/lpfc_vmid.c                      |   1 +
 drivers/scsi/mac_esp.c                             |   6 +-
 drivers/scsi/mac_scsi.c                            |   5 +-
 drivers/scsi/mpi3mr/mpi/mpi30_ioc.h                |   1 +
 drivers/scsi/mpi3mr/mpi3mr.h                       |  33 +-
 drivers/scsi/mpi3mr/mpi3mr_app.c                   | 536 ++++++++++---
 drivers/scsi/mpi3mr/mpi3mr_fw.c                    | 118 ++-
 drivers/scsi/mpi3mr/mpi3mr_os.c                    |  33 +-
 drivers/scsi/mpi3mr/mpi3mr_transport.c             |  16 +-
 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h               | 231 ++----
 drivers/scsi/mpt3sas/mpi/mpi2_image.h              |  32 +-
 drivers/scsi/mpt3sas/mpi/mpi2_ioc.h                |  27 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c                |  35 +-
 drivers/scsi/mpt3sas/mpt3sas_base.h                |   3 +-
 drivers/scsi/mpt3sas/mpt3sas_config.c              |   6 +-
 drivers/scsi/mpt3sas/mpt3sas_ctl.c                 |  42 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |  56 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c           |   9 +-
 drivers/scsi/mpt3sas/mpt3sas_trigger_pages.h       |  44 +-
 drivers/scsi/mpt3sas/mpt3sas_warpdrive.c           |   3 +-
 drivers/scsi/mvme16x_scsi.c                        |   6 +-
 drivers/scsi/qlogicpti.c                           |   6 +-
 drivers/scsi/scsi_error.c                          |   1 +
 drivers/scsi/sgiwd93.c                             |   5 +-
 drivers/scsi/sni_53c710.c                          |   6 +-
 drivers/scsi/sun3_scsi.c                           |   5 +-
 drivers/scsi/sun3x_esp.c                           |   6 +-
 drivers/scsi/sun_esp.c                             |   6 +-
 drivers/target/target_core_pr.c                    |   1 +
 drivers/ufs/core/ufs-fault-injection.c             |  19 +-
 drivers/ufs/core/ufs-fault-injection.h             |  13 +-
 drivers/ufs/core/ufs-sysfs.c                       | 151 ++++
 drivers/ufs/core/ufshcd.c                          | 154 +++-
 drivers/ufs/host/ufs-exynos.c                      |   7 +-
 drivers/ufs/host/ufs-hisi.c                        |  11 +-
 drivers/ufs/host/ufs-mediatek.c                    |  12 +-
 drivers/ufs/host/ufs-qcom.c                        | 472 +++--------
 drivers/ufs/host/ufs-qcom.h                        |  57 +-
 drivers/ufs/host/ufshcd-pltfrm.c                   |  69 +-
 drivers/ufs/host/ufshcd-pltfrm.h                   |  10 +-
 include/uapi/scsi/scsi_bsg_mpi3mr.h                |   2 +
 include/ufs/ufs.h                                  |  14 +
 include/ufs/ufshcd.h                               |  12 +-
 include/ufs/unipro.h                               |   4 +-
 97 files changed, 2567 insertions(+), 1730 deletions(-)

James


