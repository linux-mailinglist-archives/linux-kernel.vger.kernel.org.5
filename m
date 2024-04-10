Return-Path: <linux-kernel+bounces-138986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1321789FD09
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C701C20A89
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA46117B4F5;
	Wed, 10 Apr 2024 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJWktyAE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5651779A9;
	Wed, 10 Apr 2024 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766977; cv=none; b=gUNaOCJZQIQQRbQgJcJgo1w50YgAXHHwdl1cq3058iz2he9Wne9gGxpz/+0eeZ1NxIH8ePUt351IuhPcLZpnUiQ+qDfp5+HcfVTc5SMcCOlDjEhxlK9Ek8/ifMa+68weDPhnENqoBuGKQ6z6eyJwYKSplCwA0nhRysLJvsWAiDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766977; c=relaxed/simple;
	bh=va6aJQDCMR2Z82GIPrLoBSIBd2Bs9Em2LFb+DW3sePg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tl7ZMDqY8yNeAU9HEha5duSf19hs/9TKCo2viBTyYuYG3+3qTyWtDpXWq2NHaHCqP5dIFIMWQLxyWFghC35ujJA8cLWXtszI/+xDc7nBq6q5yk6mMcfgBPXpUmnCgujVJK56IFPKB5S7XpkArL22mmJuqJGDvwRycFwsB1FHJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJWktyAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E27C433F1;
	Wed, 10 Apr 2024 16:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712766976;
	bh=va6aJQDCMR2Z82GIPrLoBSIBd2Bs9Em2LFb+DW3sePg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hJWktyAEKduiTPIVXOuA9YcJrobuE94Y3FtLE3/zgzQ+xGs57CPEIuvPx6yPdFTxQ
	 4oNzU/41oBNCEf91OPo+v6EDV/Zr7BBgJ9QlmssvXr8+MAblRmp3gcwSihl9KSSRDw
	 7jA80OPbu7HYoYm1HvPQ7S083R5L9dqSJgcR3o1h91te/2EsuHWvcc9j62L5hYL5aY
	 j0f+t80N4qijG67S/7T/2tFP9T/Kfp3bJz3DJ8ghj7ncJMVIWQqBmQiLJTQTdXkNCg
	 OIGgxnlZEwhFT/sEVDjMTVezlYbvG8fct7/iIiTj+1SZ6D0NC1xoG7FS980rcEB7fJ
	 cAMthVoOVOScw==
Date: Wed, 10 Apr 2024 18:36:11 +0200
From: Alexey Gladkov <legion@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>, kbd@lists.linux.dev,
	linux-api@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-serial@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v4 2/3] VT: Add KDFONTINFO ioctl
Message-ID: <Zha_-zPHCW8iYT_4@example.org>
References: <74ca50e0-61b1-4d4c-85dd-a5d920548c04@kernel.org>
 <cover.1712080158.git.legion@kernel.org>
 <7cd32f988a147d7617742c9e074c753de0c6bc1f.1712080158.git.legion@kernel.org>
 <211f3c45-7064-475b-b9e1-f6adbbba8879@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <211f3c45-7064-475b-b9e1-f6adbbba8879@kernel.org>

On Wed, Apr 03, 2024 at 07:05:14AM +0200, Jiri Slaby wrote:
> First, there was no need to send this v4 so quickly. Provided we have 
> not settled in v3... This makes the review process painful.
> 
> And then:
> 
> On 02. 04. 24, 19:50, Alexey Gladkov wrote:
> > Each driver has its own restrictions on font size. There is currently no
> > way to understand what the requirements are. The new ioctl allows
> > userspace to get the minimum and maximum font size values.
> > 
> > Acked-by: Helge Deller <deller@gmx.de>
> > Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ...
> > --- a/drivers/tty/vt/vt_ioctl.c
> > +++ b/drivers/tty/vt/vt_ioctl.c
> > @@ -479,6 +479,17 @@ static int vt_k_ioctl(struct tty_struct *tty, unsigned int cmd,
> >   		break;
> >   	}
> >   
> > +	case KDFONTINFO: {
> > +		struct console_font_info fnt_info;
> > +
> > +		ret = con_font_info(vc, &fnt_info);
> > +		if (ret)
> > +			return ret;
> > +		if (copy_to_user(up, &fnt_info, sizeof(fnt_info)))
> 
> sizeof, I already commented.

I'm not sure I understand. sizeof(*up), but 'up' is 'void __user *up'.

> Now you leak info to userspace unless everyone sets everything in 
> fnt_info. IOW, do memset() above.

Yes. I miss it. Sorry.

-- 
Rgrds, legion


