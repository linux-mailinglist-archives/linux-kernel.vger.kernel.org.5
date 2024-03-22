Return-Path: <linux-kernel+bounces-111984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B2A8873B3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA2F1C2293B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D3078662;
	Fri, 22 Mar 2024 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MNj6cquW"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FC578292
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 19:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711134937; cv=none; b=hmWzZKtjxOT6Irn1zfKnV+/9p+izFmLve2d17O895hcxwMKERmn4yNlK8DDwNgpXqWl+rAG5De4jIR6yD+QGYL5pPGloVwDoyl1r42J+NnSwQyQiHuLJ/3+fNIyzfwu9Kdq/Cvi3tRaldRTxp/SA8UOdiQi2T5s2OrJORzVu73A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711134937; c=relaxed/simple;
	bh=E0AOE6x7BdZSspP6SFS/1zSO/pGH2f/Jn/mkKOI6V7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=am+Vq8AlI4LHIG1BRTDkxOuuhDIPas4jIh8U/9L7DcbiCpmx8u2xpohOzatMrqH2ls+xq7nP8cgI0qW+HLfaTYLeypRVTAZwRSGSVbeyL2tx0RmV8X17JVhNxXDKNRM0Nj54PrvN+ncqEtEBhzCXFeZN277KH9m6jdI9GGoHr+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MNj6cquW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4435D40E016C;
	Fri, 22 Mar 2024 19:15:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XtzQjmI6Pxjl; Fri, 22 Mar 2024 19:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711134927; bh=XY1qK0RPfISjDOYxE9MPGjKiZuZ6KrXG25tEVQFhClo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MNj6cquWJHv1Jb9+IbTGUwP3YQlLbBrjIeZxJuEWnuzCNZtm0rmdqKJP/LPlfpdYS
	 uyUEbq36YufHCn+yC/9eS/D8AjU0+nzpuOtho8ALjXUIWcVy6boxb2toNRUKJBO9vF
	 SUQsDiCjQ8Hqn+mK/ABo6sU4k19wE60/E2DHv8QuyyumK2qHpSph6TZsiWQAnRNcVA
	 AOW31d+Z7HMb00f4B/Xl6ayJ/b22/W8V0Wvb97WAb6sdia0XVGYB+pdVpVXSn08Yzc
	 07tLs19NsIL/lSAq127xFWPB1GKQp6pS1E33+/XHcCd0+AHgg0dgB1PxN2kBOPipzk
	 8zHlltaxS6mJD3OOz7UHPunzhPDxoa75dtrltI0UEoR+zsapHaP5fdbf33GUs0DIlu
	 7YuaBHptrqpKDW+Tfl1xu+viaGKhOrDgLB9k+JYYx01t9YQ1qSGdrbHksqcnH3EbVl
	 3OGI563eC0IBjS/xBH06LsFsT/CQrguAPi0njUZK5S0qJES4U3oqevTyOFZBL70RAV
	 5xf5QL7oLMD0ZDuFGN9iFUXlvuD0upE78HHHHHVuv5hao4t60tZAYsZlcK6EQQLjl8
	 Eb1EP7zEzEC453sfiWu2Py8C24axt4cZHFTGMmv/kLq8sD6lWZ0MP9ilbNAkv3EBJ+
	 B03ZNhsi8YGJ++D6VEIFxRzU=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8FE9740E0140;
	Fri, 22 Mar 2024 19:15:24 +0000 (UTC)
Date: Fri, 22 Mar 2024 20:15:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] Documentation/maintainer-tip: Clarify merge window policy
Message-ID: <20240322191517.GBZf3YxTYYYXATtl0w@fat_crate.local>
References: <20240322183403.67BAEEFE@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240322183403.67BAEEFE@davehans-spike.ostc.intel.com>

On Fri, Mar 22, 2024 at 11:34:03AM -0700, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> There are lots of maintainers "pings" during the merge window, even
> for trivial patches.
> 
> Clarify that contributors should not expect progress on *any*
> non-urgent patches during the merge window.  This applies to all
> contributions, not just large ones.
> 
> Clarify the language around -rc1.  Trees really are closed during the
> merge window.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
> 
>  b/Documentation/process/maintainer-tip.rst |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

