Return-Path: <linux-kernel+bounces-99479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C67387890B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367FA1F2197B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D469A55E43;
	Mon, 11 Mar 2024 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6mIdBjP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237E454F95;
	Mon, 11 Mar 2024 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186176; cv=none; b=evtYKLstzPumlX6mRP/RYKlr77/n9rTDO9UNN5eTRm5iOByRc4KtBlNxVWyxTAd3b06lUecRGL6kWF+TCQ7sAc7Xc/8i0fnXyVd5tV6K0ev0cXSHibOLLoT6M6EZQO1eczIq9GiYBptHGX+8XA1pF/7mbwlIUEGVnu38WqKHthY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186176; c=relaxed/simple;
	bh=CE4nk1+OqWOsoES1bjplyK/NroLhuUshIavJBnKg01c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KCvE/bzUXHuaFMMgubargMLccb2U7DAPOZulw4skJoOAWyVqm+OhNe++J+NXyB4zRv19oYDIHpolLsse1R1nsmIHbZH2FYw5pBLwe7pSoofkBkeZA399eFqQlqGL+0En/d6whVH51c0WBB7VtM50Ey+Ic2nSAAHq6q87d6h4xQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6mIdBjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC163C43390;
	Mon, 11 Mar 2024 19:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710186176;
	bh=CE4nk1+OqWOsoES1bjplyK/NroLhuUshIavJBnKg01c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f6mIdBjPsYoQXZRhjTtF/+94gj9LK3lul5eW57AClzY+kD9Eps0m3nBmveZCYLxfy
	 Uj1DzY8brV/l/BEoK/bvKXtO5sJB6dA/2bocca3sXdUO30H0g7JM9x9vKvlTY++ewZ
	 lZcgvssy6jEehab79R++ScnPXFbph5BKCq25NEQDl31kcrw1kggoF2kHXJj9lYvnwU
	 2r0rkk1g8C47M+LG28ZT+UB5VKCoTdabGOaKbJ6+5EAphKY7jlISAFX9hYR4joOqY/
	 eJtX3zkZ4ZOljYWP27/l57ja4T7cOXzjEQJNNLz9Wev7fuIeMWpcA/YABIPKdoqQXx
	 4mZUyRX8YmXcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D581ED95055;
	Mon, 11 Mar 2024 19:42:55 +0000 (UTC)
Subject: Re: [GIT PULL] Rust for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240309133817.335439-1-ojeda@kernel.org>
References: <20240309133817.335439-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <rust-for-linux.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240309133817.335439-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux.git tags/rust-6.9
X-PR-Tracked-Commit-Id: 768409cff6cc89fe1194da880537a09857b6e4db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ede842f669b6f78812349bbef4d1efd0fbdafce
Message-Id: <171018617586.28701.11549928225258146500.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 19:42:55 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  9 Mar 2024 14:38:17 +0100:

> https://github.com/Rust-for-Linux/linux.git tags/rust-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ede842f669b6f78812349bbef4d1efd0fbdafce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

