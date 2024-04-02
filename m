Return-Path: <linux-kernel+bounces-127960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DCC8953AF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87450B287B3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267DD85289;
	Tue,  2 Apr 2024 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FPF9fc6V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B638526A;
	Tue,  2 Apr 2024 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061667; cv=none; b=b6r6TxrMuvyi6mkfY7bZwOT/Z5r5hiHMKvO0Ii1iLsbZqDR0ebE4mxlSmeRkluTJv5bAoSYewTPp48s1RUpTpyxPfYXIEhjHOwytINON43c0dVoAbcxzFmXgcKOYD7rejHORJ6qBGSM6uqxn3WbgDVEJY6o23EwHTnPvPxR/dSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061667; c=relaxed/simple;
	bh=ZretEA8fWsV/yWQBiDrbkB3u6/2GEyHdXv2v6A0EZlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtVfQgKKg68+b8JpNs60PZgDL4839Gh64UZy65X+6BOo5XN72dvBjYJB/9seWaDtTQL4VtPnvZr3fcoHbr18eZcGCCbOzIYqRKSkhTtDpFoLM3LQbCOKZv27m/Y9QZMLGz6MIflPka4tS9mDKeaGFyDJe1UV3QKa6TaLp+fJIUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FPF9fc6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4519AC433F1;
	Tue,  2 Apr 2024 12:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712061666;
	bh=ZretEA8fWsV/yWQBiDrbkB3u6/2GEyHdXv2v6A0EZlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FPF9fc6Vz4OURHk7HbIFRGvrzGZnYE4/Lc6K1p0DUmtTc7a3xioYTmp4Yf4ym5E0E
	 nv29ux47kMaPXErviC8yiSo0S+QiptSWAE6nY2/VQmtQvlRj67oG8SOVluoYTa41kS
	 qMJIF/cKOeEKio+YoAoYs7UWv+4qEgRdgZqNIhJQ=
Date: Tue, 2 Apr 2024 14:41:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2][5.9-rc] USB FunctionFS DMABUF interface fixes
Message-ID: <2024040253-sanction-viewing-770e@gregkh>
References: <20240402110951.16376-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402110951.16376-1-paul@crapouillou.net>

On Tue, Apr 02, 2024 at 01:09:49PM +0200, Paul Cercueil wrote:
> Hi Greg,
> 
> Here are two patches that address issues that were noticed by Christian
> when reviewing the very similar IIO DMABUF interface (but the FunctionFS
> patchset was already merged at that point).
> 
> Based on 5.9-rc2.

I think you mean "6.9-rc2", right?


