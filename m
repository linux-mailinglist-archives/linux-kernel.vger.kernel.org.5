Return-Path: <linux-kernel+bounces-89854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC2286F68D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167A02818AA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 18:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D720768F6;
	Sun,  3 Mar 2024 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="22aNaIbi"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE81B654;
	Sun,  3 Mar 2024 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709490000; cv=none; b=Q18EmG47ltar6s/M5ct1T8yblumlHD/aBpOvbgHWbzp+ZgMCZIqN/4zEJ/l9iwhAXW8IUrw+pkAjf33awHyTgUVpDafzQWXxqtKuSJUj4iMmnTWvUVJ1BdjT8Pg0+MYwrTUl050OIDiSUboAFwPuPQR3FVDxshe8zulsUiEndY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709490000; c=relaxed/simple;
	bh=OpFUZkht/kNkK1sffj4iZQMCp1wCBtb91Rpt3Ft7ccA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFwlgYuYwcc22MhGGl996cGQwhCJxUvyk9JdQaVyUQrwRSPdnHmy/b458w+oEjd/9YH6PXtAUqyZx0yf9fFx28eONzDnW/+M/cH3zyVq1MxjMdzgt0efqTj59JKONUTZqM5ov1SVHIjpx/zKhE9s2j/pvGH9Rnmtbbisw4A98Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=22aNaIbi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=4Zprqxh0tqZFACIsoF0C+/8aiRekfRqNvxtqcVAY67w=; b=22aNaIbicw0tEK5jEEVEjslKJT
	cvZ6D2p0pwLk7niNKqQNrnSlCS88e2po8vaO1wtQKIiutVD9GNp3lBxxTZmIq4jMKo+bmZL83RnMr
	Ho///zFagi5/fdPZsReW1qUxHwAQ6x6tdewFaEOXBNaUAiEDoCDxQw+G9cgsXYmxiFp8M3pg6fSpE
	pVA26IeTPBK/P83hPMtIVRmySELsumRYukFcU0zlYIE6tNaH5sQrairFuMx+zompNAxO1dLZhBPHA
	fJ2TZd+dAdRpISKjYpHA35hTVnLen4Jb5j4piT1niUZoGvO7aHZLSDGgG8abqp3ZD6eUR420gDAAh
	S1z9Pjeg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rgqRG-00000006SaN-2aT9;
	Sun, 03 Mar 2024 18:19:54 +0000
Message-ID: <04c07ca9-6377-4326-b9b5-4a4ed49c2f66@infradead.org>
Date: Sun, 3 Mar 2024 10:19:54 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] docs: submit-checklist: change to autonumbered
 lists
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>,
 lukas.bulwahn@gmail.com
Cc: jani.nikula@intel.com, kernel-janitors@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org
References: <20240229030743.9125-4-lukas.bulwahn@gmail.com>
 <8df0c587-8f5b-4523-89d7-dc458ab2c1df@gmail.com>
 <8734t7z4vs.fsf@meer.lwn.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <8734t7z4vs.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/3/24 07:55, Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
>>> -1) If you use a facility then #include the file that defines/declares
>>> +#. If you use a facility then #include the file that defines/declares
>>>     that facility.  Don't depend on other header files pulling in ones
>>>     that you use.
>>
>> Wait.  This will render the list starting from:
>>
>>     1. If you use ...
>>

I have already said that Stephen Rothwell wanted this #1 item to be at the
top of the checklist. That makes it easy to tell people to "see submit-checklist
item #1".


>> In patch 1/1, you didn't change the ")".
>>
>> It was Jani who suggested "#.", but "#)" would work just fine.
> 
> So I'm a little confused.  Is the objection that it renders the number
> as "1." rather than "1)"?  That doesn't seem like the biggest of deals,
> somehow, but am I missing something?
> 
> A bigger complaint I might raise is that auto-numbering restarts the
> enumeration in each subsection, so we have a lot of steps #1, which is a
> definite change from before.

ack

> That, of course, can be fixed by giving an explicit starting number in
> each subsection, partially defeating the point of the change in the
> first place.

ack

> I honestly have to wonder: does this document need the enumerated list
> at all?  We don't refer to the numbers anywhere, so I don't think there
> is much useful information there.  How about just using regular bulleted
> lists instead?

That also works.

> That said, I don't have strong feelings one way or the other, and can
> certainly apply it as-is if that's the consensus on what we should do.

My preference is to leave the submit-checklist numbered from 1 to N,
without a repeated #1 in each section. But I'm not hung up on it.

thanks.
-- 
#Randy

