Return-Path: <linux-kernel+bounces-15777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77838231A5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37CF71F2464B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519B11BDFD;
	Wed,  3 Jan 2024 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CigdaF1t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947141BDEC;
	Wed,  3 Jan 2024 16:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E5BC433C7;
	Wed,  3 Jan 2024 16:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301016;
	bh=55YAiE47xn8SJbZTG5gBBLlgoRLB1XK+vd8rkROAvGY=;
	h=From:To:Cc:Subject:Date:From;
	b=CigdaF1togTarn+NtgBxxfngDH+4AsYg/tooD1VIGld7TfEqp5H9I4fXZLNSoUDaT
	 qhK4Q2enmkRLQZbm/I50emsyG062YK7J7wJt0YfSWhyLQRFTO7XKWqH3tplCcw9nYp
	 qFEyKmRhG9ZB4Vv5DSaKXukht5d6HV25kj/tfvUc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com
Subject: [PATCH 6.1 000/100] 6.1.71-rc1 review
Date: Wed,  3 Jan 2024 17:53:49 +0100
Message-ID: <20240103164856.169912722@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.71-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.71-rc1
X-KernelTest-Deadline: 2024-01-05T16:49+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.1.71 release.
There are 100 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.71-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.71-rc1

Andrii Nakryiko <andrii@kernel.org>
    tracing/kprobes: Fix symbol counting logic by looking at modules as well

Jiri Olsa <jolsa@kernel.org>
    kallsyms: Make module_kallsyms_on_each_symbol generally available

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    device property: Allow const parameter to dev_fwnode()

Geert Uytterhoeven <geert+renesas@glider.be>
    spi: Constify spi parameters of chip select APIs

NeilBrown <neilb@suse.de>
    NFSD: fix possible oops when nfsd/pool_stats is closed.

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix slowpath of interrupted event

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: skip set commit for deleted/destroyed sets

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Remove useless update to write_stamp in rb_try_to_discard()

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Fix blocked reader of snapshot buffer

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix wake ups when buffer_percent is set to 100

Matthew Wilcox (Oracle) <willy@infradead.org>
    mm/memory-failure: check the mapcount of the precise page

Matthew Wilcox (Oracle) <willy@infradead.org>
    mm/memory-failure: cast index to loff_t before shifting it

Charan Teja Kalla <quic_charante@quicinc.com>
    mm: migrate high-order folios in swap cache correctly

Baokun Li <libaokun1@huawei.com>
    mm/filemap: avoid buffered read/write race to read inconsistent data

Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
    platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()

Christoph Hellwig <hch@lst.de>
    block: renumber QUEUE_FLAG_HW_WC

Louis Chauvet <louis.chauvet@bootlin.com>
    spi: atmel: Fix clock issue when using devices with different polarities

Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
    spi: Add APIs in spi core to set/get spi->chip_select and spi->cs_gpiod

Tudor Ambarus <tudor.ambarus@microchip.com>
    spi: Reintroduce spi_set_cs_timing()

Helge Deller <deller@gmx.de>
    linux/export: Ensure natural alignment of kcrctab array

NeilBrown <neilb@suse.de>
    nfsd: call nfsd_last_thread() before final nfsd_put()

NeilBrown <neilb@suse.de>
    nfsd: separate nfsd_last_thread() from nfsd_put()

Nuno Sa <nuno.sa@analog.com>
    iio: imu: adis16475: add spi_device_id table

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    spi: Introduce spi_get_device_match_data() helper

Dan Carpenter <dan.carpenter@linaro.org>
    usb: fotg210-hcd: delete an incorrect bounds test

Tony Lindgren <tony@atomide.com>
    ARM: dts: Fix occasional boot hang for am3 usb

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix wrong allocation size update in smb2_open()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: avoid duplicate opinfo_put() call on error of smb21_lease_break_ack()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: lazy v2 lease break on smb2_write()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: send v2 lease break notification for directory

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: downgrade RWH lease caching state to RH for directory

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: set v2 lease capability

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: set epoch in create context v2 lease

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: don't update ->op_state as OPLOCK_STATE_NONE on error

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: move setting SMB2_FLAGS_ASYNC_COMMAND and AsyncId

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: release interim response after sending status pending response

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: move oplock handling after unlock parent dir

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: separately allocate ci per dentry

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix possible deadlock in smb2_open

Zongmin Zhou <zhouzongmin@kylinos.cn>
    ksmbd: prevent memory leak on error return

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix kernel-doc comment of ksmbd_vfs_kern_path_locked()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: no need to wait for binded connection termination at logoff

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: add support for surrogate pair conversion

Kangjing Huang <huangkangjing@gmail.com>
    ksmbd: fix missing RDMA-capable flag for IPoIB device in ksmbd_rdma_capable_netdev()

Marios Makassikis <mmakassikis@freebox.fr>
    ksmbd: fix recursive locking in vfs helpers

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix kernel-doc comment of ksmbd_vfs_setxattr()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: reorganize ksmbd_iov_pin_rsp()

Cheng-Han Wu <hank20010209@gmail.com>
    ksmbd: Remove unused field in ksmbd_user struct

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix potential double free on smb2_read_pipe() error path

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix Null pointer dereferences in ksmbd_update_fstate()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix wrong error response status by using set_smb2_rsp_status()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix race condition between tree conn lookup and disconnect

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix race condition from parallel smb2 lock requests

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix race condition from parallel smb2 logoff requests

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix race condition with fp

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: check iov vector index in ksmbd_conn_write()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: return invalid parameter error response if smb2 request is invalid

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix passing freed memory 'aux_payload_buf'

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: remove unneeded mark_inode_dirty in set_info_sec()

Steve French <stfrench@microsoft.com>
    ksmbd: remove experimental warning

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: add missing calling smb2_set_err_rsp() on error

Yang Li <yang.lee@linux.alibaba.com>
    ksmbd: Fix one kernel-doc comment

Atte Heikkilä <atteh.mailbox@gmail.com>
    ksmbd: fix `force create mode' and `force directory mode'

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix wrong interim response on compound

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: add support for read compound

Yang Yingliang <yangyingliang@huawei.com>
    ksmbd: switch to use kmemdup_nul() helper

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: check if a mount point is crossed during path lookup

Wang Ming <machel@vivo.com>
    ksmbd: Fix unsigned expression compared with zero

Gustavo A. R. Silva <gustavoars@kernel.org>
    ksmbd: Replace one-element array with flexible-array member

Gustavo A. R. Silva <gustavoars@kernel.org>
    ksmbd: Use struct_size() helper in ksmbd_negotiate_smb_dialect()

Lu Hongfei <luhongfei@vivo.com>
    ksmbd: Replace the ternary conditional operator with min()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: use kvzalloc instead of kvmalloc

Lu Hongfei <luhongfei@vivo.com>
    ksmbd: Change the return value of ksmbd_vfs_query_maximal_access to void

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: return a literal instead of 'err' in ksmbd_vfs_kern_path_locked()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: use kzalloc() instead of __GFP_ZERO

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: remove unused ksmbd_tree_conn_share function

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: add mnt_want_write to ksmbd vfs functions

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix posix_acls and acls dereferencing possible ERR_PTR()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: call putname after using the last component

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix uninitialized pointer read in smb2_create_link()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix uninitialized pointer read in ksmbd_vfs_rename()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix racy issue from using ->d_parent and ->d_name

Al Viro <viro@zeniv.linux.org.uk>
    fs: introduce lock_rename_child() helper

David Disseldorp <ddiss@suse.de>
    ksmbd: remove unused compression negotiate ctx packing

David Disseldorp <ddiss@suse.de>
    ksmbd: avoid duplicate negotiate ctx offset increments

David Disseldorp <ddiss@suse.de>
    ksmbd: set NegotiateContextCount once instead of every inc

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: delete asynchronous work from list

Tom Rix <trix@redhat.com>
    ksmbd: remove unused is_char_allowed function

Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
    ksmbd: Fix parameter name and comment mismatch

Colin Ian King <colin.i.king@gmail.com>
    ksmbd: Fix spelling mistake "excceed" -> "exceeded"

Steve French <stfrench@microsoft.com>
    ksmbd: update Kconfig to note Kerberos support and fix indentation

Dawei Li <set_pte_at@outlook.com>
    ksmbd: Remove duplicated codes

Dawei Li <set_pte_at@outlook.com>
    ksmbd: fix typo, syncronous->synchronous

Dawei Li <set_pte_at@outlook.com>
    ksmbd: Implements sess->rpc_handle_list as xarray

ye xingchen <ye.xingchen@zte.com.cn>
    ksmbd: Convert to use sysfs_emit()/sysfs_emit_at() APIs

Marios Makassikis <mmakassikis@freebox.fr>
    ksmbd: Fix resource leak in smb2_lock()

Jeff Layton <jlayton@kernel.org>
    ksmbd: use F_SETLK when unlocking a file

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: set SMB2_SESSION_FLAG_ENCRYPT_DATA when enforcing data encryption for this share

Gustavo A. R. Silva <gustavoars@kernel.org>
    ksmbd: replace one-element arrays with flexible-array members


-------------

Diffstat:

 Makefile                          |    4 +-
 arch/arm/boot/dts/am33xx.dtsi     |    1 +
 drivers/base/property.c           |   11 +-
 drivers/iio/imu/adis16475.c       |  129 +++--
 drivers/platform/x86/p2sb.c       |  178 +++++--
 drivers/spi/spi-atmel.c           |   82 ++-
 drivers/spi/spi.c                 |   92 +++-
 drivers/usb/host/fotg210-hcd.c    |    3 -
 fs/namei.c                        |  125 ++++-
 fs/nfsd/nfsctl.c                  |    9 +-
 fs/nfsd/nfsd.h                    |    8 +-
 fs/nfsd/nfssvc.c                  |   57 +-
 fs/smb/common/smb2pdu.h           |    1 +
 fs/smb/server/Kconfig             |   10 +-
 fs/smb/server/asn1.c              |   33 +-
 fs/smb/server/auth.c              |   11 +-
 fs/smb/server/connection.c        |   74 +--
 fs/smb/server/connection.h        |    2 +-
 fs/smb/server/ksmbd_netlink.h     |    4 +-
 fs/smb/server/ksmbd_work.c        |  100 +++-
 fs/smb/server/ksmbd_work.h        |   36 +-
 fs/smb/server/mgmt/share_config.h |   29 +-
 fs/smb/server/mgmt/tree_connect.c |   53 +-
 fs/smb/server/mgmt/tree_connect.h |   14 +-
 fs/smb/server/mgmt/user_config.h  |    1 -
 fs/smb/server/mgmt/user_session.c |   38 +-
 fs/smb/server/mgmt/user_session.h |    3 +-
 fs/smb/server/oplock.c            |  147 ++++--
 fs/smb/server/oplock.h            |    8 +-
 fs/smb/server/server.c            |   36 +-
 fs/smb/server/smb2misc.c          |   19 +-
 fs/smb/server/smb2ops.c           |   19 +-
 fs/smb/server/smb2pdu.c           | 1033 ++++++++++++++++---------------------
 fs/smb/server/smb2pdu.h           |    3 +-
 fs/smb/server/smb_common.c        |   19 +-
 fs/smb/server/smb_common.h        |   14 +-
 fs/smb/server/smbacl.c            |   20 +-
 fs/smb/server/smbacl.h            |    2 +-
 fs/smb/server/transport_ipc.c     |    4 +-
 fs/smb/server/transport_rdma.c    |   44 +-
 fs/smb/server/unicode.c           |  191 ++++---
 fs/smb/server/vfs.c               |  638 ++++++++++++-----------
 fs/smb/server/vfs.h               |   52 +-
 fs/smb/server/vfs_cache.c         |   63 ++-
 fs/smb/server/vfs_cache.h         |   18 +-
 include/linux/blkdev.h            |    2 +-
 include/linux/export-internal.h   |    1 +
 include/linux/module.h            |    9 +
 include/linux/namei.h             |    7 +
 include/linux/property.h          |    7 +-
 include/linux/spi/spi.h           |   23 +
 kernel/module/kallsyms.c          |    2 -
 kernel/trace/ring_buffer.c        |  140 ++---
 kernel/trace/trace.c              |   20 +-
 kernel/trace/trace_kprobe.c       |   25 +-
 mm/filemap.c                      |    9 +
 mm/memory-failure.c               |    8 +-
 mm/migrate.c                      |    9 +-
 net/netfilter/nf_tables_api.c     |    2 +-
 59 files changed, 2139 insertions(+), 1563 deletions(-)



