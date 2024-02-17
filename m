Return-Path: <linux-kernel+bounces-69946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DDD8590A2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71EB2B217AC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6237C6E5;
	Sat, 17 Feb 2024 15:46:27 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4022026AE0;
	Sat, 17 Feb 2024 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708184786; cv=none; b=l9WZbhYmWxHOQClleuCW51Xy3OfAMC4j46aTztABhIGdUGnGZ0gEV+2AG8g4Rgc1NfNfoLT21h0XSE9JD4Kj8toCH1b8C3mVEj22/IicFmNcmG5Ksl4FLkTaB1bF24SScOhUd3YQGlDhxe+FkdHBPLNcd+0SUw9ZV47TFN1ZkAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708184786; c=relaxed/simple;
	bh=zkvCGDhfNlH1XtqKg70gou2/9kz8mp1HggqC/aC/z5M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OZ5rMjOUAn2fyLad9a18LMhDCBKpz9YPD8OfNTYAZCLWBUbGF7WIJTA7gx4esm/EDBWNX3vptzYIflj+xP7bpF3Y09M8M7lM/gTUjqAoOJXgshTRUgoYUNUYndUfpsguwcROYfVPbvjFeF3UmzEY33vmUR8XQrxbaCpk7MD1RBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rbMtM-0000pe-5r; Sat, 17 Feb 2024 16:46:16 +0100
Message-ID: <62ea7097-256c-4331-b937-778444125a06@leemhuis.info>
Date: Sat, 17 Feb 2024 16:46:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v1] docs: new text on bisecting which also covers bug
 validation
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: Jonathan Corbet <corbet@lwn.net>, regressions@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bagas Sanjaya <bagasdotme@gmail.com>, Nathan Chancellor <nathan@kernel.org>
References: <bf1d2eba0d291ff583e01b5985a0dec248eaf27a.1708072870.git.linux@leemhuis.info>
 <20240216204140.2ecbceec@meshulam.tesarici.cz>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <20240216204140.2ecbceec@meshulam.tesarici.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1708184783;7cef09da;
X-HE-SMSGID: 1rbMtM-0000pe-5r

On 16.02.24 20:41, Petr Tesařík wrote:
> On Fri, 16 Feb 2024 09:54:46 +0100
> Thorsten Leemhuis <linux@leemhuis.info> wrote:

First off a big "thank you" for your feedback, very much appreciated; it
was really helpful.

I followed your suggestions most of the time, sometimes with a few small
changes. I only mentions things below where I didn't do that or when
there was some other reason to reply.

>> [...]
>> Style and structure of the text match the one
>> Documentation/admin-guide/quickly-build-trimmed-linux.rst uses. Quite a
>> few paragraphs are even copied from there and not changed at all or only
>> slightly. This will complicate maintenance, as some future changes to
>> one of these documents will have to be replicated in the other. But this
>> is the lesser evil: solutions like "sending readers from one document
>> over to the other" or "extracting the common parts into a separate
>> document" might work in other cases, but would be too confusing here
>> given the topic and the target audience.
> 
> Is this because you want to keep it readable if the target audience
> reads the source text of the documentation? Otherwise, the .. include
> directive does not make a difference after rendering to HTML. AFAIK.

It less that I want that, it's more that I got the impression that both
Jonathan and most of the kernel development community wants the source
text to be readable; not totally sure, but I think that's the right
thing to do, too.

>> [...]
>> * The text as of now does not really describe what a bisection is --
>> neither in general nor in the scope of Git. Maybe that should be
>> added. Having a few nice graphical diagrams might also be good, as the
>> text is meant to be read in rendered form anyway. But I think it's
>> useful like this already.
> 
> But here you expect it to be read in rendered form.

It's just a suggestion (like the note in the test), but readers are
still free to ignore it if they want an won't run into major trouble.

> So, are you afraid
> of making things confusing for potential later editors of this text?

Not something I have thought about much about yet, but yes, keeping
things simple is likely in everybody's interest.

>> [...]
>> diff --git a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
>> new file mode 100644
>> index 00000000000000..0a6a1a082d867c
>> --- /dev/null
>> +++ b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
>> @@ -0,0 +1,1925 @@
>> +.. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)
>> +.. [see the bottom of this file for redistribution information]
>> +
>> +=========================================
>> +How to verify bugs and bisect regressions
>> +=========================================
>> +
>> +This document describes how to check if some Linux kernel problem occurs in the
>> +code developers currently support
> 
> I got puzzled for a moment as the subject of the sentence changed. What about:
> 
>   code currently supported by developers

As you have noticed here and everywhere: It seems I have overdone the
"avoid passive voice" approach. I followed your advice here and in other
places.

>> -- to then explain how to locate the change
>> +causing the issue, if it did not happen with earlier versions.
> 
> I believe this part of the sentence could be also improved. I would not
> be afraid of introducing the word "regression" here, e.g.:
> 
>   It also explains how to locate the change which introduced the issue if
>   it did not happen with an earlier version. Such issues are commonly
>   called regressions.

Hmmm. That to me feels a bit to dry for the first sentence of the
document, especially that "Such issues are commonly called regressions."
part. I reworked my version slightly, but not much:

 This document describes how to check if some Linux kernel problem
 occurs in code currently supported by developers -- to then explain how
 to locate the change causing the issue, if it is a regression (e.g. did
 not happen with earlier versions).

Not sure if the word regression really needs to be used and explained
here, as it's already in the headline. But whatever.


>> +    # * Hint: at this point you might want to adjust the build configuration;
>> +    #   you'll have to, if you are running Debian.
> 
> Ugh... this step is necessary if you are running Debian ?

It definitely was and it's still in the Debian docs[1], but I haven't
recently checked.

[1] search for "Missing debian/certs/debian-uefi-certs.pem" in
https://debian-handbook.info/browse/stable/sect.kernel-compilation.html

>> +    one. Note, you in this case nevertheless want to compile a mainline kernel
>> +    as explained in segment 1, as that will determine if that is a bug that the
>> +    regular developers or the stable team will have to handle.
> 
> Ugh again. Probably:
> 
>   Note, in this case you still want to compile a mainline kernel as
>   explained in segment 1. It will be used to decide if your issue will
>   be handled by regular developers or by the stable team.

I went with this instead:

 Note, in this case you still want to compile and test a mainline kernel
 as explained in segment 1: the outcome will determine if you need to
 report your issue to the regular developers or the stable team.

>> +* Retrieve the mainline Linux sources; then change into the directory holding
>> +  them, as all further commands in this guide are meant to be executed from
>> +  there.
>> +
>> +  *Note, the following describe how to retrieve the sources using a full
>> +  mainline clone, which downloads about 2,75 GByte as of early 2024. The*
>> +  :ref:`reference section describes two alternatives <sources_bisref>` *:
>> +  one downloads less than 500 MByte, the other works better with unreliable
>> +  internet connections.*
>> +
>> +  Execute the following command to retrieve a fresh mainline codebase::
>> +
>> +    git clone -o mainline --no-checkout \
>> +      git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ~/linux/
>> +    cd ~/linux/
> 
> This is not very nice to git-daemon. Plus, it uses the insecure git
> protocol.

Argh, the latter was definitely unintended (it likely sneaked in due to
some unobservant cut'n'paste...). :-/ Fixed!

> Is it too much to show cloning from a bundle instead?
> 
>   https://www.kernel.org/cloning-linux-from-a-bundle.html

I know, but it's much more commands, that's why I decided against this.
And from what I heard from Konstantin when that came up during the
submission of the "quickly build trimmed kernel" guide it's not that bad
if a few users do it like that; CI systems are the big problem here.

> I stop here and call it a week. I may read the rest later. Hope even
> this much helps .

It helped a great deal, thx again!

Ciao, Thorsten

