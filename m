Return-Path: <linux-kernel+bounces-67613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B8F856E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F2728C927
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF93B13F015;
	Thu, 15 Feb 2024 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jmuka/BD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA36013AA35;
	Thu, 15 Feb 2024 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026607; cv=none; b=WzXzj6/E5VoI7JSEtCrwN9avwqw6l8Cs1ubbD1GafUM6KVjljq3rIMtTa/9crrqu9W/PXxyNo+mm8/eUHfQ+gczWDm8ZwW5nCdpZncv5f+IxdozvioMCBMR7gUVWFFCtJg5rADsLIoscxlPvpUaWxi/C8PUnOLlv7idSpdKpJyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026607; c=relaxed/simple;
	bh=jDIZVjmxrgUu27lhO2P/zOKIwiJENod221wvbFXGcl8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mlhXNCxZuZV5NJBgTWqIiplZiWN/eJ3Vw95wKuor8y7eIRr0hVd9O5J9v3hJTFwAhOail5jhHIhRH1IRb8fP810jTxCE0qZJF5u5F+nhLlVgnQchpMgk/lhTFtoXW1VwyTB/H5IqIRv2JU1zERvlZU0csOplyuaMJAXT/mbHNHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jmuka/BD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A100C43609;
	Thu, 15 Feb 2024 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708026607;
	bh=jDIZVjmxrgUu27lhO2P/zOKIwiJENod221wvbFXGcl8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Jmuka/BD+sT+9hXwIG0LfNMV/TwOqeklYb8thXneq8yxleDzsLmuu7xUyPfwBQFxE
	 htfU+7ICwXDjBAq7RBjuTC2QsM7tU6zRT1edxD8tQ9aFTyCacca6dR+Ii+aGGeP9q3
	 RGHXFak7Q0V+RBfKxx5N1fjJPW420LaRn/1TrG6KGTwl5vWR27M+Of5f27Tv/45K0q
	 hmOUW+oF9ZFXyCZiG9IE5bkWWBOk80RDaXCDLqTJ7jfw8wfy2lUdJ+wPzaW1q58Epz
	 Gnnpg38fqjjxDOhYZE5ZcQ5xWGqu20rxSdpJsrkNo7+OzEHQcvVZxxGcrJdruUC1BL
	 kwDH6R/fIITXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E9B5DCB6EC;
	Thu, 15 Feb 2024 19:50:07 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240215153248.GA181950-robh@kernel.org>
References: <20240215153248.GA181950-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240215153248.GA181950-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.8-1
X-PR-Tracked-Commit-Id: 4e06ec0774f5bebf10e27bc7a5ace4b48ae0fa56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 339e2fca02141ee74bd705b3d409aa81d9ca3d0a
Message-Id: <170802660725.17476.10766418345866334930.pr-tracker-bot@kernel.org>
Date: Thu, 15 Feb 2024 19:50:07 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 Feb 2024 09:32:48 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/339e2fca02141ee74bd705b3d409aa81d9ca3d0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

