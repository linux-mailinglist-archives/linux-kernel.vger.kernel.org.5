Return-Path: <linux-kernel+bounces-67417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85F0856B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A21F5B2255E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CC31369AA;
	Thu, 15 Feb 2024 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbzvRZv9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3C613667A;
	Thu, 15 Feb 2024 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018685; cv=none; b=s/LtycdRyLSTX1RIqfuEv8rajVRyvh5fPBVRculZbJWiuS3WrpOAPBkQcjiRXY93HqgJO+GZ7lA7cbChp8YiQPYWlCPtEqDxykPyX0wuhlPWJP/YQrJo5h1Fbl+3Y4hkEvL6s3sYQXPiIdR716xcYx2LCKcqHBcQTc2HZNPeP08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018685; c=relaxed/simple;
	bh=Qpm4U+Chvatig2Wj7kHJn2NI5GBwUCXx8r+p3JB+ZwM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M5C/GSz2TuzDTH3LlBPO8BbazUu4y9lCtF5St8rCflYpFbRblweZOF61fU+w3MCZsHX7dkUPAgrBPpjMjMXyYU+wncWW4D9Iu0iJeJBZTkCQsEi5DxgZZ/9ATsNxWtpai2My32+W9A6SjnAwTNHgNcAYprmsAwHwD7cWY57qSO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbzvRZv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B133FC433A6;
	Thu, 15 Feb 2024 17:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708018685;
	bh=Qpm4U+Chvatig2Wj7kHJn2NI5GBwUCXx8r+p3JB+ZwM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=RbzvRZv9VHh81xZgTipc+cyHotQf0QrKw8tdJnBwMuBKSriJLu1P+2WDrlWbEGa7S
	 fvWYE1oRqENHoFFddwxPZnXGD+D5p9+f8k6q+hneW7/yL8KQZz5CmWNfVyvPBx0yGN
	 pIoe3VZ9r/F3GXRoycqe/3oaqxc3vSqVofCl28hdJhrBZq9PI89WCF2zo0AtMzIdwc
	 QQWPI7B0rpPhtwjlFT7O/sRJJ9EeoOEyYYx9yle9TG2TyvIyq8r5/9r6NBW13+JCgw
	 zMMM+iW6t8oI+LaLDx3hR8GV957pOhAFThPIkDYn2o+80SjypEzmuxy9AnKQ914Y/v
	 fI/3ShfGjJCtA==
Date: Thu, 15 Feb 2024 18:38:05 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org, security@kernel.org, linux@leemhuis.info, 
    Kees Cook <keescook@chromium.org>, 
    Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
    Krzysztof Kozlowski <krzk@kernel.org>, 
    Lukas Bulwahn <lukas.bulwahn@gmail.com>, Sasha Levin <sashal@kernel.org>, 
    Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v4] Documentation: Document the Linux Kernel CVE
 process
In-Reply-To: <2024021500-laziness-grimace-ed80@gregkh>
Message-ID: <nycvar.YFH.7.76.2402151817440.21798@cbobk.fhfr.pm>
References: <2024021500-laziness-grimace-ed80@gregkh>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 15 Feb 2024, Greg Kroah-Hartman wrote:

> The Linux kernel project now has the ability to assign CVEs to fixed
> issues, so document the process and how individual developers can get a
> CVE if one is not automatically assigned for their fixes.

There is still one thing that's not clear to me with this new process, and 
that's how embargos are going to be handled.

Currently, the process is broken as well, but at least understood by 
everybody.

- issues are reported to security@kernel.org. No CVE assigned, 7days 
  embargo, then fix gets pushed out

- at some point (in parallel, before, or after the above), the issue gets 
  reported to linux-distros@. CVE gets assigned, and downstreams start 
  integrating the fix (once available) to their codebase.

- embargo is lifted, fixes are released with proper CVE reference

How is the new process going to look like? Please keep in mind that 
linux-stable is (by far!) *not* the only downstream of Linux Kernel 
project.

We've had this discussion in other contexts already, but I whole-heartedly 
believe that it's in no way in the Linux Kernel project's interest to kill 
those other downstreams (read: Linux distros) (*) ... or is it?

(*) just looking at how much those not-basing-on-stable distros are 
    contributing to mainline

Thanks,

-- 
Jiri Kosina
SUSE Labs


