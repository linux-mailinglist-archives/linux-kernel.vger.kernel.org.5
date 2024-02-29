Return-Path: <linux-kernel+bounces-87528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C0986D588
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E3D1F22DF1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CFC14BF30;
	Thu, 29 Feb 2024 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lk+rE9XK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F4614BD7A;
	Thu, 29 Feb 2024 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239748; cv=none; b=iTkca5pCKD4Okn0y5qjsQrLPwxnwrd10iI81wPYXh4XU/TU2l7sx2iPC5g19RxMNtO/LuwtpCpH7lEpaBnUy3WHiYyc2wabf+7toxDJLeIiO282bjkALOyctBaD6ndQ3QSKflRK7U7VxUBwUmRcyj6barzes+0e7HxZvNl/y+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239748; c=relaxed/simple;
	bh=JuxNBcvpx0bS8SYX7UWGBRGI7BGySRiEI7b1zq1KVLg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bhhHLvcjR1iXjTSmYvgqLK/36pCVjUQcStG/XTfxB3MdKfafFNz1X7l/1Afh24EK8X8rps6N6GUxPThk1MHQpo+DdyuCQY5dgllas40KRzCZ5wc3AV8eV52UMpxlJRS+9o86EK1lDrtUPG2wJCCnnoheBqKDrA9HamUSU9YbEq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lk+rE9XK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12829C433C7;
	Thu, 29 Feb 2024 20:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239748;
	bh=JuxNBcvpx0bS8SYX7UWGBRGI7BGySRiEI7b1zq1KVLg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Lk+rE9XKxom2osDGbyMOnORCs+f499n68zk4UoUXI2ASvzvNqGal8vxqqexSj2xKi
	 ylGoIUSNE3LTQi6E5Lbh4oLdhYRM8afl2SJw36HBCyIa69O174xOLGdRWc+lpueYrk
	 Dc5z0H3dVJm43dh2aqMntzW3dWrjQ+fndPVBY3eGX/naiKvxTuh5Ek0Ui5iHUv2Lbs
	 vMResa2fKmK+9v4fagb4Eq7aW6uu8vNPPBjrx+iIDDbPVOWSXTVN4xJP/HA2kw3of6
	 bbNhUoXE5orpU2iSZbnIxcgCnC/PWOtl2q+zHjkYzqxbu4eXGSIYx8SOflV2pJcfHt
	 /0D+hzXRvsXIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00CBAC595C4;
	Thu, 29 Feb 2024 20:49:08 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.8-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240229203921.3037023-1-kuba@kernel.org>
References: <20240229203921.3037023-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240229203921.3037023-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8-rc7
X-PR-Tracked-Commit-Id: 640f41ed33b5a420e05daf395afae85e6b20c003
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87adedeba51a822533649b143232418b9e26d08b
Message-Id: <170923974799.32237.8550464929239666479.pr-tracker-bot@kernel.org>
Date: Thu, 29 Feb 2024 20:49:07 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 29 Feb 2024 12:39:21 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87adedeba51a822533649b143232418b9e26d08b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

