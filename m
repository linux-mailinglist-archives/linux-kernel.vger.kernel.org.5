Return-Path: <linux-kernel+bounces-69377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 688BD85883E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 190A5B20E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820211474C0;
	Fri, 16 Feb 2024 21:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMIhvrla"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E981468ED;
	Fri, 16 Feb 2024 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708120276; cv=none; b=kyXSkN1V19yKgtntCaPlf5T/d44wmLCfH6sC3ks50fk9HSPZj3UV0dKgK8JxtQRjgzkGUj9fHz2SCKAHvnPoWkUmLgtw6brbK0Ixdryx2mrPph3piUf6cebiSwZyVpGyrFs24aU2F3iNYyrCYpG27Ykdqr/Z9dIyyJpRM7CcfQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708120276; c=relaxed/simple;
	bh=JF4vSGOWiwOROcwPNJNnbsYCsYWSecwg65mWjX3IxSw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BnKEhEDoyMftzlgYeEIg+ObllBfRK0aiEeTlQr9x24NhoS5iBW4kiFdgZJA98xyWzlFtTQ2bOqSXpbuaHb6QJyuDRHtQFZmZx7qcTegdWm0NyHy1m4q73x+M1cGoIQPJ4YPbjhwMdBpOuCCZFdC/HLLvI4DaeBzIHbxwmzWN7Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMIhvrla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8ED0C433C7;
	Fri, 16 Feb 2024 21:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708120276;
	bh=JF4vSGOWiwOROcwPNJNnbsYCsYWSecwg65mWjX3IxSw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=oMIhvrlaKWo4lDJjR0rLa59/c12XzNJZNIO1JaguI87huxQMx0Rmmg5ho0edc3daF
	 tfYUQ+QneKXKD10pB3+/EqQWkcgcD0FJebfOMNMXvLg6xf2Zz2r1+HzVrXshfw5Y6X
	 WRpc3NNdLkTp9kmKY2ATNqSG2SsRSHkwU848FrueQ3rFT4mKk2omJ3iusthyYFQy+W
	 S4LJbh64osctiKEmA6K7VhF4HWYSNoeOqpBvbVqk3VkKka9wpxEdjsCTu2aEkhy1OZ
	 Vejzhe4a9Toh0NYk7ip6IAoa3KDDzDS9aFGGc0HVMXyRVwWXoPwwQFyDT2ppHPYjot
	 a9fQ7kGkYo29w==
Date: Fri, 16 Feb 2024 22:51:16 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
cc: Josh Poimboeuf <jpoimboe@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, corbet@lwn.net, 
    workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org, security@kernel.org, linux@leemhuis.info, 
    Kees Cook <keescook@chromium.org>, 
    Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
    Krzysztof Kozlowski <krzk@kernel.org>, 
    Lukas Bulwahn <lukas.bulwahn@gmail.com>, Sasha Levin <sashal@kernel.org>, 
    Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v4] Documentation: Document the Linux Kernel CVE
 process
In-Reply-To: <20240216214521.GC549270@mit.edu>
Message-ID: <nycvar.YFH.7.76.2402162247380.21798@cbobk.fhfr.pm>
References: <2024021500-laziness-grimace-ed80@gregkh> <20240216192625.o3q6m7cjgkwyfe4y@treble> <nycvar.YFH.7.76.2402162108370.21798@cbobk.fhfr.pm> <20240216214521.GC549270@mit.edu>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 16 Feb 2024, Theodore Ts'o wrote:

> My observation is that the old system has had pretty low-quality
> CVE's, and worse, overly inflated CVE Severity Scores, which has
> forced all people who are supporting distro and cloud serves which
> sell into the US Government market to have to do very fast releases to
> meet FedRAMP requirements.  At least once, I protested an overly
> inflated CVSS score as being completely b.s., at a particular
> enterprise distro bugzilla, and my opinion as the upstream developer
> was completely ignored.
> 
> So quite frankly, at least one enteprise distro hasn't impressed me

Sad to hear that, no matter which distro that was :), hoewer ... 

> with avoiding low quality CVE's and high CVSS scores, and so I'm quite
> willing to give the new system a chance.  (Especially since I've been
> told that the Linux Kernel CVE team isn't planning on issuing CVSS
> scores, which as far as I'm concerned, is *excellent* since my
> experience is that they are quite bogus, and quite arbitrary.)

.. how is this new process going to change anything in that respect? 

There will always be some entity assigning a CVSS score (apparently not 
the kernel.org/LTS group), and then odds are the situation you are 
describing will end up happening according exactly the same scenario, 
right?

I am still trying really hard to understand what exactly is the problem 
this whole effort is magically solving for everybody out there either 
using Linux, or producing something around/on-top-of Linux. And I still 
don't get it.

Thanks,

-- 
Jiri Kosina
SUSE Labs


