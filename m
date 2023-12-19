Return-Path: <linux-kernel+bounces-5295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF51C818919
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3BA1C23E62
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4519A1B27A;
	Tue, 19 Dec 2023 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwTcTN3D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5B11A594
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-77f3790a187so294642785a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 05:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702994206; x=1703599006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xf7vDZZkz6GwHHPc1HLYA9mBh21UgE7DpY4iGTWyAz0=;
        b=cwTcTN3D6Y+IEM2OqV/TxVdImZpQMDK1Sn3yMYSwKY3+YQfSmYvqsc/3i7Je3Xlxpq
         v7nS4TK03+jYJ7n3bD/1Q1v4eW3oNsJ1ESZTxtYmlp9TMyXnewTb/PlCAUYrL/47l0Jd
         PL8CSqmGY22lg/Uf/A0x0ImRuh2MYU4vs+j0eu6YVNo27XFyNEyJ5RIW+YyN5wp61Jh4
         nI9auUgV2IyAtJ+a6/TjWzYOIA2JuqB4amaeGFsppN4+KDnSQ3gl0UHcgzPAF1z7qcaW
         veLp/JP7Y7osL4ukzpBJaD9STAwdLLXfHlhDUYM9bZNNcE2NbVKR/zEWsVXBlOy0hDSu
         369w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702994206; x=1703599006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xf7vDZZkz6GwHHPc1HLYA9mBh21UgE7DpY4iGTWyAz0=;
        b=b7ByzVqDIWityDz/ALZepMThLAEdH7h8MB3x9fVS5LJt4ztdgMAHn4cZfWP3K6U49q
         eJ1b+3JxcA6K0MwIepIUZT9a8UmGoHqFS5fBlHHAOKcTDLRXKjdxpSAJUIvjORiu3Nbi
         eLD1k5doCzGUWaDndPNbcDqKEkRELhmkwWzVeyWCG2BU610/b3ChdgBxq1CvMht2IwD9
         DoDA0qb/xXpV4USxmGc22l/PXT6+9IBzM8YCj7jiRW9PAwX1LyHvyKJ8Xj7TGCPnUvni
         q2CfH81gKhFHPCIAusswnCg184k40ApQp2EEjvWs46FWeHUcGQM5xIE1to6wY/m8r6+p
         BZlA==
X-Gm-Message-State: AOJu0YwFWzlvLFvdJhLU+O8e61orJg/lb2tq3c/b1dhmRud8YrP+5jPK
	IBNn8X7E4InGWS8mn2jxEBFYEGxLvaVIvulI2WtV3w==
X-Google-Smtp-Source: AGHT+IFw6K+fSd7zNP5OAxlt5t49hDrYdU0WXtNNHDZXZBZ8B6avCWXoXQDOZ5AXqAPY1WKVaGYcD4jL72/J/7w57No=
X-Received: by 2002:a05:6214:242e:b0:67f:28b7:a685 with SMTP id
 gy14-20020a056214242e00b0067f28b7a685mr7666971qvb.7.1702994205632; Tue, 19
 Dec 2023 05:56:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f66a3005fa578223@google.com> <20231213104950.1587730-1-glider@google.com>
 <ZXofF2lXuIUvKi/c@rh> <ZXopGGh/YqNIdtMJ@dread.disaster.area>
 <CAG_fn=UukAf5sPrwqQtmL7-_dyUs3neBpa75JAaeACUzXsHwOA@mail.gmail.com>
 <ZXt2BklghFSmDbhg@dread.disaster.area> <CAG_fn=VqSEyt+vwZ7viviiJtipPPYyzEhkuDjdnmRcW-UXZkYg@mail.gmail.com>
 <ZXzMU9DQ7JqeYwvb@dread.disaster.area> <CANp29Y5XPoH3tdZ_ZEJK3oUZnFf5awQn1w3E95YJFJ-wPxQQ4g@mail.gmail.com>
 <ZYGPZUerlEaCVRq8@dread.disaster.area>
In-Reply-To: <ZYGPZUerlEaCVRq8@dread.disaster.area>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 19 Dec 2023 14:56:04 +0100
Message-ID: <CAG_fn=XaT0pt0j-=BoOKFU9nh+R7NY3qgwtk5sTS3afDunnmwA@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in __crc32c_le_base (3)
To: Dave Chinner <david@fromorbit.com>
Cc: Aleksandr Nogikh <nogikh@google.com>, Dave Chinner <dchinner@redhat.com>, 
	syzbot+a6d6b8fffa294705dbd8@syzkaller.appspotmail.com, hch@lst.de, 
	davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 1:41=E2=80=AFPM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Mon, Dec 18, 2023 at 11:22:40AM +0100, Aleksandr Nogikh wrote:
> > Hi Dave,
> >
> > > KMSAN has been used for quite a long time with syzbot, however,
> > > and it's supposed to find these problems, too. Yet it's only been
> > > finding this for 6 months?
> >
> > As Alex already mentioned, there were big fs fuzzing improvements in
> > 2022, and that's exactly when we started seeing "KMSAN: uninit-value
> > in __crc32c_le_base" (I've just checked crash history). Before that
> > moment the code was likely just not exercised on syzbot.
>
> Can you tell us what these "big fuzzing improvements" were? I mean,
> you're trying to fuzz our code and we've been working on rejecting
> fuzzing for the last 15 years, so if you're doing something novel it
> would help us work out how to defeat it quickly and effciently.
>
> > On Fri, Dec 15, 2023 at 10:59=E2=80=AFPM 'Dave Chinner' via syzkaller-b=
ugs
> > <syzkaller-bugs@googlegroups.com> wrote:
> > >
> > > On Fri, Dec 15, 2023 at 03:41:49PM +0100, Alexander Potapenko wrote:
> > > >
> > > > You are right, syzbot used to mount XFS way before 2022.
> > > > On the other hand, last fall there were some major changes to the w=
ay
> > > > syz_mount_image() works, so I am attributing the newly detected bug=
s
> > > > to those changes.
> > >
> > > Oh, so that's when syzbot first turned on XFS V5 format testing?
> > >
> > > Or was that done in April, when this issue was first reported?
> > >
> > > > Unfortunately we don't have much insight into reasons behind syzkal=
ler
> > > > being able to trigger one bug or another: once a bug is found for t=
he
> > > > first time, the likelihood to trigger it again increases, but findi=
ng
> > > > it initially might be tricky.
> > > >
> > > > I don't understand much how trivial is the repro at
> > > > https://gist.github.com/xrivendell7/c7bb6ddde87a892818ed1ce206a429c=
4,
> > >
> > > I just looked at it - all it does is create a new file. It's
> > > effectively "mount; touch", which is exactly what I said earlier
> > > in the thread should reproduce this issue every single time.
> > >
> > > > but overall we are not drilling deep enough into XFS.
> > > > https://storage.googleapis.com/syzbot-assets/8547e3dd1cca/ci-upstre=
am-kmsan-gce-c7402612.html
> > > > (ouch, 230Mb!) shows very limited coverage.
> > >
> > > *sigh*
> > >
> > > Did you think to look at the coverage results to check why the
> > > numbers for XFS, ext4 and btrfs are all at 1%?
> >
> > Hmmm, thanks for pointing it out!
> >
> > Our ci-upstream-kmsan-gce instance is configured in such a way that
> > the fuzzer program is quite restricted in what it can do. Apparently,
> > it also lacks capabilities to do mounts, so we get almost no coverage
> > in fs/*/**. I'll check whether the lack of permissions to mount() was
> > intended.
> >
> > On the other hand, the ci-upstream-kmsan-gce-386 instance does not
> > have such restrictions at all and we do see fs/ coverage there:
> > https://storage.googleapis.com/syzbot-assets/609dc759f08b/ci-upstream-k=
msan-gce-386-0e389834.html
> >
> > It's still quite low for fs/xfs, which is explainable -- we almost
> > immediately hit "KMSAN: uninit-value in __crc32c_le_base". For the
> > same reason, it's also somewhat lower than could be elsewhere as well
> > -- we spend too much time restarting VMs after crashes. Once the fix
> > patch reaches the fuzzed kernel tree, ci-upstream-kmsan-gce-386 should
> > be back to normal.
> >
> > If we want to see how deep syzbot can go into the fs/ code in general,
> > it's better to look at the KASAN instance coverage:
> > https://storage.googleapis.com/syzbot-assets/12b7d6ca74e6/ci-upstream-k=
asan-gce-root-0e389834.html
> >  (*)
> >
> > Here e.g. fs/ext4 is already 63% and fs/xfs is 16%.
>
> Actually, that XFS number is an excellent result. I don't think we
> can do much better than that.
>
> I know, that's not the response you expected.
>
> Everyone knows that higher coverage numbers are better because it
> means we've tested more code, right?
>
> Wrong.
>
> When it comes to fuzzing based attacks, the earlier the bad data is
> detected and rejected the better the result. We should see lower
> coverage of the code the better the detection and rejection
> algorithms get.  i.e. The detection code should be extensively
> covered, but the rest of the code should have very little coverage
> because of how quickly the filesystem reacts to fatal object
> corruption.
>
> And the evidence for this in the XFS coverage results?
>
> Take a look at fs/xfs/libxfs/xfs_inode_buf.c. Every single line of
> the disk inode format verifiers has been covered (i.e. every
> possible corruption case we can detect has been exercised).
>
> That's good.
>
> However, there is zero coverage of core formatting functions like
> xfs_inode_to_disk() that indicate no inodes have been successfully
> modified and written back to disk.
>
> That's *even better*.
>
> Think about that for a minute.
>
> The coverage data is telling us that we've read lots of corrupt
> inodes and rejected them, but the testing has made almost no
> successful inode modifications that have been written back to stable
> storage. That's because of widespread corruption in the images
> resulting in a fatal corruption being detected before modofications
> are being made or are being aborted before they are pushed back to
> the corrupt image.
>
> The same pattern appears for most other major on-disk subsystems.
> They either have not been exercised at all (e.g. extent btree code) or
> the only code in the subsystem that has significant coverage is the
> object lookup code and the format verifiers the lookup code runs.
>
> This is an excellent result because it proves that XFS is detecting
> the majority of corrupt structures in it's initial object
> search iteration paths. Corruption is not getting past the
> first read from disk and so no code other than the search/lookup
> code and the verifiers is getting run.
>
> Put simply: we are not letting corrupt structures get into code
> paths where they can be mis-interpretted and do damage.
>
> From my perspective as an experienced filesystem developer, this is
> exactly the sort of coverage pattern I would like to see from -all
> filesystems- when they are fed nothing but extensively corrupted
> filesystems the way syzbot does.
>
> The basic truth is that if filesystems are good at corruption
> detection and rejection, they should have very low code coverage
> numbers from syzbot testing.
>
> -Dave.

It is quite insightful that if we throw random garbage at a
well-written API then low coverage indicates that the checks are doing
their job.

But this is not how syzkaller works.
Our goal is to produce as many well-formed inputs as possible to
exercise most of the code under test.
Then, a small step sideways from every well-formed input might trigger
a bug here or there.
It might as well be rejected early by the elaborate input checks (in
which case we won't be finding any new bugs), but anyway we should be
covering bigger parts of the code by just running valid inputs.

For certain subsystems with very limited APIs it is fairly easy to
generate all the possible valid inputs by simply combining syscalls.
In most cases we are still limited by the combinatorial explosion of
the search space though.
But if there are implicit dependencies that the fuzzer cannot deduce
from the descriptions, it will blindly flip bits in known inputs in
the hope to produce a new valid input - mostly in vain.
So seeing little coverage for a subsystem usually means that for some
reason we are just barely scratching the API surface.

Compare this with fuzzing a C compiler.
Doing something like `head /dev/random > 1.c && gcc -c 1.c` in a loop
may eventually trigger interesting bugs in the compiler backend, but
most of the time the programs will be rejected by the lexer which is
smart enough to not accept garbage.
Is the lexer written correctly? Yes, as long as it does not crash on
these random inputs.
Does low coverage indicate that the whole compiler is written
correctly? Not necessarily. Tools like csmith will easily get past the
lexer checks by generating structurally valid programs that might be
broken from the semantic point of view.

For some parts of the kernel syzkaller acts like csmith, because its
knowledge of the data layout is just enough to generate valid inputs.
For file systems, however, we might be lagging behind.
The last year changes in the fuzzer that we mentioned earlier improved
the initial seeding of file system images and added some basic
mutations, but there is still a lot to do.

Hope this helps.

