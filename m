Return-Path: <linux-kernel+bounces-72776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B203885B894
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE11D1C216C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A87360ED3;
	Tue, 20 Feb 2024 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zwcJ9Awi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C3660861;
	Tue, 20 Feb 2024 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423663; cv=none; b=NHbzkXaUlk28KaI+j2tPXkSysEIqUhIuwHGLMLGf3Nec6FR0sg6nL+seT9YbtPgAF8lcoLetOl0mLBKYIyP+RYT7XzhV+g/Ed4v6xkClUeY/VbWZiVNHgmUOHEd0bp1cA1dU+trTwIqe9d/n4ioz7B0egPXwOYmXZEHGBG8Nn88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423663; c=relaxed/simple;
	bh=RaPKTKboa8gxjYiGIH9BrKC6Nz2Z5V07v5yrPMrw7do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVlcxvMLDs+e57vR1nGmn1ouoBkQqsXsyQyKS6Zx88wPbtdt0lOwXg6aCEsM8vRwv3mIxZ7mjVEnhtbalw0iLKNriq32xyO09nUyqLUaOxDhw8YLItYA0PjMoE4yH0Atwt/yl0BeO/S4sr7XClurm+wx+qYocVHQvzkUDmJzDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zwcJ9Awi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712B5C433C7;
	Tue, 20 Feb 2024 10:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708423663;
	bh=RaPKTKboa8gxjYiGIH9BrKC6Nz2Z5V07v5yrPMrw7do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zwcJ9AwiPEbFJ7O9Y7XT1v8ZaFdscmDO3msqjEazxqF/Rib6Jj4YujIIHoOE0izBc
	 1daiUz5eNCz8LBUxQB3VngCkgAVv7JnhmxztniMXKmqZmkewHdyEo8JvxjEicAFcRt
	 6kAlFh1Kj4+W+k7THF1H/orF0oUZgWOczHJFC6n4=
Date: Tue, 20 Feb 2024 11:07:38 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	linux@leemhuis.info, Kees Cook <keescook@chromium.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v5] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024022042-raisin-catalyst-2fae@gregkh>
References: <2024021731-essence-sadness-28fd@gregkh>
 <1a26d598-0063-447a-a79b-16315d2899ca@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a26d598-0063-447a-a79b-16315d2899ca@oracle.com>

On Tue, Feb 20, 2024 at 11:03:17AM +0100, Vegard Nossum wrote:
> 
> On 17/02/2024 13:55, Greg Kroah-Hartman wrote:
> > +A list of all assigned CVEs for the Linux kernel can be found in the
> > +archives of the linux-cve mailing list, as seen on
> > +https://lore.kernel.org/linux-cve-announce/.  To get notice of the
> > +assigned CVEs, please `subscribe
> > +<https://subspace.kernel.org/subscribing.html>`_ to that mailing list.
> 
> Is the list open to discussion as well? (e.g. impact, analysis, etc.)

It's read-only, sorry.

> Or is this meant to be purely as a log of assignments?

Yes.

> What sort of content is (not) welcome? Should this be mentioned in the doc?

As it's not able to be posted to, not much to mention :)

If you wish to discuss something about it, follow the reply-to that is
set for a message there.

thanks,

greg k-h

