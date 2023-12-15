Return-Path: <linux-kernel+bounces-1725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D42815335
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF67284C66
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1797118EBA;
	Fri, 15 Dec 2023 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="QRhC6pog"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C218018EB0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d347b4d676so10182225ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1702677591; x=1703282391; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RPlOtOHOIsAyV9crgoI7qizDCGbIF4qWA//nbOzHpq8=;
        b=QRhC6pogtg3G0ycZ+WEuE3jEF2UgEhfoc7IVozM15gvJl1c9lepHBJmHyp+G755ACu
         5dl/m/BrDjTVyjSvUM1JTQENC3uWow3th5QYY/u09H9ULVlc03GB8ipSjSdyCQU89FkS
         f05NMPc9HsAvUpyULYiYRA0awEPXNaZDFDk7hQeEb4yUZNBI3vMwx2uKF0n9lx5K6BhL
         OOHODsMnWZmjxidydGBkqF586JwoYkRcL5TXeS1UJ9EgOvKNvQRXs2iIjKDKpRGb5J9q
         ueri1uCJrM4SMcN8ypHq/XrQimzj6gRTJlcLT6ozlrUzjO0SXv6WnFHP/rh21XDJeq8u
         VG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702677591; x=1703282391;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPlOtOHOIsAyV9crgoI7qizDCGbIF4qWA//nbOzHpq8=;
        b=gaLdVU2dfSej3agMLGq8r6MnA7w7Hdt2ZyPlWesByqk7WOMCDLhp1M15L3vlzarZXe
         A1ZXSZ6ldJzK2XtYJqSks6h5Ok/JlAGW6URbeAiPo8Qwl86H7CG57pJV7H01v92RHeo/
         QQMM2ZVrz2C76OmmlfklxFHUh4SjHDsmSAq47TbEsqKgttFfQ2rDYJApUHGS43eYrKlH
         pGGAFs11PWEAXxZhH9HSl7pE39g7YoEsuwE38IoATdCAqS4+jHYzxcgeeZFBnE6hkXnA
         uCgk0M03DtM2pTChLQDi7wm8oj4Sb/tZfLgSa27lRQL2Qqa+FyRzKRkREt6sj6b1uIkI
         iewA==
X-Gm-Message-State: AOJu0YwonPwxbyLHZk5pCOajiW6Mz7pr7Pq4F9UkhKlMBS0rUTGSLMsc
	qW83+nDEJcA+gN+aTinP4V2+fA==
X-Google-Smtp-Source: AGHT+IEc0uNQ0JpiFP2jdvA/Gch1OhXdp/ZnAbicLJNYB3hH+hChbtBKv/t1QY3BK74j4cvuSOe0iw==
X-Received: by 2002:a17:902:7ec1:b0:1d0:7d0b:555c with SMTP id p1-20020a1709027ec100b001d07d0b555cmr10670613plb.10.1702677591078;
        Fri, 15 Dec 2023 13:59:51 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id c10-20020a170903234a00b001d043588122sm14703619plh.142.2023.12.15.13.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 13:59:50 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rEGDj-008p3r-2R;
	Sat, 16 Dec 2023 08:59:47 +1100
Date: Sat, 16 Dec 2023 08:59:47 +1100
From: Dave Chinner <david@fromorbit.com>
To: Alexander Potapenko <glider@google.com>
Cc: Dave Chinner <dchinner@redhat.com>,
	syzbot+a6d6b8fffa294705dbd8@syzkaller.appspotmail.com, hch@lst.de,
	davem@davemloft.net, herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, linux-xfs@vger.kernel.org
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in __crc32c_le_base (3)
Message-ID: <ZXzMU9DQ7JqeYwvb@dread.disaster.area>
References: <000000000000f66a3005fa578223@google.com>
 <20231213104950.1587730-1-glider@google.com>
 <ZXofF2lXuIUvKi/c@rh>
 <ZXopGGh/YqNIdtMJ@dread.disaster.area>
 <CAG_fn=UukAf5sPrwqQtmL7-_dyUs3neBpa75JAaeACUzXsHwOA@mail.gmail.com>
 <ZXt2BklghFSmDbhg@dread.disaster.area>
 <CAG_fn=VqSEyt+vwZ7viviiJtipPPYyzEhkuDjdnmRcW-UXZkYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=VqSEyt+vwZ7viviiJtipPPYyzEhkuDjdnmRcW-UXZkYg@mail.gmail.com>

On Fri, Dec 15, 2023 at 03:41:49PM +0100, Alexander Potapenko wrote:
> On Thu, Dec 14, 2023 at 10:39 PM 'Dave Chinner' via syzkaller-bugs
> <syzkaller-bugs@googlegroups.com> wrote:
> >
> > On Thu, Dec 14, 2023 at 03:55:00PM +0100, Alexander Potapenko wrote:
> > > On Wed, Dec 13, 2023 at 10:58 PM 'Dave Chinner' via syzkaller-bugs
> > > <syzkaller-bugs@googlegroups.com> wrote:
> > > >
> > > > On Thu, Dec 14, 2023 at 08:16:07AM +1100, Dave Chinner wrote:
> > > > > [cc linux-xfs@vger.kernel.org because that's where all questions
> > > > > about XFS stuff should be directed, not to random individual
> > > > > developers. ]
> > > > >
> > > > > On Wed, Dec 13, 2023 at 11:49:50AM +0100, Alexander Potapenko wrote:
> > > > > > Hi Christoph, Dave,
> > > > > >
> > > > > > The repro provided by Xingwei indeed works.
> > > >
> > > > Can you please test the patch below?
> > >
> > > It fixed the problem for me, feel free to add:
> > >
> > > Tested-by: Alexander Potapenko <glider@google.com>
> >
> > Thanks.
> >
> > > As for the time needed to detect the bug, note that kmemcheck was
> > > never used together with syzkaller, so it couldn't have the chance to
> > > find it.
> > >
> > > KMSAN found this bug in April
> > > (https://syzkaller.appspot.com/bug?extid=a6d6b8fffa294705dbd8),
> >
> > KMSAN has been used for quite a long time with syzbot, however,
> > and it's supposed to find these problems, too. Yet it's only been
> > finding this for 6 months?
> >
> > > only
> > > half a year after we started mounting XFS images on syzbot.
> >
> > Really? Where did you get that from?  syzbot has been exercising XFS
> > filesystems since 2017 - the bug reports to the XFS list go back at
> > least that far.
> 
> You are right, syzbot used to mount XFS way before 2022.
> On the other hand, last fall there were some major changes to the way
> syz_mount_image() works, so I am attributing the newly detected bugs
> to those changes.

Oh, so that's when syzbot first turned on XFS V5 format testing?

Or was that done in April, when this issue was first reported?

> Unfortunately we don't have much insight into reasons behind syzkaller
> being able to trigger one bug or another: once a bug is found for the
> first time, the likelihood to trigger it again increases, but finding
> it initially might be tricky.
> 
> I don't understand much how trivial is the repro at
> https://gist.github.com/xrivendell7/c7bb6ddde87a892818ed1ce206a429c4,

I just looked at it - all it does is create a new file. It's
effectively "mount; touch", which is exactly what I said earlier
in the thread should reproduce this issue every single time.

> but overall we are not drilling deep enough into XFS.
> https://storage.googleapis.com/syzbot-assets/8547e3dd1cca/ci-upstream-kmsan-gce-c7402612.html
> (ouch, 230Mb!) shows very limited coverage.

*sigh*

Did you think to look at the coverage results to check why the
numbers for XFS, ext4 and btrfs are all at 1%? Why didn't the low
number make you dig a bit deeper to see if the number was real or
whether there was a test execution problem during measurement?

I just spent a minute doing exactly that, and the answer is
pretty obvious. Both ext4 and XFS had a mount attempts
rejected at mount option parsing, and btrfs rejected a device scan
ioctl. That's it. Nothing else was exercised in those three
filesystems.

Put simply: the filesystems *weren't tested during coverage
measurement*.

If you are going to do coverage testing, please measure coverage
over *thousands* of different tests performed on a single filesystem
type. It needs to be thousands, because syzbot tests are so shallow
and narrow that actually covering any significant amount of
filesystem code is quite difficult....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

