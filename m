Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF390800031
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377440AbjLAA3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377389AbjLAA3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:29:47 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A51D40;
        Thu, 30 Nov 2023 16:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701390585;
        bh=R60hFGCGds4Ahh6QIbloBB3vlpbteb0KIm5PND1IEQA=;
        h=Date:From:To:Cc:Subject:From;
        b=PI81c2W2GTH5RJxdvLsvnlCGOxPS417VJ0kjnfNdMLbKjRvbcbMAEjnrMFOGZtZxe
         LbbDP09kbaPvKd1nvNknUud5W8BpfkIOkCHEpprD0D6MwroWlWwXdvRV8kBIEq5ltD
         UstBFibN2iDN+5GbpCRt2Wj3Tg3Cfbj7NaMR9b7Y1DirTMRL8rtwBw4jxf7nabdFGp
         V8JziToKlP8t/a6PdWVnbeHrbeej9sQLgTvnyx2AlDND3TPCYOjuFs+tPh1GhxyYNU
         Mjko16SK+hobL6i6yQE1QzufMb0pFw2X2KWrex9ocgqn5Vr5nxq2orm4bDuNa+QIlD
         Ee+Be7WpNRD+A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4ShDTh4Qydz4xNH;
        Fri,  1 Dec 2023 11:29:44 +1100 (AEDT)
Date:   Fri, 1 Dec 2023 11:29:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the tip tree
Message-ID: <20231201112918.294b40b1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ut/Bg5FzMB_BZlJC_tm8xYr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ut/Bg5FzMB_BZlJC_tm8xYr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
produced these warnings:

WARNING: modpost: EXPORT symbol "const_pcpu_hot" [vmlinux] version generati=
on failed, symbol will not be versioned.
Is "const_pcpu_hot" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: "const_pcpu_hot" [arch/x86/kernel/msr.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [arch/x86/kvm/kvm.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [arch/x86/kvm/kvm-intel.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [arch/x86/kvm/kvm-amd.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [kernel/locking/locktorture.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [kernel/locking/test-ww_mutex.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [kernel/rcu/rcutorture.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [kernel/rcu/rcuscale.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [kernel/rcu/refscale.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [kernel/trace/ring_buffer_benchmark.ko] =
has no CRC!
WARNING: modpost: "const_pcpu_hot" [kernel/trace/preemptirq_delay_test.ko] =
has no CRC!
WARNING: modpost: "const_pcpu_hot" [kernel/kcsan/kcsan_test.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [kernel/torture.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [kernel/scftorture.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [mm/dmapool_test.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/binfmt_misc.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/dlm/dlm.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/netfs/netfs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/fscache/fscache.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/reiserfs/reiserfs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/ext4/ext4.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/ext2/ext2.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/jbd2/jbd2.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/squashfs/squashfs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/coda/coda.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/minix/minix.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/fat/fat.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/exfat/exfat.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/isofs/isofs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/hfsplus/hfsplus.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/hfs/hfs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/ecryptfs/ecryptfs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/nfs/nfs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/nfs/nfsv3.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/nfs/nfsv4.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/nfs/filelayout/nfs_layout_nfsv41_fil=
es.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/nfs/blocklayout/blocklayoutdriver.ko=
] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/nfs/flexfilelayout/nfs_layout_flexfi=
les.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/nfsd/nfsd.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/lockd/lockd.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/smb/client/cifs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/smb/server/ksmbd.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/hpfs/hpfs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/ntfs/ntfs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/ntfs3/ntfs3.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/jffs2/jffs2.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/ubifs/ubifs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/affs/affs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/autofs/autofs4.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/adfs/adfs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/fuse/fuse.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/overlayfs/overlay.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/orangefs/orangefs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/udf/udf.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/omfs/omfs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/jfs/jfs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/9p/9p.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/afs/kafs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/nilfs2/nilfs2.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/befs/befs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/cachefiles/cachefiles.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/ocfs2/ocfs2.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/ocfs2/dlmfs/ocfs2_dlmfs.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [fs/ocfs2/cluster/ocfs2_nodemanager.ko] =
has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/ocfs2/dlm/ocfs2_dlm.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/gfs2/gfs2.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/f2fs/f2fs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/bcachefs/bcachefs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/ceph/ceph.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/efivarfs/efivarfs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/erofs/erofs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/vboxsf/vboxsf.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/zonefs/zonefs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [crypto/asymmetric_keys/x509_selftest.ko=
] has no CRC!
WARNING: modpost: "const_pcpu_hot" [crypto/arc4.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [crypto/af_alg.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [crypto/async_tx/async_memcpy.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [block/bfq.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [lib/kunit/kunit.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [lib/kunit/kunit-test.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [lib/kunit/kunit-example-test.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [lib/test_rhashtable.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [lib/test_user_copy.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [lib/test_hmm.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/video/fbdev/omap2/omapfb/dss/om=
apdss.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/video/fbdev/arcfb.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [drivers/char/ipmi/ipmi_si.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [drivers/char/ipmi/ipmi_watchdog.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/acpi/acpi_dbg.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/acpi/acpi_pad.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/dma/idxd/idxd.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/dma/dmatest.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/virtio/virtio_mem.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [drivers/xen/xen-evtchn.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/xen/xen-gntdev.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/xen/xen-privcmd.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/xen/xen-scsiback.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/tty/serial/max3100.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [drivers/tty/serial/ucc_uart.ko] has no =
CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/tty/n_hdlc.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/tty/n_gsm.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/tty/mxser.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/char/agp/agpgart.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/char/tpm/st33zp24/tpm_st33zp24.=
ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/char/tpm/xen-tpmfront.ko] has n=
o CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/char/virtio_console.ko] has no =
CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/char/lp.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/char/applicom.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/char/hw_random/rng-core.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/char/ppdev.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/char/mwave/mwave.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/iommu/iommufd/iommufd.ko] has n=
o CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/display/drm_display_hel=
per.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/panel/panel-dsi-cm.ko] =
has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/panel/panel-sony-acx565=
akm.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/drm.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/drm_exec.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/drm_suballoc_helper.ko]=
 has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/ttm/ttm.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/scheduler/gpu-sched.ko]=
 has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/radeon/radeon.ko] has n=
o CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/i915/i915.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/i915/kvmgt.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/vc4/vc4.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/vmwgfx/vmwgfx.ko] has n=
o CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/nouveau/nouveau.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/exynos/exynosdrm.ko] ha=
s no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/gma500/gma500_gfx.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/qxl/qxl.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/virtio/virtio-gpu.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/msm/msm.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/tegra/tegra-drm.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/etnaviv/etnaviv.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/lima/lima.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/hyperv/hyperv_drm.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/block/rnbd/rnbd-client.ko] has =
no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/block/brd.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/block/loop.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/block/pktcdvd.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/block/nbd.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/block/xen-blkfront.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [drivers/block/xen-blkback/xen-blkback.k=
o] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/block/drbd/drbd.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/block/zram/zram.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/block/null_blk/null_blk.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/block/ublk_drv.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/misc/lis3lv02d/lis3lv02d.ko] ha=
s no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/misc/cardreader/rtsx_pci.ko] ha=
s no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/misc/ibmasm/ibmasm.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [drivers/misc/lkdtm/lkdtm.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/misc/tifm_core.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/misc/fastrpc.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/misc/sgi-xp/xpc.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/misc/sgi-gru/gru.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/misc/c2port/core.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/misc/mei/mei.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/misc/vmw_vmci/vmw_vmci.ko] has =
no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/misc/genwqe/genwqe_card.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/misc/bcm-vk/bcm_vk.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [drivers/misc/uacce/uacce.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mfd/ti_am335x_tscadc.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/dax/device_dax.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/dma-buf/dmabuf_selftests.ko] ha=
s no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/cxl/cxl_pci.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/megaraid/megaraid_sas.ko] =
has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/scsi_mod.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/libsas/libsas.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/libfc/libfc.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/fcoe/fcoe.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/fcoe/libfcoe.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/bnx2fc/bnx2fc.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/qedf/qedf.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/libiscsi.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/libiscsi_tcp.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/iscsi_tcp.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/arcmsr/arcmsr.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/aacraid/aacraid.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/pm8001/pm80xx.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/isci/isci.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/qla2xxx/qla2xxx.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/qla2xxx/tcm_qla2xxx.ko] ha=
s no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/qla4xxx/qla4xxx.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/lpfc/lpfc.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/bfa/bfa.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/csiostor/csiostor.ko] has =
no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/megaraid.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/mpi3mr/mpi3mr.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/ppa.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/imm.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/mvsas/mvsas.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/mvumi.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/cxgbi/libcxgbi.ko] has no =
CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/bnx2i/bnx2i.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/qedi/qedi.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/xen-scsifront.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/st.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/sd_mod.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/sg.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/scsi/ch.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/nvme/common/nvme-keyring.ko] ha=
s no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/nvme/host/nvme-core.ko] has no =
CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/nvme/host/nvme-tcp.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/ethernet/amazon/ena/ena.ko]=
 has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/ethernet/amd/pds_core/pds_c=
ore.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/ethernet/broadcom/tg3.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/ethernet/broadcom/bnxt/bnxt=
_en.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/ethernet/cavium/liquidio/li=
quidio.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/ethernet/chelsio/inline_cry=
pto/chtls/chtls.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/ethernet/chelsio/cxgb3/cxgb=
3.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/ethernet/chelsio/cxgb4/cxgb=
4.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/ethernet/fungible/funcore/f=
uncore.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/ethernet/google/gve/gve.ko]=
 has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/ethernet/microsoft/mana/man=
a.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/ethernet/mellanox/mlx5/core=
/mlx5_core.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/ethernet/netronome/nfp/nfp.=
ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/ethernet/qualcomm/qcaspi.ko=
] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/ethernet/sfc/sfc.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/ethernet/sfc/falcon/sfc-fal=
con.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/hamradio/hdlcdrv.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/wireless/ath/ath6kl/ath6kl_=
core.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/wireless/broadcom/b43legacy=
/b43legacy.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/wireless/broadcom/brcm80211=
/brcmfmac/brcmfmac.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/wireless/marvell/libertas/l=
ibertas.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/wireless/marvell/mwl8k.ko] =
has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/wireless/mediatek/mt76/mt76=
.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/wireless/realtek/rtlwifi/rt=
lwifi.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/wireless/realtek/rtw88/rtw8=
8_sdio.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/wireless/rsi/rsi_sdio.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/wireless/st/cw1200/cw1200_w=
lan_spi.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/mctp/mctp-i2c.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [drivers/net/bonding/bonding.ko] has no =
CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/wireguard/wireguard.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/eql.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/tun.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/tap.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/can/usb/peak_usb/peak_usb.k=
o] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/can/softing/softing.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/fddi/skfp/skfp.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/plip/plip.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/ppp/ppp_generic.ko] has no =
CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/slip/slip.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/wwan/t7xx/mtk_t7xx.ko] has =
no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/xen-netback/xen-netback.ko]=
 has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/usb/hso.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/usb/lan78xx.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/usb/smsc95xx.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/usb/usbnet.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/usb/qmi_wwan.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/net/netdevsim/netdevsim.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/firewire/firewire-core.ko] has =
no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/cdrom/cdrom.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/host/xhci-hcd.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/host/max3421-hcd.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/core/usbcore.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/cdns3/cdnsp-udc-pci.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/mon/usbmon.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/class/cdc-acm.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/class/usblp.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/storage/usb-storage.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/image/mdc800.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/serial/usbserial.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/serial/digi_acceleport.ko] =
has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/serial/io_edgeport.ko] has =
no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/misc/adutux.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/misc/idmouse.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/misc/uss720.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/misc/yurex.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/misc/chaoskey.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/atm/ueagle-atm.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/gadget/udc/udc-core.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/gadget/udc/max3420_udc.ko] =
has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/gadget/function/usb_f_mass_=
storage.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/gadget/function/usb_f_fs.ko=
] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/gadget/legacy/gadgetfs.ko] =
has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/usbip/usbip-core.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/usbip/usbip-host.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/input/misc/uinput.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [drivers/input/evdev.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/i2c/cx25840/cx25840.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/i2c/video-i2c.ko] has no =
CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/i2c/ir-kbd-i2c.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/i2c/msp3400.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [drivers/media/i2c/saa7110.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [drivers/media/i2c/saa717x.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [drivers/media/i2c/tvaudio.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [drivers/media/i2c/vpx3220.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [drivers/media/rc/rc-core.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/rc/imon.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/common/saa7146/saa7146_vv=
.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/common/videobuf2/videobuf=
2-common.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/platform/amphion/amphion-=
vpu.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/platform/aspeed/aspeed-vi=
deo.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/platform/samsung/exynos-g=
sc/exynos-gsc.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/platform/samsung/exynos4-=
is/s5p-fimc.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/platform/samsung/s3c-cami=
f/s3c-camif.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/pci/pt1/earth-pt1.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/pci/pt3/earth-pt3.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/pci/cx18/cx18.ko] has no =
CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/pci/cx88/cx88xx.ko] has n=
o CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/pci/ivtv/ivtv.ko] has no =
CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/pci/ivtv/ivtvfb.ko] has n=
o CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/pci/saa7134/saa7134.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/pci/saa7164/saa7164.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/pci/solo6x10/solo6x10.ko]=
 has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/usb/gspca/gspca_cpia1.ko]=
 has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/usb/gspca/m5602/gspca_m56=
02.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/usb/pvrusb2/pvrusb2.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/test-drivers/vimc/vimc.ko=
] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/test-drivers/vivid/vivid.=
ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/v4l2-core/videodev.ko] ha=
s no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/media/dvb-core/dvb-core.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/power/supply/tps65090-charger.k=
o] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/power/supply/tps65217_charger.k=
o] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/md/raid1.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/md/raid10.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/md/raid456.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/md/md-cluster.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/md/bcache/bcache.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/md/md-mod.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/md/dm-mod.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/md/dm-bufio.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/md/dm-crypt.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/md/dm-delay.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/md/dm-multipath.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/md/dm-snapshot.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/md/persistent-data/dm-persisten=
t-data.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/md/dm-log-userspace.ko] has no =
CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/md/dm-cache.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/md/dm-log-writes.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/md/dm-integrity.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/md/dm-zoned.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/md/dm-writecache.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/accessibility/speakup/speakup_a=
cntpc.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/accessibility/speakup/speakup_a=
pollo.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/accessibility/speakup/speakup_d=
ectlk.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/accessibility/speakup/speakup_d=
ecext.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/accessibility/speakup/speakup_d=
ecpc.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/accessibility/speakup/speakup_d=
tlk.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/accessibility/speakup/speakup_k=
eypc.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/accessibility/speakup/speakup_s=
oft.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/accessibility/speakup/speakup.k=
o] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/isdn/hardware/mISDN/hfcpci.ko] =
has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/isdn/hardware/mISDN/hfcmulti.ko=
] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/isdn/mISDN/mISDN_core.ko] has n=
o CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/isdn/mISDN/l1oip.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/cpuidle/cpuidle-haltpoll.ko] ha=
s no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mmc/host/tmio_mmc_core.ko] has =
no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mmc/host/vub300.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mmc/core/mmc_core.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [drivers/mmc/core/sdio_uart.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [drivers/crypto/ccp/ccp.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/hid/hid.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/hid/uhid.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/hid/hid-roccat.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/hid/usbhid/usbhid.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [drivers/staging/wlan-ng/prism2_usb.ko] =
has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/staging/rtl8723bs/r8723bs.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/staging/rts5208/rts5208.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/staging/greybus/gb-uart.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/staging/vc04_services/vchiq.ko]=
 has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/platform/x86/intel/speed_select=
_if/isst_if_common.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/platform/x86/thinkpad_acpi.ko] =
has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/platform/x86/intel_ips.ko] has =
no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/platform/chrome/cros_ec_chardev=
.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/platform/chrome/cros_ec_lightba=
r.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/platform/surface/surface3_power=
.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mailbox/mailbox-test.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/virt/vboxguest/vboxguest.ko] ha=
s no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/virt/nitro_enclaves/nitro_encla=
ves.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/virt/acrn/acrn.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/accel/habanalabs/habanalabs.ko]=
 has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/accel/ivpu/intel_vpu.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/accel/qaic/qaic.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/rapidio/rio_cm.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/rapidio/devices/tsi721_mport.ko=
] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/rapidio/devices/rio_mport_cdev.=
ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/vdpa/mlx5/mlx5_vdpa.ko] has no =
CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/vdpa/vdpa_user/vduse.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/parport/parport.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/parport/parport_pc.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [drivers/nvdimm/libnvdimm.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/nvdimm/nd_pmem.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/nvdimm/nd_btt.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/ata/libata.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/target/target_core_mod.ko] has =
no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/target/target_core_user.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/target/tcm_fc/tcm_fc.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/target/iscsi/iscsi_target_mod.k=
o] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/target/iscsi/cxgbit/cxgbit.ko] =
has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mtd/chips/cfi_cmdset_0020.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mtd/chips/cfi_cmdset_0002.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mtd/chips/cfi_cmdset_0001.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mtd/lpddr/lpddr_cmds.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mtd/nand/onenand/onenand.ko] ha=
s no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mtd/nand/raw/nandsim.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mtd/nand/raw/gpmi-nand/gpmi-nan=
d.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mtd/nand/raw/meson_nand.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mtd/tests/mtd_oobtest.ko] has n=
o CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mtd/tests/mtd_pagetest.ko] has =
no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mtd/tests/mtd_readtest.ko] has =
no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mtd/tests/mtd_speedtest.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mtd/tests/mtd_stresstest.ko] ha=
s no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mtd/tests/mtd_subpagetest.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mtd/tests/mtd_torturetest.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mtd/tests/mtd_nandecctest.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mtd/tests/mtd_nandbiterrs.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mtd/spi-nor/spi-nor.ko] has no =
CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mtd/ubi/ubi.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mtd/ubi/gluebi.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/mtd/hyperbus/hbmc-am654.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/atm/iphase.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/atm/eni.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/atm/solos-pci.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/atm/atmtcp.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/atm/he.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/uio/uio.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/vfio/vfio.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/vfio/vfio_iommu_type1.ko] has n=
o CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/pcmcia/pcmcia_core.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [drivers/block/aoe/aoe.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/w1/wire.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/hwmon/abituguru.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/hwmon/nzxt-smart2.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [drivers/hwmon/occ/occ-p8-hwmon.ko] has =
no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/bluetooth/bluecard_cs.ko] has n=
o CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/bluetooth/btmrvl.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/edac/edac_core.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/memstick/core/memstick.ko] has =
no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/memstick/host/tifm_ms.ko] has n=
o CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/memstick/host/jmb38x_ms.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/memstick/host/r592.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [drivers/infiniband/core/ib_core.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/infiniband/core/rdma_cm.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/infiniband/core/ib_umad.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/infiniband/core/ib_uverbs.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/infiniband/core/rdma_ucm.ko] ha=
s no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/infiniband/hw/mthca/ib_mthca.ko=
] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/infiniband/hw/qib/ib_qib.ko] ha=
s no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/infiniband/hw/cxgb4/iw_cxgb4.ko=
] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/infiniband/hw/efa/efa.ko] has n=
o CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/infiniband/hw/mlx4/mlx4_ib.ko] =
has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] =
has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/infiniband/hw/usnic/usnic_verbs=
.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/infiniband/hw/hfi1/hfi1.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/infiniband/hw/erdma/erdma.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/infiniband/ulp/ipoib/ib_ipoib.k=
o] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/infiniband/ulp/isert/ib_isert.k=
o] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/infiniband/ulp/rtrs/rtrs-client=
.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/infiniband/sw/rdmavt/rdmavt.ko]=
 has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/infiniband/sw/siw/siw.ko] has n=
o CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/dca/dca.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/vhost/vhost_net.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/vhost/vhost_scsi.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/vhost/vhost_vdpa.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/vhost/vhost.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/comedi/comedi.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/comedi/drivers/ni_atmio.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/comedi/drivers/ni_pcidio.ko] ha=
s no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/comedi/drivers/ni_pcimio.ko] ha=
s no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/comedi/drivers/ni_mio_cs.ko] ha=
s no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/iio/industrialio.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/thunderbolt/thunderbolt.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/hwtracing/stm/stm_core.ko] has =
no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/fpga/dfl-afu.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/fsi/fsi-occ.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/tee/tee.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/siox/siox-core.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [sound/core/oss/snd-pcm-oss.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [sound/core/snd.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [sound/core/snd-hwdep.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [sound/core/snd-timer.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [sound/core/snd-pcm.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [sound/core/snd-rawmidi.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [sound/core/seq/snd-seq.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [sound/core/seq/oss/snd-seq-oss.ko] has =
no CRC!
WARNING: modpost: "const_pcpu_hot" [sound/drivers/snd-aloop.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [sound/isa/gus/snd-gus-lib.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [sound/isa/msnd/snd-msnd-lib.ko] has no =
CRC!
WARNING: modpost: "const_pcpu_hot" [sound/isa/opti9xx/snd-miro.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [sound/isa/sb/snd-sbawe.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [sound/isa/sb/snd-emu8000-synth.ko] has =
no CRC!
WARNING: modpost: "const_pcpu_hot" [sound/isa/wavefront/snd-wavefront.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [sound/pci/korg1212/snd-korg1212.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [sound/pci/mixart/snd-mixart.ko] has no =
CRC!
WARNING: modpost: "const_pcpu_hot" [sound/pci/rme9652/snd-rme9652.ko] has n=
o CRC!
WARNING: modpost: "const_pcpu_hot" [sound/pci/rme9652/snd-hdsp.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [sound/pci/rme9652/snd-hdspm.ko] has no =
CRC!
WARNING: modpost: "const_pcpu_hot" [sound/pci/ymfpci/snd-ymfpci.ko] has no =
CRC!
WARNING: modpost: "const_pcpu_hot" [sound/usb/snd-usbmidi-lib.ko] has no CR=
C!
WARNING: modpost: "const_pcpu_hot" [sound/usb/line6/snd-usb-line6.ko] has n=
o CRC!
WARNING: modpost: "const_pcpu_hot" [sound/firewire/dice/snd-dice.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [sound/firewire/oxfw/snd-oxfw.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [sound/firewire/fireworks/snd-fireworks.=
ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [sound/firewire/bebob/snd-bebob.ko] has =
no CRC!
WARNING: modpost: "const_pcpu_hot" [sound/firewire/digi00x/snd-firewire-dig=
i00x.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [sound/firewire/tascam/snd-firewire-tasc=
am.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [sound/firewire/motu/snd-firewire-motu.k=
o] has no CRC!
WARNING: modpost: "const_pcpu_hot" [sound/firewire/fireface/snd-fireface.ko=
] has no CRC!
WARNING: modpost: "const_pcpu_hot" [sound/soc/intel/avs/snd-soc-avs.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [sound/soc/sof/snd-sof.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [samples/kprobes/kretprobe_example.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [samples/trace_events/trace-events-sampl=
e.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [samples/ftrace/ftrace-direct-modify.ko]=
 has no CRC!
WARNING: modpost: "const_pcpu_hot" [samples/ftrace/ftrace-direct-multi-modi=
fy.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [samples/ftrace/sample-trace-array.ko] h=
as no CRC!
WARNING: modpost: "const_pcpu_hot" [net/core/pktgen.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/sched/cls_cgroup.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/netfilter/nfnetlink.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/netfilter/nf_conntrack.ko] has no C=
RC!
WARNING: modpost: "const_pcpu_hot" [net/netfilter/nf_tables.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/netfilter/x_tables.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/netfilter/xt_owner.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/netfilter/ipvs/ip_vs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/ipv4/netfilter/ip_tables.ko] has no=
 CRC!
WARNING: modpost: "const_pcpu_hot" [net/ipv4/netfilter/arp_tables.ko] has n=
o CRC!
WARNING: modpost: "const_pcpu_hot" [net/xfrm/xfrm_user.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/ipv6/netfilter/ip6_tables.ko] has n=
o CRC!
WARNING: modpost: "const_pcpu_hot" [net/ipv6/ipv6.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/bpfilter/bpfilter.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/dsa/dsa_core.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/wireless/cfg80211.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/llc/llc2.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/tls/tls.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/bridge/netfilter/ebtables.ko] has n=
o CRC!
WARNING: modpost: "const_pcpu_hot" [net/bridge/bridge.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/appletalk/appletalk.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/x25/x25.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/netrom/netrom.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/rose/rose.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/ax25/ax25.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/bluetooth/bluetooth.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/bluetooth/rfcomm/rfcomm.ko] has no =
CRC!
WARNING: modpost: "const_pcpu_hot" [net/bluetooth/bnep/bnep.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/bluetooth/cmtp/cmtp.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/bluetooth/hidp/hidp.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/sunrpc/sunrpc.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/sunrpc/auth_gss/auth_rpcgss.ko] has=
 no CRC!
WARNING: modpost: "const_pcpu_hot" [net/sunrpc/xprtrdma/rpcrdma.ko] has no =
CRC!
WARNING: modpost: "const_pcpu_hot" [net/rxrpc/rxrpc.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/rxrpc/rxperf.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/kcm/kcm.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/atm/atm.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/l2tp/l2tp_ppp.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/l2tp/l2tp_debugfs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/phonet/phonet.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/phonet/pn_pep.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/dccp/dccp.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/sctp/sctp.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/rds/rds.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/rds/rds_rdma.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/rds/rds_tcp.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/tipc/tipc.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/smc/smc.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/9p/9pnet.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/9p/9pnet_fd.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/9p/9pnet_rdma.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/caif/caif_socket.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/dns_resolver/dns_resolver.ko] has n=
o CRC!
WARNING: modpost: "const_pcpu_hot" [net/ceph/libceph.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/nfc/nfc.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/vmw_vsock/vsock.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/vmw_vsock/vmw_vsock_virtio_transpor=
t_common.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [net/qrtr/qrtr.ko] has no CRC!

Presumably introduced by commit

  4604c052b84d ("x86/percpu: Declare const_pcpu_hot as extern const variabl=
e")

--=20
Cheers,
Stephen Rothwell

--Sig_/Ut/Bg5FzMB_BZlJC_tm8xYr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVpKN4ACgkQAVBC80lX
0GxtTAf+O3JjmqUBEGJUluaEjDZGt98t4ipb3GoMGVC53G/rCi5jyiH79fBMK/g7
YFWqusymihw2/qmT1HvZfKz9NFySlKRsqe9DZLcfqGgpoA8Kk/yQLMf7mY0NF7bh
/NBbe2Ee+GHvqBziW2Cq5yGoJHEY5RpkxgtAfjkTZ8ey81X3PprBkyuhEfjy290H
UsCde8ZFF9CWHYxPCjCbg1q8ykQ6wT8T+fBHQGjxy2lA2+FrqKKf0bk24bPAObun
vooywtMPHB9/ENS32SvQWu0+OuYgmtjThS+ZINPQFk08K1OaweQ1KrDOwmQ3Hhx2
evH8Z+4C6qpE/60r0ovaLMjJ2Diosw==
=Agz/
-----END PGP SIGNATURE-----

--Sig_/Ut/Bg5FzMB_BZlJC_tm8xYr--
