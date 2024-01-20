Return-Path: <linux-kernel+bounces-31912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B381183364B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195C52824F8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3791328694;
	Sat, 20 Jan 2024 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkVsrhLG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614E21798D;
	Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705784999; cv=none; b=Pk5DlLGLgN3XpePZ8kkc7dxzg2gkm0x4thujEBpHynXOau9ZDpuMnDey49Tm8viP+HJ9joQKV6vNAW1HK7i1GDZ5VDO0Vuted+pOLAZ7lmkGdVYX0XQFUnxRSFra4PC3nQQvN1hOYzYZDvsn6l9J5J8oT5YLUWkcCrfNvW7/r4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705784999; c=relaxed/simple;
	bh=Ak11chN7WclRj25UANXp4k7/EzZxe8YnZ7/DdCdJ/Eo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RZYO1k1oX9HGyUH9l6DJnupgImxSCm6c6ZsHuff6BvGGxFNHfa4O759TwVrqp+dpekbEYXp0o8dvmqJR3BnjrPY+DURN708Rc+cYosqJP+5g83kAza9rsmpwMBGYNXzqc4cYua/wjERLM86COmvd5aMeFNqAajnmB8qDhAyYhwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkVsrhLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16022C43399;
	Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784999;
	bh=Ak11chN7WclRj25UANXp4k7/EzZxe8YnZ7/DdCdJ/Eo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IkVsrhLG/8fIWEIS1jEMWek7Zvt5oHhH4iIiHcFrYKDuct84cFWNZbyPVw7aE5USn
	 EdxvcG4HNDlt83k333dnvaOcO2tidVEdbhq0CJFxJ93Prs3gEH/p58Qy+GRyl8MbIG
	 meRvcghCnLWoHc45/tNBHxbTKecNuou/KLSqasbtSvlo31zpH/vwXMEceiLwTJ5m7a
	 YjChVCAqCod2OXw7UwGW23JceU1AUwebt/FMs3NKZ8hUGwmQQ5/Zq5DoX5UetCZ7iJ
	 PdCbAB2zls/W0Ay7Xq8My+r1A2H2Yz4w3lrzw3EiKKtObnuVW7ravh/Ls8/tlKFzw/
	 65jpJECS34fYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0468BD8C96C;
	Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/7] kexec_file: print out debugging message if required
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170578499901.24348.12653685452300606867.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:59 +0000
References: <20231213055747.61826-1-bhe@redhat.com>
In-Reply-To: <20231213055747.61826-1-bhe@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-parisc@vger.kernel.org, akpm@linux-foundation.org, joe@perches.com,
 nathan@kernel.org, conor@kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Wed, 13 Dec 2023 13:57:40 +0800 you wrote:
> Currently, specifying '-d' on kexec command will print a lot of debugging
> informationabout kexec/kdump loading with kexec_load interface.
> 
> However, kexec_file_load prints nothing even though '-d' is specified.
> It's very inconvenient to debug or analyze the kexec/kdump loading when
> something wrong happened with kexec/kdump itself or develper want to
> check the kexec/kdump loading.
> 
> [...]

Here is the summary with links:
  - [v4,1/7] kexec_file: add kexec_file flag to control debug printing
    (no matching commit)
  - [v4,2/7] kexec_file: print out debugging message if required
    (no matching commit)
  - [v4,3/7] kexec_file, x86: print out debugging message if required
    (no matching commit)
  - [v4,4/7] kexec_file, arm64: print out debugging message if required
    (no matching commit)
  - [v4,5/7] kexec_file, ricv: print out debugging message if required
    https://git.kernel.org/riscv/c/eb7622d908a0
  - [v4,6/7] kexec_file, power: print out debugging message if required
    (no matching commit)
  - [v4,7/7] kexec_file, parisc: print out debugging message if required
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



