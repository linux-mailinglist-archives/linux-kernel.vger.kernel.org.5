Return-Path: <linux-kernel+bounces-7268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB4D81A42B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC031F22AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283C04BA9D;
	Wed, 20 Dec 2023 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wPoEMt9I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70701495E3;
	Wed, 20 Dec 2023 16:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F84C433C8;
	Wed, 20 Dec 2023 16:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088722;
	bh=z+kKJo9/aFLBw2osVee4R3eBrOZbQpZ8IemEluY7Uuk=;
	h=From:To:Cc:Subject:Date:From;
	b=wPoEMt9IXaG/E+iZ2z/Lu1/JeGm9RsJ9D1556/21BeMfrq+ZszokAQ8xPUsDdYq0S
	 bj7ytn/Rn3Wd7d2e+an7X6JI/KHlORndqdZPgSlODPpBcA6HWGqnCN3l4DA66E6nIk
	 EQYpaJ5MwbHAimHml6kdXLHngPjzUdL1z+AmOXAo=
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
Subject: [PATCH 5.15 000/159] 5.15.145-rc1 review
Date: Wed, 20 Dec 2023 17:07:45 +0100
Message-ID: <20231220160931.251686445@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.145-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.145-rc1
X-KernelTest-Deadline: 2023-12-22T16:09+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.15.145 release.
There are 159 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 22 Dec 2023 16:08:59 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.145-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.145-rc1

Arnd Bergmann <arnd@arndb.de>
    kasan: disable kasan_non_canonical_hook() for HW tags

Francis Laniel <flaniel@linux.microsoft.com>
    tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols

Amit Pundir <amit.pundir@linaro.org>
    Revert "drm/bridge: lt9611uxc: Switch to devm MIPI-DSI helpers"

Amit Pundir <amit.pundir@linaro.org>
    Revert "drm/bridge: lt9611uxc: Register and attach our DSI device at probe"

Amit Pundir <amit.pundir@linaro.org>
    Revert "drm/bridge: lt9611uxc: fix the race in the error path"

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
    ksmbd: handle malformed smb1 message

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
    ksmbd: fix race condition between session lookup and expire

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

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix slub overflow in ksmbd_decode_ntlmssp_auth_blob()

Yang Li <yang.lee@linux.alibaba.com>
    ksmbd: Fix one kernel-doc comment

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: reduce descriptor size if remaining bytes is less than request size

Atte Heikkilä <atteh.mailbox@gmail.com>
    ksmbd: fix `force create mode' and `force directory mode'

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix wrong interim response on compound

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: add support for read compound

Yang Yingliang <yangyingliang@huawei.com>
    ksmbd: switch to use kmemdup_nul() helper

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix out of bounds in init_smb2_rsp_hdr()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: validate session id and tree id in compound request

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: check if a mount point is crossed during path lookup

Wang Ming <machel@vivo.com>
    ksmbd: Fix unsigned expression compared with zero

Gustavo A. R. Silva <gustavoars@kernel.org>
    ksmbd: Replace one-element array with flexible-array member

Gustavo A. R. Silva <gustavoars@kernel.org>
    ksmbd: Use struct_size() helper in ksmbd_negotiate_smb_dialect()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: add missing compound request handing in some commands

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix out of bounds read in smb2_sess_setup

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
    ksmbd: validate smb request protocol id

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: check the validation of pdu_size in ksmbd_conn_handler_loop

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix posix_acls and acls dereferencing possible ERR_PTR()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix out-of-bound read in parse_lease_state()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix out-of-bound read in deassemble_neg_contexts()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: call putname after using the last component

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix UAF issue from opinfo->conn

Kuan-Ting Chen <h3xrabbit@gmail.com>
    ksmbd: fix multiple out-of-bounds read during context decoding

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix uninitialized pointer read in smb2_create_link()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix uninitialized pointer read in ksmbd_vfs_rename()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix racy issue under cocurrent smb2 tree disconnect

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix racy issue from smb2 close and logoff with multichannel

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: block asynchronous requests when making a delay on session setup

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: destroy expired sessions

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix racy issue from session setup and logoff

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

David Disseldorp <ddiss@suse.de>
    ksmbd: avoid out of bounds access in decode_preauth_ctxt()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix slab-out-of-bounds in init_smb2_rsp_hdr

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: delete asynchronous work from list

Tom Rix <trix@redhat.com>
    ksmbd: remove unused is_char_allowed function

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix wrong signingkey creation when encryption is AES256

Hangyu Hua <hbh25y@gmail.com>
    ksmbd: fix possible memory leak in smb2_lock()

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

Dawei Li <set_pte_at@outlook.com>
    ksmbd: Implements sess->ksmbd_chann_list as xarray

Marios Makassikis <mmakassikis@freebox.fr>
    ksmbd: send proper error response in smb2_tree_connect()

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

Atte Heikkilä <atteh.mailbox@gmail.com>
    ksmbd: validate share name from share config response

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: call ib_drain_qp when disconnected

Atte Heikkilä <atteh.mailbox@gmail.com>
    ksmbd: make utf-8 file name comparison work in __caseless_lookup()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: hide socket error message when ipv6 config is disable

Tom Talpey <tom@talpey.com>
    ksmbd: reduce server smbdirect max send/receive segment sizes

Tom Talpey <tom@talpey.com>
    ksmbd: decrease the number of SMB3 smbdirect server SGEs

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: set NTLMSSP_NEGOTIATE_SEAL flag to challenge blob

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix encryption failure issue for session logoff response

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fill sids in SMB_FIND_FILE_POSIX_INFO response

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: set file permission mode to match Samba server posix extension behavior

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: change security id to the one samba used for posix extension

Atte Heikkilä <atteh.mailbox@gmail.com>
    ksmbd: casefold utf-8 share names and fix ascii lowercase conversion

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: remove generic_fillattr use in smb2_open()

Al Viro <viro@zeniv.linux.org.uk>
    ksmbd: constify struct path

Al Viro <viro@zeniv.linux.org.uk>
    ksmbd: don't open-code %pD

Al Viro <viro@zeniv.linux.org.uk>
    ksmbd: don't open-code file_path()

Hyunchul Lee <hyc.lee@gmail.com>
    ksmbd: remove unnecessary generic_fillattr in smb2_open

Atte Heikkilä <atteh.mailbox@gmail.com>
    ksmbd: request update to stale share config

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: use wait_event instead of schedule_timeout()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: remove unused ksmbd_share_configs_cleanup function

Hyunchul Lee <hyc.lee@gmail.com>
    ksmbd: remove duplicate flag set in smb2_write

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    ksmbd: smbd: Remove useless license text when SPDX-License-Identifier is already used

Hyunchul Lee <hyc.lee@gmail.com>
    ksmbd: smbd: relax the count of sges required

Hyunchul Lee <hyc.lee@gmail.com>
    ksmbd: smbd: fix connection dropped issue

Yang Li <yang.lee@linux.alibaba.com>
    ksmbd: Fix some kernel-doc comments

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix wrong smbd max read/write size check

Hyunchul Lee <hyc.lee@gmail.com>
    ksmbd: smbd: handle multiple Buffer descriptors

Hyunchul Lee <hyc.lee@gmail.com>
    ksmbd: smbd: change the return value of get_sg_list

Hyunchul Lee <hyc.lee@gmail.com>
    ksmbd: smbd: simplify tracking pending packets

Hyunchul Lee <hyc.lee@gmail.com>
    ksmbd: smbd: introduce read/write credits for RDMA read/write

Hyunchul Lee <hyc.lee@gmail.com>
    ksmbd: smbd: change prototypes of RDMA read/write related functions

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: validate length in smb2_write()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: remove filename in ksmbd_file

Steve French <stfrench@microsoft.com>
    smb3: fix ksmbd bigendian bug in oplock break, and move its struct to smbfs_common

Jakob Koschel <jakobkoschel@gmail.com>
    ksmbd: replace usage of found with dedicated list iterator variable

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    ksmbd: Remove a redundant zeroing of memory

Steve French <stfrench@microsoft.com>
    ksmbd: shorten experimental warning on loading the module

Paulo Alcantara (SUSE) <pc@cjr.nz>
    ksmbd: store fids as opaque u64 integers

Tobias Klauser <tklauser@distanz.ch>
    ksmbd: use netif_is_bridge_port

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: add support for key exchange

Hyunchul Lee <hyc.lee@gmail.com>
    ksmbd: smbd: validate buffer descriptor structures

Hyunchul Lee <hyc.lee@gmail.com>
    ksmbd: smbd: fix missing client's memory region invalidation

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: add smb-direct shutdown

Hyunchul Lee <hyc.lee@gmail.com>
    ksmbd: smbd: change the default maximum read/write, receive size

Hyunchul Lee <hyc.lee@gmail.com>
    ksmbd: smbd: create MR pool

Hyunchul Lee <hyc.lee@gmail.com>
    ksmbd: smbd: call rdma_accept() under CM handler

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: set 445 port to smbdirect port by default

Hyunchul Lee <hyc.lee@gmail.com>
    ksmbd: register ksmbd ib client with ib_register_client()

Yang Li <yang.lee@linux.alibaba.com>
    ksmbd: Fix smb2_get_name() kernel-doc comment

Yang Li <yang.lee@linux.alibaba.com>
    ksmbd: Delete an invalid argument description in smb2_populate_readdir_entry()

Yang Li <yang.lee@linux.alibaba.com>
    ksmbd: Fix smb2_set_info_file() kernel-doc comment

Yang Li <yang.lee@linux.alibaba.com>
    ksmbd: Fix buffer_check_err() kernel-doc comment

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: set both ipv4 and ipv6 in FSCTL_QUERY_NETWORK_INTERFACE_INFO

Marios Makassikis <mmakassikis@freebox.fr>
    ksmbd: Remove unused fields from ksmbd_file struct definition

Marios Makassikis <mmakassikis@freebox.fr>
    ksmbd: Remove unused parameter from smb2_get_name()

Hyunchul Lee <hyc.lee@gmail.com>
    ksmbd: use oid registry functions to decode OIDs

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: change LeaseKey data type to u8 array

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: remove smb2_buf_length in smb2_transform_hdr

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: remove smb2_buf_length in smb2_hdr

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: remove md4 leftovers

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    ksmbd: Remove redundant 'flush_workqueue()' calls

Ralph Boehme <slow@samba.org>
    ksmdb: use cmd helper variable in smb2_get_ksmbd_tcon()

Ralph Boehme <slow@samba.org>
    ksmbd: use ksmbd_req_buf_next() in ksmbd_verify_smb_message()


-------------

Diffstat:

 Makefile                                   |    4 +-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c |   75 +-
 fs/ksmbd/Kconfig                           |   11 +-
 fs/ksmbd/asn1.c                            |  173 +--
 fs/ksmbd/auth.c                            |   72 +-
 fs/ksmbd/auth.h                            |    3 +-
 fs/ksmbd/connection.c                      |  169 +--
 fs/ksmbd/connection.h                      |   92 +-
 fs/ksmbd/ksmbd_netlink.h                   |    7 +-
 fs/ksmbd/ksmbd_work.c                      |  101 +-
 fs/ksmbd/ksmbd_work.h                      |   40 +-
 fs/ksmbd/mgmt/share_config.c               |   56 +-
 fs/ksmbd/mgmt/share_config.h               |   36 +-
 fs/ksmbd/mgmt/tree_connect.c               |   78 +-
 fs/ksmbd/mgmt/tree_connect.h               |   15 +-
 fs/ksmbd/mgmt/user_config.h                |    1 -
 fs/ksmbd/mgmt/user_session.c               |  180 +--
 fs/ksmbd/mgmt/user_session.h               |    8 +-
 fs/ksmbd/misc.c                            |   94 +-
 fs/ksmbd/misc.h                            |    6 +-
 fs/ksmbd/oplock.c                          |  256 ++--
 fs/ksmbd/oplock.h                          |    4 -
 fs/ksmbd/server.c                          |   54 +-
 fs/ksmbd/smb2misc.c                        |    4 +-
 fs/ksmbd/smb2ops.c                         |   10 +-
 fs/ksmbd/smb2pdu.c                         | 2047 ++++++++++++++--------------
 fs/ksmbd/smb2pdu.h                         |   83 +-
 fs/ksmbd/smb_common.c                      |  176 ++-
 fs/ksmbd/smb_common.h                      |   20 +-
 fs/ksmbd/smbacl.c                          |   26 +-
 fs/ksmbd/smbacl.h                          |    8 +-
 fs/ksmbd/transport_ipc.c                   |    4 +-
 fs/ksmbd/transport_rdma.c                  |  648 ++++++---
 fs/ksmbd/transport_rdma.h                  |    6 +-
 fs/ksmbd/transport_tcp.c                   |    9 +-
 fs/ksmbd/unicode.c                         |  191 ++-
 fs/ksmbd/unicode.h                         |    3 +-
 fs/ksmbd/vfs.c                             |  677 ++++-----
 fs/ksmbd/vfs.h                             |   56 +-
 fs/ksmbd/vfs_cache.c                       |   72 +-
 fs/ksmbd/vfs_cache.h                       |   26 +-
 fs/namei.c                                 |  125 +-
 include/linux/kasan.h                      |    6 +-
 include/linux/namei.h                      |    7 +
 kernel/trace/trace_kprobe.c                |   74 +
 kernel/trace/trace_probe.h                 |    1 +
 mm/kasan/report.c                          |    4 +-
 47 files changed, 3279 insertions(+), 2539 deletions(-)



