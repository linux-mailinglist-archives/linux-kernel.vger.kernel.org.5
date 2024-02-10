Return-Path: <linux-kernel+bounces-60206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AFF85016E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6DC1C21E3F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2652114;
	Sat, 10 Feb 2024 01:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsDg4uFW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE6D1FB3;
	Sat, 10 Feb 2024 01:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707527718; cv=none; b=d7zcmqQMefr41/I4sQXlTb2Glx2DvnqZxfC0EXaRjV4dPdAv/L3VrcKoUf392jJnH524atmDKGx9LJsmmpaVhqy7qNYPYJHDj6d7WJ9L0u8S11mCi2XaJNCCDYBoby92kX7PGC1hEE82UCJYPWcp7xLD+ILAMihzXPEwnvoWzgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707527718; c=relaxed/simple;
	bh=uFPo81DgkRUHjn14bWQCuQk8BgIXflkmYdcw7jFZkPY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W8GTGS9p4IEkW4XMtlxKecy6cSdUCPgpfM/HbIe1HwN39TKVI6e8olOD9GH4ip1Kn34EG7PuMsaUuS7BTtPr2JZX5y6qlOl9a/KYJ7ucyomDhrJa1UjtS7zBWm2r3dQRcRFs7rt8kOomy4RAz/qh8TFoo0LBV+0dCCR/jeeZoV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsDg4uFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38746C433F1;
	Sat, 10 Feb 2024 01:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707527718;
	bh=uFPo81DgkRUHjn14bWQCuQk8BgIXflkmYdcw7jFZkPY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fsDg4uFW3JZWNVMo5IA5Q2+GJJzoiGFI2yKErBNKdP7QNn6w8nxOnGO47lTV3ohWe
	 pnfDvdkN4jLC00n9DrhcYTVlqrGQlVA3Pog/d6InqItXWlhkvs0rRsenOTVS+GhjNZ
	 Pgij++d4lVuRTTPyLRzVtcJDippAtRLKXEy4Vd5L32aAiWWpYQceTphzAD9zfRIb+D
	 lucfrTejkO+7HHR0yPHBhnMENl7P8HGEGuGFxX+h2AoLe/zqS18NzrkCqUQsgDxOTD
	 0S8PYn5ZfHfdNlDvZ0JodkMoZhSsbYKL03EVSHn3AL9MZxMhaw6FwBl/8oK21R7wW6
	 JxlB4JH95nBjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 253B4E2F2FC;
	Sat, 10 Feb 2024 01:15:18 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240209153458.1741231-1-idryomov@gmail.com>
References: <20240209153458.1741231-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240209153458.1741231-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.8-rc4
X-PR-Tracked-Commit-Id: 07045648c07c5632e0dfd5ce084d3cd0cec0258a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1e3f530a17f808c70f506f11ba7dabbfd8eb14a
Message-Id: <170752771814.5962.7558478798452493618.pr-tracker-bot@kernel.org>
Date: Sat, 10 Feb 2024 01:15:18 +0000
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  9 Feb 2024 16:34:57 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1e3f530a17f808c70f506f11ba7dabbfd8eb14a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

