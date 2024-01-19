Return-Path: <linux-kernel+bounces-30680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E898322F2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BF828603C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273941FA6;
	Fri, 19 Jan 2024 01:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnq/4Pi3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA5A1391
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 01:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705627491; cv=none; b=CZd4rq5Qm02rdeEZu1+h9WNP2ptb4bscHQdllDWeG+kHohTX4qdNt8gQ5EGJrbSKhxbLrAxWTEbrEk4L5pmfxBZ4hgNBm0bF3ocmY4wRs7JowPwvJaT4Jfp+k+5K64X8RzGyBCa1vkOyl1pT0w9DjQ0g9IZNSqTKvUACEKpu9MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705627491; c=relaxed/simple;
	bh=XSRhg4YDqwPGZXYvTkrd/EFETn0p+ayF+2xG7kN1Yd4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pV4OhuvlZm1awVR+wdyz5KElN2sq6JJXk7QmiJQa85QRmbhwgafZWTtL8P0mCB7u1Kf+y6hGcnooFrESBeiP7IgjJjSuNSy2PhxcbhGCk7BjPhnxQIF3Kjn4oRiGmLntOHwW3Hl/pUECboRIeRpANdnJEhpkC/SqcXnxesJ+77Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnq/4Pi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4237DC43394;
	Fri, 19 Jan 2024 01:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705627491;
	bh=XSRhg4YDqwPGZXYvTkrd/EFETn0p+ayF+2xG7kN1Yd4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lnq/4Pi38W4xrqr5JLKX5m5U+mrJ+6ZO/To2PRy3EgRzQQzA+RAH9iK5eHjNVhkQB
	 gCKjrhcULbZPDIy6AF33YXjpbNrR/vrFPRusfomjL/RqkVS2mVJIG2aJjC7sRqJm8l
	 xx9miCC7i9t1mwcuSzG/B79Nfzr6Jd0yEamh5ECMGt0s5xq6oGzypnsx/tL3S8KSIe
	 bJWVrdKdZR87OctHYmiQaUmmT0AfJ/wsekTBp7mnTLMDRwLhNJwPNdJCHI9+NK0R4n
	 2zMBDlY8V2nRN/k6fi16u8N+iK0QWqDdLmT23vG9aDUMmPRDb6MZE7lN7HrbQyqzR2
	 6hqvjgoqt8I0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 270B7D8C976;
	Fri, 19 Jan 2024 01:24:51 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy updates for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZalbG7hfGcZ0USyt@matsya>
References: <ZalbG7hfGcZ0USyt@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZalbG7hfGcZ0USyt@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.8
X-PR-Tracked-Commit-Id: 2029e71482fcd94dcc7df2c66c7fa635479748bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33a9caa49938eff19a3cc5ffab195649d702540b
Message-Id: <170562749115.26879.414017865955493610.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 01:24:51 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jan 2024 22:38:43 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33a9caa49938eff19a3cc5ffab195649d702540b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

