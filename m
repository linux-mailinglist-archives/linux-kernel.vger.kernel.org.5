Return-Path: <linux-kernel+bounces-66183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CAF855838
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A35282236
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86F415A7;
	Thu, 15 Feb 2024 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oI+WYsth"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2725E391;
	Thu, 15 Feb 2024 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955958; cv=none; b=mAjJCt/eyPOVM/dGkDhEHgPgQme00seza1Z89HDRy6UJyWO4WOjuSEgFkZ4GK154dDLzPm3KrmXh4ZvVksCrRpxvJMOEjhjTdEi05PUvDNy71fOVwl9p1WhC8I+6RmqVdNYusNlUVHvGRBrbXbdN2ickOlaCUB5xHlqrNxms81U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955958; c=relaxed/simple;
	bh=s0umEap71PE2hcDvF2RMK2MaQsG5WH0Ik7roZhh78EA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XgXDVOYF4QViSxd/scqEB/d9gSthTL7QdqzFP0dhjmlnXcUe2hhkhf1mX/Hx7mq7zqJQMZsGQtF9ZXKyaLZUk9fbashg6D4Pv4qiCzGpf+aiBAT8ZHcsCjG8oI5dczVTdxTP83lXExtSCToZXNyiBT6KHPwdl71PDr1xjnCv2Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oI+WYsth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3539C43394;
	Thu, 15 Feb 2024 00:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707955958;
	bh=s0umEap71PE2hcDvF2RMK2MaQsG5WH0Ik7roZhh78EA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oI+WYsthi6DWVeCZErP7XTecGq4Egt9aYyjdwl/yQVNbx6tB4bjuvCsvP/hT594SQ
	 bXU4ZVofZMbtz6W+hOlODh7gNZpxNxNRMj62VbFzn7l5uGovR1qDgIxH7uF7ogxxg+
	 MArpewwSduPGaBm1UhCGdHprF1nuWLKcfQRKkgdvG/oyUVDyDOSYjb2xhawPw2CT4G
	 G6V9AFtYAMYL6DVfB/82M4YYH7TGtZmDU15wfWBxjsIDsC8nJ8s2gFsjDOx/OAaBvq
	 hEP9KGAZQpGsN7XWJm0Q3xVCtVAtSO251khkBVE2m2fM/X5QsrPKJ2ksICr2folAPe
	 xHOtoIYwfXufQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E168DD84BCE;
	Thu, 15 Feb 2024 00:12:37 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZczwVtJLAl+aeunp@alpha.franken.de>
References: <ZczwVtJLAl+aeunp@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-mips.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZczwVtJLAl+aeunp@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.8_2
X-PR-Tracked-Commit-Id: 8fa5070833886268e4fb646daaca99f725b378e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d3dea210042f54b952b481838c1e7dfc4ec751d
Message-Id: <170795595791.14173.5943301368638961241.pr-tracker-bot@kernel.org>
Date: Thu, 15 Feb 2024 00:12:37 +0000
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: torvalds@linux-foundation.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 14 Feb 2024 17:54:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.8_2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d3dea210042f54b952b481838c1e7dfc4ec751d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

