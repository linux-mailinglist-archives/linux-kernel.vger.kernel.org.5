Return-Path: <linux-kernel+bounces-134830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1E189B792
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BDBB1F21F3C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731A714294;
	Mon,  8 Apr 2024 06:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5rKsJ3Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B781610942;
	Mon,  8 Apr 2024 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557227; cv=none; b=eMkNtAOfwTpfN+jF3oZO86+c6jkIzymkN1M4w54omKBuquj6pzPGx8ru+NEqfU4ZtvnKRcTMWvws7aIq77JfPwEapn2t1SBzmPCxlaz/WnXN97Oig6PkjGmh0brGeEg93qM3JqWxMrhScf+pOh0nv/XVgssFX3OBRHnmoBSZ1ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557227; c=relaxed/simple;
	bh=ydEz4pvNadUncoDEpx5DkJX9bvAifXh1bPUwl29TKW0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=POSgeWexUFLR+jZ+Ix2XxIR4ZpvLHgfVcUpabuJpMgmr6813OxKloO/4pQ1kzrATydAf+WzN17lyQhCBtTio/izB3HiZLXuYU3ZB72erzCLHiwiX9ezINFqfQXSc/eWCq4yq3QBEnn1idS+GBe18As2CsD6JVDpfyd1ZZcpLrfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5rKsJ3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23E89C43399;
	Mon,  8 Apr 2024 06:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712557226;
	bh=ydEz4pvNadUncoDEpx5DkJX9bvAifXh1bPUwl29TKW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S5rKsJ3QZTLYYbUjJK8OHaOKN+H9lzl7guSBPWck+g3hlkfrq87SN191HcGIxWY8X
	 6HtuDCI5qMJsC6HAwMYDDppmND0L5KGx1HGAGLDbVjvKriiMD0LC4hQ/gOM4m2Xuix
	 fCofhz1SCA12iZjzgXN2+wLFCDFWCHYkJWoSWwnfHVKtZYNlkAHXk9equCO1+tjAML
	 9USK/Vj35ICR3zyYMZ5del2EewTFPqpWB7xHAuDLW0OMuPsoZKJG/83OVP+BOYi8M+
	 AaZeX9KpnUShf3KL9cMYvLU+1Z4eho7HksvJtB1Z1K/fprRcoo4zhUoAhIi51uFEdk
	 lxD7YHrJkPITw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19110D2D0FD;
	Mon,  8 Apr 2024 06:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] platform: Handle HAS_IOPORT dependencies
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171255722609.606.5030818566698111967.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 06:20:26 +0000
References: <20240405134151.5560-1-schnelle@linux.ibm.com>
In-Reply-To: <20240405134151.5560-1-schnelle@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: bleung@chromium.org, tzungbi@kernel.org, chrome-platform@lists.linux.dev,
 arnd@kernel.org, hca@linux.ibm.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Fri,  5 Apr 2024 15:41:50 +0200 you wrote:
> Hi Benson, Tzung-Bi,
> 
> This is a follow up in my ongoing effort of making inb()/outb() and
> similar I/O port accessors compile-time optional. Previously I sent this
> as a treewide series titled "treewide: Remove I/O port accessors for
> HAS_IOPORT=n" with the latest being its 5th version[0]. With a significant
> subset of patches merged I've changed over to per-subsystem series. These
> series are stand alone and should be merged via the relevant tree such
> that with all subsystems complete we can follow this up with the final
> patch that will make the I/O port accessors compile-time optional.
> 
> [...]

Here is the summary with links:
  - [1/1] platform: add HAS_IOPORT dependencies
    https://git.kernel.org/chrome-platform/c/3b89336c9ccf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



