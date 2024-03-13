Return-Path: <linux-kernel+bounces-101732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC2787AB1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BD61F227A2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D6638DC8;
	Wed, 13 Mar 2024 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoWXnZHA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE914A9BF;
	Wed, 13 Mar 2024 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347423; cv=none; b=LjgiXYIL0JbhWFSjTJSB/IvGKTOtjI/octtY2TQ0PHR9t6whuMhip3IB2dvA0sMWhQH5ihO7Ip1aAlcwfQ5yZjMXIYP1mYHm0dNXf3MV3xyu5rAEziXlTCZ1fE9Ku2o1q796j5PtqbGI9ChY6/981IVh0b5prmL6W2KzI9NK0LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347423; c=relaxed/simple;
	bh=qOlJqIzqMFXRvIV9QUgDbr119e1LZbmHCf8TLLDruzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JNeEI+bNuluwLfXMJAqYoOuGv3uOqc7TV7D6TkeBNig1fTi9Flb3slbnvx4fgpxc+DydMbyk+smIfFt/NMiz/ChmeAIErsCRsBMTpypiq8BDBRAziXFguawPrPgMCVYNWeHcxqbJHNiZB3E8rae8OyIMXR2p56N3S6qfqrus6/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoWXnZHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5C2C433C7;
	Wed, 13 Mar 2024 16:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347422;
	bh=qOlJqIzqMFXRvIV9QUgDbr119e1LZbmHCf8TLLDruzM=;
	h=From:To:Cc:Subject:Date:From;
	b=VoWXnZHAcIkvO+6FwPGkoSMNfeKspeoKds+XFcJU3xVGfi1JkBk84eDMw2tGDzWWg
	 SFL7LowLazEGYyRN9phfXSGrmQ/Dxo4DWLGgQFfNVhhKEDt9M0c7Os66mwkWUZ/BJo
	 Qkq9mNx8YCSghVCZwryWG+hKu0kifN4AwC/U4r5LXcUjRP3F+R3Qa7iKXm4Nh+/A8k
	 r4oMrq9yDo440MMK1jnzdf2khjzL41UjX9+QLPPGyOJe8ab+XOPXiSrIDTzIlXaVL5
	 bD7RLTOHXmQPJF6WbGSywtu7otSeJk24giRAwYnkpXNgo5RziDPh3gfSfPbbRjPxez
	 RNGii+Ssl9FOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de
Subject: [PATCH 6.8 0/5] 6.8.1-rc1 review
Date: Wed, 13 Mar 2024 12:30:14 -0400
Message-ID: <20240313163019.613705-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.1-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.8.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.8.1-rc1
X-KernelTest-Deadline: 2024-03-15T16:28+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit


This is the start of the stable review cycle for the 6.8.1 release.
There are 5 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Mar 15 04:28:11 PM UTC 2024.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.8.y&id2=v6.8
or in the git tree and branch at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
and the diffstat can be found below.

Thanks,
Sasha

-------------
Pseudo-Shortlog of commits:

Pawan Gupta (4):
  x86/mmio: Disable KVM mitigation when X86_FEATURE_CLEAR_CPU_BUF is set
  Documentation/hw-vuln: Add documentation for RFDS
  x86/rfds: Mitigate Register File Data Sampling (RFDS)
  KVM/x86: Export RFDS_NO and RFDS_CLEAR to guests

Sasha Levin (1):
  Linux 6.8.1-rc1

 .../ABI/testing/sysfs-devices-system-cpu      |   1 +
 Documentation/admin-guide/hw-vuln/index.rst   |   1 +
 .../hw-vuln/reg-file-data-sampling.rst        | 104 ++++++++++++++++++
 .../admin-guide/kernel-parameters.txt         |  21 ++++
 Makefile                                      |   4 +-
 arch/x86/Kconfig                              |  11 ++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   8 ++
 arch/x86/kernel/cpu/bugs.c                    |  92 +++++++++++++++-
 arch/x86/kernel/cpu/common.c                  |  38 ++++++-
 arch/x86/kvm/x86.c                            |   5 +-
 drivers/base/cpu.c                            |   3 +
 include/linux/cpu.h                           |   2 +
 13 files changed, 280 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst

-- 
2.43.0


