Return-Path: <linux-kernel+bounces-37844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0E183B65E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53150286120
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76FB67C4C;
	Thu, 25 Jan 2024 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hs0PqrQu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5CC63AE;
	Thu, 25 Jan 2024 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706144750; cv=none; b=gm40NILI4T6ipHLD3LiQSEYqhlOqAxNBvJWwbTUow7kBbALJl9Uzq1oe97ZoPJKBiva3lY0awyB/mkxNHP9ihI6T90EnBboGbtTCWM0EKEIZnLwCKopzluToewti5j9bzK/KwalnQruPVBkOna3E41ch1BboC+6Fjrk0Q4zgRA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706144750; c=relaxed/simple;
	bh=M4KvLojT4IjqBF+YmPzMSICn8NeVt5RlUd93zY74MgQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O0SIItkZZVZ7gbPPD/MY6Tyu8VLyNiivuj+iUo5EppmxqLsE0fPC5cWUuw0Yy20fWfE91Vm6KbQxmEq4Bav1XLlIRJv4nOiHsVqijMwyak38Kpt8f14xRSL6YxNTxq8iiAfzK6sZ3VMC8twec5qT8ONioyeXpnGpn8lwQULYKSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hs0PqrQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5C35C433F1;
	Thu, 25 Jan 2024 01:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706144749;
	bh=M4KvLojT4IjqBF+YmPzMSICn8NeVt5RlUd93zY74MgQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hs0PqrQuhsWSyE2F5Y8flTLMdLt8zMGH8dmrK8+6qhjdGFwvN+D18/Toe/1S3NpBp
	 iatQEjoqfKEHnlIZX2ZWDH0i+qy4fqk6w+Q+BY1wYpi//7QYvwtZ0Ue58SSf9cHxnu
	 ySbNdlLnStmaZxXpxsO/d42+wfMkYa1slkD0QZOSZ0qF9+uDNWksWZzrQYjlEjYpWM
	 68pL2UNGmR2Hsg0Qtpeg1+FvhdeytTj4lRMA2oYfXkV6V7Bv2a3IbndRAaELsV7eaL
	 w09ieyS2JuJpcE6U5wZWi+V799/bXYB7kyE6f5W3/ujr6bEgtmSCP+v5FxkBwo6iNz
	 nwTv8h5B9cuTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5CF0DFF762;
	Thu, 25 Jan 2024 01:05:49 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240124202109.1567593-1-idryomov@gmail.com>
References: <20240124202109.1567593-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240124202109.1567593-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.8-rc2
X-PR-Tracked-Commit-Id: ded080c86b3f99683774af0441a58fc2e3d60cae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6098d87eaf31f48153c984e2adadf14762520a87
Message-Id: <170614474973.13085.1781497391276692794.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jan 2024 01:05:49 +0000
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Jan 2024 21:21:06 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6098d87eaf31f48153c984e2adadf14762520a87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

