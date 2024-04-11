Return-Path: <linux-kernel+bounces-140176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6932F8A0C67
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A70D1C20962
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98873144D18;
	Thu, 11 Apr 2024 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5O+mgGC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E290D13DDDD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827772; cv=none; b=DV8BzvdUK2YfYiPw6KI6+PLlN7Y8+zKkiTU7k2IYlRR7YHLpW8QiTTTzrirFBDDI6YXHeVkjUOwSj9vvV8S2trHLOlrqEbLg26t89oLSAS3+C7x+SdKE+QbVWrUhNGuQHEnaY1DgpxVe+we/VVA63EedfiD9N/tWrN7V+KaQmxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827772; c=relaxed/simple;
	bh=YcYTyPMpLv5JYxXowNl006DvK0aovJXI4oDyIJPAnhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yy2lhxsKmav9YOPXsQ4ocRGOu+JeoErO/g1hnYdlaqwkjufh9frskkA24a/qSlkCIT72tgm/5ZmCit2MRvb30pdabfYPQExnhiVHrduubCg36F/r+MwnHUJB14R4nzdKT7s52y+jPR4WjO1VCDSzbF4MRIMSpXDvOn1d+fHGXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5O+mgGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD270C433F1;
	Thu, 11 Apr 2024 09:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712827771;
	bh=YcYTyPMpLv5JYxXowNl006DvK0aovJXI4oDyIJPAnhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5O+mgGC0zwOXVaIKJBAcN4YdxECHBrQ5bf4+hob+R+TkUtFMWvFpWE1lJZdnzDUY
	 PZcGmHWpjYMz0Yo6Ir6B7PA+AHpeCaydNe0gsOUFtor5fOuaCuedUuVarlOy3DA1Kf
	 zrL6i2pM+mLfVxnX84pg1YQ8+cQJzMVj4YgpGMMWNzgSU4RGabZTBmodKzJ6cAP730
	 udzszb0CmGtC8M8ucxr9WaPgZayiwI4wwFopMKwcKpYsEFnE5yLi8LqJaNo/XrG3CS
	 DUIPEQRfarANs6Quw8Ji6G5cccIT4Ff/1BCCE/wBJaFGsThtcAXdq8yt5kqppNz27s
	 Fu74rJc28t2AA==
Date: Thu, 11 Apr 2024 10:29:28 +0100
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/6] mfd: kempld: A few cleanups
Message-ID: <20240411092928.GB1980182@google.com>
References: <20240223195113.880121-1-andriy.shevchenko@linux.intel.com>
 <Zgwk1tr7x4HnnlD9@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zgwk1tr7x4HnnlD9@smile.fi.intel.com>

On Tue, 02 Apr 2024, Andy Shevchenko wrote:

> On Fri, Feb 23, 2024 at 09:49:49PM +0200, Andy Shevchenko wrote:
> > Just a set of ad-hoc cleanups. No functional change intended.
> 
> Any comments?
> 
> (I assume the 6+ weeks in the mailing list is enough for all kind of CIs
>  to complain. But they hadn't AFAICS.)

Not sure why these were dropped from my queue.

Likely another Mutt "feature".

Back in the queue.

-- 
Lee Jones [李琼斯]

