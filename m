Return-Path: <linux-kernel+bounces-124319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4797189159F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBEDD1F22D26
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2A84F881;
	Fri, 29 Mar 2024 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xmqZppOj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56E34F606;
	Fri, 29 Mar 2024 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703860; cv=none; b=s24OdVwbr2ihmMBO5kpAH/QFHmEudcPk7r8qnYctVwKE9Ey0R4fqcbUH0HDMWRvnXyaSTm58gapsHqNxMi2/lZ20K0lcgmcJwRiWMVw8B5POy6fx+W3D0eNmXDC91Yb7fGX1XDTEdYirfxrdxSBqSYgb+mTFVLfug1p2c43vUSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703860; c=relaxed/simple;
	bh=ukG19+e5dQUl/rTjw8Kta4Qq+7PmCZE3qbRajYNkPjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijN3BrBwWk5ve65OOsgxwdkhNTXcJRJRpxVwn/Kd2rAAFdHuPnEgxGIyfGGwOFinvoqyisLTW5UD7gu4FzbdlDmtbaLFw4eseouyKyBHvatmrnYApru8CFqswp+JCXMuMO9khkH/ZlLUzbvg3p30E3gUdi91I8o0SB34g6iZytw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xmqZppOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14A4C433F1;
	Fri, 29 Mar 2024 09:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711703860;
	bh=ukG19+e5dQUl/rTjw8Kta4Qq+7PmCZE3qbRajYNkPjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xmqZppOjBLT9G22vs9QWJt++yXpoSTWnjU/zdxjci9kfazyhQDOWQqE8odjoLezwc
	 bG1jWMU5xJT+V52cD9LO/iuIyoMWGBJaRr8UL+nXQvEpGwRUDR9q+3HLJBeVLZd9hg
	 Bs5XZhHEeQAt3YPqJcUxTB7xZTVLm+898pbmBnLg=
Date: Fri, 29 Mar 2024 10:17:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	stable@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "x86/efistub: Call mixed mode boot services on the
 firmware's stack" failed to apply to 6.8-stable tree
Message-ID: <2024032902-moonlit-abridge-743e@gregkh>
References: <20240327120643.2824712-1-sashal@kernel.org>
 <CAMj1kXH8n4-8VHSVygUyEc4Zne-4gE0uijAkDe-Ufu6hUnFU+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH8n4-8VHSVygUyEc4Zne-4gE0uijAkDe-Ufu6hUnFU+g@mail.gmail.com>

On Wed, Mar 27, 2024 at 03:46:53PM +0200, Ard Biesheuvel wrote:
> On Wed, 27 Mar 2024 at 14:06, Sasha Levin <sashal@kernel.org> wrote:
> >
> > The patch below does not apply to the 6.8-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> 
> This applies fine on top of 6.8.2, 6.7.11 and 6.6.23.
> 
> On 6.1.83, it gave me a warning
> 
>   Auto-merging arch/x86/boot/compressed/efi_mixed.S
> 
> but the change still applied without problems.
> 
> Not sure what is going on here .....

Odd, it worked here forme, now queued up everywhere, sorry for the
noise.

greg k-h

