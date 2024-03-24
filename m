Return-Path: <linux-kernel+bounces-112539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E94BD887B50
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 02:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B6F7B213E3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 01:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5A617C8;
	Sun, 24 Mar 2024 01:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rRDXvXuP"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9359981E;
	Sun, 24 Mar 2024 01:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711243167; cv=none; b=hZFdNnRQJhC3l/uiYi7RlaDIAW5cSGEBrtWRThlp1ZeSKx3ri3BQngT84rp6PBvdgLIo102TEz2FWFYW8W+3wg6MuWOkMxcTRWNUSErgCc7T88Ggr1Yi35Lxgr9rL7j3HSNeh8AI9s6+YiTZ+be0bM7i5jbqRr/uJoP99G2PMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711243167; c=relaxed/simple;
	bh=TSFL6ZPHf+nNmZN+mCrQRVmu2K+uA7T8UTvuYZPSASo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s596kTSZrUN7st/aGBg2mS06oX1HH1w3T3+dB3F0rpPaYvB0DNmIyszV/eo5Wc5OgrMPTFAm8hdRw31G7B/4bE/If/U8NDCS+ZTwHc0PIehkAw+Ju1cRBKG2CKSJJIeN+oAjdFuQr9ssM4P+37egpUMqVYS1ut74C/KPd2oEfz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rRDXvXuP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=wi2LTI5KP53CdNiOrYDHD4tTYnyBEg2RipTULkJ4IRM=; b=rRDXvXuPpC8yTHiw6Pqb7l8czJ
	zIS6KU5zxoaXKjRcqGyLnpkLYImkubIoRFPG5QJ02jpARz/K3nbOr59QomAZ1P9+nUjEqiTaMnHVu
	c7sb8Cm4ZOZvUdTyLln6Z91fC8snZ4LzvbEoUjPZCN8HBibknob1cCH1HxUm2WIk0cpY4FdneTzHT
	78xVgCpjpXN2NylIxDbMIBQYkwUvKoe5H9/JL3Qp+unVfmpRq/66fh2oGpxMGB9d8nlmzwxQMgEwV
	wDxkzlQzgEEKroY0OdUSobaLKpnaqBCWefobPw8oMvwK7yJSbArxJxEf8SND1DmGwvaiZB/c3TfXg
	TLFJIzEg==;
Received: from fpd2fa7e2a.ap.nuro.jp ([210.250.126.42] helo=[192.168.1.8])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roCW4-0000000Cwtk-1hTK;
	Sun, 24 Mar 2024 01:19:16 +0000
Message-ID: <63e4017f-dcdd-4c28-9591-1ce7f0e9b761@infradead.org>
Date: Sun, 24 Mar 2024 10:19:06 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: ps3: mark ps3_notification_device static for
 stack usage
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Arnd Bergmann <arnd@kernel.org>
Cc: llvm@lists.linux.dev, Kevin Hao <haokexin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Justin Stitt <justinstitt@google.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Bill Wendling <morbo@google.com>
References: <20240320180333.151043-1-arnd@kernel.org>
 <CAMuHMdW41e+DSBKBgugTkjoLy6bXfji-KWmB_d9EstEv01eC6w@mail.gmail.com>
 <87f6365f-a40e-4606-baff-170cb8fc48f3@infradead.org>
 <7f854130-e92f-488f-9c56-a65f86b95567@app.fastmail.com>
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <7f854130-e92f-488f-9c56-a65f86b95567@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/23/24 05:24, Arnd Bergmann wrote:
> On Fri, Mar 22, 2024, at 09:34, Geoff Levand wrote:
>> On 3/21/24 17:32, Geert Uytterhoeven wrote:
>>> --- a/arch/powerpc/platforms/ps3/device-init.c
>>>> +++ b/arch/powerpc/platforms/ps3/device-init.c
>>>> @@ -770,7 +770,7 @@ static struct task_struct *probe_task;
>>>>
>>>>  static int ps3_probe_thread(void *data)
>>>>  {
>>>> -       struct ps3_notification_device dev;
>>>> +       static struct ps3_notification_device dev;
>>>>         int res;
>>>>         unsigned int irq;
>>>>         u64 lpar;
>>>
>>> Making it static increases kernel size for everyone.  So I'd rather
>>> allocate it dynamically. The thread already allocates a buffer, which
>>> can be replaced at no cost by allocating a structure containing both
>>> the ps3_notification_device and the buffer.
> 
> I didn't think it mattered much, given that you would rarely
> have a kernel with PS3 support along with other platforms.
> 
> I suppose it does increase the size for a PS3-only kernel
> as well, while your version makes it smaller.
> 
>> Here's what I came up with.  It builds for me without warnings.
>> I haven't tested it yet.  A review would be appreciated.
> 
> It seems a little complicated but looks all correct to
> me and reduces both stack and .data size, so
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd.  I also thought it was a bit too much.  I made a simpler
version that I'll post as a separate message.

-Geoff


