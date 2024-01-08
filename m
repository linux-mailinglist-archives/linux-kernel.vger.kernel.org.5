Return-Path: <linux-kernel+bounces-19699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BCD82711A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A455A1F22F1D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FDC4655A;
	Mon,  8 Jan 2024 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZjUrkmru"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9CD4654B;
	Mon,  8 Jan 2024 14:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD80C433C9;
	Mon,  8 Jan 2024 14:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704723729;
	bh=+XcQhzqAcZx7MwvetyJR66qrtgK91z8Pi2prIoSFj6s=;
	h=From:To:Cc:Subject:Date:From;
	b=ZjUrkmruBoRkq7qb50Mbte7NcsaYoDSTB4t4hGWiQme8hIVU62OQtasebiZNZjqeM
	 S/X/MG6CzTzh8S6J0jKhWU+ckFRdjSrUx9JS08NUVqyKZEChbk1+E9FmmAJXLAlGOi
	 BTibpHmgYxKaoS68Vxc+VIk7JHGwu7AfY3cRM/dc=
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
Subject: [PATCH 4.14 0/7] 4.14.336-rc1 review
Date: Mon,  8 Jan 2024 15:21:54 +0100
Message-ID: <20240108141854.158274814@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.336-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.336-rc1
X-KernelTest-Deadline: 2024-01-10T14:18+00:00
Content-Transfer-Encoding: 8bit

-------------------------------
NOTE, this is the LAST 4.14.y-rc release cycle that is going to happen.
After this release, this branch will be end-of-life.  You all should
have moved to the 4.19.y branch at the very least by now, as this is it,
time to stop using this one.
-------------------------------

This is the start of the stable review cycle for the 4.14.336 release.
There are 7 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 10 Jan 2024 14:18:47 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.336-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.336-rc1

Geert Uytterhoeven <geert+renesas@glider.be>
    mmc: core: Cancel delayed work before releasing host

Jorge Ramirez-Ortiz <jorge@foundries.io>
    mmc: rpmb: fixes pause retune on all RPMB partitions.

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    firewire: ohci: suppress unexpected system reboot in AMD Ryzen machines and ASM108x/VT630x PCIe cards

Ke Xiao <xiaoke@sangfor.com.cn>
    i40e: fix use-after-free in i40e_aqc_add_filters()

Adrian Cinal <adriancinal@gmail.com>
    net: bcmgenet: Fix FCS generation for fragmented skbuffs

Hangyu Hua <hbh25y@gmail.com>
    net: sched: em_text: fix possible memory leak in em_text_destroy()

Siddh Raman Pant <code@siddh.me>
    nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to llcp_local


-------------

Diffstat:

 Makefile                                       |  4 +-
 drivers/firewire/ohci.c                        | 51 ++++++++++++++++++++++++++
 drivers/mmc/core/block.c                       |  7 ++--
 drivers/mmc/core/host.c                        |  1 +
 drivers/net/ethernet/broadcom/genet/bcmgenet.c |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  8 +++-
 net/nfc/llcp_core.c                            | 39 ++++++++++++++++++--
 net/sched/em_text.c                            |  4 +-
 8 files changed, 107 insertions(+), 11 deletions(-)



