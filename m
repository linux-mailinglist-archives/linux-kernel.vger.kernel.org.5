Return-Path: <linux-kernel+bounces-84552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D03186A834
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D9D2896EF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF7F21A1C;
	Wed, 28 Feb 2024 06:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ebRhEOBE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D86221362;
	Wed, 28 Feb 2024 06:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709100402; cv=none; b=SwA/WmsQN/5VrvxBzIOH4/E0n8q/MnvmDE+yvIcN378CvOF+3K9Q/GvAsrz9e568HpZ0TQ8LX/4s9X9FvNW9f4+t6YkTqcSv7EXO/XGLFcEB3iXQOT9eWDJBQZfqPUbg7l0JKUK59yEs56/yCMiLo3gviXnzLk1B31bJbepSDUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709100402; c=relaxed/simple;
	bh=3nmTiUmW+k8LJZa1YRh8n/uc70U/1mS5VHZqukv50NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kL2yvx5c22TscD2hNoQ563ylQ0VI6f799hdMLyeSYE7Luspy09s1URwrVi6QbUVj3U9QTngb/eZKTVSsdVJVXWJOE5PivjrULFOTVkitDEYEJnoJFM8+5TxpwRQu73MnJjVGMIs0fekf0ulWeQL6uJsPue47ehz2u4Kbxq/BnXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ebRhEOBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03007C43390;
	Wed, 28 Feb 2024 06:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709100401;
	bh=3nmTiUmW+k8LJZa1YRh8n/uc70U/1mS5VHZqukv50NY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ebRhEOBEhREvZrkRjlg6bbPUbTvHSAB3PYtrrVoAJcU75PHLSFJdCfVsdHa6Sf1SP
	 +aFI+ujv6Q1WM3s6HPSzwyATFCjpVAKH1lbB5A6xokR5+HKLjgfwefTj5VNBJzdllW
	 Ktcj9JYPEQ9QxEjgC/KTZq182/fh3mGph7Hpk4Ks=
Date: Wed, 28 Feb 2024 07:06:38 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 000/122] 5.10.211-rc1 review
Message-ID: <2024022804-askew-stung-cba8@gregkh>
References: <20240227131558.694096204@linuxfoundation.org>
 <Zd53aNc1aFrCYxFd@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd53aNc1aFrCYxFd@codewreck.org>

On Wed, Feb 28, 2024 at 08:59:36AM +0900, Dominique Martinet wrote:
> Greg Kroah-Hartman wrote on Tue, Feb 27, 2024 at 02:26:01PM +0100:
> > Kees Cook <keescook@chromium.org>
> >     net: dev: Convert sa_data to flexible array in struct sockaddr
> > (ca13c2b1e9e4b5d982c2f1e75f28b1586e5c0f7f in this tree,
> > b5f0de6df6dce8d641ef58ef7012f3304dffb9a1 upstream)
> 
> This commit breaks build of some 3rd party wireless module we use here
> (because sizeof(sa->sa_data) no longer works and needs to use
> sa_data_min)
> With that said I guess it really is a dependency on the arp_req_get
> overflow, so probably necessary evil, and I don't think we explicitly
> pretend to preserve APIs for 3rd party modules so this is probably
> fine... The new warnings that poped up (and were reported in other
> messages) a probably worth checking though.

We NEVER preserve in-kernel APIs for any out-of-tree code as obviously,
we have no idea what out-of-tree code is actually using, so it would be
impossible to do so.

Also, it's odd that a driver is hit by this as no in-kernel driver was,
so perhaps it's using the wrong api to start with :)

thanks,

greg k-h

