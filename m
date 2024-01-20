Return-Path: <linux-kernel+bounces-31709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8515B8332D9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 06:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD2F1F22E83
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 05:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C951C30;
	Sat, 20 Jan 2024 05:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/0wboCf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6165915C5;
	Sat, 20 Jan 2024 05:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705728628; cv=none; b=f3mCLyPFM5YFf2Qv0S5UThmuDTEDLSGqszfQDr0XsiYoVbNU6xueMkQN2SLHv4aeI7cAWiDn/TPMqRt1cG/Yo06+X8G+WTk2W9MwK4Nw093mMOGg99jag+DxiBmTNXtUy6lG+c8b3rOukuwqhz+ou5bZTfRoabm7b+dotMI6u9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705728628; c=relaxed/simple;
	bh=yu0MNUNr7CJjkYbwCDv+oNxh8exCAR7GD//KhDccK4M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JHyFouBYSS9abkDYcMPqJOXs3vWwDJcXyu7WmAbSa1vH8uINNvA6KHktUhJJ21nDvqtTIlq/WXWJ5zPvmIs3RXkTKBT6wsMyhxY4KJvslvt0+iagrjONnE9WKyXFdIXbd08SiMZeWRomsvUBl+MBwQ2Db6RuQXnKbg0QfER/XJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/0wboCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA3B4C43390;
	Sat, 20 Jan 2024 05:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705728627;
	bh=yu0MNUNr7CJjkYbwCDv+oNxh8exCAR7GD//KhDccK4M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l/0wboCfDDKC+IiD2rBZM4chDl9GSnXH7jPH+eNikgeKvVj02ocfYKGBN+JDehQwC
	 e5UXTDBst+aBAaZ6/3YrxjNaDU1AQygbyyLTRdTSO61x0dC8Mv/RmepnpWOER6tE0G
	 up924vYGZo0PV76fHETSf1U0dAguhs9rMf4AtntJkTOkWEQgESJUNdhCRJfBC81k0Y
	 ONXbrv0eJdfXerUTYn/TrH6mUS34z5mcHRRuTDMPMW5dE/MlaF0S85+O5Ua6LRVpJs
	 uxiulEnkUr8c/ABHbuO6wX6wIeGMjnNZ7Q5MC1Muo0JRTme4AR5f5O7diYfuo56BBO
	 wIiXL6LoSD0kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1D3AD8C96C;
	Sat, 20 Jan 2024 05:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] vlan: skip nested type that is not
 IFLA_VLAN_QOS_MAPPING
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170572862765.6535.650925230642049594.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 05:30:27 +0000
References: <20240118130306.1644001-1-linma@zju.edu.cn>
In-Reply-To: <20240118130306.1644001-1-linma@zju.edu.cn>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Jan 2024 21:03:06 +0800 you wrote:
> In the vlan_changelink function, a loop is used to parse the nested
> attributes IFLA_VLAN_EGRESS_QOS and IFLA_VLAN_INGRESS_QOS in order to
> obtain the struct ifla_vlan_qos_mapping. These two nested attributes are
> checked in the vlan_validate_qos_map function, which calls
> nla_validate_nested_deprecated with the vlan_map_policy.
> 
> However, this deprecated validator applies a LIBERAL strictness, allowing
> the presence of an attribute with the type IFLA_VLAN_QOS_UNSPEC.
> Consequently, the loop in vlan_changelink may parse an attribute of type
> IFLA_VLAN_QOS_UNSPEC and believe it carries a payload of
> struct ifla_vlan_qos_mapping, which is not necessarily true.
> 
> [...]

Here is the summary with links:
  - [net,v2] vlan: skip nested type that is not IFLA_VLAN_QOS_MAPPING
    https://git.kernel.org/netdev/net/c/6c21660fe221

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



