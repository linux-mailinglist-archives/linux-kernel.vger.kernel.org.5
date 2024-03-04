Return-Path: <linux-kernel+bounces-91309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AC2870D11
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E233628C725
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE867D09A;
	Mon,  4 Mar 2024 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKg6MDaw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27C47C086;
	Mon,  4 Mar 2024 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587827; cv=none; b=t6Kh+IPwpNCdJS8C3+sZhsn6BK3WiYbgBBO4fLamsnPAFHwyDmpc07lxieHnXdeyxMzdWVKeoslmoq7fZ3U+A2cIBn2qoD3rbDmlL4X1kiY7RNXm681J1Rt4MKHG0wn7Gwob9dLonz9r0ZNDmOA+nfV5T8rCnC32MfleQoAIxu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587827; c=relaxed/simple;
	bh=W27zYtNAsaurBFbAYeVJtWJ3xNO1se3Yby7vpbfIx2g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V7y3BN61Lhi2QcRzjd8GBoH5F3xbIHMPmSZUoRg3cZTMjmX1mBjhXPc0RQt90XLWjKDEgsYNax8TqjxHuVuDXnCff8S2VP400JBmovxp1K9DQdC51+Zy+dC2GDO6KsUXeqKLiGMWX350oonEG0ACcKF+ef+p1RW7p2XYjewL9hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKg6MDaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7155CC43330;
	Mon,  4 Mar 2024 21:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709587827;
	bh=W27zYtNAsaurBFbAYeVJtWJ3xNO1se3Yby7vpbfIx2g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GKg6MDaw9KQctlTOAoYPW0xR33Wh575vjxUKNmIWsFhx1XVxU+wJFaUwzjcA2XwyE
	 aqBeIWpeOYsUoagOetbysEWODn0JkZKaKfJbdKy9SJL2oa7kpN8rX1+IinMijUI1Q7
	 dlfibqPUP/IjYBH0yfqT8986zMlBjWYlSYroYg/MtvpOV6wb5Kk7zUaTQBzAZ9ZIu4
	 CRo9tqUSDAPLBSG++k/McODuy5qROJm4L33MTgk2fOJFvv5TezVMlzFEgj3yMW7Hws
	 plzCUH+9/MjpGSfFO48kAgLWFeQF8oDssavLAkunTvje1VjMFBvgiNatWjA0Yqn6WT
	 3gk8vCuVEC0dA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54421D9A4BB;
	Mon,  4 Mar 2024 21:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [PATCH] Bluetooth: btusb: Add support Mediatek MT7920
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170958782734.29902.13888163732970633114.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 21:30:27 +0000
References: <20240304144844.2042-1-peter.tsao@mediatek.com>
In-Reply-To: <20240304144844.2042-1-peter.tsao@mediatek.com>
To: Peter Tsao <peter.tsao@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, deren.Wu@mediatek.com, chris.lu@mediatek.com,
 aaron.hou@mediatek.com, steve.lee@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 4 Mar 2024 22:48:44 +0800 you wrote:
> This patch is added support Mediatek MT7920
> The firmware location of MT7920 will set to
> /lib/firmware/mediatek/
> 
> The information in /sys/kernel/debug/usb/devices about MT7920U
> Bluetooth device is listed as the below
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add support Mediatek MT7920
    https://git.kernel.org/bluetooth/bluetooth-next/c/2ea671b17896

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



