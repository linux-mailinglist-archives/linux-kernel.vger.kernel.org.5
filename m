Return-Path: <linux-kernel+bounces-123961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E42A389105E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDB828AA21
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C42F1CAA4;
	Fri, 29 Mar 2024 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahj6Sh0x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1AA1755C;
	Fri, 29 Mar 2024 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711675833; cv=none; b=Y/hyJMUenWnTUTuX7+2RBuX2zHLgyXwiFE4gWjo01tO6Ht3xn9DFykpIDCIbCUD1jzJDCNw+/LTAoPPyP3vNsf9gtS9gd2Jzhw/RSfWq68k0JjG95Bk4XWco84M70tqXRnk36A9vdHrco0rzRYYss/sIrBkSOKFwFrsYdSnCv0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711675833; c=relaxed/simple;
	bh=eBjlW0K96wcTvRKhkZN5uyozDovWwaLiajHg/TN/CFw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cqlgbzRHGpA9KqGIFCpOWG+9+Ik+rBdJfOIJ7jIVIBZr41rV2KsO810GNiqfYIn9Lt8l458WvVZXVz80bAblZx8m66HqY4q3aUF/BhdWpce1qiDOCs+DZiZn50p08gpF8KY26skF24sCvs7BZPWB7WB2NebWNUVPuHojZfXGbEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahj6Sh0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AC31C433C7;
	Fri, 29 Mar 2024 01:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711675832;
	bh=eBjlW0K96wcTvRKhkZN5uyozDovWwaLiajHg/TN/CFw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ahj6Sh0xrl5V3WSegy5w1BIBmYGNv/8Y8g3LFyOnCFifm9f4SoU1VNFx6HWRpH0kB
	 kWg8ntItwy4hmEV5HakojPhvVAdOd6E3Kt6E4kJC9gmL+zwh4XVgJt2Fh3wYRfgXke
	 Xn7P3BnsizEw1yWwx5ya3gIDDLdJXtISism06l0rVHJp7cUKK0yMB5ByTMc++Ispjd
	 VQsbDJ+Al//9aqgVQd9nn69SYGO6jI9X3VwNL1HCcl+cHZusDebrM8VzNGqx6zGgh+
	 jfrsRyJ0R1AuRQfF3bYhItirPjv5HKs/8FgBH2GnecTVbBqrDttjkxVYZcevZgVRvo
	 dRrwZO4TIfvlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D768D95054;
	Fri, 29 Mar 2024 01:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ptp: MAINTAINERS: drop Jeff Sipek
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171167583250.32458.9139932821919314899.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 01:30:32 +0000
References: <20240327081413.306054-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240327081413.306054-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: akaher@vmware.com, amakhalov@vmware.com, pv-drivers@vmware.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Mar 2024 09:14:13 +0100 you wrote:
> Emails to Jeff Sipek bounce:
> 
>   Your message to jsipek@vmware.com couldn't be delivered.
>   Recipient is not authorized to accept external mail
>   Status code: 550 5.7.1_ETR
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [...]

Here is the summary with links:
  - ptp: MAINTAINERS: drop Jeff Sipek
    https://git.kernel.org/netdev/net/c/fa84513997e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



