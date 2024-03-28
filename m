Return-Path: <linux-kernel+bounces-122362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E30EF88F5A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C52B29BDC1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65719219F0;
	Thu, 28 Mar 2024 02:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U49nNjXS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80FF101D0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711594784; cv=none; b=lh7wPLkAEu3bw66EVrIdPedFb53XInyQt3EUZyh5vguArZ+tf48OEbtL4kMYjrlaUbnMsau1xawD0kHtOjJELa+CKUgg37FxtjOkoygZF1OlFzFOvPl2oqWEsIKFO17jeDKdib2gPskhhD0OZmVDmGKCG7N3ACSl4Uvzcp9Avmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711594784; c=relaxed/simple;
	bh=VVeP8CTtDe8h8jUy8vlnsdIeVmc+EAfEED4o1DOv/O0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpjetO51fjQ31AvOvNoaDdFirZf8LTA9GqmfsGctWX9ACz0LXLVZ5EsCuk4wz2jzQyydseHXJP4Hzx/mZ2GhmHZSk/bAX3YzeFGFo9KdNzXs7oNFhxSRAxiqlimUIyrvsxXPRywCpyIQfaOynqnUWlht7cNKGI21eUpns+P+Be4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U49nNjXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4822EC433F1;
	Thu, 28 Mar 2024 02:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711594784;
	bh=VVeP8CTtDe8h8jUy8vlnsdIeVmc+EAfEED4o1DOv/O0=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=U49nNjXSPd08fEh9AsFsgFIJj2L0IJbrFeCFPSfKLki48JngA0t+vQA+3d8+QD8n9
	 7cXfgUOuZnjlJjaFrfe+oszypbyz3xLZHdQqKSIhkAFVjCeOVf2mznwg//Ja5DRm0I
	 Ca9IGXux5W1SSCgPs3G4uaOI13yBdxr+JAmJF6Xvl4LGK6Z3DQNNG6e64Aib4uiuT5
	 mLVAhVZTqCQTfg+/Mdz/OOV0rjhL2G7m9VRoIABzlhoiktXgBA47k67A74skUEgxz0
	 uSyQm0toAAQr6dymYDFKA/RSYUcs6tfqpYxNdXqCm6ThxbFECB6z+o3Eux69ESs4PH
	 fUpvAUWIjRMhQ==
Date: Thu, 28 Mar 2024 10:59:38 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Sandeep Dhavale <dhavale@google.com>, Chao Yu <chao@kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, Yue Hu <zbestahu@gmail.com>
Subject: Re: [GIT PULL] erofs fixes for 6.9-rc2
Message-ID: <ZgTdGoyTyCc+CrfL@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linuxfoundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Sandeep Dhavale <dhavale@google.com>, Chao Yu <chao@kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, Yue Hu <zbestahu@gmail.com>
References: <ZgTb62/wsjacMpC8@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZgTb62/wsjacMpC8@debian>

Hi Linus,

Sorry about missing a title due to my careless.  My apologizes...

On Thu, Mar 28, 2024 at 10:54:40AM +0800, Gao Xiang wrote:
> Could you consider this pull request for 6.9-rc2?
> 
> Just two minor informative patches.  One adds Sandeep Dhavale as a new
> reviewer who could help review some patches for EROFS filesystem
> project, and we believe the project itself will become more diverse and
> healthier as long as warm-hearted folks take a bit more time on this.
> 
> The other patch drops experimental warning for FSDAX since it's already
> used for memory sharing between hosts and guests.
> 
> All commits have been in -next and no potential merge conflict is
> observed.
> 
> Thanks,
> Gao Xiang
> 
> The following changes since commit 4cece764965020c22cff7665b18a012006359095:
> 
>   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.9-rc2-fixes
> 
> for you to fetch changes up to 7557d296ad439f66a87cd34917af2a4172517826:
> 
>   MAINTAINERS: erofs: add myself as reviewer (2024-03-25 10:57:28 +0800)
> 
> ----------------------------------------------------------------
> Changes since last update:
> 
>  - Add a new reviewer Sandeep Dhavale to build a healthier community;
> 
>  - Drop experimental warning for FSDAX.
> 
> ----------------------------------------------------------------
> Gao Xiang (1):
>       erofs: drop experimental warning for FSDAX
> 
> Sandeep Dhavale (1):
>       MAINTAINERS: erofs: add myself as reviewer
> 
>  MAINTAINERS      | 1 +
>  fs/erofs/super.c | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)

