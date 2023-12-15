Return-Path: <linux-kernel+bounces-1672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2648151EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1BB1C2424E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1BE47F7D;
	Fri, 15 Dec 2023 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4fW8UQx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9BE48CCE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702676006; x=1734212006;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VzUAfyB/9RVw3KjnMPW33oiOOcUj+9DbrRXuUNFmw4c=;
  b=c4fW8UQxMpPrqnUJBHqjx/phdnxScFfj5z2OF2aYrBSNI+iHdpn3PkaD
   sMdOrgiqNVZMXA1nHl8lKIu80g6Fp5PcUmiroDoxGMq4HUN13YQYEYtKa
   zcWvp1cMoWH4UZGJQOPCxVJedBeCjYQtC7e+gPCmwJqCbUyqwn4Zj6OKq
   0PRICPnjGsKiq/PoxMVcpL76c3YgokcqcMtmfuKYTeH5TGBCyQE5JKjwi
   nrBBwOvHUn7XpejS2/Sn96MUI21VFBnv3mTBtxrKzTb+6O2cvfttzLLqf
   va2Tj+WHAHfr2eXIzaU1P2QBBojOLhjvu2RKt86gm4nXKuHSrzI9wQX3G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="14016672"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="14016672"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 13:33:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="778409573"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="778409573"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 15 Dec 2023 13:33:24 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEFoA-0000mY-0X;
	Fri, 15 Dec 2023 21:33:22 +0000
Date: Sat, 16 Dec 2023 05:33:16 +0800
From: kernel test robot <lkp@intel.com>
To: Steve French <stfrench@microsoft.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: scripts/kernel-doc: fs/smb/server/auth.c:221: warning: Function
 parameter or struct member 'conn' not described in 'ksmbd_auth_ntlmv2'
Message-ID: <202312160506.eMlIWFK0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Steve,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3f7168591ebf7bbdb91797d02b1afaf00a4289b1
commit: 38c8a9a52082579090e34c033d439ed2cd1a462d smb: move client and server files to common directory fs/smb
date:   7 months ago
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20231216/202312160506.eMlIWFK0-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312160506.eMlIWFK0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312160506.eMlIWFK0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> scripts/kernel-doc: fs/smb/server/auth.c:221: warning: Function parameter or struct member 'conn' not described in 'ksmbd_auth_ntlmv2'
>> scripts/kernel-doc: fs/smb/server/auth.c:221: warning: Function parameter or struct member 'cryptkey' not described in 'ksmbd_auth_ntlmv2'
>> scripts/kernel-doc: fs/smb/server/auth.c:305: warning: Function parameter or struct member 'blob_len' not described in 'ksmbd_decode_ntlmssp_auth_blob'
>> scripts/kernel-doc: fs/smb/server/auth.c:305: warning: Function parameter or struct member 'conn' not described in 'ksmbd_decode_ntlmssp_auth_blob'
>> scripts/kernel-doc: fs/smb/server/auth.c:305: warning: Excess function parameter 'usr' description in 'ksmbd_decode_ntlmssp_auth_blob'
>> scripts/kernel-doc: fs/smb/server/auth.c:382: warning: Function parameter or struct member 'blob_len' not described in 'ksmbd_decode_ntlmssp_neg_blob'
>> scripts/kernel-doc: fs/smb/server/auth.c:382: warning: Function parameter or struct member 'conn' not described in 'ksmbd_decode_ntlmssp_neg_blob'
>> scripts/kernel-doc: fs/smb/server/auth.c:382: warning: Excess function parameter 'rsp' description in 'ksmbd_decode_ntlmssp_neg_blob'
>> scripts/kernel-doc: fs/smb/server/auth.c:382: warning: Excess function parameter 'sess' description in 'ksmbd_decode_ntlmssp_neg_blob'
>> scripts/kernel-doc: fs/smb/server/auth.c:410: warning: Function parameter or struct member 'conn' not described in 'ksmbd_build_ntlmssp_challenge_blob'
>> scripts/kernel-doc: fs/smb/server/auth.c:410: warning: Excess function parameter 'rsp' description in 'ksmbd_build_ntlmssp_challenge_blob'
>> scripts/kernel-doc: fs/smb/server/auth.c:410: warning: Excess function parameter 'sess' description in 'ksmbd_build_ntlmssp_challenge_blob'
--
>> scripts/kernel-doc: fs/smb/server/vfs.c:54: warning: Function parameter or struct member 'parent' not described in 'ksmbd_vfs_lock_parent'
>> scripts/kernel-doc: fs/smb/server/vfs.c:54: warning: Function parameter or struct member 'child' not described in 'ksmbd_vfs_lock_parent'
>> scripts/kernel-doc: fs/smb/server/vfs.c:356: warning: Function parameter or struct member 'fp' not described in 'ksmbd_vfs_read'
>> scripts/kernel-doc: fs/smb/server/vfs.c:356: warning: Excess function parameter 'fid' description in 'ksmbd_vfs_read'
>> scripts/kernel-doc: fs/smb/server/vfs.c:472: warning: Function parameter or struct member 'fp' not described in 'ksmbd_vfs_write'
>> scripts/kernel-doc: fs/smb/server/vfs.c:472: warning: Excess function parameter 'fid' description in 'ksmbd_vfs_write'
>> scripts/kernel-doc: fs/smb/server/vfs.c:535: warning: Function parameter or struct member 'path' not described in 'ksmbd_vfs_getattr'
>> scripts/kernel-doc: fs/smb/server/vfs.c:535: warning: Function parameter or struct member 'stat' not described in 'ksmbd_vfs_getattr'
>> scripts/kernel-doc: fs/smb/server/vfs.c:535: warning: Excess function parameter 'work' description in 'ksmbd_vfs_getattr'
>> scripts/kernel-doc: fs/smb/server/vfs.c:535: warning: Excess function parameter 'fid' description in 'ksmbd_vfs_getattr'
>> scripts/kernel-doc: fs/smb/server/vfs.c:535: warning: Excess function parameter 'attrs' description in 'ksmbd_vfs_getattr'
>> scripts/kernel-doc: fs/smb/server/vfs.c:552: warning: Function parameter or struct member 'p_id' not described in 'ksmbd_vfs_fsync'
>> scripts/kernel-doc: fs/smb/server/vfs.c:575: warning: Function parameter or struct member 'work' not described in 'ksmbd_vfs_remove_file'
>> scripts/kernel-doc: fs/smb/server/vfs.c:575: warning: Function parameter or struct member 'path' not described in 'ksmbd_vfs_remove_file'
>> scripts/kernel-doc: fs/smb/server/vfs.c:575: warning: Excess function parameter 'name' description in 'ksmbd_vfs_remove_file'
>> scripts/kernel-doc: fs/smb/server/vfs.c:613: warning: Function parameter or struct member 'work' not described in 'ksmbd_vfs_link'
>> scripts/kernel-doc: fs/smb/server/vfs.c:779: warning: Function parameter or struct member 'fp' not described in 'ksmbd_vfs_truncate'
>> scripts/kernel-doc: fs/smb/server/vfs.c:779: warning: Excess function parameter 'fid' description in 'ksmbd_vfs_truncate'
>> scripts/kernel-doc: fs/smb/server/vfs.c:820: warning: Excess function parameter 'size' description in 'ksmbd_vfs_listxattr'
>> scripts/kernel-doc: fs/smb/server/vfs.c:917: warning: Function parameter or struct member 'option' not described in 'ksmbd_vfs_set_fadvise'
   scripts/kernel-doc: fs/smb/server/vfs.c:917: warning: Excess function parameter 'options' description in 'ksmbd_vfs_set_fadvise'
   scripts/kernel-doc: fs/smb/server/vfs.c:1117: warning: Function parameter or struct member 'um' not described in 'ksmbd_vfs_lookup_in_dir'
   scripts/kernel-doc: fs/smb/server/vfs.c:1152: warning: Function parameter or struct member 'work' not described in 'ksmbd_vfs_kern_path_locked'
--
>> scripts/kernel-doc: fs/smb/server/misc.c:269: warning: Function parameter or struct member 'um' not described in 'ksmbd_extract_sharename'
--
>> scripts/kernel-doc: fs/smb/server/transport_tcp.c:373: warning: Function parameter or struct member 'max_retries' not described in 'ksmbd_tcp_read'
>> scripts/kernel-doc: fs/smb/server/transport_tcp.c:422: warning: Function parameter or struct member 'iface' not described in 'create_socket'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

