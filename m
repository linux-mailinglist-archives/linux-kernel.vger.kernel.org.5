Return-Path: <linux-kernel+bounces-31907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB048833640
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4391C20B62
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B5A171B5;
	Sat, 20 Jan 2024 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5fgAd8l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C62415AEB;
	Sat, 20 Jan 2024 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705784998; cv=none; b=HDxt/eLqA7PqpvJUHHBB/V6tHjL1FK310dF89WDC9oX2FpnILMt+NE+cKv9B+ztEeZR5k8/+CwqxIndh8mG9mmhUsD7SWRJ1Fgrv9+krTRLdQJLW33aQVDMl43i+X1n5r6nX71amNB/RDm8f5ICMN7wfO6rZivQrOQgWyXXeyIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705784998; c=relaxed/simple;
	bh=fjX1QcNSUSDtg3zN9eJIvh1kheAnttohq2CojBDtXqM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d2Jd4VvKUbyKiMTlmJpqRH5eABqynw5vcrOQVWCEQpI6uOrgXxOuph23o0XpIkxa8LNfilhEmKhz/YA4dTf3LLXCoI5pZ3NXE5HUjfqhnFYGDl0zivWl3DbvEyzeBzxJ1KnjHMCsOdltvMNIbzfXa0D+Iayev4DMWuTi3HTRMas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5fgAd8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EF1CC433F1;
	Sat, 20 Jan 2024 21:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784997;
	bh=fjX1QcNSUSDtg3zN9eJIvh1kheAnttohq2CojBDtXqM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f5fgAd8lGmVqY/67XbUSO4Qk0dRCUMvtUJD6k/fd5iG2uct6gv2xMQ3OHM1WYZ8U2
	 ngc78M3hIIoMXED9Rhlsx50MT1WXbiTtNG6ah5EKBwBMud8j+kcgE1H0x+0FnmqSGT
	 BBTDD9MuDisjsB7prVtq2FzT7FYcqsURHqxqgW0uE6WwNcJg/7ykZhWW1w3xibUlyP
	 wX703TQTb8qu6a0/EiiGati/ykJT0BM8pyB94IT1As1Rm6DeIeWHsSDdmfkdUHpJ+M
	 Y4G5OILFVDaAC74ogXv0ePOSln8yYvcsMgVHnWJJUfV+xzzSdGzo674sw/Es00ID6Y
	 cufuVhFU3QLqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D333D8C970;
	Sat, 20 Jan 2024 21:09:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] kexec_file: Load kernel at top of system RAM if required
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170578499750.24348.2518240009884006018.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:57 +0000
References: <20231114091658.228030-1-bhe@redhat.com>
In-Reply-To: <20231114091658.228030-1-bhe@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, x86@kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 akpm@linux-foundation.org, ebiederm@xmission.com, takahiro.akashi@linaro.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Tue, 14 Nov 2023 17:16:56 +0800 you wrote:
> Justification:
> ==============
> Kexec_load interface has been doing top down searching and loading
> kernel/initrd/purgtory etc to prepare for kexec reboot. In that way,
> the benefits are that it avoids to consume and fragment limited low
> memory which satisfy DMA buffer allocation and big chunk of continuous
> memory during system init; and avoids to stir with BIOS/FW reserved
> or occupied areas, or corner case handling/work around/quirk occupied
> areas when doing system init. By the way, the top-down searching and
> loading of kexec-ed kernel is done in user space utility code.
> 
> [...]

Here is the summary with links:
  - [1/2] resource: add walk_system_ram_res_rev()
    (no matching commit)
  - [2/2] kexec_file: Load kernel at top of system RAM if required
    https://git.kernel.org/riscv/c/b3ba234171cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



