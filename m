Return-Path: <linux-kernel+bounces-139787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0E88A07B9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1F21C22E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD28F13C832;
	Thu, 11 Apr 2024 05:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tqo4lJdA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F8213B2B8;
	Thu, 11 Apr 2024 05:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813384; cv=none; b=s0T0A6bhxL3zECxI1rgRDZAceVvgj8DN1oI42mWHjaiGJOQqi0jwCdCkpfoAAwd1DNDlnuA3hvEmwmetIWwyQBpjSj1GvmoTtD5itWMXa9S+dxfC4e3T8FyoIm6WzSqapg74a2ay7f1Q64hRfgAHgHlmVWyrUA2NdGYVr+VDqjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813384; c=relaxed/simple;
	bh=PJFU9fR//O/H4jsSHr8vSMOn39s5WbFra4aG/Bbnq80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bb0g9DyxC1csToT8muSEApOf1D+TLeJf7x81BjVL7ls2c2Nlko0YS49OgGCw9jpiO8/4yfQCut+6vJOk3u9I85xQGcJWBQIy3LunozR78CDLWQkcoMDAv9DfMQ7x5Ow3TY8RTR37T+cIXHl8G5Z0wfksRIbOYG44iMfuVQ0ujqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tqo4lJdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C83C433F1;
	Thu, 11 Apr 2024 05:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712813383;
	bh=PJFU9fR//O/H4jsSHr8vSMOn39s5WbFra4aG/Bbnq80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tqo4lJdADHrVDb8rDPsCRLz0vWwuoRkfbEjBQXH6q+LyLo8p00O2uCX2uAJ9CX/h5
	 tS2Me2MKmjFSeo06u900tXsfHggqfVYFoRN20sQIze2aleBcF+IY2cn7ixP953SV1o
	 xgn/kEW35c8EpF+dXmc6UZvdyhkLpE4G44vxOnyk=
Date: Thu, 11 Apr 2024 07:29:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] docs: stable-kernel-rules: mention "no
 semi-automatic backport"
Message-ID: <2024041156-backache-dolly-a420@gregkh>
References: <cover.1712812895.git.linux@leemhuis.info>
 <c0a08b160b286e8c98549eedb37404c6e784cf8a.1712812895.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0a08b160b286e8c98549eedb37404c6e784cf8a.1712812895.git.linux@leemhuis.info>

On Thu, Apr 11, 2024 at 07:25:04AM +0200, Thorsten Leemhuis wrote:
> Some developers deliberately steer clear of 'Fixes:' tags to prevent
> changes from being backported semi-automatically by the stable team.
> That somewhat undermines the reason for the existence of the Fixes: tag,
> hence point out there is an alternative to reach the same effect.
> 
> Link: https://lore.kernel.org/all/dfd87673-c581-4b4b-b37a-1cf5c817240d@leemhuis.info/
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/process/stable-kernel-rules.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
> index 7bb16d42a51833..ebd57cb9277f7b 100644
> --- a/Documentation/process/stable-kernel-rules.rst
> +++ b/Documentation/process/stable-kernel-rules.rst
> @@ -117,6 +117,12 @@ comment to pass arbitrary or predefined notes:
>     Note, such tagging is unnecessary if the stable team can derive the
>     appropriate versions from Fixes: tags.
>  
> + * Prevent semi-automatic backporting of changes carrying a 'Fixes:' tag:
> +
> +   .. code-block:: none
> +
> +     Cc: <stable@vger.kernel.org> # no semi-automatic backport

I do not understand, why are you saying "cc: stable" here if you do NOT
want it backported?

And what do you mean by "semi-automatic"?

confused,

greg k-h

