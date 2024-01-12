Return-Path: <linux-kernel+bounces-25021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E79982C63B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 21:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A17D28A4F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A7B16418;
	Fri, 12 Jan 2024 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="riQDeR6N"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2206116426
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3606e211e5cso38220985ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 12:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1705090160; x=1705694960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qi7ahWRNr4va46lLuUmUarHz+nLvldyY8ZmIKxB5ha0=;
        b=riQDeR6N09IuKANjot5eXQ0ldJumppL7xiL06LOCLRbXAV5WKIZCLDWqKkOOgRKLXq
         JWvGpaB5GZbZH70xMJNEdxj9rM8YfMKfCNCX8OrFRArXwvf34Vui4m7yfb3CHp3WOFKv
         5pKo/TPW4bcZ8n+nG5AN9i5E5J/kem/gcuurE17Ngs26o/GaLlgeNEyv0ipCqs+yoxlT
         6uCuA7TBoNdc/GezMjwmWXw+m0+TJLfo8kg33+oXrduU/K25QW8XYdyT1zZozrWW/8be
         r4ZNBn7qvFfYNzWDljly6fRVy0CgT98/anEXODmiHrEUaN7HDn4HpX0JJhEVwHIWwVz3
         WRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705090160; x=1705694960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qi7ahWRNr4va46lLuUmUarHz+nLvldyY8ZmIKxB5ha0=;
        b=RpPBTonwOeyL79VE+SNkI9E7IZahCkFzpQYZK5VLQzR83ncmCxY5WX3xHgXpyaVIUr
         5I5qF+uSvZGFoQjOtC51N5tX4zRRU/TmlATwKDjmJk13P9TPwff6AVP+WRSloeerCyDw
         yDcLaHRPTLuQ5n4UpGpsywL3WDIrJpMSyL5Ge+TKg5QWRAC2lw8WzyWaADVFVS1kGzMC
         V+BRYh9TwVTFaKT+yCgRo6WR+oDbf3oSgdrZuNlVZY9oaHUsADJg3mNF/D3luERkat8O
         262kHke+nh4i9au2WG+OBct++/eTzJAKbJQS4PF3t3weJAWlq3X9BX8cT0MbtXL2ORHs
         VKXw==
X-Gm-Message-State: AOJu0Yz/M3QC53P32yWcMgVdsnu8+8cysphLh4VAWV8N7hhnLyIUd/Sc
	P774TwXIOM81CbCRDx+DUfXMa8YoJ7RM5g==
X-Google-Smtp-Source: AGHT+IGM33IxnSOMTljdz/sQzrgdqF+rjyq3wpEwaCo9W/CC+QXZzU4LX00TzJ1Cs2esx/4G6Alhjw==
X-Received: by 2002:a92:c9ce:0:b0:35e:6ba1:7dfb with SMTP id k14-20020a92c9ce000000b0035e6ba17dfbmr1749235ilq.29.1705090159876;
        Fri, 12 Jan 2024 12:09:19 -0800 (PST)
Received: from [172.16.32.83] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id u11-20020a02cbcb000000b0046e5fe2d364sm561874jaq.9.2024.01.12.12.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 12:09:19 -0800 (PST)
Message-ID: <d3a26b8e-8823-8f3c-b815-4396cbac1dc3@landley.net>
Date: Fri, 12 Jan 2024 14:16:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [Automated-testing] Call for nommu LTP maintainer [was: Re:
 [PATCH 00/36] Remove UCLINUX from LTP]
Content-Language: en-US
To: Greg Ungerer <gerg@linux-m68k.org>, Petr Vorel <pvorel@suse.cz>,
 Tim Bird <tim.bird@sony.com>
Cc: Cyril Hrubis <chrubis@suse.cz>, Geert Uytterhoeven
 <geert@linux-m68k.org>, "ltp@lists.linux.it" <ltp@lists.linux.it>,
 Li Wang <liwang@redhat.com>, Andrea Cervesato <andrea.cervesato@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>,
 "buildroot@buildroot.org" <buildroot@buildroot.org>,
 Niklas Cassel <niklas.cassel@wdc.com>
References: <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki> <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
 <20240108090338.GA1552643@pevik> <ZZvJXTshFUYSaMVH@yuki>
 <SA3PR13MB6372498CC6372F8B16237244FD6A2@SA3PR13MB6372.namprd13.prod.outlook.com>
 <20240110141455.GC1698252@pevik>
 <40996ea1-3417-1c2f-ddd2-e6ed45cb6f4b@landley.net>
 <81c07a13-305a-404b-b14c-3aff8fde3f67@linux-m68k.org>
From: Rob Landley <rob@landley.net>
In-Reply-To: <81c07a13-305a-404b-b14c-3aff8fde3f67@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/24 20:25, Greg Ungerer wrote:
> Sorry Rob, but I think you are wrong about a number of things here.

Happy to be corrected. I learned most of this stuff by people pointing things
out I didn't know. But I _have_ been trying to collect this info for about 15
years now...

> I know, I was there at the coal face so to speak during the early
> years of uClinux and right up today. I feel I have to correct some of
> the things you claim.

I only heard about the politics long after the fact, and the stories have a lot
of elisions because what happens in Utah sadly does NOT stay in Utah.

I didn't get involved in busybox until either 2002 or 2003 depending how you
want to count it. After the dot com crash, around the time of the SCO trial.
Erik Andersen having once worked there was about as relevant as Linus' day job
at Transmeta, or busybox having started life years earlier as Debian's answer to
Red Hat Nash before being abandoned for 3 years before Erik picked it up. I
heard that this stuff was used in uClinux, but its use in linksys routers was
far more immediately relevant.

Shortly after the dot-com crash Ray Noorda went senile and got elder abused into
allowing the SCO lawsuits run by the canopy group (his personal money managers,
gone rogue), by which time Erik Andersen and Jeff Dionne and Tim Bird and so on
had all gone on to other employers. Tim heading to Sony, Jeff moved to Japan to
do hardware and leaving uClinux behind, and Erik continued busybox and uclibc as
personal projects from a server connected to the DSL line in his basement.

By the time I showed up uclinux never came up on the mailing list, the IRC
channel, or in private email. I was introduced to busybox+uclibc by tomsrtbt,
and the highest profile consumer of Erik's output was Linksys routers.

My goal with busybox was making it work in a development environment, initially
to replace most of the the 110 megabytes of gnu bloatware in Linux From Scratch
with the 1.7 megabytes of tomsrtbt to free up some of the 700 megabyte budget of
knoppix CDs. Making that actually _work_ took long enough to accomplish that
"knoppix" stopped being "the bootable CD" and every distro had one now (usually
as their install CD: try it live then install from the desktop you'd booted into
if you want to keep it).

After I finally got it all working (https://landley.net/aboriginal/news.html
either the 1.0 release rebuilding itself under itself on September 5, 2010 or
the 1.1 release building Linux From Scratch 6.7 under the result on October 2,
2011 depending how you want to measure), I moved on to focusing on toybox
development instead (trying to get it into Android so THAT could become
self-hosting and provide a real development environment with a USB
keyboard+mouse and chromecast to a big TV), and other people took over creating
Adelie Linux and Alpine Linux and so on based on busybox instead of gnu tools.

I didn't get into nommu development full-time until 2014 when Jeff Dionne hired
me to work on his j-core project. I'd heard the name, but never spoken to him
before he reached out to me by email, then phone interview, then flew me to Japan.

While working for Jeff I asked various computer history questions because it's a
hobby of mine, but there's been a pandemic between then and now. I wasn't there,
the details of the answers I _did_ get are fuzzy by now, and there were some...
stories. Let's just say a canadian who moved to Utah and then moved to LITERALLY
THE OTHER SIDE OF THE PLANET may may have seen some stuff. I've also bumped into
Tim Bird on and off since 2006 (through CELF/ELC and the Linux Jamboree at
Nakano Sun Plaza in Tokyo and
https://elinux.org/CELF_Project_Proposal/Combine_tcg_with_tcc and so on) and
he's never spoken of Lineo once.

The work I did helped kill the old uclinux distro, although I didn't realize it
at the time. The various package patches it had carried were already pushed
upstream into linux and gcc and so on, and busybox worked as a nommu userspace.
By making "build a busybox+uclibc system with a vanilla kernel" easier to do and
more powerful by itself, uclinux became less relevant. Various people sent me
nommu fixes when I was maintaining busybox, which was like sending me fixes for
running busybox on linksys (or openwrt) routers. I didn't have that hardware,
but I knew the _general_ theory and tried not to break it. Don't do unaligned
access, be careful of endianness, and here's what's necessary for nommu:

https://git.busybox.net/busybox/commit/?id=b1b3cee831bc
https://git.busybox.net/busybox/commit/?id=03628c8f75ba
https://git.busybox.net/busybox/commit/?id=b21837714a37

When buildroot metastasized from uclibc's test suite (what packages build under
uclibc? Let's regression test them and slot them together into a testable root
filesystem) into a new distro (the first post to its mailing list in 2006 is
from me because I abused my busybox maintainer root access to the shared server
to set up a third list, because buildroot discussion was smothering uclibc
development on that list), buildroot became the logical base point for nommu
systems. If you wanted a busybox+uclibc root filesystem, buildroot provided an
up to date actively developed one with build recipes for hundreds of packages,
and a busy community where you could ask questions.

Meaning there was already no reason to install uclinux in 2006. It had been
replaced by either a simple busybox+uclibc root filesystem, or buildroot.

So "me noticing this area in 2002", "me accidentally helping finish off uclinux
in passing in 2006", and "me getting involved in nommu development in 2014
because Jeff Dionne flew me to Japan and personally explained it to me" does not
give me any direct experience with what went on at lineo before that, true. Just
like I never visited transmeta.

>> You can't fork() on nommu because copies of the mappings have different
>> addresses, meaning any pointers in the copied mappings would point into the OLD
>> mappings (belonging to the parent process), and fixing them up is 100%
>> equivalent to the "garbage collection in C" problem. (It's AI-complete. Of the
>> C3PO kind, not the "autocorrect with syntax checking" kind.) People get hung up
>> on the "it would be very inefficient to do that because no copy-on-write"
>> problem and miss the "the child couldn't FUNCTION because its pointer variables
>> all contain parent addresses" problem.
>> 
>> So instead vfork() creates a child with all the same memory mappings (a bit like
>> a thread) and freezes the parent process until that child discards those
>> mappings, either by calling exec() or _exit(). (At which point the parent gets
>> un-suspended.)
> 
> Just to be clear, vfork is not a uClinux invention.

I never said vfork() was a uClinux invention. I'm describing how Linux does
nommu. Doing nommu on linux hasn't had anything to do with uclinux for 20 years.

Confusing "uclinux" with "nommu" is like confusing "knoppix" with "Linux Live
CD". We've moved on a bit since one magic distro pioneered the technique literal
decades ago, there are other options now.

I first looked at uClinux itself in 2015 because Jeff Dionne asked me to see if
there was anything left to salvage out of it, resulting in
https://github.com/landley/toybox/commit/469d7f11b66d and the answer "no, there
isn't" nine years ago.

> It dates way back to the
> early BSD UNIX days.

I know.

> It just so happens that it fits in very nicely with
> the no-MMU model of the world.

Ken and Dennis' ported Unix from a PDP-7 to a PDP-11/20, which didn't have an
MMU. Dennis wrote about it here:

https://www.bell-labs.com/usr/dmr/www/odd.html

The PDP-11/45 the upgraded to did, and the system call sematics changed quite a
bit in those early years before stabilizing with Unix v7 (largely because AT&T
stopped allowing Bell Labs releases to go out to the public after that one, so
v8, v9, and v10 saw almost no use, and then they started over with Plan 9.)

So yeah I knew about BSD coming up with the name, but I thought "vfork()" was
just "what fork() used to do circa Unix v3 or similar"?

I was trying to explain why vfork() is still in use NOW. It's not just nommu
either, it's also useful when forking from heavily threaded processes, because
normal fork() will freeze all the threads in the process causing a latency spike
and potentially quite large allocation because in that case it breaks all
copy-on-write up front rather than trying to untangle the layers of sharing. But
vfork() will only freeze the one thread that called it, and doesn't allocate new
memory before the exec() or _exit() of the new child process. (You may hit a vma
lock if other threads try to tear down the mappings, I haven't tried. But if you
DON'T do something stupid, you don't get a latency spike on the other threads.)

>> So they invented FDPIC,

"They" being the blackfin devs, I think.

>> which is ELF with FOUR base pointers. Each major section
>> (rodata, text, data, and bss) has its own base pointer, so you need to find
>> smaller chunks of memory to load them into (and thus it can work on a more
>> fragmented system), AND it means that two instances of the same program can
>> share the read-only sections (rodata and text) so you only need new copies of
>> the writeable segments (data and bss. And the heap. And the stack.)
> 
> It is worth noting that to run PIE style ELF binaries on no-MMU systems you
> actually use the FDPIC ELF loader - not the traditional linux ELF loader (binfmt_elf).

Yup. Although that's mostly because binfmt_elf refuses to build without
CONFIG_MMU due to some stupid #ifdefs and assumptions.

My understanding (mostly from making puppy eyes at Rich Felker) is that the
bimfmt_fdpic loader can load conventional ELF binaries just fine, the way the
ext4 driver can mount ext3 or ext2. Unfortunately, my attempts to build
bimfmt_fdpic on i386 and arm64 and mips and powerpc and so on to TRY that hit
the same "kconfig and the #ifdefs really dowanna allow this" nonsense.

I note that qemu's application emulation handles conventional ELF, static PIE,
and fdpic pretty much interchangeably. THEY didn't see the need to have two
redundant loaders doing the same thing, with only one understanding some fairly
minor extensions. But the linux-kernel community seems to segregate out nommu
support and quarrantine it, for no obvious reason. (And then make the nommu
stuff build ONLY in one mode and the with-mmu stuff build ONLY in the other mode
and NEVER THE TWAIN SHALL MEET, again for no obvious reason.)

> Using this setup is going to become much easier now that uClibc has native
> support for generating a relevant library and ld.so for noMMU linux (certainly
> for m68k, arm and riscv at least) - as of version 1.0.45.

I haven't followed buildroot's uclibc fork since uclibc.org died, I switched to
musl instead.

>> (The earlier binflt format is an a.out variant with 4 base pointers. FDPIC is
>> the ELF version of the same idea. Since a.out went bye-bye binflt is obsolete,
>> but not everybody's moved off it yet because so many nommu people are still
>> using 2.6 or even earlier, and also using gcc 3.x or 2.x toolchains.)
> 
> Flat format (binfmt_flat) is in no way related to a.out. It is not derived from
> it and shares nothing with it. A.out being removed from the kernel in no way affects
> flat format. It doesn't magically make it obsolete. It isn't going anywhere.

*shrug* I'll take your word for it.

Back when I tried to make it work circa
https://landley.net/notes-2014.html#07-12-2014 the binflt plumbing was so
bit-rotted that A) there was no official repository for it, B) it was
implemented as a weird post-processing step where you ran an "elf2flt" binary
but it could not actually digest a normal ELF file, instead you made a SPECIAL
elf file with various compiler flags, which the postprocessing tool then
converted to a flat file.

(This is another variant of "embedded devs get something to work and then keep
using the old version FOREVER". I could download 10 year old binflt toolchains
that produced binaries, but nobody seemed to have built a NEW one in years.)

So I shoehorned basic elf2flt support into my build system:

https://github.com/landley/aboriginal/commit/50d139530dd4

And then I asked Yoshinori Sato what version _he'd_ used when adding h8300
support to Linux (since that was nommu) and switched to his version, which he'd
fixed a lot of stuff in and which worked with newer compiler versions and had
commits less than a year old in the tree:

https://github.com/landley/aboriginal/commit/247ee063028f

And around that time I emailed various people who had once been interested in
this, and they started a new binflt tree (merging the various trees I'd found)
and switched buildroot over to use it. But I didn't track it much beyond that
because instead Jeff paid Rich Felker to add fdpic support to musl and we
switched j-core over to that instead.

What little I know about binflt comes from reading the code and from Jeff Dionne
trying to explain it to me back in 2014 and 2015, and mostly he was concerned
that you had to use older versions of gcc (despite sato-san's upgrades) because
current versions of gcc could do some pointer range thing that broke design
assumptions in elf2flt, which apparently weren't fixable because information had
already been discarded when the .o file was generated, so the thing consuming
that output didn't have all the information it needed to link. (You'd have to
ask Jeff, I never quite wrapped my head around what the specific issue was and
it's a decade ago now. My impression was you'd _mostly_ get lucky and it would
usually work with modern gcc, but you rolled the dice with every code change...)

> I don't see how this is related to versions of kernel or gcc or toolchains either.
> Flat format works on every kernel up to todays v6.7. The conversion tool works
> with the latest gcc and binutils (gcc-13.2 and bintuils-2.41 as of today)

Again, I'll take your word for it.

> and many
> versions going back for the best part of 20 years. Sure that elf2flt tool has been
> forked a lot it has a spotty history of getting updated. But, hey, as of today it
> looks pretty up to date across most architectures.

Um, yes. Check your back email for a message from me September 4, 2015, title
"elf2flt upstream repo". You were cc'd on it.

I created a website that tried to act as a uclinux.org replacement for the
social aspect of "where devs can learn about nommu development for linux, and
come together to talk about it":

https://web.archive.org/web/20160425072007/http://nommu.org/

Alas, I was busy with a half-dozen other things and handed it off to "official
web people" when the company got some, and I wasn't supposed to do "community
outreach" anymore because we had specific staff for that now. The discussion on
the mailing list about elf2flt petered out, but it DID result in people setting
up a new repo and merging some forks and buildroot switching over to the new one.

Sadly, archive.org only spidered the TOP page, not the actual months:

https://web.archive.org/web/20160416102445/http://lists.nommu.org/pipermail/nommu/

I can probably fish it out of my old mbox files if anybody cares. But the point
is, elf2flt got maintained again (not by me, I didn't have the expertise), and I
switched over to fdpic anyway.

Alas reliance of fdpic means that trying to do cortex-m in mkroot, I was stuck
using https://github.com/mickael-guene/fdpic_manifest and waiting for it to go
upstream, which is _why_ I was doing the static pie toolchain for that
architecture until such time as gcc+binutils+linux caught up with the group. (I
think I saw arm fdpic support go into the kernel. Rich said that musl should
work, last I asked him. I haven't checked upstream gcc or binutils recently,
mostly because Rich won't update musl-cross-make and redoing my
https://github.com/landley/toybox/blob/master/scripts/mcm-buildall.sh to build
without it is nontrivial. For one thing I don't think
https://github.com/richfelker/musl-cross-make/blob/master/patches/binutils-2.33.1/0001-j2.diff
ever went upstream either...)

>> UCLINUX is a long-dead distro. Linaro died in the dot-com crash and its founder
>> Jeff Dionne moved to Japan for his next gig and never came back. On the way out
>> he handed uclinux off to someone else, who didn't do a lot of work maintaining
>> it. Most of the actual support went "upstream" into various packages (linux and
>> busybox and gcc and so on) before the handoff, so you didn't NEED uclinux anymore.
> 
> Why do you keep claiming that "UCLINUX" (why all caps?) is a distro?

Because it was. Full of obsolete crap, which had its last release in 2014.

> That is just not the case. uClinux has been used as an umbrella term for
> patches, tools, packages relating to running Linux on a CPU with no MMU.

Which is why so many people are convinced nommu linux is dead because
http://uclinux.org/ was long-dead before it went down. Because of exactly that
confusion.

> There was a build package called uclinux-dist that you might consider a distro.
> But it has always been cleanly named as "uclinux-dist".

Cleanly. Uh-huh:

https://web.archive.org/web/20150219205915/http://www.uclinux.org/

https://web.archive.org/web/20181202164812/http://www.uclinux.org/description/

Here are two entries from cut and pasted from
https://web.archive.org/web/20181204132729/http://www.uclinux.org/status/

12 April 2000
The release of uClinux version 2.0.38.1pre7 announced today. Download the .diff NOW!

10 January 2000
The latest release of uClinux, 2.0.38.1pre5, is announced today. The uClinux CD
contains the popular uClinux System Builder Kit. This new version supports a
broad spectrum of chip sets. Order the CD!

> For a long time that
> was the goto starting point for anyone wanting to use Linux with no-MMU.
> The collection of patches to the toolchains, kernel, libraries and application
> packages was a pretty high mountain to climb to get started in those early
> days (late 90's and early 2000's). But through the work of a _lot_ of people
> much of that change has made its way into relevant packages across the board
> (from gcc to kernel to creation of uClibc, etc).

It was introduced to me as a distro at the first ELC I attended in 2006. (I
attended as the new busybox maintainer, there were two "uclinux developers" who
wanted to say hi, we spoke for about 30 seconds. One of them wore a t-shirt with
"uclinux" on it?)

As I said, I never used it. I just heard about it. You're the first person to
tell me it _didn't_ consider itself a distro.

> But lets face it once no-MMU support was integrated into mainline linux as off
> v2.5.46 it is really now just "Linux". The no-MMU support outgrew that trade marked
> term. But the name has stubbornly stuck around.

My successor as busybox maintainer was already ripping _uclinux_ #defines out of
that codebase a dozen years ago.

https://git.busybox.net/busybox/commit/?id=153fcaa6c171

>> The real nail in the coffin is the inheritor of uclinux never migrated it off
>> CVS, and then the disk holding the CVS archive crashed with no backup. He came
>> out with a couple more releases after that by monkey-patching the last release's
>> filesystem, but the writing was on the wall and it rolled to a stop.
> 
> No, the public facing CVS was never the master sources for the uclinux-dist.
> The public facing CVS was only ever a copy of the tar ball releases.

All I know is I emailed Michael Durrant in February 2015 to see if I could get a
copy of the repo (preparatory for doing my triage of what was actually IN
uclinux for Jeff) and he replied:

> Are you are talking about the dead cvs.uclinux.org (CVS) machine or the
> the uClibc website? (http://www.uclibc.org/)
>
> If so .. that machine is very very dead .. nothing from the harddrive was
> salvageable. I will look and see if we have a CD or DVD backup but it is very
> very doubtful.
>
> I did replace the http://mailman.uclinux.org machine a few years ago after it
> had a catastrophic fail.

I sent a follow-up email but didn't get a further reply.

Thank you for clarifying that the stuff I was interested in was apparently never
tracked under source control in the first place.

> That work was slowing down due to fact that it just wasn't really
> needed any more. There are way more popular build systems (eg build-root)
> for building complete firmware images from scratch.

Agreed, yes.

>> I did a triage of its last release (from 2014) as part of my toybox roadmap:
> 
> No, the last release was in 2016, see it archived at:
> https://sourceforge.net/projects/uclinux/files/uClinux%20Stable/

They did another one after my triage then. I hadn't noticed.

In early 2015 I went to
https://web.archive.org/web/20150219205915/http://www.uclinux.org/ which had a
cvs archive link on the left (which was dead, hence the email exchange), a page
on bflt in the same nav bar (first link on that page went to the dead CVS
archive, the beyondlogic page was 404, and vapier's stuff was still there but
several years old, I tracked down the newer forks later), and then the "http
download" link at the end of the list led to
https://web.archive.org/web/20150206052300/http://www.uclinux.org/pub/uClinux/
the newest date in which was 2004.

The resulting first impression was "this project is VERY DEAD". And then my
email exchange with the contact info link got back "cvs archive died with no
backup" and no reply to a follow-up email.

> But that is all kind of archeological now, relegated to history.

Agreed.

> Regards
> Greg

Rob

