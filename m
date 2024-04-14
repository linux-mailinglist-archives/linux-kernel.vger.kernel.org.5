Return-Path: <linux-kernel+bounces-144140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D878A4255
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4212D1F2162C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FCE3E47F;
	Sun, 14 Apr 2024 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ToXMfwEI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E38114292;
	Sun, 14 Apr 2024 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713099171; cv=none; b=ESBU6bPiP0xjC7uTlOeld/jMlaybRIVc8AMCURkt6hGFUIndyUT7W2Xd643u81ZDnckZgwJ8XLqVMyTLE8MOnmBJTWKhEmF2IgX5QfWKPaN1G6KY5Geu73PKaOySSdEk5aVkaFounPQfK2UxH8XU1mBp5tFfRo7QQmSZscbOOoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713099171; c=relaxed/simple;
	bh=ylzy7/WxQmtDrQrEHLpFCt6of1KyGEM6HQ+QR40PWmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSb43TWhTfDK5MSTu1LIBOTAvwB01zBGP09+zaRLJ8cJ4DroiiGBOLWiB/lF0WR6+ey4W9w3F/v2GgzQMCaSNG9F+ZGDCnla1oYcQyh6wtx5e7P3sAwEjTmF8SlEHKAHqlXzMfvI/MZYs4oWlwOJ/gW+nYFAeVflHuaw84DQOck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ToXMfwEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4F3C072AA;
	Sun, 14 Apr 2024 12:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713099171;
	bh=ylzy7/WxQmtDrQrEHLpFCt6of1KyGEM6HQ+QR40PWmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ToXMfwEIW2w/Y2zUh8zHAO52nKF86eQSEUaxcJ9T7iE+DKwI7NJDcl4ZHg8S50UhL
	 y2ZYp/2Gskl5n+dqknd3pWYr9LgmSB82MedBiLevQC1O8GgwoVqPv15zW/m7EGxA0x
	 Yy6H/JK8CJGLJNQOuBIKD0aczHCEYShuelAT1nd8=
Date: Sun, 14 Apr 2024 14:52:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: function: Remove usage of the deprecated
 ida_simple_xx() API
Message-ID: <2024041432-cranial-spyglass-17d3@gregkh>
References: <fb14757b434ebbad82c8771f19b73dc7ef81a91b.1705232365.git.christophe.jaillet@wanadoo.fr>
 <779bc8ae-0f24-4f34-8f20-633e6e6f2fc5@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <779bc8ae-0f24-4f34-8f20-633e6e6f2fc5@wanadoo.fr>

On Sun, Apr 14, 2024 at 02:09:08PM +0200, Christophe JAILLET wrote:
> Le 14/01/2024 à 12:39, Christophe JAILLET a écrit :
> > ida_alloc() and ida_free() should be preferred to the deprecated
> > ida_simple_get() and ida_simple_remove().
> > 
> > Note that the upper limit of ida_simple_get() is exclusive, but the one of
> > ida_alloc_max() is inclusive. So a -1 has been added when needed.
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
> > ---
> >   drivers/usb/gadget/function/f_hid.c     | 6 +++---
> >   drivers/usb/gadget/function/f_printer.c | 6 +++---
> >   drivers/usb/gadget/function/rndis.c     | 4 ++--
> >   3 files changed, 8 insertions(+), 8 deletions(-)
> > 
> 
> Hi,
> 
> polite reminder.

Odd, this isn't in my review queue anywhere.  Can you rebase and resend?

thanks,

greg k-h

