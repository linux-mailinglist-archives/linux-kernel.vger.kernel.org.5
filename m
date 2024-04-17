Return-Path: <linux-kernel+bounces-148173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 410268A7EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D980D282F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813ED129A73;
	Wed, 17 Apr 2024 08:49:29 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0E37E0E4;
	Wed, 17 Apr 2024 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343769; cv=none; b=e+gkmDD5F31ERj2Un5FcPQYhsqCt+7wMifKQztEknmyMZmnscEpl2eWEhl64iJpIJMnplSU3QixBT9mdL02RW5YnZHXncq82aKKpf77SmKqtTljP6BzSVyao087KDFPtchTlkYbOZjnQDpel8utF9O9+qcGLfh7HPFlD6X26DZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343769; c=relaxed/simple;
	bh=QleLA9s4+43LuL1szIRacuB5JOEhYMc3+71IZgYdmuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfQnaxhkxTA8fvsQvuAcpOpphUFktIVpHOGDpIRte4sharh1OIjwPUnHTj3lT4LGpbnuVRgf9DjRNnlcWnqMRulnEOprfWpVxiVnEQkSfjEdGt3xmAAeV350a+3ZFoZR7GX2dkgsdQuS/2kPlzFkGzmdiiXm8Ci3yQq9u1w5hbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 43H8muYu024470;
	Wed, 17 Apr 2024 10:48:56 +0200
Date: Wed, 17 Apr 2024 10:48:56 +0200
From: Willy Tarreau <w@1wt.eu>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>, helpdesk@kernel.org,
        "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Please create the email alias do-not-apply-to-stable@kernel.org
 -> /dev/null
Message-ID: <Zh+M+NWKbpQeT/Z6@1wt.eu>
References: <b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info>
 <20240417090918.77360289@sal.lan>
 <2024041715-calorie-late-c4de@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041715-calorie-late-c4de@gregkh>

On Wed, Apr 17, 2024 at 10:16:26AM +0200, Greg KH wrote:
> > at the scripts used by stable developers - and maybe at the ML server - to
> > catch different variations won't hurt, as it sounds likely that people will
> > end messing up with a big name like "do-not-apply-to-stable", typing
> > instead things like:
> > 
> > 	do_not_apply_to_stable
> > 	dont-apply-to-stable
> > 
> > and other variants.
> 
> I want this very explicit that someone does not want this applied, and
> that it has a reason to do so.  And if getting the email right to do so
> is the issue with that, that's fine.  This is a very rare case that
> almost no one should normally hit.

For using a comparable approach in haproxy on a daily basis, I do see
the value in this. We just mark a lot of fixes "no backport needed" or
"no backport needed unless blablabla" for everything that is only
relevant to the dev tree, and that's a huge time saver for those working
on the backports later.

Maybe "not-for-stable" would be both shorter and easier to remember BTW ?

Regards,
Willy

