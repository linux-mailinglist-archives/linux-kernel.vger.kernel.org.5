Return-Path: <linux-kernel+bounces-65359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BB6854BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E23A1F217CF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194A75B03B;
	Wed, 14 Feb 2024 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EV0n9M0C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCFB55E44;
	Wed, 14 Feb 2024 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921972; cv=none; b=WLpbPnjxElEtI+I8I8krtMs0PjVsgF0ajuNsJxPadLxXdCdQUG7mmiB+2AfpwzaQ0ywsIau6SsNS1WGIUSd+fuBwgUgK4YFB51HhQPBxP6Jojak8Z0J7JqxLRulhzuWhECJDI8fIQA5F+k/9RlzyEJiJdDaxx+tL68crdcBkeuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921972; c=relaxed/simple;
	bh=c+xjim88bHayo1cK2qBTU6PJqAH/5WT7kzZO5iz1EKU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SmHiZqo3qXkvlsSO2mkT+9n6q+TsDgyPQ1iNr3CCaNw/b9rdKRv+2ZhJdq7Pt/eUM0IWi14Z+lnLqFdGi1hvkDksSyaC+fGTiLToXQ1KYat6SNrYv/CL0dJxT79zxZ2tSJxVeXf4YsoJ2//AcNYLh8gkH7dhyOw7bCI3THe9+AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EV0n9M0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606E8C43390;
	Wed, 14 Feb 2024 14:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707921971;
	bh=c+xjim88bHayo1cK2qBTU6PJqAH/5WT7kzZO5iz1EKU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=EV0n9M0CtLsPBoVc6qo/dQDruG1BBfltUNWUW1Zul2JqVCibKG+kVBtL9ED1xjTAG
	 mIkcxwprxbXFtKHJVNr4uHpq+eCoQKsHeVD9DN0gJg7VAklrXRkoj+NaJkFPKTpgkv
	 s+MsQYDOBDh4/ubh5PXTPZqZ2kYdxyo7lwLksKGS6sq6X6Bubm/CSBeEtVTUqFoVjF
	 8GkfrCX/hiZDAIvvq+0JgTGygkoq7rfkkofhg+DMfJiJibKCeik3Db5xVZymZOOJEM
	 EpC/YCnTgArokgZcI5+Q2tN3HOiQQH7A2WM3cA0jKNSgK5Oaj5u0PyV7ZK6H2/d8NR
	 eazlxiq3G4UmA==
Date: Wed, 14 Feb 2024 15:46:12 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Mark Brown <broonie@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, corbet@lwn.net, 
    workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org, security@kernel.org, 
    Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>, 
    Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE
 process
In-Reply-To: <7c177ba2-6b0a-4203-9ee6-113e75c6bb13@sirena.org.uk>
Message-ID: <nycvar.YFH.7.76.2402141539180.21798@cbobk.fhfr.pm>
References: <2024021430-blanching-spotter-c7c8@gregkh> <nycvar.YFH.7.76.2402141433560.21798@cbobk.fhfr.pm> <7c177ba2-6b0a-4203-9ee6-113e75c6bb13@sirena.org.uk>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 14 Feb 2024, Mark Brown wrote:

> Not addressing your point in general but the speaker volume limiting is
> security relevant, that change prevents physical damage to the system.
> There's an argument for many headphone volume related fixes too since
> excessively large volumes can cause substantial distress and potential
> injury to users (I can't remember if that fix would be relevant to that
> issue).

Thanks, I guess you are actually supporting my point, and that is -- there 
is no consensus whatsoever of what assigning a CVE actually means, at all.

To me -- physical damage to the system, fair enough, that might really 
easily be security relevant.

Something being too loud, causing distress ... that's really a grey zone 
(to put it mildly) for me. How about e.g. a bug in GPU driver, leading to 
a flickering screen? Many people are very sensitive to that (both 
physically and mentally) for various reasons.

Bug worth fixing? Absolutely, as soon as possible. Security-relevant? Not 
in my book.

To me, kernel is in no way special, in this respect, actually. With each 
and every coding error in software of your choice, given anough fantasy, 
you'll come up with a scenario where this will cause some real issues to 
some living human.

That's not what CVE is about at all, at least in my understaing.

-- 
Jiri Kosina
SUSE Labs


