Return-Path: <linux-kernel+bounces-138711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989AF89F943
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314F91F2E0E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F15161314;
	Wed, 10 Apr 2024 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8a7kQ77"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B42A160885
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757630; cv=none; b=byJLhE2JDYNOQvw73F9RHn7j9L95p+hTKGIC/6WpzoHats7/9Cus4JFBSX1cExHKFMy9pe/yKxIRYOQLw6OBtUJ5gHMfGe2/Cr45NlPHj7x8O4Ge3dWnmiVnssx0+PVcD0Q4g7jNtsfFc+uAKLA1QsQRrZNeZXYVwk0ljUb93O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757630; c=relaxed/simple;
	bh=Ja6AZniRSqEA6oBU1zr4PBdhcx8DSrD4UWpOIIKlY4o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zc6IZTQ08WEOsOAJ9qRbH3iIZTbZn3uYt+BRLxedvAc3b8fEmHmRMXeJRAnHXh7FOoKxulWjppFU2EQihosTVIRu5YrG7TOrouNLmNrrmTvRhDhu+2bBN1MrZyC4lSY0kVHj/FN8H0IAvn8Z4NXlTUfMc4ZpAxnDVYNbn7izCdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8a7kQ77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0682C433C7;
	Wed, 10 Apr 2024 14:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712757630;
	bh=Ja6AZniRSqEA6oBU1zr4PBdhcx8DSrD4UWpOIIKlY4o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B8a7kQ77dT7VsPRjXN8owihdda6AzTWc8w+PYqwj0i1FSbZi1V+vvACaoUTn3lhgI
	 AWa+9VpZosKE+Wo2jGRVolWEXxdqs97ET23jWYIEaq41arE2j+eh2LrVwBgRt+TJm2
	 AQpbbb4XaLwOFeJepGK6vpMdhhNa82+yydX6VE1zK3WntU3L6u312M5EaXkoS1CTZ5
	 6yDZPpOA6rauqck3QhVMEtvkKidQ9PWk6yZLiI+uMjpqQDP9rWhfLrroq6RVLJwd/f
	 UMIDbdJvCkTzHMXmNY6/G4kSMa0aA1ySwHlTSkIfdLHdNP+EYcS/0CJgKZcmbDrONm
	 C6JZbnipGYLwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE715D60310;
	Wed, 10 Apr 2024 14:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] riscv: 64-bit NOMMU fixes and enhancements
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171275762990.4679.14858564193959592140.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 14:00:29 +0000
References: <20240227003630.3634533-1-samuel.holland@sifive.com>
In-Reply-To: <20240227003630.3634533-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 26 Feb 2024 16:34:45 -0800 you wrote:
> This series aims to improve support for NOMMU, specifically by making it
> easier to test NOMMU kernels in QEMU and on various widely-available
> hardware (errata permitting). After all, everything supports Svbare...
> 
> After applying this series, a NOMMU kernel based on defconfig (changing
> only the three options below*) boots to userspace on QEMU when passed as
> -kernel.
> 
> [...]

Here is the summary with links:
  - [1/4] riscv: Fix TASK_SIZE on 64-bit NOMMU
    https://git.kernel.org/riscv/c/6065e736f82c
  - [2/4] riscv: Fix loading 64-bit NOMMU kernels past the start of RAM
    https://git.kernel.org/riscv/c/aea702dde7e9
  - [3/4] riscv: Remove MMU dependency from Zbb and Zicboz
    (no matching commit)
  - [4/4] riscv: Allow NOMMU kernels to run in S-mode
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



