Return-Path: <linux-kernel+bounces-21532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7438290D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 851D51C24FE5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCBB3E480;
	Tue,  9 Jan 2024 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AikfLPJb"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E503C3D988
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5c65ca2e1eeso1388295a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 15:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704843002; x=1705447802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lHit1FWZjhRsqzfH5p61HM2zahiy0ipQsQIOE6qhWU=;
        b=AikfLPJb9uodJFk/Yq5jCqPylAacYeKdjHDuO6x86OMWXZYAG//Id1sz6eXrdtOyw4
         TGny8ebShV6vV4Vj+BtTru08dNCOzX1Re8sMyJZnrh455BHNNM/FsYIGOsw5hZShxz1z
         p5djkvCiw5UEZia+XxJp2D9Atjj3a0zdUHB9o8bduSbfEUmLHvy4tbfReoF70/+Xjh5s
         pNEJo8SdTZMhivNeL9UjaJniwqrl/pt1AtskOmI+OtAiU/jNo/avmfdIrlIASKkQPFBS
         h/xhAe9WWnC3O+LGY3X7H+Ht0AEGiDmnGDc3SP7Sn0Kmf8rxqCdI/wxV5Y68yP01eLnB
         vK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704843002; x=1705447802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lHit1FWZjhRsqzfH5p61HM2zahiy0ipQsQIOE6qhWU=;
        b=bVsMxR8zxaFVypA3vk6l/A0tDOnlAzAxUsXAhWuntttn92eALc9Af+lcJ4DwHY0x37
         BIDN0ASltgVKACOyoWHPtb9OilEwgV0Ao07IxRhBzmVj5fSf4Uy9j1jvlzQqeFrqQXLf
         n0+Osq54GiuVpKdrIl+FbfIYsJ6MxdEUEenca+dvkOLgPvvf7wmkOOfBP3PzeoAvT14h
         dWGI69DnfzZEENPNl1kv32tndqqscA/iOOsVmzxmd4zYz3Iu7LRvBficdGk+ScWcykYk
         88MGFw7AmdLBrY28W4zydm5JjrRhxGUBaTdgyJg8CwP5djagkZvtxkkSieshQGfep71X
         Mlew==
X-Gm-Message-State: AOJu0YxUDeZ7g4Oop9ZfkgyWR8JjPie5m4QjfW/hW86smC5mBqtw21ir
	+V2Y39KFOkAFQ7W4hU9tsyzQhMdILJZWhQl4FifbNtqzvM8=
X-Google-Smtp-Source: AGHT+IFjJTYcEiXiPqMuKO2ANppXvmnkt+HfgcfaxSUTNwR+/4AQqe1r7JKGRBnHIGoVhfrHIbQYD6cAizW961pzPZY=
X-Received: by 2002:a05:6a20:8904:b0:199:dc2d:ff28 with SMTP id
 i4-20020a056a20890400b00199dc2dff28mr56714pzg.71.1704843002021; Tue, 09 Jan
 2024 15:30:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
 <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com>
In-Reply-To: <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com>
From: Andrew Pinski <pinskia@gmail.com>
Date: Tue, 9 Jan 2024 15:29:49 -0800
Message-ID: <CA+=Sn1n18OmcDzDrZky_KqMW76ttTLGnMYnH5CPg7m9SXor1qQ@mail.gmail.com>
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 11:57=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> Hi all, I'm going to stir the hornet's nest and make what has become the
> ultimate sacrilege.
>
> Andrew Pinski recently made aware of this thread. I realize it was
> released on April 1, 2018, and either was a joke or might have been
> taken as one. However, I think there is validity to it, and I'm going to
> try to motivate my opinion here.
>
> Both C and C++ has had a lot of development since 1999, and C++ has in
> fact, in my personal opinion, finally "grown up" to be a better C for
> the kind of embedded programming that an OS kernel epitomizes. I'm
> saying that as the author of a very large number of macro and inline
> assembly hacks in the kernel.
>
> What really makes me say that is that a lot of things we have recently
> asked for gcc-specific extensions are in fact relatively easy to
> implement in standard C++ and, in many cases, allows for infrastructure
> improvement *without* global code changes (see below.)
>
> C++14 is in my option the "minimum" version that has reasonable
> metaprogramming support has most of it without the type hell of earlier
> versions (C++11 had most of it, but C++14 fills in some key missing piece=
s).
>
> However C++20 is really the main game changer in my opinion; although
> earlier versions could play a lot of SFINAE hacks they also gave
> absolutely useless barf as error messages. C++20 adds concepts, which
> makes it possible to actually get reasonable errors.
>
> We do a lot of metaprogramming in the Linux kernel, implemented with
> some often truly hideous macro hacks. These are also virtually
> impossible to debug. Consider the uaccess.h type hacks, some of which I
> designed and wrote. In C++, the various casts and case statements can be
> unwound into separate template instances, and with some cleverness can
> also strictly enforce things like user space vs kernel space pointers as
> well as already-verified versus unverified user space pointers, not to
> mention easily handle the case of 32-bit user space types in a 64-bit
> kernel and make endianness conversion enforceable.
>
> Now, "why not Rust"? First of all, Rust uses a different (often, in my
> opinion, gratuitously so) syntax, and not only would all the kernel
> developers need to become intimately familiar to the level of getting
> the same kind of "feel" as we have for C, but converting C code to Rust
> isn't something that can be done piecemeal, whereas with some cleanups
> the existing C code can be compiled as C++.
>
> However, I find that I disagree with some of David's conclusions; in
> fact I believe David is unnecessarily *pessimistic* at least given
> modern C++.
>
> Note that no one in their sane mind would expect to use all the features
> of C++. Just like we have "kernel C" (currently a subset of C11 with a
> relatively large set of allowed compiler-specific extensions) we would
> have "kernel C++", which I would suggest to be a strictly defined subset
> of C++20 combined with a similar set of compiler extensions.) I realize
> C++20 compiler support is still very new for obvious reasons, so at
> least some of this is forward looking.
>
> So, notes on this specific subset based on David's comments.
>
> On 4/1/18 13:40, David Howells wrote:
> >
> > Here are a series of patches to start converting the kernel to C++.  It
> > requires g++ v8.
> >
> > What rocks:
> >
> >   (1) Inline template functions, which makes implementation of things l=
ike
> >       cmpxchg() and get_user() much cleaner.
>
> Much, much cleaner indeed. But it also allows for introducing things
> like inline patching of immediates *without* having to change literally
> every instance of a variable.
>
> I wrote, in fact, such a patchset. It probably included the most awful
> assembly hacks I have ever done, in order to implement the mechanics,
> but what *really* made me give up on it was the fact that every site
> where a patchable variable is invoked would have to be changed from, say:
>
>         foo =3D bar + some_init_offset;
>
> ... to ...
>
>         foo =3D imm_add(bar, some_init_offset);
>
>
> >   (2) Inline overloaded functions, which makes implementation of things=
 like
> >       static_branch_likely() cleaner.
>
> Basically a subset of the above (it just means that for a specific set
> of very common cases it isn't necessary to go all the way to using
> templates, which makes the syntax nicer.)
>
> >   (3) Class inheritance.  For instance, all those inode wrappers that r=
equire
> >       the base inode struct to be included and that has to be accessed =
with
> >       something like:
> >
> >       inode->vfs_inode.i_mtime
> >
> >       when you could instead do:
> >
> >       inode->i_mtime
>
> This is nice, but it is fundamentally syntactic sugar. Similar things
> can be done with anonymous structures, *except* that C doesn't allow
> another structure to be anonymously included; you have to have an
> entirely new "struct" statement defining all the fields. Welcome to
> macro hell.
>
> > What I would disallow:
> >
> >   (1) new and delete.  There's no way to pass GFP_* flags in.
>
> Yes, there is.
>
> void * operator new (size_t count, gfp_flags_t flags);
> void operator delete(void *ptr, ...whatever kfree/vfree/etc need, or a
> suitable flag);
>
> >   (2) Constructors and destructors.  Nests of implicit code makes the c=
ode less
> >       obvious, and the replacement of static initialisation with constr=
uctor
> >       calls would make the code size larger.
>
> Yes and no. It also makes it *way* easier to convert to and from using
> dedicated slabs; we already use semi-initialized slabs for some kinds of
> objects, but it requires new code to make use of.
>
> We already *do* use constructors and *especially* destructors for a lot
> of objects, we just call them out.
>
> Note that modern C++ also has the ability to construct and destruct
> objects in-place, so allocation and construction/destruction aren't
> necessarily related.
>
> There is no reason you can't do static initialization where possible;
> even constructors can be evaluated at compile time if they are constexpr.
>
> Constructors (and destructors, for modules) in conjunction with gcc's
> init_priority() extension is also a nice replacement for linker hack
> tables to invoke intializer functions.
>
> >   (3) Exceptions and RTTI.  RTTI would bulk the kernel up too much and
> >       exception handling is limited without it, and since destructors a=
re not
> >       allowed, you still have to manually clean up after an error.
>
> Agreed here, especially since on many platforms exception handling
> relies on DWARF unwind information.

Let me just add a few things about exceptions and RTTI.
In the darwin kernel, C++ is used for device drivers and both
exceptions and RTTI is not used there either. They have been using C++
for kernel drivers since the early 2000s even.
You can find out more at https://developer.apple.com/documentation/driverki=
t .
There even was a GCC option added an option which would also disable
RTTI and change the ABI to explicitly for the kernel.
-fapple-kext/-mkernel (the former is for only loadable modules while
the latter is for kernel too).

Note even in GCC, we disable exceptions and RTTI while building GCC.
This is specifically due to not wanting to use them and use other
methods to do that.
Note GDB on the other hand used to use setjmp/longjmp for their
exception handling in C and I think they moved over to using C++
exceptions which simplified things there. But as far as I know the
Linux kernel does not use a mechanism like that (I know of copy
from/to user using HW exceptions/error/interrupt handling but that is
a special case only).


>
> >   (4) Operator overloading (except in special cases).
>
> See the example of inline patching above. But yes, overloading and
> *especially* operator overloading should be used only with care; this is
> pretty much true across the board.
>
> >   (5) Function overloading (except in special inline cases).
>
> I think we might find non-inline cases where it matters, too.
>
> >   (6) STL (though some type trait bits are needed to replace __builtins=
 that
> >       don't exist in g++).
>
> Just like there are parts of the C library which is really about the
> compiler and not part of the library. <type_traits> is part of that for C=
++.

There is an idea of a free standing C++ library. newer versions of
GCC/libstdc++ does support that but IIRC can only be configured at
compile time of GCC.
type_traits and a few other headers are included in that. I have not
looked into it fully though.

Thanks,
Andrew Pinski

>
> >   (7) 'class', 'private', 'namespace'.
> >
> >   (8) 'virtual'.  Don't want virtual base classes, though virtual funct=
ion
> >       tables might make operations tables more efficient.
>
> Operations tables *are* virtual classes. virtual base classes make sense
> in a lot of cases, and we de facto use them already.
>
> However, Linux also does conversion of polymorphic objects from one type
> to another -- that is for example how device nodes are implemented.
> Using this with C++ polymorphism without RTTI does require some
> compiler-specific hacks, unfortunately.
>
> > Issues:
> >
> >   (1) Need spaces inserting between strings and symbols.
>
> I have to admit I don't really grok this?
>
> >   (2) Direct assignment of pointers to/from void* isn't allowed by C++,=
 though
> >       g++ grudgingly permits it with -fpermissive.  I would imagine tha=
t a
> >       compiler option could easily be added to hide the error entirely.
>
> Seriously. It should also enforce that it should be a trivial type.
> Unfortunately it doesn't look like there is a way to create user-defined
> implicit conversions from one pointer to another (via a helper class),
> which otherwise would have had some other nice applications.
>
> >   (3) Need gcc v8+ to statically initialise an object of any struct tha=
t's not
> >       really simple (e.g. if it's got an embedded union).
>
> Worst case: constexpr constructor.
>
> >   (4) Symbol length.  Really need to extern "C" everything to reduce th=
e size
> >       of the symbols stored in the kernel image.  This shouldn't be a p=
roblem
> >       if out-of-line function overloading isn't permitted.
>
> This really would lose arguably the absolutely biggest advantage of C++:
> type-safe linkage. This is the one reason why Linus actually tried to
> use C++ in one single version of the kernel in the early days (0.99.14,
> if I remember correctly.) At that time, g++ was nowhere near mature
> enough, and it got dropped right away.
>
>
> > So far, it gets as far as compiling init/main.c to a .o file.
>
> ;)

