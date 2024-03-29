Return-Path: <linux-kernel+bounces-124021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607DA89114C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918661C27F24
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AF23A1DC;
	Fri, 29 Mar 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUY3kklB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F0B21373;
	Fri, 29 Mar 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677630; cv=none; b=ldCIQK0sCvrc6lcZI1qO6o1M6Sqt3jjs2KWgdxo2EU4JdNdTS9XzjdhFfb+Ni5m3BRA9cPt7Epss93yI6L7XzyT7qQG9nzsCnbV34mZo9hrL3O/GiFKNAMwgRvJtcvOrHuMUPHIKXSOtp50Kjjgwg8xAlXaLI5Ra5whoAcIaZrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677630; c=relaxed/simple;
	bh=G4Awk7UfRAKsPrPUt/4ZUd+jvuITI6kB+R0MY0zCTUk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QZa0lnw+tGOkA3cn6ttWJexRwG7tnG9U4sLNxxP/9o93fYnX5xFQfuyDGJM6ZsZ5rN0bBnf9D9Mwz5Gnx7+w4fRj+MbpHWOWQhoLsSi643G6doVltYlBjd5rd7hq1H95VxteMqWCk3Gxguso14R8XhP1hNrAKftokI5DAW3yxx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUY3kklB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31F73C433F1;
	Fri, 29 Mar 2024 02:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711677630;
	bh=G4Awk7UfRAKsPrPUt/4ZUd+jvuITI6kB+R0MY0zCTUk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BUY3kklB2rY5zyOtoBXrzAa8BQLR8pQQRbXYMMut3akmh98tFsst0oNw5zj7exDWC
	 lemSbg/j8JYd4oi3Bf+D9jvGa7RGHmHMFNNw0eUlBh9YTCcNvz3Ng8dBizQWX5nZfi
	 tvlB8bLL/4B4+r7mXc48pfdnbCnCBUQbVuruIyOAFo0l+nrdHMFpMm1aiX7//G8NsZ
	 Z1JyO+3ww7GmJq6+pqW8wDBi2UwSKAABqLKaXNDkK7juJCL27w/7Y/stQ0RAUBaKRl
	 jlrTS2EQV8dL0cg69etIohoZg/k/yvgyCZlaskymgd2HxQ7+cABqucXWaOKRA9rVls
	 vZX22osXbNzyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1DC5BD2D0E1;
	Fri, 29 Mar 2024 02:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tools/resolve_btfids: fix build with musl libc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171167763011.19983.9028255224879641834.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 02:00:30 +0000
References: <20240328110103.28734-1-ncopa@alpinelinux.org>
In-Reply-To: <20240328110103.28734-1-ncopa@alpinelinux.org>
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: bpf@vger.kernel.org, stable@vger.kernel.org, vmalik@redhat.com,
 dxu@dxuuu.xyz, ast@kernel.org, ndesaulniers@google.com, andrii@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 28 Mar 2024 11:59:13 +0100 you wrote:
> Include the header that defines u32.
> 
> Fixes: 9707ac4fe2f5 ("tools/resolve_btfids: Refactor set sorting with types from btf_ids.h")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218647
> Cc: stable@vger.kernel.org
> Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
> 
> [...]

Here is the summary with links:
  - tools/resolve_btfids: fix build with musl libc
    https://git.kernel.org/bpf/bpf/c/62248b22d01e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



