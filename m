Return-Path: <linux-kernel+bounces-5812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F045818FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90972871FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E045B38DFA;
	Tue, 19 Dec 2023 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZRyaGAP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAA038F91;
	Tue, 19 Dec 2023 18:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB91CC433CA;
	Tue, 19 Dec 2023 18:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703010537;
	bh=esDBL+hIyuOb+bPEniSWTDCbbECvcOvTasaq/Za7p7k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WZRyaGAPE8BKuEyuISxQK6U6QweRw3BodoWW2QZK2WvQy6+cZzfvP50FpoMVdy+k8
	 4PcIy+BLSKC8ukZiA+/MRDkQGvS6xsglxOXVta1lFbwpZcy6qhNEZ9n1nffpiIvabH
	 bHCxOqumuQMViYz96k7WwO9TpGlfSTnLyo3VyZOoMMOQjrc+Ct0h7Wzbz4fnm1rdbE
	 rZSMPwVtzDO45cd3B04Iy1kbKeENbIkZDfeQE/eg866gCJxLZYpRbdWpUGo0RI5tAY
	 aPzAlz1cUo1rAA62x0URYPziNSL1jXKBzkc7anuvLBF38+6z2UYmjN0pXXIl3+wGBF
	 tSfvJyEG3IVfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A30EEDD4EE8;
	Tue, 19 Dec 2023 18:28:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: fix BR/EDR wakeup bug
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170301053766.15177.5013098150567197438.git-patchwork-notify@kernel.org>
Date: Tue, 19 Dec 2023 18:28:57 +0000
References: <20231218102417.474022-1-15013537245@163.com>
In-Reply-To: <20231218102417.474022-1-15013537245@163.com>
To: None <15013537245@163.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhongjun.yu@quectel.com, clancy.shang@quectel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 18 Dec 2023 18:24:17 +0800 you wrote:
> From: clancy shang <clancy.shang@quectel.com>
> 
> when Bluetooth set the event mask and enter suspend, the controller
> has hci mode change event coming, it cause controller can not enter
> sleep mode. so it should to set the hci mode change event mask before
> enter suspend.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: fix BR/EDR wakeup bug
    https://git.kernel.org/bluetooth/bluetooth-next/c/1e961bd261a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



