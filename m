Return-Path: <linux-kernel+bounces-109410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4273B8818C3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC4E284D32
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4937486126;
	Wed, 20 Mar 2024 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGPR/WNr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CFB5026C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710967839; cv=none; b=iDLF2BVJabUxHXQ2sdB97HhoEbHzTpTeq3ij3N1qxdo7J/0CRWqmN7ws9yq8ae5LCpneSYNW+Wxal58boUlUHMHm43lDvDvogrvk+EGhxGQFYWrD8F38BI0mfi8+im6K4WQPIJC3ldcM8QqE1F3WsjUFuto8MdJDRjak9mklidI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710967839; c=relaxed/simple;
	bh=WctFVZC3uzOKg3omygLLq58GK6rmac3ruk/bV/eUe4E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bx2ydF7rr7WogFHkze7ZsqrnJkVTpEJzBeFmjyxi3m9Bq229Tc15Wfwe17FSrypfG8G+RFWeh+achcRSlg7Khn5Ek0OW8vLJWGqSfdhfG5o/QWgSDrz+tXTWs8zzix65UYJoHnw98RuXkF1uNjiKVMvYvUuQJSh8j6r6m/0ps1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGPR/WNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A4FFC43394;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710967839;
	bh=WctFVZC3uzOKg3omygLLq58GK6rmac3ruk/bV/eUe4E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oGPR/WNrpVEAj8cDjoABAs5QUae39b+h27Kte/8WwnRrufEGZbpJMKKX//IBXuV23
	 ut2CISiKtazHqXYKxQOueZ70YZeT/d0jnqmKE3vYBw7BFg3ml3QpvCM1udzAJXubNY
	 Q6idir5BZLH1XLrRXsZrLWA/8UD/mq4q29SYQ0VxQcp2+e9P2iWHunpPVNh/6b3hhO
	 BhDDVmYBXtOcDkTmTt5PJbH6tzuwDL0//jHHpyRrneX22pvXhYgxHLH04fN8RiGYut
	 KEyxQ31kxLr1yoTrso8e7u5kz2kt7EE77EW5AOQ1cWScaHZDxiEOl8+hIcSPFPpPQ6
	 UR7sqqbmYEtug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1BDD8D982E4;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 0/5] riscv: Introduce compat-mode helpers & improve
 arch_get_mmap_end()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171096783911.6804.6652711937507464203.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 20:50:39 +0000
References: <20240103160024.70305-2-leobras@redhat.com>
In-Reply-To: <20240103160024.70305-2-leobras@redhat.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, ebiederm@xmission.com,
 keescook@chromium.org, oleg@redhat.com, guoren@kernel.org,
 andy.chiu@sifive.com, conor.dooley@microchip.com, xiao.w.wang@intel.com,
 vincent.chen@sifive.com, charlie@rivosinc.com, gerg@kernel.org,
 akpm@linux-foundation.org, shikemeng@huaweicloud.com, alexghiti@rivosinc.com,
 david@redhat.com, willy@infradead.org, panqinglin2020@iscas.ac.cn,
 greentime.hu@sifive.com, bhe@redhat.com, cleger@rivosinc.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  3 Jan 2024 13:00:18 -0300 you wrote:
> I just saw the opportunity of optimizing the helper is_compat_task() by
> introducing a compile-time test, and it made possible to remove some
> #ifdef's without any loss of performance.
> 
> I also saw the possibility of removing the direct check of task flags from
> general code, and concentrated it in asm/compat.h by creating a few more
> helpers, which in the end helped optimize code.
> 
> [...]

Here is the summary with links:
  - [v1,1/5] riscv: Improve arch_get_mmap_end() macro
    https://git.kernel.org/riscv/c/6be7ee4bebd1
  - [v1,2/5] riscv: Replace direct thread flag check with is_compat_task()
    https://git.kernel.org/riscv/c/9dc30419248f
  - [v1,3/5] riscv: add compile-time test into is_compat_task()
    https://git.kernel.org/riscv/c/4c0b5a451675
  - [v1,4/5] riscv: Introduce is_compat_thread() into compat.h
    https://git.kernel.org/riscv/c/5917ea17ad07
  - [v1,5/5] riscv: Introduce set_compat_task() in asm/compat.h
    https://git.kernel.org/riscv/c/2a8986fc5e1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



