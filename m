Return-Path: <linux-kernel+bounces-68552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFA0857C32
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823491C214BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C817866E;
	Fri, 16 Feb 2024 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gixpaNzp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B30178662
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084705; cv=none; b=pBPq+nASWrtMbW3SWyZ7nJ8pDlQbV9RlhnnnS0tYszwxm/dhrMsAL/TPIYsgAkhltV4XckS3Q/1/HRzP2iZayrYaf/HOkpRv2LKe0ki+wXr5ofBbMdKsVXdM0xdImMCKa/2O7doXev9Uequ6jZkl1UuHfqoMfqlPVo77XG/nBws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084705; c=relaxed/simple;
	bh=0d42dEMNHwKVa/1k+xK+Wa7qKmbqWJQ8Ci5f04PXTZw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c+sv/c/nvBd82+AdOoqrYm0e8Ck8HYgAXWnF4Ot7ZVbPPS1u4+Qkq1wM31Y3nk829G7kteTaZz11SUQVeCNUs3y7NbrpkXvwnKtllQ5MKp6+OYFYpv4EdwU1xQl1ylidjLNN2Tr8thDPSlqNSktrKqiLRbzW3rd8IHPUIOIOTWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gixpaNzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74C9C433F1;
	Fri, 16 Feb 2024 11:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708084704;
	bh=0d42dEMNHwKVa/1k+xK+Wa7qKmbqWJQ8Ci5f04PXTZw=;
	h=Date:From:To:Cc:Subject:From;
	b=gixpaNzpDnCH9T8rN4hHCt4OXiQLqL/JwpcZWgGX1KoRkzlAuZAILMpeJCOsXM+18
	 YfrVcow/TlN333Lpv0/EveHPB6PFYhAHdw3wdPhGs2H8w0iRFuw6TccN2NEosgK7fK
	 vSQg8scGxpYgA1Kcf7nRbD0fXYqtJJz4b+vMe++sQg0dZHnOBLRyv9VAn0xXdQ0Dcr
	 kPVwN61UYxrOkPK/53AT8jM7nrRzYNYaSF7FJA22H3mg8msXy6Jg9892NCndqvU60t
	 917+hKSci38hTlcy/rj4mfvdO5veDNj3oSOTe6eC9WqXkiMT6oc+iJ503eYBSDj8lz
	 1STkAgu8SQFkw==
Date: Fri, 16 Feb 2024 11:58:20 +0000
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc5
Message-ID: <20240216115819.GA1804@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Linus,

Please pull these arm64 fixes for -rc5. It's a little busier than normal,
but it's still not a lot of code and things seem fairly quiet in general.

Summary in the tag.

Cheers,

Will

--->8

The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 2813926261e436d33bc74486b51cce60b76edf78:

  arm64/sve: Lower the maximum allocation for the SVE ptrace regset (2024-02-15 11:48:00 +0000)

----------------------------------------------------------------
arm64 fixes for -rc5

- Fix allocation failure during SVE coredumps

- Fix handling of SVE context on signal delivery

- Enable Neoverse N2 CPU errata workarounds for Microsoft's
  "Azure Cobalt 100" clone

- Work around CMN PMU erratum in AmpereOneX implementation

- Fix typo in CXL PMU event definition

- Fix jump label asm constraints

----------------------------------------------------------------
Easwar Hariharan (1):
      arm64: Subscribe Microsoft Azure Cobalt 100 to ARM Neoverse N2 errata

Fangrui Song (1):
      arm64: jump_label: use constraints "Si" instead of "i"

Hojin Nam (1):
      perf: CXL: fix mismatched cpmu event opcode

Ilkka Koskinen (1):
      perf/arm-cmn: Workaround AmpereOneX errata AC04_MESH_1 (incorrect child count)

Mark Brown (2):
      arm64/signal: Don't assume that TIF_SVE means we saved SVE state
      arm64/sve: Lower the maximum allocation for the SVE ptrace regset

Seongsu Park (1):
      arm64: fix typo in comments

 Documentation/arch/arm64/silicon-errata.rst |  7 +++++++
 arch/arm64/include/asm/cpufeature.h         |  2 +-
 arch/arm64/include/asm/cputype.h            |  4 ++++
 arch/arm64/include/asm/fpsimd.h             | 12 ++++++------
 arch/arm64/include/asm/jump_label.h         | 12 ++++++++----
 arch/arm64/kernel/cpu_errata.c              |  3 +++
 arch/arm64/kernel/fpsimd.c                  |  2 +-
 arch/arm64/kernel/ptrace.c                  |  3 ++-
 arch/arm64/kernel/signal.c                  |  4 ++--
 drivers/perf/arm-cmn.c                      | 11 +++++++++++
 drivers/perf/cxl_pmu.c                      |  2 +-
 11 files changed, 46 insertions(+), 16 deletions(-)

