Return-Path: <linux-kernel+bounces-5180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9B78187AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3EA1F23EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C7218629;
	Tue, 19 Dec 2023 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="bKVXCS4L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0773118059
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso3394141a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1702989673; x=1703594473; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jse3lCK79aXXY7rKkifQLf73K6m1hAauen4iGzJYwOo=;
        b=bKVXCS4L0JWJesw9aXkA5G5G9azAxvKL11GFLNL0sVmvaWNiAK0bZMvykVrd1x0sMJ
         cfmb1gSLbsyoHlOmStSZuHWWUf4BeBORrV0kwjbmeAiiDkhzG41AYd9mIcTX7KhU7AJ8
         rXmtgKkR6ZkHtGIg4rjwY1sKYBEa1kJX6XZnESAxaSBLwRXw75qtQmqbDv4wMN3pILLK
         Xewz2yMxt60EPuZgdI/G1tYJXnseM6SbYWEbpu2uKp3GncCLIlUYrtZTMM1ggqcfGv62
         ElwGJm3S+sdpdXVWt6p1yE7/EiuNmnKul1onmfnGwsQLtNY9erUKj6AHZKG2bA35saa5
         W4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702989673; x=1703594473;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jse3lCK79aXXY7rKkifQLf73K6m1hAauen4iGzJYwOo=;
        b=YxlHro8gClaZjwNleZawIUdzjyty5tnDDkziGdjONqMJPSpn6FEDjmJoxrUqvMlWXN
         NL/sCeZYDMJ/I+ydHLnPQAurhbka3MhsSEAV313g9Hxzs+sxgEwK1u9KVByi7j6WgpHi
         lHSbpJ4jtDbG+d9AvwjYSvp0ibONrZgB4O2fVH3QyC47rpZ5siggWHyX7G7N3tRPsAjd
         OGuuSVOkzVNk8IoZByyJDUoo36guhmyofrLTW8JSWPZ450mWs1fLJI7jb0W1f1xXIUlk
         iheoIuXBUA6iGgcoSMn2rZgB2l2TD+yDTLlPGSqBkH7XpC00omIcorTyxAePvYRmCt3R
         H2xg==
X-Gm-Message-State: AOJu0YydwKOkk8LeT6t8ISYB0RVmPPj2Tp/o5+ZlQODYzHcRsLPXrIVo
	ICAky5v8u16ePZphBqzHYCD7Fg==
X-Google-Smtp-Source: AGHT+IEPLCO86rZfqisZYKNGDry6iN+zDRCMVlxtQWLkdJrxo7qFtm5U61BClIDbvuTHod8s8r5Skw==
X-Received: by 2002:a05:6a21:19c:b0:194:b60b:aa70 with SMTP id le28-20020a056a21019c00b00194b60baa70mr441841pzb.56.1702989673219;
        Tue, 19 Dec 2023 04:41:13 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id b2-20020a17090a6e0200b0028ad2c3bd08sm1429356pjk.33.2023.12.19.04.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 04:41:12 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rFZPJ-00AQml-1i;
	Tue, 19 Dec 2023 23:41:09 +1100
Date: Tue, 19 Dec 2023 23:41:09 +1100
From: Dave Chinner <david@fromorbit.com>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: Alexander Potapenko <glider@google.com>,
	Dave Chinner <dchinner@redhat.com>,
	syzbot+a6d6b8fffa294705dbd8@syzkaller.appspotmail.com, hch@lst.de,
	davem@davemloft.net, herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, linux-xfs@vger.kernel.org
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in __crc32c_le_base (3)
Message-ID: <ZYGPZUerlEaCVRq8@dread.disaster.area>
References: <000000000000f66a3005fa578223@google.com>
 <20231213104950.1587730-1-glider@google.com>
 <ZXofF2lXuIUvKi/c@rh>
 <ZXopGGh/YqNIdtMJ@dread.disaster.area>
 <CAG_fn=UukAf5sPrwqQtmL7-_dyUs3neBpa75JAaeACUzXsHwOA@mail.gmail.com>
 <ZXt2BklghFSmDbhg@dread.disaster.area>
 <CAG_fn=VqSEyt+vwZ7viviiJtipPPYyzEhkuDjdnmRcW-UXZkYg@mail.gmail.com>
 <ZXzMU9DQ7JqeYwvb@dread.disaster.area>
 <CANp29Y5XPoH3tdZ_ZEJK3oUZnFf5awQn1w3E95YJFJ-wPxQQ4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y5XPoH3tdZ_ZEJK3oUZnFf5awQn1w3E95YJFJ-wPxQQ4g@mail.gmail.com>

On Mon, Dec 18, 2023 at 11:22:40AM +0100, Aleksandr Nogikh wrote:
> Hi Dave,
> 
> > KMSAN has been used for quite a long time with syzbot, however,
> > and it's supposed to find these problems, too. Yet it's only been
> > finding this for 6 months?
> 
> As Alex already mentioned, there were big fs fuzzing improvements in
> 2022, and that's exactly when we started seeing "KMSAN: uninit-value
> in __crc32c_le_base" (I've just checked crash history). Before that
> moment the code was likely just not exercised on syzbot.

Can you tell us what these "big fuzzing improvements" were? I mean,
you're trying to fuzz our code and we've been working on rejecting
fuzzing for the last 15 years, so if you're doing something novel it
would help us work out how to defeat it quickly and effciently.

> On Fri, Dec 15, 2023 at 10:59 PM 'Dave Chinner' via syzkaller-bugs
> <syzkaller-bugs@googlegroups.com> wrote:
> >
> > On Fri, Dec 15, 2023 at 03:41:49PM +0100, Alexander Potapenko wrote:
> > >
> > > You are right, syzbot used to mount XFS way before 2022.
> > > On the other hand, last fall there were some major changes to the way
> > > syz_mount_image() works, so I am attributing the newly detected bugs
> > > to those changes.
> >
> > Oh, so that's when syzbot first turned on XFS V5 format testing?
> >
> > Or was that done in April, when this issue was first reported?
> >
> > > Unfortunately we don't have much insight into reasons behind syzkaller
> > > being able to trigger one bug or another: once a bug is found for the
> > > first time, the likelihood to trigger it again increases, but finding
> > > it initially might be tricky.
> > >
> > > I don't understand much how trivial is the repro at
> > > https://gist.github.com/xrivendell7/c7bb6ddde87a892818ed1ce206a429c4,
> >
> > I just looked at it - all it does is create a new file. It's
> > effectively "mount; touch", which is exactly what I said earlier
> > in the thread should reproduce this issue every single time.
> >
> > > but overall we are not drilling deep enough into XFS.
> > > https://storage.googleapis.com/syzbot-assets/8547e3dd1cca/ci-upstream-kmsan-gce-c7402612.html
> > > (ouch, 230Mb!) shows very limited coverage.
> >
> > *sigh*
> >
> > Did you think to look at the coverage results to check why the
> > numbers for XFS, ext4 and btrfs are all at 1%?
> 
> Hmmm, thanks for pointing it out!
> 
> Our ci-upstream-kmsan-gce instance is configured in such a way that
> the fuzzer program is quite restricted in what it can do. Apparently,
> it also lacks capabilities to do mounts, so we get almost no coverage
> in fs/*/**. I'll check whether the lack of permissions to mount() was
> intended.
> 
> On the other hand, the ci-upstream-kmsan-gce-386 instance does not
> have such restrictions at all and we do see fs/ coverage there:
> https://storage.googleapis.com/syzbot-assets/609dc759f08b/ci-upstream-kmsan-gce-386-0e389834.html
> 
> It's still quite low for fs/xfs, which is explainable -- we almost
> immediately hit "KMSAN: uninit-value in __crc32c_le_base". For the
> same reason, it's also somewhat lower than could be elsewhere as well
> -- we spend too much time restarting VMs after crashes. Once the fix
> patch reaches the fuzzed kernel tree, ci-upstream-kmsan-gce-386 should
> be back to normal.
> 
> If we want to see how deep syzbot can go into the fs/ code in general,
> it's better to look at the KASAN instance coverage:
> https://storage.googleapis.com/syzbot-assets/12b7d6ca74e6/ci-upstream-kasan-gce-root-0e389834.html
>  (*)
> 
> Here e.g. fs/ext4 is already 63% and fs/xfs is 16%.

Actually, that XFS number is an excellent result. I don't think we
can do much better than that.

I know, that's not the response you expected.

Everyone knows that higher coverage numbers are better because it
means we've tested more code, right?

Wrong.

When it comes to fuzzing based attacks, the earlier the bad data is
detected and rejected the better the result. We should see lower
coverage of the code the better the detection and rejection
algorithms get.  i.e. The detection code should be extensively
covered, but the rest of the code should have very little coverage
because of how quickly the filesystem reacts to fatal object
corruption.

And the evidence for this in the XFS coverage results?

Take a look at fs/xfs/libxfs/xfs_inode_buf.c. Every single line of
the disk inode format verifiers has been covered (i.e. every
possible corruption case we can detect has been exercised).

That's good.

However, there is zero coverage of core formatting functions like
xfs_inode_to_disk() that indicate no inodes have been successfully
modified and written back to disk.

That's *even better*.

Think about that for a minute.

The coverage data is telling us that we've read lots of corrupt
inodes and rejected them, but the testing has made almost no
successful inode modifications that have been written back to stable
storage. That's because of widespread corruption in the images
resulting in a fatal corruption being detected before modofications
are being made or are being aborted before they are pushed back to
the corrupt image.

The same pattern appears for most other major on-disk subsystems.
They either have not been exercised at all (e.g. extent btree code) or
the only code in the subsystem that has significant coverage is the
object lookup code and the format verifiers the lookup code runs.

This is an excellent result because it proves that XFS is detecting
the majority of corrupt structures in it's initial object
search iteration paths. Corruption is not getting past the
first read from disk and so no code other than the search/lookup
code and the verifiers is getting run.

Put simply: we are not letting corrupt structures get into code
paths where they can be mis-interpretted and do damage.

From my perspective as an experienced filesystem developer, this is
exactly the sort of coverage pattern I would like to see from -all
filesystems- when they are fed nothing but extensively corrupted
filesystems the way syzbot does.

The basic truth is that if filesystems are good at corruption
detection and rejection, they should have very low code coverage
numbers from syzbot testing.

-Dave.

-- 
Dave Chinner
david@fromorbit.com

