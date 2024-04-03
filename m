Return-Path: <linux-kernel+bounces-130395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FB1897780
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FE91C213F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0092229427;
	Wed,  3 Apr 2024 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qW9T4jrF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F98154442;
	Wed,  3 Apr 2024 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712166872; cv=none; b=lcpGdN4coMbtHHol4+tadWwV3EOWW1TFso4EWCtL+V+GutHZj6KlBYIzAVvheo2KRONct0wjyx6Max8w5udV6MkvjISbr0apBfprYLsnCpvmsRMvvC9GAzLOEsEwWcgyMm0mg34sRaMid98tpiJjvsxnZwd1WppTseIZkXFzLdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712166872; c=relaxed/simple;
	bh=uvqoFepTTSmYf5CSCPMuPkExGddqCecW1dhS79RR5c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqANeoie+WR3VOYSipXEN1+VSUreOfQ4F466QsA0zvB5elC1idY0j2E8x8mBkj1c0XbUeKhBtv0AB4mp1/LBENCoXyytq6kCMrhkd0sYxu6Bjb2ZoG5UKcbcgStjdhGH21iLtrFUAsMStXtzkZAzKUydHnYeA1EDKOs9cEHy29w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qW9T4jrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10680C433F1;
	Wed,  3 Apr 2024 17:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712166871;
	bh=uvqoFepTTSmYf5CSCPMuPkExGddqCecW1dhS79RR5c8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qW9T4jrF2wB9R4dfJDVmFj2ZF+HBS7TaHZcm3tLT/XlbP83lMDlJLdWORBkHWEA+n
	 Pe/ukYFIqB2tkEA5LEfytu2TGY+dOlq6xEQz+/VwN3PryNY4wSmfSrHuAkfJfxQUqo
	 07VpNUp2Ri9RKsXA4y3CRkQtTiS8eqR/sR8ewR9U=
Date: Wed, 3 Apr 2024 19:54:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Joseph Salisbury <joseph.salisbury@canonical.com>
Cc: hch@lst.de, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, sashal@kernel.org, stable@vger.kernel.org,
	Francis Ginther <francis.ginther@canonical.com>
Subject: Re: [v5.15 Regression] block: rename GENHD_FL_NO_PART_SCAN to
 GENHD_FL_NO_PART
Message-ID: <2024040329-unstopped-spelling-64c8@gregkh>
References: <924449dc-9b1f-4943-afe3-a68c03aedbb5@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <924449dc-9b1f-4943-afe3-a68c03aedbb5@canonical.com>

On Wed, Apr 03, 2024 at 01:50:09PM -0400, Joseph Salisbury wrote:
> Hi Christoph,
> 
> A kernel bug report was opened against Ubuntu [0].  This bug is a regression
> introduced in mainline version v5.17-rc1 and made it's way into v5.15 stable
> updates.
> 
> The following commit was identified as the cause of the regression in 5.15:
> 
> c6ce1c5dd327 ("block: rename GENHD_FL_NO_PART_SCAN to GENHD_FL_NO_PART")

How is renaming a define a "regression"?

> I was hoping to get your feedback, since you are the patch author. Is the
> best approach to revert this commit, since many third parties rely on the
> name being GENHD_FL_NO_PART_SCAN in kernel headers?

External kernel modules are never an issue.  Is this a userspace thing?

> Is there a specific need that you know of that requires this commit
> in the 5.15 and earlier stable kernels?

Yes.  And Christoph did not do the backport, so I doubt he cares :)

Again, what in-kernel issue is caused by this?

thanks,

greg k-h

