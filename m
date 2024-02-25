Return-Path: <linux-kernel+bounces-79909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D11186288A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 01:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DB71F21BB1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 00:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BF03211;
	Sun, 25 Feb 2024 00:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ME47pIY3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3ED2F43;
	Sun, 25 Feb 2024 00:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708819691; cv=none; b=oFnu6I0x+78WrrIXlkahPFwMvWVLvogUjrXy7giRkz5wSz4BM3rMfcFxMJDe5r+L6lwEee3fKsevAKC0Hg7wbHvaRALWdZnDyfHnCuJRzwnZas8qVIHe1s2BJuQfWpFNvScIbtiuN0e3GUcXoDxynLjQtYVK/vMt26QWR6L6oxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708819691; c=relaxed/simple;
	bh=a7/1igAT4PoxDcDNOgmtzoiaA0neM5ZGDNTfggTNBHU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FrzkBHyEj6Ud8xXjlp6Vl8PcVXwK5EtzkHgzUa7Xom9BsjG9ygFWBi3oHcjU/QOpGMsL/moxNwRjxryQk+nMcISBrIm0hwCQ70lyJVw0nQQb1MUJEOL5a3lEBNGmFC5NYkmf148VND30Op09XfslcJk3hHjOij0yX7wp0Z3VqtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ME47pIY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B913C433C7;
	Sun, 25 Feb 2024 00:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708819690;
	bh=a7/1igAT4PoxDcDNOgmtzoiaA0neM5ZGDNTfggTNBHU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ME47pIY3cmXh+XNazxyNGhuvGuwlrIADhH+l4e94zAb9w9ITCt3PBt9iqNYxIuiDc
	 SJBxollDEnviP7C2B6AL5VYcozKTYU4MRkUVtE72v68LdOsb4hUzCo/D748aqmSKI+
	 L+J1JyqnhPzeX87ABZhD4P1t7SJyADhiQhYAHidZ2qHyF252SY2GF0kCTEujljZYi8
	 4UWapzdwLJGxIpYTZoXJSjU9r/JZtlCpRxxdVTm7+kC7WBpp9LG4OS46COBodQAlKw
	 JfDwv2XYt/3IkWXwQfeg+FAB0G2Wbi1sIUUXaNrsuVt+DdoFrn0glf5NXENAu+ciK1
	 z88RkR1Hz9cXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 785E4C04E32;
	Sun, 25 Feb 2024 00:08:10 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.8-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <65da4a4392d41_2bce929471@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <65da4a4392d41_2bce929471@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <65da4a4392d41_2bce929471@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.8-rc6
X-PR-Tracked-Commit-Id: 5c6224bfabbf7f3e491c51ab50fd2c6f92ba1141
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac389bc0ca56e1a2f92b2a17e58298390a3879a8
Message-Id: <170881969048.17738.7320871548796795724.pr-tracker-bot@kernel.org>
Date: Sun, 25 Feb 2024 00:08:10 +0000
To: Dan Williams <dan.j.williams@intel.com>
Cc: torvalds@linux-foundation.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 24 Feb 2024 11:57:55 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac389bc0ca56e1a2f92b2a17e58298390a3879a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

