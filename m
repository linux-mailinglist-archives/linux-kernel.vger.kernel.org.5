Return-Path: <linux-kernel+bounces-110753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B1D88633C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB42286D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DF013667C;
	Thu, 21 Mar 2024 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7cKaOuO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFDB135A7C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711059910; cv=none; b=AeRtUZCWH1CZvv7a0SDbfhv6ggFbKOFOe8nHh1xIyDXycDr8wXLE0KnH0LgyuhNb8GooiWn7obwTzc0P0WC/OJE79uO9e5kY2paZJfkKVdIUztYJ2TVObqBtjVqcRYq6sGuzPWrc44mBCcIplOhy3FF1p87+aCwRwhNY22+taYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711059910; c=relaxed/simple;
	bh=GEWNaHp0RBHe9+Ju50wlKLeG3lw9qy9FeS8LdAMnL6o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=E2wCnpNZ4iqq3MzBxJssiP5khX68jfhlqNZpdx1wuwIdPYPd/LN/VY9Vmy+HYAUYZLJFBZZRRLKUpJxwylHIjeT3Xf0eLx0AvrK7WoO8YDcc5FMIS+K7tnSPyNjj2jhqhHJZF14WIcnJUo9/xx06pqctqio6rl/MoRWH17yH4hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7cKaOuO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52002C433F1;
	Thu, 21 Mar 2024 22:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711059910;
	bh=GEWNaHp0RBHe9+Ju50wlKLeG3lw9qy9FeS8LdAMnL6o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L7cKaOuOe7YuZwMgY4grHuxf03E/JQWfZKvVUBxwIrC33kLJOcP/H5eSuJaeJK/QB
	 HZp+Vqrn6JfNQW+qi9SSg4Sdu/TudO334Ur4JqlEdMlorVZybdMsFjriTEn+vUO33W
	 YOL7j1r82gusFlYsa7a5f/CRkgoIRqv2lhazg+zhdPWvhuOi+Nv/wQ3jUXFn+yrgFJ
	 1dZHNIiPSVlMBatNemWRDkC7cQJDkV1cwJjb+nyBLq/FC3FFkdwqiBQLXY3sHE/V0+
	 iADHPt4seUN8jWIo7l6nI/MzgQqBQDhcO9pnq7TbqL0CibX+OG7w8ckwuOXSKwnbj5
	 8UaVsiOvz08gg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 471B9D95060;
	Thu, 21 Mar 2024 22:25:10 +0000 (UTC)
Subject: Re: [GIT PULL] UBI and UBIFS updates for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <1722992374.86554.1711052004278.JavaMail.zimbra@nod.at>
References: <1722992374.86554.1711052004278.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <1722992374.86554.1711052004278.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.9-rc1
X-PR-Tracked-Commit-Id: b8a77b9a5f9c2ba313f2beef8440b6f9f69768e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85a79128c4f5723f812ab8d5ee465ec660e223f1
Message-Id: <171105991028.29795.7624151013270733326.pr-tracker-bot@kernel.org>
Date: Thu, 21 Mar 2024 22:25:10 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-mtd <linux-mtd@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Mar 2024 21:13:24 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85a79128c4f5723f812ab8d5ee465ec660e223f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

