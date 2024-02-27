Return-Path: <linux-kernel+bounces-82641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C65C86878D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB444285EB5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7C21EB31;
	Tue, 27 Feb 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKPoEhLM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225E41B27D;
	Tue, 27 Feb 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709003429; cv=none; b=SfdJ4DlgTTOXuypathR7tds74jFk/2EGSxuTEbCxZT3WQHAs3O7Vd2hfNP1+0gRv3qK7wL8F1Un18pwM+JfT1/qubOPvM4Jjd0CqMr9ITdpKQpRXBCrvXgwv+K035KL2AFCbuJnFXTpfwmtywSIn3h6eR4ElJpiUqkdSDpy84fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709003429; c=relaxed/simple;
	bh=BL//BWSR9QpqKlOillPpkFg2dpt0O10QSIIIi8UoD0c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qlG9i/1mM5adqXaouqxoCYFVwdW+a3s4SUl0uD754xvCAxDcyQ0goBy8V44CI2HoJZ296H7RaalxWedWxAsKthOeVQ6HilGDyQ8Cx4mdnR+sNUYtQGoSfcI1u35gzhZzp5k2tL/Fat2+Hg94vMEKHIoy0SGoB6K+hSDAAOPiwts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKPoEhLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5BB5C43399;
	Tue, 27 Feb 2024 03:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709003428;
	bh=BL//BWSR9QpqKlOillPpkFg2dpt0O10QSIIIi8UoD0c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vKPoEhLMu/bq0cR6kbDOVZsVy5kgvOR5R41BJlgVIeH9UwFsbJTJwzX66gS0sV5bB
	 5E1sV7/kOmlifDpuJl3H2dkTtsaKE+xARieYPYuz7t/9nZM/lvcBIdsw7LavhaiEMc
	 rYuhJMEJuwnjICESfwBERHVcE62lZ7gIpM+3dln20u9SKBQ17B5uZoTaLVPtfHeisJ
	 +1RmPC4Qbc4APpIF0B7Gj1KhY16e/tzNQue6/viC+6ohIZbdzMX4UErM/XCl0kf8g/
	 gOn5nhb2X/0BYnFsXQvIgNFg8z2WuiIgkrD/JnMW9DSiHNTGO3xV/3kvdyL79XNfhO
	 +6uUCZyXgkPLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A22FEC39562;
	Tue, 27 Feb 2024 03:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 1/1] lan78xx: enable auto speed configuration for
 LAN7850 if no EEPROM is detected
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170900342865.19917.10348271747533192626.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 03:10:28 +0000
References: <20240222123839.2816561-1-o.rempel@pengutronix.de>
In-Reply-To: <20240222123839.2816561-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, woojung.huh@microchip.com, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Feb 2024 13:38:38 +0100 you wrote:
> Same as LAN7800, LAN7850 can be used without EEPROM. If EEPROM is not
> present or not flashed, LAN7850 will fail to sync the speed detected by the PHY
> with the MAC. In case link speed is 100Mbit, it will accidentally work,
> otherwise no data can be transferred.
> 
> Better way would be to implement link_up callback, or set auto speed
> configuration unconditionally. But this changes would be more intrusive.
> So, for now, set it only if no EEPROM is found.
> 
> [...]

Here is the summary with links:
  - [net,v1,1/1] lan78xx: enable auto speed configuration for LAN7850 if no EEPROM is detected
    https://git.kernel.org/netdev/net/c/0e67899abfbf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



