Return-Path: <linux-kernel+bounces-40713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBD283E490
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C206E1C22864
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFB251017;
	Fri, 26 Jan 2024 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbStxWAj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C82535280
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306728; cv=none; b=UDtrOITu+2vMRGCas+OBB2Kq4Rn6kLCY5j90tMSGl6ourE0AZjHW/dZOX2DZMnM+I/p4VjLcuNx1MLDAgouLac/ic28a8oEXzKTuC+KDFPUQTM20esm7TFjAHXOuhMRQ3Gy79wNX4M688h/bIeoqvbqoOJCDnlH5teFUxqyTTDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306728; c=relaxed/simple;
	bh=4QvJW67oQuA5OWDAolrMvi4/GfUn9uzNIjv/lnapjzw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YBS8sYfUX5dHTbibYeS0sBbQPin/xE1NRG1DUXRTb4rmvZfhXm2eAvsdAQQDIqYBwkUrj4qCyQF3GlOT/tStLVZnEs+PvYCOTYey2d5N9g33AoiOZg2sMdiKXZ1WeVE4GirhK0lZmQ6+MgcE3EMVTZqhcKaRHwFeZa0kI35+rsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbStxWAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 040AEC433F1;
	Fri, 26 Jan 2024 22:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706306728;
	bh=4QvJW67oQuA5OWDAolrMvi4/GfUn9uzNIjv/lnapjzw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rbStxWAjrZo1Lwv7Jack3YVWAjQhCRvejif6phfOYlvRj8nbbscIMMSqhSeHZ2CQb
	 M4Rnbey/Sg07qxC4pEI0hffNptBmNrChBdgNXXLgT6QWtxNwA1c5KhUJWzlnRB+AmX
	 /KOKb2I7Y5lTw1nKturNgvoiAAd+vGtB0tEAuytM1Otu5gnEi1lGig47eL6SmOYOdT
	 Zq2pgqrJOFx8ZsYZgnwpTl+RIEhVfs4GSo6T8AsCgCc9r/cF565Wd8KxYq+u8LrAIn
	 Du6NGlK8UvfQpvZ2SMQ/d6XRzHT97XtSkRKqRyNuaxnxNRonLdvCdz7dAhjRXvmYqD
	 RezYAHWlm8KkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5969DFF760;
	Fri, 26 Jan 2024 22:05:27 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzGRDXLt3NqDcmhZHU7i2hBsL3Xn_zsTpGfOdMJH5tH9w@mail.gmail.com>
References: <CAPM=9tzGRDXLt3NqDcmhZHU7i2hBsL3Xn_zsTpGfOdMJH5tH9w@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tzGRDXLt3NqDcmhZHU7i2hBsL3Xn_zsTpGfOdMJH5tH9w@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2024-01-27
X-PR-Tracked-Commit-Id: 987940f05735a960dd143214f7cc2d699885b625
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 168174d78157bba1315d5f8e1c66548b92c84ae9
Message-Id: <170630672792.20742.11197618829336878702.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jan 2024 22:05:27 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Jan 2024 04:56:27 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2024-01-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/168174d78157bba1315d5f8e1c66548b92c84ae9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

