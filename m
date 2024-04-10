Return-Path: <linux-kernel+bounces-139300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDC98A0122
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641F71C23897
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E01A181B97;
	Wed, 10 Apr 2024 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVFyUjjM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10192E3FE;
	Wed, 10 Apr 2024 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780258; cv=none; b=OFnWFmaBqUfRRjDk0NjzopROZwDqNgeZlZaAR4aohMU47e4u5u9sZN629Kc90kSc+gD8QJQCugKZ5QYKFLFagLRe4LOB1vIv2+ZARkaQbETt4MoK/pRxlzmdRrvSnpx8xMYGPxUHKmirlKzHEW4CpIV3OWsSPG1HI3NMYPtQ/xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780258; c=relaxed/simple;
	bh=QcaA+Tks9qmzbBKV4bECFbXeuiKXKJL/4zcv8AAhf3I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JxYSMzegFqwb3vvdVUOToP3wmkqnHmhUjKgSL8ziUha0ezhaEVtC9hggVTgdMTs+rTDiNZVF5lVK8n+qEI95PSivb/c21V04/zh2k8B14XN4gNa1r2+liBMsDv9uXIUtv60UEP+h/SRsn/F01rzofOpXex/IuoocjnBVNworG7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVFyUjjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80E65C433F1;
	Wed, 10 Apr 2024 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712780258;
	bh=QcaA+Tks9qmzbBKV4bECFbXeuiKXKJL/4zcv8AAhf3I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EVFyUjjMTE4YFMresOMk3v7KPNaJdfCqp1epgaOj7ekg0rKeRe95f28nEDxrgPqUI
	 KGBy6D3R4VA4j+4BU2qSPJeaU9szL7RGJTq7dX5SmWwGfmIRwYbluiDKEsq+l6LAGR
	 pLbuJITNWYaS2OIurWQ9F/3kcKMwqV/XrUtpUJPPOOrZAZF7ax8IEyoMhmhyxBEYJp
	 s5CWfwbzumMvyU5ttdpQgFUOeff1hDdUrOjR/2+BrPIOHlvWfv6D3G94+i15PhlUET
	 VxR6ARPxLhGIqvcpkaACrOfVZ3wKjL1eo3J3yeKWDOXUNo20R1eC1aa2k8aqy2Picx
	 WYdvnF89nvMoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71456D6030E;
	Wed, 10 Apr 2024 20:17:38 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.9-2
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20240410114357-295477719@linux.intel.com>
References: <pdx86-pr-20240410114357-295477719@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20240410114357-295477719@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.9-2
X-PR-Tracked-Commit-Id: e71c8481692582c70cdfd0996c20cdcc71e425d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3679d9d1509ab7766f288cf4f70bea3f4c5cf193
Message-Id: <171278025845.11836.16290969028880881782.pr-tracker-bot@kernel.org>
Date: Wed, 10 Apr 2024 20:17:38 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Apr 2024 11:43:57 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.9-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3679d9d1509ab7766f288cf4f70bea3f4c5cf193

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

