Return-Path: <linux-kernel+bounces-32913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4138361D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6E61F27B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D61C3D57A;
	Mon, 22 Jan 2024 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQyzjYa4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC823AC24;
	Mon, 22 Jan 2024 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922634; cv=none; b=sJZi+1eNJlfdURzSjym0hZuRIZY9SaQuqgEDjPs8oBwK5iWEpyxoYfQ0jyaYSKsVvLQdk3kSwV9oKjdcJNTU67giO9F34Var304/+OCsSHDhX9GiCVAIIVJAjkm+rSbN3HR7Bfh/NjVkMD6ga7Lr2Gw2JkWHeIAQiXilI9CjwwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922634; c=relaxed/simple;
	bh=9DqyAdSXj6UrH1kkwYm309Xg36Z8oG2OadQpiKIfrH4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QOw5iqsH+nE3sBUZcz6NJBHN1a0MeBzQ6CwKsxkiJbJB+9+0/qCSnICbZuL1t95BqnoTFYWZ4uq5pHEVPay9cutVkfIzmEN8SOCeCiWYAlxVpHPbCaLoLK8YcUxsO9gMN13l7xIwKUmbl3AmNhOvIEzBqvRCQX+TKw779bCmzFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQyzjYa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 257DBC43390;
	Mon, 22 Jan 2024 11:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705922634;
	bh=9DqyAdSXj6UrH1kkwYm309Xg36Z8oG2OadQpiKIfrH4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XQyzjYa4hDsvnXevPmfBJzHocdL62CkFQ8EVS9ef3U45SXj46WN6VR2Auf9wLdVph
	 Z/VZKek/29UIKUWoDXNH0vx8xyiotR1LikHvSwYDWPmg/rv+vDedHdqcuGgIHSVitK
	 Xl/VK09C8PHsjV7GmYSnoKysc3C74xsvxGq2/YFcgmo20LxrYR6FiyIFkdj9kg4s0y
	 OfsXDiZdlpq3Tt40jmRlnLDFGyOBhqA8uoXBw4sf9/MaN0rQ+vKZq2t3v7Yad/nHlF
	 dEClA7bAMCgdy++Tg8SGGatOhbS6ABnVP7M6jE6+npF2apSKEyeeHuQ290SFGK1+wK
	 gM8DLt5sOqmXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13C46D8C9A8;
	Mon, 22 Jan 2024 11:23:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6 0/4] dpll: fix unordered unbind/bind registerer issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170592263407.5359.16052163888086860774.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jan 2024 11:23:54 +0000
References: <20240119134304.576956-1-arkadiusz.kubalewski@intel.com>
In-Reply-To: <20240119134304.576956-1-arkadiusz.kubalewski@intel.com>
To: Kubalewski@codeaurora.org,
	Arkadiusz <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, jiri@resnulli.us,
 davem@davemloft.net, milena.olech@intel.com, linux-kernel@vger.kernel.org,
 pabeni@redhat.com, kuba@kernel.org, mschmidt@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 19 Jan 2024 14:43:00 +0100 you wrote:
> Fix issues when performing unordered unbind/bind of a kernel modules
> which are using a dpll device with DPLL_PIN_TYPE_MUX pins.
> Currently only serialized bind/unbind of such use case works, fix
> the issues and allow for unserialized kernel module bind order.
> 
> The issues are observed on the ice driver, i.e.,
> 
> [...]

Here is the summary with links:
  - [net,v6,1/4] dpll: fix broken error path in dpll_pin_alloc(..)
    https://git.kernel.org/netdev/net/c/b6a11a7fc4d6
  - [net,v6,2/4] dpll: fix pin dump crash for rebound module
    https://git.kernel.org/netdev/net/c/830ead5fb0c5
  - [net,v6,3/4] dpll: fix userspace availability of pins
    https://git.kernel.org/netdev/net/c/db2ec3c94667
  - [net,v6,4/4] dpll: fix register pin with unregistered parent pin
    https://git.kernel.org/netdev/net/c/7dc5b18ff71b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



