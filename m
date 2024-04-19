Return-Path: <linux-kernel+bounces-151805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0248AB41A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C20C282261
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD27139590;
	Fri, 19 Apr 2024 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUuvbWoJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80742137779
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713546278; cv=none; b=QF0m5EhmrS50MYJwkW7XCUTUf01vQhkg+7p4H7duHYBMYjJGSiPE+UabI6qo4vxYDLX42QCeUdk0ZL5nmEAL0jcuFgxmynru0m65lBNyBOYvQDlZ1OHw4x/uYj0Cd7VM3vzyH9/U0lZkwwzdd5WY8CbUBFMpFvB6vz9bTrwxuZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713546278; c=relaxed/simple;
	bh=fvHLckpXbaNd5RcvRYOeWTy5xEAJYwS0/rsjf35DyNg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TEKJ0R8AUCzwbglapxKMQO5A2aM48Zar8vW2OSHURYWv3U4X3iaQcLdlMMM7PnWhVJ+kURZIu1wy8DYPMFIhUsdPQLB4q7T+Rz25hJSYSUr0G8c6SHhQDPtLDreix0eRws4e3wqtfxlsdqIac91FhB3fv9JeUETvwfGDclXsgVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUuvbWoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14D3FC072AA;
	Fri, 19 Apr 2024 17:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713546278;
	bh=fvHLckpXbaNd5RcvRYOeWTy5xEAJYwS0/rsjf35DyNg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WUuvbWoJf0iVh3E5bBojrkQzJSiLfg+OFmnFpplEN5xT9wUO+CarfRzxx/ADw83Vd
	 TTzsIn/7FicIoiGwYEmDK+mDKOSnCGWkGx0ujsv3UYW7FjDWmXN1jPehVcMeU+PyDW
	 536YK1h9kofWMS3vOoTZkeV/iJ3wV5PwCiItYw9maf7udejqlIJNA3BrETzDkQ7gv5
	 RywOBv0WrphL6f7+IkYUl93EnrDsZ2Wwy6uC+QN4MYezt7xjNP3p8vyLnlW46dBLOi
	 W06J+wm0wQPj2rD8NXq7z4VnIy7EqFDdW1ZX2AMVbIPtBu4Fkppx1NhZQRiqaOEoLb
	 ivibLj9JW5tDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08F49C43616;
	Fri, 19 Apr 2024 17:04:38 +0000 (UTC)
Subject: Re: [GIT PULL] bootconfig: Fixes for v6.9-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240419143251.35ba9e253bb5fa07ad9b71dc@kernel.org>
References: <20240419143251.35ba9e253bb5fa07ad9b71dc@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240419143251.35ba9e253bb5fa07ad9b71dc@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git bootconfig-fixes-v6.9-rc4
X-PR-Tracked-Commit-Id: 298b871cd55a607037ac8af0011b9fdeb54c1e65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c6e84e4baf01a33a72cdfd1256d0f281c0ea812
Message-Id: <171354627802.5257.5315207353902387407.pr-tracker-bot@kernel.org>
Date: Fri, 19 Apr 2024 17:04:38 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Qiang Zhang <qiang4.zhang@intel.com>, Yuntao Wang <ytcoode@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Apr 2024 14:32:51 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git bootconfig-fixes-v6.9-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c6e84e4baf01a33a72cdfd1256d0f281c0ea812

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

