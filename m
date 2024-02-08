Return-Path: <linux-kernel+bounces-57595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F05484DB28
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3015B23E24
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E85D6A33E;
	Thu,  8 Feb 2024 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="UrW0HwCE"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071226A330
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380073; cv=none; b=qNUpMnp+r9QWRXDn+hmGa0D9+PO8EQ7NS64N4AGdsU8b5aVJ10qKQfuC7zpBhvmPRmFHbIh63ZYPDdKrrre65EJQG9jV8jtGwGju3/pNXrms/1eAe3hTIQMHYGNKoa6Cu5aGK7mG1g4yAesmzEJR7rgF5oTV29JMLVDW0x769jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380073; c=relaxed/simple;
	bh=lBH0sY/JdNNXlmRGdJWJ0L16jp5wNypK4GTr0/VBtdA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYvfD5CLqx/GR0A7qc0utMA7YQsSCI/+mCprFT8JQ+8ENt6g0YBEWDxfumMSLSiilKTA0m6WyC9Qu0u8qFjp03F2mh2c4R3m8/PSaBPq8Y5FrQttOgfJ/OS35IQ5oz81lmp79DmUQmW3RwVM/vxmslWCpyKVuRBU/5+0tTViikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=UrW0HwCE; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id C8C3B176FC4; Thu,  8 Feb 2024 08:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1707380065; bh=lBH0sY/JdNNXlmRGdJWJ0L16jp5wNypK4GTr0/VBtdA=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=UrW0HwCEOmz/aurKT9ceXf1OFjX1tpk5HUAWy1MDqlXR5B2zb90NIWpKwvjMEvo/z
	 Qkg8Xtjd8JUIcsT9TPk2Kz/I3ya5kqhah5aDTdkWl8Rgz+Q2ocgyJnjvWhkFPo0K6B
	 SWOWa1ZwSXaKRxcCqD9cXsCuEwjXAbQSczJUVvxppmX1JE/dZoWwmbPRvis3UyEw5O
	 Adt30ztbolZ54H5L+OklAwHOswuvDEr/qZSYToubbyOGC58XnQV0DNdlT98EdOhkM2
	 rlNAq2kOMnTn4xwWah1b2jZBjzep4J6TL9HaosWWS84JIpZPPTjqs6aG6X5NcH69oz
	 HAOQ7msYRDSpA==
Date: Thu, 8 Feb 2024 08:14:25 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: add boot param to disable stack dump on panic
Message-ID: <20240208081425.GA1511946@lichtman.org>
References: <20240206213902.GA1490631@lichtman.org>
 <ZcLmjrBxE2BA_hLG@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcLmjrBxE2BA_hLG@archie.me>

In a lot of cases when there is a kernel panic it obscures on the display the previous problem that caused it and the main
reason is that the call stack prints a lot of lines on the display - and there is no way to scroll back up.
What led me to make this patch is that I was working on running the kernel on my old computer and when I passed root=/dev/sda
to the kernel there was a panic and it could not start init, but since the call stack took almost all the space on the screen,
I couldn't see the available partitions the kernel does detects.

After this patch, I could just pass in the new boot parameter I added here and then it would not print the call stack,
and I saw the line in which the kernel prints the available partitions.


On Wed, Feb 07, 2024 at 09:10:22AM +0700, Bagas Sanjaya wrote:
> On Tue, Feb 06, 2024 at 09:39:02PM +0000, Nir Lichtman wrote:
> > From: Nir Lichtman <nir@lichtman.org>
> > Date: Sat, 3 Feb 2024 10:19:30 +0200
> > Subject: [PATCH] kernel: add boot param to disable stack dump on panic
> > 
> 
> Can you describe why this patch is needed (or beneficial)?
> 
> Confused...
> 
> -- 
> An old man doll... just what I always wanted! - Clara



