Return-Path: <linux-kernel+bounces-109498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 422C5881A39
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5350283514
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D7E86246;
	Wed, 20 Mar 2024 23:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYvk70K3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7CA8613E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710978397; cv=none; b=Yv2N4tszyRkL7nTKlaSm6F9Fw3rWE+IYFhyunojXUTWn7nUHNWxI5WncuGTPkZy2tQLzmd+wj1xDb4XX1aSnxJ4HU9kzA7EyBaLMbcOpkeMJaYzkVjeBWWXS/umo19+INS+vP9tiIGefkbZt3jDxv0m3VE9RedFNJOIGEbAEzsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710978397; c=relaxed/simple;
	bh=7/+xtavFlF76nIPvdQ7/GGOCwvshJsJhcn/KVuUU9ZQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pYv0w+tWWhKt25OmXkkR/CZk2ljzfRrGt1oiQNgKWRQ+ZO5XodYjJ/annya42rj9aWVnkPVeei7gaFZrgyroKhz4dTHbuzDyhoxzDs3LyxvOlkHQ+/cYc+PhuWkASaeHS0FHvvEVqiQqtvE8wMjwDpfu9H7zH90GvouSEV5vI3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYvk70K3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98632C43390;
	Wed, 20 Mar 2024 23:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710978397;
	bh=7/+xtavFlF76nIPvdQ7/GGOCwvshJsJhcn/KVuUU9ZQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fYvk70K3juaN0LXneK04NqgC7CIo620ATutiPv8kEUh2Wty+jFosr0VSDzupVfLLd
	 aXX+EdyZYPTJBWKArjEwpQMe7mQ5MHZTS0VNW4dHNKNYzKrZZWz2WNTr5ul4k70xP0
	 dMftcMitYGBsM7zrq+2OXRmYIb/7X/YHgvzhIqXw0nd3eNwvTSzVv138q/k+GoAeB/
	 pT2BQRQ+VQHqvuPAJdOWUEA/m6vigfjRQnmMnuORkaouZis02l2AI9JifZsDc5or0M
	 /+/58cDdvR25KyS3vIxOlUMi3ayAEuARxQ7y2b2u+OJf2ZOFe/bkJH3XpdMIPGG/0C
	 gt32zdBr0V+dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90A50D84BB1;
	Wed, 20 Mar 2024 23:46:37 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtyoxmUyhmD-RA0TzAvsanU2VaCRi=OpTqCVjzdv0QykA@mail.gmail.com>
References: <CAH2r5mtyoxmUyhmD-RA0TzAvsanU2VaCRi=OpTqCVjzdv0QykA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtyoxmUyhmD-RA0TzAvsanU2VaCRi=OpTqCVjzdv0QykA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/v6.9-rc-smb3-server-fixes
X-PR-Tracked-Commit-Id: def30e72d8abaf68da10682767e584519c234c4c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23956900041d968f9ad0f30db6dede4daccd7aa9
Message-Id: <171097839758.7347.5855464583372910334.pr-tracker-bot@kernel.org>
Date: Wed, 20 Mar 2024 23:46:37 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Namjae Jeon <linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 20 Mar 2024 12:06:54 -0500:

> git://git.samba.org/ksmbd.git tags/v6.9-rc-smb3-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23956900041d968f9ad0f30db6dede4daccd7aa9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

