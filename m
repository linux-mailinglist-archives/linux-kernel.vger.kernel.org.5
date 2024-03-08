Return-Path: <linux-kernel+bounces-97648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDF7876D17
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E780C1F21CF0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06DC604C1;
	Fri,  8 Mar 2024 22:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M04k5eqF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB9E604AE;
	Fri,  8 Mar 2024 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709936901; cv=none; b=K5LUHGP4CBSEW4uWcTSvuQ4uXMM2s8/RnJBS4Ltlw5P9z8mC9U1CIfjgOQAEqJsxbWF2WIkAppQjdQ4I/Hvat0d9XY81rXfPs1iXZSGoSUmZv2jbTu/KZF0YrFWPQA1IxUtQIYE4oqvLc/xMaAAUMRMNocIT98hkeEQfV5piVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709936901; c=relaxed/simple;
	bh=f+aA1pXh0Fecuf0nO1G0I+WuUBCGnya/AIRsrq2HsvY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SHGBLHOwuh+w+zYoZ4aj/B3GU/HlOo/aeoaaxIZUxMKexn64aMWsUArrtsHqoVgGVF9WbV8QkaKbxkHpgTZFavG23IG60h3bvnWHwSFt+YaJ5jXSvQ9OEQDoGE2t4/ZziDHZimY5QTZuWJHrLRVKkP+KTZPxkdfYylkDTGnt4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M04k5eqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C65CFC433F1;
	Fri,  8 Mar 2024 22:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709936900;
	bh=f+aA1pXh0Fecuf0nO1G0I+WuUBCGnya/AIRsrq2HsvY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=M04k5eqFCdbc4nGsAz17gkp+c4I76Xr4+hR8aeLkEzDDmDk4qROdvfJhnoVw4xtAq
	 Y+qyPgLaWKodoCjeV1BwdPW1y/7sYcghNfKJmkPcCz32uO/j7eaThKOifC3t5299kR
	 c387p8HYcrNvq+2DemyjnE30TtKHk6ezGWT0/8X6IHebZWplrOg1f2BxGpYfH7gA8I
	 bCXIWu7abeJ7xvZ8LoiKC4ZiOgEgu41oyIF3cUisTrCxgcLNlz2aiiXdwHL9RN7MsP
	 gmpqbAFFcp/tYJZsChYC0+1ithbl8rGluVq+lHg1HL4KEELq8aPNqbwpdV5Jv/T9z7
	 MqA6xikk6E3Hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B16B7C59A4C;
	Fri,  8 Mar 2024 22:28:20 +0000 (UTC)
Subject: Re: [GIT PULL] USB/Thunderbolt driver fixes for 6.8-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZetLB2-_00QyZZJs@kroah.com>
References: <ZetLB2-_00QyZZJs@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZetLB2-_00QyZZJs@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.8-rc8
X-PR-Tracked-Commit-Id: b234c70fefa7532d34ebee104de64cc16f1b21e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e536e0d44c44f8854a6c527195c70ce9dd1e0c0b
Message-Id: <170993690072.2485.16888337815076439293.pr-tracker-bot@kernel.org>
Date: Fri, 08 Mar 2024 22:28:20 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Mar 2024 17:29:43 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.8-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e536e0d44c44f8854a6c527195c70ce9dd1e0c0b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

