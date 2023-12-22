Return-Path: <linux-kernel+bounces-10049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA7781CF25
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 21:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D591F2209F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A8E2EAF1;
	Fri, 22 Dec 2023 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="414//8xz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA332EAE0;
	Fri, 22 Dec 2023 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=KI0zA/Px6cUxS0L0b8KBYHVUg2z133x4b67QPUw/9JU=; b=414//8xzZIyi1bEAx5dQSFGWPV
	s+zDyR+elltAiPvZfDlNLCGGB7AgIQ6KHMYoztc0Vv6GSwF3AoHyFI1DhdIx8r7TYbyvLe3+OAWWS
	m+ovB5rFm0A9WCcHnQFDdrEoKRlQvuu0J/fAFh8nLOdUYzmD+MFpycu3aVhpbMqH/x8jLkj2sRm+L
	0HKP4Ek1Y5SqS79IGEG/KAjFZbskNJ1A0KKroOH2zbu0bjmFpgfWOJak9fe/GNTux6uIi10eQARAP
	l/lfZ0X15H6Bu4TLqgR0s7Vio8jIJTv9q9X3xcSNdSEtSxX7Z2NGx+CwxUo4d1YUTTQzix/NDInSr
	BrPK4N+w==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGlrg-006nkP-1H;
	Fri, 22 Dec 2023 20:11:24 +0000
Message-ID: <b9165c65-0cbe-43f0-8634-361308a01972@infradead.org>
Date: Fri, 22 Dec 2023 12:11:23 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/kernel-doc: restore warning for Excess
 struct/union
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, Vegard Nossum
 <vegard.nossum@oracle.com>, linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
 linux-doc@vger.kernel.org
References: <20231214070200.24405-1-rdunlap@infradead.org>
 <875y0zqvjr.fsf@meer.lwn.net>
 <93e1b9fa-c447-4f7d-9dc7-825ebe9e1cde@oracle.com>
 <877cl7a8gh.fsf@meer.lwn.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <877cl7a8gh.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/21/23 07:20, Jonathan Corbet wrote:
> Vegard Nossum <vegard.nossum@oracle.com> writes:
> 
>> On 15/12/2023 17:28, Jonathan Corbet wrote:
>>> *sigh*
>>>
>>> This adds nearly 600 new warnings.  Anybody gonna help fix them?
>>
>> I think in the vast majority of the cases the fix will be to just remove
>> the offending line from the kerneldoc, so it's not particularly
>> difficult, mostly just overhead from the patch preparation/submission
>> process.
>>
>> I'd be happy to take a stab at it -- I think we could even script most
>> of it. Respond here, I guess, if anybody else wants to do some so we can
>> split it up.
> 
> It's mostly done; I've gotten it down to under 200 and sent patches to
> make the changes.  Randy is working on it too, I know.  It's not always
> just deletion, but the fixes are usually pretty straightforward.
> 

I'm still seeing lots of Excess warnings from
  include/crypto/hash.h
  include/crypto/skcipher.h
  drivers/gpu/drm/*  (several files there have warnings)

I would be happy to see Vegard's help on this - unless Jon has already
addressed those warnings.

>> On a related note, it might be useful to have some kind of "status page"
>> somewhere on the web for the docs where you can see a list of unresolved
>> documentation warnings in mainline/docs-next/next without having to do a
>> local build first (as a way to solicit contributions).
> 
> I suppose, but how do you know you've properly addressed the warning if
> you don't do a build afterward?  I don't see that saving a whole lot of
> effort, but maybe I'm missing something?

Thanks.

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

