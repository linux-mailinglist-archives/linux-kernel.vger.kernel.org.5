Return-Path: <linux-kernel+bounces-79474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 196C48622B9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 06:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B3C1C21E07
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 05:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB3017541;
	Sat, 24 Feb 2024 05:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n1q17bxb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D942113AD9;
	Sat, 24 Feb 2024 05:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708752461; cv=none; b=COemDjXO5nrH/MKvqmX5zpSqNKqYlAt6M2Gt8jFraGWYOIPovyYXZZMUqK6XSUuXXBVTVDDvVyxOE5Uz8yI3PdOfIX1dT8TOpr4UXVa0sZ9gnwR2Ca3t5iAeF7p5r4nZkVtrEXtesdl6/Cr9IxskLCUyE51A8PTjFZBAYnj74hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708752461; c=relaxed/simple;
	bh=X2Voa/lGxk4ES7nWY51+cmiznqb71ZDPT59P/2/VOWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZX6ff/BAUZO3uzZZ6L86U0A2BmJFki37Uc3gqodNtpJGm9tFoSdxLUDVf363E7uFu6BnTb2fl/wB4dVIyhK+cdvVFmjGbvqOtL0/5DQTRW5rWzoTMnGsSKEWQH43hLvrjnYKqqwu5duNA6Vn5w0jSMe6qxgBf2BGzSkm2CfFmAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n1q17bxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A6DC433F1;
	Sat, 24 Feb 2024 05:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708752460;
	bh=X2Voa/lGxk4ES7nWY51+cmiznqb71ZDPT59P/2/VOWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1q17bxbv9DOyF8yrOzXlPxbjV/F25EohVgvSMjx/+HZYHbRScGXfP/nQvtLqp4wM
	 NcP62jBsbkWB+D1tukg1I/ynhx4iZv3wtNTM2TfHtutFCHNPhfzOmAcJ3cz4GRrqC3
	 /KNqyL1jJqJEwKiN+S/quzWCax1Hs0XZZw2Nhk0w=
Date: Sat, 24 Feb 2024 06:27:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dileep Sankhla <dileepsankhla.ds@gmail.com>
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, pure.logic@nexus-software.ie,
	johan@kernel.org, elder@kernel.org
Subject: Re: tree for the greybus subsystem
Message-ID: <2024022427-abruptly-vastness-ed23@gregkh>
References: <CAHxc4buV_UieeVVBhua3vmT2+2e6qf2B9uoxpSPAg6faGBa=Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHxc4buV_UieeVVBhua3vmT2+2e6qf2B9uoxpSPAg6faGBa=Ww@mail.gmail.com>

On Fri, Feb 23, 2024 at 11:44:48PM +0530, Dileep Sankhla wrote:
> Hello,
> 
> I am fixing a coding style problem in the loopback bridge driver for
> the Greybus loopback module. The source code file (please see [0]) is
> located in the staging tree for the linux-next.
> 
> In order to create the patch, I need to find the right development
> tree. I checked the MAINTAINERS file for the Greybus subsystem
> development tree but could not find one. I also searched [1] for
> "greybus", but without success.
> 
> What is the development tree for the greybus subsystem?

As the staging subsystem is how this code flows into the tree:

	$ ./scripts/get_maintainer.pl drivers/staging/greybus/loopback.c
	"Bryan O'Donoghue" <pure.logic@nexus-software.ie> (maintainer:GREYBUS LOOPBACK DRIVER)
	Johan Hovold <johan@kernel.org> (maintainer:GREYBUS SUBSYSTEM)
	Alex Elder <elder@kernel.org> (maintainer:GREYBUS SUBSYSTEM)
	Greg Kroah-Hartman <gregkh@linuxfoundation.org> (maintainer:GREYBUS SUBSYSTEM)
	greybus-dev@lists.linaro.org (moderated list:GREYBUS SUBSYSTEM)
	linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM)
	linux-kernel@vger.kernel.org (open list)

Then the staging.git tree as shown in MAINTAINERS is the correct one.

But you should always be able to just use linux-next as a default if you
can't figure out what tree to use.

thanks,

greg k-h

