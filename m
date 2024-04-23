Return-Path: <linux-kernel+bounces-154371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF248ADB55
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FDFCB217CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED2C1B952;
	Tue, 23 Apr 2024 00:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIaaRP9H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4C4168DE;
	Tue, 23 Apr 2024 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713833593; cv=none; b=hPQAj7P7KQjic9Oz6dDuqMIQ1WOoDawUoMSINqv/Y7K0G5s+/PUKQVso/bJ2h3Eir7b9L0maqSyYOOZUqMQ/EfCrB7PhYnxkqMY5tgRPWkt93Bwo0TMXCFhgAZonxBVu3N66+GbHT5NpnPTvaOj23TDLvkeeKvqcWiY/E8S9Vv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713833593; c=relaxed/simple;
	bh=xWS6VLbXGvTJ+DEx3HDhGwjoNvVDSG3ZEhuApHLVq+8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FL43lv3tysG9iTCDAxvADgH8Zd4k/WRJVFDebC4wbAtENoUUBIW4FJwsO2QSxY6LUO+7jLFO7sVYLjD90fnRpKN8EOED+f9xof8BY37G0oGRr+ela1AkE+b2BCvyaPTGIJBKOjhsxeOjGy/uGoGqx2oglWVnu85xxfDV40Mn6/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIaaRP9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49AFAC4AF0A;
	Tue, 23 Apr 2024 00:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713833593;
	bh=xWS6VLbXGvTJ+DEx3HDhGwjoNvVDSG3ZEhuApHLVq+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PIaaRP9HrGpobLWMhfWo3r2fMaLdtCKInBveFgA2zgcK2pKY0sVsVHZofpXA/vlhx
	 /U9ycI0620v376U2dNQxB3qhc5Vr/jDRUHULaDfs2Xkw1PAEq5OWRHK+gs0aDvD1pG
	 iLkmahqyggVMAzKDJQrwKNz/fdxyRRk78eDNgrirhxW48PyNfa+TY4T/fvy+qDyX22
	 dIZstbXCo0R7fuYn1cWOfOw01o4dH4DMQ1vxB1N3UhozhjmTgb7vW9K4ljsO+y1guZ
	 9Dnu1/I2XWwHCF0MZ8ziyeB1xfH4h0beGCrtYKyPzQAleXOUsqamj2ZQWMOtEZiRMh
	 vRf9F2eVrQEfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40E0EC43440;
	Tue, 23 Apr 2024 00:53:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: openvswitch: Check vport netdev name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171383359326.888.13888365366178686900.git-patchwork-notify@kernel.org>
Date: Tue, 23 Apr 2024 00:53:13 +0000
References: <20240419061425.132723-1-jun.gu@easystack.cn>
In-Reply-To: <20240419061425.132723-1-jun.gu@easystack.cn>
To: Jun Gu <jun.gu@easystack.cn>
Cc: kuba@kernel.org, dev@openvswitch.org, echaudro@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Apr 2024 14:14:25 +0800 you wrote:
> Ensure that the provided netdev name is not one of its aliases to
> prevent unnecessary creation and destruction of the vport by
> ovs-vswitchd.
> 
> Signed-off-by: Jun Gu <jun.gu@easystack.cn>
> Acked-by: Eelco Chaudron <echaudro@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: openvswitch: Check vport netdev name
    https://git.kernel.org/netdev/net-next/c/2540088b836f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



