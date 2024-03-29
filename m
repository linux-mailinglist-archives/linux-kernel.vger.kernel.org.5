Return-Path: <linux-kernel+bounces-125259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EBB8922F0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFBB1F250FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DBE136E01;
	Fri, 29 Mar 2024 17:43:30 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1217A923
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711734209; cv=none; b=aL9+CjbSr9NtWy+c/plfpjZUQnmjM2OKBm4FQj1epaAWiTRF35dbOjQGnUgyJNnF8fcoIq3u3SVUCHrncTC3cVzxxBZIoa9H86xBmnI3HKBfUe2vOrCaKjVGcK4wOU4vKzdRDcdwRwOrTCTQPdS1oWid/IghCG462Q49uvqCg2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711734209; c=relaxed/simple;
	bh=v4exPhlwMVCowKtVo0H5olZ5yCVgiSussHYwa5vgczQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLXzkemELJhmkQYtlOXjML7Ecl9glhTLkM2GfKgYupDGRdm7opYdbF+rEcpnmefFjA1HewGMWPu3W44nzkXnL50HIEa3LZkfdDnKOeD5qnGjX7N57COH5fD5csuCUUAd0nnfl6gfVvP5wS83ZOvegjH6EqxjGtS3yYNUqg5sy4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id d7edf15f-edf3-11ee-b972-005056bdfda7;
	Fri, 29 Mar 2024 19:43:25 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 29 Mar 2024 19:43:24 +0200
To: Armin Wolf <W_Armin@gmx.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1 1/1] platform/x86: quickstart: Miscellaneous
 improvements
Message-ID: <Zgb9vPkaR9V8hbic@surfacebook.localdomain>
References: <20240327215208.649020-1-andy.shevchenko@gmail.com>
 <a2362908-feab-416c-b5ae-13d560089ee6@gmx.de>
 <CAHp75VcnsxanOpP+v+EFqpO1TLXyuz1_55Qvttrib9=T1Y1Y+Q@mail.gmail.com>
 <1ff02eec-084b-4d4b-9629-cd1a104e6213@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ff02eec-084b-4d4b-9629-cd1a104e6213@gmx.de>

Fri, Mar 29, 2024 at 01:23:25AM +0100, Armin Wolf kirjoitti:
> Am 28.03.24 um 09:50 schrieb Andy Shevchenko:
> > On Thu, Mar 28, 2024 at 1:35 AM Armin Wolf <W_Armin@gmx.de> wrote:
> > > Am 27.03.24 um 22:52 schrieb Andy Shevchenko:

..

> > > > -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > that is the reason for removing this?
> > Yes, it's a dead code. Likely the cargo cult line was copied from
> > another driver.
> > 
> In that case: Reviewed-by: Armin Wolf <W_Armin@gmx.de>

Thank you!

You need to use a whole line for the tag.

P.S.
It seems Hans hadn't folded anything from here, so I will send a patch
(series?) next week.


-- 
With Best Regards,
Andy Shevchenko



