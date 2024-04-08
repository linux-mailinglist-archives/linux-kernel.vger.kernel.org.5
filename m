Return-Path: <linux-kernel+bounces-135205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEA389BCB1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01D21F22715
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361D852F85;
	Mon,  8 Apr 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/pR2fP9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7868B52F62;
	Mon,  8 Apr 2024 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571026; cv=none; b=TC621ADp7RPSMgkCyf5tod8irdD9maktKGgytFa5ihB1CGW5xTPHtP3O3a9dPln86JwxP0nwEXRa+RNQlTnwcK6KzqU6jGmJGtsOBiqp0qGe+5RxDp2QnqweowwMM0u5drrPQQPT9vPdybxHHBy1P3d08Yfa0h4I0r/+9Jb8NCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571026; c=relaxed/simple;
	bh=HPmoHWUkifmtc02r8Vvw4XPt6kaQ6hZkler7r/Mjbp8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dpcs6QICVWUXJObEl0D9M2UT9qLjqpjjuJ+sXJmN2kDQcKvuaKpVqswgWQAin23UzLQNwucxdOzSVc67NKVOiZtPJ0CnoTctvrVbHHKCWdXzhI95QiSH3lA6qRgSAg7RJb+0sCxeUDbBSDV04FYJ6beusx1z8AYrMoJDEu3xMyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/pR2fP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 481B6C43390;
	Mon,  8 Apr 2024 10:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712571026;
	bh=HPmoHWUkifmtc02r8Vvw4XPt6kaQ6hZkler7r/Mjbp8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r/pR2fP9SVEUQNZy/0kT8O9UotHgOeZwFNpQYphgf+gZe0AlW5PCocljht9epZ5zc
	 N4VSHoM2PDSV9Rcvd5ByabydxzAVagdm2VBvvMeUkqMiaiRlJMo+nCI0oQxWwNtClG
	 +sDVyS5fcJMqeJuTWZWc+4qZLjsSG/u8K9WzUtWFA3bNijfru79GaS5fuj6NTeqTgS
	 pbsqyE0BPBOgxZ8hEx7v82F+gjzDZCeJWTj9nYP6mxXaQY8lK8KM0eLe4wApl+0xZ2
	 4SCV3/Umx7tZuEoYJyjvJu2vuJW6jVcWh1Qkmqpk1DIeQ12tNYlO8sg9E5sXWBbYpf
	 GpqTCcuHyqQeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35912C54BD6;
	Mon,  8 Apr 2024 10:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] lib: checksum: hide unused expected_csum_ipv6_magic[]
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171257102621.30740.8793708790577049957.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 10:10:26 +0000
References: <20240404163702.241706-1-arnd@kernel.org>
In-Reply-To: <20240404163702.241706-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: netdev@vger.kernel.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
 palmer@rivosinc.com, kuba@kernel.org, akpm@linux-foundation.org,
 pabeni@redhat.com, charlie@rivosinc.com, goldstein.w.n@gmail.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  4 Apr 2024 18:36:45 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_NET is disabled, an extra warning shows up for this
> unused variable:
> 
> lib/checksum_kunit.c:218:18: error: 'expected_csum_ipv6_magic' defined but not used [-Werror=unused-const-variable=]
> 
> [...]

Here is the summary with links:
  - [v2] lib: checksum: hide unused expected_csum_ipv6_magic[]
    https://git.kernel.org/netdev/net/c/e9d47b7b3156

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



