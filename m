Return-Path: <linux-kernel+bounces-13880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F96821420
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 15:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBEF21C20AB9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FAE6AC0;
	Mon,  1 Jan 2024 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnsUsB2R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F013A46A2;
	Mon,  1 Jan 2024 14:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 434E5C433C7;
	Mon,  1 Jan 2024 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704120624;
	bh=sMHSpifdInmPi4iD65LAeTh1jLi0FspVM/9ti5byvGI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YnsUsB2R2ooT2B9cFSiSulL4y1IkhgRSiBeRqLbbSvI7Qvq+0J/9xin6z4ZyGUJnm
	 bE9phFQRJMyAQjzvQCTYpvyApbYRpu0TuT6mzVQhaNBHk/uzxzzHghYWxRZ3pZ+2Ge
	 wfdxU62JxpyZwVEHk43C+cT0iDjpE4DA7AQTJJzrOi3ankzvUZCMt8zz4xuhje6ze8
	 AfdiDQzpFr6wWhRGzj3iAM+ZZo9jSp7sdfspIMB9sANvckPwPr+/tH3KFGzgRg/Iue
	 n76nTuWlozkFO5w+xvy1Ivgp2jO6YHCy63ApVtGD5WrWTKQg/jDwrHrnx/gy3s4Sh/
	 vCeJ3uATFOJBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28EAAC4314C;
	Mon,  1 Jan 2024 14:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] r8169: Fix PCI error on system resume
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170412062416.26004.12010057503783659969.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jan 2024 14:50:24 +0000
References: <20231222043410.464730-1-kai.heng.feng@canonical.com>
In-Reply-To: <20231222043410.464730-1-kai.heng.feng@canonical.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 22 Dec 2023 12:34:09 +0800 you wrote:
> Some r8168 NICs stop working upon system resume:
> 
> [  688.051096] r8169 0000:02:00.1 enp2s0f1: rtl_ep_ocp_read_cond == 0 (loop: 10, delay: 10000).
> [  688.175131] r8169 0000:02:00.1 enp2s0f1: Link is Down
> ...
> [  691.534611] r8169 0000:02:00.1 enp2s0f1: PCI error (cmd = 0x0407, status_errs = 0x0000)
> 
> [...]

Here is the summary with links:
  - [net,v3] r8169: Fix PCI error on system resume
    https://git.kernel.org/netdev/net/c/9c476269bff2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



