Return-Path: <linux-kernel+bounces-160568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A6D8B3F46
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78061F2535C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A5863B8;
	Fri, 26 Apr 2024 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/J3ugZJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1673A46A4;
	Fri, 26 Apr 2024 18:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714156264; cv=none; b=ldcEVf3fBgLroaWf/p57rXJgZyWfVlOgvcLNIWzfxR29aKcg6/1lqcT8q7XK1rRM7jeRah4vmcP5Hvru7Fy4NWZ1YesOB6rBHU7a5ODjQzbJRP/Evc6xFLOvzL0OECrIfOGi2rJ0WTBsFQ6hZ7L/Eb7+UWRZWRkVfVhC4HsAP1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714156264; c=relaxed/simple;
	bh=Ix3eXL5jNchsBTBRexCBgUKqv6YNLZIOEXcXJlY/w+o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jptE0hObocFZowamnNDwOFSflf8tqSPltcQx4vSnzDXZGSxoB/zApba/Zy1hs2OrSJNVKJdwUOOD0CghXqTd3PNGFocT8+77O8N3s9PCrn0XkYC1DrQJrMiwltJbqXj1QWv3ccgdVs+BmEd/9sh0FBvYF91mySdMUxKa7MDksD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/J3ugZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EEBAC113CD;
	Fri, 26 Apr 2024 18:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714156263;
	bh=Ix3eXL5jNchsBTBRexCBgUKqv6YNLZIOEXcXJlY/w+o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=p/J3ugZJWHmywWXK4OxMEtx/nnrZshHQ8xvXJvQFbdtyNMguJBATK49PzyQv7ImjY
	 d4xjvPfaBxW6d5s7CWGZPP6v0xWKfmRCVrtBjsnb6u6Hd5a+7p2UPd5GLQUTHd0KD9
	 b/kg+Tvaot3Q/MIcIJk/uCm1vWJ56bDCg/LRb+wM7i+qinfbebGijjWvb66oWMu9Ch
	 tUVCgnxncoxoEJjKY8g84M68+ZDrQbhp53pF2otB2PmKJ+ZGckYUPX9h89CjUdZ1pH
	 R8ar0dQiIoOnRvGIVBQYGGi0e4agNLhjz21m6oHGwGQiHjiBQ4MxXylrpWnbgPu7Rt
	 SqK7o3/pb2X4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92134C433F2;
	Fri, 26 Apr 2024 18:31:03 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fix for 6.9-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <0ab5345e-3a73-45eb-af20-80b61f3de7e9@intel.com>
References: <0ab5345e-3a73-45eb-af20-80b61f3de7e9@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0ab5345e-3a73-45eb-af20-80b61f3de7e9@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.9-rc6
X-PR-Tracked-Commit-Id: 4b759dd5765503bd466defac7d93aca14c23a15d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b43efa158e0a972ac19c54d00600bfffb7db7f6
Message-Id: <171415626359.22135.17551057035003038780.pr-tracker-bot@kernel.org>
Date: Fri, 26 Apr 2024 18:31:03 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Alison Schofield <alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Apr 2024 10:39:00 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b43efa158e0a972ac19c54d00600bfffb7db7f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

