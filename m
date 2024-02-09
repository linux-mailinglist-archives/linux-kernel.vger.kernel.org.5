Return-Path: <linux-kernel+bounces-59163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC2484F262
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9DB1F2368E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94D767A0E;
	Fri,  9 Feb 2024 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utvPrB0x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EC3679E2;
	Fri,  9 Feb 2024 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707471547; cv=none; b=mskUiEmouZjszCtjMLU1JCh1JI2t27dhQuj/wmjXzw5pdxM4R8bcXPqla9iQCvt2k+JEOPfgUJ0r9Y7Ptq5cRpz0TPiiAZqIHtZxKIZv/ygMhcRUPCVjzoDDlDv9Bj7rwgDOPqMts6kXsX/rm+WN7qWMEBOlRqhXrcAdh9YHdH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707471547; c=relaxed/simple;
	bh=6Z9tZX0qeO4mORKNEd7aiPw4VjFNllHVUaz0ZIl1MPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZj9JzHKwQ9O2w0BOJ4b6i5XY7FIwInZL+XEl+TXbP1B1LYpfqBG6p1Ts97wMrVGUcj6Y24WWyP+NgL4cd+IBaCUaTwKg3CAHLkAirEyB1vzUQvav8aZ5oIodN1Ij4NG5Wu7ewETIsXHv2tx6fyKTLWLT5YhmTRdoDCi9WEA6Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utvPrB0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBBEC433F1;
	Fri,  9 Feb 2024 09:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707471546;
	bh=6Z9tZX0qeO4mORKNEd7aiPw4VjFNllHVUaz0ZIl1MPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=utvPrB0xbZbKMMSJgm+IPXLnLWrygqGV6m018IZNpft4qsUGUDDxSusFmhP7QVDen
	 qKUd4d4IcmgFptMCfrCabLbz0eO70PPDjcFlRZAfhJWJsnlzZEnslRV9kcnGnRSTYU
	 X6gs6PC3wDF1idohqOADSjqyEqp2Dzq3lykisMXEoJ4TEMi2AL/v/Faykbty7Eb4zm
	 dy0F4/+OEvkhj1WMZF0CKH4lgjvGCWFCMfpOUgLRRsEKPXAT5rucMrgNPUzMNLlF5+
	 BcCFQqN1jU+ZKgr6FbKAeUXxk3vX3Wl672WTSLPOIRuIZy3TNGgQNa3YQpjJ7LwIHz
	 gWR/LOxIaO2tA==
From: Christian Brauner <brauner@kernel.org>
To: corbet@lwn.net,
	Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] docs: filesystems: fix typo in docs
Date: Fri,  9 Feb 2024 10:38:54 +0100
Message-ID: <20240209-objekt-wertbrief-78f8e50bc261@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208162032.109184-1-vincenzo.mezzela@gmail.com>
References: <20240208162032.109184-1-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056; i=brauner@kernel.org; h=from:subject:message-id; bh=6Z9tZX0qeO4mORKNEd7aiPw4VjFNllHVUaz0ZIl1MPc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQe/bQ5+ne6106Gnq1bd237NSk59vT/q6fXfTq8l8N08 tk+2cX/F3WUsjCIcTHIiimyOLSbhMst56nYbJSpATOHlQlkCAMXpwBMZMpDRoZTqaE7n1QLZtvt vH3LZ4Jgseze4tNMKufaHF2URRx+ZJkwMuzhuXxNl+kRa5zq25bjM9pOtzztkV39ufPAigm55fX pGxgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 08 Feb 2024 17:20:32 +0100, Vincenzo Mezzela wrote:
> This patch resolves a spelling error in the filesystem documentation.
> 
> It is submitted as part of my application to the "Linux Kernel Bug
> Fixing Spring Unpaid 2024" mentorship program of the Linux Kernel
> Foundation.
> 
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] docs: filesystems: fix typo in docs
      https://git.kernel.org/vfs/vfs/c/f1d1f00279f6

