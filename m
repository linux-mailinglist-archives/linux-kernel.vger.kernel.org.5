Return-Path: <linux-kernel+bounces-75095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFBF85E2F9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33497B2541D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0544381746;
	Wed, 21 Feb 2024 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mvz1frH1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FC881740
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532576; cv=none; b=rQ/pxynEbMQGpNYrfRrMymkynYtuHAe8HkAbiWna74hRcIdneMoFaH+dvcRuoDJlLF4XMqWzEbuFEGdQCIX5ltCyuFcd6J9s/s/oqmEMsFmRCaxcvNhX6qTK4S+z4Fy5XpD+FVxaGZXKFSvhidsXa4BQn7+QeOgw8Cr9UAVe8Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532576; c=relaxed/simple;
	bh=ufe21RcpjI+Fe/InXrIajsCgsE8NvxRbIK3dneO0Bck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/Zm/H1KRCBJdZ39fLbVXbo+Q+Ii6D3KbYewdwAf41PUQVKyt/aaEaSuABK3H+fMj7HU4W3n4rvgNFMtSFHMoPtAPiyGqT4hDzX7S4MchJVZovxPSd4QgROR/K8Tzb9KgTGHU/Lq/eK1klSbokjmNUscq8+XIOaRxYS+KJkX8EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mvz1frH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F4CC43390;
	Wed, 21 Feb 2024 16:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708532576;
	bh=ufe21RcpjI+Fe/InXrIajsCgsE8NvxRbIK3dneO0Bck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mvz1frH1q9RaX5+RdvkHy33unY0QUBKGxvFGBgJsS+LduZQxN0cEf3bPTKLFU/jX3
	 dhOhxzQ5FMxP3k93KdGhrId/2VU8QiZtSJMZsqU++UC1/YHThqdUCCVUR7Zug/a3Ji
	 GOCglQNuDuQJiY6mRI1CFwdnsp/tjcRUmT1Ur5Dy8s8orIs/3X0zI582/GCFGdvi7Y
	 ZUZw6oqjZiup/LYcKMtnX2Y6dfhSjiyund1O+TNt8dFFbw1FKi7Y5/NIRB3VPBb6EO
	 JAlr61oNSPxz8+og69TRl/dsGtxHI+oJkZQ1JP1l5cti00+g6OGXflNzLvNuSZnrHn
	 YbN1wg6XTUVgA==
Date: Wed, 21 Feb 2024 11:22:54 -0500
From: Sasha Levin <sashal@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, cve@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Kosina <jkosina@suse.cz>
Subject: Re: CVE-2023-52437: Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING
 in raid5d"
Message-ID: <ZdYjXmA_1OvcS_CZ@sashalap>
References: <7ae646b3-28e4-4344-a7a4-730a0d6e3f38@redhat.com>
 <CABgObfYDcFPRNpGtsY=UbstXbqVCMcxy3LPS_xJ65aFcByC=Nw@mail.gmail.com>
 <ZdXt09vL4GJy6PbP@sashalap>
 <0e8675e0-165d-4cf7-9755-666278868ab8@redhat.com>
 <ZdX2LcAWR6wyvYC5@sashalap>
 <bec7c1db-c13e-4b00-a968-4ae69539d7ac@redhat.com>
 <ZdYKSkqRckOc5aRO@sashalap>
 <a9652aa2-e79b-4144-b3b7-746587af9eca@redhat.com>
 <ZdYSmdUKzQAYpprc@sashalap>
 <3ebbc121-8cb8-4b8d-ad5d-fb5c576e5171@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ebbc121-8cb8-4b8d-ad5d-fb5c576e5171@redhat.com>

On Wed, Feb 21, 2024 at 04:56:31PM +0100, Paolo Bonzini wrote:
>To recap:
>
>- the CVE description comes from was upstream commit bed9e27baf52
>
>- neither the CVE mitigation section nor the mentioned kernel releases
>fix the bug mentioned in the upstream commit, because the mitigation
>section also includes commits that _revert_ commit bed9e27baf52
>
>- this second revert is not mentioned anywhere, so the CVE description
>is at best misleading; or perhaps more accurately described as
>"completely f***ed up".
>
>I'm sure it's just a bug in the scripts, but it's worrisome that you
>don't acknowledge this.

No objections that commit messages aren't perfect, they're just better
than the some unhelpful text like:

"""
In the Linux kernel before 6.5.9, there is a NULL pointer dereference in send_acknowledge in net/nfc/nci/spi.c.
"""

My choice was to actually just call out the offending commit and be done
with it, without additional description.

>>So now you're asking us to drop this additional work on them by
>>reviewing CVE requests?
>
>It doesn't have to be mandatory.  But for people that _do_ want to do
>the work, they might as well do it before the CVE is publicly announced,
>rather than after.  At least give us the possibility of doing it without
>bureaucracy.

[...]

>> How were you aware until a few weeks ago where CVE assignments were
>> handled by different entities?
>
>They more often than not CC'd me before the patch was committed and
>provided me the CVE id, and I was able to provide input or dispute the
>assignment beforehand.  This is exactly what I'm suggesting that the
>kernel should do.

This is fascinating to know, because when multiple members of the
community asked to review CVEs before they are assigned, certain few
CNAs blatantly ignored such requests.

Would you want to expand on why you got the courtesy of being able to
review these assignments, while the rest of us had to jump through the
hoops of becoming our own CNA just to stop from this crap from happening
to us?

[ snip ]

>>So yes, I disagree with your "all of them" statement. For that matter,
>>I'd argue that the number of users who need massaged messages are the
>>vast minority.
>
>They don't need massaged messages.  They need correct and complete ones.
>  You're completely removing the human part of the work and expecting
>the result to be of comparable quality.  That's not going to happen, and
>this CVE is an example of this.

I definitely agree that it would be nice to have better messages in
CVEs, and I'd welcome interested parties to follow the process that was
in place up until two weeks ago, and request an amendment to a CVE with
a better description (or dispute an invalid one) with the CNA.

This is exactly the same process that most of us had to follow in the
past to address crappy CVE descriptions or bogus CVEs.

>>>2) how are you going to handle patch dependencies?  Are they going to
>>>be rolled into a single entry or split into multiple announcements?
>>
>>Likely multiple different entries.
>
>So, looking at
>https://git.kernel.org/pub/scm/linux/security/vulns.git/tree/cve/review/6.7.proposed
>I see
>
>aeb686a98a9e usb: gadget: uvc: Allocate uvc_requests one at a time
>da324ffce34c usb: gadget: uvc: Fix use-after-free for inflight usb_requests
>
>What vulnerability is the first one fixing?  Looking at your GSD

Well, if you look at the first patch, it says "This patch is 1 of 2
patches addressing the use-after-free issue.".

>entries, will there even be CVEs purporting that renaming a variable
>from "foo" to "bar" is fixing a vulnerability?

Maybe? Hopefully not if it's not a real security issue.

>>>3) are the scripts used to generate the CVEs public?  Can fixes to the
>>>scripts be developed in the open?
>>
>>Yup - https://git.kernel.org/pub/scm/linux/security/vulns.git/ .
>
>What about the detection part?

Manual at this point, we're looking into converging workflows but it's
one of those things we'd need to address after we got the basics in
place.

>I like to assume the best of people, so I'll assume that this is just
>naïveté rather than an intentional attempt at burning everything down.
>But please, let's take a step back and understand what the proposed
>workflow fixes and breaks for everyone (especially maintainers and
>distros).  Then make a proper solution.  In the meanwhile you can keep
>sending test announcements to linux-cve-announce, and those can be used
>to debug the process and the scripts.

No objections on future improvements, right now we're still trying to
get the basics working which is where the strong pushback on "feature
requests" is coming from.

>In fact it would be nice if bippy included at the end the command line
>that was used, to aid the reproduction and fixing of bugs.

Bippy just maps commits to trees and formats the json, or did I
misunderstand what you meant?

-- 
Thanks,
Sasha

