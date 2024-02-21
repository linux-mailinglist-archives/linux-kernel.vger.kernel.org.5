Return-Path: <linux-kernel+bounces-74906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2170485DFD9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B122F1F24FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0477F7EF;
	Wed, 21 Feb 2024 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6GOK5y2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEAC374D9;
	Wed, 21 Feb 2024 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526157; cv=none; b=sbr4xJ+9cjX31lpNEpMdfsC08C55RUGL+N9QqKo9zcOjBacFWCj3IszsfqAqQdatU47aAIeWQVRc6wyKOZnNlOLb4qbFw3QxFhMlG4AcHX8tovjqSyOmQ05Dxfv4wY+WGNMX58WJ4f53Kjv1kUPfemGf8bYP4Pvh4v9hagU0v1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526157; c=relaxed/simple;
	bh=ShFnbQF1akJrSoIdhg9IFlVYTjo2i764A1JBYc+1bTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IN8a1buz2d1f1Ow2Qgqv8wgOyBBspnLeWOhpPpCM6RtEyW/IoFAd9aiFH+l8N+9QHwuO+8Wp3SjpZGiHOlPSwITkFRihecWbBp98zk74E52SwRRJaBfGxOI8hStl25Dio5V49Yn1Lsa/0oE3LJUxVgIOoFD1noa5J2IG4agrJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6GOK5y2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E5EC433F1;
	Wed, 21 Feb 2024 14:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708526156;
	bh=ShFnbQF1akJrSoIdhg9IFlVYTjo2i764A1JBYc+1bTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r6GOK5y2/l1WkN2Yi0eobTYHLcErBYdf0tHzPo836AA/e99dd3UrPnzplfdNqzPc8
	 Yr6gm+iT+xl97/dgOw+/zPKObB5cZQ7KL3/x1y9C0n/93KTRJYEZJX1s+grPhZuKHd
	 PEJ6sMzSpeiF+0izEuqHqT3V9GOEr5tjIbjDx+FI3Zc8XM00O0HDMH75GqjEQMrcfX
	 rbcF5qBiI0fvd04wstbb2/YWEFzKLdhpqPEmJvxyR5hUA3Ei8yu8nD3o+oAVtPqRfk
	 zsWtD9tzlL1pb/WDKUP5H5M3Tq/99dSU9mnAjeCWWmIIkmrkwma3W860d+aZ5y1wzt
	 HOK5kLg9N/NGw==
Date: Wed, 21 Feb 2024 09:35:54 -0500
From: Sasha Levin <sashal@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: cve@kernel.org, linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52437: Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING
 in raid5d"
Message-ID: <ZdYKSkqRckOc5aRO@sashalap>
References: <2024022009-subsoil-halt-4b28@gregkh>
 <7ae646b3-28e4-4344-a7a4-730a0d6e3f38@redhat.com>
 <CABgObfYDcFPRNpGtsY=UbstXbqVCMcxy3LPS_xJ65aFcByC=Nw@mail.gmail.com>
 <ZdXt09vL4GJy6PbP@sashalap>
 <0e8675e0-165d-4cf7-9755-666278868ab8@redhat.com>
 <ZdX2LcAWR6wyvYC5@sashalap>
 <bec7c1db-c13e-4b00-a968-4ae69539d7ac@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bec7c1db-c13e-4b00-a968-4ae69539d7ac@redhat.com>

On Wed, Feb 21, 2024 at 02:15:12PM +0100, Paolo Bonzini wrote:
>>On 2/21/24 14:10, Sasha Levin wrote:
>>>On Wed, Feb 21, 2024 at 01:58:04PM +0100, Paolo Bonzini wrote:
>>>>On 2/21/24 13:34, Sasha Levin wrote:
>>>>>[snip]
>
>This conversation needs to be public.

I've cc'ed lkml.

>Please send your original answer as a reply to the message with 
>"[resend]" in the subject, which has LKML in the Cc list, and we'll 
>take it from there.  I'm sorry about the confusion, but I didn't 
>expect linux-cve-announce to be moderator-only, as that is a deviation 
>from the common practice of vger.kernel.org.

You'll find that the convention for *-announce mailing list is that
they, as the name suggests, are used only for announces and are
moderated.

So for example, linux-kernel@ is the lkml we all know and love, while
linux-kernel-announce@ is an announcement-only mailing list used to
announce releases.

But thank you for pointing out this "deviation".

-- 
Thanks,
Sasha

