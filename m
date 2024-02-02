Return-Path: <linux-kernel+bounces-50572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D6C847AEB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54F91B24707
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA428060F;
	Fri,  2 Feb 2024 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OM4seBrR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A591E83A0F;
	Fri,  2 Feb 2024 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907621; cv=none; b=ZCnbM+V6GOM//W+irxDUNBhxk9hf9t41T1Bai84iFgu2SEGMfUIYhA0v9NYKb9z+jMZ5qH9Le1gUqCaUbe9jgrYVIu202PzJ4fxrMK8V3/lYNlb7hPgqpWtFmRIlOa+buiQdf1uww+ByDr3p9yrMRgERBeuJsIc9f5Vfg6NYU4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907621; c=relaxed/simple;
	bh=QcusuvkZju3ZuWeqcFz2VxijShzSXrp5sL3xhUi9l+M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ukzpGXb+4j3UFARyxpIB2cQ8Bo90HTVeyg3YRtzCT/4Wbd5GG8hpon2M0IbnZza391ttHkztAY7w9E+KtkQ/qhsBQcl9bQprLA6DbHnVX53847E8wSSEZrLrFYLLw/P3gaNZNsubL/JbTN6xIAvgO0fRcgwx2uqzdqKT2SVBwg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OM4seBrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8950FC43609;
	Fri,  2 Feb 2024 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706907621;
	bh=QcusuvkZju3ZuWeqcFz2VxijShzSXrp5sL3xhUi9l+M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OM4seBrRQo0QD0OO35Xe15Jkd6JO66nWDtoigYQHz+VuBFVpdQIstIPnswe2gLD06
	 lqNe2ae/LLLpmO5RyMRN9sgAs/bGgNivC35K89ZaUbWmmNUquICb174KyqyXlvAmhw
	 6GX+bNNexOcflKnZyUS/jbuK3m/oH2sjfOOrKNIWiPNcvsAhdM4QY0+usY596EhnfK
	 0a3XQKN0N9BCFrn2OzCcUgXnXmct4siSccdjNpZLgoF9A7QZLyRu23r8Z53JnbjjwQ
	 vllNsa+EQXTk+XvLWKm6G35QbezhWx7sEyFIiDzW04fgHD0zzi0MqEaNRePMZPtI2+
	 iZpOnIDc6H1rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7716CDC99E7;
	Fri,  2 Feb 2024 21:00:21 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240202183012.1607147-1-linux@roeck-us.net>
References: <20240202183012.1607147-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240202183012.1607147-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.8-rc3
X-PR-Tracked-Commit-Id: 915644189c22d9c93e9fee7c7c993b58e745bef7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43e7ef642ef2e3a26bf1118e27c992ebba3d2d6b
Message-Id: <170690762148.8980.9507908163887296398.pr-tracker-bot@kernel.org>
Date: Fri, 02 Feb 2024 21:00:21 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  2 Feb 2024 10:30:12 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43e7ef642ef2e3a26bf1118e27c992ebba3d2d6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

