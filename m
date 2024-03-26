Return-Path: <linux-kernel+bounces-119604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC86A88CAFA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D81AB27E62
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B941CFB9;
	Tue, 26 Mar 2024 17:33:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7851CD2D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474397; cv=none; b=hWCz6xLaGZqX+Vpv76B9Whv2SCQwdP6MbCGIZuPJl63RfgvoD3Gaav15xhdntCdv0J2bGfnq0NZyscQA8ZZANl7IETuB+iQtsjAz/1xl3BegvhnvENmkkuJBJHWM+rDM1kj7stLmiBzjicv5Yl8/m1xpKoOtyJrSHk3VlPgGsn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474397; c=relaxed/simple;
	bh=A4W9NkeL4SqI0Nxei+oIQ5wA6NWT8IY5yqEh9Ua2fTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLbdwJAWXo00/2Vgh44eA1jWTSPPUaa1mDxQq6JS1+IxJ3i9QATrfTYac3ZGVF0rgaKRvkjpaJ2c5u0VOrhh3B5uNSVKJhbLUAD7SEHfqMl+Rh3paYMTSOjRkTEeNtGz8Sjoot3joxcW/b54FnzQGMOFvDAmJ/4uyaFkYRpbBj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FA4C43390;
	Tue, 26 Mar 2024 17:33:15 +0000 (UTC)
Date: Tue, 26 Mar 2024 17:33:12 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/kmemleak: Compact kmemleak_object further
Message-ID: <ZgMG2DOyL6qwfBfr@arm.com>
References: <20240307190548.963626-1-longman@redhat.com>
 <20240307190548.963626-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307190548.963626-2-longman@redhat.com>

On Thu, Mar 07, 2024 at 02:05:47PM -0500, Waiman Long wrote:
> With commit 56a61617dd22 ("mm: use stack_depot for recording kmemleak's
> backtrace"), the size of kmemleak_object has been reduced by 128 bytes
> for 64-bit arches. The replacement "depot_stack_handle_t trace_handle"
> is actually just 4 bytes long leaving a hole of 4 bytes. By moving up
> trace_handle to another existing 4-byte hold, we can save 8 more bytes
> from kmemleak_object reducing its overall size from 248 to 240 bytes.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

