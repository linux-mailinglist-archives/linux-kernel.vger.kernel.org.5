Return-Path: <linux-kernel+bounces-48843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B56E846242
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E54A1C24907
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F70D405FC;
	Thu,  1 Feb 2024 21:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM3JLCxv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5733CF79;
	Thu,  1 Feb 2024 21:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821352; cv=none; b=pJ3ZZAmmBENYgQTLuyMQMMIvBTDMm1eTH6M79Djkng5aMFbCRgSYw/7LQvQY2URZNlnmbQktrSRMTN9FULUR6WtBQXiskEB16H0x4r9RQ6G4Ye/bko41fHJPQ1FcapN3x2nmKkPXpKa1xQjbtbZVy0KXX9ttrPLsFFla6md4yyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821352; c=relaxed/simple;
	bh=l3/oCKlxxHFyMLP1M3auM39noF5+GDiT9+aZvX/miAo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QfvdbQTatQiV6TiJf8imPMvLXZ9fE+hIOpRDIpcDpUir700eoZ7X9AGIv6liiCgrcw2TqZliXf9zqAEO1o7FQ1NMpYm06B7tWUnBMFWYkbScyZ4TqJnqD5+3+7Clb0b9DuG966dxR3ziEio3cq0JqLAFoKXqPmPjP09ADJDKG8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM3JLCxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24450C43394;
	Thu,  1 Feb 2024 21:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706821352;
	bh=l3/oCKlxxHFyMLP1M3auM39noF5+GDiT9+aZvX/miAo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DM3JLCxvz5s2aIEBYeB/979MeP9w9dWV6DyfQ9BU7z1jo8wZ/wn92b6ZkskH5/TGH
	 F/GHG5GFv+iWG9nwakLArHTvhYjBGdcgo6AQul47CmjP9yOWiSxUFjP1oZf62Bjqqs
	 Mgw6bKnHedh2w4uPGdUN5870S1pBmn3VTlmlzXv8SdQDCAE4hcEZ/txr6Rv5CAXRv8
	 WWbGW2sjqj7EWL/gYDTyc7JZCIeZpr7V6b2Cb++ro56mGW4/kZHoxRKnRY/BjPNy9Q
	 WntlOpyQe39+hxMIJX+Jyx3qiZVpt4WMG6fF1yzABs6yzszzDWb7DvRROAftoUCIcu
	 CjXlIT59GznXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1225FC0C40E;
	Thu,  1 Feb 2024 21:02:32 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240201183046.3491512-1-kuba@kernel.org>
References: <20240201183046.3491512-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240201183046.3491512-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8-rc3
X-PR-Tracked-Commit-Id: 4e192be1a225b7b1c4e315a44754312347628859
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41b9fb381a486360b2daaec0c7480f8e3ff72bc7
Message-Id: <170682135206.25707.7004428323547963175.pr-tracker-bot@kernel.org>
Date: Thu, 01 Feb 2024 21:02:32 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  1 Feb 2024 10:30:46 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41b9fb381a486360b2daaec0c7480f8e3ff72bc7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

