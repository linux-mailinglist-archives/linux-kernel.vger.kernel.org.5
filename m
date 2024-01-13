Return-Path: <linux-kernel+bounces-25249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A942282CBB3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 11:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480851F2325B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B3F17541;
	Sat, 13 Jan 2024 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XoOXsNNt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B071EEE6;
	Sat, 13 Jan 2024 10:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14652C433F1;
	Sat, 13 Jan 2024 10:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705140161;
	bh=nA9nD1RLi9ISxENfFr7MGcWankNBBn5JWLnGqBrBGFY=;
	h=From:To:Cc:Subject:Date:From;
	b=XoOXsNNtQ/4noAHnrSLT/E0gZl0s+6gewLFrJKcxWkLzR7/garjV7P8F4u2J/4vyf
	 GY7CpciMtxUXWicStExIMuT7z4TcoNCtn1VLr6Y4bj8v5GN6mnV5bWkqsLY+bJlnCW
	 b4E2RQ6Qq+368s5AdRqKQXwTYb3Ch74Vi5ytqS6E=
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
Subject: [PATCH 6.6 0/1] 6.6.12-rc1 review
Date: Sat, 13 Jan 2024 10:50:58 +0100
Message-ID: <20240113094204.275569789@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.12-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.12-rc1
X-KernelTest-Deadline: 2024-01-15T09:42+00:00
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.6.12 release.
There are 1 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.12-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.6.12-rc1

Jeff Layton <jlayton@kernel.org>
    nfsd: drop the nfsd_put helper


-------------

Diffstat:

 Makefile         |  4 ++--
 fs/nfsd/nfsctl.c | 31 +++++++++++++++++--------------
 fs/nfsd/nfsd.h   |  7 -------
 3 files changed, 19 insertions(+), 23 deletions(-)



