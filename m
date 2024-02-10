Return-Path: <linux-kernel+bounces-60452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E0C85051F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556991F2216E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376265C5F0;
	Sat, 10 Feb 2024 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADV4CZ3I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7805BAF6;
	Sat, 10 Feb 2024 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707582372; cv=none; b=cXA17c7znKeGsaTMrC+gy3E4ENm8i3fbqjzWCRmga375VCl7TfTAD9NDvfFhd6nr/g+OGdePDVZt55Tj+ALUOfGxfXL0H1KmtriYtq5BM0Ei0jig9UDArv733jVG2ST4Se7sJ1q8p7nprLETMYmwq9sYlh3UHfW5A2UkREF47f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707582372; c=relaxed/simple;
	bh=F4CzGC9B27b7GO6X/MD/XHVPsyeN5xCCXUH/5q5zw2g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hunc0IJz7fyc7fOCSuOrPDyUWfTh9MM9YTEtKFOrwqkDZp1BTICmLXASv/YJKYSvFGhYJ6xqCf9R12RecvtGA5H+bdUgFPdCn3U3DKgj63XlsFN3eLRwhvdoWuCDwo9IhFwlNmYG0UEPi9TkX9JQUTMnLf71N3u7ij0seaELgb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADV4CZ3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A75BC433F1;
	Sat, 10 Feb 2024 16:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707582372;
	bh=F4CzGC9B27b7GO6X/MD/XHVPsyeN5xCCXUH/5q5zw2g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ADV4CZ3I1um22KIdG2Ku4GiS70QZVk60C2gOL/13JNRaLrq0omUfXAXuhSZM5CwbG
	 i8on+AhrIGuenAGlWpGc09rKewiqToxTd3sLKSCxSUA3SaXUGc4iV/45rYxoJ1BVt/
	 WP3g+hYFLYd60ZJpJ1cvIgq8ZVZIRjSQ+gph+TM1UebvlvpqySAbb6Gdw3Og4p2Zmv
	 TsTCfb0F8pd8IhBIsWNGQ8U7nKhQbsOXbWbZTf0r2d+MoVr2MK7KzkgZ67vVhOiCP4
	 PwegrvCFE173Pn1UE6l3uJSBD53+D1d3JVhYlYbMsqkDWfb6vb/8SpCK7ce476Uy/k
	 x9HLamSHvibig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27B43E2F2F0;
	Sat, 10 Feb 2024 16:26:12 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtdu3ng8E7e3h5iLYA+hcMQNjF+iwiAzh3xNw1dTnBydQ@mail.gmail.com>
References: <CAH2r5mtdu3ng8E7e3h5iLYA+hcMQNjF+iwiAzh3xNw1dTnBydQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtdu3ng8E7e3h5iLYA+hcMQNjF+iwiAzh3xNw1dTnBydQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.8-rc3-ksmbd-server-fixes
X-PR-Tracked-Commit-Id: 108a020c64434fed4b69762879d78cd24088b4c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a7ec87063c0fbb7706fdccb0cc890757da6f4a1
Message-Id: <170758237214.1913.6316302817273858424.pr-tracker-bot@kernel.org>
Date: Sat, 10 Feb 2024 16:26:12 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, CIFS <linux-cifs@vger.kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 9 Feb 2024 19:45:31 -0600:

> git://git.samba.org/ksmbd.git tags/6.8-rc3-ksmbd-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a7ec87063c0fbb7706fdccb0cc890757da6f4a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

