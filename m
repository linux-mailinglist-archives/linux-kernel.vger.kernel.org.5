Return-Path: <linux-kernel+bounces-54434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8150B84AF2F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFDCAB22A37
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794F012883D;
	Tue,  6 Feb 2024 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgScM+Lq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A3C128831;
	Tue,  6 Feb 2024 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205646; cv=none; b=Deo5pmighKoFyi6m/mqod5+O3fccMQEkc9rxUFGOBq9i0kVAegCDW35YU+KpCiJU2L04N+zLOIWIJEPWyw0R/An1vyz37irmj4Uq+rWY7C0P2ghjHlvkcl/Fz2A0lr1U3f5g6mY4oJEz6PWpbK5k4524TE+0Y4yCZL9Sw+0Gep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205646; c=relaxed/simple;
	bh=YwhZgwgbQswfOHSxcvvJqiI10qad8vn74BWIWjWT/yI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IElX7QxNOWE435sycAYjYCOH2QU131ra7LvCpKQCbBqiW9zeqn5G3Pqm09+k761/wxGKpRb6VGUNYx4q8gIUH4e8OHsDUs9kKgk+owR9YSS7FzlDOF0S7ckj6yH79+/OPgXnmtTSkEQbLVIhOkh98R9yPjq34XsAGG30M3mK91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgScM+Lq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44C4BC433C7;
	Tue,  6 Feb 2024 07:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707205646;
	bh=YwhZgwgbQswfOHSxcvvJqiI10qad8vn74BWIWjWT/yI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tgScM+Lq/MFetVQA1xBBsAy75mwgwc+vGkhzoctpoe/rg0gOLg0IdQP0p6PZ3lva9
	 fjRuxGbinTuFPna0H/XLewLPToOTfRuKmQMnSeXW/4K+uGWC2YWbeRmc1j7jG/GMKb
	 1PEPu1hymyKZeNPoYeNauGimi4ThEhuJxCjK/GYWM2yczck8fgXFXmFVCQ6UZWi84u
	 QAH9PGGmO8GgDOXH3UdjS/jV3GGPwIH14+PyI57ldDac5+LC1ZXk5Mehj9n96EeoUh
	 wB7IThGqeQ2DlMJQX2PGa9Za9K0ufaMXpDHYHs0eS6Ks40Fv4Jlq4oKNFJwOCV0HbA
	 Vxc/wdXpl+N8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33483E2F2ED;
	Tue,  6 Feb 2024 07:47:26 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <v6czqjwdsso2hy6be7qeu4mqxsx4oydq6shavws4k7sexshcrp@np4inrse4e4p>
References: <v6czqjwdsso2hy6be7qeu4mqxsx4oydq6shavws4k7sexshcrp@np4inrse4e4p>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <v6czqjwdsso2hy6be7qeu4mqxsx4oydq6shavws4k7sexshcrp@np4inrse4e4p>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-02-05
X-PR-Tracked-Commit-Id: 7b508b323b2ec45be59769bd4e4aeba729c52cf6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99bd3cb0d12e85d5114425353552121ec8f93adc
Message-Id: <170720564619.3974.9278369920294903060.pr-tracker-bot@kernel.org>
Date: Tue, 06 Feb 2024 07:47:26 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 5 Feb 2024 19:15:32 -0500:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-02-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99bd3cb0d12e85d5114425353552121ec8f93adc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

