Return-Path: <linux-kernel+bounces-89097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D9A86EA67
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7D81F21F91
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596613D3A7;
	Fri,  1 Mar 2024 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVNjPOww"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9042E3D0AB;
	Fri,  1 Mar 2024 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325441; cv=none; b=uQZbipa9OL56WuxDb0mdINa+Uzqaf7/1nhYyqPwhDCSGfR9IJ288bsXDRlMx7lS1KOhpqwI4T6wyN06iIYQzsmXi4hK3ohOH/o2xMvw2vURZHn2osMFEjtyBWHXCPKx+NfMKzb+Khf9HoZhM5Tf3gUErHYkWGSenVjmfAXdKBPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325441; c=relaxed/simple;
	bh=R4xRsdU9TDT2Zj7/56xiJV6/6xw4QYpZnxrsc9ZYE64=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FtlADe9Hw5nPRR9Y6rcJD1wx09HlgfuoVH06RRNHtIOND/QHy9ClqoMOGroCSOjNaHKiPfYax7PXFATt7foRn73cGGNsNAOz2vSUf6uAhHVwejSZToxgqVuH46YothpfUa1EyDcNH2yEsI6oqv2kGykeTMQTyYafgak4YxVMEFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVNjPOww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70B49C433A6;
	Fri,  1 Mar 2024 20:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709325441;
	bh=R4xRsdU9TDT2Zj7/56xiJV6/6xw4QYpZnxrsc9ZYE64=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BVNjPOwwSNXbD8vmC09J9V5ipoU28d5PqcoZ5bkNi3Ymzl/yzjqma9TTsIm9apRAb
	 0rEIiJOBaw5T8C4Om5wHfijRonkpAJkhbm8hurxNyzh3GW8T0hQiM5GWYOlEIcaZK3
	 bJS9lPEM5xYzdEWApydaXcJ+S1zBguGoSItftzutY/CZcXX7btAql7U5q5L8053FRe
	 QYGzdY/e7CGiFXrqq8neFA+2ReKWFzr0IjTBu/6lSVDNSGO7WCuhFjQ8qw8xWCu/yq
	 wt2f57Ajmx42+KF8Y4MbUn/LYlk0DnESbEGqpiVM6x2/Dd/94zKcQRaIKsYTJsXtTc
	 Ih7aMA1ADPG5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CBECC595D1;
	Fri,  1 Mar 2024 20:37:21 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fix for 6.8-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240301173710.2004467-1-idryomov@gmail.com>
References: <20240301173710.2004467-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240301173710.2004467-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.8-rc7
X-PR-Tracked-Commit-Id: 51d31149a88b5c5a8d2d33f06df93f6187a25b4c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5870ba3dc6e4ca4b29a0d1ddd9c3e35b44f0b172
Message-Id: <170932544137.4935.9733397889032478694.pr-tracker-bot@kernel.org>
Date: Fri, 01 Mar 2024 20:37:21 +0000
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  1 Mar 2024 18:37:09 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5870ba3dc6e4ca4b29a0d1ddd9c3e35b44f0b172

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

