Return-Path: <linux-kernel+bounces-25248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4ED82CBB0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 11:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3CB51F23505
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A143610958;
	Sat, 13 Jan 2024 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vovk1fYA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB95E185A;
	Sat, 13 Jan 2024 10:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B956C433F1;
	Sat, 13 Jan 2024 10:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705140155;
	bh=Lpqomv6yINfDgfYvdmGQosJFAe5tGqe9/wyszdmObRA=;
	h=From:To:Cc:Subject:Date:From;
	b=vovk1fYApjgsNyO9uXb4+Zlwwrg3yXz6+Qh/nGLIisqC+ay3HHvEgLz4yNCeT4yLN
	 MlrJFtCBPqHZByTkAf7OZ/uD8vp2zup77/iCUnHNeGFZWFni6+V7FlqfI2S7n/5/fK
	 ug5x0esDEyKXC5B0IF8lFzDp7k+muFCUr5lVArbs=
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
Subject: [PATCH 6.1 0/4] 6.1.73-rc1 review
Date: Sat, 13 Jan 2024 10:50:38 +0100
Message-ID: <20240113094204.017594027@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.73-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.73-rc1
X-KernelTest-Deadline: 2024-01-15T09:42+00:00
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.1.73 release.
There are 4 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.73-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.73-rc1

Jon Maxwell <jmaxwell37@gmail.com>
    ipv6: remove max_size check inline with ipv4

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "nfsd: separate nfsd_last_thread() from nfsd_put()"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "nfsd: call nfsd_last_thread() before final nfsd_put()"

Steve French <stfrench@microsoft.com>
    cifs: fix flushing folio regression for 6.1 backport


-------------

Diffstat:

 Makefile               |  4 ++--
 fs/nfsd/nfsctl.c       |  9 ++-------
 fs/nfsd/nfsd.h         |  8 +-------
 fs/nfsd/nfssvc.c       | 52 ++++++++++++++++++++++++++++++++------------------
 fs/smb/client/cifsfs.c |  2 +-
 include/net/dst_ops.h  |  2 +-
 net/core/dst.c         |  8 ++------
 net/ipv6/route.c       | 13 +++++--------
 8 files changed, 47 insertions(+), 51 deletions(-)



