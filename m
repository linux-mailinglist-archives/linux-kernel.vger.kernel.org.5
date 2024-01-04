Return-Path: <linux-kernel+bounces-16340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BEA823D0A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB051F262DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D26520305;
	Thu,  4 Jan 2024 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrF+pQE0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE522030A;
	Thu,  4 Jan 2024 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso135062a12.1;
        Wed, 03 Jan 2024 23:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704354914; x=1704959714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thELQt+jJStLaTs0SK0jv3blwIe6CCuApqMHQi68vpE=;
        b=WrF+pQE0ROWIMDKoaT+eXbvZuqatSuNkWEh5my41UFccMyD4t0Ix2A+H6wxn2cVITq
         HGX4SAnYpwgngdrdU1b/PbAzEj30OTpcExWr2Qbz4JsO/FlNQifwPViIS5Y/sRLLdgns
         Y/mR2rngCpDC9POrYNqkYKTX+vpS29VWSeZBsIyKewrjd1jcHECASeza99l5cMlpY/4m
         R5tb2iT4l3KeNwFNzjZ9NXe4/iyU6trUvkWIU36knSzs5x7Xpkx9Qw5ZYhwuSCjSW4eb
         JSxZ5Wpc/0Ucgi/cmEyW1QQK+BWSVs5Mtfv4FkO2lqhZar0lqQglQEY7CUiaVzmCpq6O
         o4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704354914; x=1704959714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thELQt+jJStLaTs0SK0jv3blwIe6CCuApqMHQi68vpE=;
        b=w3+lcISySE4r22Tn1u1Zb6KWQnUFftD1kgdrjS1rXwCcY3elnX1jW+unDGcFixiXL7
         VzzHEbRDKKJnq3oNXd/DBL9QrdhtKEygrsiu3WKu7H+fSHGmOKCHnHtvMOmwqW7XCjO9
         tauSLZYlwGfa34R95o/UBUEGRzw9TN5MP2k27SvCdM5bFzkPxJWXBCqwBIhL0/VsDm4C
         orvpt3uJ5oeNdm2glKaApFyOVHdD1N9Oshem2pg84HvPTkzpwkhwclTXy5MZI1aLTob0
         6SC4bvQWwEKVAeAS72H1QLzSws7ekfZ7Omx4VadCBxNsMLCebKUyFHC0z34uULz1nYdI
         QxNA==
X-Gm-Message-State: AOJu0YwN4vs5mJ5VkpRjdonfrbQ44M2jCyRurScV5dDmis3Bk6moaSVX
	05yzsz7Emn8dQ63LbZ2lR/llFVcBc23Z7NKLSbg=
X-Google-Smtp-Source: AGHT+IFI73v/6TfZ1EDje8MFqjY1bVatog9mEBZ85DA+lpHsm7Ax9qkxcUELS3xNPe7ldb2qxSp24wzYpP9w75dC8po=
X-Received: by 2002:a05:6a20:12c2:b0:196:4c53:52db with SMTP id
 v2-20020a056a2012c200b001964c5352dbmr157073pzg.47.1704354914365; Wed, 03 Jan
 2024 23:55:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103164834.970234661@linuxfoundation.org>
In-Reply-To: <20240103164834.970234661@linuxfoundation.org>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Thu, 4 Jan 2024 07:55:02 +0000
Message-ID: <CADo9pHiP8rXxLrGdsH5o+0KbR0f8XO+G1a=OgNW6UfD0s_hwAQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/49] 6.6.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Luna Jernberg <droidbittin@gmail.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tried to follow this guide:
https://wiki.archlinux.org/title/Kernel/Traditional_compilation to
compile it on Crystal Linux based on Arch Linux on a Dell Latitude
7390 laptop with a Intel i5-8350U and did not get it to boot
but the same process worked for the stable 6.6.9 kernel, so guess i
will just wait for the stable 6.6.10 and try when thats out

Den ons 3 jan. 2024 kl 17:13 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> This is the start of the stable review cycle for the 6.6.10 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 6.6.10-rc1
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: skip set commit for deleted/destroyed sets
>
> L=C3=A9o Lam <leo@leolam.fr>
>     wifi: nl80211: fix deadlock in nl80211_set_cqm_rssi (6.6.x)
>
> Johannes Berg <johannes.berg@intel.com>
>     wifi: cfg80211: fix CQM for non-range use
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     tracing: Fix blocked reader of snapshot buffer
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     ftrace: Fix modification of direct_function hash while in use
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     ring-buffer: Fix wake ups when buffer_percent is set to 100
>
> Keith Busch <kbusch@kernel.org>
>     Revert "nvme-fc: fix race between error recovery and creating associa=
tion"
>
> Matthew Wilcox (Oracle) <willy@infradead.org>
>     mm/memory-failure: check the mapcount of the precise page
>
> Matthew Wilcox (Oracle) <willy@infradead.org>
>     mm/memory-failure: cast index to loff_t before shifting it
>
> Charan Teja Kalla <quic_charante@quicinc.com>
>     mm: migrate high-order folios in swap cache correctly
>
> Baokun Li <libaokun1@huawei.com>
>     mm/filemap: avoid buffered read/write race to read inconsistent data
>
> Muhammad Usama Anjum <usama.anjum@collabora.com>
>     selftests: secretmem: floor the memory size to the multiple of page_s=
ize
>
> Sidhartha Kumar <sidhartha.kumar@oracle.com>
>     maple_tree: do not preallocate nodes for slot stores
>
> Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>     platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()
>
> David E. Box <david.e.box@linux.intel.com>
>     platform/x86/intel/pmc: Move GBE LTR ignore to suspend callback
>
> David E. Box <david.e.box@linux.intel.com>
>     platform/x86/intel/pmc: Allow reenabling LTRs
>
> David E. Box <david.e.box@linux.intel.com>
>     platform/x86/intel/pmc: Add suspend callback
>
> Christoph Hellwig <hch@lst.de>
>     block: renumber QUEUE_FLAG_HW_WC
>
> Paolo Abeni <pabeni@redhat.com>
>     mptcp: fix inconsistent state on fastopen race
>
> Paolo Abeni <pabeni@redhat.com>
>     mptcp: fix possible NULL pointer dereference on close
>
> Paolo Abeni <pabeni@redhat.com>
>     mptcp: refactor sndbuf auto-tuning
>
> Helge Deller <deller@gmx.de>
>     linux/export: Ensure natural alignment of kcrctab array
>
> Helge Deller <deller@gmx.de>
>     linux/export: Fix alignment for 64-bit ksymtab entries
>
> Arnd Bergmann <arnd@arndb.de>
>     kexec: select CRYPTO from KEXEC_FILE instead of depending on it
>
> Arnd Bergmann <arnd@arndb.de>
>     kexec: fix KEXEC_FILE dependencies
>
> Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>     virtio_ring: fix syncs DMA memory with different direction
>
> Zizhi Wo <wozizhi@huawei.com>
>     fs: cifs: Fix atime update check
>
> Jeff Layton <jlayton@kernel.org>
>     client: convert to new timestamp accessors
>
> Jeff Layton <jlayton@kernel.org>
>     fs: new accessor methods for atime and mtime
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: avoid duplicate opinfo_put() call on error of smb21_lease_brea=
k_ack()
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: lazy v2 lease break on smb2_write()
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: send v2 lease break notification for directory
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: downgrade RWH lease caching state to RH for directory
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: set v2 lease capability
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: set epoch in create context v2 lease
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: don't update ->op_state as OPLOCK_STATE_NONE on error
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: move setting SMB2_FLAGS_ASYNC_COMMAND and AsyncId
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: release interim response after sending status pending response
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: move oplock handling after unlock parent dir
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: separately allocate ci per dentry
>
> Zongmin Zhou <zhouzongmin@kylinos.cn>
>     ksmbd: prevent memory leak on error return
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: fix kernel-doc comment of ksmbd_vfs_kern_path_locked()
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: no need to wait for binded connection termination at logoff
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: add support for surrogate pair conversion
>
> Kangjing Huang <huangkangjing@gmail.com>
>     ksmbd: fix missing RDMA-capable flag for IPoIB device in ksmbd_rdma_c=
apable_netdev()
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: fix kernel-doc comment of ksmbd_vfs_setxattr()
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: reorganize ksmbd_iov_pin_rsp()
>
> Cheng-Han Wu <hank20010209@gmail.com>
>     ksmbd: Remove unused field in ksmbd_user struct
>
>
> -------------
>
> Diffstat:
>
>  Makefile                                  |   4 +-
>  arch/powerpc/Kconfig                      |   4 +-
>  arch/riscv/Kconfig                        |   4 +-
>  arch/s390/Kconfig                         |   4 +-
>  arch/x86/Kconfig                          |   4 +-
>  drivers/nvme/host/fc.c                    |  21 +--
>  drivers/platform/x86/intel/pmc/adl.c      |   9 +-
>  drivers/platform/x86/intel/pmc/cnp.c      |  26 ++-
>  drivers/platform/x86/intel/pmc/core.c     |  12 +-
>  drivers/platform/x86/intel/pmc/core.h     |   7 +-
>  drivers/platform/x86/intel/pmc/mtl.c      |   9 +-
>  drivers/platform/x86/intel/pmc/tgl.c      |   9 +-
>  drivers/platform/x86/p2sb.c               | 178 ++++++++++++++++-----
>  drivers/virtio/virtio_ring.c              |   6 +-
>  fs/libfs.c                                |  41 +++--
>  fs/smb/client/file.c                      |  18 ++-
>  fs/smb/client/fscache.h                   |   6 +-
>  fs/smb/client/inode.c                     |  17 +-
>  fs/smb/client/smb2ops.c                   |   6 +-
>  fs/smb/common/smb2pdu.h                   |   1 +
>  fs/smb/server/connection.c                |  16 --
>  fs/smb/server/ksmbd_work.c                |  51 +++---
>  fs/smb/server/mgmt/user_config.h          |   1 -
>  fs/smb/server/oplock.c                    | 118 ++++++++++++--
>  fs/smb/server/oplock.h                    |   8 +-
>  fs/smb/server/smb2misc.c                  |  15 +-
>  fs/smb/server/smb2ops.c                   |   9 +-
>  fs/smb/server/smb2pdu.c                   | 258 ++++++++++++++++--------=
------
>  fs/smb/server/transport_rdma.c            |  40 +++--
>  fs/smb/server/unicode.c                   | 187 ++++++++++++++++------
>  fs/smb/server/vfs.c                       |  14 +-
>  fs/smb/server/vfs_cache.c                 |  30 ++--
>  fs/smb/server/vfs_cache.h                 |   9 +-
>  include/linux/blkdev.h                    |   2 +-
>  include/linux/export-internal.h           |   6 +-
>  include/linux/fs.h                        |  85 ++++++++--
>  kernel/Kconfig.kexec                      |   2 +
>  kernel/trace/ftrace.c                     | 100 ++++++------
>  kernel/trace/ring_buffer.c                |  12 +-
>  kernel/trace/trace.c                      |  20 ++-
>  lib/maple_tree.c                          |  11 ++
>  mm/filemap.c                              |   9 ++
>  mm/memory-failure.c                       |   8 +-
>  mm/migrate.c                              |   9 +-
>  net/mptcp/protocol.c                      |  27 +++-
>  net/mptcp/protocol.h                      |  63 +++++++-
>  net/mptcp/sockopt.c                       |   5 +-
>  net/mptcp/subflow.c                       |  29 ++--
>  net/netfilter/nf_tables_api.c             |   2 +-
>  net/wireless/core.h                       |   1 +
>  net/wireless/nl80211.c                    |  56 ++++---
>  tools/testing/radix-tree/maple.c          |   2 +-
>  tools/testing/selftests/mm/memfd_secret.c |   3 +
>  53 files changed, 1070 insertions(+), 524 deletions(-)
>
>
>

