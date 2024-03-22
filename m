Return-Path: <linux-kernel+bounces-111928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D849D8872E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780F71F215E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0350263CAE;
	Fri, 22 Mar 2024 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQ3lzpjm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4447560ED1;
	Fri, 22 Mar 2024 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711131466; cv=none; b=BomMgoWBswt3vbic+F/M7kkX1RYVl0OBuPuJaK8NGpnJUp24OycfAnhltLV1o+h3vqiVJeEobaZQucWEP4JuTCzhwdpVYj5VLbDfGB2pPM8rzbghol79FZpCaStuSIaqIwSJgxO5lfBb06UEJNNan2n5JxDsVYcXvNCpJD3lkQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711131466; c=relaxed/simple;
	bh=vTDbh6MfVjEG+BiUEnTOdwJ0ztrszozH78esjfXpkWs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Cji/kNXCSvHvpbfmk/IZbELBEIF14g+yBLXHHjOLAin3zGAUg0mf0BjZ6VyC72Kwg3+LgY+SbGPbVFtZC/AhYiqMO98nw1Gy8HBAgU3D+Rf/6hx/B6cyatCZuf7BzRxwV0a3CrLztGCIT6P3fnr+xfSlPBIFZeB9yo411SjEZV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQ3lzpjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D9E6C433A6;
	Fri, 22 Mar 2024 18:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711131466;
	bh=vTDbh6MfVjEG+BiUEnTOdwJ0ztrszozH78esjfXpkWs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KQ3lzpjm5S+pRf3ZuP1vAfRqrGEqLsoKfvY4K0klcRbWzxOZ5ieodskMXfxL38CIq
	 POcVVyNTS7YXJKobv2Kqz473rnNMBGTKGp6hZ/q8Z+kemcKkxehVpPZ76gSW9fN/qz
	 Fv2qmiKFchkvoK7H8SNfMHuOWyoshQgy7LachVJ4pocawbU61fmwKbYmHZG2Jcn2xZ
	 QHLAUnD5gx6D5Eq5csvU2AvjWrBvjHQXZr0LYzbO6rz3E3vmQlkAHL6MjoCDdMkJVZ
	 FH1AtyNzZXsgx53jGiVX/z3k1J4uIposm9UaLpBGHmgi+rnh3+4Xape4EY5STL7Iw6
	 a4AMH5MY3P23Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14362D95056;
	Fri, 22 Mar 2024 18:17:46 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240322175308.2289495-1-idryomov@gmail.com>
References: <20240322175308.2289495-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240322175308.2289495-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.9-rc1
X-PR-Tracked-Commit-Id: 825b82f6b82aa38dbb771d24e135152012500e51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff9c18e435b042596c9d48badac7488e3fa76a55
Message-Id: <171113146607.17281.2540026461558505706.pr-tracker-bot@kernel.org>
Date: Fri, 22 Mar 2024 18:17:46 +0000
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Mar 2024 18:53:07 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff9c18e435b042596c9d48badac7488e3fa76a55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

