Return-Path: <linux-kernel+bounces-161137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A238B4782
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81401F2186A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7743E12836B;
	Sat, 27 Apr 2024 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfAuyPyN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46363BBCA;
	Sat, 27 Apr 2024 19:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714245427; cv=none; b=WbH/O+9v2caufH3cNHiYIIKy5neZH3dSHwr4/bCrZnI1CDRY8jMryPSrAuuBxqOWqEpSCoBRaImST/Br6eHaqpV6afswDSBV6OtaFJmc6nxN8/vFYo5bw5wslf39R4elVYfckc6x1zWoXoxSLoHHBxRFqzEgl+X9hERSjc/RYq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714245427; c=relaxed/simple;
	bh=qH6rAUVxPnGAasGcVjXu81zgc5DrQQueOu04FpSapWc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QFWDrYzuWcqg+M9LY44To+5B/JGeyrpohvJ8wex+vaMjg73eY7XP4yfZpI9IjM98+GNypJib8L48zdr9N5/OSBDBO9dJulT0XES9D2itOwS2jIGyJWx82m8bhNC53iJ1ZPZD3aAVTu/7BF4m+8Su6d55MF75NwShQEWv1ACj+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfAuyPyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86863C32781;
	Sat, 27 Apr 2024 19:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714245427;
	bh=qH6rAUVxPnGAasGcVjXu81zgc5DrQQueOu04FpSapWc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hfAuyPyNgHGOIJlutOpocDofMer7EziUrgGISYxqE4iZJqmr97TvA++OVMGkYpfwS
	 gYa8WZe/6dSr9xxm3EM/mYQZodgxVm756XCOmhKZSZsdX2+/Rgn+p3zHCEZe01kVEy
	 6ZlUV4oeDCu0ij2jNsWHLBxzzgpFdBqYrw+WT1p4SACLs7Msy4ZLho8qSD1odGaRaN
	 6SY3f8uUhJt4dDhvbtn8gaVcdv/JvfTYDsx9TufkcBFs7fM4znmH/BiF2VJrh0XBst
	 5hbYJxY05/jOSlYPS+boRpNXduEqel1oBN4Bk+svr0Bv5Q06CRZaKc1GOEoLQAGzRF
	 SLWQh/FKUl+0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B199DF3C9F;
	Sat, 27 Apr 2024 19:17:07 +0000 (UTC)
Subject: Re: [GIT PULL] Rust fixes for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240427171549.934651-1-ojeda@kernel.org>
References: <20240427171549.934651-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240427171549.934651-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.9
X-PR-Tracked-Commit-Id: 19843452dca40e28d6d3f4793d998b681d505c7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c8159388952f530bd260e097293ccc0209240be
Message-Id: <171424542750.11751.13148491105823774138.pr-tracker-bot@kernel.org>
Date: Sat, 27 Apr 2024 19:17:07 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Apr 2024 19:15:49 +0200:

> https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c8159388952f530bd260e097293ccc0209240be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

