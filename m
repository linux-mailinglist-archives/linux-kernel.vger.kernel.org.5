Return-Path: <linux-kernel+bounces-59883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E202A84FCE6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1662F1C213F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084C58612E;
	Fri,  9 Feb 2024 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmnWk3Mt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C4F84A32
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507121; cv=none; b=FKjjrJO0y1ecFKuPf1KQ/CqdOLX6QRF5UPsf7Zwy3lv8C5mF+xw0zixL6hCAgO481pj0hPhu4sYYJ/RhJaQOmMzqYABtYDURcqn7yyoh6MK06mE94xk8akU1u60+YzzgKBQWqM6l/f1LlB4WOhmo41mtaOd+Yzt+QRB9eWLGZhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507121; c=relaxed/simple;
	bh=F+sIiex4L43Qikbn9GbDgBIpdkqiOM3V5P2O0mK4WyQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N6TqkA6TybQi0NctKIk1TDZeEOxrwN9YLT44FMrrqRmGZ2QF9a0nZjyiDMuCnZe6fCW0BULhx4Z0kN8LLA3PPqOlVGiLxP3dp1gTZctirOhYJcpEt1DXSfWCG3TZIAa/09mQ+TevM5tOsUN/DZaIUtJrenlPmwMb83SXClfAv6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmnWk3Mt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 188D3C433F1;
	Fri,  9 Feb 2024 19:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707507121;
	bh=F+sIiex4L43Qikbn9GbDgBIpdkqiOM3V5P2O0mK4WyQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jmnWk3MtMYUaUbLdqCNwwYuuauCYq/HcUz97yJLf8lNg8A5g1w5oRaJZs7FKnHMf6
	 X2p4xwQK0V8rKVYnNQI9SiAgvX99VBjezPlo7nZUzYjV3RUCAaAMY+cnofJ8Q946Y6
	 pi1Wxuxb+T8FHzhn775nShvrmwlyEoK6a3s72/JGHjCEtKtob6NKgbDNWI9akMzASx
	 4CjQdqvFI3TXhfr+evWkjGUgm9yN6vZEvNsgaOr7MR7lJ6eimbpaAXOO6C7cmrrPih
	 etTxj+h0lkmiRKDLY+TbayXkQWYUmH4cG1I7AJrgs7hYRXFKwWsA8ax3e8iyUXA04V
	 BmIXIQu96NNVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05BB7E2F2FC;
	Fri,  9 Feb 2024 19:32:01 +0000 (UTC)
Subject: Re: [GIT PULL] probes: fixes for v6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240209200916.e1607c9688a39971feb43867@kernel.org>
References: <20240209200916.e1607c9688a39971feb43867@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240209200916.e1607c9688a39971feb43867@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.8-rc3
X-PR-Tracked-Commit-Id: 9efd24ec5599ed485b7c4d9aeb731141f6285167
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6dc512a0a22e817100a0522d8f0985c8ffc86456
Message-Id: <170750712101.26526.8809545842289447237.pr-tracker-bot@kernel.org>
Date: Fri, 09 Feb 2024 19:32:01 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Li zeming <zeming@nfschina.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 9 Feb 2024 20:09:16 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6dc512a0a22e817100a0522d8f0985c8ffc86456

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

