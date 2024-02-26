Return-Path: <linux-kernel+bounces-81233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D92D38673A2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53BBAB2BECA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8AD249F5;
	Mon, 26 Feb 2024 10:57:34 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB3A22626;
	Mon, 26 Feb 2024 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708945054; cv=none; b=ap2tndtylbYirLpH2r8IkcIPclVj6KphCTtoXGYiyskYDyB+ZM/VkUYud05YLC2TggWg1ZNi3eerJZluSlLy+GZHoqximEp/FdzBGysDX2G6dQiFmCyhpMXnQ4zeM6hfeuWhw++LjjjPCzZlOxSPB5TUOkocV4q33eaMEzgW2zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708945054; c=relaxed/simple;
	bh=u5oWRzn/7hndJk1lfnmcJE+isM/HfInNAVsppGMJ/eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBuJFnFZt0BKINjoAgkpenIUGolcpPk7YT3ZP3nUNGXJ/inc3jr2k779zsifeOT3TcR4ramY//zy4ZBjJmiAZkn9T1hvK+4eF2+LGR1zHmz+wlA5AgB99mH9TmWWf9P0vT6IHWZj+wAY1afBRTN3Ndg3zbAYxnxbFc5KSmoN9Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0236168CFE; Mon, 26 Feb 2024 11:57:28 +0100 (CET)
Date: Mon, 26 Feb 2024 11:57:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: hch@lst.de, chandanbabu@kernel.org, corbet@lwn.net, david@fromorbit.com,
	djwong@kernel.org, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, linux-xfs@vger.kernel.org,
	mchehab@kernel.org, sfr@canb.auug.org.au
Subject: Re: linux-next: build warning after merge of the xfs tree
Message-ID: <20240226105727.GA28770@lst.de>
References: <20240223140619.GA30519@lst.de> <22187737-e0ad-4cc4-98fd-5e43ebc5ecee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22187737-e0ad-4cc4-98fd-5e43ebc5ecee@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Feb 24, 2024 at 06:07:28PM +0900, Akira Yokosawa wrote:
> How about teaching kernel-doc unary "*" on param?

That would be great!

> 
> Substitution would look like:
> 
>    (kernel-doc)       (RST)
>    *@param     ->  ***param**
> 
> Sphinx detects double asterisk, starts strong emphasis, waits for
> another double asterisk to appear, and stops strong emphasis.
> Hence you would get boldface "*param" in pretty printed docs.
> 
> Diff below (against docs-next) should add a rule for param_deref
> (only for RST).

I'd love to go with this instead of working around the issue:

Acked-by: Christoph Hellwig <hch@lst.de>


