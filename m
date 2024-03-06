Return-Path: <linux-kernel+bounces-94015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D72B873850
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43023284ADC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA861353E4;
	Wed,  6 Mar 2024 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qNMWEppk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E5132C1A;
	Wed,  6 Mar 2024 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733859; cv=none; b=Os0xETI6jYBjGg/FR27hpg2xydJvFFj9XXssmyviwZDqoJ7xzssoR32C+wsnGSQQjImqT+iOACJY+OkVjSgEhVcAKzIuLek2bdjDGrn9dZKQYGM4PE00iegNeiynaj37X67juD/luryEJCHy95j9muF82LjztiENIqzDI1eI2qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733859; c=relaxed/simple;
	bh=T6CE373exE9I+zoaK7rtBSeyqI9Srim5i65zAuzn18c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELNejZme1jEdOh+s/vVBqtlRgfS4B8phTTdOBLfyJyXrDFDf9qc8NjX1FrP6rjJk71FN8JOhllv+YBgq2Cwsv+w+26NuxsZ31FbvEJ1HgcTaEqG9RB0UG7PSerRZpyVFDA24t5W//5kt+h6/U27x0Vb+32a+uEqemOetbAT7vZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qNMWEppk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A956C433C7;
	Wed,  6 Mar 2024 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709733858;
	bh=T6CE373exE9I+zoaK7rtBSeyqI9Srim5i65zAuzn18c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qNMWEppk6OBA+JuUwI2Ymj2ToSAXLxLg1fa7f7t7NdfE7IcaLcdNKP8zSIZ4CdNi2
	 LK94Gw48nBz2p8cg5kkD71rqvdql5tZXvw5sdzdbGRxYjOzIcgEKaciCh2400Mndm0
	 Pkyl0o7RmKJzqEKBGhHeFotNhBBzNvlfkKAx8w7w=
Date: Wed, 6 Mar 2024 14:04:14 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 6.9
Message-ID: <2024030606-shorter-carve-fcb4@gregkh>
References: <20240306135516.510557-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306135516.510557-1-djakov@kernel.org>

On Wed, Mar 06, 2024 at 03:55:16PM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the v6.9-rc1 merge
> window. It contains new drivers and clean-ups. As always, the summary is
> in the signed tag.
> 
> All patches have been in linux-next for a week with no reported issues.
> Please pull into char-misc-next when possible.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:
> 
>   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.9-rc1

Pulled and pushed out, thanks.

greg k-h

