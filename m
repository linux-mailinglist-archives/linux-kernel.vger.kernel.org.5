Return-Path: <linux-kernel+bounces-89291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A015186EDDF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C66128725C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235FACA50;
	Sat,  2 Mar 2024 01:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wqd+8ruV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1788F41;
	Sat,  2 Mar 2024 01:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709343085; cv=none; b=DrbFZS6o3GA4vI6B9n54Sc//6BSRubzsjJE62ljd+12ccDKbIrPuljzZPCtj3T9N90lItsE+e0ucGNPN+P9XkXQIDUNCHNqcL5EGioIpqtjtyw3XmbPw588DnXXpbgPQhDo2mynTgk2yoHXu0Xp8D0X/bWEtPcVzNF5+nfRUqtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709343085; c=relaxed/simple;
	bh=B3BqHA4ZyWmcmOCMItyCJa7g672OEPohxC7YXaOzIWk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OfuY7QuuShTUiKw0zGyiNlB/9bBYysbzVreaI5zU1Qxt/AxWxPtvum5hiOHyJQd8aQ4/Vjqs7u2LatKfuK0DRM/++lHhoBh8aj2wNJhFDkk5LKRZlaWPIDBemXgR1WUDU7Ol2m/TCZS1BWXAIUAdVrxcZbjEJAKfCFd3bGUUB7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wqd+8ruV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE6CCC433F1;
	Sat,  2 Mar 2024 01:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709343084;
	bh=B3BqHA4ZyWmcmOCMItyCJa7g672OEPohxC7YXaOzIWk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Wqd+8ruVzEfKSms3L2BG77/fig91daQqJuAfPZBFy7RX3dAYz49w/38VCCMRA0qcT
	 qZP09LHPVkykP7twtoHnktJJtOp0DNPqD2id7+q9VyklGCflAtlXBV6mTRvkujABx6
	 szIWqpT2AhIVUdpB2abzi5iWzSbFY4jT2ZaIAPWx3YblqjwLrnicopYZ6UnlQdKBd9
	 lKsfXrcEhsTlfYaYkEJWsZCC6kpcQnV4YNFbYlqYDbf6AxcAKhtmKkl4nFaw6QhOMz
	 C+qUSfRcWu5BdEEMxa+Guoyf7dfyDb41bbzF4v2lP07Ss58imx6wwNE9rN2OfF/gW5
	 JPrich67LRyzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA741C595C4;
	Sat,  2 Mar 2024 01:31:24 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.8, take 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240301222902.GA3168830-robh@kernel.org>
References: <20240301222902.GA3168830-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240301222902.GA3168830-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.8-2
X-PR-Tracked-Commit-Id: 7cb50f6c9fbaa1c0b80100b8971bf13db5d75d06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb54efc2932681dadeca91210007a4d246c49890
Message-Id: <170934308482.29596.5964459552966492851.pr-tracker-bot@kernel.org>
Date: Sat, 02 Mar 2024 01:31:24 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Mar 2024 16:29:02 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb54efc2932681dadeca91210007a4d246c49890

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

