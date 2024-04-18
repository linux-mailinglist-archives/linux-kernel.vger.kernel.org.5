Return-Path: <linux-kernel+bounces-150566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2438AA0FC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADBC9285975
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D127172BBC;
	Thu, 18 Apr 2024 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tm8Quevk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE7171093;
	Thu, 18 Apr 2024 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713461005; cv=none; b=FgOXO5PskAzdkBGpkysFomPpcaB0F6gycHt+W+MoGex+hPsWvCtNt/RlyoOMSjpNnykpTFyhFmZp/506Gb+Kv49m6E1K4jioJrwp7K3n4qBhsiDqcD913FdsnW7dOWaTGGQbgaVWmONHeD8a8NU3gnNqBv01oxg+aUDuQURFYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713461005; c=relaxed/simple;
	bh=O+BlYr5B88IYB6tmQUGNTReB34mdgGymzzFo8OXKIo8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oPSkn7eol7zeVe8KvyJuU4h18kE5lFwmN4ud6hwCvGSv1DDBc8tOOw+VWyLtoAfKpiFQ7grU+SGWpCZeKj0hn+/9OoNj/QXKiDXSJb4cFNO6a+8FbNh6yx5LjvYvZmCuMcX6nr3ozEAmLyVnw07c1GLbxJ/JFTriRpnwFcoBRN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tm8Quevk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 855BAC116B1;
	Thu, 18 Apr 2024 17:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713461005;
	bh=O+BlYr5B88IYB6tmQUGNTReB34mdgGymzzFo8OXKIo8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Tm8Quevk0VMpU27oNfPP46g1u29s7k9gVG38abIxQixUgNg8nahZt5yFFuo8Gmd+A
	 /okaAF2p/jUzc8mR4bm7imU5ysTp0mHu7TVK5h9gfHzp0oGiX3jQ+R+rUXNRP3n4It
	 SKEehRHo4oWT+LZMTRBPxiBoCryYWlWnIVRTbzx98aC0tgpAhBlcnGZHy87997PZWd
	 Rbm8C9h/s74WCKGFe5Gx+PQLOioLTrchevC+I9szKTtTkwRihWOBt66my4bO2wNIcO
	 N0E/8Uh5pNWfr6dQaO7A6fll+tUzNvAltZUdEhD7Te3G2rDVrmDcbTy6KlsRJTaA8F
	 DcGzgpXDcuIqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71930C43619;
	Thu, 18 Apr 2024 17:23:25 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.9-3
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20240418120332-847319520@linux.intel.com>
References: <pdx86-pr-20240418120332-847319520@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20240418120332-847319520@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.9-3
X-PR-Tracked-Commit-Id: f609e7b1b49e4d15cf107d2069673ee63860c398
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2d88559121ba4b6434493b4f8ed46657be6cc08
Message-Id: <171346100545.11189.8214122422847991143.pr-tracker-bot@kernel.org>
Date: Thu, 18 Apr 2024 17:23:25 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Apr 2024 12:03:32 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.9-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2d88559121ba4b6434493b4f8ed46657be6cc08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

