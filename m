Return-Path: <linux-kernel+bounces-21298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B5D828D3F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FEE286218
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507C33D387;
	Tue,  9 Jan 2024 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaxuR2uH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D903C694;
	Tue,  9 Jan 2024 19:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27AF8C43390;
	Tue,  9 Jan 2024 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704828025;
	bh=t3QNkdfJLG6lYFIiv569+bzNw/2O3SyoMY/KgOsqdU8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uaxuR2uHKRM4tmJlizXx07h1RyuXLw8p1qI2OoNlb9kespMuLdh6Jpq8F5R08LfBe
	 1bn9oo3q5zyinKqsAxOLw9tsaEE3sbRkMtqfVJ65YlVQ13VtBtjNRWmEPhBhJrFMY5
	 09DRxOSqyI4DR0VyVTpna1rqFJo2DBxW+sTQs0osOUujxDf9mInr1E5x+UGGexTy2V
	 2Mo2frA3iALyp2Bik0GZgVGCHBZkKBpapUbLoUl4VcIYIBaIlH7+NFnPKL/xs9ja/E
	 ViF7R/SXGlJhiliiQ6e0vj/SMgnPmLEniPh4+6GuMsDUKdmnqTs+dt3JRMT67ssd5A
	 owLkk3iZ8tW+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09C89C4166F;
	Tue,  9 Jan 2024 19:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/4] Bluetooth: Improve retrying of connection attempts
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170482802503.21245.5004430777144462822.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jan 2024 19:20:25 +0000
References: <20240108224614.56900-1-verdre@v0yd.nl>
In-Reply-To: <20240108224614.56900-1-verdre@v0yd.nl>
To: =?utf-8?q?Jonas_Dre=C3=9Fler_=3Cverdre=40v0yd=2Enl=3E?=@codeaurora.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  8 Jan 2024 23:46:05 +0100 you wrote:
> Since commit 4c67bc74f016 ("[Bluetooth] Support concurrent connect
> requests"), the kernel supports trying to connect again in case the
> bluetooth card is busy and fails to connect.
> 
> The logic that should handle this became a bit spotty over time, and also
> cards these days appear to fail with more errors than just "Command
> Disallowed".
> 
> [...]

Here is the summary with links:
  - [v3,1/4] Bluetooth: Remove superfluous call to hci_conn_check_pending()
    https://git.kernel.org/bluetooth/bluetooth-next/c/a7ee39bea315
  - [v3,2/4] Bluetooth: hci_event: Use HCI error defines instead of magic values
    https://git.kernel.org/bluetooth/bluetooth-next/c/f8c47ee39e6d
  - [v3,3/4] Bluetooth: hci_conn: Only do ACL connections sequentially
    (no matching commit)
  - [v3,4/4] Bluetooth: Remove pending ACL connection attempts
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



