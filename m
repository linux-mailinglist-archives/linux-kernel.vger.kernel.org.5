Return-Path: <linux-kernel+bounces-154368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DC78ADB4C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E942B23726
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87739125C0;
	Tue, 23 Apr 2024 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKeJML2k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E27322A;
	Tue, 23 Apr 2024 00:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713833591; cv=none; b=RV/gUoRB3m0wlo1cn8jCD/2Spf1jMR2m/KAZZKnqMLbYZqZlq4HFXED5Js+aLeOb6hLCF4EruLQKAIzbVbMuHw0XXdFpWlurpL4hP1rwVdDjeWd5wBmkjP/3kJJmXHs5Ry+IVRjUdYr7Lcc9/qVoeeM1dW+Fhe6Or2v5xX9Y88g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713833591; c=relaxed/simple;
	bh=LRUpSH5+qSQEKPv+C6482zv9PMbA+2tteYA9bEobWsI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nzBBUXbd4DErFlHTwySDqF5C8stCkQqOMtIU5qp/ZfoeiHZK3A+VUSFABVy7tQBVyuJLuVPrl0LR8hJqNHHdD/NKvg0Chk0e3+ecbJW9II4xXwHxOanPuzQH+GWYYMQ0hCFqCxh/KgtR1dFta4RnsC6xadV+wwX96TRvKBrnApE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKeJML2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60CA3C32782;
	Tue, 23 Apr 2024 00:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713833591;
	bh=LRUpSH5+qSQEKPv+C6482zv9PMbA+2tteYA9bEobWsI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QKeJML2kLFdRwFbQyUT88vDF7urP0elHRbl5BKzOUaa7s3jnfqyf3sQg5fWVkbVDL
	 IT6T33q6Tj16r8ei319KXGNDtNnlxSnCeYQfDIQffk0j5sFZk0yGBHwgmEoMQyqtMB
	 aNv+a2idtLCZ/M4M83GmoOpHIDgpwBmn6wrj8a/mhelqj0BXLWR/wOE+IeVVyTpViP
	 +VVFjG8UdwjIvVHwR4bD3+MhYNG0BC0WvpSYCzhi/6GyTyYYW3cKrIbYiO9SCzIH0p
	 ULy7BmmaKTwn6aYXp+1zxgUiKLWHy6USxCNqKFijgncE+t/C35HsUZmcWthQMQa+AK
	 4oMxRabDKmQNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50F35C433A2;
	Tue, 23 Apr 2024 00:53:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] NFC: trf7970a: disable all regulators on removal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171383359132.888.4974153862608179534.git-patchwork-notify@kernel.org>
Date: Tue, 23 Apr 2024 00:53:11 +0000
References: <DB7PR09MB26847A4EBF88D9EDFEB1DA0F950E2@DB7PR09MB2684.eurprd09.prod.outlook.com>
In-Reply-To: <DB7PR09MB26847A4EBF88D9EDFEB1DA0F950E2@DB7PR09MB2684.eurprd09.prod.outlook.com>
To: Paul Geurts <paul_geurts@live.nl>
Cc: mgreer@animalcreek.com, krzk@kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Apr 2024 21:25:38 +0200 you wrote:
> During module probe, regulator 'vin' and 'vdd-io' are used and enabled,
> but the vdd-io regulator overwrites the 'vin' regulator pointer. During
> remove, only the vdd-io is disabled, as the vin regulator pointer is not
> available anymore. When regulator_put() is called during resource
> cleanup a kernel warning is given, as the regulator is still enabled.
> 
> Store the two regulators in separate pointers and disable both the
> regulators on module remove.
> 
> [...]

Here is the summary with links:
  - [v2] NFC: trf7970a: disable all regulators on removal
    https://git.kernel.org/netdev/net/c/6bea4f03c6a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



