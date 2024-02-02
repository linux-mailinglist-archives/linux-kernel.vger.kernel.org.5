Return-Path: <linux-kernel+bounces-49368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B24F846941
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58BC81C21A7E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EA0179AE;
	Fri,  2 Feb 2024 07:27:16 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4377617998;
	Fri,  2 Feb 2024 07:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858835; cv=none; b=TdvEa8nxtcVZX3gX0CJlhhpeSE8WD8TZo+cHokw1/bDCkDVVZc55H8lub2bcVtj12qwnPoepGCaSiEtb3M0sl5jgTRBGFufHvgPP04Zlf1sYTOJWBjHvimGaMtB+tAhHuD9caK2kJYMeWP/4jIPbu/Gpq0vqhekFkYsZBNikg9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858835; c=relaxed/simple;
	bh=dZ82q8E1RIK1gXQuQuhfhP/EeXFpgRPT6dVb7CflZRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkgwHBQu5gbnolGCJ55opYUYga9eBRc+cj1ifIpFFS4sUHjuIwBFsD1jyQdfVlvm/cCOoVLhFFbvKP1eLSeUoTScx9n/schej1xlrQQHyUwlqYLPl964WPwtWKC+kj3OX9PncqijPUs0D0ZHtTIklTmHbQR12/ida38+Ccz6vf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4DE13227A88; Fri,  2 Feb 2024 08:27:09 +0100 (CET)
Date: Fri, 2 Feb 2024 08:27:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrew Kanner <andrew.kanner@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, mcgrof@kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	mchehab@kernel.org
Subject: Re: [PATCH v1] module.h: define __symbol_get_gpl() as a regular
 __symbol_get()
Message-ID: <20240202072709.GA5403@lst.de>
References: <20240131190251.4668-1-andrew.kanner@gmail.com> <20240201052958.GA14943@lst.de> <65bb648c.190a0220.d431d.4f63@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65bb648c.190a0220.d431d.4f63@mx.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 01, 2024 at 12:29:46PM +0300, Andrew Kanner wrote:
> Of course not, no new users needed.
> 
> I haven't discussed it directly. I found the unused __symbol_get_gpl()
> myself, but during investigation of wether it was ever used somewhere
> found the old patch series suggested by Mauro Carvalho Chehab (in Cc).

Ah, ok.

> 
> Link: https://lore.kernel.org/lkml/5f001015990a76c0da35a4c3cf08e457ec353ab2.1652113087.git.mchehab@kernel.org/
> 
> The patch series is from 2022 and not merged. You can take [PATCH v6
> 1/4] which removes the unused symbol from the link.
> 
> Or I can resend v2 with my commit msg. But not sure about how it works
> in such a case - will adding Suggested-by tag (if no objections from
> Mauro) with the Link be ok?

Either is fine.  I actually have a patch removing it somewhere in an
unused tree as well :)

