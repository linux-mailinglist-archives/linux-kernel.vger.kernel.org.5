Return-Path: <linux-kernel+bounces-157065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 594BC8B0C60
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0C31F281A8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449BB15E802;
	Wed, 24 Apr 2024 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6URCNb9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8652A13DBB2;
	Wed, 24 Apr 2024 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968429; cv=none; b=h9Pk0k8Wzn5wqV04EW1ir1RWkeM7/2FF5YFPngIEHBORG34B7D8trNGNEdVHST3nhkXBW4vCvEhhMDqTmdR8MaQukt465y4TOlnGDPgJo4d2oBEu8Aeu25FXgpBeSM7eQvFGYxBtnUwEcGVKSotaedyMoiAbgAH/G+yPoNyC5uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968429; c=relaxed/simple;
	bh=zUvh5JMg5W5A98seb6x9t39N35QqYFAWXIiE9H/DkAY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WEefeXheHOFDlbtB/yNL/0ORZoNftVRmJUBXRBVbh+WUHfc8AuJQdQX4lelgJR/8Ag/nWvhEUq+UbjskXtFmV9tq+YGjqc/y9MdHhdSCj0eAB8DXKS/ETmDx+PEFwgDoNcMu8o58xjadBnBwKSQVxJa5LdGEO09Hrei85R2njWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6URCNb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45B7BC2BD10;
	Wed, 24 Apr 2024 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713968429;
	bh=zUvh5JMg5W5A98seb6x9t39N35QqYFAWXIiE9H/DkAY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K6URCNb9XdAk5tD81G0iqRuxZRpLk0sYkghdE0fWWQVonccimhXOTLtRvN6pLM9LP
	 3v60KZvYA3reuzfxsKnHDAwAFuUVJu92wx4YBxy5bOmLkHQTVME7U3CNR3lJdXKH3v
	 H52H4LDqu67h6iYz1TWusmTE9ysfElB/AdWTJk5R2rnkrsviGP01gwd4zgS2tVBCOK
	 JLPkrdzLd+Xm9Sj1Z1yfB5N7Jeb3sUVv54mkgsJK9sBOmsm2GCnr3WgoPGto63JGYi
	 +KPYXQY+xngxPhuzlgJVzVvUASCSfSUsmDf1G3KFQDfch7LCrujcK1/0NBvweC2cNv
	 vcKqaV+4g0OuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36EB0C595CE;
	Wed, 24 Apr 2024 14:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: Populate hci_set_hw_info for Intel and Realtek
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171396842922.29186.2152578622770434073.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 14:20:29 +0000
References: <20240422172027.v2.1.Ib96985e197f3db620a127a84aa20f3f3017aaf57@changeid>
In-Reply-To: <20240422172027.v2.1.Ib96985e197f3db620a127a84aa20f3f3017aaf57@changeid>
To: Archie Pusaka <apusaka@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 johan.hedberg@gmail.com, marcel@holtmann.org,
 chromeos-bluetooth-upstreaming@chromium.org, apusaka@chromium.org,
 abhishekpandit@google.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 22 Apr 2024 17:20:28 +0800 you wrote:
> From: Archie Pusaka <apusaka@chromium.org>
> 
> The hardware information surfaced via debugfs might be usable by the
> userspace to set some configuration knobs. This patch sets the hw_info
> for Intel and Realtek chipsets.
> 
> Below are some possible output of the hardware_info debugfs file.
> INTEL platform=55 variant=24
> RTL lmp_subver=34898 hci_rev=10 hci_ver=11 hci_bus=1
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: Populate hci_set_hw_info for Intel and Realtek
    https://git.kernel.org/bluetooth/bluetooth-next/c/46d8da86787b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



