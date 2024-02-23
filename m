Return-Path: <linux-kernel+bounces-78796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E998618F3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92781F23944
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8E712B168;
	Fri, 23 Feb 2024 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqrMMaL3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B2B84A37;
	Fri, 23 Feb 2024 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708302; cv=none; b=ro6QFpN2lNj3C5yiMcwL/9wAJWUrkEdV7sPwNmayltu7sPb7/pu4ZRikZaUdyEpNXsHIY55e+IcBOmcdk+ppVlkF6NUuI8qpaBWls3qdB/X5cRdh3kfxRTty/xVyIMpWiar8OxmDJy11Ed70GF3l852FzmjsIoDYUtL5yveQBfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708302; c=relaxed/simple;
	bh=XYiusDz4a/zHRVjgoRq8EzKguzdNE99tC+fJGZhhOK0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nsGZD3klIbKMrhr8+SlxnMKURZGRka9Y5f2JasPQSe1xP6VRh+SmfUJK9cngolJ/vvhOKkPxrZEh2fW/2NWEkZ+irRCgRVMoz0Hbcbl4TM4EYihUhjOVQauk77EU52i2ZRZXX7qiVs7hKqfyVvRhejMB+QjcH/8osGHyIZd1Y+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqrMMaL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEAC5C433C7;
	Fri, 23 Feb 2024 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708708302;
	bh=XYiusDz4a/zHRVjgoRq8EzKguzdNE99tC+fJGZhhOK0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PqrMMaL3T+YbEM59yC1v3ZcikGnDT/Yqtk4wJUHzXwStsON4jgy90lsDXIpJGeHil
	 OXKZGOlmcEBhfvjOn0x1MZ/bchWUuhv/31t3rAEEttFMm8wlEtmG1D/f+di2BMDTAh
	 sn9YBFZKfKVyXXBx7wawPBh77E0h1QVBf0NAaJ25sdbBbRAUcOSbcbQiNr9IW4G2Ms
	 BwYFHpkhabqnyVKPJxu4d9yDXL89/CgcMDldBwMJOHAWrqZxvKv2Ye5C5G1GTW1IWS
	 tN2wFgsWNEB4KIKy2RxFDTUh6o9XRybpN+m2a0S7bKfZzEQA9PAypCcoPlALt93ifI
	 h1kEo9jGb7ldQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DBF1BD990CB;
	Fri, 23 Feb 2024 17:11:41 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.8-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240222225651.4078336-1-linux@roeck-us.net>
References: <20240222225651.4078336-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240222225651.4078336-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.8-rc6
X-PR-Tracked-Commit-Id: d56e460e19ea8382f813eb489730248ec8d7eb73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76d885a1e5450d16252fcfc07d51ecdaaf712fa4
Message-Id: <170870830188.25757.4439962222756019066.pr-tracker-bot@kernel.org>
Date: Fri, 23 Feb 2024 17:11:41 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 22 Feb 2024 14:56:51 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76d885a1e5450d16252fcfc07d51ecdaaf712fa4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

