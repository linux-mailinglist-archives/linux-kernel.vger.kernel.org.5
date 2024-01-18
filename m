Return-Path: <linux-kernel+bounces-29567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8030A83104E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FA9BB228A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13F6138A;
	Thu, 18 Jan 2024 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zps9R2uR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E288635;
	Thu, 18 Jan 2024 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536309; cv=none; b=Gd3H5JVLdtn56UrNQ/6mKP0lsldTZJ7po6IJRDakIwYr1YoSU5/Y4GejD+P8BTNnXROfwx949yWWyjCxqJ+fpTgd3ifzfy4peXH2gRaG9q6s/GQcvCF2kjLWEgOc7SN738z8v1zYC0ETIH5nNaHXmJ5pr6C5mrJfeXkP1kUpmwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536309; c=relaxed/simple;
	bh=mWIm52Ioes8B7vGq/p5QF8a8ot6j61tAifgfacbfSvQ=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=f0IwE6h/zfiyV7IH9Zliz+RFBM9NXIKbMtU6/+ofDONpO1vIuLaNPa97K6RwnGiNf1h2/7kpc9L8bdbHFGm5xPrbCFy4XWUSIbTI/MzmB6ejbDmSnbRksiJX96evXgVnFtiY7VRJ5gqk9jYKyK9SCJBULPhtBGU31UoJF/sRvd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zps9R2uR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1773C43390;
	Thu, 18 Jan 2024 00:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705536309;
	bh=mWIm52Ioes8B7vGq/p5QF8a8ot6j61tAifgfacbfSvQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Zps9R2uRwTTDPouXpLq1kg0q9bWhlnvR5+pK3yRPwxdRKTD0WpH/kAGNsuq0274fZ
	 SiOK3S+XQM8YabNd9d9TH1bJBJ4fo4rDpG6Eaax9auemIa90f96YfMToSxmD2bkyEt
	 Kpx6p2KD1IwSAuWFITYLEXGVRfbP8mUwln2kzL5TrPWdKhAN+rqQf/JvuIcqLy5nhc
	 DdnNpedLO2pXrp0uuKD2pESeSFq20GOB5ZQcTYIjEY5+GgSfLGZKJtGWUUcucEhS1F
	 wI6NSfSWWfAOAHjxGFRQI2rl9cNkO0RFl+rhLOoOKU6kkJVWfwo846RmAiGaCQBoke
	 7adGtruxEvb3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD8CAD8C96C;
	Thu, 18 Jan 2024 00:05:08 +0000 (UTC)
Subject: Re: [GIT PULL] rpmsg updates for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240115032444.155078-1-andersson@kernel.org>
References: <20240115032444.155078-1-andersson@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240115032444.155078-1-andersson@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v6.8
X-PR-Tracked-Commit-Id: d5362c37e1f8a40096452fc201c30e705750e687
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a43434675b2114e8f909a5039cc421d35d35ce9
Message-Id: <170553630890.10877.17464444654151711503.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 00:05:08 +0000
To: Bjorn Andersson <andersson@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, Adrien Leravat <adrien.leravat@gmail.com>, Xiaolei Wang <xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Jan 2024 19:24:43 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a43434675b2114e8f909a5039cc421d35d35ce9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

