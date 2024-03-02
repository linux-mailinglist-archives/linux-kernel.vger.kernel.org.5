Return-Path: <linux-kernel+bounces-89289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D2786EDC4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AAC62875A4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E0263D5;
	Sat,  2 Mar 2024 01:18:46 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254732904
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 01:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342325; cv=none; b=VHzXPND1XYuTM2/MdNssSKrzluAqFX80dAL0qJ7ckWWe+VkOmmp+4HNObCsgY3fws3oz+l3i60YghNjKwjjkq2+DZErPeXqUCIgaSuX2osLeFqTF/bMSkRitAncjgOvwA+irkoYouZGbaSVDibvdrtVpxlf9tic1W27hZKLATvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342325; c=relaxed/simple;
	bh=m0IPqXx7Wg24y/7JRaaKK28MS12xs2UN/ny1kNF25Gs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u33DEIVjq4F/Fdt8v9FRgmeTt/eeTV30oyFlVQdMKUWmbRqYCD2ximIWBKNg/k2pdRr9SiMffqaKUsQ4iFvCPkQtOFCRg+6YzL3STstAau6D682Y/wvV6KCZoQBK43tXu/0GqjgCIYydkaXRpU5v+G4lMDyrfy992jKVwn3LbtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id a5064544-d832-11ee-a9de-005056bdf889;
	Sat, 02 Mar 2024 03:17:33 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 2 Mar 2024 03:17:32 +0200
To: Kees Cook <keescook@chromium.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] compiler.h: Explain how __is_constexpr() works
Message-ID: <ZeJ-LAkSxwBlr9_v@surfacebook.localdomain>
References: <20240301044428.work.411-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301044428.work.411-kees@kernel.org>

Thu, Feb 29, 2024 at 08:44:37PM -0800, Kees Cook kirjoitti:
> The __is_constexpr() macro is dark magic. Shed some light on it with
> a comment to explain how and why it works.

I was under impression that somebody did it already once and it fell through
cracks when has been moved (?) to compiler.h.

Ah, now I see it, https://lore.kernel.org/all/YKeghxRY4FeOKuwb@smile.fi.intel.com/.
It was asked, but till now never fulfilled (maybe Reported-by:/Closes: tag?).

And explanation before was given here:
https://stackoverflow.com/questions/49481217/linux-kernels-is-constexpr-macro.

-- 
With Best Regards,
Andy Shevchenko



