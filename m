Return-Path: <linux-kernel+bounces-6101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 659D48194A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891851C24A82
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143B640BF5;
	Tue, 19 Dec 2023 23:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="MtreWpKm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D16C40BFE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6d9f4eed60eso3967378a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1703028843; x=1703633643; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QJQt7cbCUi1tOuMx0ASymYCoclSLcgR/2qgTejmDPTU=;
        b=MtreWpKmZ8jrOi+oP08vul+QoiiZiplTZ30lav2bTTchrxD7P0Cq6iSv5zLU15lywH
         hwm+Qk9suMl1/23d45yuh2jbn/jNWz5sgv8JTv8q3puTqQvzOs3FMAt+yZXfVSp4Heyy
         vviSKwPHyH5dAUgTFc16OcRQBW4wNqUDkkvdnZQSAS2t4nse/sZOiynRbd67rrM59Pgc
         7dxiJaXT2HRwKz8+CFIZRFGMoNCS8kcLELwi4M+Oic+5l4Mh8F/3dXkxw7ai9BghxY6h
         4JVE2NotcGQL97FK8D4bQkgBoPnGeSfWrUqR/7MZvTxj2NZNCXeFiCZe2oyAx38u0K6E
         aqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703028843; x=1703633643;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJQt7cbCUi1tOuMx0ASymYCoclSLcgR/2qgTejmDPTU=;
        b=e8nCkFrCufO3DQudkTBxo+XyJzGYuiHmauRJmMoCtSfSsleXrsOs+zEgr5SHKSAr5W
         +wDGD0/F1NqnTBoXwDHE690dP5zgWO5GC36hYgL4UiXBLBrnew0Gg4nkuxojQlUrPJpF
         Z5OidcIDh0gRkrTXCsOogoIYlRCs0+ptHqAREmTWEgMBNzKmqelJD7JMpBQA/SH/XX9O
         TmsblbAvzhQ8gQuwB52JOzqkroKfqc/A68l7oIvsEygsh4x5iGXoW9YduM5WcdG6Uil0
         5485KzN9xZpn5J3pRvYWe70puNWemcKArv3jmrHJ0dbdKWQJQX6J5KAyCgv8G/f2KTbm
         JfRw==
X-Gm-Message-State: AOJu0YxkcwkmPjA6GKRtgaUCmlVuepGSnkCsA6sM6593SIsLlRSHkIZa
	BTCJDQyhoS1fIfG2BClJSFVSLqL5KQ8jQl+im0U=
X-Google-Smtp-Source: AGHT+IGUSBbzpL6dCwMmMDy4BA/oZq0bz76xCWnpQDCC4RjQFFWKr1IXur8/+3hkhIwIpSmVt3cMug==
X-Received: by 2002:a05:6830:1084:b0:6d8:5323:2516 with SMTP id y4-20020a056830108400b006d853232516mr17340495oto.19.1703028842847;
        Tue, 19 Dec 2023 15:34:02 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id q64-20020a634343000000b005cdb499acd0sm1929873pga.42.2023.12.19.15.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 15:34:01 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rFjb4-00AdXV-0a;
	Wed, 20 Dec 2023 10:33:58 +1100
Date: Wed, 20 Dec 2023 10:33:58 +1100
From: Dave Chinner <david@fromorbit.com>
To: Alexander Potapenko <glider@google.com>
Cc: Aleksandr Nogikh <nogikh@google.com>,
	Dave Chinner <dchinner@redhat.com>,
	syzbot+a6d6b8fffa294705dbd8@syzkaller.appspotmail.com, hch@lst.de,
	davem@davemloft.net, herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, linux-xfs@vger.kernel.org
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in __crc32c_le_base (3)
Message-ID: <ZYIoZuGKsVaOt2QI@dread.disaster.area>
References: <20231213104950.1587730-1-glider@google.com>
 <ZXofF2lXuIUvKi/c@rh>
 <ZXopGGh/YqNIdtMJ@dread.disaster.area>
 <CAG_fn=UukAf5sPrwqQtmL7-_dyUs3neBpa75JAaeACUzXsHwOA@mail.gmail.com>
 <ZXt2BklghFSmDbhg@dread.disaster.area>
 <CAG_fn=VqSEyt+vwZ7viviiJtipPPYyzEhkuDjdnmRcW-UXZkYg@mail.gmail.com>
 <ZXzMU9DQ7JqeYwvb@dread.disaster.area>
 <CANp29Y5XPoH3tdZ_ZEJK3oUZnFf5awQn1w3E95YJFJ-wPxQQ4g@mail.gmail.com>
 <ZYGPZUerlEaCVRq8@dread.disaster.area>
 <CAG_fn=XaT0pt0j-=BoOKFU9nh+R7NY3qgwtk5sTS3afDunnmwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=XaT0pt0j-=BoOKFU9nh+R7NY3qgwtk5sTS3afDunnmwA@mail.gmail.com>

On Tue, Dec 19, 2023 at 02:56:04PM +0100, Alexander Potapenko wrote:
> On Tue, Dec 19, 2023 at 1:41 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Mon, Dec 18, 2023 at 11:22:40AM +0100, Aleksandr Nogikh wrote:
> > > Hi Dave,
> > >
> > > > KMSAN has been used for quite a long time with syzbot, however,
> > > > and it's supposed to find these problems, too. Yet it's only been
> > > > finding this for 6 months?
> > >
> > > As Alex already mentioned, there were big fs fuzzing improvements in
> > > 2022, and that's exactly when we started seeing "KMSAN: uninit-value
> > > in __crc32c_le_base" (I've just checked crash history). Before that
> > > moment the code was likely just not exercised on syzbot.
> >
> > Can you tell us what these "big fuzzing improvements" were? I mean,
> > you're trying to fuzz our code and we've been working on rejecting
> > fuzzing for the last 15 years, so if you're doing something novel it
> > would help us work out how to defeat it quickly and effciently.
> >
> > > On Fri, Dec 15, 2023 at 10:59 PM 'Dave Chinner' via syzkaller-bugs
> > > <syzkaller-bugs@googlegroups.com> wrote:
> > > >
> > > > On Fri, Dec 15, 2023 at 03:41:49PM +0100, Alexander Potapenko wrote:
> > > > >
> > > > > You are right, syzbot used to mount XFS way before 2022.
> > > > > On the other hand, last fall there were some major changes to the way
> > > > > syz_mount_image() works, so I am attributing the newly detected bugs
> > > > > to those changes.
> > > >
> > > > Oh, so that's when syzbot first turned on XFS V5 format testing?
> > > >
> > > > Or was that done in April, when this issue was first reported?
> > > >
> > > > > Unfortunately we don't have much insight into reasons behind syzkaller
> > > > > being able to trigger one bug or another: once a bug is found for the
> > > > > first time, the likelihood to trigger it again increases, but finding
> > > > > it initially might be tricky.
> > > > >
> > > > > I don't understand much how trivial is the repro at
> > > > > https://gist.github.com/xrivendell7/c7bb6ddde87a892818ed1ce206a429c4,
> > > >
> > > > I just looked at it - all it does is create a new file. It's
> > > > effectively "mount; touch", which is exactly what I said earlier
> > > > in the thread should reproduce this issue every single time.
> > > >
> > > > > but overall we are not drilling deep enough into XFS.
> > > > > https://storage.googleapis.com/syzbot-assets/8547e3dd1cca/ci-upstream-kmsan-gce-c7402612.html
> > > > > (ouch, 230Mb!) shows very limited coverage.
> > > >
> > > > *sigh*
> > > >
> > > > Did you think to look at the coverage results to check why the
> > > > numbers for XFS, ext4 and btrfs are all at 1%?
> > >
> > > Hmmm, thanks for pointing it out!
> > >
> > > Our ci-upstream-kmsan-gce instance is configured in such a way that
> > > the fuzzer program is quite restricted in what it can do. Apparently,
> > > it also lacks capabilities to do mounts, so we get almost no coverage
> > > in fs/*/**. I'll check whether the lack of permissions to mount() was
> > > intended.
> > >
> > > On the other hand, the ci-upstream-kmsan-gce-386 instance does not
> > > have such restrictions at all and we do see fs/ coverage there:
> > > https://storage.googleapis.com/syzbot-assets/609dc759f08b/ci-upstream-kmsan-gce-386-0e389834.html
> > >
> > > It's still quite low for fs/xfs, which is explainable -- we almost
> > > immediately hit "KMSAN: uninit-value in __crc32c_le_base". For the
> > > same reason, it's also somewhat lower than could be elsewhere as well
> > > -- we spend too much time restarting VMs after crashes. Once the fix
> > > patch reaches the fuzzed kernel tree, ci-upstream-kmsan-gce-386 should
> > > be back to normal.
> > >
> > > If we want to see how deep syzbot can go into the fs/ code in general,
> > > it's better to look at the KASAN instance coverage:
> > > https://storage.googleapis.com/syzbot-assets/12b7d6ca74e6/ci-upstream-kasan-gce-root-0e389834.html
> > >  (*)
> > >
> > > Here e.g. fs/ext4 is already 63% and fs/xfs is 16%.
> >
> > Actually, that XFS number is an excellent result. I don't think we
> > can do much better than that.
> >
> > I know, that's not the response you expected.
> >
> > Everyone knows that higher coverage numbers are better because it
> > means we've tested more code, right?
> >
> > Wrong.
> >
> > When it comes to fuzzing based attacks, the earlier the bad data is
> > detected and rejected the better the result. We should see lower
> > coverage of the code the better the detection and rejection
> > algorithms get.  i.e. The detection code should be extensively
> > covered, but the rest of the code should have very little coverage
> > because of how quickly the filesystem reacts to fatal object
> > corruption.
> >
> > And the evidence for this in the XFS coverage results?
> >
> > Take a look at fs/xfs/libxfs/xfs_inode_buf.c. Every single line of
> > the disk inode format verifiers has been covered (i.e. every
> > possible corruption case we can detect has been exercised).
> >
> > That's good.
> >
> > However, there is zero coverage of core formatting functions like
> > xfs_inode_to_disk() that indicate no inodes have been successfully
> > modified and written back to disk.
> >
> > That's *even better*.
> >
> > Think about that for a minute.
> >
> > The coverage data is telling us that we've read lots of corrupt
> > inodes and rejected them, but the testing has made almost no
> > successful inode modifications that have been written back to stable
> > storage. That's because of widespread corruption in the images
> > resulting in a fatal corruption being detected before modofications
> > are being made or are being aborted before they are pushed back to
> > the corrupt image.
> >
> > The same pattern appears for most other major on-disk subsystems.
> > They either have not been exercised at all (e.g. extent btree code) or
> > the only code in the subsystem that has significant coverage is the
> > object lookup code and the format verifiers the lookup code runs.
> >
> > This is an excellent result because it proves that XFS is detecting
> > the majority of corrupt structures in it's initial object
> > search iteration paths. Corruption is not getting past the
> > first read from disk and so no code other than the search/lookup
> > code and the verifiers is getting run.
> >
> > Put simply: we are not letting corrupt structures get into code
> > paths where they can be mis-interpretted and do damage.
> >
> > From my perspective as an experienced filesystem developer, this is
> > exactly the sort of coverage pattern I would like to see from -all
> > filesystems- when they are fed nothing but extensively corrupted
> > filesystems the way syzbot does.
> >
> > The basic truth is that if filesystems are good at corruption
> > detection and rejection, they should have very low code coverage
> > numbers from syzbot testing.
> >
> > -Dave.
> 
> It is quite insightful that if we throw random garbage at a
> well-written API then low coverage indicates that the checks are doing
> their job.
> 
> But this is not how syzkaller works.

In general, that statement is true. But we're talking about the
filesystem fuzzing that syzkaller does, and that's a completely
different beast.

> Our goal is to produce as many well-formed inputs as possible to
> exercise most of the code under test.
> Then, a small step sideways from every well-formed input might trigger
> a bug here or there.
> It might as well be rejected early by the elaborate input checks (in
> which case we won't be finding any new bugs), but anyway we should be
> covering bigger parts of the code by just running valid inputs.

Yes, you're talking about the syscall exercising interface. That
works just fine for finding issues when the input comes from only
one direction - the syscall interface.

The issue is that filesystem testing has a second set of inputs that
are being perturbed: the filesystem image being operated on by the
syscalls.

It's a simple fact that filesystem operations cannot be fully
exercised if the filesystem image is corrupt. Corruption will be
detected and the syscall operation will be aborted without having
performed the desired operation.

So while the goal might be to gain extensive subsystem code coverage
from the syscall interface, this is being defeated by the additional
peturbation of low level data objects (the corrupt filesystem)
causing premature termination of the syscall explorations.

> For certain subsystems with very limited APIs it is fairly easy to
> generate all the possible valid inputs by simply combining syscalls.
> In most cases we are still limited by the combinatorial explosion of
> the search space though.
> But if there are implicit dependencies that the fuzzer cannot deduce
> from the descriptions, it will blindly flip bits in known inputs in
> the hope to produce a new valid input - mostly in vain.
> So seeing little coverage for a subsystem usually means that for some
> reason we are just barely scratching the API surface.

Yes, random bit perturbation fuzzing is a really basic "million
monkeys bashing on typewriters" discovery technique. But when I read
the coverage results, there are very few syscall entry points into
the filesystem, and they all end up in the metadata read verifiers
that point to extensive corruption detection occuring.

> Compare this with fuzzing a C compiler.
> Doing something like `head /dev/random > 1.c && gcc -c 1.c` in a loop
> may eventually trigger interesting bugs in the compiler backend, but
> most of the time the programs will be rejected by the lexer which is
> smart enough to not accept garbage.
> Is the lexer written correctly? Yes, as long as it does not crash on
> these random inputs.
> Does low coverage indicate that the whole compiler is written
> correctly? Not necessarily. Tools like csmith will easily get past the
> lexer checks by generating structurally valid programs that might be
> broken from the semantic point of view.

This is exactly equivalent of syzkaller feeding corrupt filesystem
images to the filesystems.

IOWs, syzkaller needs to stop using corrupt filesystem images if it
wants to actually extensively cover filesystem internal
functionality for filesystems with high rates of corruption
rejection.

> For some parts of the kernel syzkaller acts like csmith, because its
> knowledge of the data layout is just enough to generate valid inputs.
> For file systems, however, we might be lagging behind.

I suspect the right word is "obsolete", not "lagging behind". That's
what I'm trying to find out....

> The last year changes in the fuzzer that we mentioned earlier improved
> the initial seeding of file system images and added some basic
> mutations, but there is still a lot to do.

This really doesn't t tell us anything we didn't already know.

What syzkaller -appears- to be doing with filesystems doesn't look
much different to state of the art from 2005 where syscall
operations were exercised against simulated disk failures and media
corruptions instead of corrupted images. That quickly moved on to
using image-based corruptions rather than simulated runtime failure
because it was a lot simpler to implement and had much faster test
cycles.

e.g. Go look for "IRON File Systems" related papers from the
University of Wisconsin where these techniques were first
demonstrated. These were some of the foundational papers
on filesystem error detection and handling that influenced the
current XFS v5 format design and verifiation architecture.

IOws, I'm trying to understand whether syzbot is actually doing
something novel I've never seen before with it's filesystem images
that might cause such coverage patterns. AFAICT syzkaller is not
doing anything novel, but I can't be certain if the responses I get
to requests for specific details are generalities devoid of any
detail....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

