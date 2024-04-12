Return-Path: <linux-kernel+bounces-142045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BD88A26B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F501F2424A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6624087B;
	Fri, 12 Apr 2024 06:34:44 +0000 (UTC)
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDCE47F73;
	Fri, 12 Apr 2024 06:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903684; cv=none; b=YGr/pBC4KdT+5sfTsIloWBzuOth4BTWjwRkCT+kVvGqOD/Q/fa7zgGi7k2kqAwzowWSltdF6Yy7XDrioEzwM2X5Y8M+78SDSxQWBI6q1whK+1MT3TgGf+wbbJ2wvnNw+A3Ysw3evmtDnZzFPDpic9fly5KeKstELYRjO6bqNUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903684; c=relaxed/simple;
	bh=YimORL+yJ1Jg4ENKctqEw1m3ZDIHqs2suc/Ktwhr3Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+FDNM4RUSMzIhzNKj+ZYPNAKTahBCnwko10j6H/dUoS4XHaolG4jsu0SlKw1d/UCetKm35aPdiZj5avIaEYLU/m5gMqnIc4BHtCiytww1el16ONqyl/jQwE2qf61HvE+riIZefQxSEq4ljnNqwMGncaGS3jknnZLSnsgg45ui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Fri, 12 Apr 2024 08:34:31 +0200 (CEST)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id EE57E8053B;
	Fri, 12 Apr 2024 08:34:31 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id E04A5180C43; Fri, 12 Apr 2024 08:34:31 +0200 (CEST)
Date: Fri, 12 Apr 2024 08:34:31 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc: "Valerii Chernous -X (vchernou - GLOBALLOGIC INC at Cisco)" <vchernou@cisco.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	"xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Add MO(mod objs) variable to process ext modules with
 subdirs
Message-ID: <ZhjV90qSCPSyWiBh@buildd.core.avm.de>
References: <20240405165610.1537698-1-vchernou@cisco.com>
 <ZhfLrGrED-ls6i5V@buildd.core.avm.de>
 <ZhgdjpE+yl3IYSzl@goliath>
 <Zhg5L2xO_lT4lLwp@fjasle.eu>
 <ZhhNAQtV3StbaA4z@goliath>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhhNAQtV3StbaA4z@goliath>
X-purgate-ID: 149429::1712903671-2B7DCE5F-99954997/0/0
X-purgate-type: clean
X-purgate-size: 2978
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Thu, Apr 11, 2024 at 08:50:10PM +0000, Daniel Walker (danielwa) wrote:
> On Thu, Apr 11, 2024 at 09:25:35PM +0200, Nicolas Schier wrote:
> > On Thu, Apr 11, 2024 at 05:27:42PM +0000 Daniel Walker (danielwa) wrote:
[...]
> > > If that were true we would not have driver/uio/ for example. It seems like
> > > Cisco and NVM should work together produce a solution.
> > > 
> > > You could run into this issue even with entirely in tree modules. For example,
> > > we may have a v6.6 kernel but we need some modules from v5.15 for some incompatibility
> > > reason in v6.6. Then we may build the v5.15 modules as out of tree modules
> > > against the v6.6 kernel.
>  
> All problems should be fixed or worked around. One bit of code maybe isn't
> the best choice or maybe another is, but not fixing or working around the
> problem is not really an option.

Let me sum up: It is possible to build out-of-tree kmods with subdirs
in their source tree.
The patch attempts to put support for _out-of-source builds_ of
out-of-tree kmods with subdirs into kbuild itself.

If you really out-of-source builds for your complex out-of-tree kmods,
than, as a "work-around", you can simply put those 'src' override lines
into your oot-Kbuild files.  But you probably know that already, right?

> > If your in-tree module in question does compile and run properly in v5.15 and
> > in v6.6: why don't you just compile it in-tree in v6.6?  Which driver/module do
> > you refer to?
> 
> I believe it was this driver drivers/crypto/marvell/octeontx2 . I don't recall
> every aspect of the issues but it has to do with what Marvell supported in their
> SDK and the exact hardware we were using and the bootloader we had on the
> product.
> 
> > > You also have just normal developers making kernel modules which always start as
> > > out of tree modules before they are upstreamed. Those modules could be any level
> > > of complexity.
> > 
> > I do not agree, but there is no need to convince me as I am not in the position
> > to decide between acceptance or denial.  I just thought it might be fair to
> > warn that I do not expect acceptance.
> 
> I think it's incorrect, unhealthy even, to look at it that way. If your using
> Linux to make a product and you have an issue, it should be consider as a real
> issue. Not something maintainer can just discard. Unless the maintainer has
> a suggestion to do what is needed or different code to do it.
> 
> Daniel

Daniel,

I am confused about the outcome from your argumentation that you might
expect.  And I think, I as a spare-time reviewer (not maintainer), am
not the one you want to argue with.

If you have a concrete technical issue or bug, please explain it
concretely to linux-kbuild and we will probably find someone trying to
help you.  If you want me to hide critical thoughts when reviewing
patches under your pillow, then please tell me so.

Have a nice weekend,
Nicolas

