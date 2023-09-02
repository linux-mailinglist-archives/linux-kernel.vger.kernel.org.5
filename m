Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFDE7905CE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 09:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351735AbjIBHj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 03:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237687AbjIBHjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 03:39:25 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF821B4
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 00:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1693640359;
        bh=72jvGsMbaLqtJDjGj/syYm98ANE2aGXGlry6noHtsfM=;
        h=Message-ID:Subject:From:To:Date:From;
        b=NvedaXUeGtHQwwvoTFneCapKpaEgXWox4Yv3au/6zuabRXQ17NpOWO0Iy2RqR1GaT
         jCZ7i3ds7+esuduifvFJu+w9yrMC/gRPzbNGGVwZXjPaI21qcKnKldXjbKCabAf31G
         W79QK6PHgiXQhBa73J+vXFrfXHMkDni8UMARa60g=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2C2A41285D97;
        Sat,  2 Sep 2023 03:39:19 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id L4DB55Bju1ft; Sat,  2 Sep 2023 03:39:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1693640358;
        bh=72jvGsMbaLqtJDjGj/syYm98ANE2aGXGlry6noHtsfM=;
        h=Message-ID:Subject:From:To:Date:From;
        b=V6aj5EH6ZPgx+jJB5rYbLcVzPhaQu4fCEgZorjNwECnr6YvESJg4WqMim/EGNFFe+
         h1FNsgEKimNkHh1PEFrOw7ZZRUjtCfyoCwyJnpJEjHhz6xcxpaIHNyQ/7rUbKRnI8g
         xlnKfCryYYDzfLZVxcxKFP/gso2doR5952xX0MRk=
Received: from [IPv6:2a00:23c8:1005:a801:e95:68ca:9caa:7c8c] (unknown [IPv6:2a00:23c8:1005:a801:e95:68ca:9caa:7c8c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 99EAC12818AF;
        Sat,  2 Sep 2023 03:39:17 -0400 (EDT)
Message-ID: <6908480e8808a2d025926f2ff1f9a2468d1b6bb9.camel@HansenPartnership.com>
Subject: [GIT PULL] first round of SCSI updates for the 6.4+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 02 Sep 2023 08:39:13 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates to the usual drivers (ufs, lpfc, qla2xxx, mpi3mr, libsas) and
the usual minor updates and bug fixes but no significant core changes.

There is a top level merge to pull in a stray fix that missed the last
-rc cutoff.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Alex Henrie (2):
      scsi: ppa: Add a module parameter for the transfer mode
      scsi: ppa: Fix compilation with PPA_DEBUG=1

Andy Shevchenko (1):
      scsi: lpfc: Do not abuse UUID APIs and LPFC_COMPRESS_VMID_SIZE

Arnd Bergmann (3):
      scsi: gvp11: Remove unused gvp11_setup() function
      scsi: qlogicpti: Mark qlogicpti_info() static
      scsi: ufs: qcom: Remove unused variable

Artem Chernyshev (1):
      scsi: isci: Return result of sas_register_ha()

Bart Van Assche (18):
      scsi: ufs: core: Fix the build for gcc 9 and before
      scsi: ufs: Simplify response header parsing
      scsi: ufs: Simplify transfer request header initialization
      scsi: ufs: Remove a member variable
      scsi: ufs: Simplify ufshcd_abort_all()
      scsi: ufs: Remove a local variable from ufshcd_abort_all()
      scsi: ufs: Improve type safety
      scsi: ufs: Simplify zero-initialization
      scsi: ufs: Minimize #include directives
      scsi: ufs: Rename a function argument
      scsi: ufs: Fix kernel-doc headers
      scsi: ufs: Document all return values
      scsi: ufs: Follow the kernel-doc syntax for documenting return values
      scsi: ufs: Fix residual handling
      scsi: RDMA/srp: Fix residual handling
      scsi: ufs: core: Remove HPB support
      scsi: core: Fix the scsi_set_resid() documentation
      scsi: ufs: core: Convert UPIU_HEADER_DWORD() into a function

Brian Masney (2):
      scsi: ufs: host: Convert to dev_err_probe() in ufshcd_pltfrm_init()
      scsi: ufs: core: Convert to dev_err_probe() in ufshcd_variant_hba_init()

Chengfeng Ye (1):
      scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock

Gustavo A. R. Silva (1):
      scsi: bfa: Replace one-element array with flexible-array member in struct fc_rscn_pl_s

Igor Pylypiv (2):
      scsi: pm80xx: Set RETFIS when requested by libsas
      scsi: libsas: Add return_fis_on_success to sas_ata_task

Jeuk Kim (1):
      scsi: ufs: ufs-pci: Add support for QEMU

Jialin Zhang (3):
      scsi: megaraid: Use pci_dev_id() to simplify the code
      scsi: megaraid_sas: Use pci_dev_id() to simplify the code
      scsi: mvumi: Use pci_dev_id() to simplify the code

John Garry (10):
      scsi: libsas: Delete sas_ata_task.retry_count
      scsi: libsas: Delete sas_ata_task.stp_affil_pol
      scsi: libsas: Delete sas_ata_task.set_affil_pol
      scsi: libsas: Delete sas_ssp_task.task_prio
      scsi: libsas: Delete sas_ssp_task.enable_first_burst
      scsi: libsas: Delete sas_ssp_task.retry_count
      scsi: libsas: Delete struct scsi_core
      scsi: libsas: Delete enum sas_phy_type
      scsi: libsas: Delete enum sas_class
      scsi: libsas: Delete sas_ha_struct.lldd_module

Justin Tee (13):
      scsi: lpfc: Modify when a node should be put in device recovery mode during RSCN
      scsi: lpfc: Copyright updates for 14.2.0.14 patches
      scsi: lpfc: Update lpfc version to 14.2.0.14
      scsi: lpfc: Clean up SLI-4 sysfs resource reporting
      scsi: lpfc: Refactor cpu affinity assignment paths
      scsi: lpfc: Abort outstanding ELS cmds when mailbox timeout error is detected
      scsi: lpfc: Make fabric zone discovery more robust when handling unsolicited LOGO
      scsi: lpfc: Set Establish Image Pair service parameter only for Target Functions
      scsi: lpfc: Revise ndlp kref handling for dev_loss_tmo_callbk and lpfc_drop_node
      scsi: lpfc: Qualify ndlp discovery state when processing RSCN
      scsi: lpfc: Remove extra ndlp kref decrement in FLOGI cmpl for loop topology
      scsi: lpfc: Simplify fcp_abort transport callback log message
      scsi: lpfc: Pull out fw diagnostic dump log message from driver's trace buffer

Konstantin Shelekhin (2):
      scsi: target: iscsi: Stop using sprintf() in iscsi_target_configfs.c
      scsi: target: iscsi: Fix buffer overflow in lio_target_nacl_info_show()

Lin Ma (4):
      scsi: qla4xxx: Add length check when parsing nlattrs
      scsi: be2iscsi: Add length check when parsing nlattrs
      scsi: iscsi: Add strlen() check in iscsi_if_set{_host}_param()
      scsi: iscsi: Add length check for nlattr payload

Manivannan Sadhasivam (3):
      scsi: ufs: qcom: Make struct ufs_qcom_bw_table static const
      scsi: ufs: qcom: Add support for scaling interconnects
      scsi: ufs: core: Add enums for UFS lanes

Maurizio Lombardi (1):
      scsi: target: iscsi: Remove the unused netif_timeout attribute

Michael Kelley (1):
      scsi: storvsc: Handle additional SRB status values

Mike Christie (1):
      scsi: target: Fix write perf due to unneeded throttling

Nilesh Javali (1):
      scsi: qla2xxx: Update version to 10.02.08.500-k

Nitin Rawat (3):
      scsi: ufs: ufs-qcom: Check host controller state
      scsi: ufs: core: Export ufshcd_is_hba_active()
      scsi: ufs: ufs-qcom: Change UFS devfreq timer to delayed

Oleksandr Natalenko (3):
      scsi: qedf: Do not touch __user pointer in qedf_dbg_fp_int_cmd_read() directly
      scsi: qedf: Do not touch __user pointer in qedf_dbg_debug_cmd_read() directly
      scsi: qedf: Do not touch __user pointer in qedf_dbg_stop_io_on_error_cmd_read() directly

Po-Wen Kao (2):
      scsi: ufs: ufs-mediatek: Add MCQ support for MTK platform
      scsi: ufs: core: Export symbols for MTK driver module

Quinn Tran (9):
      scsi: qla2xxx: fix inconsistent TMF timeout
      scsi: qla2xxx: Fix TMF leak through
      scsi: qla2xxx: Turn off noisy message log
      scsi: qla2xxx: Fix session hang in gnl
      scsi: qla2xxx: Fix erroneous link up failure
      scsi: qla2xxx: Fix command flush during TMF
      scsi: qla2xxx: Limit TMF to 8 per function
      scsi: qla2xxx: Adjust IOCB resource on qpair create
      scsi: qla2xxx: Fix deletion race condition

Rajeshwar R Shinde (1):
      scsi: elx: sli4: Remove code duplication

Ranjan Kumar (6):
      scsi: mpi3mr: Update driver version to 8.5.0.0.0
      scsi: mpi3mr: Enhance handling of devices removed after controller reset
      scsi: mpi3mr: WRITE SAME implementation
      scsi: mpi3mr: Add support for more than 1MB I/O
      scsi: mpi3mr: Update MPI Headers to version 3.00.28
      scsi: mpi3mr: Invoke soft reset upon TSU or event ack time out

Rob Herring (3):
      scsi: sun_esp: Explicitly include correct DT includes
      scsi: qlogicpti: Explicitly include correct DT includes
      scsi: ufs: Explicitly include correct DT includes

Sunil V L (1):
      scsi: hisi_sas: Fix warning detected by sparse

Tony Battersby (1):
      scsi: core: Use 32-bit hostnum in scsi_host_lookup()

Udit Kumar (1):
      scsi: ufs: ti-j721e: Expose device tree aliases

Wang Jinchao (1):
      scsi: aic7xxx: Fix firmware build fatal error

Xiang Yang (1):
      scsi: arcmsr: Add __init and __exit for arcmsr_module_{init,exit}()

Xingui Yang (1):
      scsi: hisi_sas: Fix normally completed I/O analysed as failed

Yang Li (2):
      scsi: ufs: core: Fix some kernel-doc comments
      scsi: ufs: ufs-mediatek: Remove redundant dev_err()

Yihang Li (2):
      scsi: hisi_sas: Delete unused lock in hisi_sas_port_notify_formed()
      scsi: hisi_sas: Block requests before a debugfs snapshot

Yue Haibing (4):
      scsi: pm8001: Remove unused declarations
      scsi: qla2xxx: Remove unused declarations
      scsi: core: Remove unused extern declarations
      scsi: libsas: Remove unused declarations

YueHaibing (1):
      scsi: iscsi: Remove unused extern declaration iscsi_lookup_iface()

Zheng Zengkai (1):
      scsi: pmcraid: Use pci_dev_id() to simplify the code

Ziqi Chen (2):
      scsi: ufs: qcom: Hold the mutex lock when configuring ESI
      scsi: ufs: qcom: Get queue ID from MSI index in ESI handler

And the diffstat:

 Documentation/ABI/testing/sysfs-driver-ufs   |  247 ---
 Documentation/scsi/scsi_mid_low_api.rst      |    4 +-
 drivers/infiniband/ulp/srp/ib_srp.c          |    4 -
 drivers/scsi/Kconfig                         |    2 +-
 drivers/scsi/aic7xxx/aicasm/Makefile         |   18 +-
 drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c  |    1 +
 drivers/scsi/aic94xx/aic94xx_hwi.c           |    4 +-
 drivers/scsi/aic94xx/aic94xx_init.c          |    7 +-
 drivers/scsi/aic94xx/aic94xx_task.c          |   12 +-
 drivers/scsi/arcmsr/arcmsr_hba.c             |    4 +-
 drivers/scsi/be2iscsi/be_iscsi.c             |    4 +
 drivers/scsi/bfa/bfa_fc.h                    |    2 +-
 drivers/scsi/bfa/bfa_fcbuild.c               |    2 +-
 drivers/scsi/elx/libefc_sli/sli4.c           |    8 +-
 drivers/scsi/fcoe/fcoe_ctlr.c                |   20 +-
 drivers/scsi/gvp11.c                         |    5 -
 drivers/scsi/hisi_sas/hisi_sas_main.c        |   14 +-
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c       |    9 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c       |   14 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c       |   27 +-
 drivers/scsi/hosts.c                         |    4 +-
 drivers/scsi/isci/host.h                     |    2 +-
 drivers/scsi/isci/init.c                     |    9 +-
 drivers/scsi/isci/phy.c                      |    2 -
 drivers/scsi/isci/request.c                  |    2 +-
 drivers/scsi/libsas/sas_ata.c                |   12 +-
 drivers/scsi/libsas/sas_discover.c           |    8 +-
 drivers/scsi/libsas/sas_expander.c           |    2 +-
 drivers/scsi/libsas/sas_host_smp.c           |    4 +-
 drivers/scsi/libsas/sas_init.c               |   16 +-
 drivers/scsi/libsas/sas_internal.h           |    7 -
 drivers/scsi/libsas/sas_phy.c                |    8 +-
 drivers/scsi/libsas/sas_port.c               |    8 +-
 drivers/scsi/libsas/sas_scsi_host.c          |   15 +-
 drivers/scsi/lpfc/lpfc.h                     |   23 +-
 drivers/scsi/lpfc/lpfc_attr.c                |  136 +-
 drivers/scsi/lpfc/lpfc_ct.c                  |   20 +-
 drivers/scsi/lpfc/lpfc_els.c                 |   70 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c             |   77 +-
 drivers/scsi/lpfc/lpfc_hw.h                  |    2 +
 drivers/scsi/lpfc/lpfc_init.c                |   53 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c           |   94 +-
 drivers/scsi/lpfc/lpfc_nvme.c                |   16 +-
 drivers/scsi/lpfc/lpfc_nvmet.c               |    5 +-
 drivers/scsi/lpfc/lpfc_sli.c                 |    8 +-
 drivers/scsi/lpfc/lpfc_version.h             |    2 +-
 drivers/scsi/megaraid/megaraid_mbox.c        |    2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c    |    2 +-
 drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h         |    2 +-
 drivers/scsi/mpi3mr/mpi/mpi30_ioc.h          |    1 +
 drivers/scsi/mpi3mr/mpi/mpi30_transport.h    |    2 +-
 drivers/scsi/mpi3mr/mpi3mr.h                 |   23 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c              |   37 +-
 drivers/scsi/mpi3mr/mpi3mr_os.c              |  155 +-
 drivers/scsi/mvsas/mv_init.c                 |    7 +-
 drivers/scsi/mvsas/mv_sas.c                  |    9 +-
 drivers/scsi/mvumi.c                         |    2 +-
 drivers/scsi/pm8001/pm8001_hwi.c             |   12 +-
 drivers/scsi/pm8001/pm8001_hwi.h             |    2 +-
 drivers/scsi/pm8001/pm8001_init.c            |    5 +-
 drivers/scsi/pm8001/pm8001_sas.h             |    2 -
 drivers/scsi/pm8001/pm80xx_hwi.c             |   27 +-
 drivers/scsi/pm8001/pm80xx_hwi.h             |    2 +-
 drivers/scsi/pmcraid.c                       |    3 +-
 drivers/scsi/ppa.c                           |   84 +-
 drivers/scsi/ppa.h                           |    4 -
 drivers/scsi/qedf/qedf_dbg.h                 |    2 +
 drivers/scsi/qedf/qedf_debugfs.c             |   35 +-
 drivers/scsi/qla2xxx/qla_def.h               |    9 +-
 drivers/scsi/qla2xxx/qla_gbl.h               |   11 +-
 drivers/scsi/qla2xxx/qla_init.c              |  217 ++-
 drivers/scsi/qla2xxx/qla_iocb.c              |    1 +
 drivers/scsi/qla2xxx/qla_isr.c               |    7 +-
 drivers/scsi/qla2xxx/qla_mbx.c               |    3 +
 drivers/scsi/qla2xxx/qla_nvme.c              |    3 +-
 drivers/scsi/qla2xxx/qla_os.c                |   11 +-
 drivers/scsi/qla2xxx/qla_target.c            |   14 +-
 drivers/scsi/qla2xxx/qla_version.h           |    4 +-
 drivers/scsi/qla4xxx/ql4_os.c                |   15 +
 drivers/scsi/qlogicpti.c                     |    4 +-
 drivers/scsi/scsi_priv.h                     |    2 -
 drivers/scsi/scsi_transport_iscsi.c          |   80 +-
 drivers/scsi/storvsc_drv.c                   |    7 +
 drivers/scsi/sun_esp.c                       |    3 +-
 drivers/target/iscsi/iscsi_target_configfs.c |   74 +-
 drivers/target/iscsi/iscsi_target_tpg.c      |   26 -
 drivers/target/iscsi/iscsi_target_tpg.h      |    1 -
 drivers/target/target_core_iblock.c          |    7 +-
 drivers/ufs/core/Kconfig                     |    8 -
 drivers/ufs/core/Makefile                    |    1 -
 drivers/ufs/core/ufs-hwmon.c                 |    3 +-
 drivers/ufs/core/ufs-mcq.c                   |   34 +-
 drivers/ufs/core/ufs-sysfs.c                 |   22 -
 drivers/ufs/core/ufs_bsg.c                   |    2 +
 drivers/ufs/core/ufshcd-crypto.h             |   20 +-
 drivers/ufs/core/ufshcd-priv.h               |    4 +-
 drivers/ufs/core/ufshcd.c                    |  627 +++---
 drivers/ufs/core/ufshpb.c                    | 2668 --------------------------
 drivers/ufs/core/ufshpb.h                    |  318 ---
 drivers/ufs/host/cdns-pltfrm.c               |   27 +-
 drivers/ufs/host/tc-dwc-g210-pci.c           |    2 +-
 drivers/ufs/host/tc-dwc-g210.c               |   32 +-
 drivers/ufs/host/ti-j721e-ufs.c              |    2 +
 drivers/ufs/host/ufs-mediatek.c              |  180 +-
 drivers/ufs/host/ufs-mediatek.h              |   33 +
 drivers/ufs/host/ufs-qcom.c                  |  174 +-
 drivers/ufs/host/ufs-qcom.h                  |    4 +-
 drivers/ufs/host/ufs-renesas.c               |    2 +-
 drivers/ufs/host/ufshcd-dwc.c                |   22 +-
 drivers/ufs/host/ufshcd-pci.c                |    3 +-
 drivers/ufs/host/ufshcd-pltfrm.c             |   13 +-
 include/scsi/libsas.h                        |   32 +-
 include/scsi/scsi_host.h                     |    2 +-
 include/scsi/scsi_transport_iscsi.h          |    1 -
 include/target/iscsi/iscsi_target_core.h     |    4 -
 include/uapi/scsi/scsi_bsg_ufs.h             |   52 +-
 include/ufs/ufs.h                            |   90 +-
 include/ufs/ufs_quirks.h                     |    6 -
 include/ufs/ufshcd.h                         |   60 +-
 include/ufs/ufshci.h                         |   53 +-
 include/ufs/unipro.h                         |    6 +
 121 files changed, 1878 insertions(+), 4561 deletions(-)
 delete mode 100644 drivers/ufs/core/ufshpb.c
 delete mode 100644 drivers/ufs/core/ufshpb.h

James

