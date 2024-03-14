Return-Path: <linux-kernel+bounces-103158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFE987BBB6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CD01F21F84
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595406CDA3;
	Thu, 14 Mar 2024 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moDtbAil"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1A06EB53
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710414582; cv=none; b=XCwPQ4oN3T20r9Iy1InttplWBdl2oYFwY8E+o/j1wnH+KCUn1TU0tO39K4JF8gZAPK7Cy5jr64/8wEgBUmasC6xLR97DRdpXA/fEvdNHMl+bcBWCdm5pP8ThujJaBOTevDfXuvBhdzLGAtjRrjChWMMyiPi8ywE6mJHhuXT+EmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710414582; c=relaxed/simple;
	bh=RaseM/+KoqOPYNmXu1HCiER1tZgWMTC85atLNfK0kqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqyXPPT8wi04ZOw6HvNsywXx1lG52CRbFJzShLNClkEtljlTbCz8dZUt2Q2B6vY8qUUkMVMBRLKBIE5db28d8PPGVA69YouvhqIB07PkrmB2/aSWTefPgYQihNMtg9aSOHxzoQhLCbzTMQaMLz5uUH9QwntM+BFQ8h1xUrEZFeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moDtbAil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC2CC433F1;
	Thu, 14 Mar 2024 11:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710414582;
	bh=RaseM/+KoqOPYNmXu1HCiER1tZgWMTC85atLNfK0kqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=moDtbAilM7o1ksXGdCj1d5zYc0JpDsUwsaE3PufyJkNl2X5/SgtMCqKEXbKB/Phe6
	 aCFmozE9ar2kMxt5+mISFKncM7Lzc0b2sEYSqhGTpwsCZCy3hLekEDRVX6JJzYc7po
	 ep2BqVh3RP2zfslNmYho2TQovdJh1otUqD3v9mn9LX0keJ7QXBD6RLTAl8nqkqan9p
	 9jlwjOLk8FhbjKoxjvTB7NbngEJ7oKP47z+rRNPoIvP9DSmScveT77eYHbPNYnqMri
	 s2bqCTkZEK30jDZh/l/zDXwnMJnCSEiX2jlCYkrVTZ+1wR4bSLRegx0gX/3dhe6M5w
	 F5DVA15MCCdbA==
Date: Thu, 14 Mar 2024 11:09:38 +0000
From: Lee Jones <lee@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: CVE-2024-26628: drm/amdkfd: Fix lock dependency warning
Message-ID: <20240314110938.GM1522089@google.com>
References: <2024030649-CVE-2024-26628-f6ce@gregkh>
 <Zerheyn-4rB5kySt@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zerheyn-4rB5kySt@tiehlicka>

On Fri, 08 Mar 2024, Michal Hocko wrote:

> On Wed 06-03-24 06:46:11, Greg KH wrote:
> [...]
> >  Possible unsafe locking scenario:
> > 
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(&svms->lock);
> >                                lock(&mm->mmap_lock);
> >                                lock(&svms->lock);
> >   lock((work_completion)(&svm_bo->eviction_work));
> > 
> > I believe this cannot really lead to a deadlock in practice, because
> > svm_range_evict_svm_bo_worker only takes the mmap_read_lock if the BO
> > refcount is non-0. That means it's impossible that svm_range_bo_release
> > is running concurrently. However, there is no good way to annotate this.
> 
> OK, so is this even a bug (not to mention a security/weakness)?

Looks like the patch fixes a warning which can crash some kernels.  So
the CVE appears to be fixing that, rather than the impossible deadlock.

-- 
Lee Jones [李琼斯]

