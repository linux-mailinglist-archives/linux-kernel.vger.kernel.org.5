Return-Path: <linux-kernel+bounces-134829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7779C89B791
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7AA2827B3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECA0F9E6;
	Mon,  8 Apr 2024 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KN65rF1f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B641C3E;
	Mon,  8 Apr 2024 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557226; cv=none; b=aK4SN8bwG7KSE9l7uuoBpMpHaBf+v4rppAuk0D3zRfBEatGkAh6Vemvk0bbD7YTh9cJQ9qLB+2l2C3gRawIHlMgPckql4dV56f58WWOPfgrDDtdzgNJ8tHnmDXY34ti1g+WTS7YajbnLU/so2+Q2HXp8EQdyNTP3+LzAImFBKnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557226; c=relaxed/simple;
	bh=BeeYTLf5wFLpqYh+8yiJHCtgyzZdlshb4mu0aF5x7dg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KnN/AP2uyl/KI5Nb+GKldtn/mR7ZCh7yc5mhCDDwYlVN7otSss/OnNs6JLJiMQfRgx1VZ2zuFQHUajVBVCeTBDl0HE9AH62h2kOGCMvqpFaW2cyq68Sx4DQ7MomF1gUJ09vODiaBfgolvR/J9VJXNo1huJuG4eHk+vtrdjwDjho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KN65rF1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2522C433C7;
	Mon,  8 Apr 2024 06:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712557226;
	bh=BeeYTLf5wFLpqYh+8yiJHCtgyzZdlshb4mu0aF5x7dg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KN65rF1ftf3clzoddmDvvthkw4itsWlKuPTSL9hq257lvB/60G19rQrAzfw8I4YxZ
	 IWfjLpTWmiQ6/tf4iP8tEIa0kQJ/XX2C+/VVBsdYqlweDEaqTIMrYp3PDcX4S6oENH
	 HzDRB+TbqKI1HpnxqKYZ38c2t5eU2twDD9x2zg3Uxyoj7rlYzbaaKPothD7TE9QTPZ
	 y9GzPQHU7uNq0SumZHWnwlwJu5YIUIf6cblDWiojWSewaChEgtpI0e2aTwKLuI6/00
	 RgmyC6m2+clsHS8oWo2n/AFHut375d1FL1t5IBGQTQ4FJTNv3G5gpuKT9m7ggdX+SJ
	 9nQ3NYX0oCIFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E31BCD7982C;
	Mon,  8 Apr 2024 06:20:25 +0000 (UTC)
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
 <171255722592.606.18199441888717456715.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 06:20:25 +0000
References: <20240405134151.5560-1-schnelle@linux.ibm.com>
In-Reply-To: <20240405134151.5560-1-schnelle@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: bleung@chromium.org, tzungbi@kernel.org, chrome-platform@lists.linux.dev,
 arnd@kernel.org, hca@linux.ibm.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
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



