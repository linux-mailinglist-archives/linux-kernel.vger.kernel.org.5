Return-Path: <linux-kernel+bounces-63691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF427853351
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED051C22C57
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7121A41C60;
	Tue, 13 Feb 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x9PwzjTQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3CF1DFE3;
	Tue, 13 Feb 2024 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835093; cv=none; b=ofKjNEeuzRaSke7fqqbgTY5MPokdtbt1ylX/VN2W1Xnn9H1JgDXQ+GZNdLcA+uzkNLh0VczDWctEG+f2frG2M9iHYqA1Mpd3M8K85uOc4mSXMEfiMCI8l405X0HVJFIT59Vm9eIEBH22EhsvEEbCG0m9JWdbWUTuK13hE0zMk7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835093; c=relaxed/simple;
	bh=qo9f7339OiVSnIqYU8i+7TfOZV/04hMxcDASphcjwvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ip5QFevnr+LLC2/VxPv3/UAmElmVQos1fc5gEqkiokk+zR+AH0NTaf1BEC2bK7hlIDkKdfwY55DBPqGuC3jRAnOc3DbZhwLy3GoCpGqJmF674Rf2ZUBAKndXymriFKIX9iQoVujS6M1vuuFaSxSMJBMFlzCeJaKwJZ5pungGJnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x9PwzjTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F22C433C7;
	Tue, 13 Feb 2024 14:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707835093;
	bh=qo9f7339OiVSnIqYU8i+7TfOZV/04hMxcDASphcjwvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x9PwzjTQHmrRwNH6qXXUgvU2IMSO2TXW3jguB5W6NGrwgdYAE+VZvfdYhRFniK97O
	 g3f3g4p4nVWxkfUoGemmrji7KA8KXk5rxrbAbZ4kVc+t1IwENu0YTDFKC9zYc+lDKv
	 TVuiCZiAiWRHf28RXC2W8q1cWR8jTnqerbkRWYvk=
Date: Tue, 13 Feb 2024 15:38:10 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs stable updates for v6.7
Message-ID: <2024021307-reactive-woven-8543@gregkh>
References: <6yl6zvu2pa3mz7irsaax5ivp6kh3dae5kaslvst7yafmg6672g@mskleu2vjfp2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6yl6zvu2pa3mz7irsaax5ivp6kh3dae5kaslvst7yafmg6672g@mskleu2vjfp2>

On Thu, Feb 08, 2024 at 08:14:39PM -0500, Kent Overstreet wrote:
> Hi Greg, few stable updates for you -
> 
> Cheers,
> Kent
> 
> The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:
> 
>   Linux 6.7 (2024-01-07 12:18:38 -0800)
> 
> are available in the Git repository at:
> 
>   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-for-v6.7-stable-20240208
> 
> for you to fetch changes up to f1582f4774ac7c30c5460a8c7a6e5a82b9ce5a6a:
> 
>   bcachefs: time_stats: Check for last_event == 0 when updating freq stats (2024-02-08 15:33:11 -0500)

This didn't work well :(

All of the original git commit ids are gone, and for me to look them up
and add them back by hand is a pain.  I'll do it this time, but next
time can you please include them in the commit somewhere (cherry-pick -x
will do it automatically for you)

Let's see if I can figure it out...

thanks,

greg k-h

