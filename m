Return-Path: <linux-kernel+bounces-25052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC9482C6EC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C271F2316D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 21:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E6717725;
	Fri, 12 Jan 2024 21:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4UsTs9W"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC8715E94
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 21:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a28a997f3dfso537007366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705096722; x=1705701522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yMTOTETbcTc5oBdRyZ0Ty8Au2cLzJJeuH/OfFaa9eKc=;
        b=d4UsTs9WDSIn7RKd0I488jmlrZdnNcqJPbY8WIAYUepnklnn8BBzRUGWZPSzUKk4oz
         64PNi2VsJPZPswmySP5GUJLQVewYmnWbi42o/BmQsv6OSHHO9+u3aUK3Q87AyQCqRiZA
         izFoND2Z/BnESmsYMTHKz3cshijhgMRlvjKPjFWPqDsuLfwmS9/N0zDgzHAB2W16KXwT
         XiXylV99Eq9jXmK2iwf3kVYNpuWnpWRAjD9HwN0b0IkZGoIsU/BU+jyQU67Mw1bdHyJn
         n6K0OusaOXRSMSYXDal3dQKOb2ZbKzya5jQqhNO0KAkix7X6QAtu8wesWT159LQk9glM
         CySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705096722; x=1705701522;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMTOTETbcTc5oBdRyZ0Ty8Au2cLzJJeuH/OfFaa9eKc=;
        b=YQO/3HroDA/wSDi8k5LFgcFMTXLc8cQ66pihhzTCw1O/fuNOCUnU9Iyp8EZAzaXy3y
         AJbS1NPsGvnPEJ86KYPsEl/dROzcZoF/+BJ33DNsuNxPk4IqWcGTfzSil5yngQALnQDl
         9LIr16FZpOQTlBGI7iJYBZrvmrahS2S3NCNrgdSBRi0/sCeu6Qm41HwpmeKuLpaoXq5u
         LFoHwHJMit7fxGtvMCdSecxc6u6P94+77yL7Q+sfUwMmS2+mVtqHlVR1huE+MkBU5PQ4
         OpQg/ER1LC608SbYQCzTa3eF6F8c5tFb+wxWxXnHD7W3kjdiv2LhnucPr5J4O36BQ1+D
         mT7w==
X-Gm-Message-State: AOJu0Ywi1Spjpe4i1cqNFGwwBuhSXlb9BRZMays49dhbZRtbD8PjXDh8
	rQ4pCHYtyR796Y4iEwi7OHE=
X-Google-Smtp-Source: AGHT+IFcZnLGVrU8x+aUKcRjY8XMFwnMiAu5PL4qts37riT0SuX5UDh/JXUvUiR8DNxTbph6C8XzWg==
X-Received: by 2002:a17:906:1583:b0:a28:a36e:98ac with SMTP id k3-20020a170906158300b00a28a36e98acmr1046308ejd.68.1705096722112;
        Fri, 12 Jan 2024 13:58:42 -0800 (PST)
Received: from [10.30.166.181] ([191.96.168.189])
        by smtp.gmail.com with ESMTPSA id y11-20020a170906524b00b00a233515c39esm2193588ejm.67.2024.01.12.13.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 13:58:41 -0800 (PST)
Message-ID: <d535f0b5-7319-4a21-a002-eb4074758c22@gmail.com>
Date: Fri, 12 Jan 2024 22:58:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Content-Language: en-US
To: "Enrico Weigelt, metux IT consult" <info@metux.net>,
 "H. Peter Anvin" <hpa@zytor.com>, David Howells <dhowells@redhat.com>,
 linux-kernel@vger.kernel.org, pinskia@gmail.com
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
 <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com>
 <b931d02e-a414-4f5c-acc8-160d7b5e016a@gmail.com>
 <69fe1c0c-b5ec-4031-b719-d9c14742929c@metux.net>
From: Michael de Lang <kingoipo@gmail.com>
In-Reply-To: <69fe1c0c-b5ec-4031-b719-d9c14742929c@metux.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for your reply.

>> Namely, to prevent stagnation for the Kernel as well as continue to be 
>> interesting to new developers.
> 
> Which stagnation are you talking about, exactly ?

While I do not know what Linus was exactly thinking about when he 
mentioned stagnation, I assume he was looking at it from the lens of 
long-term maintainers. I'm basing this on the 2021 discussion on lwn: 
https://lwn.net/Articles/870581/. Obviously there are plenty of 
contributors every kernel release and while I don't have any numbers 
there, I don't think # of contributors or # of contributions is an issue.

Still, the idea of C discouraging people to contribute resonates with 
me. That is largely based on subjectivity so feel free to ignore it.

> 
> While I've got a long list of ideas for modernizing the kernel
> (which I'm lacking time to actually work on), I'm unsure whether
> C++ really would be of much benefit. Especially considering that for
> many things there's no way to know / define how things will really
> look like on binary level.

Do you have any examples on what exactly in C++ obfuscates the resulting 
binary? Everything I can think of, also applies to C: anything 
implementation-defined, e.g. struct layout, high-order bit propagation 
for shift operations,

There are things in the STL that are implementation defined, but the 
proposal excludes the STL.

> Personally, the opposite had been one my primary reasons.
> Because it's so simple to understand - in contrast to the usual C++
> monster's i've seen so often in the wild. (I usually try to keep far
> away from C++ projects). 

I have never understood the sentiment that C is supposedly simple. 
Looking at the macros used in the kernel is one obvious big argument 
against using C, as macros can be considered their own 
language-inside-a-language. Another big argument against the sentiment 
is the loose type system, where void* casts are everywhere you want to 
do anything remotely type-generic, losing type information and making it 
harder to grok the original intent.

Creating a compiler for C is 'easier' than creating one for C++ (or Rust 
for that matter), but coding in it as a user requires years of 
experience to avoid a lot of the pitfalls. A simple language would be 
something like golang, with its GC and prescribed coding patterns.

C is a language to be (ab)used like any other, the same goes for C++. 
The kernel has shown that it is possible to create maintainable C, I 
feel confident saying that it is also possible in C++.

 > Note that C++ is a very complex language,
 > and w/ STL it's even much, much more complex.

Note that the proposal here is to use C++ without the STL as well as 
apply some other restrictions.

> Can't judge what you see as interesting, but frankly, I really don't
> have it on my list of interesting things - instead would prefer phasing
> C++ out in favour of many other languages.

I could give you concrete examples of C++ language addition examples, 
but I don't think that adds much to the discussion. Many languages, 
including C++, have additions that C does not have and provide benefits 
such as reduced cognitive load, standardised ways to do things 
preventing NIH syndrome and possibly enthuse more people to contribute 
to the kernel.

The biggest merit of using C++ in the kernel is that in comparison to 
other systems language (Zig, Rust, Swift to name a few) it requires the 
least re-skilling of existing contributors. A close second would be the 
low barrier to integrate various C++ and C codebases. Especially when 
taking into account the architectures that the kernel needs to support 
vs the other languages. Even Rust with its big push towards being a 
replacement isn't there yet today (e.g. PA-RISC).

> 
>> other languages, unlike C. The aforementioned metaprogramming is one 
> 
> Metaprogramming can be very interesting indeed - Oberon once made a 
> really good show case, but I wouldn't dare trying that in kernel space.
> And it's hard to do that w/o causing extra performance penalties.

I believe this is a case of having to try it first before being able to 
decisively say anything about the impact. Counter-examples have been 
mentioned elsewhere in the thread.

> 
>> such example, but things like RAII, smart pointers and things like 
>> gsl::not_null would reduce the changes on kernel bugs, especially 
>> memory safety related bugs that are known to be vulnerable to security 
>> issues.
> 
> These are exactly the things I would prefer keeping out of kernel space.
> Indeed there're several areas where it could be nice, but there're
> others where we really can't take it.

As you mention yourself, there are places where such constructs would be 
a boon and places where we should not apply them. I have faith in the 
Kernel processes to weed out using things where they should not, as is 
presumably done already for certain C constructs today.

> 
>> On the other hand, the benefits I mention can also turn into 
>> downsides: if constructs like gsl::not_null are desired, does that 
>> mean that there 
> 
> this seems to be pretty much an assert() - obviously something we really
> cannot have in the kernel.

gsl::not_null prevents constructing a pointer with NULL, ensuring at 
compile-time that it never happens. As such, an assert() would be 
superfluous. It is exactly an example of a C++ construct that has no 
downsides and only upsides.

> 
>> will be a kernel-specific template library? A KTL instead of STL? That 
>> might be yet another thing that increases the steepness of the kernel 
>> development learning curve.
> 
> Most likely we'd need our own kernel specific library. (we also have one
> instead of libc). Some simple pieces might look similar to STL on the
> front, but it would have to be very different from userland.
> 
> At that point, your previous argument about attracting more people
> who're already used to / like C++ breaks down, because it wouldn't be
> that C++ as usual C++ devs know it (IIRC, STL is integral part of the
> standard), but just the core lang plus some very custom template lib.

It's not that the argument breaks down, it's that it applies to a 
smaller, but still greater than 0, target audience. There are plenty of 
C++ programmers out there that disable the STL on purpose: game 
developers, automotive engineers that I know and so on. You're going to 
be hard-pressed to find concrete numbers, but the fact that the EASTL 
and ETL exist shows the proliferation of non-STL C++ and that the STL 
itself is not an integral part of C++. I recommend you check out ETL 
specifically, I'm sure you'll be amazed at how much functionality it 
has, especially geared for the embedded world.

> 
>> Although compiler-specific, C++20 has enabled implementing RTTI 
>> without RTTI as well as (partial) reflection. 
> 
> You name it: compiler specific.
> 
> Is it even specified how this exactly looks at binary level, and methods
> to control the exact binary data structures ?
> 
> The least thing's need to implement such things is some pointer or tag
> inside each struct/object instance - this would change struct layouts!
> Note that we often use structs to reflect HW specific data structures,
> so we'd need a way to have exact control over this. And then we need to
> be very careful on which instances have RTTI and which ones don't.
> I see debugging nightmares on the horizon ...

I could be convinced that RTTI of any sort is just a bad idea in the 
kernel. It is one of the things that is first to be disabled in embedded 
C++ usage, alongside exceptions. Still, it has its uses even in those 
areas, but that's outside of the scope of this proposal I think.

> 
>> On top of increasing the binary size, 
> 
> That's also a huge problem:
> 
> Templates in general have the strong tendency of producing lots of
> duplicated code. That's what they're designed for: expressing similar
> things (that have to be different on binary level) by the same
> generic source code.
> 
> It might be possible to write them in a way they don't increase binary
> size, but that's not entirely trivial, and so the actual gain of all
> of that becomes questionable again.

Hmm, explicit template instantiations are an 'easy' fix to taming the 
code bloat, but any use of templates is going to mean _some_ extra code 
generation. I do not have any concrete Kernel examples here, but I'm 
sure there are switch/case statements somewhere in there that can be 
optimized away by using templates. For those, the question is: code 
bloat or run-time performance?

> 
>> this then becomes a discussion on what requirements the kernel puts on 
>> compilers, as I'm sure that the kernel needs to be compiled for 
>> architectures which have a less than stellar conformance to the C++ 
>> specification. 
> Indeed. Also think about embedded environments, where folks can't easily
> upgrade toolchains (e.g. due regulative constraints)
> 

This argument also applies against using Rust and is directly opposed to 
modern security practices. Updating to the latest version for 
OS/compilers/libraries etc is pretty much a given since UN R155 and UN 
R156 came into effect. Though those apply only to automotive so far, the 
Cyber Resilience Act is going to force manufacturers of all kinds to 
adhere to better security. There is definitely a whole debate we can 
have just on the impacts of these regulations and what that should mean, 
but I've already written a lot ;)

Cheers,
Michael de Lang

