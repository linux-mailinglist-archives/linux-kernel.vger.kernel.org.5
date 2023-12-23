Return-Path: <linux-kernel+bounces-10366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A6081D369
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 10:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DBB61F228B5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 09:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBB39466;
	Sat, 23 Dec 2023 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VdhIVjyu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2450944F;
	Sat, 23 Dec 2023 09:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BB1C433C7;
	Sat, 23 Dec 2023 09:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703325394;
	bh=yDdR5/h2aidYbEeKvDEmcpNyaDTTAOyUragWBticefM=;
	h=From:To:Cc:Subject:Date:From;
	b=VdhIVjyuemsLtanN2xs8LKnsdyBT9jJ3OepD8BH2D4ymM/p0O62LqxFS2AV5eEB7G
	 z9IiVGulpv3zwIEjiIAxi+9YbqzfkmOiq+InxXsLeolUuSZDS+HuJVOHAn5j+/lQAM
	 0n0KcRxt6Mcpi2fgR9TdyimpZBmJiA6TL57YtfAk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.145
Date: Sat, 23 Dec 2023 10:56:26 +0100
Message-ID: <2023122324-graceless-unsuited-6ae6@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.145 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                   |    2 
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c |   75 -
 fs/ksmbd/Kconfig                           |   11 
 fs/ksmbd/asn1.c                            |  169 --
 fs/ksmbd/auth.c                            |   72 -
 fs/ksmbd/auth.h                            |    3 
 fs/ksmbd/connection.c                      |  169 +-
 fs/ksmbd/connection.h                      |   92 -
 fs/ksmbd/ksmbd_netlink.h                   |    7 
 fs/ksmbd/ksmbd_work.c                      |  101 +
 fs/ksmbd/ksmbd_work.h                      |   40 
 fs/ksmbd/mgmt/share_config.c               |   56 
 fs/ksmbd/mgmt/share_config.h               |   36 
 fs/ksmbd/mgmt/tree_connect.c               |   80 -
 fs/ksmbd/mgmt/tree_connect.h               |   15 
 fs/ksmbd/mgmt/user_config.h                |    1 
 fs/ksmbd/mgmt/user_session.c               |  180 +-
 fs/ksmbd/mgmt/user_session.h               |    8 
 fs/ksmbd/misc.c                            |   94 +
 fs/ksmbd/misc.h                            |    6 
 fs/ksmbd/oplock.c                          |  258 +--
 fs/ksmbd/oplock.h                          |    4 
 fs/ksmbd/server.c                          |   54 
 fs/ksmbd/smb2misc.c                        |    4 
 fs/ksmbd/smb2ops.c                         |   10 
 fs/ksmbd/smb2pdu.c                         | 2041 ++++++++++++++---------------
 fs/ksmbd/smb2pdu.h                         |   83 -
 fs/ksmbd/smb_common.c                      |  176 +-
 fs/ksmbd/smb_common.h                      |   20 
 fs/ksmbd/smbacl.c                          |   26 
 fs/ksmbd/smbacl.h                          |    8 
 fs/ksmbd/transport_ipc.c                   |    4 
 fs/ksmbd/transport_rdma.c                  |  644 ++++++---
 fs/ksmbd/transport_rdma.h                  |    6 
 fs/ksmbd/transport_tcp.c                   |    9 
 fs/ksmbd/unicode.c                         |  193 +-
 fs/ksmbd/unicode.h                         |    3 
 fs/ksmbd/vfs.c                             |  647 ++++-----
 fs/ksmbd/vfs.h                             |   56 
 fs/ksmbd/vfs_cache.c                       |   72 -
 fs/ksmbd/vfs_cache.h                       |   26 
 fs/namei.c                                 |  125 +
 include/linux/kasan.h                      |    6 
 include/linux/namei.h                      |    7 
 kernel/trace/trace_kprobe.c                |   74 +
 kernel/trace/trace_probe.h                 |    1 
 mm/kasan/report.c                          |    4 
 47 files changed, 3259 insertions(+), 2519 deletions(-)

Al Viro (4):
      ksmbd: don't open-code file_path()
      ksmbd: don't open-code %pD
      ksmbd: constify struct path
      fs: introduce lock_rename_child() helper

Amit Pundir (3):
      Revert "drm/bridge: lt9611uxc: fix the race in the error path"
      Revert "drm/bridge: lt9611uxc: Register and attach our DSI device at probe"
      Revert "drm/bridge: lt9611uxc: Switch to devm MIPI-DSI helpers"

Arnd Bergmann (1):
      kasan: disable kasan_non_canonical_hook() for HW tags

Atte Heikkilä (5):
      ksmbd: request update to stale share config
      ksmbd: casefold utf-8 share names and fix ascii lowercase conversion
      ksmbd: make utf-8 file name comparison work in __caseless_lookup()
      ksmbd: validate share name from share config response
      ksmbd: fix `force create mode' and `force directory mode'

Cheng-Han Wu (1):
      ksmbd: Remove unused field in ksmbd_user struct

Christophe JAILLET (3):
      ksmbd: Remove redundant 'flush_workqueue()' calls
      ksmbd: Remove a redundant zeroing of memory
      ksmbd: smbd: Remove useless license text when SPDX-License-Identifier is already used

Colin Ian King (1):
      ksmbd: Fix spelling mistake "excceed" -> "exceeded"

David Disseldorp (4):
      ksmbd: avoid out of bounds access in decode_preauth_ctxt()
      ksmbd: set NegotiateContextCount once instead of every inc
      ksmbd: avoid duplicate negotiate ctx offset increments
      ksmbd: remove unused compression negotiate ctx packing

Dawei Li (4):
      ksmbd: Implements sess->ksmbd_chann_list as xarray
      ksmbd: Implements sess->rpc_handle_list as xarray
      ksmbd: fix typo, syncronous->synchronous
      ksmbd: Remove duplicated codes

Francis Laniel (1):
      tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols

Greg Kroah-Hartman (1):
      Linux 5.15.145

Gustavo A. R. Silva (3):
      ksmbd: replace one-element arrays with flexible-array members
      ksmbd: Use struct_size() helper in ksmbd_negotiate_smb_dialect()
      ksmbd: Replace one-element array with flexible-array member

Hangyu Hua (1):
      ksmbd: fix possible memory leak in smb2_lock()

Hyunchul Lee (16):
      ksmbd: use oid registry functions to decode OIDs
      ksmbd: register ksmbd ib client with ib_register_client()
      ksmbd: smbd: call rdma_accept() under CM handler
      ksmbd: smbd: create MR pool
      ksmbd: smbd: change the default maximum read/write, receive size
      ksmbd: smbd: fix missing client's memory region invalidation
      ksmbd: smbd: validate buffer descriptor structures
      ksmbd: smbd: change prototypes of RDMA read/write related functions
      ksmbd: smbd: introduce read/write credits for RDMA read/write
      ksmbd: smbd: simplify tracking pending packets
      ksmbd: smbd: change the return value of get_sg_list
      ksmbd: smbd: handle multiple Buffer descriptors
      ksmbd: smbd: fix connection dropped issue
      ksmbd: smbd: relax the count of sges required
      ksmbd: remove duplicate flag set in smb2_write
      ksmbd: remove unnecessary generic_fillattr in smb2_open

Jakob Koschel (1):
      ksmbd: replace usage of found with dedicated list iterator variable

Jeff Layton (1):
      ksmbd: use F_SETLK when unlocking a file

Jiapeng Chong (1):
      ksmbd: Fix parameter name and comment mismatch

Kangjing Huang (1):
      ksmbd: fix missing RDMA-capable flag for IPoIB device in ksmbd_rdma_capable_netdev()

Kuan-Ting Chen (1):
      ksmbd: fix multiple out-of-bounds read during context decoding

Lu Hongfei (2):
      ksmbd: Change the return value of ksmbd_vfs_query_maximal_access to void
      ksmbd: Replace the ternary conditional operator with min()

Marios Makassikis (5):
      ksmbd: Remove unused parameter from smb2_get_name()
      ksmbd: Remove unused fields from ksmbd_file struct definition
      ksmbd: Fix resource leak in smb2_lock()
      ksmbd: send proper error response in smb2_tree_connect()
      ksmbd: fix recursive locking in vfs helpers

Namjae Jeon (79):
      ksmbd: remove md4 leftovers
      ksmbd: remove smb2_buf_length in smb2_hdr
      ksmbd: remove smb2_buf_length in smb2_transform_hdr
      ksmbd: change LeaseKey data type to u8 array
      ksmbd: set both ipv4 and ipv6 in FSCTL_QUERY_NETWORK_INTERFACE_INFO
      ksmbd: set 445 port to smbdirect port by default
      ksmbd: add smb-direct shutdown
      ksmbd: add support for key exchange
      ksmbd: remove filename in ksmbd_file
      ksmbd: validate length in smb2_write()
      ksmbd: fix wrong smbd max read/write size check
      ksmbd: remove unused ksmbd_share_configs_cleanup function
      ksmbd: use wait_event instead of schedule_timeout()
      ksmbd: remove generic_fillattr use in smb2_open()
      ksmbd: change security id to the one samba used for posix extension
      ksmbd: set file permission mode to match Samba server posix extension behavior
      ksmbd: fill sids in SMB_FIND_FILE_POSIX_INFO response
      ksmbd: fix encryption failure issue for session logoff response
      ksmbd: set NTLMSSP_NEGOTIATE_SEAL flag to challenge blob
      ksmbd: hide socket error message when ipv6 config is disable
      ksmbd: call ib_drain_qp when disconnected
      ksmbd: set SMB2_SESSION_FLAG_ENCRYPT_DATA when enforcing data encryption for this share
      ksmbd: fix wrong signingkey creation when encryption is AES256
      ksmbd: delete asynchronous work from list
      ksmbd: fix slab-out-of-bounds in init_smb2_rsp_hdr
      ksmbd: fix racy issue from using ->d_parent and ->d_name
      ksmbd: fix racy issue from session setup and logoff
      ksmbd: destroy expired sessions
      ksmbd: block asynchronous requests when making a delay on session setup
      ksmbd: fix racy issue from smb2 close and logoff with multichannel
      ksmbd: fix racy issue under cocurrent smb2 tree disconnect
      ksmbd: fix uninitialized pointer read in ksmbd_vfs_rename()
      ksmbd: fix uninitialized pointer read in smb2_create_link()
      ksmbd: fix UAF issue from opinfo->conn
      ksmbd: call putname after using the last component
      ksmbd: fix out-of-bound read in deassemble_neg_contexts()
      ksmbd: fix out-of-bound read in parse_lease_state()
      ksmbd: fix posix_acls and acls dereferencing possible ERR_PTR()
      ksmbd: check the validation of pdu_size in ksmbd_conn_handler_loop
      ksmbd: validate smb request protocol id
      ksmbd: add mnt_want_write to ksmbd vfs functions
      ksmbd: remove unused ksmbd_tree_conn_share function
      ksmbd: use kzalloc() instead of __GFP_ZERO
      ksmbd: return a literal instead of 'err' in ksmbd_vfs_kern_path_locked()
      ksmbd: use kvzalloc instead of kvmalloc
      ksmbd: fix out of bounds read in smb2_sess_setup
      ksmbd: add missing compound request handing in some commands
      ksmbd: check if a mount point is crossed during path lookup
      ksmbd: validate session id and tree id in compound request
      ksmbd: fix out of bounds in init_smb2_rsp_hdr()
      ksmbd: add support for read compound
      ksmbd: fix wrong interim response on compound
      ksmbd: reduce descriptor size if remaining bytes is less than request size
      ksmbd: fix slub overflow in ksmbd_decode_ntlmssp_auth_blob()
      ksmbd: add missing calling smb2_set_err_rsp() on error
      ksmbd: remove unneeded mark_inode_dirty in set_info_sec()
      ksmbd: fix passing freed memory 'aux_payload_buf'
      ksmbd: return invalid parameter error response if smb2 request is invalid
      ksmbd: check iov vector index in ksmbd_conn_write()
      ksmbd: fix race condition between session lookup and expire
      ksmbd: fix race condition with fp
      ksmbd: fix race condition from parallel smb2 logoff requests
      ksmbd: fix race condition from parallel smb2 lock requests
      ksmbd: fix race condition between tree conn lookup and disconnect
      ksmbd: fix wrong error response status by using set_smb2_rsp_status()
      ksmbd: fix Null pointer dereferences in ksmbd_update_fstate()
      ksmbd: fix potential double free on smb2_read_pipe() error path
      ksmbd: reorganize ksmbd_iov_pin_rsp()
      ksmbd: fix kernel-doc comment of ksmbd_vfs_setxattr()
      ksmbd: add support for surrogate pair conversion
      ksmbd: no need to wait for binded connection termination at logoff
      ksmbd: fix kernel-doc comment of ksmbd_vfs_kern_path_locked()
      ksmbd: handle malformed smb1 message
      ksmbd: fix possible deadlock in smb2_open
      ksmbd: separately allocate ci per dentry
      ksmbd: move oplock handling after unlock parent dir
      ksmbd: release interim response after sending status pending response
      ksmbd: move setting SMB2_FLAGS_ASYNC_COMMAND and AsyncId
      ksmbd: don't update ->op_state as OPLOCK_STATE_NONE on error

Paulo Alcantara (SUSE) (1):
      ksmbd: store fids as opaque u64 integers

Ralph Boehme (2):
      ksmbd: use ksmbd_req_buf_next() in ksmbd_verify_smb_message()
      ksmdb: use cmd helper variable in smb2_get_ksmbd_tcon()

Steve French (4):
      ksmbd: shorten experimental warning on loading the module
      smb3: fix ksmbd bigendian bug in oplock break, and move its struct to smbfs_common
      ksmbd: update Kconfig to note Kerberos support and fix indentation
      ksmbd: remove experimental warning

Tobias Klauser (1):
      ksmbd: use netif_is_bridge_port

Tom Rix (1):
      ksmbd: remove unused is_char_allowed function

Tom Talpey (2):
      ksmbd: decrease the number of SMB3 smbdirect server SGEs
      ksmbd: reduce server smbdirect max send/receive segment sizes

Wang Ming (1):
      ksmbd: Fix unsigned expression compared with zero

Yang Li (6):
      ksmbd: Fix buffer_check_err() kernel-doc comment
      ksmbd: Fix smb2_set_info_file() kernel-doc comment
      ksmbd: Delete an invalid argument description in smb2_populate_readdir_entry()
      ksmbd: Fix smb2_get_name() kernel-doc comment
      ksmbd: Fix some kernel-doc comments
      ksmbd: Fix one kernel-doc comment

Yang Yingliang (1):
      ksmbd: switch to use kmemdup_nul() helper

Zongmin Zhou (1):
      ksmbd: prevent memory leak on error return

ye xingchen (1):
      ksmbd: Convert to use sysfs_emit()/sysfs_emit_at() APIs


