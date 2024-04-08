Return-Path: <linux-kernel+bounces-135967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1792589CE50
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF8C1F22239
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF00149E1F;
	Mon,  8 Apr 2024 22:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZpzjLU0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FC9146A74;
	Mon,  8 Apr 2024 22:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712614283; cv=none; b=Bxhki92fi/+RC8ptq8BJ/wmhYWav51w5IP5pU3SPDIkxa7oOK+Iisp/Ys6m7x1mmCcfUDoSEWgcM4IlUbgHa1Og6v3iFvxsccO6MbMziXzt1eCZEVFHuwPLdRxgTPEbbB80RI+JdwvbDzWyhH84KFkoGSv6mATbpuTWcczf+4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712614283; c=relaxed/simple;
	bh=lW11RI+KDUxz+R1JazYwSEvVHMXg9ftxGnF6AdTgkjo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T4G4iY9gqGcPRbB3n5uxFjEsgBJddVvOK8VyNpxVtOC7Jv0iP+CyTf7YZx+rlDXixUUkUiUPyXra11FbcuVAsz4pldHXQd0e61b0aSxg/9S0M6qWBzRTVbdQpPlwMqoRa2+FesDWB4yk/WCfhe9n0pEPiHw33JAgGYPVuFhDS2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZpzjLU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAAA2C433F1;
	Mon,  8 Apr 2024 22:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712614282;
	bh=lW11RI+KDUxz+R1JazYwSEvVHMXg9ftxGnF6AdTgkjo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oZpzjLU04UMqo3DHGNXPncnDOgiUKHS8aSf8pL34SWiBTw0MJJbQ5e4igv7PF8D69
	 biNOVVfC6nyaMXtDZoT9W+oyqE6kJVglUBhuVeECJBAxqoaUK5ue7I44nGof7+Ir1L
	 nH6WldASjQ/sFfzYbQWd5IWSGrDUo4EYAXcntX32hjJZCGmNYqu90RNKwIW+2Ykobb
	 myYl9PStsHQGp/NDFPwgRsmX4GhIJY5t36Z1T5tRQGpiG1yQ0OL/hbntQuPXR4K7t1
	 EukB9azhaYEvwnUDFEE+zhDqg6xJOCbmySeXle4+K91Zbm1rQF/kDYzDYpeqKIhpeV
	 VcvUp4CzpGppw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3B58C54BD6;
	Mon,  8 Apr 2024 22:11:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2][next] Bluetooth: L2CAP: Avoid
 -Wflex-array-member-not-at-end warnings
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171261428272.29448.1603633433425207397.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 22:11:22 +0000
References: <ZgRIF1bkXlZlaK22@neat>
In-Reply-To: <ZgRIF1bkXlZlaK22@neat>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 27 Mar 2024 10:23:51 -0600 you wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> There are currently a couple of objects (`req` and `rsp`), in a couple
> of structures, that contain flexible structures (`struct l2cap_ecred_conn_req`
> and `struct l2cap_ecred_conn_rsp`), for example:
> 
> [...]

Here is the summary with links:
  - [v2,next] Bluetooth: L2CAP: Avoid -Wflex-array-member-not-at-end warnings
    https://git.kernel.org/bluetooth/bluetooth-next/c/215c4704208b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



