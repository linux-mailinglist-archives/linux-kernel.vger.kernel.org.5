Return-Path: <linux-kernel+bounces-133819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71F289A944
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 08:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4381C21082
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 06:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C25622EF3;
	Sat,  6 Apr 2024 06:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RR1MLUBz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E11F2901;
	Sat,  6 Apr 2024 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712383829; cv=none; b=SgaO2/m8ceuXE0wnsuyZeb1fgPPwztqt6UrmFAgvh/tsY5Ur+1O6ZMdx7IGcrvSjwdwKOPaXFv0XqRgx/GOQ2mUlro4YZa2mGncqfIXpLN3MzhOjkOmCxt3Olp/ylM6bdeQC7YWubsRyDWdrR1G5NJT+mAiDdSGE2JVnLo5ztok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712383829; c=relaxed/simple;
	bh=SLouAEBqxufPSWcJ18J5rq043683PdG8RqtIQAUaAmk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dD/5zmM1Ss+DPtvmKRQuYYHcpQEGSq+qM4cscxwL6HBW+STKmVfmWZ/QCPoL0dOV1Ip/EIlW0eyNutn4QUyWwNgQki6ad85cEb+m11VPLRegLbc8pDFM0Z9Bire+ufv3ZAYjpYrn9mr01KdC4zOgdc1RRIGcUzwd5K9zgMutmYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RR1MLUBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C556C43390;
	Sat,  6 Apr 2024 06:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712383829;
	bh=SLouAEBqxufPSWcJ18J5rq043683PdG8RqtIQAUaAmk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RR1MLUBzAHbughCy15n7QnOgi7txNtRt3gPQsK4+hkscuqP4ZNT0awEoEijqt5cVn
	 MsPuwXvrdWFd1A1WCcioeHiGwky5AZ2gV/7Qt0cUq7LMQuX+nQhV+18JWPHTdEDBpm
	 sWGFgWJ/Zo15Aj1M1WKl3sh2sCYzT+egfvWLG3HgvdQuesQHuSsaQtOA9ZIeTIBkeT
	 oKxNVRlii2leALJHeqJe5OdCxy0hfVCkiF9YKXlwXH+V+COIfTNb9VcQPsvpqsQCKl
	 wXhpVDDlbpLJjv4IA0/AET7UsVFj4tN/AeK42sIacAL3p9dNLgyQs6dweBB5Hc3eU0
	 Ag/wcLMUZ/V1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BC4ED84BAC;
	Sat,  6 Apr 2024 06:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: openvswitch: fix unwanted error log on timeout
 policy probing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171238382917.24936.12025392110286749451.git-patchwork-notify@kernel.org>
Date: Sat, 06 Apr 2024 06:10:29 +0000
References: <20240403203803.2137962-1-i.maximets@ovn.org>
In-Reply-To: <20240403203803.2137962-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, pshelar@ovn.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 yihung.wei@gmail.com, dev@openvswitch.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Apr 2024 22:38:01 +0200 you wrote:
> On startup, ovs-vswitchd probes different datapath features including
> support for timeout policies.  While probing, it tries to execute
> certain operations with OVS_PACKET_ATTR_PROBE or OVS_FLOW_ATTR_PROBE
> attributes set.  These attributes tell the openvswitch module to not
> log any errors when they occur as it is expected that some of the
> probes will fail.
> 
> [...]

Here is the summary with links:
  - [net] net: openvswitch: fix unwanted error log on timeout policy probing
    https://git.kernel.org/netdev/net/c/4539f91f2a80

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



