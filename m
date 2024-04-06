Return-Path: <linux-kernel+bounces-134005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D05E89ABFC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6431C20D9E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFB23CF58;
	Sat,  6 Apr 2024 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeOZ113w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4832031D;
	Sat,  6 Apr 2024 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712420342; cv=none; b=G1evzS+02qIM+0FkShi9sCYBrcmAFzmGA3Iiu6tnwhBMneJuQJBnZnVOxbIjgsFnaS9Nl4HIo9OmS7VZtH3t/SScO2tEp1IvSGATP3tX6CaGz4dFl9VahBGLmxTqZZEuBJ07g/5VwfXsIRlzlcXa7ErAQ28M3r4GGOlEgU2nnSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712420342; c=relaxed/simple;
	bh=luE3wk9Sd7KTXEA/yt5pP2m7e0nBAAoS8yfAt/Q7oN4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=F26a906dy/mnSLtYfhncmxKnNZpkJvzP8b478UrR4GF9b0atVTMjl0/Kp+TnrDXFxW1RLpXknisNplCoig3kz99LBATMTZ4ZovmWCkl+6gh3NhvrnWXfW151LjK7YkLDNlkDC2BU61ZSj/nlhcwlu4TPqOFvmjCFpuXVjEMerhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeOZ113w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC9A9C433F1;
	Sat,  6 Apr 2024 16:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712420341;
	bh=luE3wk9Sd7KTXEA/yt5pP2m7e0nBAAoS8yfAt/Q7oN4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IeOZ113wLP1CAE7RQorI1h/qhASatfjnaXJPCbBUdmORCpYMXbj1A4fbmc5jrJ9fw
	 4fw0WavffLT5jZbq9fS8nIkFPvyoX8gcCdIjr6h/dCYBX5DzYi+Kjd5VrjmEZw4PhO
	 3H/JckSJnjjxKyCqB6w1Y40ei4JsnalhR8/eH8fpkDZoLhAEfKm1drcC7m2f7OVVBq
	 oKauVXHZBcZ3pQPRJOgzyZX7adGIa1p3yS0ibOiM0402ytkInr/CEd50v73QOoVm1Y
	 d+a4W13Jr4ioM2vpbGQ4Xohp7EzcL9ziZHffnWPhLyYtzFhxubNq/c6dj864w42fYT
	 zRt/e5FgZbEhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3A48D8A103;
	Sat,  6 Apr 2024 16:19:01 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5ms=TTjN5yoGsnEhrvqioM3pG6ANcTwsC8L1q833EPmMtQ@mail.gmail.com>
References: <CAH2r5ms=TTjN5yoGsnEhrvqioM3pG6ANcTwsC8L1q833EPmMtQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5ms=TTjN5yoGsnEhrvqioM3pG6ANcTwsC8L1q833EPmMtQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.9-rc2-smb3-client-fixes
X-PR-Tracked-Commit-Id: e0e50401cc3921c9eaf1b0e667db174519ea939f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 119c289409ddb9bca55074388f282ca67da67692
Message-Id: <171242034166.494.7220690827196807473.pr-tracker-bot@kernel.org>
Date: Sat, 06 Apr 2024 16:19:01 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 6 Apr 2024 00:08:19 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.9-rc2-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/119c289409ddb9bca55074388f282ca67da67692

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

