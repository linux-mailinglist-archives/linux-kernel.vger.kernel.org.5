Return-Path: <linux-kernel+bounces-37609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD80583B283
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9667428737F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FE5133983;
	Wed, 24 Jan 2024 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4O7gtfe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA73133434;
	Wed, 24 Jan 2024 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125784; cv=none; b=ZLOdrZs0vPE+eHV2Znq6gnNKAluMaGtqTmY72Am/abno3nNQRcqqUoyYmwwSLpQymS+92uwu4VL6wuCZv69jpsWssOMucq6Gn3zWYgvXm0IZ8q7jax7pIFF2+Bw/kAX+Y/6JteMrbxlg3Z1B0lKi5eIT3yBeA6Ktf2q1UfIQ5Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125784; c=relaxed/simple;
	bh=VBDeXV//B1Ygl8IacY4kMW66YLU6vLMeG9D2ddbaCXg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hk+ZKYzCF3JBQEU9RKIidtFC3mBSubtlApaVBjC4LXp0bqaA/tDenBf0XX+93KIegouK5TpN8+VUBxXnVusQQ6ks321hT1G+iWxGZw+9Zudo17hlz2Wp16zdFXLhlVYfHRXVzYAqSUiRM0XsBGdE2fAm4DjGiPsYJoXhxLFw4ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4O7gtfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E52BEC43399;
	Wed, 24 Jan 2024 19:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706125783;
	bh=VBDeXV//B1Ygl8IacY4kMW66YLU6vLMeG9D2ddbaCXg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=o4O7gtfezGf/bN44nuF1YJphJTRqA5fVlq7DTfbCJ2MXehbEutu2EooHu+qbn8oh1
	 xxlj6oWo9H5jHuMa9667+23LYue2EePSEobhhfdEGPt4gWb4LhRfboJWqzSvxrvUg6
	 TFbDc6aF36OZbgut4ny593gpdnoeeKN2DYT7UFQnf637W0cTG1G7dhpwl7CGQR7DIZ
	 P7Ym6sG9PxlDwfK/wuGnXKTF25NCOIzB8jahWBApgpLbYqUyLQYvoJYfjcg2jW378Q
	 5Cc5uR2z3EwLOKNtJZcue3tbBwycGa6Tmj+KKvUckRfGbFlSagyAD6Bgxw4psUUDN/
	 6pQTcn+4ZdD8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDC3EDFF767;
	Wed, 24 Jan 2024 19:49:43 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fix for v6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZbE2t9LoFlro7J-H@carbonx1>
References: <ZbE2t9LoFlro7J-H@carbonx1>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <ZbE2t9LoFlro7J-H@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.8-rc2
X-PR-Tracked-Commit-Id: 4b088005c897a62fe98f70ab69687706cb2fad3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1110ebe058268b5425c69a23a99456f2331063bf
Message-Id: <170612578383.9426.13921726820598469749.pr-tracker-bot@kernel.org>
Date: Wed, 24 Jan 2024 19:49:43 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Jan 2024 17:11:35 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1110ebe058268b5425c69a23a99456f2331063bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

