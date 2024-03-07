Return-Path: <linux-kernel+bounces-96186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C7E87583F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF311C22A70
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC0E1386B5;
	Thu,  7 Mar 2024 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mj37RvxS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90E8139595
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843099; cv=none; b=YnPD5U3hdRt/zz/k6YEYAyV9gkffq4VBv3CVFoMBa5U/LdDB6Rm4/MQjAZ0os6EyKthRB/8mrywQp8lL8uevmiVRToziOG18wWRcKODW3Ahfqpwugx1q0vpwQPwediuz2PSpUkUtJEEdxpHpgVREMXybDxeburIJt8HPex02058=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843099; c=relaxed/simple;
	bh=HuxHJqWDye5tzAC9EsKo0Gue29hC6RbHn9Pl+9cw2LI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=t13BkBy99nzAosmJCA4WhCuDWqX/rPK8ZRcfJfGICfWFuM3YA0bC4UMEcpzDLmyW3Av2M8OaUkUAlj2N/jpCFX5HRCiiAaCf7YBsTAod8LIrlUbDjFlHtdMt5mUWt7C5xgAoVPjbHFcG04j79jXvNp+C/7vpXFKFepvolZSBn/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mj37RvxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61754C433F1;
	Thu,  7 Mar 2024 20:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709843098;
	bh=HuxHJqWDye5tzAC9EsKo0Gue29hC6RbHn9Pl+9cw2LI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Mj37RvxSqlxnpW7tR4yxOl8y0jGYA9EY4TVgXudgjWY/XGlAj2EwXFMTUOq3x2aGC
	 aUx2gcsQvPyVSFbb0PlANENhJ3qHnXvN7HPuElx6JTYNUEmjDF84QLg2xeGb36yqpj
	 rE1cqQUCSFQ8O2idLks56YHsHvV9fPNLOLHa4LRRjEENA4Z/5OKhUAhfNK2hOWNgjO
	 cyXonQoMQ52PUtkvlFkWGSSwLiuqVyE0dU1aQQukX5+IFfi3Vy3Rd22Ya+fCDgs93W
	 OryS6D7L45sRJj1eBhnhal9TnRpd3XYDxcweHu79QRduP3G0fZWdXMqjEQlEow6ga2
	 6ba0OQmzZ6yiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A766C04D3F;
	Thu,  7 Mar 2024 20:24:58 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.8-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240307201333.99745C433F1@smtp.kernel.org>
References: <20240307201333.99745C433F1@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240307201333.99745C433F1@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.8-rc7
X-PR-Tracked-Commit-Id: 6717ff5533f332ef7294655629b8fa5fb8b132de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5c6c9f151c4b3f5a1e8f59c79814d510c78afab
Message-Id: <170984309830.27811.10040755415085251250.pr-tracker-bot@kernel.org>
Date: Thu, 07 Mar 2024 20:24:58 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 07 Mar 2024 20:13:19 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5c6c9f151c4b3f5a1e8f59c79814d510c78afab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

