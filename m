Return-Path: <linux-kernel+bounces-162821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693718B60FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A95A1C21646
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71511292EB;
	Mon, 29 Apr 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdT1XKjP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3A9127E32;
	Mon, 29 Apr 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714414830; cv=none; b=G0dP5mb0JA0CEKckmx5ipM+eXGXCJgoVTuSq75+zpid5bqrvXxASmmQOJekA5NkYGnZgs0p8KTRN3LMHYpgPJT8Flew7qPqdawkKAEkOugqDNhjV0DBI3nwQA/l7vRlOmgQiYBw7ZuCFuvDvxWcvR/7iYzo+AL7DP89E8Cob/ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714414830; c=relaxed/simple;
	bh=EHzBYgcTZofTyZOXgV2/Ib0JRArpR6S3hfHZf6/BX18=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GImatGSIy31/wTFlFPVqNxbdvAyXom8qIxtlzeqdEE43c/bUpW9mdRDKA9EpXUv1x9CFQAfRAKTp5iybohllC4qj9B7k2NNj7jn4KXJL3CcUedOVW0CA69g49UfTu6Ij6KMWhBmCZodSfPcYK7UsFzhZQTwMlNcpV3LXeRxpYKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdT1XKjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55F6CC4AF14;
	Mon, 29 Apr 2024 18:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714414829;
	bh=EHzBYgcTZofTyZOXgV2/Ib0JRArpR6S3hfHZf6/BX18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mdT1XKjP38gwqsuh0kyVStYoOGq7Wfpxt+VilSBcbc+BkjwTse1jmZYXONQD3Dwo7
	 qd2swqqADGQSmFkuwU08Sp+6ToQZGudEDF/mDtWyPKGpAypgINwVarFAhxI3cuV3FO
	 BOgNKgMWMDVOp7ju7TQby7V5LeGCQxp+zHAGgZ2KzSqSll46vaDN0pXmYsY1AUVn97
	 t2mdiYlZEwDWeBB4Vv1+sQNz5+QoxLxdjTMgaH9XGd7QDD0Ufd7GlF6UHm/Uiv80XL
	 QpMjk3f0Z2w36WFe+kPX2a2Yqu1KsfX/hQrz4du5n1t7dejnhavjL0/onVDZvO7+Ek
	 CSViQgodpEa5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34FCAC54BAA;
	Mon, 29 Apr 2024 18:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2][next] Bluetooth: hci_conn: Use __counted_by() in struct
 hci_cp_le_big_create_sync and avoid -Wfamnae warning
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171441482921.19588.5976212947478581553.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 18:20:29 +0000
References: <ZivaHUQyDDK9fXEk@neat>
In-Reply-To: <ZivaHUQyDDK9fXEk@neat>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 26 Apr 2024 10:45:17 -0600 you wrote:
> Prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time
> via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> (for strcpy/memcpy-family functions).
> 
> Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
> getting ready to enable it globally.
> 
> [...]

Here is the summary with links:
  - [v2,next] Bluetooth: hci_conn: Use __counted_by() in struct hci_cp_le_big_create_sync and avoid -Wfamnae warning
    https://git.kernel.org/bluetooth/bluetooth-next/c/b4208ba1661e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



