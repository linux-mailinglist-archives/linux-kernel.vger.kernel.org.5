Return-Path: <linux-kernel+bounces-150533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0028B8AA0A4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05AF280CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2763176FBD;
	Thu, 18 Apr 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR9zXjhy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97F215B117;
	Thu, 18 Apr 2024 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459628; cv=none; b=HUGrn7yG9hhScB6neFkqNIb3Q7E7GCER4HoiQ8FKj+LjZceakEphALeGO3xdUNx5Z9v6lMGH9bSUNh26m/MwwZuvcLEWdbueHoI3btUM/S+zeg7wzMwvGVuHSOOQqNrPhmIfn0PaFLzxNUuPFSbq4dNLI0szVew0SUTUEZfYHyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459628; c=relaxed/simple;
	bh=M5490jcSE4ZyRqN3KFV7i3MTuPXtaiZf0isFGnyxHYg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M7Zsj/UoPH+PCeXA3y7Os5/dVP3c6OjgBmAvbcsu8SmjsimX7223Vf3DI6B+1r3ycXPE+YozNy6GUbGym0BLc5ZoC81mHnPxPypLUxtAew6aW9uUsoXlGuSxEqekPGeQJKF9ap4r6tVFVfKAiZZ7M+VwLBNBnxnNXtiobACujWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NR9zXjhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88478C32781;
	Thu, 18 Apr 2024 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713459627;
	bh=M5490jcSE4ZyRqN3KFV7i3MTuPXtaiZf0isFGnyxHYg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NR9zXjhyYKkRA+YPEgzvHCr1AEcRb3xUUcYxNKjEZrnYIeEvsmxJ1kPJIBS0hsyIJ
	 Ipm7BxHjyKsYzi2Cl+ql0RSFrb4aO+07WZ05lUE0bxA16pVgwMB+7vrRwW5032OwZc
	 YhTqm1u12voxV1CmLm+MG57hkGmX9iHVbqNfqkOYcS6gzvClqWG5gBmE/HGaOfQSZ0
	 ioOAFVaohvwj+EyYWLyWqXgRSw4cP0FRSpt2PYYb7B7dOUATV9fkI3XXWrancevwTS
	 3cFrDGUjgCUO/UuGZ8L1UFoBH+VBDPJ/AcSH91F3K1QGMunBnTQ7ktwfwtvfbwV4gu
	 NJ2k+Zqwz8YfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 707D3C43619;
	Thu, 18 Apr 2024 17:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac address
 before first reading
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171345962745.29083.15641493659556059187.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 17:00:27 +0000
References: <20240417085524.219532-1-jtornosm@redhat.com>
In-Reply-To: <20240417085524.219532-1-jtornosm@redhat.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 jarkko.palviainen@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Apr 2024 10:55:13 +0200 you wrote:
> After the commit d2689b6a86b9 ("net: usb: ax88179_178a: avoid two
> consecutive device resets"), reset operation, in which the default mac
> address from the device is read, is not executed from bind operation and
> the random address, that is pregenerated just in case, is direclty written
> the first time in the device, so the default one from the device is not
> even read. This writing is not dangerous because is volatile and the
> default mac address is not missed.
> 
> [...]

Here is the summary with links:
  - [v2] net: usb: ax88179_178a: avoid writing the mac address before first reading
    https://git.kernel.org/netdev/net/c/56f78615bcb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



