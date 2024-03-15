Return-Path: <linux-kernel+bounces-104887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A704A87D509
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34863B21D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D93054BEC;
	Fri, 15 Mar 2024 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+jQJemV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F1854907;
	Fri, 15 Mar 2024 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535055; cv=none; b=YQZeP7FRih/bgBb+hGXMb6ihQHVs/WohwqWNdVj//4FBAFyarKx8BBauibQOm5Q44M/PbDZ6jEKog3N3M9B6mgVArZMwrvfbRd8hvXjcMl/1KS7EnNMYHV+K2GbuPMHuOdpZVA/WNUOqkBxx3ydpiQedafvk2wNcMeywq3VmWw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535055; c=relaxed/simple;
	bh=tIx3i0NJYpZdhaoDg7gS/RXZqhMB1vfFbFZU+gr5Rds=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PnuRZrIqsE7GVWsWqbkkyy6q/5xSK+++1F+M8pCPAqYjDNZvRC6c62/ynjyWd5xzYEuIMsfE8pXsB+SKj+fYOWGkBrMELJimfnenllJx5fjt3ZAtZUWpudxW3K9IE84Dd/yQDaiezFiI7Ty/yxQHJhay9HnbFJhOVMDjnmhV6PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+jQJemV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3216FC43394;
	Fri, 15 Mar 2024 20:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710535055;
	bh=tIx3i0NJYpZdhaoDg7gS/RXZqhMB1vfFbFZU+gr5Rds=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Y+jQJemVp1cjyISapj65ke/UJj+/cVnwQk1kbCJDWI+pEQCaWDbXitSdEvANhTOOg
	 3WdyVU/lM1kuipsS1o+Do5gJAri0Ra/0Z876ydaIYVHtQhJnKirJNt2jLjSGwjGAYg
	 1xPzvbsrunzaxKrKvPhBN73AyWXw7m1TKcBXX0TupCAkaTzA4nQZjI1silxJU9DKnT
	 6F0pslV3zM5isJqWNaPRJRj4F22acRUooPxZZ0eD3+ND/6E2vfk8SggkQIPvGdnlym
	 SRRCPqB26kjfisi3lQQ8CtkRSg3raAmY7DKrTey01dlAdIV+jRPH6rykOpc2ZpFfAa
	 C7iy5+lX3IhkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C75CD95060;
	Fri, 15 Mar 2024 20:37:35 +0000 (UTC)
Subject: Re: [GIT PULL] NVDIMM//DAX changes for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <6ea8ea30-9a6b-4ed1-bccc-96b0171a3dd2@intel.com>
References: <6ea8ea30-9a6b-4ed1-bccc-96b0171a3dd2@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6ea8ea30-9a6b-4ed1-bccc-96b0171a3dd2@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-for-6.9
X-PR-Tracked-Commit-Id: d9212b35da52109361247b66010802d43c6b1f0d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4757c3c64a71820a37da7a14c5b63a1f26fed0f5
Message-Id: <171053505517.29375.3695472699220989106.pr-tracker-bot@kernel.org>
Date: Fri, 15 Mar 2024 20:37:35 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>, "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Mar 2024 13:44:39 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-for-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4757c3c64a71820a37da7a14c5b63a1f26fed0f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

