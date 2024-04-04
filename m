Return-Path: <linux-kernel+bounces-131817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE42C898C1F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C5A1C22501
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605011C6A0;
	Thu,  4 Apr 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hsmwht34"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9B414A8B;
	Thu,  4 Apr 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248229; cv=none; b=a5qglwOQ13IpwVip+RwrBZsAFOM4+6+57x2nhu6yoD0Ogij8U72lCN+b9nl0TpMiBfjmAvBuDIN6IHkR4lFNYAkvQSTdt19y0plw5xHYhzfbHQxiXXCNR1Sc+xd4ns5ceM+HQlmlsEMeiYIA8ueAYNXNGTTLQMXl8a4d5gY3uAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248229; c=relaxed/simple;
	bh=BVhTXashEG57puklFol7XbJe6FSrSBczHcdEuLpp3iM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kenqLgu8L5rWmlFpMzRMZizmwCUnRZ5/G9Rzz8cUq+OmTPIMDJBxRKBiZ8Q3PNPwfqi5kQikcxOK7uGh/fh7+i4oTSyI/WR1xc4Kgb6OYE+j2JS/fMJ/CyT8RHBqig+On8TOmhS8H4QhT7WT8cuJk+Oc2ARgM+GUZXNEq92QhMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hsmwht34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A7D3C433C7;
	Thu,  4 Apr 2024 16:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712248229;
	bh=BVhTXashEG57puklFol7XbJe6FSrSBczHcdEuLpp3iM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hsmwht34uUDEQzhRK1cgphbEHpX7XgDjagInAX5Z07E/FXvdJJlgs/io39DrxhGV4
	 Zd9cX0LlYZvGqiwYlnEsZPSxqIJuf7AT+oc6InsYFND5GdUrA03GTiYqcYyl5nCQLI
	 oK6tzVYPv78eGi1Jxq2YKeYc9gHKQidM8SAl8+6GsSfARSPlXjMpZ1b0nVHITF+H3T
	 jeUog2UP1LBu5NwMqVjZ//s+5SlV/JLsFEsE6pwgLu4386rtUrnycFNcpf6ab87Oh3
	 UOk2kIF1UczAjiu3oBmZx9rujaLisLMoi3yyOvuGUZ933J+SNfvy3M1G6/zb1haum3
	 C6PVsqFLvDnNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 352BBD84BAC;
	Thu,  4 Apr 2024 16:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: l2cap: Don't double set the
 HCI_CONN_MGMT_CONNECTED
 bit
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171224822921.32019.3904901733305096930.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 16:30:29 +0000
References: <20240404185022.1.Ic27505c8f1ca7d4a653b1dcc1b08cdfc862a4622@changeid>
In-Reply-To: <20240404185022.1.Ic27505c8f1ca7d4a653b1dcc1b08cdfc862a4622@changeid>
To: Archie Pusaka <apusaka@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 johan.hedberg@gmail.com, marcel@holtmann.org,
 chromeos-bluetooth-upstreaming@chromium.org, apusaka@chromium.org,
 mmandlik@chromium.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  4 Apr 2024 18:50:23 +0800 you wrote:
> From: Archie Pusaka <apusaka@chromium.org>
> 
> The bit is set and tested inside mgmt_device_connected(), therefore we
> must not set it just outside the function.
> 
> Fixes: eeda1bf97bb5 ("Bluetooth: hci_event: Fix not indicating new connection for BIG Sync")
> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
> 
> [...]

Here is the summary with links:
  - Bluetooth: l2cap: Don't double set the HCI_CONN_MGMT_CONNECTED bit
    https://git.kernel.org/bluetooth/bluetooth-next/c/d6126dfaf91e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



