Return-Path: <linux-kernel+bounces-71483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 790DA85A5FF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A3B7B211F3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0771E890;
	Mon, 19 Feb 2024 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLnPSs7e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952671D684;
	Mon, 19 Feb 2024 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353197; cv=none; b=caUPdf1g/kOHYHit84ugm+sRztFvi1EBCHyS3990s0YvrAq2hSBnrWF+etTQfgv2jx18pFSZuI2p95FfrMznOOBJxBkV7MBZiRLc851nlx3aU2K8KEVUzI2YrP4Awd3/pTA/Pc3BVdnhgmAkCCQjRvrYP3UgJ6ZBYPpaPenGV3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353197; c=relaxed/simple;
	bh=Xe/jNUZzERdzy9szmi2GKWerL8Qr31xoS5JDPwdmnjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yg6FRB1PlF4qUjlufAQ7yUjAMtEHrYPMI0YpDD3daWBvNZP+qSYTccTlkZNDVuNmnI0inaMmIX3afIrB2KTPCRh5kxBA+w5asC4iL8dTNG1hX6SAD0GIXc+hoUvdh7TQWjQxYRM+KaxA+BE+PnrnzTSUTmGN93nHuUXQ9mS4TV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLnPSs7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F25C433C7;
	Mon, 19 Feb 2024 14:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708353197;
	bh=Xe/jNUZzERdzy9szmi2GKWerL8Qr31xoS5JDPwdmnjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aLnPSs7eMksGfJNzisomcqU5oBRRhHVmAxLtULdy6oLUUpR7FIiNEFwFvFVTRsgy1
	 4oj00ScUXRCNTOHH82jaAgT8T0TRe1FYyYO960bGdNsO3yIUS5bz5x7tBaH3rILu0A
	 g+t3UDzpt9OUoiT8rSNhKQLFHxd7AhypRZmC01VKKUhH6DoiIUaOlMZsoBAvD4iWEW
	 p72naJJK4SQHsQ/gKEXlr4JZtdLYVOlfeuky564x+EUZQ6peTARKAKUcnRsa0Howhb
	 37yGYVyN++ox0Q1iF+wiwuWt7RMFRlxMCjHs1mWWcZBJdxwy467PCyeVg+/bDt+ufz
	 ZhW0GnSxjvA3w==
Date: Mon, 19 Feb 2024 14:33:12 +0000
From: Lee Jones <lee@kernel.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>, tony@atomide.com,
	robh@kernel.org, wens@csie.org, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mfd: twl6030-irq: Revert to use of_match_device()
Message-ID: <20240219143312.GA10170@google.com>
References: <20231029114843.15553-1-peter.ujfalusi@gmail.com>
 <mvmttm4ye5q.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mvmttm4ye5q.fsf@suse.de>

On Mon, 19 Feb 2024, Andreas Schwab wrote:

> On Okt 29 2023, Peter Ujfalusi wrote:
> 
> > The core twl chip is probed via i2c and the dev->driver->of_match_table is
> > NULL, causing the driver to fail to probe.
> >
> > This partially reverts commit 1e0c866887f4.
> >
> > Fixes: 1e0c866887f4 ("mfd: Use device_get_match_data() in a bunch of drivers")
> 
> That commit id does not exist, which is why it hasn't been picked up by
> stable.  The correct commit id is 830fafce06e6f.

It hasn't been picked by Stable because no one sent it to Stable. :)

-- 
Lee Jones [李琼斯]

