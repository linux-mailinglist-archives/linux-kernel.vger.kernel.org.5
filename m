Return-Path: <linux-kernel+bounces-155558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3055C8AF3E7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA2028ACDB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A2313E405;
	Tue, 23 Apr 2024 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nThVN82K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C7113E03B;
	Tue, 23 Apr 2024 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889436; cv=none; b=BqmXzBuyTuzJ7BxV6Bl49D0Xvg0s+Zvs7RUqrYP7pJp/g/jWH7TStlSlJZWe9MkXi86yVzujU94PPC/jx8z700OXsAFGp4T7tp3A1Cv4pWU+Shgc39tVnAzgN5TS1F5sG6rbkV8QTs4Rd5sWhP+BxzzP6cvFlFDYtP9mh6IDCUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889436; c=relaxed/simple;
	bh=3rE8iCzACJ3xQrQo2n7+k+pI9IyJWXmBfSTaEbZ8Wjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5Q9jE2yRf4WcgE96Yp+pbnlQVj2erMo7imzg1QlcbZqAdt533LxNleT+2MfqeDsvKFXXL1UFfz9VCZKhyMf7HJhtg8xQ3OPRo0CUaLFjMEuRvssQrnqyCKwKvDyiYzaJ2uYeiFVEcp7isn9hzxOZNzQbMmCC+7Id10awOy+VqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nThVN82K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801D2C116B1;
	Tue, 23 Apr 2024 16:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713889435;
	bh=3rE8iCzACJ3xQrQo2n7+k+pI9IyJWXmBfSTaEbZ8Wjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nThVN82Kxi0XgxvS273sJ4SetvM8MeSKZouTlFVsenVzlc1/VrdZZgIJrVhWcdZmX
	 5WhQ51oV4EBJq/gZUbuesH0JENAYYo+IuK0cCGG8r+whTh4eAIrs7PlS9jlzZrUB8c
	 nq3oGE4gtw/xO/KFmMH7+7ybYSTvHxN6zEKd8Bqo=
Date: Tue, 23 Apr 2024 09:23:46 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?B?Suly9G1l?= Carretero <cJ-ko@zougloub.eu>
Cc: Sasha Neftin <sasha.neftin@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [Intel-wired-lan] [BUG] e1000e, scheduling while atomic (stable)
Message-ID: <2024042328-footprint-enrage-2db3@gregkh>
References: <a7eb665c74b5efb5140e6979759ed243072cb24a.camel@zougloub.eu>
 <dff8729b-3ab6-4b54-a3b0-60fabf031d62@intel.com>
 <2259bbeb9a012548779e3bf09a393fdb7d62dd0c.camel@zougloub.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2259bbeb9a012548779e3bf09a393fdb7d62dd0c.camel@zougloub.eu>

On Fri, Apr 19, 2024 at 12:20:05PM -0400, Jérôme Carretero wrote:
> Hi Sasha,
> 
> 
> Thank you, sorry for the delay but I coudln't reboot.
> 
> Adding Greg KH because I don't know if stable will receive my e-mail
> (not subscribed) but the regression was integrated in stable:
>  commit 0a4e3c2d976aa4dd38951afd6267f74ef3fade0e
> so they should get the fix ASAP too.

The fix needs to show up in Linus's tree, is it on its way there?

thanks,

greg k-h

