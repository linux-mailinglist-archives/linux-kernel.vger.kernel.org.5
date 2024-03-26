Return-Path: <linux-kernel+bounces-119985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4542188CFBA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79D8328E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDAE13D624;
	Tue, 26 Mar 2024 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3seXFDp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCED512AAF6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711487429; cv=none; b=rg+94xAKdJT6wMyMaZn19J5ECGPIVvcSCaow75ijN5+CIemyRYgZaMCMd+/6+M8P2Kah0HdwCFLZDYe8iGYJ/WkXKm4NxJWrl+XnxUOfv4W/4NoGqQpnBKcry/VO4mV3EdhbQSZkAxptatnSbeV9kPLJI/Vh1TJZeYuPkJIiz4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711487429; c=relaxed/simple;
	bh=8saIACrfy8QISx9H5ksI6D7YCNwsbcZUSnWbjaAtbqM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lxbs17DB8OBcR5udz5ySfB3b72w89OAbkgPu/IBxtqMnDDBhC6fkyW7f2+CADZC/UEdTE8kSvcLPNdMlirK9iCPu2s40G2jrZmmnsMkyAeszYy8fKi5mMwVhwCBJt2lbx79AYhC6iYTzu9nGW8fR6bpNS4GwcbMO2mgAoNnkMko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3seXFDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7369AC43390;
	Tue, 26 Mar 2024 21:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711487429;
	bh=8saIACrfy8QISx9H5ksI6D7YCNwsbcZUSnWbjaAtbqM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M3seXFDpvNLKmEGfVcZqvJDXhGH0EYOKu6uBnUfgsCq8ev+H/YxRQ++NfDtioFlaL
	 BPOMPhMeOYOCh4joZfb3mKZRVcCM1qIVhskBmd2IQJq2Vuddwn/szMYPz86bSgU75b
	 c64R9NaTUy/5DVx16cCAaaFRMjo6WVLrvz4xGu4kJpQJCT+muyExdCMLcwTE+o3RxM
	 frj6Y3OB3Q7PM53mTFU5gesfMfHE9eIk4TRC4BbQIz4t7cSnj4Ij+cgq/Tkge8x0QR
	 A+B5Asbm2mcJkWEBqzT94yq6XWFh3dObj3+Vp/3oYAMW/T+oekYZ9fYFOJPNzf9H7f
	 1LYM2C2LYFeVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63A58D95063;
	Tue, 26 Mar 2024 21:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: hwprobe: do not produce frtace relocation
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171148742940.11448.3731153346859499014.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 21:10:29 +0000
References: <20240313085843.17661-1-vladimir.isaev@syntacore.com>
In-Reply-To: <20240313085843.17661-1-vladimir.isaev@syntacore.com>
To: Vladimir Isaev <vladimir.isaev@syntacore.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, catalin.marinas@arm.com,
 evan@rivosinc.com, nicolas@fjasle.eu, tglx@linutronix.de,
 samitolvanen@google.com, masahiroy@kernel.org, maskray@google.com,
 linux-kernel@vger.kernel.org, guoren@kernel.org, roman.artemev@syntacore.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 13 Mar 2024 10:35:46 +0300 you wrote:
> Such relocation causes crash of android linker similar to one
> described in commit e05d57dcb8c7
> ("riscv: Fixup __vdso_gettimeofday broke dynamic ftrace").
> 
> Looks like this relocation is added by CONFIG_DYNAMIC_FTRACE which is
> disabled in the default android kernel.
> 
> [...]

Here is the summary with links:
  - riscv: hwprobe: do not produce frtace relocation
    https://git.kernel.org/riscv/c/ad14f7ca9f0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



