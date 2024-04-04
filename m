Return-Path: <linux-kernel+bounces-131983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A51898E3A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60B51C21625
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3871311B4;
	Thu,  4 Apr 2024 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3FVrRAz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C06E208A7;
	Thu,  4 Apr 2024 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712256415; cv=none; b=Bwtx010IpVHEtPro+4AJH5k3/lcG2rLcdZg1jBfqUXf5nQD2/chrYkjYzRVAgSiSlJQRBFTTblLGkjt8hWuKrUdmnXG4UlUzX03aOqdOBEzgpTiClKhhZ8xqdKUkMDp4s33SMfB4Z/vTn3q6s+1fT7hUUzZC5RPhJgg92WKEI2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712256415; c=relaxed/simple;
	bh=wRlh0tNx3jmAg/ri9YiEsNL/NfVDxoKxFALDXE9p3HA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IRQJmbRu7kMwUyRK955TKZNbXarz+/E8mqalL+LQS7zaQKJp8TaPK8tA1PPfs16eYiodx0FIdXZ3mBLNlo3hgpswedg2Uo/hLMnpXM4P0FkoC/JoEyAY8JCnAOBvXTRRqrUcXIjEyE53clte9lAa+GLezW8d6ycSSZcsuK0E6+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3FVrRAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24DEC433C7;
	Thu,  4 Apr 2024 18:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712256415;
	bh=wRlh0tNx3jmAg/ri9YiEsNL/NfVDxoKxFALDXE9p3HA=;
	h=Date:From:To:Cc:Subject:From;
	b=V3FVrRAzOgbjdU3n/Hpip3UHYQlhIvp8LJK/gjeB5i5b5TKRU3/jDebdVSnTSw3/q
	 pd7c2GjGIg5UZe9bxwO7Tyh5CUH6DH8fIbHUX14Z6tt41BgTc6jTGNsTT6lINQuFKz
	 u7WBp51iqt4Z45dn8oVl9YRbhwyv1ciBBVCFiTYgUOnhW8f8KPJUyEiMgBxG8NpSbJ
	 hulZ6HxUMxpNZNpnfoNOxd23Q90q7tABOnf1bEGUo6eDe0lauK38Czod+kuz/8gtuB
	 2BG3BHglEeq+k7UYjLsfe4Tijj9i26hOIIUIEyX1KDmwMyRS9l0MGiwPbT5wx975cj
	 MvdYYjceODBmQ==
Date: Thu, 4 Apr 2024 11:46:53 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: conor@kernel.org, ojeda@kernel.org
Subject: Prebuilt LLVM 18.1.3
Message-ID: <20240404184653.GA3299356@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 18.1.3 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the 18.x
series is no longer supported.

Cheers,
Nathan

