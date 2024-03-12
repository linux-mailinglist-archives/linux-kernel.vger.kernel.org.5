Return-Path: <linux-kernel+bounces-99765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE28878CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5C92827F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F821AD2C;
	Tue, 12 Mar 2024 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MjinCQYJ"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6281A945A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710210122; cv=none; b=O6z6YpVaLby9BFLvdxNDzN+DtzTmwKBfCcgh/OgWmhu7iQ9gSSDOQXCqhFaUTYMSYcJ37NpaUxXDkcnfco/dDTksn3OdZBqWUjXDYCg5TwRxAjzNVbSdsQW5P3SeTHNCtv9MF76p8a7wGJ6jYIyR3WgdhkZfVAp+HRVj/58fnsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710210122; c=relaxed/simple;
	bh=epRTf1wLs43NkiHRFVg/kOBMSreaIeFhsSZmxUVSZMU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RSviRCyQUoZYDczvxDl5MEePofjQFVb6tcFxmrSizv4zAzBf+r8oUthUnANCYki7AqKp/LKl7DQdgbwA9FS9l3QwGf+F8J1DeQZetrR+ZIlEgqpG6xQ5vLRmIibV/MEUijY8hYsm8xJThDQwe8qRDh3r60CtuUMpLObG8MuTeEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=MjinCQYJ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 42C2KvjU1107798
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 11 Mar 2024 19:20:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 42C2KvjU1107798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024021201; t=1710210062;
	bh=25o8RezCz/80azo9KF9KOroEFSSWkg8pHxdIqDA7QWg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=MjinCQYJOwkr/GeS6myIyc5fiKaO2Jc6L1Aas4l12yyMkbi9pF+p3BmHPieTdqOkZ
	 cGhZ0/0Ct+NBK+Ta954sRgeRzGlC0WPeICXOLDfBHReqMVl357P7jT+TYr+2GH/R1e
	 JPaS5v8Ps3uU8nBBmWFIRiu7qb+1Ylkf2l46STFhRAEZrQ5AWPbrD5dw7d7pvFuoK/
	 nWbYe1zFwItOZ5VeNTWoyhGMSF7vxUaVH4IsAbcTMVwp+mzVJSDoJTPwkYuveTeQNR
	 +uGe4p9G2m8nf/rVw4evqkBOahg2pka7mZfLvHMYdQcK3d46AP1XjtyttzxZqnxtsg
	 3s8ZDreVs1uww==
Date: Mon, 11 Mar 2024 19:20:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>
CC: Pasha Tatashin <pasha.tatashin@soleen.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Christian Brauner <brauner@kernel.org>,
        bristot@redhat.com, Ben Segall <bsegall@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, dianders@chromium.org,
        dietmar.eggemann@arm.com, eric.devolder@oracle.com, hca@linux.ibm.com,
        "hch@infradead.org" <hch@infradead.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, jpoimboe@kernel.org,
        Joerg Roedel <jroedel@suse.de>, juri.lelli@redhat.com,
        Kent Overstreet <kent.overstreet@linux.dev>, kinseyho@google.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        lstoakes@gmail.com, mgorman@suse.de, mic@digikod.net,
        michael.christie@oracle.com, Ingo Molnar <mingo@redhat.com>,
        mjguzik@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>, vincent.guittot@linaro.org,
        vschneid@redhat.com
Subject: Re: [RFC 11/14] x86: add support for Dynamic Kernel Stacks
User-Agent: K-9 Mail for Android
In-Reply-To: <0645946c-f4f5-43b1-a9a0-03ed139036b3@app.fastmail.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com> <20240311164638.2015063-12-pasha.tatashin@soleen.com> <3e180c07-53db-4acb-a75c-1a33447d81af@app.fastmail.com> <bedfa55b-b1d0-4e59-8c94-dbc5f8485a7f@intel.com> <ef0419dd-9d7b-4b77-b63a-5f11aaefb570@app.fastmail.com> <08EFDEDB-7BBB-4D9C-B7E5-D7370EC609BE@gmail.com> <dd67a2b9-35ef-4cf8-b303-9e6b8692b390@intel.com> <D4D747C5-2B0E-44B0-A550-BA05BE0AF2FA@zytor.com> <0645946c-f4f5-43b1-a9a0-03ed139036b3@app.fastmail.com>
Message-ID: <83E86178-FBC7-49C5-B624-8B8106D10CBC@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 11, 2024 7:16:38 PM PDT, Andy Lutomirski <luto@kernel=2Eorg> wrote=
:
>On Mon, Mar 11, 2024, at 6:25 PM, H=2E Peter Anvin wrote:
>> On March 11, 2024 5:53:33 PM PDT, Dave Hansen <dave=2Ehansen@intel=2Eco=
m> wrote:
>>>On 3/11/24 16:56, Nadav Amit wrote:
>>>> So you can look on the dirty-bit, which is not being set
>>>> speculatively and save yourself one problem=2E
>>>Define "set speculatively"=2E :)
>>>
>>>> If software on one logical processor writes to a page while software
>>>> on another logical processor concurrently clears the R/W flag in the
>>>> paging-structure entry that maps the page, execution on some
>>>> processors may result in the entry=E2=80=99s dirty flag being set (du=
e to the
>>>> write on the first logical processor) and the entry=E2=80=99s R/W fla=
g being
>>>> clear (due to the update to the entry on the second logical
>>>> processor)=2E
>>>
>>>In other words, you'll see both a fault *AND* the dirty bit=2E  The wri=
te
>>>never retired and the dirty bit is set=2E
>>>
>>>Does that count as being set speculatively?
>>>
>>>That's just the behavior that the SDM explicitly admits to=2E
>>
>> Indeed; both the A and D bits are by design permissive; that is, the=20
>> hardware can set them at any time=2E
>>
>> The only guarantees are:
>>
>> 1=2E The hardware will not set the A bit on a not present late, nor the=
 D=20
>> bit on a read only page=2E
>
>Wait a sec=2E  What about setting the D bit on a not-present page?
>
>I always assumed that the actual intended purpose of the D bit was for th=
ings like file mapping=2E  Imagine an alternate universe in which Linux use=
d hardware dirty tracking instead of relying on do_wp_page, etc=2E
>
>mmap(=2E=2E=2E, MAP_SHARED): PTE is created, read-write, clean
>
>user program may or may not write to the page=2E
>
>Now either munmap is called or the kernel needs to reclaim memory=2E  So =
the kernel checks if the page is dirty and, if so, writes it back, and then=
 unmaps it=2E
>
>Now some silly people invented SMP, so this needs an atomic operation:  x=
chg the PTE to all-zeros, see if the dirty bit is set, and, if itt's set, w=
rite back the page=2E  Otherwise discard it=2E
>
>Does this really not work on Intel CPU?
>

Sorry, I should have been more clear=2E

Hardware will not set a bit that would correspond to a prohibited access=
=2E

