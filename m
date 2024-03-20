Return-Path: <linux-kernel+bounces-109409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC608818C4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438231F22D40
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4952886128;
	Wed, 20 Mar 2024 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2SZ4abI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CC64F8B2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710967839; cv=none; b=KMB9QXzuz9con6iRHSJ/1mCScDYCXuQui8fk52KkLy/1+1srWVViVZSRv/BR1pQmuf28Ps+Ci3GTbgDMcEzSJFJlZaW7AG4wJcSN0B5IaOvOkzG97lnXZY5MfvsrogCVLXeAVfffpBZqLKsjW8mN0O5TO5YWXTQY5mLe5JjP5nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710967839; c=relaxed/simple;
	bh=EzEXn434C3owX412vSu+v4rWnWZ62rkj4t68PC+Dsko=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uZjKHxaefWg1L6I61E2ELCoOWzKYA9+6MIRFqwRZPn6Y2H6Enpv6J0zkElphnS8shCh3/rQF6kWrUu0piphZ1y1iqJ2ZvZpwato3eN1DZvVDh2W86hx5m5c8UCBUFZTKIPEHSVFNKc4sO+I2FXrJPl7v7dgLC+2uRzFvRtxopSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2SZ4abI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 363CBC43399;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710967839;
	bh=EzEXn434C3owX412vSu+v4rWnWZ62rkj4t68PC+Dsko=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p2SZ4abIHqa0sX56hiq9Oa4dlfTRGDjvfk8Y8fyToXrUFH6p70eIBYMXbv6BXfzJD
	 ma2JVua77H0tlR3uDlAg34AZYLeRJn1+Cw8WdB6LA0JpQW7evERiJwnV2rtpc/6rjx
	 uxbI6cJGRHKkHun9R3uzF/c3gbVDfOz6JFFu3S5AHHDjj7ZfAV7N49SBnurBkfxOVX
	 lvO2zh6x5QIcjYfxjBY98dWjAht4n6ACGf3efE6DYsH5rGKPn4eFvJx8Q9HmYrSFe7
	 ffLL983k/ZXiKYX41v8dhlDJyiB9/GamYg9e8kxBRGCg2MhFiaLKLyZMpBjrcz6TQ0
	 LeH0kSGFIls3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2569DD95060;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 0/4] riscv/barrier: tidying up barrier-related macro
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171096783915.6804.16329473999832420687.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 20:50:39 +0000
References: <20240217131206.3667544-1-ericchancf@google.com>
In-Reply-To: <20240217131206.3667544-1-ericchancf@google.com>
To: Eric Chan <ericchancf@google.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 conor.dooley@microchip.com, parri.andrea@gmail.com,
 emil.renner.berthing@canonical.com, samuel.holland@sifive.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat, 17 Feb 2024 13:12:06 +0000 you wrote:
> This series makes barrier-related macro more neat and clear.
> This is a follow-up to [0-3], change to multiple patches,
> for readability, create new message thread.
> 
> v5 -> v6: [PATCH 1/4] let this change to pass review by checkpatch.pl
> instead of overwriting again in [PATCH 4/4]. for [PATCH 4/4] change
> the error message example in commit message to make it more relevant
> 
> [...]

Here is the summary with links:
  - [v6,1/4] riscv/barrier: Define __{mb,rmb,wmb}
    https://git.kernel.org/riscv/c/89f4fd7b1ab7
  - [v6,2/4] riscv/barrier: Define RISCV_FULL_BARRIER
    https://git.kernel.org/riscv/c/b3c8064ccc44
  - [v6,3/4] riscv/barrier: Consolidate fence definitions
    https://git.kernel.org/riscv/c/c85688e2b0f0
  - [v6,4/4] riscv/barrier: Add missing space after ','
    https://git.kernel.org/riscv/c/9133e6e6908d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



