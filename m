Return-Path: <linux-kernel+bounces-56580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E7A84CBE9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCFF91C21A34
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB7377F0E;
	Wed,  7 Feb 2024 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c/iJ5n9y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0474617BDD;
	Wed,  7 Feb 2024 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313710; cv=none; b=Ei3MArygawOrk51JtgBM2goqaEw6e4FYGhKzlXQGNsGmGFGobhk7mZ16Civ/FotRSzoXnRqBg6bzoI4uIZHkA5mq4HFwnl7E7OC6gLctOEKG3nfvnF/buhMW3nXCB9d2i7SgwtAwbeGOVQHvhDCA+4U+8vanJdaCFKfCxKScdAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313710; c=relaxed/simple;
	bh=LmYzeNQgT/9+MELH1VLfosTX85cvpxu2g3dpE1NbMeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfyCeCfsN8WE00vfVJzRT1DzTj0GBftWyeIFSMc7FBRk/c7kFZL5mZewMBMIm9YCUbBavjbMlUgctunel4Da/ant45FGiUd+205vRne6ktyA3C/5uY5WdY26Pwosq12kJ0oTDkBWPeW1OhOTrqDi261T2RHlrCUbAsYRV4d+WEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c/iJ5n9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16911C433F1;
	Wed,  7 Feb 2024 13:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707313709;
	bh=LmYzeNQgT/9+MELH1VLfosTX85cvpxu2g3dpE1NbMeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/iJ5n9yrL294ArOKsWf3zMo5VALpEd/XMF8aBj0G3LHuPoGQaUEoOe+UCmgpnwqW
	 Ql8FWbQiJIdM14KJ5hGQZpUwfnM2TyCnqS3g1/g6hRhaZW3BMeLN+1+NiM0MDVNym1
	 Avq7TEgOHGGt6/Mkz+MN9xc2Ov3nFg6FcqEv/ElM=
Date: Wed, 7 Feb 2024 13:48:25 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fixes for 6.8-rc
Message-ID: <2024020716-subtotal-quack-1c08@gregkh>
References: <20240207131905.2355454-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207131905.2355454-1-djakov@kernel.org>

On Wed, Feb 07, 2024 at 03:19:05PM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> This pull request brings in some oneliner fixes for the current cycle. The
> details are in the signed tag as usual. All patches have been in linux-next
> for a few days now. Please pull into char-misc-linus when you get a chance.
> 
> Thanks,
> Georgi
> 
> 
> The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:
> 
>   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.8-rc4

Pulled and pushed out, thanks.

greg k-h

