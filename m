Return-Path: <linux-kernel+bounces-111248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A27A8869AD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86E2284A2B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9205C224C7;
	Fri, 22 Mar 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAHfX5s6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D325513ADD;
	Fri, 22 Mar 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101028; cv=none; b=rozjgosnGhu4OXJnVYxjO8++3cfy1DwOsAm3SX3jKXOWlcTiV/kg1zVLgzI7doKOAbSNXa4R+3h7GpwK4exV6XEtCVfvc3MoWhYfyxzM63dja85bavww5AGrEUGABQ7VYIeqvwRrleHx5npLsbJHneeSkVlE5kDYW3OE4nPqNTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101028; c=relaxed/simple;
	bh=8NhJlCsJEn3+K8HPGyA7RWOSgZk2ki01G6VnRJsG2VY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cIePc8fJzKfuu0o2RImvpf97reuiG1qbHBCihR8Q3KugLoPfqoPWHzKHMxi5kbf18Y6thrvuO4ZLRcC1C9Sdd3qDPVOcUNb75nXnG6wsMiT+/W9eu1jy7QB1BB4fIsk3i+PTnHy3xXO2112FOyeFPYN+R0mRM99rf+fDBjI3zEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAHfX5s6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BACAC43390;
	Fri, 22 Mar 2024 09:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711101028;
	bh=8NhJlCsJEn3+K8HPGyA7RWOSgZk2ki01G6VnRJsG2VY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TAHfX5s6RABSgflwVs8L568zgFD7Eu0mv7I8vLQ4NfOZ8arI1CtY00B/+vygTC9xV
	 qnXAAWfjxCOQY7HsDDMkQtP0nP2QHjaXO/0k6RhHXUhCXn7MjKw/7bypn4DwkMIPcG
	 SOj7y8YV14/fnpWR+zhsKm3ZZKe9I5bwenpFXPLmyLThPDOKQJx2alOK7oVQphhCP7
	 wSlsg9z1eenQmNFm9lxijKpZLImAYIdRH+Xl/YPt84WKG8Zn4Pb6e59nyai8Bqy5lJ
	 z/0qjglCmM2U2nq3Sf/jcIw55N65i3FJQ3xNC+MAvGh7RVxrkudjQYIPT3pUARyEaS
	 5Mp5KYBiwzE+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 375E6D982E4;
	Fri, 22 Mar 2024 09:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] nfc: nci: Fix uninit-value in nci_dev_up and
 nci_ntf_packet
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171110102821.24590.15255416599958880632.git-patchwork-notify@kernel.org>
Date: Fri, 22 Mar 2024 09:50:28 +0000
References: <20240320005412.905060-1-ryasuoka@redhat.com>
In-Reply-To: <20240320005412.905060-1-ryasuoka@redhat.com>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: krzysztof.kozlowski@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jeremy@jcline.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, syoshida@redhat.com,
 syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com,
 syzbot+29b5ca705d2e0f4a44d2@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 20 Mar 2024 09:54:10 +0900 you wrote:
> syzbot reported the following uninit-value access issue [1][2]:
> 
> nci_rx_work() parses and processes received packet. When the payload
> length is zero, each message type handler reads uninitialized payload
> and KMSAN detects this issue. The receipt of a packet with a zero-size
> payload is considered unexpected, and therefore, such packets should be
> silently discarded.
> 
> [...]

Here is the summary with links:
  - [net,v2] nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet
    https://git.kernel.org/netdev/net/c/d24b03535e5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



