Return-Path: <linux-kernel+bounces-66376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2196A855BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86381F24CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921D81118A;
	Thu, 15 Feb 2024 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qajf8PZ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2C8DDC4;
	Thu, 15 Feb 2024 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707983332; cv=none; b=N3NaItBFVPEjBfiz9GmFvvwrqNAzOXkzDRR3qm5m01IxzdCVFtc0AMYJHPATUusqvYvyjYluWFbxFMznzMhLb+OzRTURJk9jEjbn/pSvNoxGVXZQcBhfD+nchXLX3vH2bMbLaLaFP6oFS/rcHP9hTJq4XThxkEFl/nMc9qXARzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707983332; c=relaxed/simple;
	bh=gahLnnsNTqmUik4SdEeXvaqgZ4vCmG45RsllVXdj/mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKinLW2EWvU9GUsFMTzx2fgn3qCqwnNJN3HUcyaHa+lbPr2qperjTnzFYVVidwsKA+1FDxXZcchSdJkrrRoV+vEfo6En7vQ79IjYM77pSB2qkedg7t2YmZPiQaFMkGMoYqgNyq4TCUXqdmqQpGV6uE5Ytoeq8cL/jIgMUAva+Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qajf8PZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6981C433C7;
	Thu, 15 Feb 2024 07:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707983332;
	bh=gahLnnsNTqmUik4SdEeXvaqgZ4vCmG45RsllVXdj/mE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qajf8PZ65kKGyotnqyIUZ3vlSkpstKVFTdqCpNtt11yZc3WQx0TBIeEixG38eBjtF
	 dQqDmJTsG/G5wsnuGVF8KapV2qoQO5WOO8TzkkTkg7Dn5t3dStmcx0CXS5nF0PGms9
	 s3OFz8TRzd2nuSJQYkDvFpQtkCeofc/Pulf3+EIQ=
Date: Thu, 15 Feb 2024 08:48:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ALSA: struct bus_type cleanup
Message-ID: <2024021539-boxcar-shown-c829@gregkh>
References: <20240214-bus_cleanup-alsa-v1-0-8fedbb4afa94@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-bus_cleanup-alsa-v1-0-8fedbb4afa94@marliere.net>

On Wed, Feb 14, 2024 at 04:28:27PM -0300, Ricardo B. Marliere wrote:
> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]).
> 
> ---
> [1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
> 
> To: Johannes Berg <johannes@sipsolutions.net>
> To: Jaroslav Kysela <perex@perex.cz>
> To: Takashi Iwai <tiwai@suse.com>
> Cc:  <linuxppc-dev@lists.ozlabs.org>
> Cc:  <alsa-devel@alsa-project.org>
> Cc:  <linux-sound@vger.kernel.org>
> Cc:  <linux-kernel@vger.kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

