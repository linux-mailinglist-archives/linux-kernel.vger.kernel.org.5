Return-Path: <linux-kernel+bounces-94090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CC58739CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 882FBB23A4D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6691134740;
	Wed,  6 Mar 2024 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dYujUqZP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D84133993;
	Wed,  6 Mar 2024 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736742; cv=none; b=b3nnTARlXR5fix5eAzR+RqzzhQMD0dtQGqfeNzi6QbS84stzQnihiRKmjgOZFV2tZXeyQyZzxAvYE2UQev4rTN6vMdehuGxuhHQyVF+oLF54LIi7LJOTneOBWq6S6wBe7S4zC83RtUexsE0WP9ygt86gMVjxXYV/7E7r00qyqW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736742; c=relaxed/simple;
	bh=WWz3qX51brqr+2XRy9NKnm6i/rbnFz7tp+ykTPKSwY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlhiiMZH9xr3vteKHNtIumniyW1pzHlp8P+sumekHkukcYQsf3xGERHbPfb6EfAC0Gm7D+uT70GhPF2NZhJxFlqDC92LR5LlPLtjkjAuQ2SKRsrdT73IHiUJ3SH4teADiqKsSpEjoaMLBps4hRvJ7563PLhtBEUFFRoq/VFoIPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dYujUqZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B85C433F1;
	Wed,  6 Mar 2024 14:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709736741;
	bh=WWz3qX51brqr+2XRy9NKnm6i/rbnFz7tp+ykTPKSwY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYujUqZPrsuTCdsyHG30JC9FTYQhWsgDR3/SOgXmIK8grnNBfVDk5nGa8QahXOmb1
	 bmzN8nr3MLoID7PlEvJabhu/B2v1yU7c580cYkMF6NdqQnP0HrkjA0CMwabW5JPibq
	 HfzoKC+igNANMdVJMCffUk2C/0ZuGG+TWIxf88hw=
Date: Wed, 6 Mar 2024 14:52:19 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Luna Jernberg <droidbittin@gmail.com>
Cc: SeongJae Park <sj@kernel.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, damon@lists.linux.dev
Subject: Re: [PATCH 6.7 000/162] 6.7.9-rc1 review
Message-ID: <2024030653-reforest-gauze-149e@gregkh>
References: <20240304211551.833500257@linuxfoundation.org>
 <20240304224813.73380-1-sj@kernel.org>
 <CADo9pHi0az-CL_hktmpCVcuoiDaUJn2U208=TwAvBM6YQhfFqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADo9pHi0az-CL_hktmpCVcuoiDaUJn2U208=TwAvBM6YQhfFqw@mail.gmail.com>

On Tue, Mar 05, 2024 at 12:05:33AM +0100, Luna Jernberg wrote:
> Works fine on my Arch Linux desktop with model name    : AMD Ryzen 5
> 5600 6-Core Processor
> after the Arch Linux manual intervention for new mkinitcpio settings
> and version in Arch
> 
> Tested by: Luna Jernberg <droidbittin@gmail.com>

Nit, this should be "Tested-by:" without the ' ', otherwise our tools
will not pick this up.

thanks,

greg k-h

