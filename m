Return-Path: <linux-kernel+bounces-69242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ADD858622
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB5D1F243AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFCD1369B0;
	Fri, 16 Feb 2024 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfHnCJNB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68992135402;
	Fri, 16 Feb 2024 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708111588; cv=none; b=B8AKbiptePOe+UYEtcU+WNclScwEHIDD39vWLgPewEORvrDcX/Y5TFSTsJluqLL8/ecPrnK20f0nBElAhZyQAaPE42meV/MdS9vNPyHC/hWhoaq0fAtOhMHx3Ik7HOHm1TqYiutTm8Z/nI9PiacPbge4ZukzvdMlIkQNZp6R020=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708111588; c=relaxed/simple;
	bh=1mpjenY//1/lR2l1bgr2WJZpCyo7YC4v+ajLMTbKotE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T38HGIh+H9/vVEw+X91Q8/TqiPjDVxzfwvjOM3Ca0MfePRge/qBzCPGeoZeB/mGIYBzB63Tr7x18JKIVCjxhBtluyNysLQI+fb8PhFYK7p0dU0ZGt7gsHbC6dpH57k7WN8XmqQ+gjVSPqTP5r1YPjmbv2F5kENDYJA5+Hxv/Fts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfHnCJNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B630C43390;
	Fri, 16 Feb 2024 19:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708111588;
	bh=1mpjenY//1/lR2l1bgr2WJZpCyo7YC4v+ajLMTbKotE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QfHnCJNB3GHYywyG7spCptMCzNszHj5csHJWlnqyQGO1P3//zNoyIPXWUUGyRRaWo
	 73QBBp3w/vRwg2TbZyI0yIDgemjuQYxB0nAVsQfberERofvoWxzhGHYmXEvdZy8bbf
	 tbtL0tBeybawWyidQ2n7yZjAgQLYHM/xdYyB1s3a4jN/i/B7g75EF7IyiIIcbg4T70
	 C32Ms0XKzwBL0r/1ygx6V19VKJ5lCfZWlTvz80vLLjp6LPYGqRQGv2m6o8w+xML/21
	 DM16neeI1J00KV4W9D5VgwFrOSn9hGkWgYGHeXMA7eUzm2Y9vsBu7Wm8hgRzjrSeCQ
	 IGaAKWRKTbs9Q==
Date: Fri, 16 Feb 2024 11:26:25 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	linux@leemhuis.info, Kees Cook <keescook@chromium.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v4] Documentation: Document the Linux Kernel CVE process
Message-ID: <20240216192625.o3q6m7cjgkwyfe4y@treble>
References: <2024021500-laziness-grimace-ed80@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024021500-laziness-grimace-ed80@gregkh>

On Thu, Feb 15, 2024 at 01:10:55PM +0100, Greg Kroah-Hartman wrote:
> +Note, due to the layer at which the Linux kernel is in a system, almost
> +any bug might be exploitable to compromise the security of the kernel,
> +but the possibility of exploitation is often not evident when the bug is
> +fixed.

By this paranoid black-and-white logic, any mainline commit could have a
yet-to-be-discovered regression resulting in a catastrophic
vulnerability.

Should we stay one step ahead and just open a CVE for every mainline
commit?

Problem solved, all "vulnerabilities" have been identified!  False
positives be damned!

For that matter, why don't we do as Thomas has suggested and hardcode
NR_CPUS to zero!

> Because of this, the CVE assignment team is overly cautious and
> +assign CVE numbers to any bugfix that they identify.  This
> +explains the seemingly large number of CVEs that are issued by the Linux
> +kernel team.

How does this match up with the definition of a vulnerabilty?

  An instance of one or more weaknesses in a Product that can be
  exploited, causing a negative impact to confidentiality, integrity, or
  availability; a set of conditions or behaviors that allows the
  violation of an explicit or implicit security policy.

Bug != vulnerability.  Otherwise the definition of a vulnerability would
be much simpler, i.e., "any software defect".

If a CVE is created without any analysis and doesn't describe how the
bug can be exploited then it's completely useless.

Who is this process helping?

- Not users of -stable since they already know they need to be on the
  latest version.

- Not distros or their users as it's just flooding them with low quality
  CVEs which have no analysis or scoring.

And enterprise distros will never be able to rebase onto -stable,
especially for older streams for which they have to be very selective,
in order to avoid destabilizing them.  As you say, "a bug is a bug".

If the problem is low CVE quality then of course it makes a lot of sense
for kernel.org to become a CNA in order to take a leadership role in
helping define and improve the process for its users.  But it makes no
sense to "fix" it by making CVE quality *vastly* lower by flooding
people with useless CVEs.

-- 
Josh

