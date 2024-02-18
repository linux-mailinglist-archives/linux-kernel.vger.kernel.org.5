Return-Path: <linux-kernel+bounces-70333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7EB859631
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 11:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715CC2831D3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AD83714E;
	Sun, 18 Feb 2024 10:22:45 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243C01B7F2
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708251764; cv=none; b=m3t+ZmQ8PNgThSo/dzajX5vM9LetqyiBm8a0jiwCecVJU54jpYWu91e0AiPQXg8SUz18BOKu6iqWTfyj8s6wQFnHIblxtwb2K4wAk+g3NGjGPdGiV5gKdm0liiM7Uqs9gBI22zXDaHe7ve1O/bnfeH03NH5NyFxaQMCmovGXlTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708251764; c=relaxed/simple;
	bh=gnuJ8aBOF5KQ/U+nEFYhni6Lx6+TUwWlZzTwjXaN4ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gn0vrNuNDFj5iJmZErMLgWJVFBahiCxopkm27MHkA5lnNJWPBXPQpSDioXGgOAUbUF/gjY2lAti/eOsBfRBDicB5+4lSeGMuhdoLg705m6WmUg8IBl9lgejP5fCn3XWCXv9Uhq3u5wN8vvrQn86WKzeGZjuBVn8XvRiz+6OpGV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 41IAMbtZ032424;
	Sun, 18 Feb 2024 11:22:37 +0100
Date: Sun, 18 Feb 2024 11:22:37 +0100
From: Willy Tarreau <w@1wt.eu>
To: Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] tools/nolibc: Fix strlcat() return code and size
 usage
Message-ID: <20240218102237.GB32375@1wt.eu>
References: <20240129141516.198636-1-rodrigo@sdfg.com.ar>
 <20240129141516.198636-3-rodrigo@sdfg.com.ar>
 <20240211104817.GA19364@1wt.eu>
 <10b97cd3-5690-40b2-aa8e-3fea5dd4275f@sdfg.com.ar>
 <197c0910-f1e5-4e55-81a3-59cb2069a1d7@sdfg.com.ar>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <197c0910-f1e5-4e55-81a3-59cb2069a1d7@sdfg.com.ar>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Feb 14, 2024 at 07:03:10PM -0300, Rodrigo Campos wrote:
> On 2/14/24 16:34, Rodrigo Campos wrote:
> > size_t strlcat_rata(char *dst, const char *src, size_t size)
> > {
> > 	const char *orig_src = src;
> > 	size_t len = 0;
> > 	for (;len < size; len++) {
> > 		if (dst[len] == '\0')
> > 			break;
> > 	}
> 
> If you think about it, this is strnlen() and what follows is strncat().

I agree, I just didn't remember we had strnlen() nor strncat().

Willy

