Return-Path: <linux-kernel+bounces-64806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AB7854307
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10FA81F23FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5E9111B7;
	Wed, 14 Feb 2024 06:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IDHHGp6S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A4B1119B;
	Wed, 14 Feb 2024 06:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707893015; cv=none; b=oTKAu75z6AqvXWuWxVnuz+6wbgzYmulQf8BUy3rljwh+5utCz6JcTY4eFZto7yXhaT3OG2AOvaKytWIXkC42Wj63j/Bf/irjU10MFVnwuVWc+T43AHp5IQSN/vcfApsE2OblvFPEAlmxYgp5yLmWCqxUzqRfXXQJfjTBFnM7xt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707893015; c=relaxed/simple;
	bh=l0OlVPwnAA/BNoPYrpxmb0JNzdB35f0E0pfIwlxJRVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euKSLWkcfiGBwVNXQJP39exbdRvZNkdP7CdBIeRhjAAj5KrnlcdJmYdegIqSf+H0jCdEQJAZd7OeaiS/KJbwznAaSx2q+frmUuM6XCN1xWs4PU7CdLTpdeUJBoDlFQIKw87hJiegd/TmNUKRZ8p+3M8GD2qCLQhAhUpPPsEgAD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IDHHGp6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994B8C433C7;
	Wed, 14 Feb 2024 06:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707893015;
	bh=l0OlVPwnAA/BNoPYrpxmb0JNzdB35f0E0pfIwlxJRVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IDHHGp6SmQ6hKT0WvGQTgkoC9BFQAX3vZaQlniWuUg90li5YMGtejyqLlX2ZhnBQF
	 eBkpAE1vdKpQ7qIWcYUP1nfvJvjRKMUPHGODR04CbNfzeOnCY2Ec/FIYIFNqIwrFiy
	 40RXus3X8i2k6t5nKCQ8ZE7xLCyzdryujSyPR9gM=
Date: Wed, 14 Feb 2024 07:43:32 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024021445-emporium-tightwad-3c35@gregkh>
References: <2024021314-unwelcome-shrill-690e@gregkh>
 <202402131429.A604440C6@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402131429.A604440C6@keescook>

On Tue, Feb 13, 2024 at 02:35:24PM -0800, Kees Cook wrote:
> On Tue, Feb 13, 2024 at 07:48:12PM +0100, Greg Kroah-Hartman wrote:
> > +No CVEs will be assigned for unfixed security issues in the Linux
> > +kernel, assignment will only happen after a fix is available as it can
> > +be properly tracked that way by the git commit id of the original fix.
> 
> This seems at odds with the literal definition of what CVEs are:
> _vulnerability_ enumeration. This is used especially during the
> coordination of fixes; how is this meant to interact with embargoed
> vulnerability fixing?

Yes, this is totally wrong, it was the original first draft of the
document, that I did on my workstation, and then went on the road for 3+
weeks and I never sycned up when I got home with the updated version
that is on my laptop.  The updated version addresses this, as it was
rightly pointed out by the CVE group that this is not how a CNA is
supposed to only work.

Yet another reason why keeping changes private is a major pain, not only
for security ones!  :(

Let me send out the proper one after my morning coffee has kicked in and
I resolve the differences, and make the grammer fixes that Randy pointed
out...

> Outside of that, I welcome the fire-hose of coming identifiers! I think
> this will more accurately represent the number of fixes landing in
> stable trees and how important it is for end users to stay current on
> a stable kernel.

Agreed.

> Reviewed-by: Kees Cook <keescook@chromium.org>

Many thanks for the review!

greg k-h

