Return-Path: <linux-kernel+bounces-69393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 889B7858862
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451CA285430
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0E414831A;
	Fri, 16 Feb 2024 22:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aytk5fr2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7393146007;
	Fri, 16 Feb 2024 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708121398; cv=none; b=a+ef+4FkERwqc8EMpv70cN2rVoDMxzRkn5+Rdz0FVUwIDOqPJyAKl80v8MR0EoKRduvgeAeDX2VgdpnBHBPx5WUPxjIlt7+G1e8ECT2o1WCarnTjrk3oAClQkjhI56FpP8v+/57vdD0bzLucmaOxrJcAqo1AE4Mnr5nCHtKLqq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708121398; c=relaxed/simple;
	bh=lRFQIJZX3Pg0cTIlE+lHH+nreOThLU4vdjwgO5STp4A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HLJ4Z6r8Dv4g7CDAxjlRX+ZtL0y8AQAvjtdqgQs0LipYWoMpw9XSTc3M4tQvz23D3xqHIkDQe2mrtmO0LI9Jt/svJ64tdU5494aeeBeGauDAYn0pG6AoIwYmv/lhq5F4UpBTfs+YZ8AtzTMX1VK0MGV3dl/6mDI4XSTdEa8zknk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aytk5fr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B7DDC433F1;
	Fri, 16 Feb 2024 22:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708121398;
	bh=lRFQIJZX3Pg0cTIlE+lHH+nreOThLU4vdjwgO5STp4A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Aytk5fr25MDuecFLMkThxrtYkUh7PilTIbHf5i0Jl4c7N4TSRycUKe51N7fMHxZIg
	 KK/AL3V2rUpkfeFbrh79T+2XbJjObK+PyZNvQS+mDC1NQg9sHWAqPKMGeIipQGnFy3
	 HtOWrVRAT5UAAwJ075RM2VrOMYqyVzWMfN9a6o+d2nY4rXH8MKaLRkg91QqGa4bhax
	 9wScDL7Tse9WhdtaLCZCFl5/lKMEQMWuAP9ZKfZKKxmswARODHLrQXsto5YRN2VydL
	 p+fXZYC7NglX0mGKzRh2uUXPxDXGriDLSgGlKdoGWPK68TngHFtnWGfhjg/x71dHpx
	 7XLYJJNhvR6pQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1582CD84BCD;
	Fri, 16 Feb 2024 22:09:58 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240216173705.1837988-1-idryomov@gmail.com>
References: <20240216173705.1837988-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240216173705.1837988-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.8-rc5
X-PR-Tracked-Commit-Id: dbc347ef7f0c53aa4a5383238a804d7ebbb0b5ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f9c1b315d65fb4b3a2352d579c35d662b0c2ae0
Message-Id: <170812139807.30067.13654568591538586875.pr-tracker-bot@kernel.org>
Date: Fri, 16 Feb 2024 22:09:58 +0000
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Feb 2024 18:37:02 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f9c1b315d65fb4b3a2352d579c35d662b0c2ae0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

