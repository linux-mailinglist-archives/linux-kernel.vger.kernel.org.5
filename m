Return-Path: <linux-kernel+bounces-90711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AE38703B6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CD01C22FF6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529663FB31;
	Mon,  4 Mar 2024 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="VYu11XBP"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9C23D9E;
	Mon,  4 Mar 2024 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561420; cv=none; b=rrqktHcTi0ptiZGztycZGs9UUV7pP8pyPuGL2tedtNgPKEhLaxohrHElx975zRecS7P+1BtXn00xOVpBDN4DeyIRQ48wpruzgJD61CUcLKKuegxsrpTOyKvS+xX2R9CtWC1SgtnQIXPsl9ADbwjDFy2EU3THM+h7GogeMlAxgGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561420; c=relaxed/simple;
	bh=iq23kpk8WdH7WCVOi5NjLdInalEVix39z/ioMqK4M0g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=X62xdaC+pvnSXKOxpUmxAD+ceNTTHdNkJqzCEgFV5yi/M+SkQsRkB/qLiSA+AsAMKg9EkJ5ptOTTmxDBQJYvEKO99xqSn038U65NDtHx8TTJaTm2yv+52tBkQVjtLAlu+hHuSyv0aEo10MkWS+br3HmWcMCnmf4cNxW26pgOSgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=VYu11XBP; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Reply-To:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=iq23kpk8WdH7WCVOi5NjLdInalEVix39z/ioMqK4M0g=;
	t=1709561418; x=1709993418; b=VYu11XBPnwHeYC7pVVai8SZCY2gERnTTURV+S+EV7XXIfGY
	Gbo//1Q9BWzxq6vp6rCO2gkbpxvrNRlHrxiFuA86nT7hKDyByJH8YPl4+M5/gKXpwzmoZ3zt5eNmW
	cqVAkuPAkSuPIH/8ZYWwtOX1OPBPl7zST5T5tb/bB/t81Tn4xcGUsyWPW7NpsI/2UO0d1L0EbyScT
	HlqmePSjry49aGF9adqi7jOXQil1NqwNgQXFvwrlIsrBGzV+JSQjRfMK/RHFDMMvuMUXqRpMa1/Sc
	a8QTFoVtEkSL0z7jRXOPVA7g9sWqIoUZ4EDAL3UT2YRPuUoYRpLkfsuDGBdSveDg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rh917-0000G0-OE; Mon, 04 Mar 2024 15:10:09 +0100
Message-ID: <2ae4d3ba-3024-4bfe-8f95-c5c9526cd16f@leemhuis.info>
Date: Mon, 4 Mar 2024 15:10:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: This is the fourth time I've tried to find what led to the
 regression of outgoing network speed and each time I find the merge commit
 8c94ccc7cd691472461448f98e2372c75849406c
Content-Language: en-US, de-DE
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, niklas.neronin@linux.intel.com,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-x86_64@vger.kernel.org, netdev@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
 <e7b96819-edf7-1f9f-7b01-e2e805c99b33@linux.intel.com>
 <CABXGCsPjW_Gr4fGBzYSkr_4tsn0fvuT72G-YJYXcb1a4kX=CQw@mail.gmail.com>
 <2d87509a-1515-520c-4b9e-bba4cd4fa2c6@linux.intel.com>
 <CABXGCsPdXqRG6v97KDGy+o59xc3ayaq3rLj267veC7YcKVp8ww@mail.gmail.com>
 <1126ed0a-bfc1-a752-1b5e-f1339d7a8aa5@linux.intel.com>
 <CABXGCsN5_O3iKDOyYxtsGTGDA6fw4962CjzXLSnOK3rscELq+Q@mail.gmail.com>
 <a026ecd8-6fba-017d-d673-0d0759a37ed8@linux.intel.com>
 <CABXGCsOgy8H4GGcNU1jRE+SzRqwnPeNuy_3xBukjwB-bPxeZrQ@mail.gmail.com>
 <CABXGCsOd=E428ixUOw+msRpnaubgx5-cVU7TDXwRUCdrM5Oicw@mail.gmail.com>
 <34d7ab1b-ab12-489d-a480-5e6ccc41bfc3@infradead.org>
 <10487018-49b8-4b27-98a1-07cee732290d@infradead.org>
 <4f34b6a8-4415-6ea4-8090-262847d606c6@linux.intel.com>
 <3ea25443-1275-4c67-90e0-b637212d32b5@leemhuis.info>
 <1e719367-01ae-565a-2199-0ff7e260422b@linux.intel.com>
 <410817b8-1cf9-4285-b20b-f1fa0513cee8@leemhuis.info>
In-Reply-To: <410817b8-1cf9-4285-b20b-f1fa0513cee8@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709561418;440f53ab;
X-HE-SMSGID: 1rh917-0000G0-OE

On 26.02.24 10:51, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 26.02.24 10:24, Mathias Nyman wrote:
>> On 26.2.2024 7.45, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> On 21.02.24 14:44, Mathias Nyman wrote:
>>>> On 21.2.2024 1.43, Randy Dunlap wrote:
>>>>> On 2/20/24 15:41, Randy Dunlap wrote:
>>>>>> {+ tglx]
>>>>>> On 2/20/24 15:19, Mikhail Gavrilov wrote:
>>>>>>> On Mon, Feb 19, 2024 at 2:41 PM Mikhail Gavrilov
>>>>>>> <mikhail.v.gavrilov@gmail.com> wrote:
>>>>>>> I spotted network performance regression and it turned out, this was
>>>>>>> due to the network card getting other interrupt. It is a side effect
>>>>>>> of commit 57e153dfd0e7a080373fe5853c5609443d97fa5a.
>>>>>> That's a merge commit (AFAIK, maybe not so much). The commit in
>>>>>> mainline is:
>>>>>>
>>>>>> commit f977f4c9301c
>>>>>> Author: Niklas Neronin <niklas.neronin@linux.intel.com>
>>>>>> Date:   Fri Dec 1 17:06:40 2023 +0200
>>>>>>
>>>>>>       xhci: add handler for only one interrupt line
>>>>>>
>>>>>>> Installing irqbalance daemon did not help. Maybe someone experienced
>>>>>>> such a problem?
>> This isn't really about those usb xhci patches.
>> This is about which interrupt gets assigned to which CPU.
> I know, but from my understanding of Linus expectations wrt to handling
> regressions it does not matter much if a bug existed earlier or
> somewhere else: what counts is the commit that exposed the problem.

TWIMC, I mentioned this twice in mails to Linus, he didn't get involved,
so I assume things are fine the way they are for him. And then it's of
course totally fine for me, too. :-D

Thx again for all your help and sorry for causing trouble, but in my
line of work these "might or might not be a regression from Linus
viewpoint" sometimes happen.

Ciao, Thorsten

#regzbot resolve: apparently not a regression from Linus viewpoint

