Return-Path: <linux-kernel+bounces-5859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A6F819065
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3DB1C24032
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AA738FA8;
	Tue, 19 Dec 2023 19:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IdzX9CEQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03D839AD1;
	Tue, 19 Dec 2023 19:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E03C433C8;
	Tue, 19 Dec 2023 19:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703013056;
	bh=/rG2E/TZNUgrQqdmZq7A5rdxeb0Ivy93L+M55L5o9+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IdzX9CEQWfUleGznBf/Sv2ylanAKdM8bLKfeNZl83nKdC+bvv3wrditxfCVHCu9lr
	 OIgKIupw93HNK+v6PmHhW/6E2J+69jZ02SnkQo6ZsQ96q1orv9t8cKoD5TOT3mKjpd
	 zO/TD6xi2hlobV61cVMnjdHVexLolzUViu1yRrGw=
Date: Tue, 19 Dec 2023 20:10:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tanzir Hasan <tanzirh@google.com>
Cc: Kees Cook <keescook@chromium.org>, Nick DeSaulniers <nnn@google.com>,
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 1/2] kernel.h: removed REPEAT_BYTE from kernel.h
Message-ID: <2023121928-propose-florist-5898@gregkh>
References: <20231219-libstringheader-v4-0-aaeb26495d2f@google.com>
 <20231219-libstringheader-v4-1-aaeb26495d2f@google.com>
 <2023121938-stargazer-purse-0dc1@gregkh>
 <CAE-cH4p-TzH3zyJfmSg3r=fw78j8y-0t0dp-NvaLyVYAMULw1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-cH4p-TzH3zyJfmSg3r=fw78j8y-0t0dp-NvaLyVYAMULw1w@mail.gmail.com>

On Tue, Dec 19, 2023 at 10:35:55AM -0800, Tanzir Hasan wrote:
> > Legal note, this file is NOT copyright Google as no Google employe
> > actually wrote the logcal contents of it.
> >
> > Please be VERY careful when doing stuff like this, it has potentially
> > big repercussions, and you don't want to have to talk to lots of
> > lawyers a few years from now and explain how you messed it all up :(
> 
> Ah, sorry, I didn't realize. Will change right away.
> 
> > Nick, odds are there's a Google copyright class that Tanzir should take
> > here, if not, I recommend the free LF one that anyone can take online
> > that explains the issues here:
> >         https://training.linuxfoundation.org/training/open-source-licensing-basics-for-software-developers/
> 
> I will take a look, thanks!

Please take the time to either learn what the Google-specific rules are,
or take the above training, before submitting a new version of the
patch.

thanks,

greg k-h

