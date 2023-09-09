Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B397999D5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbjIIQ0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjIIOrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 10:47:33 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC3A18F;
        Sat,  9 Sep 2023 07:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1694270849;
        bh=3grigik/ZiBKqwMR4+wDAQNXIu7S6TaG5KgFISLxyZ0=;
        h=Message-ID:Subject:From:To:Date:From;
        b=NcGnV1HB1KkXJRBxU8aFLZkZ38HOHmFsm2dchXMwgWaB+fvLyIbCrJRrdpCoOQ9DQ
         EHEwIlFMtsOFY/TgEmAYVDmMDCkVUt1ofikyV6h4BoihpXaXQ6BZn8rWbRamfzrWCU
         MyJx/lr/+I7CTsboqTRsfOv+qS11BkEsReXKZCbA=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 11A9B1280AC2;
        Sat,  9 Sep 2023 10:47:29 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id KsYcfblZMwsH; Sat,  9 Sep 2023 10:47:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1694270848;
        bh=3grigik/ZiBKqwMR4+wDAQNXIu7S6TaG5KgFISLxyZ0=;
        h=Message-ID:Subject:From:To:Date:From;
        b=iyl1TEeBCnTmHmw1qfNHS7kup5JYfqplhyoDWqipje5W54jDGhmWN76A+SrP1/r5Q
         vOMKnV2hBH78exEwQORzQEeobGI8RpedVtRTYM6GskNDZgy00lbU6Cw2/qWwRdd6wH
         QaUJO00QOTSFsUePTfMuiEGc4DdpqQunjUpLzOSE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5115A128093C;
        Sat,  9 Sep 2023 10:47:28 -0400 (EDT)
Message-ID: <285d43b9cbe7bc2b9aaa8537345f14aeec93c982.camel@HansenPartnership.com>
Subject: [GIT PULL] final round of SCSI updates for the 6.5+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 09 Sep 2023 10:47:26 -0400
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

Mostly small stragglers that missed the initial merge.  Driver updates
are qla2xxx and smartpqi (mp3sas has a high diffstat due to the
volatile qualifier removal, fnic due to unused function removal and
sd.c has a lot of code shuffling to remove forward declarations).

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Bart Van Assche (4):
      scsi: ufs: Fix the build for the old ARM OABI
      scsi: sd: Remove the number of forward declarations
      scsi: core: Report error list information in debugfs
      scsi: core: Improve type safety of scsi_rescan_device()

Bean Huo (2):
      scsi: ufs: core: No need to update UPIU.header.flags and lun in advanced RPMB handler
      scsi: ufs: core: Add advanced RPMB support where UFSHCI 4.0 does not support EHS length in UTRD

Bikash Hazarika (1):
      scsi: qla2xxx: Add logs for SFP temperature monitoring

Colin Ian King (1):
      scsi: qla2xxx: Fix spelling mistake "tranport" -> "transport"

David Strahan (3):
      scsi: smartpqi: Enhance controller offline notification
      scsi: smartpqi: Enhance shutdown notification
      scsi: smartpqi: Simplify lun_number assignment

Don Brace (1):
      scsi: smartpqi: Change driver version to 2.1.24-046

John Meneghini (1):
      scsi: st: Add third party poweron reset handling

Juergen Gross (1):
      scsi: xen-scsifront: shost_priv() can never return NULL

Karan Tilak Kumar (1):
      scsi: fnic: Replace sgreset tag with max_tag_id

Kevin Barnett (3):
      scsi: smartpqi: Rename pciinfo to pci_info
      scsi: smartpqi: Rename MACRO to clarify purpose
      scsi: smartpqi: Add abort handler

Mahesh Rajashekhara (1):
      scsi: smartpqi: Enhance error messages

Manish Rangankar (2):
      scsi: qla2xxx: Remove unsupported ql2xenabledif option
      scsi: qla2xxx: Add Unsolicited LS Request and Response Support for NVMe

Nathan Chancellor (1):
      scsi: qla2xxx: Fix unused variable warning in qla2xxx_process_purls_pkt()

Nilesh Javali (5):
      scsi: qla2xxx: Remove unused variables in qla24xx_build_scsi_type_6_iocbs()
      scsi: qla2xxx: Fix nvme_fc_rcv_ls_req() undefined error
      scsi: qla2xxx: Update version to 10.02.09.100-k
      Revert "scsi: qla2xxx: Fix buffer overrun"
      scsi: qla2xxx: Fix smatch warn for qla_init_iocb_limit()

Quinn Tran (5):
      scsi: qla2xxx: Error code did not return to upper layer
      scsi: qla2xxx: Fix firmware resource tracking
      scsi: qla2xxx: Flush mailbox commands on chip reset
      scsi: qla2xxx: Allow 32-byte CDBs
      scsi: qla2xxx: Move resource to allow code reuse

Ranjan Kumar (2):
      scsi: mpt3sas: Remove volatile qualifier
      scsi: mpt3sas: Perform additional retries if doorbell read returns 0

Wenchao Hao (1):
      scsi: libsas: Simplify sas_queue_reset() and remove unused code

Yang Li (1):
      scsi: fnic: Remove unused functions fnic_scsi_host_start/end_tag()

Yue Haibing (2):
      scsi: qedi: Remove unused declarations
      scsi: qedf: Remove unused declaration

And the diffstat:

 drivers/ata/libata-scsi.c             |   2 +-
 drivers/scsi/aacraid/commsup.c        |   2 +-
 drivers/scsi/fnic/fnic.h              |   3 +-
 drivers/scsi/fnic/fnic_scsi.c         |  53 +----
 drivers/scsi/libsas/sas_scsi_host.c   |  41 +---
 drivers/scsi/mpt3sas/mpi/mpi2.h       |   2 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c   |  50 +++--
 drivers/scsi/mpt3sas/mpt3sas_base.h   |   3 +-
 drivers/scsi/mvumi.c                  |   2 +-
 drivers/scsi/qedf/qedf.h              |   1 -
 drivers/scsi/qedi/qedi_gbl.h          |   2 -
 drivers/scsi/qla2xxx/qla_attr.c       |   2 -
 drivers/scsi/qla2xxx/qla_dbg.c        |   7 +-
 drivers/scsi/qla2xxx/qla_dbg.h        |   1 +
 drivers/scsi/qla2xxx/qla_def.h        |  57 ++++-
 drivers/scsi/qla2xxx/qla_dfs.c        |  10 +
 drivers/scsi/qla2xxx/qla_gbl.h        |  14 +-
 drivers/scsi/qla2xxx/qla_init.c       |  36 ++-
 drivers/scsi/qla2xxx/qla_inline.h     |  57 ++++-
 drivers/scsi/qla2xxx/qla_iocb.c       | 321 ++++++++++++++++++++++++---
 drivers/scsi/qla2xxx/qla_isr.c        | 164 +++++++++++++-
 drivers/scsi/qla2xxx/qla_mbx.c        |   4 -
 drivers/scsi/qla2xxx/qla_nvme.c       | 402 +++++++++++++++++++++++++++++++++-
 drivers/scsi/qla2xxx/qla_nvme.h       |  17 +-
 drivers/scsi/qla2xxx/qla_nx.h         |   4 +-
 drivers/scsi/qla2xxx/qla_os.c         |  75 ++++---
 drivers/scsi/qla2xxx/qla_version.h    |   6 +-
 drivers/scsi/scsi_debugfs.c           |  26 ++-
 drivers/scsi/scsi_lib.c               |   2 +-
 drivers/scsi/scsi_priv.h              |   1 -
 drivers/scsi/scsi_scan.c              |   4 +-
 drivers/scsi/scsi_sysfs.c             |   4 +-
 drivers/scsi/sd.c                     |  66 +++---
 drivers/scsi/smartpqi/smartpqi.h      |  16 +-
 drivers/scsi/smartpqi/smartpqi_init.c | 256 +++++++++++++++++-----
 drivers/scsi/st.c                     |   2 +
 drivers/scsi/storvsc_drv.c            |   2 +-
 drivers/scsi/virtio_scsi.c            |   2 +-
 drivers/scsi/xen-scsifront.c          |   6 +-
 drivers/ufs/core/ufs_bsg.c            |   3 +-
 drivers/ufs/core/ufshcd.c             |  14 +-
 include/linux/nvme-fc-driver.h        |   6 +-
 include/scsi/scsi_host.h              |   2 +-
 include/uapi/scsi/scsi_bsg_ufs.h      |   2 +-
 44 files changed, 1433 insertions(+), 319 deletions(-)

James


