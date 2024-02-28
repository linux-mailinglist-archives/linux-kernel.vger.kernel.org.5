Return-Path: <linux-kernel+bounces-84473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BA486A72F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98237B2BB5C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A627A200B7;
	Wed, 28 Feb 2024 03:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8MbCwHS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4FD1EEE3;
	Wed, 28 Feb 2024 03:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709090788; cv=none; b=QtckRhs1FdfraanXw0OQpsALMJE7fxgGMw4rsJnJI5Q87Jc0c6vWhpm64yLfBhNb0JXDa5VUSUZV7nvBfxzVLzuu2DknjX2YgJ4H/NQ2D9gwEqys0ZT8PaA0H1Mn3mvK0m2ZJ5Gkct8ZdjnbI0T7cRN8Zol7KEz8FfTa4F1nbAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709090788; c=relaxed/simple;
	bh=cSJTkkdvJj/nLPtpZZE1yeAyrpa5hIWO/1KdPbZU39U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=r7zH4GX3kGMoXXIpQ5stZF8NHlpaoKi+P0dUddCKiPXot/q5kLUQ94fET7ZtXziVrNFwLgKjwJGd3QMWkAI37zyUmwTqAvIJg5gw6BVkCfV9+gHSVDJLzpNMIy5zlNiP7aotXqDQlRC8pFnkSBJSb2r6pB4q6rPd82y3t9hFGAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8MbCwHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7A4C433C7;
	Wed, 28 Feb 2024 03:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709090787;
	bh=cSJTkkdvJj/nLPtpZZE1yeAyrpa5hIWO/1KdPbZU39U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=O8MbCwHSegvpu9mzWN0dRxKhj4w9cjX21Fla7Ui2V4iPhN6RHt2jSOvHt9MLOB8gO
	 NWgxrb/6M5PA8340wP+58rlkvtoDVwjK77GZDALnH3Fa594SPR3PoTVpK9BR7OccUw
	 5Cjmmr2BF7aDSe5Dl5RsnGK5x4QGVGiXh1fbKXWK54lax+KpgEftYXlWUi6vHQ2bgU
	 f3Co01rTGYdWJAEqgewEOJzwnLPgcKMNQTvewTa5ittZY5t3tcxs4ce05KxQpt29TP
	 m9oQg7CZxIIE3Dbf8XIJjDgXTqiyGGaAbhSDxggiUH/eijCGQJHjT6golL1tAQdIxY
	 LhvDDLwi78tSQ==
Date: Tue, 27 Feb 2024 19:26:26 -0800
From: Kees Cook <kees@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Kees Cook <keescook@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the kspp tree
User-Agent: K-9 Mail for Android
In-Reply-To: <20240228140252.6d4e5e85@canb.auug.org.au>
References: <20240228140252.6d4e5e85@canb.auug.org.au>
Message-ID: <31C7C387-221F-4FEA-887E-A262844EE9CB@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 27, 2024 7:02:52 PM PST, Stephen Rothwell <sfr@canb=2Eauug=2Eo=
rg=2Eau> wrote:
>Hi all,
>
>The following commit is also in the tip tree as a different commit
>(but the same patch):
>
>  2867ef32ce00 ("x86/vdso: Move vDSO to mmap region")
>
>This is commit
>
>  3c6539b4c177 ("x86/vdso: Move vDSO to mmap region")
>
>in the tip tree=2E

Thanks! I'll drop mine=2E

-Kees


--=20
Kees Cook

