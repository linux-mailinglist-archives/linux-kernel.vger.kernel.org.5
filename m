Return-Path: <linux-kernel+bounces-6122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA938194DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF0C1C234BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E441940BEE;
	Wed, 20 Dec 2023 00:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TMQvMvT3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D31C40BE0;
	Tue, 19 Dec 2023 23:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=GF1wzjjBGEMJOB30ICU1C1SRmgYDCtBoBlKGMTC9Kek=; b=TMQvMvT3Hs8r1XgNmLpVn//iFS
	bLo9/1v2KF1gmIfNPWDPxhKVLSscC3L/6+vrXjHzi+9P6l+LfSi0g6rNbofWf+iAEEeJOkJCUQgHr
	0yOrqN76hKwNXYZNV2UDHja4cKUg7bQpXZ7D60ZXx6TIvwa8eaYeVzyF+x1XWCeYYOT8Q733+LOPS
	Jg9KhIePoigcMU+EC/OW4vEJk7EoxANIBPPszkkVeY2nzUoxxUhfI7bpl6Ce13EhkeNDCjZdlbplM
	Zd9ISAM5uhoWVIYFOCA+gGvdaxLwgrI+oYSUABvfXVBD/UsPSx8KiMzxtoucS8VrGNTYkpUAtvOFQ
	WrYVrlbw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFk0F-00Fj2G-15;
	Tue, 19 Dec 2023 23:59:59 +0000
Message-ID: <4cbcd213-55f9-4525-8be0-29db00a468d2@infradead.org>
Date: Tue, 19 Dec 2023 15:59:58 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: build warning after merge of the jc_docs tree
To: Jonathan Corbet <corbet@lwn.net>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231218182825.39a6562b@canb.auug.org.au>
 <87r0jjmw59.fsf@meer.lwn.net>
Content-Language: en-US
In-Reply-To: <87r0jjmw59.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/18/23 06:18, Jonathan Corbet wrote:
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> 
>> Hi all,
>>
>> After merging the jc_docs tree, today's linux-next build (htmldocs)
>> produced this warning:
>>
>> include/crypto/hash.h:248: warning: Excess struct member 'digestsize' description in 'shash_alg'
>>
>> and 636 new similar warnings :-(
>>
>> Exposed by commit
>>
>>   b77fdd6a48e6 ("scripts/kernel-doc: restore warning for Excess struct/union")
>>
>> I am not sure what we should do about this ... last Friday I only
>> got about 18 lines of warnings.
> 
> The warnings were expected, of course.
> 
> The alternatives are to fix the docs or to revert b77fdd6a48e6,
> pretending that all those kerneldoc errors don't actually exist.  The
> fixes should be pretty easy to do (and there's far less of them than it
> seems from the number of warnings).  I can't get there right away but if
> nobody beats me to it I'll try to toss some patches together.

Hi Jon,

Attempt at a little coordination:

It looks like you are working on some net-related patches for this.
I am currently working on fs/ and kernel/ patches.

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

