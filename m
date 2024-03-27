Return-Path: <linux-kernel+bounces-121551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E4588E99F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58EE1F32B37
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11398137747;
	Wed, 27 Mar 2024 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwj619xn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBC0535A4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554106; cv=none; b=tZ84riJg6yMOw/FY5G3YwBQMOnxHrWH0dPvTJXp/uUu7/LK9Kye2TzppMYZdHPjymiaSwDvsPTXbIc6HVd1KVZkjCLjrY6MgSJH3GBXzz9DwJYF2qKp91LF9pC9Sp0RGhhsvSJjesTNLfikW0evx6Suwx7N55N75jgoRjHT+JOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554106; c=relaxed/simple;
	bh=LSkdq/t94YMFNlamRqeWvTTfCAU7fVztXM9mzQlr1gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcSKN3lPksYIvF1V20GjdVimW39xQexFiNF415ftWQWCTEMTQAmKQeFDa8g93p5Kr0ugHy4C8cEkbrnD7ZcmfLsKfXAtak64mU1WhtFDu21r5L6Ced1DGD8AbY8sfn2mzp1ysJO8AE8iKQOCHsDSzhXiOu6ee24vIMQOo2AEKVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwj619xn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8D6C433C7;
	Wed, 27 Mar 2024 15:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711554105;
	bh=LSkdq/t94YMFNlamRqeWvTTfCAU7fVztXM9mzQlr1gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kwj619xnpdyJcHARuFdyABjHRFcqAdSXTht6r7soAxbPD/i8JwH+Wbuob+V12R3n2
	 rjT194985hg2t/tELpPWn6hp5xbV83OJPRUcfIIyw1XiOKlN+pZKuEoNANmwzA8bXf
	 xibCFVjADjaBzJLD5hoFzVnQTvcKdyo0G82FBxUUQdfhnn4CUkqUgeMYvOCYAi5VRT
	 ICQPFF6NQuQf4/VDzP7+eI7NawGxe8N8bucpZBSmyyIJQw1RHRtdi2tOpl6QuBm/+L
	 aNjfOvRL6V2syLJt/UUb2Ue3dsT7fVlFSSHfAu+IrlAx8FS1BvBEkD0naTCJXB4YJQ
	 /1gP29XdpE5vw==
Date: Wed, 27 Mar 2024 17:41:03 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
Subject: Re: [PATCH v2 6/6] mm/mm_init.c: remove arch_reserved_kernel_pages()
Message-ID: <ZgQ-D5Gpvr_LJM-Z@kernel.org>
References: <20240325145646.1044760-1-bhe@redhat.com>
 <20240325145646.1044760-7-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325145646.1044760-7-bhe@redhat.com>

On Mon, Mar 25, 2024 at 10:56:46PM +0800, Baoquan He wrote:
> Since the current calculation of calc_nr_kernel_pages() has taken into
> consideration of kernel reserved memory, no need to have
> arch_reserved_kernel_pages() any more.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/powerpc/include/asm/mmu.h |  4 ----
>  arch/powerpc/kernel/fadump.c   |  5 -----
>  include/linux/mm.h             |  3 ---
>  mm/mm_init.c                   | 12 ------------
>  4 files changed, 24 deletions(-)
> 

