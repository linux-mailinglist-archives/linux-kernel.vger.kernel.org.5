Return-Path: <linux-kernel+bounces-64139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E77E853A94
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B56285D3D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B184286B3;
	Tue, 13 Feb 2024 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2VqIl8D4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CD51CD25;
	Tue, 13 Feb 2024 19:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851398; cv=none; b=M7F02uJF75L29bdtRB0A+jlZHEDljvJlaZBDEPBiyxuWCU7FeuP/+sxX/w1qhUuqtwun0pKBUL/JI3KP6soa+uHNkt9jzPa8H6yP6h7s+uhm9s0hHpXUgP1/SYdCmd+pDq2m5FF8GmB6n5Uh9bJNwtBfNgSMItKaPaU5vQcgMn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851398; c=relaxed/simple;
	bh=/QjGlW87PajSKynFEQYQzKjo6YWXcgGBvBtgW5K6AgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OA9Fzhw1xX4vwwqByE/1INqjpTdVjJ00RhVnrd6aXnMFKszXRHv+W6yg6v/QgGWCePVpBidy4UARHDASZl0m+KxTsyk/QX3itkYi5x7V0eqX20o7lLK7Fy9kDmhwDR/p4g9/q3eGtd7r59GkJ/jxk9gkguT1T5Sn15jnQGMk17U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2VqIl8D4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9962EC433C7;
	Tue, 13 Feb 2024 19:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707851398;
	bh=/QjGlW87PajSKynFEQYQzKjo6YWXcgGBvBtgW5K6AgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2VqIl8D4fgdC+cszjglP4zrkTyu8enPE512iZV1ghMmx9wCGCorn/UWdc2VBLyLy4
	 QoSRFUNqB4HelpylFipPf+LfrdpsyrR6ODlXwbUS62ftt7hgiNasuT7/a7YfcwGcIr
	 nYurcwH3QN8IrJg01ofocrdH5X8L21QEKNWl77wM=
Date: Tue, 13 Feb 2024 20:09:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: corbet@lwn.net
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024021322-pumice-corny-eabc@gregkh>
References: <2024021314-unwelcome-shrill-690e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021314-unwelcome-shrill-690e@gregkh>

On Tue, Feb 13, 2024 at 07:48:12PM +0100, Greg Kroah-Hartman wrote:
> The Linux kernel project now has the ability to assign CVEs to fixed
> issues, so document the process and how individual developers can get a
> CVE if one is not automatically assigned for their fixes.
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Jon, if you don't have any objections, I can just take this in my tree
for the next -rc pull request I have for Linus with other driver-core
type stuff.

thanks,

greg k-h

